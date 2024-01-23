# Aplicativo mobile para filtrar dados do Diário Oficial de Recife

- Carlos Eduardo Santana Nascimento 202100011252
- Max Antônio Lima Barreto 202100011744

## Telas

  Para montar o aplicativo foram feitas 4 telas, dentre elas temos:

### - Tela principal

  A tela principal tem o escopo padrão que também é usado na tela de resultados e de favoritos.
Ela é formada por um Scaffold, onde no AppBar é mostrado o título da tela e na bottomNavigationBar é mostrado
um texto escrito Diário Oficial de Recife na cor vermelha.

  No body da tela principal é exposto as barras de pesquisa, temos a barra de pesquisa por nome que é formada por
um TextField simples, a barra de pesquisa por edição que também é um TextField com o keyboardType sendo numérico,
e 3 barras de pesquisa de data, sendo uma pra data exata e as outras para um intervalo de data inicial e data final
o campo das datas também é formado por um TextField, porém para selecionar a data foi utilizado um showDatePicker
que permite ao usuário que a seleção seja feita clicando no calendário, além disso os campos de data inicial e final
foram dispostos dentro de um Widget Row para permitir que eles apareçam um do lado do outro. 

  Abaixo dos campos de pesquisa temos uma Row com dois ElevatedButtons dentro, que são os botões de pesquisa e de favoritos
o botão de pesquisa redireciona para a tela de resultados de consulta e o botão de favoritos para a tela de diários salvos,
o redirecionamento é feito por meio do Navigator.push e os dados são passados para a tela por meio de um array passado como argumento
(porém isso provavelmente será mudado ao longo do desenvolvimento do aplicativo).

### - Tela de resultados

  A tela de resultados segue o mesmo molde que a tela principal, um Scaffold, AppBar e bottomNavigationBar iguais a tela principal. 
Porém no body temos a listagem dos diários que foram encontrados na pesquisa.

  No body temos um ListView para listar todos os diários, cada diário foi modelado em um card customizado. O card foi criado
com um Material e InkWell para permitir ações ao clicar no card, dentro do InkWell foi montado o card utilizando Column, Row, Expanded, Padding
permitindo que o card possua um título, subtítulo e um trailing. 

  No trailing foram colocados três IconButtons, um de download, outro de compartilhar e o de favorito, permitindo que futuramente sejam implementadas as funções específicas de cada botão. Por enquanto apenas a função de favorito foi implementada de uma forma apenas para testes.

### - Tela de favoritos

  A tela de favoritos é exatamente igual a tela de resultados, a única diferença seria no trailing dos cards. Aqui no trailing foi adicionado um
campo para renomear o título do card (que será implementado no futuro). Todos os outros aspectos visuais dessa tela são identicos a tela de resultados.

  Porém ao clicar em um card da tela de favoritos ocorre o redirecionamento para a tela de visualização de pdf, isso foi implementado apenas para
questão de testes e será melhor aproveitado em versões futuras do aplicativo.

### - Tela visualização de pdfs

  Ao clicar em um card (no momento funciona apenas na tela de favoritos) é feito um redirecionamento para a tela de visualização de pdf.
Essa tela faz o carregamento de um pdf (por enquanto é um pdf estático, apenas para teste) a partir de uma url, nessa tela é possível ver o conteúdo
do pdf.

  Essa tela segue o mesmo padrão das telas anteriores, um Scaffold com um AppBar e no body é feita a renderização do pdf utilizando o SyncFusion PDF Viewer,
o widget é construído utilizando o SfPdfViewer.network(url), que faz a renderização diretamente da internet. Por causa disso, é necessário que o aparelho
possua conexão ativa com a internet para ser possível visualizar o pdf.
