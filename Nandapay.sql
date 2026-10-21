/*==============================================================*/
/* Database name:  DB_NANDAPAY                                  */
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     14/09/2021 03:01:31                          */
/*==============================================================*/


/*==============================================================*/
/* Database: DB_NANDAPAY                                        */
/*==============================================================*/
create database DB_NANDAPAY;

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
/* Table: TB_CLI_CONTA                                          */
/*==============================================================*/
create table TB_CLI_CONTA (
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   constraint PK_TB_CLI_CONTA primary key (ID_CLIENTE, ID_CONTA)
);

comment on table TB_CLI_CONTA is
'Tabela pivot entre cliente e conta ';

comment on column TB_CLI_CONTA.ID_CLIENTE is
'Número identificador do cliente';

comment on column TB_CLI_CONTA.ID_CONTA is
'Número identificador da conta';

/*==============================================================*/
/* Index: CLIENTE_CLIENTE_CONTA                                 */
/*==============================================================*/
create index CLIENTE_CLIENTE_CONTA on TB_CLI_CONTA (
   ID_CLIENTE ASC
);

/*==============================================================*/
/* Index: CONTA_CLIENTE_CONTA                                   */
/*==============================================================*/
create index CONTA_CLIENTE_CONTA on TB_CLI_CONTA (
   ID_CONTA ASC
);

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
/* Table: TB_DOM_STS_TRANS                                      */
/*==============================================================*/
create table TB_DOM_STS_TRANS (
   ID_STATUS_TRANSACAO  NUMBER                not null,
   NM_STATUS_TRANSACAO  VARCHAR2(50)          not null,
   constraint PK_TB_DOM_STS_TRANS primary key (ID_STATUS_TRANSACAO)
);

comment on table TB_DOM_STS_TRANS is
'Tabela de domínio de status da transação';

comment on column TB_DOM_STS_TRANS.ID_STATUS_TRANSACAO is
'Número identificador do status da transação';

comment on column TB_DOM_STS_TRANS.NM_STATUS_TRANSACAO is
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
/* Table: TB_DOM_TP_TRANS                                       */
/*==============================================================*/
create table TB_DOM_TP_TRANS (
   ID_TP_TRANSACAO      NUMBER                not null,
   NM_TP_TRANSACAO      VARCHAR2(100)         not null,
   constraint PK_TB_DOM_TP_TRANS primary key (ID_TP_TRANSACAO)
);

comment on table TB_DOM_TP_TRANS is
'Tabela de domínio do tipo da transação';

comment on column TB_DOM_TP_TRANS.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_DOM_TP_TRANS.NM_TP_TRANSACAO is
'Nome do tipo de transação';

/*==============================================================*/
/* Table: TB_HST_REG_LIM                                        */
/*==============================================================*/
create table TB_HST_REG_LIM (
   ID_HST_REGRA_LIMITE  NUMBER                not null,
   ID_REG_LIM           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER(8,2)           not null,
   DT_HR_HISTORICO      DATE                  not null,
   constraint PK_TB_HST_REG_LIM primary key (ID_HST_REGRA_LIMITE)
);

comment on column TB_HST_REG_LIM.ID_HST_REGRA_LIMITE is
'Número identificador do registro da tabela de histórico';

comment on column TB_HST_REG_LIM.ID_REG_LIM is
'Identificador da regra de limite';

comment on column TB_HST_REG_LIM.ID_CONTA is
'Número identificador da conta';

comment on column TB_HST_REG_LIM.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_HST_REG_LIM.VL_LIMITE is
'Valor limite da transação';

comment on column TB_HST_REG_LIM.DT_HR_HISTORICO is
'Data e hora da entrada do registro na tabela de histórico';

/*==============================================================*/
/* Table: TB_HST_SOLIC_TRANS                                    */
/*==============================================================*/
create table TB_HST_SOLIC_TRANS (
   ID_HST_SOLIC_TRANS   NUMBER                not null,
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   ID_STATUS_TRANSACAO  NUMBER                not null,
   VL_TRANSACAO         NUMBER(8,2)           not null,
   DT_HR_TRANSACAO      DATE                  not null,
   DT_HR_HST            DATE,
   constraint PK_TB_HST_SOLIC_TRANS primary key (ID_HST_SOLIC_TRANS)
)
   partition by range
    (DT_HR_HST)
       (
           partition Q_2026
    values less than (TIMESTAMP '2027-01-01 00:00:00'),
           partition Q_2027
    values less than (TIMESTAMP '2028-01-01 00:00:00')
       );

comment on table TB_HST_SOLIC_TRANS is
'Tabela de histórico de solicitação de transação. Esta tabela guarda histórico do registro de solicitação de transação.';

comment on column TB_HST_SOLIC_TRANS.ID_HST_SOLIC_TRANS is
'Identificador do registro de histórico de solicitação de transação';

comment on column TB_HST_SOLIC_TRANS.HS_TRANSACAO is
'Hash que identifica a transação, ele é montado a partir dos dados de conta, tipo de canal, tipo de transação, valor da transação e data e hora da transação ';

comment on column TB_HST_SOLIC_TRANS.ID_TP_CANAL is
'Número identificador do tipo de canal';

comment on column TB_HST_SOLIC_TRANS.ID_CONTA is
'Número identificador da conta';

comment on column TB_HST_SOLIC_TRANS.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_HST_SOLIC_TRANS.ID_STATUS_TRANSACAO is
'Número identificador do status da transação';

comment on column TB_HST_SOLIC_TRANS.VL_TRANSACAO is
'Valor da transação';

comment on column TB_HST_SOLIC_TRANS.DT_HR_TRANSACAO is
'Data e hora da transação';

/*==============================================================*/
/* Index: IDX_DT_HR_HST                                         */
/*==============================================================*/
create index IDX_DT_HR_HST on TB_HST_SOLIC_TRANS (
   DT_HR_HST ASC
);

/*==============================================================*/
/* Table: TB_REG_LIM                                            */
/*==============================================================*/
create table TB_REG_LIM (
   ID_REG_LIM           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER(8,2)           not null,
   constraint PK_TB_REG_LIM primary key (ID_REG_LIM)
);

comment on table TB_REG_LIM is
'Tabela que contém as regras de valor de limite por  conta e tipo de transação';

comment on column TB_REG_LIM.ID_REG_LIM is
'Identificador único da regra de limite';

comment on column TB_REG_LIM.ID_CONTA is
'Número identificador da conta';

comment on column TB_REG_LIM.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_REG_LIM.VL_LIMITE is
'Valor de limite por conta e transação';

/*==============================================================*/
/* Index: TP_TRANS_REGRA_LIMITE                                 */
/*==============================================================*/
create index TP_TRANS_REGRA_LIMITE on TB_REG_LIM (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: CONTA_REGRA_LIMITE                                    */
/*==============================================================*/
create index CONTA_REGRA_LIMITE on TB_REG_LIM (
   ID_CONTA ASC
);

/*==============================================================*/
/* Table: TB_SOLIC_TRANS                                        */
/*==============================================================*/
create table TB_SOLIC_TRANS (
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   ID_STATUS_TRANSACAO  NUMBER                not null,
   ID_REG_LIM           NUMBER                not null,
   VL_TRANSACAO         NUMBER(8,2)           not null,
   DT_HR_TRANSACAO      DATE                  not null,
   constraint PK_TB_SOLIC_TRANS primary key (HS_TRANSACAO)
)
   partition by range
    (DT_HR_TRANSACAO)
       (
           partition Q_2026
    values less than (TIMESTAMP '2027-01-01 00:00:00'),
           partition Q_2027
    values less than (TIMESTAMP '2028-01-01 00:00:00')
       );

comment on table TB_SOLIC_TRANS is
'Tabela de solicitação de transação. Esta tabela recebe as solicitações de transação e já realiza a tentativa de entrada de uma mesma transação mais de uma vez.';

comment on column TB_SOLIC_TRANS.HS_TRANSACAO is
'Hash que identifica a transação, ele é montado a partir dos dados de conta, tipo de canal, tipo de transação, valor da transação e data e hora da transação ';

comment on column TB_SOLIC_TRANS.ID_TP_CANAL is
'Número identificador do tipo de canal';

comment on column TB_SOLIC_TRANS.ID_CONTA is
'Número identificador da conta';

comment on column TB_SOLIC_TRANS.ID_TP_TRANSACAO is
'Número identificador do tipo de transação';

comment on column TB_SOLIC_TRANS.ID_STATUS_TRANSACAO is
'Número identificador do status da transação';

comment on column TB_SOLIC_TRANS.ID_REG_LIM is
'Identificador único da regra de limite';

comment on column TB_SOLIC_TRANS.VL_TRANSACAO is
'Valor da transação';

comment on column TB_SOLIC_TRANS.DT_HR_TRANSACAO is
'Data e hora da transação';

/*==============================================================*/
/* Index: TP_CANAL_SOLIC_TRANS                                  */
/*==============================================================*/
create index TP_CANAL_SOLIC_TRANS on TB_SOLIC_TRANS (
   ID_TP_CANAL ASC
);

/*==============================================================*/
/* Index: CONTA_SOLIC_TRANS                                     */
/*==============================================================*/
create index CONTA_SOLIC_TRANS on TB_SOLIC_TRANS (
   ID_CONTA ASC
);

/*==============================================================*/
/* Index: TIPO_TRANS_SOLIC_TRANS                                */
/*==============================================================*/
create index TIPO_TRANS_SOLIC_TRANS on TB_SOLIC_TRANS (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: STATUS_SOLIC_TRANS                                    */
/*==============================================================*/
create index STATUS_SOLIC_TRANS on TB_SOLIC_TRANS (
   ID_STATUS_TRANSACAO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_14                                       */
/*==============================================================*/
create index RELATIONSHIP_14 on TB_SOLIC_TRANS (
   ID_REG_LIM ASC
);

/*==============================================================*/
/* Index: IDX_DT_HR_TRANS                                       */
/*==============================================================*/
create index IDX_DT_HR_TRANS on TB_SOLIC_TRANS (
   DT_HR_TRANSACAO ASC
);

/*==============================================================*/
/* Table: TB_TRANS                                              */
/*==============================================================*/
create table TB_TRANS (
   ID_TRANSACAO         NUMBER                not null,
   HS_SOLIC_TRANS       VARCHAR2(50)          not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_REG_LIM           NUMBER                not null,
   FL_DEBITO_CREDITO    CHAR(1)               not null
      constraint CKC_FL_DEBITO_CREDITO_TB_TRANS check (FL_DEBITO_CREDITO in ('D','C')),
   VL_TRANSACAO         NUMBER(8,2)           not null,
   NM_USUARIO_TRANSACAO VARCHAR2(100)         not null,
   DT_HR_TRANSACAO      DATE                  not null,
   constraint PK_TB_TRANS primary key (ID_TRANSACAO),
   constraint AK_AK_TRANSACAO_TB_TRANS unique (HS_SOLIC_TRANS)
)
   partition by range
    (DATA_HORA_TRANSACAO)
       (
           partition Q_2026
    values less than (TIMESTAMP '2027-01-01 00:00:00'),
           partition Q_2027
    values less than (TIMESTAMP '2028-01-01 00:00:00')
       );

comment on table TB_TRANS is
'Tabela que armazena transações financeiras';

comment on column TB_TRANS.ID_TRANSACAO is
'Número identificador das transação';

comment on column TB_TRANS.HS_SOLIC_TRANS is
'Hash da solicitação da transação, utilizado para rastreio e para evitar a entrada da mesma solicitação de transação mais de uma vez';

comment on column TB_TRANS.ID_TP_TRANSACAO is
'Número identificador de tipo de transação';

comment on column TB_TRANS.ID_TP_CANAL is
'Número identificador de tipo de canal';

comment on column TB_TRANS.ID_REG_LIM is
'Identificador único da regra de limite';

comment on column TB_TRANS.FL_DEBITO_CREDITO is
'Flag indicadora da direção da transação. Aceita os valores:
D- Débito
C- Crédito ';

comment on column TB_TRANS.VL_TRANSACAO is
'Valor da transação';

comment on column TB_TRANS.NM_USUARIO_TRANSACAO is
'Nome do usuário que criou a transação';

comment on column TB_TRANS.DT_HR_TRANSACAO is
'Campo que registra a data e a hora, em que a transação foi registrada.';

/*==============================================================*/
/* Index: TIPO_TRANS_TRANS                                      */
/*==============================================================*/
create index TIPO_TRANS_TRANS on TB_TRANS (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: REGRA_LIMITE_TRANS                                    */
/*==============================================================*/
create index REGRA_LIMITE_TRANS on TB_TRANS (
   ID_REG_LIM ASC
);

/*==============================================================*/
/* Index: SOLIC_TRANS_TRANS                                     */
/*==============================================================*/
create index SOLIC_TRANS_TRANS on TB_TRANS (
   HS_SOLIC_TRANS ASC
);

/*==============================================================*/
/* Index: TIPO_CANAL_TRANS                                      */
/*==============================================================*/
create index TIPO_CANAL_TRANS on TB_TRANS (
   ID_TP_CANAL ASC
);

/*==============================================================*/
/* Index: IDX_DATA_HORA_TRANSACAO                               */
/*==============================================================*/
create index IDX_DATA_HORA_TRANSACAO on TB_TRANS (
   DT_HR_TRANSACAO ASC
);

alter table TB_CLI_CONTA
   add constraint FK_TB_CLI_C_CLIENTE_C_TB_CLIEN foreign key (ID_CLIENTE)
      references TB_CLIENTE (ID_CLIENTE);

alter table TB_CLI_CONTA
   add constraint FK_TB_CLI_C_CONTA_CLI_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_CONTA
   add constraint FK_TB_CONTA_CONTA_AGE_TB_DOM_A foreign key (CD_AGENCIA)
      references TB_DOM_AGENCIA (CD_AGENCIA);

alter table TB_REG_LIM
   add constraint FK_TB_REG_L_CONTA_REG_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_REG_LIM
   add constraint FK_TB_REG_L_TP_TRANS__TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANS (ID_TP_TRANSACAO);

alter table TB_SOLIC_TRANS
   add constraint FK_TB_SOLIC_CONTA_SOL_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_SOLIC_TRANS
   add constraint FK_TB_SOLIC_RELATIONS_TB_REG_L foreign key (ID_REG_LIM)
      references TB_REG_LIM (ID_REG_LIM);

alter table TB_SOLIC_TRANS
   add constraint FK_TB_SOLIC_STATUS_SO_TB_DOM_S foreign key (ID_STATUS_TRANSACAO)
      references TB_DOM_STS_TRANS (ID_STATUS_TRANSACAO);

alter table TB_SOLIC_TRANS
   add constraint FK_TB_SOLIC_TIPO_TRAN_TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANS (ID_TP_TRANSACAO);

alter table TB_SOLIC_TRANS
   add constraint FK_TB_SOLIC_TP_CANAL__TB_DOM_T foreign key (ID_TP_CANAL)
      references TB_DOM_TP_CANAL (ID_TP_CANAL);

alter table TB_TRANS
   add constraint FK_TB_TRANS_REGRA_LIM_TB_REG_L foreign key (ID_REG_LIM)
      references TB_REG_LIM (ID_REG_LIM);

alter table TB_TRANS
   add constraint FK_TB_TRANS_SOLIC_TRA_TB_SOLIC foreign key (HS_SOLIC_TRANS)
      references TB_SOLIC_TRANS (HS_TRANSACAO);

alter table TB_TRANS
   add constraint FK_TB_TRANS_TIPO_CANA_TB_DOM_T foreign key (ID_TP_CANAL)
      references TB_DOM_TP_CANAL (ID_TP_CANAL);

alter table TB_TRANS
   add constraint FK_TB_TRANS_TIPO_TRAN_TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANS (ID_TP_TRANSACAO);

