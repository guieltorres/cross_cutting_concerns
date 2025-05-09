# Explicação dos Princípios e Padrões

Este projeto demonstra a aplicação de princípios SOLID e padrões de design em um contexto de comunicação HTTP. Abaixo estão os princípios e padrões utilizados, com explicações baseadas no código.

## Princípio da Responsabilidade Única (SRP - Single Responsibility Principle)

Cada classe tem uma única responsabilidade:

- `UserRepository` gerencia a lógica de carregamento de usuários.
- `HttpAdapter` e `DioAdapter` gerenciam a comunicação HTTP com bibliotecas específicas (`http` e `dio`).
- `HttpAdapterLogger` adiciona a funcionalidade de logging sem modificar as implementações existentes.

## Princípio Aberto/Fechado (OCP - Open/Closed Principle)

O código está aberto para extensão e fechado para modificação:

- Podemos adicionar novos adapters, como `CustomHttpAdapter`, sem alterar o código existente.
- O `UserRepository` não precisa ser modificado para usar um novo adapter, pois depende da abstração `HttpClient`.

## Princípio da Substituição de Liskov (LSP - Liskov Substitution Principle)

- `HttpAdapter` e `DioAdapter` podem substituir a interface `HttpClient` sem quebrar o comportamento do `UserRepository`.
- `HttpAdapterLogger` aceita qualquer implementação de `HttpClient` como `decoratee`, garantindo que todas as subclasses ou implementações concretas de `HttpClient` possam ser usadas de forma intercambiável.

## Princípio da Segregação de Interfaces (ISP - Interface Segregation Principle)

- A interface `HttpClient` define apenas o método necessário (`get`), garantindo que as implementações não sejam forçadas a implementar métodos desnecessários.

## Princípio da Inversão de Dependência (DIP - Dependency Inversion Principle)

- `UserRepository` depende da abstração `HttpClient`, e não de implementações concretas como `HttpAdapter` ou `DioAdapter`.
- A criação de instâncias de `HttpClient` é delegada ao método `createHttpClient`, promovendo flexibilidade.

## Padrão de Design Factory

- O método `createHttpClient` encapsula a lógica de criação de objetos, permitindo alternar entre diferentes implementações de `HttpClient` sem alterar o código que consome essa abstração.

## Padrão de Design Decorator

- `HttpAdapterLogger` adiciona funcionalidades (logging) à interface `HttpClient` sem modificar as implementações existentes (`HttpAdapter` e `DioAdapter`).

## Padrão de Design Adapter

- `HttpAdapter` e `DioAdapter` adaptam bibliotecas específicas (`http` e `dio`) para a interface comum `HttpClient`, permitindo que o restante do código funcione de forma independente da biblioteca utilizada.

## Estrutura do Código

- **`UserRepository`**: Gerencia a lógica de carregamento de usuários.
- **`HttpClient`**: Interface que define o contrato para comunicação HTTP.
- **`HttpAdapter`**: Implementação de `HttpClient` usando a biblioteca `http`.
- **`DioAdapter`**: Implementação de `HttpClient` usando a biblioteca `dio`.
- **`HttpAdapterLogger`**: Implementação de `HttpClient` que adiciona logging às requisições HTTP.
- **`createHttpClient`**: Método fábrica que cria uma instância de `HttpClient` com logging.

## Como Executar

1. Certifique-se de que o backend está rodando:

   ```sh
   cd backend
   npm install
   npm start
   ```

2. Execute o projeto Dart:
   ```sh
   dart run main.dart
   ```
