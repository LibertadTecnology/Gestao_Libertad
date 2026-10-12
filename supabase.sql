-- =====================================================================
--  LIBERTAD GESTÃO · banco de dados no Supabase (plano grátis)
--  Como usar: Supabase → SQL Editor → New query → cole TUDO → Run
--  Pode rodar de novo quando quiser (não apaga nada).
-- =====================================================================

-- 1) TROQUE OS 3 E-MAILS ABAIXO pelos e-mails que vocês cadastraram em
--    Authentication → Users. Só esses e-mails conseguem ler e gravar.
create or replace function public.eh_socio()
returns boolean
language sql
stable
set search_path = ''
as $$
  select lower(coalesce(auth.jwt() ->> 'email', '')) in (
    lower('email-do-renan@exemplo.com'),
    lower('email-do-bruno@exemplo.com'),
    lower('email-da-dani@exemplo.com')
  );
$$;

-- 2) Tabela única com tudo da gestão (tarefas, projetos, clientes,
--    contratos, financeiro, agenda, equipe e histórico).
create table if not exists public.registros (
  id             text primary key,               -- "tipo:id", ex.: tarefa:t-abc123
  tipo           text not null,                  -- tarefa, projeto, cliente, contrato…
  dados          jsonb not null default '{}'::jsonb,
  atualizado_em  timestamptz not null default now(),
  atualizado_por text
);
create index if not exists registros_tipo_idx on public.registros (tipo);

-- 3) Segurança: ninguém de fora acessa. Só os sócios logados da lista acima.
alter table public.registros enable row level security;

drop policy if exists "socios leem"      on public.registros;
drop policy if exists "socios inserem"   on public.registros;
drop policy if exists "socios atualizam" on public.registros;
drop policy if exists "socios apagam"    on public.registros;

create policy "socios leem"      on public.registros for select to authenticated using ((select public.eh_socio()));
create policy "socios inserem"   on public.registros for insert to authenticated with check ((select public.eh_socio()));
create policy "socios atualizam" on public.registros for update to authenticated using ((select public.eh_socio())) with check ((select public.eh_socio()));
create policy "socios apagam"    on public.registros for delete to authenticated using ((select public.eh_socio()));

-- 4) Tempo real: quando um sócio muda algo, a tela dos outros atualiza sozinha.
do $$
begin
  alter publication supabase_realtime add table public.registros;
exception
  when duplicate_object then null;   -- já estava ligado
  when undefined_object then null;   -- publicação não existe (projeto antigo)
end $$;

-- Pronto! Para conferir: Table Editor → registros (fica vazia até alguém conectar).
-- Para adicionar um 4º sócio no futuro: inclua o e-mail dele na lista do passo 1 e rode de novo.
