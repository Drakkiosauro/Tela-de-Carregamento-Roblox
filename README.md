# Loading Screen + Select team Roblox

Uma tela de carregamento para Roblox que exibe progresso de pré-carregamento de ativos e, ao finalizar, abre uma interface para seleção de time.

## O que faz
- Mostra progresso de carregamento (barra e porcentagem).
- Exibe o nome do ativo sendo carregado.
- Apresenta um botão para avançar quando o carregamento termina.
- Mostra cards de seleção de time e envia a escolha para o servidor via RemoteEvent.

## Principais características
- LocalScript pronto para uso
- Interface construída dinamicamente em runtime (sem depender de objetos pré-criados no Explorer).
- Animações simples usando TweenService.
- Contagem de jogadores por time exibida em tempo real.

## Instalação
1. Crie um LocalScript (em `ReplicatedFirst`).
2. Cole o conteúdo do script de loading dentro do LocalScript.
3. Crie um Script em `ServerScriptService` com o nome qualquer e copie o Script e cole dentro do Script criado.
4. Verifique se as `Teams` existem em `Teams` com os nomes que serão exibidos.

## Uso básico
- Execute o jogo no Studio (Play) para testar.
- O script pré-carregará ativos e, após terminar, permitirá avançar para a seleção de time.
- Ao escolher um time e clicar em "ENTRAR NA PARTIDA", o evento remoto será disparado para o servidor com o nome do time.

## Licença
Licenciado sob MIT. Veja o arquivo `LICENSE` para os termos completos.
