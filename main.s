	.text
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	get
	.type	get, @function
get:
	endbr64	
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12              # сохраняем значения, лежащие в r12, r13, r14, r15
	pushq	%rbp	          # пролог
	movq	%rsp, %rbp	      # пролог
	subq	$16, %rsp         # выравниваем стек
	movq	%rdi, %r15    	  # перемещаем в регистр r15 переменную а
	movq	%rsi, %r14    	  # перемещаем в регистр r14 n
	movq	%rdx, %r13    	  # перемещаем в регистр r13 file
	movq	$0, %r12    	  # кладем 0 на регистр r12 в место, предназначенное для last
	cmpq	$0, %r13    	  # проверяем, существует ли file
	jne	.L2	                  # если существует, прыгаем по метке L2
	movl	$0, -12(%rbp)	  # кладем в стек 0 на место, предназначенное для i
	jmp	.L3	                  # начинаем цикл
.L5:
	movl	-12(%rbp), %eax	  # кладем i в регистр
	cltq                      # расширяем eax до rax
	leaq	0(,%rax,4), %rdx	
	movq	%r15, %rax	    
	addq	%rdx, %rax	    
	movq	%rax, %rsi	      # кладем a[i] в rsi для дальнейшего вызова scanf
	leaq	.LC0(%rip), %rdi  # записываем "%d" в rdi
	movl	$0, %eax	      # обнуляем eax
	call	__isoc99_scanf@PLT	# вызываем scanf
	movl	-12(%rbp), %eax	  # перемещаем i в eax
	cltq
	leaq	0(,%rax,4), %rdx	
	movq	%r15, %rax	
	addq	%rdx, %rax	
	movl	(%rax), %eax	  # ищем переменную a[i]
	testl	%eax, %eax	      # сравниваем a[i] с 0
	jle	.L4	                  # если a[i] <= 0, прыгаем в L4
	movl	-12(%rbp), %eax	  # перемещаем i в eax
	addl	$1, %eax	      # добавляем 1 к i
	movq	%rax, %r12	      # перемещаем i + 1 в last
.L4:
	addl	$1, -12(%rbp)	  # добавляем 1 к i
.L3:
	movl	-12(%rbp), %eax	 
	cmpq	%r14, %rax	      # сравниваем i с n
	jl	.L5	                  # если i < n
	movq	%r12, %rax	      # перемещаем last для возврата из функции
	jmp	.L6	                  # прыгаем на возврат из функции
.L2:
	movq	$0, %r12	      # присваиваем last значение 0
	movl	$0, -4(%rbp)	  # перемещаем 0 в i
	jmp	.L7	                  # начинаем цикл
.L9:
	movl	-4(%rbp), %eax	  #  берем со стека значение i и перемещаем в регистр
	cltq                      # расширяем eax до rax
	leaq	0(,%rax,4), %rdx  # ищем место в массиве а
	movq	%r15, %rax	      # передаем адрес массива а в rax
	addq	%rax, %rdx	      # записываем число из файла в a[i]
	leaq	.LC0(%rip), %rsi  # записываем "%d" в rsi
	movq	%r13, %rdi	      # записываем file в rdi
	movl	$0, %eax	      # обнуляем eax
	call	__isoc99_fscanf@PLT	# вызываем fscanf
	movl	-4(%rbp), %eax	  # перемещаем i в eax
	cltq                      # расширяем eax
	leaq	0(,%rax,4), %rdx
	movq	%r15, %rax
	addq	%rdx, %rax	      # ищем a[i]
	movl	(%rax), %eax
	testl	%eax, %eax	      # сверяем a[i] с 0
	jle	.L8	                  # если a[i] <= 0, переходим по метке
	movl	-4(%rbp), %eax	  # переносим i  в eax
	addl	$1, %eax	      # добавляем 1 к i
	movq	%rax, %r12	      # перемещаем i в last
.L8:
	addl	$1, -4(%rbp)	  # прибавляем 1 к i
.L7:
	movl	-4(%rbp), %eax	  # переносим i в eax
	cmpq	%r14, %rax	      # сравниваем i с n
	jl	.L9	                  # если i < n входим в цикл
	movq	%r12, %rax	      # перемещаем i в last для return
.L6:
	leave
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	get, .-get
	.globl	form
	.type	form, @function
form:
	endbr64	
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12              # сохраняем значения, лежащие в r12, r13, r14, r15
	pushq	%rbp	
	movq	%rsp, %rbp	      # эпилог
	movq	%rdi, %r15	      # перемещаем a в r15
	movq	%rsi, %r14	      # перемещаем b в r14
	movq	%rdx, %r13	      # перемещаем first в r13
	movq	%rcx, %r12	      # перемещаем last в r12
	movl	$0, -8(%rbp)	  # j = 0
	movq	%r13, %rax	   
	movl	%eax, -4(%rbp)	  # перемещаем first в i
	jmp	.L11	              # начинаем цикл
.L12:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx	
	movq	%r15, %rax	
	addq	%rdx, %rax	      # ищем a[i]
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	%r14, %rdx
	addq	%rcx, %rdx	      # ищем b[j]
	movl	(%rax), %eax	
	movl	%eax, (%rdx)	  # присваеваем b[j]-му a[i]-тый
	addl	$1, -8(%rbp)	  # прибавляем 1 к j
	addl	$1, -4(%rbp)	  # прибавляем 1 к i
.L11:
	movl	-4(%rbp), %eax
	cmpq	%r12, %rax	      # сравниваем i с last
	jl	.L12	              # если i < last прыгаем на L12
	nop	                      # выравниваем стек
	nop	
	popq	%rbp	
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	form, .-form
	.section	.rodata
.LC1:
	.string	"%d "
.LC2:
	.string	"w"
.LC3:
	.string	"output.txt"
	.text
	.globl	print
	.type	print, @function
print:
	endbr64	
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12              # сохраняем значения, лежащие в r12, r13, r14, r15
	pushq	%rbp	
	movq	%rsp, %rbp	
	subq	$32, %rsp	      # пролог и выравнивание стека
	movq	%rdi, %r15	      # перемещаем b в r15
	movq	%rsi, %r14	      # перемещаем size в r14
	movq	%rdx, %r13	      # перемещаем file в r12
	cmpq	$0, %r13	      # проверяем, существует ли file
	jne	.L14	              # если существует, прыгаем в L14
	movq	$0, %r12	      # кладем 0 в i 
	jmp	.L15	              # начинаем цикл
.L16:
	movq	%r12, %rax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	%r15, %rax
	addq	%rdx, %rax	      # получаем адрес b[i]
	movl	(%rax), %esi	  # передаем b[i] в esi
	leaq	.LC1(%rip), %rdi  # передаем "%d " в rdi
	movl	$0, %eax	      # обнуляем eax
	call	printf@PLT	      # вызываем printf
	addq	$1, %r12	      # прибавляем 1 к i
.L15:
	movq	%r12, %rax
	cmpq	%r14, %rax	      # сравниваем i с size
	jl	.L16	              # если i < size, переходим по метке
	jmp	.L20	              # если больше, переходим в эпилог
.L14:
	leaq	.LC2(%rip), %rsi  # кладем "w" в rsi
	leaq	.LC3(%rip), %rdi  # кладем output.txt в rdi
	call	fopen@PLT	      # вызываем fopen
	movq	%rax, -8(%rbp)	  # кладем output на стек
	movq	$0, %r12	      # кладем 0 в i     
	jmp	.L18	              # начинаем цикл
.L19:
	movq	%r12, %rax	
	cltq
	leaq	0(,%rax,4), %rdx	
	movq	%r15, %rax
	addq	%rdx, %rax        # получаем адрес b[i]
	movl	(%rax), %edx	  # переносим b[i] в edx
	leaq	.LC1(%rip), %rsi  # переносим "%d " в rsi
	movq	-8(%rbp), %rdi	  # переносим output в rdi
	movl	$0, %eax	      # обнуляем eax
	call	fprintf@PLT	      # вызываем fprintf
	addq	$1, %r12	      # прибавляем 1 к i
.L18:
	movq	%r12, %rax
	cmpq	%r14, %rax	      # сравниваем i с size
	jl	.L19	              # если i < size, прыгаем в метку
	movq	-8(%rbp), %rdi	  # переносим output в rdi
	call	fclose@PLT	      # закрываем файл
.L20:
	nop	
	leave	                  # эпилог, выходим из функции
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	print, .-print
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
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)	  # кладем канарейку на стек
	xorl	%eax, %eax	      # зануляем eax
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
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L29
	call	__stack_chk_fail@PLT
.L29:
	leave	
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	main, .-main
