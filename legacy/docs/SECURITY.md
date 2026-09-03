# Segurança — Harpex Geo

## Modelo

- `anon`: somente ocorrências explicitamente `public` e nunca simuladas.
- `viewer`: leitura no(s) município(s) associado(s).
- `operator`: leitura + criação/alteração operacional no município associado.
- `admin`: gestão ampliada; associação com `municipality_id = null` representa acesso organizacional global.

## Teste obrigatório de RLS

Crie Município A e Município B. Associe um operador apenas ao A. Com o JWT desse operador, todo SELECT/INSERT/UPDATE/DELETE sobre B deve falhar ou retornar vazio. Repita com viewer, operator e admin.

## Segredos

Nunca exponha `DATABASE_URL` privilegiada ou `SUPABASE_SERVICE_ROLE_KEY` ao browser. Variáveis `NEXT_PUBLIC_*` são públicas por definição.

## Arquivos importados

Projetos importados devem passar por schema Zod antes de entrar no estado da aplicação. Conteúdo textual vindo de usuário não deve ser injetado via `innerHTML`.
