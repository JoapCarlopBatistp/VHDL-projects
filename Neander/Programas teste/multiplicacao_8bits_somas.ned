org 0

inicio:
	LDA primeiro_fator
	STA copia

loop_multiplicacao:
	LDA primeiro_fator
	JZ fim_multiplicacao
	NOT 
	ADD um
	NOT
	STA primeiro_fator
somas_sucessivas:
	LDA produto_menos_significativo
	JN caso_negativo
	ADD segundo_fator
	JZ caso_carry
	STA produto_menos_significativo
	JMP loop_multiplicacao
caso_negativo:
	ADD segundo_fator
	STA produto_menos_significativo
	JN loop_multiplicacao
	JMP caso_carry
caso_carry:
	STA produto_menos_significativo
	LDA produto_mais_significativo
	ADD um
	STA produto_mais_significativo
	JMP loop_multiplicacao
fim_multiplicacao:
	LDA copia
	STA primeiro_fator
	HLT


org 128

primeiro_fator: db 100
segundo_fator: db 3
produto_menos_significativo: db 0
produto_mais_significativo: db 0
copia: db 0

um: db 1