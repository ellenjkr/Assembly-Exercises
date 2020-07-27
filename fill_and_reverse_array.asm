# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 02
# Grupo: - Ellen Junker
#        - Mateus da Silva Francelino 


# VARIÁVEIS:
# s0 -> array
# s1 -> tamanho

# t0 -> i (percorre o while)
# t1 -> cont (percorre o while)
# t2 -> valor do elemento
# t3 -> tamanho / 2
# t4 -> indiceFinal
# t5 -> indiceInicio
# t6 -> tempInicio
# t7 -> tempFinal


.data

Vetor: .word 0, 0, 0, 0, 0, 0, 0, 0
Tamanho: .asciiz "Digite um tamanho maior 1 e menor ou igual a 8\n"
Elemento1: .asciiz "Digite um valor para o elemento ["
Elemento2: .asciiz "]: "
Elemento3: .asciiz "\nElemento["
     
     
.text

	j main

	escolheTamanho:
 	
			
		li $v0,4 # Informa ao computador que uma string/texto está sendo impresso
		# Registrador v0 retorna uma informação, o li carrega imediatamente uma posição disponível
		la $a0,Tamanho # Carrega o endereço no registrador de argumentos 
		syscall # Chamada do sistema
	
		#Escolha do usuário: 
		li $v0,5 # 5 corresponde aos inteiros
		syscall
	
		# Guarda o numero introduzido
		move $s1,$v0
	
		blt $s1, 2, escolheTamanho # Se for menor que 2 repete o loop
		bgt $s1, 8, escolheTamanho # Se for maior que 8 repete o loop
	
		j preencheVetor	
		
	
	preencheVetor:
		add $t0, $zero, $s0 # i = 0 + endereço
		addi $t1, $zero, 0 # cont = 0
	
		while:
		
			li $v0, 4 
			la $a0, Elemento1 # Elemento[
			syscall
		
			li $v0,1
			move $a0,$t1 # posicao
			syscall
		
			li $v0, 4 
			la $a0, Elemento2  # ]: 
			syscall
		
			li $v0,5 # usuário insere o valor 
			syscall
			move $t2,$v0  # valor adicionado em t2
     		
     			sw  $t2, 0($t0) #adiciona valor ao vetor
     			
      			add $t0,$t0, 4 # i = i + 4
      			add $t1, $t1, 1 # cont++
		
			blt $t1, $s1, while # Enquanto o contador for menor que o tamanho do array
			j divide

	divide:
		srl $t3,$s1,1 # t3 -> tamanho / 2
		j troca

	troca:
		add $t0, $zero, 0 # i = 0
	
		#TAMANHO VEZES 4
		add $t4, $s1, $s1       # t3 = indiceFinal
      		add $t4, $t4, $t4
      		
      		
      		sub $t4, $t4, 4 # diminui 4 do valor do indiceFinal
      		add $t4, $t4,$s0 # adiciona a posição do vetor ao indiceFinal
      	
        	add $t5, $zero, 0 # Indice de inicio
		add $t5, $t5, $s0 # adiciona a posição do vetor ao indiceInicio
      	
		while2:  
		
			lw $t6, 0($t5) # t5 = tempInicio
      			lw $t7, 0($t4) # t6 = tempFinal
      			
      			sw  $t6, 0($t4)         #adiciona tempInicio no final
     			sw  $t7, 0($t5)         #adiciona tempFinal no inicio

			sub $t4, $t4, 4 # diminui 4 do indiceFinal
			add $t5,$t5, 4 # aumenta 4 do indiceInicio
			
			add $t0, $t0, 1 # i++
			
			blt $t0, $t3, while2 # executa enquanto i for menor que o tamanho / 2
			j imprimeVetor
		

	imprimeVetor:
		add $t0, $zero, 0 # i = 0
        	add $t5, $zero, $s0 # indiceInicio
        	add $t6, $zero, 0 # tempInicio = 0
		while3:
			li $v0, 4 
			la $a0, Elemento3 # Elemento[
			syscall
		
			li $v0,1
			move $a0,$t0 # Posição do elemento
			syscall
		
			li $v0, 4 
			la $a0, Elemento2 # ]: 
			syscall
		
			lw $t6, 0($t5) # Carrega o elemento em t6
			li $v0,1
			move $a0,$t6 # Imprime o elemento
			syscall 
			
			add $t5,$t5, 4 # Adiciona 4 ao endereço
			add $t0, $t0, 1 # i++
			
			
			blt $t0, $s1, while3 # enquanto 1 for menor que o tamanho
			j exit
	
	main:

     		la   $s0, Vetor     

     		j escolheTamanho

     		exit:
     
     
