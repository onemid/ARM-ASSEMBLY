all:
	gcc -std=c99 -msse4 hw9.c -o hw9.exe
	gcc -std=c99 -msse4 hw9simd.c -o hw9simd.exe
	gcc -std=c99 -msse4 -mavx2 hw9simdavx.c -o hw9simdavx.exe

without_avx:
	gcc -std=c99 -msse4 hw9.c -o hw9.exe
	gcc -std=c99 -msse4 hw9simd.c -o hw9simd.exe