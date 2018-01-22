	.file "zsvjmp.s"
	.abiversion 2
	.section ".text"
	.align 2
	.globl zsvjmp_
	.type zsvjmp_, @function

zsvjmp_:
	# r3 = jmpbuf, r4 = &status
	li 9,0		# r9 = 0
	std 9,0(4)	# *status = r9
	std 4,0(3)	# buf[0] = status (as arg)
	addi 3,3,8	# &buf[1] --> 1st arg for sigsetjmp (Buf)
	li 4,0		# 0 --> 2nd arg for sigsetjmp (savesigs)  
	mflr 14		# save LR in r14 (r14 is saved in jmpbuf)
	bl __sigsetjmp
	nop
	mtlr 14		# restore LR

	.size zsvjmp_,.-zsvjmp_
	.section .note.GNU-stack,"",@progbits
