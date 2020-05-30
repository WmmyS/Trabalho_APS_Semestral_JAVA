/*Esta estrutura foi criada para gerar o banco de dados no PsotgreSQL
Para funcionar precisamos executar cada módulo de criação na mesma sequencia do documento*/
CREATE DATABASE bd_afrodite
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

CREATE TABLE tb_categoria
(
  cod_categoria serial NOT NULL,
  desc_categoria character varying(40) NOT NULL,
  CONSTRAINT pk_tb_categoria_cod_categoria PRIMARY KEY (cod_categoria),
  CONSTRAINT tb_categoria_desc_categoria_key UNIQUE (desc_categoria)
);

CREATE TABLE tb_cliente
(
  cod_cliente serial NOT NULL,
  nome_cliente character varying(50) NOT NULL,
  tipo_cliente integer,
  email_cliente character varying(40),
  apelido_cliente character varying(20),
  endereço_cliente character varying(40) NOT NULL,
  bairro_cliente character varying(20) NOT NULL,
  cidade_cliente character varying(20) NOT NULL,
  estado_cliente character varying(2) NOT NULL,
  cep_cliente character varying(10) NOT NULL,
  telefone1_cliente character varying(13) NOT NULL,
  telefone2_cliente character varying(13),
  data_nascimento_cliente character varying(13) NOT NULL,
  cpf_cliente character varying(20),
  rg_cliente character varying(20),
  cnpj_cliente character varying(20),
  ie_cliente character varying(20),
  CONSTRAINT pk_tb_cliente_cod_cliente PRIMARY KEY (cod_cliente),
  CONSTRAINT tb_cliente_cnpj_cliente_key UNIQUE (cnpj_cliente),
  CONSTRAINT tb_cliente_cpf_cliente_key UNIQUE (cpf_cliente),
  CONSTRAINT tb_cliente_ie_cliente_key UNIQUE (ie_cliente)
);

CREATE TABLE tb_fornecedor
(
  cod_fornecedor serial NOT NULL,
  tipo_fornecedor integer NOT NULL,
  nome_fornecedor character varying(40) NOT NULL,
  email_fornecedor character varying(40),
  apelido_fornecedor character varying(20),
  endereço_fornecedor character varying(40) NOT NULL,
  bairro_fornecedor character varying(20) NOT NULL,
  cidade_fornecedor character varying(20) NOT NULL,
  estado_fornecedor character varying(2) NOT NULL,
  cep_fornecedor character varying(10) NOT NULL,
  telefone1_fornecedor character varying(13) NOT NULL,
  telefone2_fornecedor character varying(13),
  data_nascimento_fornecedor character varying(13) NOT NULL,
  cnpj_fornecedor character varying(20),
  ie_fornecedor character varying(20),
  CONSTRAINT pk_tb_fornecedor_cod_fornecedor PRIMARY KEY (cod_fornecedor),
  CONSTRAINT tb_fornecedor_cnpj_fornecedor_key UNIQUE (cnpj_fornecedor),
  CONSTRAINT tb_fornecedor_ie_fornecedor_key UNIQUE (ie_fornecedor)
);

CREATE TABLE tb_mercadoria
(
  cod_mercadoria serial NOT NULL,
  desc_mercadoria character varying(60) NOT NULL,
  modelo_mercadoria character varying(60),
  cod_categoria integer NOT NULL,
  neces_estoque character varying(20),
  qtde_mercadoria integer,
  precoa_mercadoria double precision,
  precov_mercadoria double precision,
  qtde_min integer,
  CONSTRAINT pk_tb_mercadoria_cod_mercadoria PRIMARY KEY (cod_mercadoria),
  CONSTRAINT fk_tb_mercaoria_cod_categoria FOREIGN KEY (cod_categoria)
      REFERENCES tb_categoria (cod_categoria) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE tb_pedido
(
  cod_pedido serial NOT NULL,
  cod_cliente integer NOT NULL,
  data_pedido date,
  valor_pedido double precision,
  CONSTRAINT pk_tb_pedido_cod_pedido PRIMARY KEY (cod_pedido),
  CONSTRAINT fk_tb_pedido_cod_cliente FOREIGN KEY (cod_cliente)
      REFERENCES tb_cliente (cod_cliente) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE tb_notaentrada
(
  cod_nota integer NOT NULL,
  cod_fornecedor integer NOT NULL,
  data_nota character varying(50),
  CONSTRAINT pk_tb_notaentrada_cod_nota_fornecedor PRIMARY KEY (cod_nota, cod_fornecedor),
  CONSTRAINT fk_tb_notaentrada_cod_fornecedor FOREIGN KEY (cod_fornecedor)
      REFERENCES tb_fornecedor (cod_fornecedor) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

fazer depois de mercadoria e nota
CREATE TABLE tb_itensnota
(
  cod_nota integer NOT NULL,
  cod_fornecedor integer NOT NULL,
  cod_mercadoria integer NOT NULL,
  qtde_produto integer,
  valoraproduto double precision,
  valorvproduto double precision,
  CONSTRAINT pk_tb_itensnota_cod_nota_mercadoria PRIMARY KEY (cod_nota, cod_fornecedor, cod_mercadoria),
  CONSTRAINT fk_tb_itensnota_cod_mercadoria FOREIGN KEY (cod_mercadoria)
      REFERENCES tb_mercadoria (cod_mercadoria) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tb_itensnota_cod_nota FOREIGN KEY (cod_nota, cod_fornecedor)
      REFERENCES tb_notaentrada (cod_nota, cod_fornecedor) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE tb_itenspedido
(
  cod_pedido integer NOT NULL,
  cod_mercadoria integer NOT NULL,
  qtde_produto integer,
  valoruproduto double precision,
  valortproduto double precision,
  CONSTRAINT pk_tb_itenpedido_cod_pedido_mercadoria PRIMARY KEY (cod_pedido, cod_mercadoria),
  CONSTRAINT fk_tb_itenspedido_cod_mercadoria FOREIGN KEY (cod_mercadoria)
      REFERENCES tb_mercadoria (cod_mercadoria) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tb_itenspedido_cod_pedido FOREIGN KEY (cod_pedido)
      REFERENCES tb_pedido (cod_pedido) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
);

