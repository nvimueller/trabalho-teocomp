#import "lib.typ": *

#show:noteworthy.with(paper-size: "a4", font: "New Computer Modern", language: "en", title: "Parte 4 -- Demonstrações")

*Questão A.* Apresente e justifique a correção da redução $"PANV" <= "PAT"$.

_Demonstração._ Vamos construir uma redução $r: "PANV" => "PAT"$. Considere o seguinte algoritmo $r$ que, ao receber uma instância $M$ de PANV, retorna uma instância $r(M) = M'$ de PAT, onde $M'$ é a Máquina de Turing que, para toda palavra w de entrada, executa os seguintes passos:

+ Rode $M$.
+ Se $M$ aceita algum $w$, então $M'$ aceita todas as palavras tal que $w in Sigma^*$.
+ Se $M$ não aceita nenhum $w$, então $M'$ possui alguma palavra $w$ tal que $w in.not Sigma^*$.

Resta agora provarmos que a redução $r$ descrita acima está correta:

- Suponha que $M in Upsilon("PANV")$. Então $M'$ aceita todas as palavras possíveis de serem formadas pelo seu alfabeto, ou seja, $M' in Upsilon("PAT")$.
- Suponha que $M in Nu("PANV")$. Então $M'$ possui alguma palavra formada pelo seu alfabeto que não é aceita, ou seja, $M' in Nu("PAT")$.

*Questão B.* Apresente e justifique a correção da redução $"HAMPATH" <= "TSP"$.

_Demonstração._ Vamos construir uma redução $r: "HAMPATH" => "TSP"$. Considere o seguinte algoritmo $r$ que, ao receber uma instância $M$ de $"HAMPATH"$, retorna uma instância $r(M) = M'$ de $"TSP"$, onde $M'$ é a Máquina de Turing que, para toda tripla $(G, s, t)$ de entrada, executa os seguintes passos:

+ Rode $M$.
+ Se $M$ possui um caminho hamiltoniano que parte de $s$ e termina em $t$, então haverá uma soma de arestas menor que $k$.
+ Se $M$ não possui um caminho hamiltoniano que parte de $s$ e termina em $t$, então não haverá uma soma de arestas menor que $k$, muito menos qualquer soma devido a ausência do caminho.

Resta agora provarmos que a redução $r$ descrita acima está correta:

- Suponha que $(G, s, t) in Upsilon("HAMPATH")$. Então $M'$ aceita o caminho formado pela soma das arestas, pois definimos $k$ como sendo a soma de todas as arestas percorridas pelo caminho hamiltoniano acrescida de um.
- Suponha que $(G, s, t) in Nu("HAMPATH")$. Então $M'$ não aceita o caminho formado pela soma das arestas pois não há caminho.

Alternativamente, como provamos que a redução pode ser realizada em tempo polinomial e sabemos que $"HAMPATH"$ é NP-completo, temos que se for possível resolver $"TSP"$ em tempo polinomial, $"HAMPATH"$ também poderá ser solucionável em tempo polinomial. Isso, por sua vez, contradiz o fato de $"HAMPATH"$ não poder ser resolvido em tempo polinomial. Logo, $"TSP"$ também é NP-completo.
