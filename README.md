# Gerador de Código Intermediário

Aqui são apresentadas três formas de representação de código intermediário por um compilador: árvore sintática, árvore sintática abstrata e notação posfixa.

A entrada é uma expressão que pode conter: adições, subtrações, multiplicações, divisões, parênteses, atribuições e variáveis.

A saída entregue pelo gerador de notação posfixa é a própria expressão matemática posfixada, já os geradores de árvores sintáticas entregam um trecho de código LaTeX, veja abaixo como utilizar.


## Compilação e uso

*Observação: Para ter certeza de que os códigos sejam compilados e executados corretamente, tenha certeza de instalar o Flex e o Bison em sua máquina.*

1. Entre em uma das três pastas do repositório.

2. Compile o arquivo exp.y com o Bison:
    > $ bison -d exp.y

3. Compile o arquivo exp.l com o Flex:
    > $ flex exp.l

4. Compile os arquivos lex.yy.c e exp.tab.c (gerados nos passos anteriores) com o Flex:
    > $ gcc lex.yy.c exp.tab.c -lm -lfl

5. Execute o arquivo a.out:
    > $ ./a.out

Caso seu objetivo seja gerar uma árvore sintática ou uma árvore sintática abstrata, veja como:

6. Digite a expressão desejada no programa a.out sendo executado. Por exemplo, estando na pasta Arvore Sintatica Abstrata, depois de
realizar os passoas acima, digito:
    > media = (n1 + n2 + n3) / 3

    Nesse caso, o código gerado será:
    ```latex
        \node{=}
            child{ node{media} }
            child{ node{/}
                child{ node{+}
                    child{ node{+}
                        child{ node{n1} }
                        child{ node{n2} }
                    }
                    child{ node{n3} }
                }
                child{ node{3} }
            }
        ;
    ```
    
7. Para utilizar o código acima você deve introduzí-lo no documento LaTeX abaixo:
    ```latex
    \documentclass[tikz,margin=.5cm]{standalone}

    \begin{document}
        \begin{tikzpicture}[folha/.style={fill=green!20}]
            % Insira o código gerado aqui
        \end{tikzpicture}
    \end{document}
    ```
    
    O resultado deverá ser:
    ```latex
    \documentclass[tikz,margin=.5cm]{standalone}

    \begin{document}
        \begin{tikzpicture}[folha/.style={fill=green!20}]
            \node{=}
                child{ node{media} }
                child{ node{/}
                    child{ node{+}
                        child{ node{+}
                            child{ node{n1} }
                            child{ node{n2} }
                        }
                        child{ node{n3} }
                    }
                    child{ node{3} }
                }
            ;
        \end{tikzpicture}
    \end{document}
    ```

8. O último passo é fazer a compilação, que pode ser feita utilizando a ferramenta online para edição de documentos em LaTeX, **Overleaf** (www.overleaf.com).

   Para este exemplo, o resultado obtido é encontrado aqui neste repositório em [exemplo.pdf](https://github.com/wellingtonlcm/Codigo-Intermediario/blob/main/exemplo.pdf).

9. Para um resultado mais elegante, você pode mudar apenas o documento principal para:
    ```latex
    \documentclass[tikz,margin=.5cm]{standalone}

    \usetikzlibrary{graphs, graphdrawing}
    \usegdlibrary{trees}

    \begin{document}
        \begin{tikzpicture}[tree layout, every node/.style={draw,circle, minimum size=8mm}, level distance=1.5cm, sibling distance=1.5cm, folha/.style={fill=green!20}]
            % Insira o código gerado aqui
        \end{tikzpicture}
    \end{document}
    ```
    
    *Note que, para compilar este documento corretamente, você deve utilizar o compilador **LuaLaTeX**, também disponível no Overleaf.*


## Considerações

Você pode notar que a representação de notação posfixa foi feita de maneira direta, pois o funcionamento do analisador sintático bottom-up
criado em Bison facilita esse processo.

Por outro lado, a representação das árvores sintáticas poderia ter sido feita de maneira mais simples, gerando diretamente um código LaTeX. Mas veja que,
antes de converter para um código LaTeX, meu código guarda a árvore em uma estrutura de dados em C++ que criei, utilizando alocação de memória e ponteiros,
para representar a árvore, esse procedimento foi feito, pois vi que teria mais liberdade para novas criações, tomando como base esse código; além disso,
também permitiu-me construir o código LaTeX já indentado.
