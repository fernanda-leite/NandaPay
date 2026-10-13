# NandaPay
Projeto NandaPay
1. Contexto: Um banco está modernizando a solução responsável pelo controle de limites de transações de seus clientes. Atualmente, as informações estão concentradas em uma aplicação legada. A nova solução deverá atender diferentes canais e permitir a evolução independente dos componentes.
	 - Um cliente pode possuir uma ou mais contas.
   - Cada conta possui limites configurados para determinados tipos de transação.
   - Os limites podem ser alterados ao longo do tempo e o histórico precisa ser preservado.
   -	Uma transação pode consumir parte do limite disponível.
   -	Uma transação pode ser solicitada, autorizada, negada ou cancelada.
   -	Diferentes canais podem solicitar transações.
   -	Outros sistemas precisam ser informados quando estados relevantes forem alterados.
   -	Consultas de limite e solicitações de transação podem ocorrer em grande volume.
   -	Deve ser possível identificar qual regra e qual limite foram considerados na decisão de autorizar ou negar uma transação.
