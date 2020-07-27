# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 03 – Programação de Procedimentos
# Programa 02
# Grupo: - Ellen Junker
#        - Mateus da Silva Francelino 

.data
  InformaPrimeiro: .asciiz "Informe um numero: "
  InformaSegundo: .asciiz "Informe um segundo numero: "
  novaLinha: .asciiz "\n"
  ImprimeResultado: .asciiz "Maximo divisor comum: "
  
.text	

	main: 
		jal insereNumero # Chama o procedimento para inserção dos valores
		jal mdc # Chama o procedimento para cálculo do MDC (máximo divisor comum)
		jal imprimeResultado # Chama o procedimento para imprimir o resultado
    		j end # Chama o procedimento para terminar o programa
		
	end: 
		li $v0, 10 # Finaliza o programa
		syscall
	
	insereNumero:
			
		li $v0, 4 # 4 corresponde a string/texto
		la $a0, InformaPrimeiro # Texto para inserir o primeiro número 
		syscall 
		
		li $v0,5 # Escolha do usuário (5 corresponde aos inteiros)
		syscall
		move $a1, $v0 # Valor armazenado no registrador de argumentos a1

		li $v0, 4
		la $a0, InformaSegundo # Texto para inserir o segundo número 
		syscall
		
		li $v0,5 # Escolha do usuário (5 corresponde aos inteiros)
		syscall
		move $a2, $v0 # Valor armazenado no registrador de argumentos a2

		jr $ra # Retorna para onde foi chamado
	
	
		
	mdc:
	        # a1 = x
	        # a2 = y
	        
		addi $sp, $sp, -12 # Reserva 3 posições na pilha
		sw $s0, 0 ($sp) # Insere a1 na pilha	
    		sw $s1, 4 ($sp) # Insere a2 na pilha
    		sw $ra, 8 ($sp) # Insere endereço de retorno na pilha
		
		move $s0, $a1 # s0 = x
		move $s1, $a2 # s1 = y
		
		beq $s0, $s1, return # Se x = y retorna e finaliza
		blt $s0, $s1, if # Se x < y -> if
		bgt $s0, $s1, else # Se x > y -> else
		
		jr $ra # Retorna para onde foi chamado
	
	 	
		if:
	 		sub $a2, $a2, $a1 # y = y -x
	 		jal mdc # return mdc(y-x, x) PARTE RECURSIVA
	 		j exitmdc # sai do programa quando o jr apontar para aqui
	 	
		else:
	 		sub $a1, $a1, $a2 # x = x -y
	 		jal  mdc # return mdc(y, x-y) PARTE RECURSIVA
	 		j exitmdc # sai do programa quando o jr apontar para aqui
	 	
		return:
			add $v1, $zero, $a1 # Armazena resposta no registrador de retorno v1
			j exitmdc # chama o procedimento para sair
		
		exitmdc:
			# Carrega valores da pilha
			lw $ra, 8($sp) 
			lw $s0, 4($sp)
			lw $s1, 0($sp)
			
			addi $sp, $sp, 12 # pop (3 posições)
			jr $ra # Retorna para onde foi chamado
	
	imprimeResultado:
		li $v0, 4 
		la $a0, ImprimeResultado # Texto para imprimir o resultado
		syscall
		
		add $a0, $v1, $zero # Imprime resultado armazenado no registrador de retorno
    		li $v0,1
    		syscall 
		
		jr $ra # Retorna para onde foi chamado
