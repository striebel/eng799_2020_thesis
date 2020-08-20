// Author: Jacob Striebel
//
// Date: 1 Aug 2020
//
// Split a factored corpus that contains the base factors, tags1, and tags2
// into three corpora, containing: (1) only the base factors, (2) the base factors and tags1, and
// (3) the base factors and tags2.
//
#include<stdio.h>

#define BUFSIZE 1024

int main(int argc, char **argv) {

  int   state;
  FILE *in,          *out0,         *out1,         *out2;
  int   in_i,         out0_i,        out1_i,        out2_i;
  int   in_n;
  char  buf[BUFSIZE], buf0[BUFSIZE], buf1[BUFSIZE], buf2[BUFSIZE];

  if (2 != argc) {
    fprintf(stderr, "Error in corpus split -- #1 -- argument error\n"); 
    return 1;
  }

  snprintf(buf, BUFSIZE, "data/%s.factors.de", argv[1]);
  in = fopen(buf, "r");

  snprintf(buf, BUFSIZE, "data/%s.factors_ctrl.de", argv[1]);
  out0 = fopen(buf, "w");

  snprintf(buf, BUFSIZE, "data/%s.factors_udts.de", argv[1]);
  out1 = fopen(buf, "w");

  snprintf(buf, BUFSIZE, "data/%s.factors_stts.de", argv[1]);
  out2 = fopen(buf, "w");

  if (in == NULL || out0 == NULL || out1 == NULL || out2 == NULL) {
    fprintf(stdout, "Error in corpus split -- #2 -- fopen() failed\n");
    return 2;
  }

  state = 0;  // state
              //   0 : reading  bpe_segment
              //   1 : reading  bpe_label
              //   2 : reading  lemma
              //   3 : reading  UD POS tag
              //   4 : reading  STTS POS tag
  while ((in_n = fread(buf, sizeof(char), BUFSIZE, in)) > 0) {

    out0_i = out1_i = out2_i = 0;
    for (in_i = 0; in_i < in_n; in_i++) {

      if (buf[in_i] == '|') {
        state++;
      }
      else if (buf[in_i] == ' ' || buf[in_i] == '\n') {
        if ((buf[in_i] == ' '  && state != 4) ||         // If a space is encountered, the last state
                                                         // should have been read tag2 (state==4).
            (buf[in_i] == '\n' && state != 0)) {         // If a newline is encountered, the last
                                                         // char should have been a space.
          fprintf(stderr, "Error in corpus split -- #3 -- input format error\n");
          return 3;
        }
        else {
          state = 0;
        }
      }

      if (0 <= state && state <= 1) {
        buf0[out0_i++] = buf[in_i];
      }
      if ((0 <= state && state <= 1) || state == 3) {
        buf1[out1_i++] = buf[in_i];
      }
      if ((0 <= state && state <= 1) || state == 4) {
        buf2[out2_i++] = buf[in_i];
      }
    }
    fwrite(buf0, sizeof(char), out0_i, out0);
    fwrite(buf1, sizeof(char), out1_i, out1);
    fwrite(buf2, sizeof(char), out2_i, out2);
  }
  fclose(in);
  fclose(out0);
  fclose(out1);
  fclose(out2);

  return 0;
}
