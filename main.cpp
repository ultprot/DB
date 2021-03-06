#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <string>
#pragma warning(disable:4996)
using namespace std;

char* random_string(int size) {
	char *strChar = new char[size];
	for (int i = 0; i < size; i++) {
		strChar[i] = 97 + rand() % 25;
	}
	strChar[size] = 0;
	return strChar;
}
char* random_string_number(int size) {
	char *strChar = new char[size];
	for (int i = 0; i < size; i++) {
		strChar[i] = 48 + rand() % 10;
	}
	strChar[size] = 0;
	return strChar;
}

void main() {
	FILE *openPointer;
	openPointer = fopen("output.txt", "w+");
	char out_str[100] = { 0, };
	//fclose(openPointer);

	//입력예제
	int k = 0;
	//fprintf(openPointer, "어어 ", out_str);
	//랜덤 : rand()사용

	int cin_int[8];
	cout << "<<Random Instance Maker>>\n";
	cout << "유저 수: "; cin >> cin_int[0];
	cout << "차량 수: "; cin >> cin_int[1];
	cout << "구청 수: "; cin >> cin_int[2];
	cout << "주차장 수: "; cin >> cin_int[3];
	cout << "관리기록 수 :"; cin >> cin_int[4];
	cout << "최대 자리 수 : "; cin >> cin_int[5];
	cout << "리뷰 개수 : "; cin >> cin_int[6];
	cout << "사용이력 수 : "; cin >> cin_int[7];

	
	//소유자 수 + 소유자 번호 지정
	int soyu = 0;
	int *soyu_num = new int[cin_int[0]];

	int sayong = 0;
	int *sayong_num = new int[cin_int[0]];


	//Block1, 유저 생성 (생성과 동시에 관리자 소유자 사용자 지정)
	for (int i = 0; i < cin_int[0]; i++) {
		fprintf(openPointer, "Insert INTO 유저\n", out_str);
		fprintf(openPointer, "values (%d,'%s','%s','%s','%d-%d-%d')\n", i + 1, random_string(5+rand() % 10), random_string(5+rand() % 10), random_string_number(11), 1950 + rand() % 60, 1 + rand() % 12, 1 + rand() % 28, out_str);

		if ((rand() % 2) == 0) {//50%확률로 사용자
			fprintf(openPointer, "Insert INTO 사용자\n", out_str);
			fprintf(openPointer, "values (%d,%d.%d,%d.%d)\n", i + 1, rand()%10000, rand() % 1000, rand()%10000, rand() % 1000, out_str);

			sayong_num[sayong] = i+1;
			sayong++;
		}
		if ((rand() % 2) == 0) {//50%확률로 소유자
			fprintf(openPointer, "Insert INTO 소유자\n", out_str);
			fprintf(openPointer, "values (%d,%s)\n", i + 1, random_string_number(15), out_str);

			soyu_num[soyu] = i+1;
			soyu++;
		}
		if ((rand() % 2) == 0) {//50%확률로 관리자
			fprintf(openPointer, "Insert INTO 관리자\n", out_str);
			fprintf(openPointer, "values (%d,'%d:%d:%d','%d-%d-%d','%d:%d:%d','%d-%d-%d')\n", i + 1, rand() % 24, rand() % 60, rand() % 60,  1950 + rand() % 60, 1 + rand() % 12, 1 + rand() % 28, rand() % 24, rand() % 60, rand() % 60, 1950 + rand() % 60, 1 + rand() % 12, 1 + rand() % 28,  out_str);
		}

		fprintf(openPointer, "\n", out_str);
	}
	fclose(openPointer);
	cout << "유저 생성 완료" << endl;



	openPointer = fopen("output.txt", "a");
	//Block2, 구청 생성
	for (int i = 0; i < cin_int[2]; i++) {
		fprintf(openPointer, "Insert INTO 구청\n", out_str);
		fprintf(openPointer, "values (%d,'%s')\n\n", i + 1, random_string(rand() % 20), out_str);
	}
	fclose(openPointer);
	cout << "구청 생성 완료" << endl;


	openPointer = fopen("output.txt", "a");
	//Block3, 주차장 생성
	int full = 0; int randint = 0;
	for (int i = 0; i < cin_int[3]; i++) {
		fprintf(openPointer, "Insert INTO 주차장\n", out_str);
		full = 10 + rand() % 1000;
		fprintf(openPointer, "values (%d,%d,%d,'%s',%d.%d,%d,'%d:%d:%d','%d:%d:%d',%d,%d,NULL, %d.%d)\n", i + 1, rand() % 100, rand() % 3, random_string(rand() % 40), rand() % 10000, rand() % 1000, rand() % 1000, rand() % 24, rand() % 60, rand() % 60, rand() % 24, rand() % 60, rand() % 60, full, rand()% full, soyu_num[rand()%soyu], rand() % 10000, rand() % 1000, out_str);
	
		//Block3.2 자리생성
		randint = rand() % cin_int[5];
		for (int j = 0; j < randint; j++) {
			fprintf(openPointer, "Insert INTO 자리\n", out_str);
			fprintf(openPointer, "values (%d,%d,%d,%d,%d,%d)\n", j+1, rand()%2, rand()%200,  rand()%3, i + 1, rand() % 500, out_str);
		}
		fprintf(openPointer, "\n", out_str);
	}
	fclose(openPointer);
	cout << "주차장 생성 완료" << endl;



	openPointer = fopen("output.txt", "a");
	//Block4, 차량 생성
	for (int i = 0; i < cin_int[1]; i++) {
		fprintf(openPointer, "Insert INTO 차량\n", out_str);
		fprintf(openPointer, "values (%d,'%s', %d)\n", i + 1, random_string(rand() % 20), sayong_num[rand()%sayong], out_str);
	}
	fprintf(openPointer, "\n", out_str);
	fclose(openPointer);
	cout << "차량 생성 완료" << endl;


	openPointer = fopen("output.txt", "a");
	//Block5, 관리기록 생성
	for (int i = 0; i < cin_int[4]; i++) {
		fprintf(openPointer, "Insert INTO 관리기록\n", out_str);
		fprintf(openPointer, "values ('%d-%d-%d',%d,%d)\n",  1950 + rand() % 60, 1 + rand() % 12, 1 + rand() % 28, rand() % cin_int[2]+1, rand() % cin_int[3]+1, out_str);
	}
	fprintf(openPointer, "\n", out_str);
	fclose(openPointer);
	cout << "관리기록 생성 완료" << endl;


	openPointer = fopen("output.txt", "a");
	//Block6, 리뷰 생성
	for (int i = 0; i < cin_int[6]; i++) {
		fprintf(openPointer, "Insert INTO 리뷰\n", out_str);
		fprintf(openPointer, "values (%d,'%s',%d,%d,%d)\n", i + 1, random_string(rand() % 100), rand() % 5, rand() % cin_int[3]+1, sayong_num[rand() % sayong],out_str);
	}
	fprintf(openPointer, "\n", out_str);
	fclose(openPointer);
	cout << "리뷰 생성 완료" << endl;


	openPointer = fopen("output.txt", "a");
	//Block7, 사용이력 생성
	for (int i = 0; i < cin_int[7]; i++) {
		fprintf(openPointer, "Insert INTO 사용이력\n", out_str);
		fprintf(openPointer, "values ('%d-%d-%d %d:%d:%d','%d-%d-%d %d:%d:%d',%d,%d,%d,%d)\n", 1950 + rand() % 60, 1 + rand() % 12, 1 + rand() % 28, 1950 + rand() % 60, 1 + rand() % 12, 1 + rand() % 28, rand() % 24, rand() % 60, rand() % 60,   rand() % 24, rand() % 60, rand() % 60, rand() % 100000, rand() % 100000, rand() % cin_int[3]+1, sayong_num[rand() % sayong], out_str);
	}
	fprintf(openPointer, "\n", out_str);
	fclose(openPointer);
	cout << "사용이력 생성 완료" << endl << endl << endl;

	
	cout << "output query => output.txt" << endl;

	
}
