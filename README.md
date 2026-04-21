# Reshop Client - Docker

Container Docker para executar o cliente Reshop (Unico.Client.exe) em ambiente Linux usando Wine.

## 📋 Descrição

Este projeto dockeriza uma aplicação Windows .NET (Unico.Client.exe) permitindo sua execução em ambiente Linux através do Wine. O container é baseado em Ubuntu 20.04 e inclui todas as dependências necessárias para executar aplicações .NET Framework no Wine.

## 🚀 Tecnologias

- **Docker**
- **Ubuntu 20.04** (base image)
- **Wine HQ Stable** - Camada de compatibilidade para executar aplicações Windows no Linux
- **Xvfb** - X Virtual Framebuffer para ambiente gráfico virtual
- **.NET Framework 4.5**
- **System.Data.SQLite** - Banco de dados SQLite

## 🔧 Componentes

- **Wine** com .NET Framework 4.5
- **Winetricks** para gerenciamento de dependências Windows
- **Xvfb** para simulação de display gráfico
- **Aplicação Unico.Client** (Reshop Client)

## 📦 Build da Imagem

Para construir a imagem Docker:

```bash
docker build -t reshop/client:1.2.30 .
```

## ▶️ Execução

Para executar o container:

```bash
docker container run --name ReshopClient -p 2009:2009 -p 2010:2010 reshop/client:1.2.30
```

### Portas Expostas

- **2009** - Porta da aplicação Reshop Client (HTTP)
- **2010** - Porta auxiliar da aplicação

## 📁 Estrutura

```
reshop-client-docker/
├── Dockerfile          # Definição da imagem Docker
├── startup.sh          # Script de inicialização do container
└── app/                # Aplicação Unico.Client e dependências
    ├── Unico.Client.exe
    ├── Unico.Client.exe.config
    ├── Unico.Client.exe.config.prod
    ├── Unico.Client.exe.config.stage
    ├── Unico.db
    └── [DLLs e dependências]
```

## ⚙️ Configuração

O container possui três arquivos de configuração para diferentes ambientes:

- `Unico.Client.exe.config` - Configuração padrão
- `Unico.Client.exe.config.prod` - Configuração de produção
- `Unico.Client.exe.config.stage` - Configuração de staging

## 🔍 Detalhes Técnicos

### Dependências Windows instaladas via Wine:
- .NET Framework 4.5
- MSXML6

### Variáveis de Ambiente:
- `WINEDEBUG=fixme-all` - Suprime mensagens de debug do Wine

## 📝 Notas

- O container usa `xvfb-run` para executar a aplicação sem necessidade de um servidor X real
- A aplicação é executada com um delay de 1 segundo no startup para garantir que todos os serviços estejam prontos
- Wine está configurado para executar aplicações 32-bit e 64-bit

## 👤 Autor

Claudio A. Martins  
claudio.almeida@linx.com.br

## 📄 Versão

**1.2.30** - Reshop Client Slot 1
