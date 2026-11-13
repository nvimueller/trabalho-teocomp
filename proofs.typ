#set page(paper: "a4", margin: 2.5cm)

#set text(font: "New Computer Modern", size: 10pt)

#set par(justify: true)

#show heading: set align(center)

#set enum(indent: 1.5em, body-indent: 0.5em)
#set list(indent: 1.5em, body-indent: 0.5em)

== #smallcaps("Parte 4 -- Demonstrações")

#v(1em)

*Questão A.* Apresente e justifique a correção da redução $"PANV" => "PAT"$.

*Demonstração.* Vamos construir uma redução $r: "PANV" => "PAT"$. Considere o seguinte algoritmo $r$ que, ao receber uma instância $M$ de PANV, retorna uma instância $r(M) = M'$ de PAT, onde $M'$ é a Máquina de Turing que, para toda palavra w de entrada, executa os seguintes passos:

+ Rode $M$ $forall w in Sigma^*$. Os alfabetos das duas máquinas serão o mesmo.
+ Se $M$ aceita algum $w$, então $M'$ aceita todas as palavras tal que $w in Sigma^*$.
+ Se $M$ não aceita nenhum $w$, então $M'$ possui alguma palavra $w$ tal que $w in.not Sigma^*$.

Resta agora provarmos que a redução $r$ descrita acima está correta:

- Suponha que $M in Upsilon("PANV")$. Então $M'$ aceita todas as palavras possíveis de serem formadas pelo seu alfabeto, ou seja, $M' in Upsilon("PAT")$.

- Suponha que $M in Nu("PANV")$. Então $M'$ possui alguma palavra formada pelo seu alfabeto que não é aceita, ou seja, $M' in Nu("PAT")$.

Logo, se $"PAT"$ é decidível, então $"PANV"$ é decidível. Então, $"PAT"$ precisa ser indecidível para não haver contradição.

*Questão B.* Apresente e justifique a correção da redução $"HAMPATH" <= "TSP"$.

*Demonstração.* Vamos construir uma redução $r: "HAMPATH" <= "TSP"$. Considere o seguinte algoritmo $r$ que, ao receber uma instância $(G, s, t$ de $"HAMPATH"$, retorna uma instância $r(G, s, t) = (G', k)$ de $"TSP"$, onde $(G', k)$ é a tradução da instância $"HAMPATH"$ realizada da seguinte maneira:

+ Remova todos o ciclos do grafo por meio de DFS, deletando a última aresta visitada que leva a um vértice já visitado.
+ Utilize o direcionamento do grafo (1s) da matriz de adjacência como pesos (todas as arestas terão peso 1).
+ Adicionar aresta de $t$ para $s$ caso não exista.
+ $k$ é gerado pelo produto $(|V| times (|V| - 1) + 1)$, para que garantidamente o peso do ciclo, quando ele existir, seja menor que $k$.

Resta agora provarmos que a redução $r$ descrita acima está correta:

- Suponha que $(G, s, t) in Upsilon("HAMPATH")$ -- há um caminho hamiltoniano de $s$ até $t$ no grafo. Isso significa que adicionar uma aresta de $t$ até $s$ garante que o ciclo hamiltoniano exista e tenha peso garantidamente um peso menor que $k$ por definição.

- Suponha que $(G, s, t) in Nu("HAMPATH")$ -- não há um caminho hamiltoniano de $s$ até $t$, supondo que não há outro caminho hamiltoniano. Isso significa que remover os ciclos e adicionar uma aresta de $t$ até $s$ não resultará em um ciclo hamiltoniano, pois o caminho não existia em primeiro lugar. Desse modo, garantimos que o ciclo não existe, sem mesmo ser necessário nos preocuparmos com o seu peso devido a sua inexistência. A existência de um novo ciclo gerado pela simples adição da ligação de $t$ até $s$ não resulta em um novo ciclo, pois se o fosse, teria sido reconhecido como caminho primeiramente.

- Suponha que $(G, s, t) in Nu("HAMPATH")$ -- não há um caminho hamiltoniano de $s$ até $t$, supondo que há outro caminho hamiltoniano. Isso significa que remover os ciclos e adicionar uma aresta de $t$ até $s$ não resultará em um ciclo hamiltoniano, pois o único jeito de gerá-lo seria permitindo um ciclo que não contesse a sequência $t -> s$ no ciclo.

Os casos em que há, primeiramente, ciclo hamiltoniano em $G$ são descartados devido à remoção dos ciclos para produzir $G'$.

Logo, como provamos que a redução pode ser realizada em tempo polinomial e sabemos que $"HAMPATH"$ é NP-completo, temos que se for possível resolver $"TSP"$ em tempo polinomial em uma Máquina de Turing Determinística, $"HAMPATH"$ também poderá ser solucionável em tempo polinomial em uma Máquina de Turing Determinística. Isso, por sua vez, contradiz o fato de $"HAMPATH"$ ser NP-completo. Logo, $"TSP"$ também é NP-completo.
