	.data
mes1:	.asciz	"Hello world\n"
mes2:	.asciz 	"RISC-V asm\n"
	.text	
main:	li a7, 4
	la a0, mes1
	ecall
	la a0, mes2
	ecall