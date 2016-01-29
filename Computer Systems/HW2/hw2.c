#include <stdio.h>
#define IN   1  /* inside a word */
#define OUT  0  /* outside a word */

/* count lines, words, and characters in input */
/* to run, try:    gcc THIS_FILE.c ; cat ANY_FILE | ./a.out */

void SolutionA1();
void SolutionB1();
void SolutionC1();

void SolutionA2();
void SolutionB2();
void SolutionC2();

main()
{
	printf("Problem 1:\n");
    SolutionA1();
	SolutionB1();
	SolutionC1();
	
	printf("\nProblem 2:\n");
	SolutionA2();
	SolutionB2();
	SolutionC2();
	
    return 0;
}

void SolutionA1() {
	int c, nl, nw, nc, state;
    state = OUT;
    nl = nw = nc = 0;
	char x1[100] = "The quick brown fox jumped over the lazy dog.";
	
    while (x1[nc] != '\0') {
        if (x1[nc] == '\n')
            ++nl;
        if (x1[nc] == ' ' || x1[nc] == '\n' || x1[nc] == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
		++nc;
    }
    printf("Solution A: %d %d %d\n", nl, nw, nc);
}

void SolutionB1() {
	int c, nl, nw, nc, state;
    state = OUT;
    nl = nw = nc = 0;
	char x1[100] = "The quick brown fox jumped over the lazy dog.";
	char *x1Ptr = x1;
	
    while (*(x1Ptr + nc) != '\0') {
        if (*(x1Ptr + nc) == '\n')
            ++nl;
        if (*(x1Ptr + nc) == ' ' || *(x1Ptr + nc) == '\n' || *(x1Ptr + nc) == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
		++nc;
    }
    printf("Solution B: %d %d %d\n", nl, nw, nc);
}

void SolutionC1() {
	int c, nl, nw, nc, state;
    state = OUT;
    nl = nw = nc = 0;
	char x1[100] = "The quick brown fox jumped over the lazy dog.";
	char *x1Ptr = x1;
	
    while (*x1Ptr != '\0') {
        if (*x1Ptr == '\n')
            ++nl;
        if (*x1Ptr == ' ' || *x1Ptr == '\n' || *x1Ptr == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
		++nc;
		*x1Ptr++;
    }
    printf("Solution C: %d %d %d\n", nl, nw, nc);
}

void SolutionA2() {
	int count, i, nwhite, nother;
    int ndigit[10];
    char x1[100] = "The 25 quick brown foxes jumped over the 27 lazy dogs 17 times.";
    nwhite = nother = count = 0;
    
    for (i = 0; i < 10; ++i) {
        ndigit[i] = 0;
	}
	
    while (x1[count] != '\0') {
        if (x1[count] >= '0' && x1[count] <= '9') {
            ++ndigit[x1[count]-'0'];
		}
        else if (x1[count] == ' ' || x1[count] == '\n' || x1[count] == '\t') {
            ++nwhite;
		}
        else {
            ++nother;
        }
        count++;
    }
	
    printf("Solution A: digits =");
	
    for (i = 0; i < 10; ++i) {
        printf(" %d", ndigit[i]);
	}
	
    printf(", white space = %d, other = %d\n", nwhite, nother);
}

void SolutionB2() {
    int count, i, nwhite, nother;
    int ndigit[10];
    int *ndigitPtr = ndigit;
    char x1[100] = "The 25 quick brown foxes jumped over the 27 lazy dogs 17 times.";
    char *x1Ptr = x1;
    nwhite = nother = count = 0;
    
    for (i = 0; i < 10; ++i) {
        *(ndigitPtr + i) = 0;
	}
	
    while (*(x1Ptr + count) != '\0') {
        if (*(x1Ptr + count) >= '0' && *(x1Ptr + count) <= '9') {
            ++*(ndigit + (*(x1Ptr + count) - '0'));
		}
        else if (*(x1Ptr + count) == ' ' || *(x1Ptr + count) == '\n' || *(x1Ptr + count) == '\t') {
            ++nwhite;
		}
        else {
            ++nother;
        }
        count++;
    }
	
    printf("Solution A: digits =");
	
    for (i = 0; i < 10; ++i) {
        printf(" %d", *(ndigitPtr + i));
	}
	
    printf(", white space = %d, other = %d\n", nwhite, nother);
}

void SolutionC2() {
    int count, i, nwhite, nother;
    int ndigit[10];
    int *ndigitPtr = ndigit;
    char x1[100] = "The 25 quick brown foxes jumped over the 27 lazy dogs 17 times.";
    char *x1Ptr = x1;
    nwhite = nother = count = 0;
    
    for (i = 0; i < 10; ++i) {
        *ndigitPtr++ = 0;
	}
	
    ndigitPtr = ndigit;
    
    while (*x1Ptr != '\0') {
        if (*x1Ptr >= '0' && *x1Ptr <= '9') {
            ++*(ndigitPtr + (*x1Ptr - '0'));
		}
        else if (*x1Ptr == ' ' || *x1Ptr == '\n' || *x1Ptr == '\t') {
            ++nwhite;
		}
        else {
            ++nother;
        }
        *x1Ptr++;
    }
	
    printf("Solution A: digits =");
	
    ndigitPtr = ndigit;
    for (i = 0; i < 10; ++i) {
        printf(" %d", *ndigitPtr++);
	}
	
    printf(", white space = %d, other = %d\n", nwhite, nother);
}