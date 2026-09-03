# Segurança

## Preview

Este pacote não contém chaves privadas.

Não coloque no HTML:

- service role do Supabase;
- segredo OpenAI;
- token administrativo;
- credenciais de banco;
- APIs privadas de terceiros.

## Harpex AI

`window.HarpexMap` é uma superfície de ações controladas. Um modelo real deve chamar essas operações por backend/tool calling. Não permita que o modelo gere e execute JavaScript arbitrário no browser.

## Produção

- RLS por organização e município;
- incidentes com `public/internal/restricted/confidential`;
- logs de auditoria;
- rate limiting;
- validação Zod/JSON Schema;
- CSP compatível com as fontes autorizadas;
- secrets apenas no backend;
- assinatura/autorização de ações destrutivas.
