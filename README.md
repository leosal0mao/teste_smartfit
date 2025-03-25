# Teste Técnico: Engenheiro de Software Junior III (Flutter)

## Introdução

A proposta do projeto é desenvolver um aplicativo de Lista de Tarefas (To-Do List) utilizando Flutter, aplicando conceitos essenciais como navegação, gerenciamento de estado, consumo de API e manipulação de listas.

### Tecnologias utilizadas

- [Flutter/Dart](https://flutter.dev/), para o desenvolvimento de UI e lógica

### Arquitetura empregada

- Nesse projeto, utilizei dos principios [Clean Architecture](https://medium.com/@yamen.abd98/clean-architecture-in-flutter-mvvm-bloc-dio-79b1615530e1), empregando a separação de responsabilidade por camadas, onde a camada **domain** é o coração do sistema, livre de qualquer dependência externa, apenas criando contratos para o restante da aplicação, a camada **data** lida apenas com a persistência dos dados, e a camada **presentation** seja responsável apenas por reagir a todas as mudanças geridas pelas outras camadas. Utilizei **bloc** para a gerencia do estado da aplicação, pela sua abordagem mais profunda para a definição dos estados, permitindo a facilidade nos testes e na implementação de comportamentos para as telas. Para as injeções de dependências, preferi o uso do **get_it**, por sua facilidade no uso e abordagem limpa para declaração de dependências.

#### Bibliotecas e suas finalidades

- [dio](https://pub.dev/packages/dio), para a execução de chamados para a API e estrutura de comunicação;
- [get_it](https://pub.dev/packages/get_it), para a injeção de dependencias;
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) e [bloc](https://pub.dev/packages/bloc), para o gerenciamento de estado da aplicação;
- [equatable](https://pub.dev/packages/equatable), para simplificação de tipagens do aplicativo
- [mockito](https://pub.dev/packages/mockito), [build_runner](https://pub.dev/packages/build_runner) e [bloc_test](https://pub.dev/packages/bloc_test) para testes unitários e geração automática de mocks

### Setup para inicialização do projeto

Primeiramente, é necessário ter o [Flutter](https://docs.flutter.dev/get-started/install) instalado em sua máquina, este link contém o tutorial de como fazer a instalação em cada plataforma.

Depois, faça o download do projeto disponível no [repositório](https://github.com/leosal0mao/teste_smartfit).

Com o projeto instalado em sua máquina, entre na pasta do projeto pelo prompt de comando, e acesse a pasta **teste_smartfit**, essa pasta é a raíz do projeto.

```
Em seu console, execute:

~ % flutter pub get
```

Com esse comando, todas as dependencias de pacotes serão instaladas em seu projeto, e tudo estará configurado para que você teste a aplicação.

```
Em seu console, execute:

~ % flutter run
```

Caso hajam dúvidas, a [documentação](https://docs.flutter.dev/get-started/test-drive?tab=terminal) do flutter ensina a configuração de emuladores para todas as plataformas, e o setup para dispositivos físicos.

#### POSSÍVEIS PONTOS DE MELHORIA

- Implementação de testes de integração e widgets.
- Melhorias na UI.
- Implementação de banco de dados offline para manter o estado do aplicativo
