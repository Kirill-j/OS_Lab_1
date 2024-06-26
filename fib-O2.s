		.file	"fib.c" 				// Откуда сгенерирован
		.text							// Начало секции кода
		.globl	fib						// Функция глобальна
		.type	fib, @function			// Тип - функция
fib:									// Начало фунции
.LFB0:									// Начало базового блока функции
		.cfi_startproc					// Начало процедуры отладки
		endbr64							// Инструкция безопасности для защиты от переполнения
		leal	-1(%rdi), %edx			// Вычисление %rdi - 1 и сохранение в %edx
		movl	$1, %eax				// Загружает значение 1 в %eax
		cmpl	$1, %edx				// Сравнивает значение аргумента с константой 1
		jbe	.L5							// Если значение меньше или равно 1, перейти к L5
		pushq	%rbp					// Сохраняет текущее значение %rbp на вершине стека
		.cfi_def_cfa_offset 16			// Устнавливает смещение на 16 байт
		.cfi_offset 6, -16				// Указывает, что значение %rbp находится по адресу -16 от текущего значения
		pushq	%rbx					// Сохраняет текущее значение %rbx на вершине стека
		.cfi_def_cfa_offset 24			// Устнавливает смещение на 24 байта
		.cfi_offset 3, -24				// Указывает, что %rbx находится на -24 от текущего значения CFA
		subq	$8, %rsp				// Резервирует место для локальных переменных (8 байт)
		.cfi_def_cfa_offset 32			// Устнавливает смещение на 32 байта
		movl	%edi, %ebx				// Копирует из %edi в %ebx
		movl	%edx, %edi				// Копирует из %edx в %edi
		call	fib						// Вызов функции
		movl	%eax, %ebp				// Копирует из %eax в %ebp
		leal	-2(%rbx), %edi			// Вычисление %rdx - 2 и сохранение в %edi
		call	fib						// Вызов функции
		addl	%ebp, %eax				// Складывает результыты возовов функции
		addq	$8, %rsp				// Увеличивает указатель стека на 8 байт, освобождая место под локал. переменные
		.cfi_def_cfa_offset 24			// Устнавливает смещение на 24 байта
		popq	%rbx					// Извлекает значение регистра %rbx из стека
		.cfi_def_cfa_offset 16			// Устнавливает смещение на 16 байт
		popq	%rbp					// Извлекает значение регистра %rbp из стека
		.cfi_def_cfa_offset 8			// Устнавливает смещение на 8 байт
		ret								// Возвращает результат
.L5:									// Метка,куда будет осуществлен переход, если условие jbe не будет выполнено.
		.cfi_restore 3					// Восстановление информации о регистре %rdx
		.cfi_restore 6					// Восстановление информации о регистре %rbp
		ret								// Возвращает результат
		.cfi_endproc					// Завершение процедуры отладки
.LFE0:
		.size	fib, .-fib
		.ident	"GCC: (Ubuntu 13.2.0-4ubuntu3) 13.2.0"
		.section	.note.GNU-stack,"",@progbits
		.section	.note.gnu.property,"a"
		.align 8
		.long	1f - 0f
		.long	4f - 1f
		.long	5
0:
		.string	"GNU"
1:
		.align 8
		.long	0xc0000002
		.long	3f - 2f
2:
		.long	0x3
3:
		.align 8
4:
