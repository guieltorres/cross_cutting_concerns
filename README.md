# Explicação dos Princípios e Padrões:

## Princípio da Responsabilidade Única (SRP - Single Responsibility Principle):

Cada classe tem uma única responsabilidade:
UserRepository gerencia a lógica de carregamento de usuários.
HttpAdapter e DioAdapter gerenciam a comunicação HTTP.

## Princípio Aberto/Fechado (OCP - Open/Closed Principle):

O código está aberto para extensão (podemos adicionar novos adapters, como CustomHttpAdapter), mas fechado para modificação (não precisamos alterar UserRepository para usar um novo adapter).

## Princípio da Substituição de Liskov (LSP - Liskov Substitution Principle):

HttpAdapter e DioAdapter podem substituir a interface HttpClient sem quebrar o comportamento do UserRepository.

## Princípio da Segregação de Interfaces (ISP - Interface Segregation Principle):

A interface HttpClient define apenas o método necessário (get), garantindo que as implementações não sejam forçadas a implementar métodos desnecessários.

## Princípio da Inversão de Dependência (DIP - Dependency Inversion Principle):

UserRepository depende da abstração HttpClient, e não de implementações concretas como HttpAdapter ou DioAdapter.

## Padrão de Design Factory:

O método createHttpClient encapsula a lógica de criação de objetos, permitindo alternar entre diferentes implementações de HttpClient.

## Padrão de Design Adapter:

HttpAdapter e DioAdapter adaptam bibliotecas específicas (http e dio) para a interface comum HttpClient.
