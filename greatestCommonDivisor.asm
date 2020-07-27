# Disciplina: Arquitetura e Organiza��o de Processadores
# Atividade: Avalia��o 03 � Programa��o de Procedimentos
# Programa 01
# Grupo: - Ellen Junker
#        - Mateus da Silva Francelino 

.data
  InformaPrimeiro: .asciiz "Informe um numero: "
  InformaSegundo: .asciiz "Informe um segundo numero: "
  ImprimeResultado: .asciiz "Maximo divisor comum: "
  
.text	

	main: 
		jal insereNumero # Chama o procedimento para inser��o dos valores
		jal mdc # Chama o procedimento para c�lculo do MDC (m�ximo divisor comum)
		jal imprimeResultado # Chama o procedimento para imprimir o resultado
		
		
	li $v0, 10 # Termina o programa
	syscall
	
	insereNumero:
			
		li $v0, 4 # 4 corresponde a string/texto
		la $a0, InformaPrimeiro # Texto para inserir o primeiro n�mero 
		syscall 
	
		
		li $v0,5 # Escolha do usu�rio (5 corresponde aos inteiros)
		syscall
		move $a1, $v0 # Valor armazenado no registrador de argumentos a1
		
		li $v0, 4
		la $a0, InformaSegundo # Texto para inserir o segundo n�mero 
		syscall
	
		li $v0,5 # Escolha do usu�rio (5 corresponde aos inteiros)
		syscall
		move $a2, $v0 # Valor armazenado no registrador de argumentos a2
		
		jr $ra # Retorna para onde foi chamado
	
	
		
	mdc:
		# Primeiro argumento armazenado em t0, ser� alterado pelo procedimento ao finalizar a opera��o
		add $t0, $zero, $a1 # x
		
		# Segundo argumento armazenado em s0, n�o ser� alterado pelo procedimento ao finalizar a opera��o
		add $s0, $zero, $a2 # y		
		
		addi $sp, $sp, -4 # push (reserva uma posi��o na pilha)
		sw $s0, 0($sp) # Insere s0 na pilha
		
		while:
			beq  $t0,$s0, sair # Se x = y sai do while
			blt  $t0, $s0, if # Se x < y -> if
			bgt $t0, $s0, else # Se x > y -> else
			
	 	if:
	 		sub $s0, $s0, $t0 # y = y - x
	 		j while # Retorna ao while
	 		
	 	else:
	 		sub $t0, $t0, $s0 # x = x - y
	 		j while # Retirna ao while
	 		
		sair:
			lw $s0, 0($sp) # Carrega o valor de s0 armazenado na pilha
			addi $sp, $sp, 4 # pop (retira uma posi��o da pilha)
		
			jr $ra # Retorna para onde foi chamado
			
	imprimeResultado:
		li $v0, 4 
		la $a0, ImprimeResultado # Texto para imprimir o resultado
		syscall
		
		li $v0, 1 
		move $a0, $t0 # Imprime o valor armazenado em t0 (o resultado)
		syscall
		
		jr $ra # Retorna para onde foi chamado
		
		
		
		
