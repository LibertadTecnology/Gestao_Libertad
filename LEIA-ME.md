# Libertad Gestão — guia rápido

Sistema interno da **Libertad Technology** para os três sócios (Renan, Bruno e Dani):
tarefas, projetos, clientes, contratos, financeiro e agenda — no computador e no celular.

**Arquivos**

| Arquivo | Para que serve |
|---|---|
| `index.html` | O aplicativo inteiro (um arquivo só, com as fotos de vocês dentro). |
| `supabase.sql` | Cria o banco de dados gratuito no Supabase. |
| `LEIA-ME.md` | Este guia. |

---

## 1. Testar agora (2 minutos)

Abra o `index.html` no navegador do computador, escolha o seu perfil e use à vontade.
Ele já vem com os projetos atuais da Libertad (site, Barbale, Macari, Serra Aberta) e tarefas sugeridas.
Para limpar: **Ajustes → Apagar tudo e começar do zero**.

> Enquanto o banco não estiver conectado, os dados ficam salvos **só naquele navegador**.
> Para os três verem as mesmas informações, siga os passos 2 a 4.

---

## 2. Criar o banco grátis no Supabase (10 minutos)

1. Entre em **supabase.com → Start your project** e faça login com o GitHub.
2. **New project** → nome `libertad-gestao` → crie uma senha para o banco (guarde) → região **South America (São Paulo)** → plano **Free**.
3. **Criar os três usuários:** menu **Authentication → Users → Add user → Create new user**.
   Coloque o e-mail e uma senha de cada sócio e deixe marcado **Auto Confirm User**.
4. **Criar a tabela:** menu **SQL Editor → New query** → cole todo o arquivo `supabase.sql`.
   No começo dele, **troque os 3 e-mails de exemplo** pelos e-mails do passo 3 → **Run**.
   Deve aparecer *Success*.
5. **Fechar o cadastro para estranhos:** **Authentication → Sign In / Providers** → desligue
   **Allow new users to sign up** → Save. Assim só vocês três conseguem entrar.
6. **Copiar a URL e a chave:** clique no botão **Connect** no topo do projeto (ou **Settings → API Keys**).
   Copie a **Project URL** (`https://xxxx.supabase.co`) e a **Publishable key** (`sb_publishable_…`).
   ⚠️ Nunca use a *secret key* (nem a antiga *service_role*) no site.

## 3. Ligar a gestão ao banco

**Jeito recomendado (vale para todo mundo):** abra o `index.html` num editor de texto
(ou no próprio GitHub, no lápis ✏️ *Edit*), procure `CONFIG_NUVEM` (fica logo no começo do código) e cole:

```js
var CONFIG_NUVEM = {
  url: 'https://xxxx.supabase.co',
  chave: 'sb_publishable_xxxxxxxx'
};
```

Pronto: quem abrir o link cai direto na tela de login (e-mail e senha).

**Jeito rápido (só naquele aparelho):** na gestão, **Ajustes → Banco de dados na nuvem** → cole a URL e a chave → **Conectar banco**.

**No primeiro acesso**
- O primeiro sócio que entrar envia os dados do aparelho dele para o banco vazio.
- Cada um, no primeiro login, escolhe **“Quem é você?”** uma única vez.
- Depois disso, o que um muda aparece na tela dos outros na hora. Se a internet cair,
  as mudanças ficam guardadas no aparelho e sobem sozinhas quando ela voltar.

## 4. Publicar no GitHub Pages

1. Na organização **libertad-tecnology** → **New repository** (Novo repositório) → nome `gestao` → **Public** → Create.
2. **Add file → Upload files** (Adicionar arquivo → Enviar arquivos) → arraste **só o `index.html`** → **Commit changes**.
3. **Settings → Pages** (Configurações → Pages) → *Branch*: `main` / `(root)` → **Save**.
4. Em 1–2 minutos o link fica: **https://libertad-tecnology.github.io/gestao/**
5. No Supabase, em **Authentication → URL Configuration**, coloque esse link em **Site URL**
   (é para onde o e-mail de “Esqueci minha senha” leva).
6. No celular: abra o link → menu do navegador → **Adicionar à tela inicial**. Vira um app com o ícone da Libertad.

> No plano grátis do GitHub, o Pages exige repositório **público**: o código do arquivo
> (com as fotos e os dados de exemplo) fica visível para quem procurar. Os dados que vocês
> cadastrarem ficam protegidos no Supabase, atrás do login. Se quiserem esconder até o código,
> dá para publicar de graça com repositório privado no **Cloudflare Pages** ou no **Netlify**.

---

## O que tem dentro

- **Início** — saudação, suas tarefas do dia, carga de cada sócio, próximos 7 dias, funil e atividade recente.
- **Tarefas** — quadro (A fazer → Em andamento → Em revisão → Concluído) com arrastar e soltar
  (no celular: **segure o card** e arraste), lista, filtro por sócio e projeto, checklist, comentários,
  prioridade e prazo. Ao passar uma tarefa para outro sócio, aparece o botão **Avisar no WhatsApp**.
- **Projetos** — evolução em 6 etapas: *Ideia → Fase inicial → Em desenvolvimento → Testes → Implementado → Em funcionamento*,
  com marcos/entregas, tarefas, contratos, links do site e do GitHub, e **linha do tempo**.
- **Clientes** — funil de vendas (Lead → Contato → Proposta → Negociação → Fechado/Perdido) com taxa de conversão.
- **Contratos** — gera o contrato completo a partir de modelos (site, agendamento, gestão, automação,
  manutenção mensal ou personalizado), com **valores por extenso**, campos faltando destacados,
  **Imprimir / salvar PDF**, envio por **WhatsApp** e **e-mail**, status (rascunho → enviado → assinado → encerrado)
  e histórico. Ao marcar como assinado, o cliente vai para “Fechado” e o sistema oferece gerar as **cobranças**.
- **Financeiro** — entradas e despesas, a receber, vencidas, resultado do mês, gráfico de 6 meses e receita recorrente.
- **Agenda** — calendário com reuniões, prazos de tarefas, entregas e cobranças; botão **Adicionar ao Google Agenda**.
- **Equipe** — os três sócios, com troca de foto, WhatsApp e o que cada um está tocando agora.
- **Ajustes** — dados da empresa (vão nos contratos), banco na nuvem, backup (.json) e tema claro/escuro.
- **Atalhos** — `Ctrl/⌘ + K` busca tudo e cria coisas · `N` nova tarefa · `Esc` fecha janelas.

## Cuidados

- **Contrato:** é um modelo-base bem completo (inclui LGPD, garantia, propriedade intelectual e foro),
  mas **peça para um advogado revisar** antes de usar com clientes. Para assinar de graça com validade
  jurídica, salve o PDF e use o assinador do gov.br: https://assinador.iti.br
- **Antes do primeiro contrato:** preencha **Ajustes → Dados da empresa** (CNPJ, endereço, cidade e quem assina).
- **Backup:** de vez em quando, **Ajustes → Baixar backup (.json)**.
- **Plano grátis do Supabase:** 500 MB de banco (sobra muito para isso). O projeto **pausa depois de 1 semana
  sem nenhum acesso** — se acontecer, entre em supabase.com e clique em **Restore**.
- **Novo sócio no futuro:** crie o usuário (passo 2.3), inclua o e-mail no `supabase.sql` e rode de novo.

## Se algo der errado

| Mensagem | O que fazer |
|---|---|
| “E-mail ou senha incorretos” | Confira o usuário em Authentication → Users (ou redefina a senha lá). |
| “E-mail ainda não confirmado” | Crie o usuário com **Auto Confirm User** marcado. |
| “O banco recusou a gravação” / dados não aparecem | O e-mail não está na lista do `supabase.sql`. Corrija e rode de novo. |
| “A tabela registros ainda não existe” | Rode o `supabase.sql` no SQL Editor. |
| Indicador “Salvo neste aparelho” | Aquele aparelho ainda não está ligado ao banco (veja o passo 3). |
