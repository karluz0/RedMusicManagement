# Red Music — implantação de testes

O Dockerfile desta raiz extrai `redmusicmanagement-publicacao.zip`, compila o React
e inicia a API FastAPI. O código-fonte revisado está nesse arquivo; consulte
`redmusicmanagement/PUBLICACAO.md` dentro dele para as configurações e limitações.

O arquivo antigo `redmusicmanagement-main.zip` não participa da implantação.

No Render, use **Docker**, Dockerfile `./Dockerfile`, contexto da raiz e plano **Free**.
O projeto não usa Elixir: os comandos `mix phx.digest` e `mix phx.server` não se aplicam.

Configure `MONGO_URL`, `DB_NAME=redmusic_testes`, `JWT_SECRET`, `COOKIE_SECURE=true`,
`ADMIN_EMAIL` e `ADMIN_PASSWORD` nos campos protegidos do Render. Não grave segredos
no repositório. Use MongoDB Atlas Free para o banco; não é necessário PostgreSQL.

A publicação só estará concluída depois de configurar o banco e validar `/api/health`.
Use dados fictícios no piloto, pois as demais melhorias funcionais ainda estão pendentes.
