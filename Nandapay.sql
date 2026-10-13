/*==============================================================*/
/* Database name:  DB_NANDAPAY                                  */
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     14/09/2021 05:25:15                          */
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

/*==============================================================*/
/* Table: TB_CONTA                                              */
/*==============================================================*/
create table TB_CONTA (
   ID_CONTA             NUMBER                not null,
   CD_CONTA             VARCHAR2(10)          not null,
   CD_AGENCIA           VARCHAR2(10)          not null,
   ST_CONTA             CHAR(1)               not null,
   DT_CRIACAO_CONTA     DATE,
   constraint PK_TB_CONTA primary key (ID_CONTA),
   constraint AK_AK_CONTA_TB_CONTA unique (CD_CONTA, CD_AGENCIA)
);

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

/*==============================================================*/
/* Table: TB_DOM_STATUS_TRANSACAO                               */
/*==============================================================*/
create table TB_DOM_STATUS_TRANSACAO (
   ID_STATUS_TRANSACAO  NUMBER                not null,
   NM_STATUS_TRANSACAO  VARCHAR2(50)          not null,
   constraint PK_TB_DOM_STATUS_TRANSACAO primary key (ID_STATUS_TRANSACAO)
);

/*==============================================================*/
/* Table: TB_DOM_TP_CANAL                                       */
/*==============================================================*/
create table TB_DOM_TP_CANAL (
   ID_TP_CANAL          NUMBER                not null,
   NM_TP_CANAL          VARCHAR2(100)         not null,
   constraint PK_TB_DOM_TP_CANAL primary key (ID_TP_CANAL)
);

/*==============================================================*/
/* Table: TB_DOM_TP_TRANSACAO                                   */
/*==============================================================*/
create table TB_DOM_TP_TRANSACAO (
   ID_TP_TRANSACAO      NUMBER                not null,
   NM_TP_TRANSACAO      VARCHAR2(100)         not null,
   constraint PK_TB_DOM_TP_TRANSACAO primary key (ID_TP_TRANSACAO)
);

/*==============================================================*/
/* Table: TB_HST_LIMITE_CONSUMIDO                               */
/*==============================================================*/
create table TB_HST_LIMITE_CONSUMIDO (
   ID_HST_LIMITE_CONSUMIDO NUMBER                not null,
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   HASH_ID_REGISTRO     VARCHAR2(50)          not null,
   VL_LIMITE_CONSUMIDO  NUMBER(8,2)           not null,
   VL_LIMITE_RESTANTE   NUMBER(8,2)           not null,
   DT_USO_LIMITE        DATE                  not null,
   constraint PK_TB_HST_LIMITE_CONSUMIDO primary key (ID_HST_LIMITE_CONSUMIDO)
);

/*==============================================================*/
/* Table: TB_HST_REGRA_LIMITE                                   */
/*==============================================================*/
create table TB_HST_REGRA_LIMITE (
   ID_HST_REGRA_LIMITE  NUMBER                not null,
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER(8,2)           not null,
   DT_HR_HISTORICO      DATE                  not null,
   constraint PK_TB_HST_REGRA_LIMITE primary key (ID_HST_REGRA_LIMITE)
);

/*==============================================================*/
/* Table: TB_HST_TRANSACAO                                      */
/*==============================================================*/
create table TB_HST_TRANSACAO (
   ID_HST_TRANSACAO     NUMBER                not null,
   ID_TRANSACAO         NUMBER                not null,
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER                not null,
   FL_DEBITO_CREDITO    CHAR(1)               not null,
   VL_TRANSACAO         NUMBER(8,2)           not null,
   ID_STATUS_TRANSACAO  NUMBER                not null,
   DT_HR_TRANSACAO      DATE                  not null,
   DT_HR_HISTORICO      DATE                  not null,
   constraint PK_TB_HST_TRANSACAO primary key (ID_HST_TRANSACAO)
);

/*==============================================================*/
/* Table: TB_LIMITE_CONSUMIDO                                   */
/*==============================================================*/
create table TB_LIMITE_CONSUMIDO (
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   HASH_ID_REGISTRO     VARCHAR2(50)          not null,
   VL_LIMITE_CONSUMIDO  NUMBER(8,2)           not null,
   VL_LIMITE_RESTANTE   NUMBER(8,2)           not null,
   DT_USO_LIMITE        DATE                  not null,
   constraint AK_AK_LIMITE_CONSUMID_TB_LIMIT unique (ID_CLIENTE, ID_CONTA, ID_TP_TRANSACAO, DT_USO_LIMITE)
);

/*==============================================================*/
/* Index: REGRA_LIM_CONSUMIDO                                   */
/*==============================================================*/
create index REGRA_LIM_CONSUMIDO on TB_LIMITE_CONSUMIDO (
   ID_CLIENTE ASC,
   ID_CONTA ASC,
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Table: TB_REGRA_LIMITE                                       */
/*==============================================================*/
create table TB_REGRA_LIMITE (
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_LIMITE            NUMBER(8,2)           not null,
   constraint PK_TB_REGRA_LIMITE primary key (ID_CLIENTE, ID_CONTA, ID_TP_TRANSACAO)
);

/*==============================================================*/
/* Index: IDX_TP_TRANS_REGRA_LIMITE                             */
/*==============================================================*/
create index IDX_TP_TRANS_REGRA_LIMITE on TB_REGRA_LIMITE (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: IDX_CLIENTE_REGRA_LIMITE                              */
/*==============================================================*/
create index IDX_CLIENTE_REGRA_LIMITE on TB_REGRA_LIMITE (
   ID_CLIENTE ASC
);

/*==============================================================*/
/* Index: IDX_CONTA_REGRA_LIMITE                                */
/*==============================================================*/
create index IDX_CONTA_REGRA_LIMITE on TB_REGRA_LIMITE (
   ID_CONTA ASC
);

/*==============================================================*/
/* Table: TB_SOLICITACAO_TRANSACAO                              */
/*==============================================================*/
create table TB_SOLICITACAO_TRANSACAO (
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_TP_CANAL          NUMBER                not null,
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   VL_TRANSACAO         NUMBER(8,2)           not null,
   DT_HR_TRANSACAO      DATE                  not null,
   constraint PK_TB_SOLICITACAO_TRANSACAO primary key (HS_TRANSACAO)
);

/*==============================================================*/
/* Index: IDX_TP_CANAL_SOLIC_TRANS                              */
/*==============================================================*/
create index IDX_TP_CANAL_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_TP_CANAL ASC
);

/*==============================================================*/
/* Index: IDX_CLIENTE_SOLIC_TRANS                               */
/*==============================================================*/
create index IDX_CLIENTE_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_CLIENTE ASC
);

/*==============================================================*/
/* Index: IDX_CONTA_SOLIC_TRANS                                 */
/*==============================================================*/
create index IDX_CONTA_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_CONTA ASC
);

/*==============================================================*/
/* Index: IDX_TIPO_TRANS_SOLIC_TRANS                            */
/*==============================================================*/
create index IDX_TIPO_TRANS_SOLIC_TRANS on TB_SOLICITACAO_TRANSACAO (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Table: TB_TRANSACAO                                          */
/*==============================================================*/
create table TB_TRANSACAO (
   ID_TRANSACAO         NUMBER                not null,
   HS_TRANSACAO         VARCHAR2(50)          not null,
   ID_CLIENTE           NUMBER                not null,
   ID_CONTA             NUMBER                not null,
   ID_TP_TRANSACAO      NUMBER                not null,
   ID_TP_CANAL          NUMBER                not null,
   VL_LIMITE            NUMBER                not null,
   FL_DEBITO_CREDITO    CHAR(1)               not null
      constraint CKC_FL_DEBITO_CREDITO_TB_TRANS check (FL_DEBITO_CREDITO in ('D','C')),
   VL_TRANSACAO         NUMBER(8,2)           not null,
   ID_STATUS_TRANSACAO  NUMBER                not null,
   DT_HR_TRANSACAO      DATE                  not null,
   constraint PK_TB_TRANSACAO primary key (ID_TRANSACAO),
   constraint AK_AK_TRANSACAO_TB_TRANS unique (HS_TRANSACAO)
);

/*==============================================================*/
/* Index: IDX_TIPO_TRANS_TRANS                                  */
/*==============================================================*/
create index IDX_TIPO_TRANS_TRANS on TB_TRANSACAO (
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: IDX_ST_TRANS_TRANS                                    */
/*==============================================================*/
create index IDX_ST_TRANS_TRANS on TB_TRANSACAO (
   ID_STATUS_TRANSACAO ASC
);

/*==============================================================*/
/* Index: IDX_REGRA_LIMITE_TRANS                                */
/*==============================================================*/
create index IDX_REGRA_LIMITE_TRANS on TB_TRANSACAO (
   ID_CLIENTE ASC,
   ID_CONTA ASC,
   ID_TP_TRANSACAO ASC
);

/*==============================================================*/
/* Index: IDX_SOLIC_TRANS_TRANS                                 */
/*==============================================================*/
create index IDX_SOLIC_TRANS_TRANS on TB_TRANSACAO (
   HS_TRANSACAO ASC
);

/*==============================================================*/
/* Index: IDX_TIPO_CANAL_TRANS                                  */
/*==============================================================*/
create index IDX_TIPO_CANAL_TRANS on TB_TRANSACAO (
   ID_TP_CANAL ASC
);

alter table TB_CONTA
   add constraint FK_TB_CONTA_CONTA_AGE_TB_DOM_A foreign key (CD_AGENCIA)
      references TB_DOM_AGENCIA (CD_AGENCIA);

alter table TB_LIMITE_CONSUMIDO
   add constraint FK_TB_LIMIT_REGRA_LIM_TB_REGRA foreign key (ID_CLIENTE, ID_CONTA, ID_TP_TRANSACAO)
      references TB_REGRA_LIMITE (ID_CLIENTE, ID_CONTA, ID_TP_TRANSACAO);

alter table TB_REGRA_LIMITE
   add constraint FK_TB_REGRA_CLIENTE_R_TB_CLIEN foreign key (ID_CLIENTE)
      references TB_CLIENTE (ID_CLIENTE);

alter table TB_REGRA_LIMITE
   add constraint FK_TB_REGRA_CONTA_REG_TB_CONTA foreign key (ID_CONTA)
      references TB_CONTA (ID_CONTA);

alter table TB_REGRA_LIMITE
   add constraint FK_TB_REGRA_TP_TRANS__TB_DOM_T foreign key (ID_TP_TRANSACAO)
      references TB_DOM_TP_TRANSACAO (ID_TP_TRANSACAO);

alter table TB_SOLICITACAO_TRANSACAO
   add constraint FK_TB_SOLIC_CLIENTE_S_TB_CLIEN foreign key (ID_CLIENTE)
      references TB_CLIENTE (ID_CLIENTE);

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
   add constraint FK_TB_TRANS_REGRA_LIM_TB_REGRA foreign key (ID_CLIENTE, ID_CONTA, ID_TP_TRANSACAO)
      references TB_REGRA_LIMITE (ID_CLIENTE, ID_CONTA, ID_TP_TRANSACAO);

alter table TB_TRANSACAO
   add constraint FK_TB_TRANS_SOLIC_TRA_TB_SOLIC foreign key (HS_TRANSACAO)
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

