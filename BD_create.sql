-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-08-29 19:44:26.097

-- tables
-- Table: detalhes_envio
CREATE TABLE detalhes_envio (
    id int NOT NULL AUTO_INCREMENT,
    pedido_id int NOT NULL,
    metodo_envio varchar(255) NOT NULL,
    numero_rastreamento varchar(255) NULL,
    status varchar(255) NOT NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    CONSTRAINT detalhes_envio_pk PRIMARY KEY (id)
);

-- Table: enderecos
CREATE TABLE enderecos (
    id int NOT NULL AUTO_INCREMENT,
    usuario_id int NOT NULL,
    pedido_id int NULL,
    rua varchar(255) NOT NULL,
    cidade varchar(255) NOT NULL,
    estado varchar(255) NOT NULL,
    cep varchar(20) NOT NULL,
    pais varchar(100) NOT NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    CONSTRAINT enderecos_pk PRIMARY KEY (id)
);

-- Table: logs
CREATE TABLE logs (
    id int NOT NULL AUTO_INCREMENT,
    usuario_id int NOT NULL,
    acao varchar(255) NOT NULL,
    endereco_ip varchar(45) NULL,
    localizacao varchar(255) NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    CONSTRAINT logs_pk PRIMARY KEY (id)
);

-- Table: metodos_pagamento
CREATE TABLE metodos_pagamento (
    id int NOT NULL AUTO_INCREMENT,
    usuario_id int NOT NULL,
    pedido_id int NULL,
    tipo_metodo varchar(50) NOT NULL,
    numero_cartao varchar(20) NULL,
    nome_titular_cartao varchar(255) NULL,
    cpf varchar(14) NULL,
    endereco_cobranca_id int NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    CONSTRAINT metodos_pagamento_pk PRIMARY KEY (id)
);

-- Table: pedidos
CREATE TABLE pedidos (
    id int NOT NULL AUTO_INCREMENT,
    usuario_id int NOT NULL,
    nome_produto varchar(255) NOT NULL,
    preco_produto decimal(10,2) NOT NULL,
    quantidade int NOT NULL,
    total decimal(10,2) NOT NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    CONSTRAINT pedidos_pk PRIMARY KEY (id)
);

-- Table: produtos
CREATE TABLE produtos (
    id int NOT NULL AUTO_INCREMENT,
    nome varchar(255) NOT NULL,
    descricao text NULL,
    preco decimal(10,2) NOT NULL,
    quantidade_estoque int NOT NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    atualizado_em timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT produtos_pk PRIMARY KEY (id)
);

-- Table: transacoes
CREATE TABLE transacoes (
    id int NOT NULL AUTO_INCREMENT,
    pedido_id int NOT NULL,
    numero_cartao varchar(20) NULL,
    validade_cartao varchar(7) NULL,
    cvv_cartao varchar(4) NULL,
    nome_titular_cartao varchar(255) NULL,
    cpf varchar(14) NULL,
    endereco_cobranca text NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    CONSTRAINT transacoes_pk PRIMARY KEY (id)
);

-- Table: usuarios
CREATE TABLE usuarios (
    id int NOT NULL AUTO_INCREMENT,
    nome varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    senha varchar(255) NOT NULL,
    criado_em timestamp NULL DEFAULT current_timestamp,
    atualizado_em timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX AK_0 (email),
    CONSTRAINT usuarios_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: FK_0 (table: pedidos)
ALTER TABLE pedidos ADD CONSTRAINT FK_0 FOREIGN KEY FK_0 (usuario_id)
    REFERENCES usuarios (id);

-- Reference: FK_1 (table: transacoes)
ALTER TABLE transacoes ADD CONSTRAINT FK_1 FOREIGN KEY FK_1 (pedido_id)
    REFERENCES pedidos (id);

-- Reference: FK_2 (table: logs)
ALTER TABLE logs ADD CONSTRAINT FK_2 FOREIGN KEY FK_2 (usuario_id)
    REFERENCES usuarios (id);

-- Reference: FK_3 (table: enderecos)
ALTER TABLE enderecos ADD CONSTRAINT FK_3 FOREIGN KEY FK_3 (usuario_id)
    REFERENCES usuarios (id);

-- Reference: FK_4 (table: enderecos)
ALTER TABLE enderecos ADD CONSTRAINT FK_4 FOREIGN KEY FK_4 (pedido_id)
    REFERENCES pedidos (id);

-- Reference: FK_5 (table: metodos_pagamento)
ALTER TABLE metodos_pagamento ADD CONSTRAINT FK_5 FOREIGN KEY FK_5 (usuario_id)
    REFERENCES usuarios (id);

-- Reference: FK_6 (table: metodos_pagamento)
ALTER TABLE metodos_pagamento ADD CONSTRAINT FK_6 FOREIGN KEY FK_6 (pedido_id)
    REFERENCES pedidos (id);

-- Reference: FK_7 (table: metodos_pagamento)
ALTER TABLE metodos_pagamento ADD CONSTRAINT FK_7 FOREIGN KEY FK_7 (endereco_cobranca_id)
    REFERENCES enderecos (id);

-- Reference: FK_8 (table: detalhes_envio)
ALTER TABLE detalhes_envio ADD CONSTRAINT FK_8 FOREIGN KEY FK_8 (pedido_id)
    REFERENCES pedidos (id);

-- End of file.

