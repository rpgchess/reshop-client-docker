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

### Opção 1: Build Simples

```bash
# Build da imagem
docker build -t reshop/client:1.2.30 .

# Build com cache desabilitado (rebuild completo)
docker build --no-cache -t reshop/client:1.2.30 .

# Build com tag adicional
docker build -t reshop/client:1.2.30 -t reshop/client:latest .
```

### Opção 2: Build Multi-stage (otimizado)

```bash
# Build com target específico
docker build --target production -t reshop/client:1.2.30 .
```

### Opção 3: Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  reshop-client:
    build:
      context: .
      dockerfile: Dockerfile
    image: reshop/client:1.2.30
    container_name: ReshopClient
    ports:
      - "2009:2009"
      - "2010:2010"
    environment:
      - WINEDEBUG=fixme-all
      - ENVIRONMENT=production
    volumes:
      - ./data:/root/reshop/data
      - ./logs:/root/reshop/logs
    restart: unless-stopped
```

```bash
# Build e executar com Docker Compose
docker-compose up -d --build
```

## ▶️ Execução

### Opção 1: Execução Básica

```bash
# Executar container
docker container run --name ReshopClient -p 2009:2009 -p 2010:2010 reshop/client:1.2.30

# Executar em background (detached)
docker run -d --name ReshopClient -p 2009:2009 -p 2010:2010 reshop/client:1.2.30

# Executar e remover container ao parar
docker run --rm --name ReshopClient -p 2009:2009 -p 2010:2010 reshop/client:1.2.30
```

### Opção 2: Com Volumes Persistentes

```bash
# Mapear volumes para persistência
docker run -d \
  --name ReshopClient \
  -p 2009:2009 \
  -p 2010:2010 \
  -v $(pwd)/data:/root/reshop/data \
  -v $(pwd)/logs:/root/reshop/logs \
  reshop/client:1.2.30
```

### Opção 3: Com Variáveis de Ambiente

```bash
# Configurar ambiente via variáveis
docker run -d \
  --name ReshopClient \
  -p 2009:2009 \
  -p 2010:2010 \
  -e ENVIRONMENT=production \
  -e LOG_LEVEL=info \
  -e WINEDEBUG=fixme-all \
  reshop/client:1.2.30
```

### Opção 4: Docker Compose

```bash
# Iniciar serviço
docker-compose up -d

# Ver logs
docker-compose logs -f reshop-client

# Pa� Troubleshooting

### Container não inicia

```bash
# Verificar logs
docker logs ReshopClient

# Verificar eventos do Docker
docker events

# Inspecionar container
docker inspect ReshopClient
```

### Problemas com Wine

```bash
# Executar shell no container
docker exec -it ReshopClient /bin/bash

# Verificar instalação do Wine
wine --version

# Testar Wine
wine notepad

# Verificar .NET Framework
wine cmd /c reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4\Full" /v Version
```

### Problemas de Rede

```bash
# Verificar se portas estão expostas
docker port ReshopClient

# Testar conectividade
curl http://localhost:2009
curl http://localhost:2010

# Verificar conflitos de porta
netstat -an | grep 2009
```

### Problemas de Performance

```bash
# Aumentar recursos do container
docker run -d \
  --name ReshopClient \
  --memory="2g" \
  --cpus="2.0" \
  -p 2009:2009 \
  -p 2010:2010 \
  reshop/client:1.2.30
```

## 💡 Conceitos Demonstrados

- **Docker**: Containerização de aplicações
- **Wine**: Camada de compatibilidade Windows no Linux
- **Xvfb**: X Virtual Framebuffer para aplicações gráficas headless
- **Multi-stage builds**: Otimização de imagens Docker
- **Health checks**: Monitoramento de saúde do container
- **Volume mapping**: Persistência de dados
- **.NET Framework no Linux**: Execução de apps Windows em Linux

## ⚙️ Melhorias Implementadas

### ✅ Configuração
- **EditorConfig** adicionado para encoding UTF-8
- Dockerfile e shell scripts configurados

### ✅ Documentação
- README expandido com 4 formas de executar
- Docker Compose exemplo completo
- Comandos de gerenciamento listados
- Troubleshooting detalhado
- Conceitos técnicos explicados
- Volumes e variáveis de ambiente documentados

## 🚀 Melhorias Futuras

- [ ] Health check endpoint
- [ ] Multi-stage Dockerfile para reduzir tamanho
- [ ] Docker secrets para credenciais
- [ ] Monitoramento (Prometheus/Grafana)
- [ ] Log aggregation (ELK Stack)
- [ ] CI/CD pipeline (GitHub Actions)
- [ ] Kubernetes deployment
- [ ] Helm chart
- [ ] Backup automatizado de dados
- [ ] Alpine Linux base image (menor)

## 🔗 Links Úteis

- [Docker Documentation](https://docs.docker.com/)
- [Wine HQ](https://www.winehq.org/)
- [Winetricks](https://github.com/Winetricks/winetricks)
- [.NET Framework on Wine](https://appdb.winehq.org/objectManager.php?sClass=version&iId=17886)
- [Xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml)

## �rar serviço
docker-compose down
```

### Gerenciamento do Container

```bash
# Listar containers em execução
docker ps

# Ver logs do container
docker logs ReshopClient
docker logs -f ReshopClient  # Follow logs em tempo real

# Parar container
docker stop ReshopClient

# Iniciar container parado
docker start ReshopClient

# Reiniciar container
docker restart ReshopClient

# Remover container
docker rm ReshopClient

# Acessar shell do container
docker exec -it ReshopClient /bin/bash

# Ver estatísticas de recursos
docker stats ReshopClient
```

### Portas Expostas

- **2009** - Porta principal da aplicação Reshop Client (HTTP API)
- **2010** - Porta auxiliar da aplicação (WebSocket/Health)

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
