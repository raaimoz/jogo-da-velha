algoritmo "JogoDaVelha"
// Tabuleiro grande 3x3: cada casa e uma partida completa de jogo da velha.
// Ao fim de cada partida a casa recebe X, O ou V (velha/empate).
// O jogador que comeca alterna a cada rodada.

var
   grande: vetor[1..3,1..3] de caractere
   pq: vetor[1..3,1..3] de caractere
   inicial, jogador, resultado: caractere
   gl, gc, i, j, lin, col, jogadas, rodada, vitX, vitO, vitV: inteiro
   acabou, valido, linhaX, linhaO: logico

// Verifica se o jogador p completou uma linha no tabuleiro PEQUENO
funcao ganhou(p: caractere): logico
var
   k: inteiro
inicio
   para k de 1 ate 3 faca
      se (pq[k,1] = p) e (pq[k,2] = p) e (pq[k,3] = p) entao
         retorne verdadeiro
      fimse
      se (pq[1,k] = p) e (pq[2,k] = p) e (pq[3,k] = p) entao
         retorne verdadeiro
      fimse
   fimpara
   se (pq[1,1] = p) e (pq[2,2] = p) e (pq[3,3] = p) entao
      retorne verdadeiro
   fimse
   se (pq[1,3] = p) e (pq[2,2] = p) e (pq[3,1] = p) entao
      retorne verdadeiro
   fimse
   retorne falso
fimfuncao

// Verifica se o jogador p completou uma linha no tabuleiro GRANDE
funcao ganhouGrande(p: caractere): logico
var
   k: inteiro
inicio
   para k de 1 ate 3 faca
      se (grande[k,1] = p) e (grande[k,2] = p) e (grande[k,3] = p) entao
         retorne verdadeiro
      fimse
      se (grande[1,k] = p) e (grande[2,k] = p) e (grande[3,k] = p) entao
         retorne verdadeiro
      fimse
   fimpara
   se (grande[1,1] = p) e (grande[2,2] = p) e (grande[3,3] = p) entao
      retorne verdadeiro
   fimse
   se (grande[1,3] = p) e (grande[2,2] = p) e (grande[3,1] = p) entao
      retorne verdadeiro
   fimse
   retorne falso
fimfuncao

procedimento mostraPequeno
var
   k: inteiro
inicio
   escreval("")
   para k de 1 ate 3 faca
      escreval("   ", pq[k,1], " | ", pq[k,2], " | ", pq[k,3])
      se k < 3 entao
         escreval("  ---+---+---")
      fimse
   fimpara
   escreval("")
fimprocedimento

procedimento mostraGrande
var
   k: inteiro
inicio
   escreval("")
   escreval("=== TABULEIRO GERAL (V = velha) ===")
   para k de 1 ate 3 faca
      escreval("   ", grande[k,1], " | ", grande[k,2], " | ", grande[k,3])
      se k < 3 entao
         escreval("  ---+---+---")
      fimse
   fimpara
   escreval("")
fimprocedimento

inicio
   // zera o tabuleiro grande e os contadores
   para i de 1 ate 3 faca
      para j de 1 ate 3 faca
         grande[i,j] <- " "
      fimpara
   fimpara
   vitX <- 0
   vitO <- 0
   vitV <- 0
   rodada <- 0

   escreval("===== JOGO DA VELHA - 9 RODADAS =====")
   repita
      escreva("Quem comeca a 1a rodada (X ou O)? ")
      leia(inicial)
      se inicial = "x" entao
         inicial <- "X"
      fimse
      se inicial = "o" entao
         inicial <- "O"
      fimse
   ate (inicial = "X") ou (inicial = "O")

   para gl de 1 ate 3 faca
      para gc de 1 ate 3 faca
         rodada <- rodada + 1
         escreval("")
         escreval("##### RODADA ", rodada, " de 9 (casa ", gl, ",", gc, " do tabuleiro geral) #####")
         escreval("Comeca: ", inicial)

         // prepara o tabuleiro pequeno
         para i de 1 ate 3 faca
            para j de 1 ate 3 faca
               pq[i,j] <- " "
            fimpara
         fimpara
         jogador <- inicial
         jogadas <- 0
         resultado <- " "
         acabou <- falso

         enquanto nao acabou faca
            mostraPequeno
            escreval("Vez de ", jogador)
            repita
               escreva("Linha (1-3): ")
               leia(lin)
               escreva("Coluna (1-3): ")
               leia(col)
               valido <- (lin >= 1) e (lin <= 3) e (col >= 1) e (col <= 3)
               se valido entao
                  se pq[lin,col] <> " " entao
                     valido <- falso
                     escreval("Casa ocupada! Escolha outra.")
                  fimse
               senao
                  escreval("Posicao invalida! Use valores de 1 a 3.")
               fimse
            ate valido

            pq[lin,col] <- jogador
            jogadas <- jogadas + 1

            se ganhou(jogador) entao
               resultado <- jogador
               acabou <- verdadeiro
            senao
               se jogadas = 9 entao
                  resultado <- "V"
                  acabou <- verdadeiro
               senao
                  se jogador = "X" entao
                     jogador <- "O"
                  senao
                     jogador <- "X"
                  fimse
               fimse
            fimse
         fimenquanto

         mostraPequeno
         se resultado = "V" entao
            escreval("Rodada ", rodada, ": VELHA (empate)!")
            vitV <- vitV + 1
         senao
            escreval("Rodada ", rodada, ": vencedor = ", resultado)
            se resultado = "X" entao
               vitX <- vitX + 1
            senao
               vitO <- vitO + 1
            fimse
         fimse

         // preenche a casa do tabuleiro geral
         grande[gl,gc] <- resultado
         mostraGrande

         // alterna quem comeca a proxima rodada
         se inicial = "X" entao
            inicial <- "O"
         senao
            inicial <- "X"
         fimse
      fimpara
   fimpara

   // ===== RESULTADO FINAL =====
   escreval("")
   escreval("========== RESULTADO FINAL ==========")
   mostraGrande
   escreval("Rodadas vencidas por X: ", vitX)
   escreval("Rodadas vencidas por O: ", vitO)
   escreval("Rodadas empatadas (velha): ", vitV)
   escreval("")

   linhaX <- ganhouGrande("X")
   linhaO <- ganhouGrande("O")

   se linhaX e nao linhaO entao
      escreval("VENCEDOR DO JOGO: X (completou uma linha no tabuleiro geral)")
   senao
      se linhaO e nao linhaX entao
         escreval("VENCEDOR DO JOGO: O (completou uma linha no tabuleiro geral)")
      senao
         se linhaX e linhaO entao
            escreval("Os dois completaram linhas! Desempate por rodadas vencidas:")
            se vitX > vitO entao
               escreval("VENCEDOR DO JOGO: X")
            senao
               se vitO > vitX entao
                  escreval("VENCEDOR DO JOGO: O")
               senao
                  escreval("VELHA! Empate final.")
               fimse
            fimse
         senao
            escreval("VELHA! Ninguem completou uma linha no tabuleiro geral.")
         fimse
      fimse
   fimse
fimalgoritmo