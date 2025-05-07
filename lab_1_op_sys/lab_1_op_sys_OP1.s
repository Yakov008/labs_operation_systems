	.file	"lab_1_op_sys.cpp" ; Исходный файл
	.text ; Начало секции кода
Ltext0:
	.def	___tcf_0;	.scl	3;	.type	32;	.endef
___tcf_0:
LFB1941:
	.file 1 "c:/mingw/lib/gcc/mingw32/6.3.0/include/c++/iostream"
	.loc 1 74 0
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	.loc 1 74 0
	movl	$__ZStL8__ioinit, %ecx
	call	__ZNSt8ios_base4InitD1Ev
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE1941:
	.globl	__Z9factoriali ; Глобальное имя функции (декорированное)
	.def	__Z9factoriali;	.scl	2;	.type	32;	.endef ;	.scl	2;	.type	32;	.endef
__Z9factoriali:
LFB1504:
	.file 2 "lab_1_op_sys.cpp"
	.loc 2 6 0 ; Ссылка на строку в исходнике
	.cfi_startproc
	pushl	%edi ; Сохраняем регистры
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subl	$16, %esp ; Выделяем место в стеке
	.cfi_def_cfa_offset 32
	movl	32(%esp), %ebx ; Загружаем аргумент n в ebx
	.loc 2 7 0
	movl	$1, %eax ; Инициализация результата (1)
	movl	$0, %edx
	cmpl	$1, %ebx ; Сравнение n <= 1
	jle	L3 ; Если да, переход к возврату
	.loc 2 8 0 ; Рекурсивный вызов
	leal	-1(%ebx), %eax ; n-1
	movl	%eax, (%esp)
	call	__Z9factoriali ; Рекурсивный вызов factorial(n-1)
	; Умножение результата на n (64-битное)
	movl	%ebx, %edi
	sarl	$31, %edi ; Знаковое расширение
	movl	%edi, %esi
	imull	%eax, %esi
	imull	%ebx, %edx
	leal	(%esi,%edx), %ecx
	mull	%ebx
	addl	%ecx, %edx
L3: ; Возврат результата
	.loc 2 9 0
	addl	$16, %esp ; Восстанавливаем стек
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE1504:
	.section .rdata,"dr"
LC0:
	.ascii "Could not map view of file: \0"
	.text
	.globl	__Z13child_processPv@4
	.def	__Z13child_processPv@4;	.scl	2;	.type	32;	.endef
__Z13child_processPv@4:
LFB1505:
	.loc 2 12 0
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subl	$32, %esp
	.cfi_def_cfa_offset 48
	movl	48(%esp), %esi ; Получаем параметр (HANDLE)
	.loc 2 15 0 ; MapViewOfFile
	movl	$8, 16(%esp) ; Размер = 8 байт
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	$983071, 4(%esp) ; Доступ = FILE_MAP_ALL_ACCESS
	movl	%esi, (%esp)
	call	_MapViewOfFile@20
	.cfi_def_cfa_offset 28
	subl	$20, %esp
	.cfi_def_cfa_offset 48
	.loc 2 16 0
	testl	%eax, %eax ; Проверка на NULL
	je	L14 ; Обработка ошибки
	movl	%eax, %ebx ; Сохраняем указатель
	.loc 2 22 0 ; Вычисление факториала(5)
	movl	$5, (%esp)
	call	__Z9factoriali
	movl	%eax, (%ebx) ; Сохраняем результат
	movl	%edx, 4(%ebx)
	.loc 2 24 0 ; UnmapViewOfFile
	movl	%ebx, (%esp)
	call	_UnmapViewOfFile@4
	.cfi_def_cfa_offset 44
	subl	$4, %esp
	.cfi_def_cfa_offset 48
	.loc 2 25 0
	movl	$0, %eax ; Возврат 0 (успех)
L7: ; Выход из функции
	.loc 2 26 0
	addl	$32, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret	$4
L14: ; Обработка ошибки
	.cfi_restore_state
	.loc 2 17 0
	call	_GetLastError@0
	movl	%eax, %ebx ; Возврат 1 (ошибка)
LBB142:
LBB143:
	.file 3 "c:/mingw/lib/gcc/mingw32/6.3.0/include/c++/ostream"
	.loc 3 561 0
	movl	$28, 8(%esp)
	movl	$LC0, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE143:
LBE142:
LBB144:
LBB145:
	.loc 3 171 0
	movl	%ebx, (%esp)
	movl	$__ZSt4cerr, %ecx
	call	__ZNSo9_M_insertImEERSoT_
	.cfi_def_cfa_offset 44
	subl	$4, %esp
	.cfi_def_cfa_offset 48
	movl	%eax, %edi
LBE145:
LBE144:
LBB146:
LBB147:
LBB148:
	.loc 3 591 0
	movl	(%eax), %eax
LBB149:
LBB150:
	.file 4 "c:/mingw/lib/gcc/mingw32/6.3.0/include/c++/bits/basic_ios.h"
	.loc 4 450 0
	movl	-12(%eax), %eax
	movl	124(%edi,%eax), %ebx
LBB151:
LBB152:
	.loc 4 49 0
	testl	%ebx, %ebx
	je	L15
LBE152:
LBE151:
LBB154:
LBB155:
	.file 5 "c:/mingw/lib/gcc/mingw32/6.3.0/include/c++/bits/locale_facets.h"
	.loc 5 874 0
	cmpb	$0, 28(%ebx)
	je	L10
	.loc 5 875 0
	movzbl	39(%ebx), %eax
L11:
LBE155:
LBE154:
LBE150:
LBE149:
	.loc 3 591 0
	movsbl	%al, %eax
	movl	%eax, (%esp)
	movl	%edi, %ecx
	call	__ZNSo3putEc
	.cfi_def_cfa_offset 44
	subl	$4, %esp
	.cfi_def_cfa_offset 48
LBB160:
LBB161:
	.loc 3 613 0
	movl	%eax, %ecx
	call	__ZNSo5flushEv
LBE161:
LBE160:
LBE148:
LBE147:
LBE146:
	.loc 2 18 0
	movl	%esi, (%esp)
	call	_CloseHandle@4
	.cfi_def_cfa_offset 44
	subl	$4, %esp
	.cfi_def_cfa_offset 48
	.loc 2 19 0
	movl	$1, %eax
	jmp	L7
L15:
LBB165:
LBB164:
LBB163:
LBB162:
LBB159:
LBB157:
LBB153:
	.loc 4 50 0
	call	__ZSt16__throw_bad_castv
L10:
LBE153:
LBE157:
LBB158:
LBB156:
	.loc 5 876 0
	movl	%ebx, %ecx
	call	__ZNKSt5ctypeIcE13_M_widen_initEv
	.loc 5 877 0
	movl	(%ebx), %eax
	movl	$10, (%esp)
	movl	%ebx, %ecx
	call	*24(%eax)
	.cfi_def_cfa_offset 44
	subl	$4, %esp
	.cfi_def_cfa_offset 48
	jmp	L11
LBE156:
LBE158:
LBE159:
LBE162:
LBE163:
LBE164:
LBE165:
	.cfi_endproc
LFE1505:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC1:
	.ascii "Usage: \0"
LC2:
	.ascii " <number>\0"
LC3:
	.ascii "Number must be non-negative\0"
	.align 4
LC4:
	.ascii "F\0a\0c\0t\0o\0r\0i\0a\0l\0S\0h\0a\0r\0e\0d\0M\0e\0m\0o\0r\0y\0\0\0"
	.align 4
LC5:
	.ascii "Could not create file mapping object: \0"
LC6:
	.ascii "CreateThread failed: \0"
LC7:
	.ascii "Factorial of 5 is \0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB1506:
	.loc 2 28 0
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x70,0x6
	.cfi_escape 0x10,0x7,0x2,0x75,0x7c
	.cfi_escape 0x10,0x6,0x2,0x75,0x78
	.cfi_escape 0x10,0x3,0x2,0x75,0x74
	subl	$56, %esp
	movl	(%ecx), %ebx
	movl	4(%ecx), %esi
	.loc 2 28 0
	call	___main
	.loc 2 29 0 ; Проверка аргументов
	cmpl	$2, %ebx ; argc == 2?
	je	L17 ; Нет - ошибка
	.loc 2 30 0
	movl	(%esi), %ebx
LBB166:
LBB167:
	.loc 3 561 0
	movl	$7, 8(%esp)
	movl	$LC1, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE167:
LBE166:
	.loc 2 30 0
	movl	%ebx, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	%eax, %ebx
LBB168:
LBB169:
	.loc 3 561 0
	movl	$9, 8(%esp)
	movl	$LC2, 4(%esp)
	movl	%eax, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE169:
LBE168:
LBB170:
LBB171:
	.loc 3 113 0
	movl	%ebx, (%esp)
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
LBE171:
LBE170:
	.loc 2 31 0
	movl	$1, %eax
L16:
	.loc 2 68 0
	leal	-16(%ebp), %esp
	popl	%ecx
	.cfi_remember_state
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
L17:
	.cfi_restore_state
	.loc 2 33 0 ; atoi(argv[1])
	movl	4(%esi), %eax
	movl	%eax, (%esp)
	call	_atoi
	.loc 2 34 0 ; Проверка n >= 0
	testl	%eax, %eax
	js	L24 ; Если отрицательное - ошибка
	.loc 2 39 0 ; CreateFileMappingW
	movl	$LC4, 20(%esp) ; Имя области
	movl	$8, 16(%esp) ; Размер
	movl	$0, 12(%esp)
	movl	$4, 8(%esp) ; PAGE_READWRITE
	movl	$0, 4(%esp)
	movl	$-1, (%esp) ; INVALID_HANDLE_VALUE
	call	_CreateFileMappingW@24
	subl	$24, %esp
	movl	%eax, %ebx ; Сохраняем HANDLE
	.loc 2 41 0
	testl	%eax, %eax
	je	L25
	.loc 2 46 0 ; CreateThread
	movl	$0, 20(%esp)
	movl	$0, 16(%esp)
	movl	%eax, 12(%esp) ; Передаем HANDLE
	movl	$__Z13child_processPv@4, 8(%esp)
	movl	$0, 4(%esp)
	movl	$0, (%esp)
	call	_CreateThread@24
	subl	$24, %esp
	movl	%eax, -28(%ebp) ; Сохраняем handle потока
	.loc 2 48 0
	testl	%eax, %eax
	je	L26
	.loc 2 54 0 ; WaitForSingleObject
	movl	$-1, 4(%esp) ; INFINITE
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_WaitForSingleObject@8
	subl	$8, %esp
	.loc 2 56 0
	movl	$8, 16(%esp)
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	$4, 4(%esp)
	movl	%ebx, (%esp)
	call	_MapViewOfFile@20
	subl	$20, %esp
	movl	%eax, -32(%ebp)
	.loc 2 57 0
	testl	%eax, %eax
	je	L27
	.loc 2 62 0
	movl	-32(%ebp), %eax
	movl	(%eax), %esi
	movl	4(%eax), %edi
LBB172:
LBB173:
	.loc 3 561 0
	movl	$18, 8(%esp)
	movl	$LC7, 4(%esp)
	movl	$__ZSt4cout, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE173:
LBE172:
LBB174:
LBB175:
	.loc 3 206 0
	movl	%esi, (%esp)
	movl	%edi, 4(%esp)
	movl	$__ZSt4cout, %ecx
	call	__ZNSo9_M_insertIyEERSoT_
	subl	$8, %esp
LBE175:
LBE174:
LBB176:
LBB177:
	.loc 3 113 0
	movl	%eax, (%esp)
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
LBE177:
LBE176:
	.loc 2 64 0
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_UnmapViewOfFile@4
	subl	$4, %esp
	.loc 2 65 0
	movl	%ebx, (%esp)
	call	_CloseHandle@4
	subl	$4, %esp
	.loc 2 66 0
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_CloseHandle@4
	subl	$4, %esp
	.loc 2 67 0
	movl	$0, %eax
	jmp	L16
L24: ; Обработка ошибок
LBB178:
LBB179:
	.loc 3 561 0
	movl	$27, 8(%esp)
	movl	$LC3, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE179:
LBE178:
LBB180:
LBB181:
	.loc 3 113 0
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
LBE181:
LBE180:
	.loc 2 36 0
	movl	$1, %eax
	jmp	L16
L25:
	.loc 2 42 0
	call	_GetLastError@0
	movl	%eax, %ebx
LBB182:
LBB183:
	.loc 3 561 0
	movl	$38, 8(%esp)
	movl	$LC5, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE183:
LBE182:
LBB184:
LBB185:
	.loc 3 171 0
	movl	%ebx, (%esp)
	movl	$__ZSt4cerr, %ecx
	call	__ZNSo9_M_insertImEERSoT_
	subl	$4, %esp
LBE185:
LBE184:
LBB186:
LBB187:
	.loc 3 113 0
	movl	%eax, (%esp)
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
LBE187:
LBE186:
	.loc 2 43 0
	movl	$1, %eax
	jmp	L16
L26:
	.loc 2 49 0
	call	_GetLastError@0
	movl	%eax, %esi
LBB188:
LBB189:
	.loc 3 561 0
	movl	$21, 8(%esp)
	movl	$LC6, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE189:
LBE188:
LBB190:
LBB191:
	.loc 3 171 0
	movl	%esi, (%esp)
	movl	$__ZSt4cerr, %ecx
	call	__ZNSo9_M_insertImEERSoT_
	subl	$4, %esp
LBE191:
LBE190:
LBB192:
LBB193:
	.loc 3 113 0
	movl	%eax, (%esp)
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
LBE193:
LBE192:
	.loc 2 50 0
	movl	%ebx, (%esp)
	call	_CloseHandle@4
	subl	$4, %esp
	.loc 2 51 0
	movl	$1, %eax
	jmp	L16
L27:
	.loc 2 58 0
	call	_GetLastError@0
	movl	%eax, %esi
LBB194:
LBB195:
	.loc 3 561 0
	movl	$28, 8(%esp)
	movl	$LC0, 4(%esp)
	movl	$__ZSt4cerr, (%esp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i
LBE195:
LBE194:
LBB196:
LBB197:
	.loc 3 171 0
	movl	%esi, (%esp)
	movl	$__ZSt4cerr, %ecx
	call	__ZNSo9_M_insertImEERSoT_
	subl	$4, %esp
LBE197:
LBE196:
LBB198:
LBB199:
	.loc 3 113 0
	movl	%eax, (%esp)
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
LBE199:
LBE198:
	.loc 2 59 0
	movl	%ebx, (%esp)
	call	_CloseHandle@4
	subl	$4, %esp
	.loc 2 60 0
	movl	$1, %eax
	jmp	L16
	.cfi_endproc
LFE1506:
	.def	__GLOBAL__sub_I__Z9factoriali;	.scl	3;	.type	32;	.endef
__GLOBAL__sub_I__Z9factoriali:
LFB1942:
	.loc 2 68 0
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
LBB202:
LBB203:
	.loc 1 74 0
	movl	$__ZStL8__ioinit, %ecx
	call	__ZNSt8ios_base4InitC1Ev
	movl	$___tcf_0, (%esp)
	call	_atexit
LBE203:
LBE202:
	.loc 2 68 0
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE1942:
	.section	.ctors,"w"
	.align 4
	.long	__GLOBAL__sub_I__Z9factoriali
.lcomm __ZStL8__ioinit,1,1
	.text
Letext0:
	.file 6 "c:/mingw/lib/gcc/mingw32/6.3.0/include/c++/bits/ios_base.h"
	.file 7 "c:/mingw/lib/gcc/mingw32/6.3.0/include/c++/bits/char_traits.h"
	.section	.debug_info,"dr"
Ldebug_info0:
	.long	0x5ee
	.word	0x4
	.secrel32	Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.ascii "GNU C++14 6.3.0 -mtune=generic -march=i586 -g1 -O1\0"
	.byte	0x4
	.ascii "lab_1_op_sys.cpp\0"
	.ascii "C:\\Users\\putin\\OneDrive\\\320\340\341\356\367\350\351 \361\362\356\353\\\321++\\lab_1_op_sys\0"
	.long	Ltext0
	.long	Letext0-Ltext0
	.secrel32	Ldebug_line0
	.uleb128 0x2
	.ascii "_GLOBAL__sub_I__Z9factoriali\0"
	.long	LFB1942
	.long	LFE1942-LFB1942
	.uleb128 0x1
	.byte	0x9c
	.long	0xcf
	.uleb128 0x3
	.long	0xcf
	.long	LBB202
	.long	LBE202-LBB202
	.byte	0x2
	.byte	0x44
	.byte	0
	.uleb128 0x4
	.ascii "__static_initialization_and_destruction_0\0"
	.byte	0x1
	.uleb128 0x5
	.ascii "__tcf_0\0"
	.long	LFB1941
	.long	LFE1941-LFB1941
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x6
	.ascii "__check_facet<std::ctype<char> >\0"
	.byte	0x4
	.byte	0x2f
	.ascii "_ZSt13__check_facetISt5ctypeIcEERKT_PS3_\0"
	.byte	0x3
	.uleb128 0x6
	.ascii "rdstate\0"
	.byte	0x4
	.byte	0x89
	.ascii "_ZNKSt9basic_iosIcSt11char_traitsIcEE7rdstateEv\0"
	.byte	0x3
	.uleb128 0x7
	.ascii "flush<char, std::char_traits<char> >\0"
	.byte	0x3
	.word	0x264
	.ascii "_ZSt5flushIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_\0"
	.byte	0x3
	.uleb128 0x7
	.ascii "widen\0"
	.byte	0x4
	.word	0x1c1
	.ascii "_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc\0"
	.byte	0x3
	.uleb128 0x6
	.ascii "setstate\0"
	.byte	0x4
	.byte	0x9d
	.ascii "_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate\0"
	.byte	0x3
	.uleb128 0x8
	.secrel32	LASF0
	.byte	0x3
	.byte	0xcd
	.ascii "_ZNSolsEy\0"
	.byte	0x3
	.uleb128 0x8
	.secrel32	LASF0
	.byte	0x3
	.byte	0x6c
	.ascii "_ZNSolsEPFRSoS_E\0"
	.byte	0x3
	.uleb128 0x7
	.ascii "endl<char, std::char_traits<char> >\0"
	.byte	0x3
	.word	0x24e
	.ascii "_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_\0"
	.byte	0x3
	.uleb128 0x8
	.secrel32	LASF0
	.byte	0x3
	.byte	0xaa
	.ascii "_ZNSolsEm\0"
	.byte	0x3
	.uleb128 0x7
	.ascii "operator<< <std::char_traits<char> >\0"
	.byte	0x3
	.word	0x22c
	.ascii "_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc\0"
	.byte	0x3
	.uleb128 0x9
	.ascii "main\0"
	.byte	0x2
	.byte	0x1c
	.long	LFB1506
	.long	LFE1506-LFB1506
	.uleb128 0x1
	.byte	0x9c
	.long	0x49c
	.uleb128 0x3
	.long	0x324
	.long	LBB166
	.long	LBE166-LBB166
	.byte	0x2
	.byte	0x1e
	.uleb128 0x3
	.long	0x324
	.long	LBB168
	.long	LBE168-LBB168
	.byte	0x2
	.byte	0x1e
	.uleb128 0x3
	.long	0x295
	.long	LBB170
	.long	LBE170-LBB170
	.byte	0x2
	.byte	0x1e
	.uleb128 0x3
	.long	0x324
	.long	LBB172
	.long	LBE172-LBB172
	.byte	0x2
	.byte	0x3e
	.uleb128 0x3
	.long	0x283
	.long	LBB174
	.long	LBE174-LBB174
	.byte	0x2
	.byte	0x3e
	.uleb128 0x3
	.long	0x295
	.long	LBB176
	.long	LBE176-LBB176
	.byte	0x2
	.byte	0x3e
	.uleb128 0x3
	.long	0x324
	.long	LBB178
	.long	LBE178-LBB178
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.long	0x295
	.long	LBB180
	.long	LBE180-LBB180
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.long	0x324
	.long	LBB182
	.long	LBE182-LBB182
	.byte	0x2
	.byte	0x2a
	.uleb128 0x3
	.long	0x312
	.long	LBB184
	.long	LBE184-LBB184
	.byte	0x2
	.byte	0x2a
	.uleb128 0x3
	.long	0x295
	.long	LBB186
	.long	LBE186-LBB186
	.byte	0x2
	.byte	0x2a
	.uleb128 0x3
	.long	0x324
	.long	LBB188
	.long	LBE188-LBB188
	.byte	0x2
	.byte	0x31
	.uleb128 0x3
	.long	0x312
	.long	LBB190
	.long	LBE190-LBB190
	.byte	0x2
	.byte	0x31
	.uleb128 0x3
	.long	0x295
	.long	LBB192
	.long	LBE192-LBB192
	.byte	0x2
	.byte	0x31
	.uleb128 0x3
	.long	0x324
	.long	LBB194
	.long	LBE194-LBB194
	.byte	0x2
	.byte	0x3a
	.uleb128 0x3
	.long	0x312
	.long	LBB196
	.long	LBE196-LBB196
	.byte	0x2
	.byte	0x3a
	.uleb128 0x3
	.long	0x295
	.long	LBB198
	.long	LBE198-LBB198
	.byte	0x2
	.byte	0x3a
	.byte	0
	.uleb128 0xa
	.ascii "child_process\0"
	.byte	0x2
	.byte	0xc
	.ascii "_Z13child_processPv@4\0"
	.long	LFB1505
	.long	LFE1505-LFB1505
	.uleb128 0x1
	.byte	0x9c
	.long	0x555
	.uleb128 0x3
	.long	0x324
	.long	LBB142
	.long	LBE142-LBB142
	.byte	0x2
	.byte	0x11
	.uleb128 0x3
	.long	0x312
	.long	LBB144
	.long	LBE144-LBB144
	.byte	0x2
	.byte	0x11
	.uleb128 0xb
	.long	0x295
	.long	LBB146
	.secrel32	Ldebug_ranges0+0
	.byte	0x2
	.byte	0x11
	.uleb128 0xb
	.long	0x2ae
	.long	LBB147
	.secrel32	Ldebug_ranges0+0
	.byte	0x3
	.byte	0x71
	.uleb128 0xc
	.long	0x1fe
	.long	LBB149
	.secrel32	Ldebug_ranges0+0x18
	.byte	0x3
	.word	0x24f
	.long	0x542
	.uleb128 0xd
	.long	0x10e
	.long	LBB151
	.secrel32	Ldebug_ranges0+0x30
	.byte	0x4
	.word	0x1c2
	.uleb128 0xd
	.long	0x57a
	.long	LBB154
	.secrel32	Ldebug_ranges0+0x48
	.byte	0x4
	.word	0x1c2
	.byte	0
	.uleb128 0xe
	.long	0x198
	.long	LBB160
	.long	LBE160-LBB160
	.byte	0x3
	.word	0x24f
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xf
	.ascii "factorial\0"
	.byte	0x2
	.byte	0x6
	.ascii "_Z9factoriali\0"
	.long	LFB1504
	.long	LFE1504-LFB1504
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x7
	.ascii "widen\0"
	.byte	0x5
	.word	0x368
	.ascii "_ZNKSt5ctypeIcE5widenEc\0"
	.byte	0x3
	.uleb128 0x6
	.ascii "operator|\0"
	.byte	0x6
	.byte	0xa9
	.ascii "_ZStorSt12_Ios_IostateS_\0"
	.byte	0x3
	.uleb128 0x7
	.ascii "length\0"
	.byte	0x7
	.word	0x10a
	.ascii "_ZNSt11char_traitsIcE6lengthEPKc\0"
	.byte	0x3
	.byte	0
	.section	.debug_abbrev,"dr"
Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x1d
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1d
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x1d
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"dr"
	.long	0x1c
	.word	0x2
	.secrel32	Ldebug_info0
	.byte	0x4
	.byte	0
	.word	0
	.word	0
	.long	Ltext0
	.long	Letext0-Ltext0
	.long	0
	.long	0
	.section	.debug_ranges,"dr"
Ldebug_ranges0:
	.long	LBB146-Ltext0
	.long	LBE146-Ltext0
	.long	LBB165-Ltext0
	.long	LBE165-Ltext0
	.long	0
	.long	0
	.long	LBB149-Ltext0
	.long	LBE149-Ltext0
	.long	LBB162-Ltext0
	.long	LBE162-Ltext0
	.long	0
	.long	0
	.long	LBB151-Ltext0
	.long	LBE151-Ltext0
	.long	LBB157-Ltext0
	.long	LBE157-Ltext0
	.long	0
	.long	0
	.long	LBB154-Ltext0
	.long	LBE154-Ltext0
	.long	LBB158-Ltext0
	.long	LBE158-Ltext0
	.long	0
	.long	0
	.section	.debug_line,"dr"
Ldebug_line0:
	.section	.debug_str,"dr"
LASF0:
	.ascii "operator<<\0"
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	__ZNSt8ios_base4InitD1Ev;	.scl	2;	.type	32;	.endef
	.def	_MapViewOfFile@20;	.scl	2;	.type	32;	.endef
	.def	_UnmapViewOfFile@4;	.scl	2;	.type	32;	.endef
	.def	_GetLastError@0;	.scl	2;	.type	32;	.endef
	.def	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_i;	.scl	2;	.type	32;	.endef
	.def	__ZNSo9_M_insertImEERSoT_;	.scl	2;	.type	32;	.endef
	.def	__ZNSo3putEc;	.scl	2;	.type	32;	.endef
	.def	__ZNSo5flushEv;	.scl	2;	.type	32;	.endef
	.def	_CloseHandle@4;	.scl	2;	.type	32;	.endef
	.def	__ZSt16__throw_bad_castv;	.scl	2;	.type	32;	.endef
	.def	__ZNKSt5ctypeIcE13_M_widen_initEv;	.scl	2;	.type	32;	.endef
	.def	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc;	.scl	2;	.type	32;	.endef
	.def	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_;	.scl	2;	.type	32;	.endef
	.def	_atoi;	.scl	2;	.type	32;	.endef
	.def	_CreateFileMappingW@24;	.scl	2;	.type	32;	.endef
	.def	_CreateThread@24;	.scl	2;	.type	32;	.endef
	.def	_WaitForSingleObject@8;	.scl	2;	.type	32;	.endef
	.def	__ZNSo9_M_insertIyEERSoT_;	.scl	2;	.type	32;	.endef
	.def	__ZNSt8ios_base4InitC1Ev;	.scl	2;	.type	32;	.endef
	.def	_atexit;	.scl	2;	.type	32;	.endef
