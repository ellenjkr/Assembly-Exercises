# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 01
# Grupo: - Ellen Junker
#        - Mateus da Silva Francelino 




# VARIAVEIS:
# s0 -> numero
# s1 -> escolhaOperacao
# s2 -> resultado
# s3 -> soma
# s4 -> resto

# t0 -> divisor = 2
# t1 -> auxiliar





.data
  Digite: .asciiz "informe um numero maior que zero\n"
  Escolha: .asciiz "\n\n 0 para sair do programa\n 1 para resto de divisão por 2\n 2 para divisão por 2\n"
  ErroEntrada: .asciiz "Valor invalido, tente novamente\n"
  Resto: .asciiz "\n Resto da divisao:"
  Divisao: .asciiz "\n Divisao: "
  
.text	
	j main # Pula para o main
	
	insereNumero:
		addi $s0, $zero, 0 # Inicializa escolha = 0
		
		while:
			bgtz $s0, escolheOperacao # bgtz(Branch if greater than zero) - Se o valor for maior que zero vai sair do loop
			
			li $v0,4 # Informa ao computador que uma string/texto está sendo impresso
			# Registrador v0 retorna uma informação, o li carrega imediatamente uma posição disponível
			la $a0,Digite # Carrega o endereço no registrador de argumentos 
			syscall # Chamada do sistema
	
			#Escolha do usuário: 
			li $v0,5 # 5 corresponde aos inteiros
			syscall
	
			# Guarda o numero introduzido
			move $s0,$v0
			
			j while # Instrução jump, pula para o while novamente
		
			
	escolheOperacao:
		
		
		addi $s1, $zero, 0 # Inicializa operacao = 0
		
		while2:
			li $v0, 4 # Imprimir string
			la $a0, Escolha #Imprimir o texto Escolha
			syscall
	
			#Escolha do usuário: 
			li $v0,5 # 5 corresponde aos inteiros
			syscall
	
			# Guarda o numero introduzido
			move $s1,$v0
			
			bltz $s1, while2 # Se o valor for menor que zero executa o while novamente
			bgt $s1, 2, while2 # Se o valor for maior que 2 executa o while novamente
			
			j divideDois # Caso não satisfaça às condições acima ele sai do while
		
			
	divideDois:
		add $s2, $zero, 0 # resultado
		add $t0, $zero, 2 # divisor
		add $s3, $zero, 0 # soma = 0
		add $t1, $zero, $s0 # variavel para auxiliar na condiçao, aux = numero
		sub $t1, $t1, 1 # aux = aux - 1
		
		while3:
			beq $s3, $t1, executaOperacao # se a soma for igual ao auxiliar (valor menos 1) ele sai do loop
			beq $s3, $s0, executaOperacao # se a soma for igual ao valor ele sai do loop
			
			add $s3, $s3, $t0 # soma = soma + divisor
			add $s2, $s2, 1 # aumenta o valor do resultado
		
			j while3
		
	executaOperacao:
		beq $s1, 0, exit # Se a escolha de operação for zero ele sai do programa
		beq $s1, 1, resto # Se for 1 ele imprime o resto
		beq $s1, 2, divisao # Se for 2 ele imprime o resultado da divisão
	
	resto:
		add $s4, $zero, $s0 # resto = valor
		sub $s4, $s4, $s3 # resto = resto - soma
		
		li $v0,4
		la $a0,Resto
		syscall
		
		li $v0,1
		move $a0,$s4
		syscall
		
		j escolheOperacao # Volta para o loop de escolha de operação
		
	divisao:
		li $v0,4
		la $a0,Divisao
		syscall
		
		li $v0,1
		move $a0,$s2 # Imprime o valor de s2 (resultado da divisão) 
		syscall
		j escolheOperacao
			
	main:
		j insereNumero # Pula para insereNumero
		exit:
	
	
		
  	 
