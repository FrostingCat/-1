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
