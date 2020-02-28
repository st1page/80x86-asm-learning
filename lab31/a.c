#include <stdio.h>
#define N 10
#pragma pack(1)
typedef struct _student {
	char name[10];
	char a, b, c, avg;
}student;
student s[N] = {
	{"ZhangSan",100,85,80},
	{"LiSi",80,100,70},
	{"mxtest",100,100,100},
	{"mntest",0,0,0},
	{"TempValue",80,90,95},
	{"TempValue",80,90,95},
	{"TempValue",80,90,95},
	{"TempValue",80,90,95},
	{"TempValue",80,90,95},
	{"stonepage",85,85,100},
};
student* poin;
char in_name[11];
int overflag = 0; 
void calc_avg() {
	__asm {
		mov ebx, offset s
		mov ecx, N
		avg_iter :
			xor ah, ah
			mov al, 10[ebx]
			shl ax, 1

			add al, 11[ebx]
			adc ah, 0
			shl ax, 1

			add al, 12[ebx]
			adc ah, 0

			mov dl, 7
			div dl

			mov 13[ebx], al
			add bx, 14
		loop avg_iter
	}
}
void get_poin(){
	__asm {
		mov ecx, N;
		mov ebx, offset s
		find_iter :
			mov esi, ebx
			mov edi, offset in_name
			push ebx
			push ecx
			mov ecx, 10
			strcmp_iter :
				mov dl, [esi]
				cmp dl, [edi]
				jnz next
				inc esi
				inc edi
			loop strcmp_iter
			jmp found
		next :
			pop ecx
			pop ebx
			add ebx, 14
		loop find_iter
		jmp not_found
	found :
		mov poin, ebx
			pop ecx
			pop ebx
			not_found :
	}
}
int get_in_name() {
	int i;
	for (in_name[i = 0] = getchar(); i < 10; in_name[++i] = getchar()) {
		if (in_name[i] == '\n') break;
	}
	if (!i) return 0;
	if (in_name[i] != '\n') {
		puts("too long!");
		while (getchar() != '\n');
		return 0;
	}
	if (i == 1 && in_name[0] == 'q') {
		overflag = 1;
		return 0;
	}
	for (; i < 10; i++) in_name[i] = 0;
	return 1;
}

int main() {
	calc_avg();
	while (1) {
		poin = NULL;
		while (poin == NULL) {
			do {
				if (overflag) {
					puts("exit!");
					return 0;
				}
				puts("Please input the name of the student:");
			} while (!get_in_name());
			get_poin();
		}
		if (poin != NULL) {
			puts("found!");
			printf("the level of %s is ", in_name);
			int x = poin->avg ? poin->avg / 10 : 0;
			switch (x) {
			case 10:
			case 9: puts("A"); break;
			case 8: puts("B"); break;
			case 7: puts("C"); break;
			case 6: puts("D"); break;
			default: puts("E"); break;
			}
		}
	}
}
