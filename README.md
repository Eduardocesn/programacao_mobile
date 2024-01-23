# Aplicativo mobile para filtrar dados do Diário Oficial de Recife

- Carlos Eduardo Santana Nascimento 202100011252
- Max Antônio Lima Barreto 202100011744

## Telas

Para montar o aplicativo foram feitas 4 telas, dentre elas temos:

### Tela principal

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



