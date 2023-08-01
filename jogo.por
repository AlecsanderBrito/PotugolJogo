programa
{
	inclua biblioteca Util --> u // biblioteca Util, utilizado para temporizar e sortear
	inclua biblioteca Teclado --> t // biblioteca Teclado, utilizado para a movimentação do jogador
	inclua biblioteca Graficos --> g // biblioteca Graficos, utilizado para iniciar e exibir o modo gráfico

	// titulo
	cadeia janelaTitulo[2][2] = {{"Jogo", "Plataforma"}, 
							{"2D", "Interativo"}} // título do jogo

	// paleta de cores
	inteiro preto = g.criar_cor(0, 0, 0), // preto
		cinza = g.criar_cor(158, 157, 157), // cinza
		azul = g.criar_cor(0, 82, 117), // azul
		amarelo = g.criar_cor(185, 177, 0), // amarelo
		vermelho = g.criar_cor(142, 0, 0), // vermelho
		laranja = g.criar_cor(219, 67, 2) // laranja
	
	// janela
	inteiro janelaX = 1024, // largura da janela
		janelaY = 215 // altura da janela

	// jogador
	inteiro jogadorX = 100, // posição X do jogador
		jogadorY = 143, // posiçõo Y do jogador
		jogadorV = 1, // velocidade do jogador
		jogadorP = 1, // pulo do jogador
		jogadorC = 0, // cor do jogador
		grav = 1 // gravidade

	// textos1
	cadeia fim = "FIM!" // exibir ao finalizar a fase

	// pontos
	inteiro pts[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, // possíveis valores de pontuação
		pts_random = u.sorteia(0, 9), // sortear valor do vetor
		pts_final = pts_random // pontuação final

	// limitador de frames
	inteiro fps = 7

	funcao inicio() // Exibir as princiais funções do programa
	{
		cor_jogador()
		janela()
		
		enquanto(verdadeiro) 
		{
			controles()
			conteudo()
		}
	}

	funcao cor_jogador() // Escolher a cor do jogador
	{
		inteiro opcao // váriavel responsável pela escolha do usuário

		// texto para auxiliar o usuário
		escreva("Escolha a cor do seu personagem:\n")
		escreva("1. Vermelho\n")
		escreva("2. Azul\n")
		escreva("> ")
		leia(opcao) // armazenar a escolha do usuário

		// gerenciar a escolha do usuário
		escolha(opcao)
		{
			// iniciar o programa
			caso 1:
				jogadorC = vermelho
			pare

			// encerrar execução
			caso 2:
				jogadorC = azul
			pare

			// caso seja inserido qualquer valor diferente, encerrar a execução
			caso contrario:
				g.renderizar()
				g.iniciar_modo_grafico(verdadeiro)
				sair()
		}
	}
	
	funcao janela() // Declarar janela e seus parametros para que será exibido
	{
		// sortear nome
		inteiro sorteio1 = u.sorteia(0, 1), // sortear o valor da matriz
			sorteio2 = u.sorteia(0, 1) // sortear o valor da matriz
			
		cadeia titulo = janelaTitulo[0][sorteio2] + " " + janelaTitulo[1][sorteio1] // exibir o nome sorteado na janela

		// declaração e configuração da janela
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(janelaX, janelaY)
		g.definir_titulo_janela(titulo)
	}

	funcao conteudo() // Conteúdo principal do programa que será exibido
	{
		// condição para encerrar a execução ao clicar na tecla ESC
		enquanto(nao t.tecla_pressionada(t.TECLA_ESC))
		{
			controles() // controles do jogador
			u.aguarde(fps) // limitador de frames
			gravidade() // gravidade
			fase() // fase
			jogador() // jogador
			colisao() // colisão
			colisao_obs() // colisão dos obstáculos
			g.renderizar() // exibe o conteúdo do jogo
		}

		sair() // encerrar modo gráfico
	}

	funcao fase() // Única e principal fase
	{
		// mudar fundo
		g.definir_cor(preto) // definir cor de fundo
		g.limpar() // limpar o conteúdo anterior
		
		// base
		g.definir_cor(cinza)
		g.desenhar_retangulo(24, 165, 974, 37, falso, verdadeiro) // chão
		g.desenhar_retangulo(24, 15, 974, 37, falso, verdadeiro) // teto
		g.desenhar_retangulo(24, 52, 37, 114, falso, verdadeiro) // parede esquerda

		// parede direita
		g.definir_cor(amarelo) // cor amarela da parede direita
		g.desenhar_retangulo(961, 52, 37, 114, falso, verdadeiro) // parametros da parede direita
		g.definir_cor(vermelho) // cor da fonte
		g.definir_tamanho_texto(12.0) // tamanho da fonte
		g.definir_estilo_texto(falso, verdadeiro, falso) // estilo da fonte
		g.desenhar_texto(965, 105, fim) // exibir texto

		// obstáculos
		g.definir_cor(laranja) // definir a cor do obstáculo
		g.desenhar_retangulo(61, 115, 88, 22, falso, verdadeiro) // obstáculo 1 c
		g.desenhar_retangulo(180, 143, 22, 22, falso, verdadeiro) // obstáculo 2 b
		g.desenhar_retangulo(235, 115, 88, 22, falso, verdadeiro) // obstáculo 3 c
		g.desenhar_retangulo(355, 143, 22, 22, falso, verdadeiro) // obstáculo 4 b
		g.desenhar_retangulo(420, 115, 88, 22, falso, verdadeiro) // obstáculo 5 c
		g.desenhar_retangulo(546, 143, 22, 22, falso, verdadeiro) // obstáculo 6 b
		g.desenhar_retangulo(615, 143, 22, 22, falso, verdadeiro) // obstáculo 7 b
		g.desenhar_retangulo(680, 143, 22, 22, falso, verdadeiro) // obstáculo 8 b
		g.desenhar_retangulo(740, 115, 88, 22, falso, verdadeiro) // obstáculo 9 c
		g.desenhar_retangulo(870, 143, 22, 22, falso, verdadeiro) // obstáculo 10 b
	}

	funcao colisao() // Colisão da fase principal
	{
		// chao
		se(jogadorY >= 143)
		{
			jogadorY = 143
			jogadorP = 15
		}

		// teto
		se(jogadorY <= 52)
		{
			jogadorY = 52
		}

		// parede esquerda
		se(jogadorX <= 61)
		{
			jogadorX = 61
		}

		// parede direita
		se(jogadorX >= 941)
		{
			tela_pontuacao()
		}
	}
	
	funcao colisao_obs() // Colisão dos obstáculos
	{
		// se(jogadorXY >= xy_obs - xy_jogador e jogadorXY <= xy_obs + largura_ou_altura_obs)
		 
		// obstáculo 1 c
		se((jogadorX >= 39 e jogadorX <= 149) e (jogadorY >= 93 e jogadorY <= 137))
		{
		    tela_fim_de_jogo()
		}

		// onstáculo 2 b
		se((jogadorX >= 158 e jogadorX <= 202) e (jogadorY >= 121 e jogadorY <= 165))
		{
		    tela_fim_de_jogo()
		}

		// obstáculo 3 c
		se((jogadorX >= 213 e jogadorX <= 323) e (jogadorY >= 93 e jogadorY <= 137))
		{
		    tela_fim_de_jogo()
		}

		// onstáculo 4 b
		se((jogadorX >= 333 e jogadorX <= 377) e (jogadorY >= 121 e jogadorY <= 165))
		{
		    tela_fim_de_jogo()
		}

		// obstáculo 5 c
		se((jogadorX >= 398 e jogadorX <= 508) e (jogadorY >= 93 e jogadorY <= 137))
		{
		    tela_fim_de_jogo()
		}

		// onstáculo 6 b
		se((jogadorX >= 524 e jogadorX <= 568) e (jogadorY >= 121 e jogadorY <= 165))
		{
		    tela_fim_de_jogo()
		}

		// onstáculo 7 b
		se((jogadorX >= 593 e jogadorX <= 637) e (jogadorY >= 121 e jogadorY <= 165))
		{
		    tela_fim_de_jogo()
		}

		// onstáculo 8 b
		se((jogadorX >= 658 e jogadorX <= 702) e (jogadorY >= 121 e jogadorY <= 165))
		{
		    tela_fim_de_jogo()
		}
	
		// obstáculo 9 c
		se((jogadorX >= 718 e jogadorX <= 828) e (jogadorY >= 93 e jogadorY <= 137))
		{
		    tela_fim_de_jogo()
		}

		// onstáculo 10 b
		se((jogadorX >= 848 e jogadorX <= 892) e (jogadorY >= 121 e jogadorY <= 165))
		{
		    tela_fim_de_jogo()
		}
	}

	funcao inteiro pontos() // Sistema de pontuação ao coletar o orbe azul
	{
		retorne(pts[pts_final]) // pontuação do jogador
	}

	funcao tela_pontuacao() // Tela de pontuação ao finalizar o jogo
	{
		enquanto(nao t.tecla_pressionada(t.TECLA_ESPACO) e nao t.tecla_pressionada(t.TECLA_ESC)) 
		{
			// cor do fundo
			g.definir_cor(preto)
	
			// limpar a tela
			g.limpar()
	
			// especificações do texto que será exibido
			g.definir_cor(amarelo) // cor do texto
			g.definir_tamanho_texto(32.0) // tamanha da fonte
			g.definir_estilo_texto(verdadeiro, verdadeiro, falso) // estilo da fonte

			// texto que será exibido
			g.desenhar_texto(janelaX - 985, 50, "Aperte a tecla ESC ou ESPAÇO para encerrar o jogo!")
			g.desenhar_texto(janelaX - 775, 150, "Sua pontuação foi de " + pontos() + " pontos")

			// exibir conteúdo
			g.renderizar()
		}

		sair() // encerrar modo gráfico
	}

	funcao tela_fim_de_jogo() // Tela de fim de jogo
	{
		//s.reproduzir_som(som, falso)
		
		enquanto(nao t.tecla_pressionada(t.TECLA_ESPACO) e nao t.tecla_pressionada(t.TECLA_ESC)) 
		{
			// cor do fundo
			g.definir_cor(preto)
	
			// especificações do texto que será exibido
			g.definir_cor(vermelho) // cor do texto
			g.definir_tamanho_texto(32.0) // tamanha da fonte
			g.definir_estilo_texto(verdadeiro, verdadeiro, falso) // estilo da fonte

			// texto que será exibido
			g.desenhar_texto(janelaX - 930, 50, "Aperte a tecla ESC ou ESPAÇO para encerrar!")
			g.desenhar_texto(janelaX - 630, 150, "Você perdeu!")

			// exibir conteúdo
			g.renderizar()
		}
			
		sair() // encerrar modo gráfico
	}

	funcao gravidade() // Gravidade do jogador
	{
		jogadorY += grav // grav aplicada no jogador
	}

	funcao jogador() // Declaração e parametros do jogador
	{
		// especificações do jogador
		g.definir_cor(jogadorC) // cor do jogador
		g.desenhar_retangulo(jogadorX, jogadorY, 22, 22, falso, verdadeiro) // formato do jogador
	}

	funcao controles() // Controles do jogador
	{
		// mover para esquerda utilizando a tecla A e seta esquerda
		se (t.tecla_pressionada(t.TECLA_A) ou t.tecla_pressionada(t.TECLA_SETA_ESQUERDA))
		{
			jogadorX -= jogadorV
		}

		// mover para direita utilizando a tecla D e seta direita
		se (t.tecla_pressionada(t.TECLA_D) ou t.tecla_pressionada(t.TECLA_SETA_DIREITA))
		{
			jogadorX += jogadorV
		}

		// pular utilizando a tecla W e  e seta para cima
		se (t.tecla_pressionada(t.TECLA_W) ou t.tecla_pressionada(t.TECLA_SETA_ACIMA))
		{
			jogadorY -= jogadorP
			jogadorP -= 1

			se(jogadorP == 0)
			{
				jogadorP = 0
			}
		}

		// mover para baixo utilizando a tecla S para efetuar testes
		se (t.tecla_pressionada(t.TECLA_S) ou t.tecla_pressionada(t.TECLA_SETA_ABAIXO))
		{
			jogadorY += jogadorV
			jogadorP += 1
		}
	}

	funcao sair() // Encerrar execução
	{
		g.encerrar_modo_grafico() // encerrar o modo gráfico
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1237; 
 * @DOBRAMENTO-CODIGO = [41, 53, 85, 117, 151, 179, 244, 275, 300, 305, 312, 346];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */