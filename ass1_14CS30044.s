.file	"ass1_14CS30044.c"						# source file name
	.section	.rodata						# read-only data section
	.align 8								# align with 8-byte boundary
.LC0:										# Label of f-string-1st printf
	.string	"Enter how many elements you want:"	# the format string 
												#  of printf
.LC1:										# Label of f-string- scanf
	.string	"%d"							# format string of scanf
.LC2:										# Label of f-string-2nd printf
	.string	"Enter the %d elements:\n"
.LC3:										# Label of f-string-3rd printf
	.string	"\nEnter the item to search"
.LC4:										# Label of f-string-4th printf
	.string	"\n%d found in position: %d\n"
.LC5:										# Label of f-string-5th printf (inside if block)
	.string	"\n%d inserted in position: %d\n"
.LC6:										# Label of f-string-6th printf (inside else block)
	.string	"The list of %d elements:\n"
.LC7:										# Label of f-string-7th printf (inside for loop)
	.string	"%6d"
	.text									# Code starts
	.globl	main							# main is a global name
											# i.e. available to entire prog. (visible to linker)
	.type	main, @function					# main is a function:
main:										# main: starts
.LFB0:										# local label referring to start of a function
	.cfi_startproc							# Call Frame Information (CFI) Directive
											# used at beginning of function to initialize some
											# internal data structures
	pushq	%rbp							# save current value of "rbp" register
											# (saving old base pointer)
	.cfi_def_cfa_offset 16					# CFI Directive to compute CFA (Canonical Frame Address)
											# take address from the register & add offset (16) to it
	.cfi_offset 6, -16						# CFI directive: Previous value of register(6)
											# is saved at offset(-16) from CFA
	movq	%rsp, %rbp						# rbp <-- rsp (Quad word(q) data type- 8 bytes)
											# Set new stack base pointer for the function
	.cfi_def_cfa_register 6					# CFI Directive: Register(6) will be used
											# to compute CFA
	subq	$432, %rsp						# Create space for local array and variables

	movq	%fs:40, %rax					# these three instructions are used to
	movq	%rax, -8(%rbp)					# check for stack boundary violation
	xorl	%eax, %eax

	movl	$.LC0, %edi						# edi <- 1st parameter of printf
											# 1st parameter of printf stores the string of .LC0 label
	call	puts							# Calls puts for printf
	leaq	-432(%rbp), %rax				# rax <- (rbp-432)
											#  (&n)
	movq	%rax, %rsi						# rsi <- rax
											# 2nd parameter (of scanf)
											# Address of 'n' is stored in 2nd parameter of scanf
	movl	$.LC1, %edi						# edi <- starting address of string of .LC1 label
											# 1st parameter of scanf stores starting address of "%d"
	movl	$0, %eax						# eax <- 0 (Double word(l)- 4 bytes)
											# setting the return value as null(0)
											# before calling the scanf function
	call	__isoc99_scanf					# Calls scanf, return value is in eax
	movl	-432(%rbp), %eax				# eax <- M[rbp-432] (n) (l- 4 bytes)
	movl	%eax, %esi						# esi <- eax
											# Value stored in 2nd parameter (n)
	movl	$.LC2, %edi						# edi <- starting address of
											#  printf format string
											#  1st parameter
	movl	$0, %eax						# eax <- 0
											# setting the return value as null(0)
											# before calling the printf function
	call	printf							# Calls printf(2nd call)
											# return value is in eax
	movl	$0, -424(%rbp)					# M[rbp-424] <- 0
											#  i <- 0, intialize loop variable
	jmp	.L2									# Unconditional jump statement
											# Goto beginning of for loop (condition)
.L3:										# Label for body of the loop
											# (after loop condition)
	leaq	-416(%rbp), %rax				# rax <- (rbp-416)
											# (&a[0]- address of 1st element of array a)
	movl	-424(%rbp), %edx				# edx <- M[rbp-424] (i)
	movslq	%edx, %rdx						# rdx <- edx (32-bits to
											# sign ext. 64-bits)
	salq	$2, %rdx						# rdx <- shift-arithmetic
											# 2-bit left (4*i)
											# 4- as, array element(a[i])
											# is of int type (4 bytes)
	addq	%rdx, %rax						# rax <- rax + rdx
											# (a + 4*i = &a[i])
	movq	%rax, %rsi						# rsi <- rax (&a[i])
											# 2nd parameter of scanf
	movl	$.LC1, %edi						# edi <- address of format string (in .LC1 label)
											# 1st parameter of scanf
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value as null(0)
											# before calling the scanf function
	call	__isoc99_scanf					# Calls scanf, return value is in eax
	addl	$1, -424(%rbp)					# M[rbp-424] <- M[rbp-424] + 1
											# (i <- i+1) incrementing loop variable
.L2:										# Label, body for loop condition
	movl	-432(%rbp), %eax				# eax <- M[rbp-432] (n)
	cmpl	%eax, -424(%rbp)				# Unsigned comparison between
											# eax (n) and M[rbp-424] (i)
	jl	.L3									# if i < return value (n), goto .L3 (loop)
											# 		Continue reading data (until i >=n)
	movl	-432(%rbp), %edx				# edx <- M[rbp-432]
											# Load value (n)
	leaq	-416(%rbp), %rax				# rax <- (rbp-416)
											# Load Effective Address (a)
	movl	%edx, %esi						# esi <- edx (n) (value- 4 bytes (int))
											# 2nd parameter of inst_sort function
	movq	%rax, %rdi						# rdi <- rax (a) (address- 8 bytes) (call by reference)
	call	inst_sort						# Calls inst_sort function
	movl	$.LC3, %edi						# edi <- address of format string (in .LC3 label)
											# 1st parameter of printf
	call	puts							# calls puts for printf
	leaq	-428(%rbp), %rax				# rax <- (rbp-428) (q- 8 bytes)
											# (&item - address)
	movq	%rax, %rsi						# rsi <- rax (&item)
											# 2nd parameter of scanf
	movl	$.LC1, %edi						# edi <- address of format string (in .LC1 label)
											# 1st parameter of scanf
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value as null(0)
											# before calling the scanf function
	call	__isoc99_scanf					# Calls scanf, return value is in eax
	movl	-428(%rbp), %edx				# edx <- M[rbp-428] (item) (4 bytes)
											# 3rd parameter of bsearch function
	movl	-432(%rbp), %ecx				# ecx <- M[rbp-432] (n) (4 bytes)
	leaq	-416(%rbp), %rax				# rax <- (rbp-416) (a) (address- 8 bytes)
											# address of array a (its 1st element)
	movl	%ecx, %esi						# esi <- ecx (n)
											# 2nd parameter of bsearch function
	movq	%rax, %rdi						# rdi <- rax (a (address of array))
											# 1st parameter of bsearch function
	call	bsearch							# Calls bsearch function
	movl	%eax, -420(%rbp)				# M[rbp-420] <- eax
	movl	-420(%rbp), %eax				# eax <- M[rbp-420] (loc)
	cltq									# rax <- eax (32-bits to
											# sign ext. 64-bits)
	movl	-416(%rbp,%rax,4), %edx			# edx <- M[rbp +4*rax-416] (a[loc])
											# the content in address given by (%rbp + 4*%rax - 416)
											# is copied into edx register
	movl	-428(%rbp), %eax				# eax <- M[rbp-428] (item)
	cmpl	%eax, %edx						# Unsigned comparison between
											# eax (item) & edx (a[loc])
	jne	.L4									# if item != a[loc] goto .L4 (else block)
											# to insert the item
#											# Entering the if block
	movl	-420(%rbp), %eax				# eax <- M[rbp-420] (loc)
	leal	1(%rax), %edx					# edx <- (rax+1) (loc + 1)
											# 3rd parameter of printf
	movl	-428(%rbp), %eax				# eax <- M[rbp-428] (item)
	movl	%eax, %esi						# esi <- eax (item)
											# 2nd parameter of printf
	movl	$.LC4, %edi						# edi <- address of format string (in .LC4 label)
											# 1st parameter of printf
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value as null(0)
											# before calling the printf function
	call	printf							# Calls printf
	jmp	.L5									# Unconditionally jump to .L5 label
											# outside of if-else block
.L4:										# Entering the else block
	movl	-428(%rbp), %edx				# edx <- M[rbp-428] (item)
											# 3rd parameter of insert function
	movl	-432(%rbp), %ecx				# ecx <- M[rbp-432] (n)
	leaq	-416(%rbp), %rax				# rax <- (rbp-416) (address of array a)
	movl	%ecx, %esi						# esi <- ecx (n)
											# 2nd parameter of insert function
	movq	%rax, %rdi						# rdi <- rax (address of array a)
											# 1st parameter of insert function
	call	insert							# call insert function
	movl	%eax, -420(%rbp)				# M[rbp-420] <- eax (l- 4 bytes)
											# loc stores the return value of insert function
	movl	-432(%rbp), %eax				# eax <- M[rbp-432] (n)
	addl	$1, %eax						# eax <- eax + 1
											# for, n <- n+1 (n++)
	movl	%eax, -432(%rbp)				# M[rbp-432] <- eax
											# n <- n+1 (n++), here n stores the updated incremented value
	movl	-420(%rbp), %eax				# eax <- M[rbp-420] (loc)
	leal	1(%rax), %edx					# edx <- (rax+1) (loc + 1)
											# 3rd parameter of printf
	movl	-428(%rbp), %eax				# eax <- M[rbp-428] (item)
	movl	%eax, %esi						# esi <- eax (item)
											# 2nd parameter of printf
	movl	$.LC5, %edi						# edi <- address of format string (in .LC5 label)
											# 1st parameter of printf
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value as null(0)
											# before calling the printf function
	call	printf							# Calls printf
.L5:										# Label for stements after if-else block
	movl	-432(%rbp), %eax				# eax <- M[rbp-432] (n)
	movl	%eax, %esi						# esi <- eax (n)
											# 2nd parameter of printf
	movl	$.LC6, %edi						# edi <- address of format string (in .LC6 label)
											# 1st parameter of printf
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value as null(0)
											# before calling the printf function
	call	printf							# Calls printf
	movl	$0, -424(%rbp)					# M[rbp-424] <- 0
											# i <- 0, initialize loop variable
	jmp	.L6									# Unconditionally jump to .L6 (for loop condition)
.L7:										# Body of for loop
	movl	-424(%rbp), %eax				# eax <- M[rbp-424] (i)
	cltq									# rax <- eax (32-bits to
											# sign ext. 64-bits)
	movl	-416(%rbp,%rax,4), %eax			# eax <- M[rbp + 4*rax - 416] (a[i])
											# the content in address given by (%rbp + 4*%rax - 416)
											# is copied into eax register
	movl	%eax, %esi						# esi <- eax (a[i])
											# 2nd parameter of printf
	movl	$.LC7, %edi						# edi <- address of format string (in .LC7 label)
											# 1st parameter of printf
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value as null(0)
											# before calling the printf function
	call	printf							# Calls printf
	addl	$1, -424(%rbp)					# M[rbp-424] <- M[rbp-424] + 1
											# (i <- i+1) incrementing loop variable
.L6:										# Checking of loop condition
	movl	-432(%rbp), %eax				# eax <- M[rbp-432] (n)
	cmpl	%eax, -424(%rbp)				# Unsigned comparison between
											# eax (n) & M[rbp-424] (i)
	jl	.L7									# After comparison, if i < n,
											# then goto .L7 (body of for loop)
	movl	$10, %edi						# edi <- 10
	call	putchar							# calls putchar (for, '\n')
	movl	$0, %eax						# eax <- 0 (Dual word- 4 bytes)
											# setting the return value of main function as null(0)

	movq	-8(%rbp), %rcx					# these instructions are used to
	xorq	%fs:40, %rcx					# check for stack fails before returning from function
	je	.L9
	call	__stack_chk_fail

.L9:
	leave									# destroys the stack frame of the function
	.cfi_def_cfa 7, 8						# CFI Directive to compute CFA
											# Register 8 will be used instead of register 7
	ret										# Return statement (returning null)
											# return from main function
	.cfi_endproc							# CFI directive to close the unwind entry
											# previously opened by .cfi_startproc
.LFE0:										# label at end of function
	.size	main, .-main					# This directive tells the assembler to
											# compute the size of symbol main to be the
											# difference between the label main and the
											# current position in the file
	.globl	inst_sort						# inst_sort is a global name
	.type	inst_sort, @function			# inst_sort is a function
inst_sort:									# inst_sort function starts:
.LFB1:										# Label referring to start of a function
	.cfi_startproc							# CFI Directive
	pushq	%rbp							# save old base pointer (rbp)
	.cfi_def_cfa_offset 16					# CFI Directive
	.cfi_offset 6, -16						# CFI Directive
	movq	%rsp, %rbp						# rbp <- rsp
											# Set new stack base pointer
	.cfi_def_cfa_register 6					# CFI Directive
	movq	%rdi, -24(%rbp)					# M[rbp-24] <- rdi (1st parameter- num)
											# q- 8 bytes (as, address of array num)
	movl	%esi, -28(%rbp)					# M[rbp-28] <- esi (2nd parameter- n)
											# l- 4 bytes (as, n is an int variable)
	movl	$1, -8(%rbp)					# M[rbp-8] <- 1 (j <- 1)
											# intializing for loop variable
	jmp	.L11								# Unconditionally goto .L11 label
.L15:										# Label: Outer for loop body of
											# inst_sort function
	movl	-8(%rbp), %eax					# eax <- M[rbp-8] (j)
	cltq									# rax <- eax (32- to sign ext 64-bits)
	leaq	0(,%rax,4), %rdx				# rdx <- (4*rax) (4*j) (q- as, address)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num)
	addq	%rdx, %rax						# rax <- rax + rdx (num + j) (8 bytes)
	movl	(%rax), %eax					# eax <- rax (num[j]) (4 bytes)
	movl	%eax, -4(%rbp)					# M[rbp-4] <- eax
											# (k = num[j])
	movl	-8(%rbp), %eax					# eax <- M[rbp-8] (j)
	subl	$1, %eax						# eax <- eax - 1 (j - 1)
	movl	%eax, -12(%rbp)					# M[rbp-12] <- eax
											# (i <- j-1)
	jmp	.L12								# Goto .L12 (inner loop condition)
.L14:										# Label: Inner for loop body
	movl	-12(%rbp), %eax					# eax <- M[rbp-12] (i)
	cltq									# rax <- eax (32 to 64 bits)
	addq	$1, %rax						# rax <- rax+1 (i+1)
	leaq	0(,%rax,4), %rdx				# rdx <- (4*rax) (4*(i+1))
											# 4- as, array elements are int type (4 bytes)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num) (address)
	addq	%rax, %rdx						# rdx <- rdx + rax (num + 4*(i+1))
											# (&num[i+1])
	movl	-12(%rbp), %eax					# eax <- M[rbp-12] (i)
	cltq									# rax <- eax (32 to 64 bits)
	leaq	0(,%rax,4), %rcx				# rcx <- (4*rax) (4*i)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num)
	addq	%rcx, %rax						# rax <- rax + rcx (num+4*i)
											# (&num[i])
	movl	(%rax), %eax					# eax <- num[i] (int value- 4 bytes)
	movl	%eax, (%rdx)					# rdx <- edx (32 to 64 bits)
	subl	$1, -12(%rbp)					# M[rbp-12] <- M[rbp-12] - 1
											# i <- i-1 (i--) (inner loop var decrement)
.L12:										# Label: Inner loop Condition check
	cmpl	$0, -12(%rbp)					# Unsigned comparison between
											# M[rbp-12] (i) & 0 (zero)
	js	.L13								# After comparison, if
											# i < 0, goto .L13
	movl	-12(%rbp), %eax					# eax <- M[rbp-12] (i) (int value)
	cltq									# rax <- eax (32 to 64 bits) (address)
	leaq	0(,%rax,4), %rdx				# rdx <- (4*rax) (4*i)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num)
	addq	%rdx, %rax						# rax <- rax + rdx (num+i) (address(q))
	movl	(%rax), %eax					# eax <- num[i] (int value) (4 bytes)
	cmpl	-4(%rbp), %eax					# Unsigned comparison between
											# eax (num[i]) & M[rbp-4] (k)
	jg	.L14								# After comparison, if
											# k > num[i], then goto .L14 (inside inner loop)
.L13:										# Label: below inner loop
	movl	-12(%rbp), %eax					# eax <- M[rbp-12] (i)
	cltq									# rax <- eax (32 to 64 bits)
	addq	$1, %rax						# rax <- rax + 1 (i+1) (8 bytes)
	leaq	0(,%rax,4), %rdx				# rdx <- (4*rax) (4*(i+1))
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num)
	addq	%rax, %rdx						# rdx <- rdx + rax (num+4*(i+1))
											# (&num[i+1])
	movl	-4(%rbp), %eax					# eax <- M[rbp-4] (k)
	movl	%eax, (%rdx)					# rdx <- eax
											# (num[i+1] <- k)
	addl	$1, -8(%rbp)					# M[rbp-8] <- M[rbp-8]+1 (j++)
											# Decrement of Outer loop variable
.L11:										# Label: for outer loop condition check
	movl	-8(%rbp), %eax					# eax <- M[rbp-8] (j)
	cmpl	-28(%rbp), %eax					# Unsigned comparison between
											# eax (j) & M[rbp-28] (n)
	jl	.L15								# After comparison, if j < n, goto .L15
	nop										# No operation
	popq	%rbp							# restore the stack base pointer
	.cfi_def_cfa 7, 8						# CFI Directive
	ret										# return statement (returning null)
	.cfi_endproc							# CFI Directive
.LFE1:										# label at end of function
	.size	inst_sort, .-inst_sort
	.globl	bsearch							# bsearch is global
	.type	bsearch, @function				# bsearch is a function
bsearch:									# bsearch starts:
.LFB2:										# label referring start of a function
	.cfi_startproc							# CFI Directive
	pushq	%rbp							# Save the old stack base pointer
	.cfi_def_cfa_offset 16					# CFI Directive
	.cfi_offset 6, -16						# CFI Directive
	movq	%rsp, %rbp						# rbp <- rsp
											# Set new stack base pointer
	.cfi_def_cfa_register 6					# CFI Directive
	movq	%rdi, -24(%rbp)					# M[rbp-24] <- rdi (a)
											# 1st parameter (array)(q- 8 bytes)
	movl	%esi, -28(%rbp)					# M[rbp-28] <- rdi (n)
											# 2nd parameter (n)(l- 4 bytes)
	movl	%edx, -32(%rbp)					# M[rbp-32] <- rdi (item)
											# 3rd parameter (item)(l- 4 bytes)
	movl	$1, -8(%rbp)					# M[rbp-8] <- 1
											# (bottom = 1)
	movl	-28(%rbp), %eax					# eax <- n
	movl	%eax, -12(%rbp)					# M[rbp-12] <- eax
											# (top = n)
.L20:										# Start of do-while loop
	movl	-8(%rbp), %edx					# edx <- bottom
	movl	-12(%rbp), %eax					# eax <- top
	addl	%edx, %eax						# eax <- eax + edx (top + bottom)
											# (may have overflowed (wih only 4 bytes))
	movl	%eax, %edx						# edx <- eax (top+bottom)
	shrl	$31, %edx						# edx <- shift-logical
											# 31 bits right (edx/(2^31))
											# if edx <0, edx=1 (i.e. overflow)
											# else edx=1
	addl	%edx, %eax						# eax <- eax + edx (top+bottom)
	sarl	%eax							# eax <- shift-arithmetic
											# 2 bit right (eax/2) ((top+bottom)/2)
	movl	%eax, -4(%rbp)					# M[rbp-4] <- eax
											# mid = (bottom+top)/2
	movl	-4(%rbp), %eax					# eax <- mid
	cltq									# rax <- eax
	leaq	0(,%rax,4), %rdx				# rdx <- (4*rax) (4*mid)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (a)
	addq	%rdx, %rax						# rax <- rax + rdx (a + 4*mid)
	movl	(%rax), %eax					# eax <- rax (a[mid])
	cmpl	-32(%rbp), %eax					# Unsigned comparison between
											# eax (a[mid]) & M[rbp-32] (item)
	jle	.L17								# if a[mid] <= item goto .L17 (else if block)
#											# if block
	movl	-4(%rbp), %eax					# eax <- mid
	subl	$1, %eax						# eax <- eax-1 (mid-1)
	movl	%eax, -12(%rbp)					# M[rbp-12] <- eax
											# (top = mid-1)
	jmp	.L18								# goto outside of if-else-if chain
.L17:										# label: else-if block
	movl	-4(%rbp), %eax					# eax <- mid
	cltq									# rax <- eax (mid) (8 bytes)
	leaq	0(,%rax,4), %rdx				# rdx <- 4*rax (mid)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (array a) (8 bytes)
	addq	%rdx, %rax						# rax <- rax + rdx (a+4*mid) (address)
	movl	(%rax), %eax					# eax <- rax (a[mid]) (int value- 4 bytes)
	cmpl	-32(%rbp), %eax					# Unsigned comparison between
											# eax (a[mid]) & item
	jge	.L18								# if a[mid] >=item, goto .L18
	movl	-4(%rbp), %eax					# eax <- mid
	addl	$1, %eax						# eax <- eax + 1 (mid+1)
	movl	%eax, -8(%rbp)					# bottom = mid+1
.L18:										#label: end of do-while loop
											# While condition
	movl	-4(%rbp), %eax					#eax <- mid
	cltq									# rax <- eax (32 to 64 bits)
	leaq	0(,%rax,4), %rdx				# rdx <- 4*rax (4*mid)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (a)
	addq	%rdx, %rax						# rax <- rax + rdx (a+4*mid) (q)
											# 4, as each element of a occupies
											# 4 bytes (since int type- l)
	movl	(%rax), %eax					# eax <- rax (a[mid]) (l)
	cmpl	-32(%rbp), %eax					# Unsigned comparison between
											# eax (a[mid]) & M[rbp-32] (item)
	je	.L19								# if item == a[mid] goto .L19
											# (outside of do-while loop)
	movl	-8(%rbp), %eax					# eax <- bottom
	cmpl	-12(%rbp), %eax					# Unsigned comparison between
											# bottom and top
	jle	.L20								# if bottom <= top, goto .L20 (start of loop)
.L19:										# Label: below do-while loop
	movl	-4(%rbp), %eax					# eax <- mid
											# mid is the return value of the function
	popq	%rbp							#  restore the stack base pointer
	.cfi_def_cfa 7, 8						# cfi directive
	ret										# return statement: return from the function
	.cfi_endproc							# cfi directive
.LFE2:										# label at end of function
	.size	bsearch, .-bsearch
	.globl	insert							# insert is global	
	.type	insert, @function				# insert is a function
insert:										# insert function starts:
.LFB3:										# label at beginning of function
	.cfi_startproc							# CFI Directive
	pushq	%rbp							# Save the old stack base pointer
	.cfi_def_cfa_offset 16					# CFI Directive
	.cfi_offset 6, -16						# CFI Directive
	movq	%rsp, %rbp						# set new stack pointer
	.cfi_def_cfa_register 6					# CFI Directive
	movq	%rdi, -24(%rbp)					# M[rbp-24] <- rdi (num)
											# 1st parameter of insert function (num array)
	movl	%esi, -28(%rbp)					# M[rbp-28] <- esi (n)
											# 2nd parameter of insert function (n)
	movl	%edx, -32(%rbp)					# M[rbp-32] <- edx (k)
											# 3rd parameter of insert function
											# (k-to be inserted in the array)
	movl	-28(%rbp), %eax					# eax <- n
	movl	%eax, -4(%rbp)					# M[rbp-4] <- eax (i=n)
	jmp	.L23								# Goto .L23 (for loop condition)
.L25:										# For loop body
	movl	-4(%rbp), %eax					# eax <- i
	cltq									# eax <- rax (4 to 8 bytes)
	addq	$1, %rax						# rax <- rax + 1 (i+1)
	leaq	0(,%rax,4), %rdx				# rdx <- 4*rax (4*(i+1))
	movq	-24(%rbp), %rax					# rax <- num (8 bytes)
											# address of 1st element of num
	addq	%rax, %rdx						# rdx <- rdx + rax (num + 4*(i+1))
	movl	-4(%rbp), %eax					# eax <- i
	cltq									# rax <- eax (i)
	leaq	0(,%rax,4), %rcx				# rcx <- 4*rax (4*i)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num)
	addq	%rcx, %rax						# rax <- rax + rcx (num + 4*i) (8 bytes)
	movl	(%rax), %eax					# eax <- rax (num[i])
	movl	%eax, (%rdx)					# rdx <- eax
											# (num[i+1] = num[i])
											# the address pointed by rdx will store eax (num[i])
	subl	$1, -4(%rbp)					# M[rbp-4] <- M[rbp-4]-1
											# i=i-1 (i--) (decrement of loop var)
.L23:										# For loop condition check
	cmpl	$0, -4(%rbp)					# Unsigned comparison between
											# M[rbp-4] (i) & 0 (zero)
	js	.L24								# if i < 0, goto .L24 (outside for loop)
	movl	-4(%rbp), %eax					# eax <- i (4 bytes)
	cltq									# rax <- eax (4 to 8 bytes)
	leaq	0(,%rax,4), %rdx				# rdx <- 4*rax (4*i)
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num) (4 bytes (address))
	addq	%rdx, %rax						# rax <- rax + rdx (num + 4*i)
	movl	(%rax), %eax					# eax <- rax (num[i])
	cmpl	-32(%rbp), %eax					# Unsigned comparison between
											# eax (num[i]) & k
	jg	.L25								# if num[i] > k, goto .L25  (inside for loop)
.L24:										# Label: below for loop statement
	movl	-4(%rbp), %eax					# eax <- i
	cltq									# rax <- eax (i)
	addq	$1, %rax						# rax <- rax + 1 (i+1)
	leaq	0(,%rax,4), %rdx				# rdx <- (4*rax) (4*(i+1))
	movq	-24(%rbp), %rax					# rax <- M[rbp-24] (num)
	addq	%rax, %rdx						# rdx <- rdx+rax (num+4*(i+1))
	movl	-32(%rbp), %eax					# eax <- M[rbp-32] (k-to be inserted)
	movl	%eax, (%rdx)					# rdx <- eax
											# (num[i+1] = k)
	movl	-4(%rbp), %eax					# eax <- i
	addl	$1, %eax						# eax <- eax + 1 (= i+1)
											# return value of the function is (i+1)
	popq	%rbp							# restore the stack base pointer
	.cfi_def_cfa 7, 8						# CFI Directive
	ret										# return statement: return from the function
	.cfi_endproc							# CFI Directive
.LFE3:										# label referring the end of a function
	.size	insert, .-insert
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
