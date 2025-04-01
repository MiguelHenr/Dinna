CREATE TABLE Usuario(
    id SERIAL NOT NULL,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,

    CONSTRAINT usuario_pk PRIMARY KEY (id)
);

CREATE TABLE GastosMensais(
    id SERIAL NOT NULL,
    mes_ano DATE NOT NULL,
    fk_usuario SERIAL NOT NULL,
    gasto_maximo FLOAT(2) NOT NULL,

    CONSTRAINT gastosmensais_pk PRIMARY KEY (id),
    CONSTRAINT fk_gastosmensais_usuario FOREIGN KEY (fk_usuario)
        REFERENCES Usuario(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Renda(
    id SERIAL NOT NULL,
    valor FLOAT(2) NOT NULL,
    fk_usuario SERIAL NOT NULL,

    CONSTRAINT renda_pk PRIMARY KEY (id),
    CONSTRAINT fk_renda_usuario FOREIGN KEY (fk_usuario)
        REFERENCES Usuario(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Alerta(
    id SERIAL NOT NULL,
    fk_usuario SERIAL NOT NULL,
    mensagem VARCHAR(255) NOT NULL,
    data DATE NOT NULL,

    CONSTRAINT alerta_pk PRIMARY KEY (id),
    CONSTRAINT fk_renda_usuario FOREIGN KEY (fk_usuario)
        REFERENCES Usuario(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Categoria(
    id SERIAL NOT NULL,
    fk_usuario SERIAL NOT NULL,
    nome VARCHAR(255) NOT NULL,

    CONSTRAINT categoria_pk PRIMARY KEY (id),
    CONSTRAINT fk_categoria_usuario FOREIGN KEY (fk_usuario)
        REFERENCES Usuario(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Despesa(
    id SERIAL NOT NULL,
    valor FLOAT(2) NOT NULL,
    fk_usuario INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    fk_categoria INT NOT NULL,
    data DATE NOT NULL,
    fk_gastos_mensais INT NOT NULL,

    CONSTRAINT despesa_pk PRIMARY KEY (id),
    CONSTRAINT fk_despesa_usuario FOREIGN KEY (fk_usuario)
        REFERENCES Usuario(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_despesa_categoria FOREIGN KEY (fk_categoria)
        REFERENCES Categoria(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_despesa_gastos_mensais FOREIGN KEY (fk_gastos_mensais)
        REFERENCES GastosMensais(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TYPE tipo_conta AS ENUM('crédito', 'débito', 'pix', 'dinheiro');

CREATE TABLE Pagamento(
    id SERIAL NOT NULL,
    valor FLOAT(2) NOT NULL,
    tipo_conta tipo_conta NOT NULL,
    fk_despesa INT UNIQUE NOT NULL,

    CONSTRAINT pagamento_pk PRIMARY KEY (id),
    CONSTRAINT fk_pagamento_despesa FOREIGN KEY (fk_despesa)
        REFERENCES Despesa(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Despesa ADD COLUMN fk_forma_pagamento INT UNIQUE;
ALTER TABLE Despesa ADD CONSTRAINT fk_despesa_forma_pagamento FOREIGN KEY (fk_forma_pagamento) REFERENCES Pagamento(id);
