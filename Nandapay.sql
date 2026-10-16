/*==============================================================*/
/* Database name:  DB_NANDAPAY                                  */
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     14/09/2021 08:39:34                          */
/*==============================================================*/


/*==============================================================*/
/* Database: DB_NANDAPAY                                        */
/*==============================================================*/
create database DB_NANDAPAY;

/*==============================================================*/
/* Table: TABELA_CLIENTE_CONTA                                  */
/*==============================================================*/
create table TABELA_CLIENTE_CONTA (
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   constraint PK_TABELA_CLIENTE_CONTA primary key (ID_CLIENTE, ID_CONTA)
);

comment on table TABELA_CLIENTE_CONTA is
'Tabela pivot entre cliente e conta ';

comment on column TABELA_CLIENTE_CONTA.ID_CLIENTE is
'Número identificador do cliente';

comment on column TABELA_CLIENTE_CONTA.ID_CONTA is
'Número identificador da conta';

/*==============================================================*/
/* Index: CLIENTE_CLIENTE_CONTA                                 */
/*==============================================================*/
create index CLIENTE_CLIENTE_CONTA on TABELA_CLIENTE_CONTA (
   ID_CLIENTE ASC
);

/*==============================================================*/
/* Index: CONTA_CLIENTE_CONTA                                   */
/*==============================================================*/
create index CONTA_CLIENTE_CONTA on TABELA_CLIENTE_CONTA (
   ID_CONTA ASC
);

/*==============================================================*/
/* Table: TB_CLIENTE                                            */
/*==============================================================*/
create table TB_CLIENTE (
   ID_CLIENTE           NUMBER                not null,
   NM_CLIENTE           VARCHAR2(255)         not null,
   NM_TP_DOCUMENTO      VARCHAR2(4)           not null
      constraint CKC_NM_TP_DOCUMENTO_TB_CLIEN check (NM_TP_DOCUMENTO in ('CPF','CNPJ')),
   NR_DOCUMENTO         VARCHAR2(15)          not null,
   DT_CRIACAO_CLIENTE   DATE                  not null,
   constraint PK_TB_CLIENTE primary key (ID_CLIENTE),
   constraint AK_AK_TABELA_CLIENTE_TB_CLIEN unique (NM_CLIENTE, NR_DOCUMENTO)
);

comment on table TB_CLIENTE is
'Tabela que armazena os cliente do banco NandaPay';

comment on column TB_CLIENTE.ID_CLIENTE is
'Número identificador do cliente';

comment on column TB_CLIENTE.NM_CLIENTE is
'Nome do cliente';

comment on column TB_CLIENTE.NM_TP_DOCUMENTO is
'Tipo de documento do cliente . Aceita os valores CPF ou CNPJ';

comment on column TB_CLIENTE.NR_DOCUMENTO is
'Número do cpf ou do cnpj do cliente';

comment on column TB_CLIENTE.DT_CRIACAO_CLIENTE is
'Data de criação do registro do cliente';

/*==============================================================*/
/* Table: TB_CONTA                                              */
/*==============================================================*/
create table TB_CONTA (
   ID_CONTA             NUMBER                not null,
   CD_CONTA             VARCHAR2(10)          not null,
   CD_AGENCIA           VARCHAR2(10)          not null,
   ST_CONTA             CHAR(1)               not null
      constraint CKC_ST_CONTA_TB_CONTA check (ST_CONTA in ('P','A','I','B','E')),
   DT_CRIACAO_CONTA     DATE,
   constraint PK_TB_CONTA primary key (ID_CONTA),
   constraint AK_AK_CONTA_TB_CONTA unique (CD_CONTA, CD_AGENCIA)
);

comment on table TB_CONTA is
'Tabela que armazena as contas do banco NandaPay';

comment on column TB_CONTA.ID_CONTA is
'Número identificador da conta';

comment on column TB_CONTA.CD_CONTA is
'Código da conta bancária';

comment on column TB_CONTA.CD_AGENCIA is
'Código da agência, onde está alocada a conta bancária';

comment on column TB_CONTA.ST_CONTA is
'Status da conta bancária. Valores Aceitos:
P - Pendente / Em Análise
A- Ativa
I - Inativa
B - Bloqueada
E - Encerrada
';

comment on column TB_CONTA.DT_CRIACAO_CONTA is
'Data de criação da conta';

/*==============================================================*/
/* Index: CONTA_AGENCIA                                         */
/*==============================================================*/
create index CONTA_AGENCIA on TB_CONTA (
   CD_AGENCIA ASC
);

/*==============================================================*/
/* Table: TB_DOM_AGENCIA                                        */
/*==============================================================*/
create table TB_DOM_AGENCIA (
   CD_AGENCIA           VARCHAR2(10)          not null,
   NM_AGENCIA           VARCHAR2(255)         not null,
   constraint PK_TB_DOM_AGENCIA primary key (CD_AGENCIA)
);

comment on table TB_DOM_AGENCIA is
'Tabela que contém as agências do banco NandaPay';

comment on column TB_DOM_AGENCIA.CD_AGENCIA is
'Código que identifica a agência ';

comment on column TB_DOM_AGENCIA.NM_AGENCIA is
'Nome da agência';

/*==============================================================*/
/* Table: TB_DOM_STATUS_TRANSACAO                               */
/*==============================================================*/
create table TB_DOM_STATUS_TRANSACAO (
   ID_STATUS_TRANSACAO  NUMBER                not null,
   NM_STATUS_TRANSACAO  VARCHAR2(50)          not null,
   constraint PK_TB_DOM_STATUS_TRANSACAO primary key (ID_STATUS_TRANSACAO)
);

comment on table TB_DOM_STATUS_TRANSACAO is
'Tabela de domínio de status da transação';

comment on column TB_DOM_STATUS_TRANSACAO.ID_STATUS_TRANSACAO is
'Número identificador do status da transação';

comment on column TB_DOM_STATUS_TRANSACAO.NM_STATUS_TRANSACAO is
'Nome do statua da transação';

/*==============================================================*/
/* Table: TB_DOM_TP_CANAL                                       */
/*==============================================================*/
create table TB_DOM_TP_CANAL (
   ID_TP_CANAL          NUMBER                not null,
   NM_TP_CANAL          VARCHAR2(100)         not null,
   constraint PK_TB_DOM_TP_CANAL primary key (ID_TP_CANAL)
);

comment on table TB_DOM_TP_CANAL is
'Tabela onde constam os tipos de canal';

comment on column TB_DOM_TP_CANAL.ID_TP_CANAL is
'Número identificador do tipo de canal';

comment on column TB_DOM_TP_CANAL.NM_TP_CANAL is
'Nome do tipo de canal';

/*==============================================================*/
/* Table: TB_DOM_TP_TRANSACAO                                   */
/*==============================================================*/
create table TB_DOM_TP_TRANSACAO (
   ID_TP_TRANSACAO      NUMBER                not null,
   NM_TP_TRANSACAO      VARCHAR2(100)         not null,
   constraint PK_TB_DOM_TP_TRANSACAO primary key (ID_TP_TRANSACAO)
);

comment on table TB_DOM_TP_TRANSACAO is
'Tabela de domínio do tipo da transação';

comment on column TB_DOM_TP_TRANSACAO.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_DOM_TP_TRANSACAO.NM_TP_TRANSACAO is
'Nome do tipo de transação';

/*==============================================================*/
/* Table: TB_HST_REGRA_LIMITE                                   */
/*==============================================================*/
create table TB_HST_REGRA_LIMITE (
   ID_HST_REGRA_LIMITE  NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER(8,2)           not null,
   DT_HR_HISTORICO      DATE                  not null,
   constraint PK_TB_HST_REGRA_LIMITE primary key (ID_HST_REGRA_LIMITE)
);

comment on column TB_HST_REGRA_LIMITE.ID_HST_REGRA_LIMITE is
'Número identificador do registro da tabela de histórico';

comment on column TB_HST_REGRA_LIMITE.ID_CONTA is
'Número identificador da conta';

comment on column TB_HST_REGRA_LIMITE.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_HST_REGRA_LIMITE.VL_LIMITE is
'Valor limite da transação';

comment on column TB_HST_REGRA_LIMITE.DT_HR_HISTORICO is
'Data e hora da entrada do registro na tabela de histórico';

/*==============================================================*/
/* Table: TB_HST_TRANSACAO                                      */
/*==============================================================*/
create table TB_HST_TRANSACAO (
   ID_HST_TRANSACAO     NUMBER                not null,
   ID_TRANSACAO         NUMBER                not null,
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   FL_DEBITO_CREDITO    CHAR(1)               not null,
   VL_TRANSACAO         NUMBER(8,2)           not null,
   ID_STATUS_TRANSACAO  NUMBER                not null,
   NM_USUARIO_TRANSACAO VARCHAR2(100)         not null,
   DT_HR_TRANSACAO      DATE                  not null,
   DT_HR_HISTORICO      DATE                  not null,
   constraint PK_TB_HST_TRANSACAO primary key (ID_HST_TRANSACAO)
);

comment on table TB_HST_TRANSACAO is
'Tabela que armazena histórico da tabela TB_TRANSACAO';

comment on column TB_HST_TRANSACAO.ID_HST_TRANSACAO is
'Número identificador do registro histórico';

comment on column TB_HST_TRANSACAO.ID_TRANSACAO is
'Número identificador da transação';

comment on column TB_HST_TRANSACAO.HS_TRANSACAO is
'Hash de rastro da transação';

comment on column TB_HST_TRANSACAO.ID_CONTA is
'Número identificador da conta que recebeu a transação';

comment on column TB_HST_TRANSACAO.ID_TP_CANAL is
'Número identificador do tipo de canal';

comment on column TB_HST_TRANSACAO.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_HST_TRANSACAO.FL_DEBITO_CREDITO is
'Flag indicador da direção da transação , crédito ou débito';

comment on column TB_HST_TRANSACAO.VL_TRANSACAO is
'Valor da transação';

comment on column TB_HST_TRANSACAO.ID_STATUS_TRANSACAO is
'Número identificador do status da transação';

comment on column TB_HST_TRANSACAO.NM_USUARIO_TRANSACAO is
'Nome do usuário que criou a transação';

comment on column TB_HST_TRANSACAO.DT_HR_TRANSACAO is
'Data e hora em que a transação foi gerada';

comment on column TB_HST_TRANSACAO.DT_HR_HISTORICO is
'Data e hora em que o registro do histórico foi criado ';

/*==============================================================*/
/* Table: TB_REGRA_LIMITE                                       */
/*==============================================================*/
create table TB_REGRA_LIMITE (
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER(8,2)           not null,
   constraint PK_TB_REGRA_LIMITE primary key (ID_CONTA, ID_TP_TRANSACAO)
);

comment on table TB_REGRA_LIMITE is
'Tabela que contém as regras de valor de limite por  conta e tipo de transação';

comment on column TB_REGRA_LIMITE.ID_CONTA is
'Número identificador da conta';

comment on column TB_REGRA_LIMITE.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_REGRA_LIMITE.VL_LIMITE is
'Valor de limite por conta e transação';

/*==============================================================*/
/* Index: TP_TRANS_REGRA_LIMITE                                 */
/*==============================================================*/
create index TP_TRANS_REGRA_LIMITE on TB_REGRA_LIMITE (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: CONTA_REGRA_LIMITE                                    */
/*==============================================================*/
create index CONTA_REGRA_LIMITE on TB_REGRA_LIMITE (
   ID_CONTA ASC
);

/*==============================================================*/
/* Table: TB_SOLICITACAO_TRANSACAO                              */
/*==============================================================*/
create table TB_SOLICITACAO_TRANSACAO (
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_TRANSACAO         NUMBER(8,2)           not null,
   DT_HR_TRANSACAO      DATE                  not null,
   constraint PK_TB_SOLICITACAO_TRANSACAO primary key (HS_TRANSACAO)
);

comment on table TB_SOLICITACAO_TRANSACAO is
'Tabela de solicitação de transação. Esta tabela recebe as solicitações de transação e já realiza a tentativa d eentrada de uma mesma transação mais de uma vez.';

comment on column TB_SOLICITACAO_TRANSACAO.HS_TRANSACAO is
'Hash que identifica a transação, ele é montado a partir dos dados de conta, tipo de canal, tipo de transação, valor da transação e data e hora da transação ';

comment on column TB_SOLICITACAO_TRANSACAO.ID_TP_CANAL is
'Número identificador do tipo de canal';

comment on column TB_SOLICITACAO_TRANSACAO.ID_CONTA is
'Número identificador da conta';

comment on column TB_SOLICITACAO_TRANSACAO.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_SOLICITACAO_TRANSACAO.VL_TRANSACAO is
'Valor da transação';

comment on column TB_SOLICITACAO_TRANSACAO.DT_HR_TRANSACAO is
'Data e hora da transação';

/*==============================================================*/
/* Index: TP_CANAL_SOLIC_TRANS                                  */
/*==============================================================*/
create index TP_CANAL_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_TP_CANAL ASC
);

/*==============================================================*/
/* Index: CONTA_SOLIC_TRANS                                     */
/*==============================================================*/
create index CONTA_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_CONTA ASC
);

/*==============================================================*/
/* Index: TIPO_TRANS_SOLIC_TRANS                                */
/*==============================================================*/
create index TIPO_TRANS_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Table: TB_TRANSACAO                                          */
/*==============================================================*/
create table TB_TRANSACAO (
   ID_TRANSACAO         NUMBER                not null,
   HS_SOLIC_TRANS       VARCHAR2(50)          not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   ID_TP_CANAL          NUMBER                not null,
   FL_DEBITO_CREDITO    CHAR(1)               not null
      constraint CKC_FL_DEBITO_CREDITO_TB_TRANS check (FL_DEBITO_CREDITO in ('D','C')),
   VL_TRANSACAO         NUMBER(8,2)           not null,
   ID_STATUS_TRANSACAO  NUMBER                not null,
   NM_USUARIO_TRANSACAO VARCHAR2(100)         not null,
   DT_HR_TRANSACAO      DATE                  not null,
   constraint PK_TB_TRANSACAO primary key (ID_TRANSACAO),
   constraint AK_AK_TRANSACAO_TB_TRANS unique (HS_SOLIC_TRANS)
);

comment on table TB_TRANSACAO is
'Tabela que armazena transações financeiras';

comment on column TB_TRANSACAO.ID_TRANSACAO is
'Número identificador das transação';

comment on column TB_TRANSACAO.HS_SOLIC_TRANS is
'Hash da solicitação da transação, utilizado para rastreio e para evitar a entrada da mesma solicitação de transação mais de uma vez';

comment on column TB_TRANSACAO.ID_CONTA is
'Número identificador da conta';

comment on column TB_TRANSACAO.ID_TP_TRANSACAO is
'Número identificador de tipo de transação';

comment on column TB_TRANSACAO.ID_TP_CANAL is
'Número identificador de tipo de canal';

comment on column TB_TRANSACAO.FL_DEBITO_CREDITO is
'Flag indicadora da direção da transação. Aceita os valores:
D- Débito
C- Crédito ';

comment on column TB_TRANSACAO.VL_TRANSACAO is
'Valor da transação';

comment on column TB_TRANSACAO.ID_STATUS_TRANSACAO is
'Campo que indica qual o status atual da transação. Aceita os valores contidos na tabela de domínio TB_DOM_STATUS_TRANSACAO
';

comment on column TB_TRANSACAO.NM_USUARIO_TRANSACAO is
'Nome do usuário que criou a transação';

comment on column TB_TRANSACAO.DT_HR_TRANSACAO is
'Campo que registra a data e a hora, em que a transação foi registrada.';

/*==============================================================*/
/* Index: TIPO_TRANS_TRANS                                      */
/*==============================================================*/
create index TIPO_TRANS_TRANS on TB_TRANSACAO (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: ST_TRANS_TRANS                                        */
/*==============================================================*/
create index ST_TRANS_TRANS on TB_TRANSACAO (
   ID_STATUS_TRANSACAO ASC
);

/*==============================================================*/
/* Index: REGRA_LIMITE_TRANS                                    */
/*==============================================================*/
create index REGRA_LIMITE_TRANS on TB_TRANSACAO (
   ID_CONTA ASC,
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: SOLIC_TRANS_TRANS                                     */
/*==============================================================*/
create index SOLIC_TRANS_TRANS on TB_TRANSACAO (
   HS_SOLIC_TRANS ASC
);

/*==============================================================*/
/* Index: TIPO_CANAL_TRANS                                      */
/*==============================================================*/
create index TIPO_CANAL_TRANS on TB_TRANSACAO (
   ID_TP_CANAL ASC
);

alter table TABELA_CLIENTE_CONTA
   add constraint FK_TABELA_C_CLIENTE_C_TB_CLIEN foreign key (ID_CLIENTE)
      references TB_CLIENTE (ID_CLIENTE);

alter table TABELA_CLIENTE_CONTA
   add constraint FK_TABELA_C_CONTA_CLI_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_CONTA
   add constraint FK_TB_CONTA_CONTA_AGE_TB_DOM_A foreign key (CD_AGENCIA)
      references TB_DOM_AGENCIA (CD_AGENCIA);

alter table TB_REGRA_LIMITE
   add constraint FK_TB_REGRA_CONTA_REG_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_REGRA_LIMITE
   add constraint FK_TB_REGRA_TP_TRANS__TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANSACAO (ID_TP_TRANSACAO);

alter table TB_SOLICITACAO_TRANSACAO
   add constraint FK_TB_SOLIC_CONTA_SOL_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_SOLICITACAO_TRANSACAO
   add constraint FK_TB_SOLIC_TIPO_TRAN_TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANSACAO (ID_TP_TRANSACAO);

alter table TB_SOLICITACAO_TRANSACAO
   add constraint FK_TB_SOLIC_TP_CANAL__TB_DOM_T foreign key (ID_TP_CANAL)
      references TB_DOM_TP_CANAL (ID_TP_CANAL);

alter table TB_TRANSACAO
   add constraint FK_TB_TRANS_REGRA_LIM_TB_REGRA foreign key (ID_CONTA, ID_TP_TRANSACAO)
      references TB_REGRA_LIMITE (ID_CONTA, ID_TP_TRANSACAO);

alter table TB_TRANSACAO
   add constraint FK_TB_TRANS_SOLIC_TRA_TB_SOLIC foreign key (HS_SOLIC_TRANS)
      references TB_SOLICITACAO_TRANSACAO (HS_TRANSACAO);

alter table TB_TRANSACAO
   add constraint FK_TB_TRANS_ST_TRANS__TB_DOM_S foreign key (ID_STATUS_TRANSACAO)
      references TB_DOM_STATUS_TRANSACAO (ID_STATUS_TRANSACAO);

alter table TB_TRANSACAO
   add constraint FK_TB_TRANS_TIPO_CANA_TB_DOM_T foreign key (ID_TP_CANAL)
      references TB_DOM_TP_CANAL (ID_TP_CANAL);

alter table TB_TRANSACAO
   add constraint FK_TB_TRANS_TIPO_TRAN_TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANSACAO (ID_TP_TRANSACAO);

