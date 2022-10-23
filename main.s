	.section	.rodata
.LC4:
	.string	"F1"
.LC5:
	.string	"r"
.LC6:
	.string	"F1.txt"
.LC7:
	.string	"F2"
.LC8:
	.string	"F2.txt"
.LC10:
    .string	"F3"
.LC9:
	.string	"F3.txt"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64	
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12
	pushq	%rbp	
	movq	%rsp, %rbp
	subq	$80, %rsp	      # пролог и выравнивание стека
	movq	%rdi, %r15	      # перемещаем argc в r15
	movq	%rsi, %r14	      # перемещаем argv в r14
	movl	$0, -56(%rbp)	  # зануляем file
	cmpq	$1, %r15	      # сравниваем 1 с argc
	je	.L22	              # если они равны, переходим по метке
	movq	%r14, %rax
	addq	$8, %rax	      # берем значение argv[1]
    movq    (%rax), %rax
	leaq	.LC4(%rip), %rsi  # кладем "F1" в rsi
	movq	%rax, %rdi	      # кладем argv[1] в rdi
	call	strcmp@PLT	      # вызываем strcmp
	testl	%eax, %eax	      # сравниваем eax и 0
	jne	.L23	              # если они не равны, прыгаем на L23
	leaq	.LC5(%rip), %rsi  # "r" перемещаем в rsi
	leaq	.LC6(%rip), %rdi  # F1.txt перемещаем в rdi
	call	fopen@PLT	      # вызываем fopen
	movq	%rax, %r12	  # записываем полученное значение
	leaq	-64(%rbp), %rdx
	movq	%r12, %rax	  # F1 переносим в rax
	leaq	.LC0(%rip), %rsi  # "%d" переносим в rsi
	movq	%rax, %rdi	      # переносим F1 в rdi
	movl	$0, %eax	      # зануляем eax
	call	__isoc99_fscanf@PLT	# вызываем fscanf
	movl	-64(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %r13	      # выделяем память под массив и записываем в r13
	movl	-64(%rbp), %ecx
	movq	%r12, %rdx
	movq	%r13, %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	get
	movl	%eax, -60(%rbp)	  # записываем значение get в first
	movq	%r12, %rax
	movq	%rax, %rdi
	call	fclose@PLT	      # закрываем файл F1
	jmp	.L24
.L23:
	movq	%r14, %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC7(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L25	              # если strcmp не F2, переходим на L25
	leaq	.LC5(%rip), %rsi
	leaq	.LC8(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -32(%rbp)	  # открываем файл и записываем адрес
	leaq	-64(%rbp), %rdx
	movq	-32(%rbp), %rax
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT	# считываем n из файла 
	movl	-64(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT	      # выделяем память под массив
	movq	%rax, %r13	      # и записываем адрес начала массива в а
	movl	-64(%rbp), %ecx
	movq	-32(%rbp), %rdx
	movq	%r13, %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	get
	movl	%eax, -60(%rbp)	  # получаем значение first из функции get
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT	      # закрываем файл F2
	jmp	.L24
.L25:
	movq	%r14, %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT	      
	testl	%eax, %eax
	jne	.L24	              # если файл не F3, переходим по метке
	leaq	.LC5(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -40(%rbp)   # записываем адрес файла F3
	leaq	-64(%rbp), %rdx
	movq	-40(%rbp), %rax
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT	# считываем значение n из F3
	movl	-64(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %r13	      # записываем адрес массива a в r13
	movl	-64(%rbp), %ecx
	movq	-40(%rbp), %rdx
	movq	%r13, %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	get
	movl	%eax, -60(%rbp)	  # присваиваем first значение, полученное из get
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT	      # закрываем F3
.L24:
	movl	$1, -56(%rbp)	  # присваиваем file значение 1
	jmp	.L26	              # прыгаем по метке
.L22:
	leaq	-64(%rbp), %rax	
	movq	%rax, %rsi	      # записываем значение в n
	leaq	.LC0(%rip), %rdi  # переносим "%d" в rdi
	movl	$0, %eax	      # зануляем eax
	call	__isoc99_scanf@PLT	# вызываем scanf
	movl	-64(%rbp), %eax	
	cltq
	salq	$2, %rax	      # умножаем n на 4 арифметическим сдвигом влево
	movq	%rax, %rdi	      # передаем полученное значение в rdi
	call	malloc@PLT	      # выделяем память под массив
	movq	%rax, %r13	      # переносим адрес начала массива в r13
	movl	$0, %edx	      # зануляем edx
	movl	-64(%rbp), %esi	  # переносим n в esi
	movq	%r13, %rdi	      # переносим a в rdi
	call	get	              # вызываем функцию get
	movl	%eax, -60(%rbp)	  # записываем полученное из функции значение в first
.L26:
	movl	-64(%rbp), %eax	  # переносим n в eax
	subl	-60(%rbp), %eax	  # вычисляем n - first
	movl	%eax, -52(%rbp)	  # записываем результат в size
	movl	-52(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi	      # вычисляем size * 4 и записываем в rdi
	call	malloc@PLT	      # выделяем память под массив
	movq	%rax, -16(%rbp)	  # записываем адрес массива b
	cmpl	$0, -60(%rbp)	  # сравниваем 0 с first
	je	.L27	              # если они равны
	movl	-64(%rbp), %ecx	  # записываем n в ecx
	movl	-60(%rbp), %edx	  # записываем first в edx
	movq	-16(%rbp), %rsi	  # записываем b в rsi
	movq	%r13, %rax	      # записываем a в rax
	movq	%rax, %rdi
	call	form	          # вызываем form
	movl	-56(%rbp), %edx	  # записываем file
	movl	-52(%rbp), %ecx	  # записываем size
	movq	-16(%rbp), %rax	  # записываем b
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	print	          # вызываем print
.L27:
	movq	%r13, %rdi	
	call	free@PLT	      # очищаем память массива a
	movq	-16(%rbp), %rdi
	call	free@PLT	      # очищаем память массива b
	movl	$0, %eax	      # передаем 0 в eax
.L29:
	leave	
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	main, .-main
