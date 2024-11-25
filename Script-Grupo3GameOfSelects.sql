CREATE DATABASE pokemon;
USE pokemon;

-- Criação das tabelas
CREATE TABLE espectador (
    idApostador INT PRIMARY KEY AUTO_INCREMENT,
    vulgo VARCHAR(45)
);

CREATE TABLE competicao (
    idCompeticao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    dtInicio DATE,
    dtFim DATE,
    ganhador VARCHAR(45),
    premiacao DECIMAL(14,2)
);

CREATE TABLE treinador (
    idTreinador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    idade INT
);

CREATE TABLE pokedex (
    idPokedex INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo1 VARCHAR(45),
    tipo2 VARCHAR(45)
);

CREATE TABLE pokemon (
    idPokemon INT PRIMARY KEY AUTO_INCREMENT,
    apelido VARCHAR(45),
    categoria VARCHAR(45),
    peso DECIMAL(10,2),
    tamanho DECIMAL(10,2),
    fkPokemon_TreinadorMestre INT,
    fkPokemon_TreinadorClandestino INT,
    fkPokemon_Pokedex INT,
    FOREIGN KEY (fkPokemon_TreinadorMestre) REFERENCES treinador(idTreinador),
    FOREIGN KEY (fkPokemon_TreinadorClandestino) REFERENCES treinador(idTreinador),
    FOREIGN KEY (fkPokemon_Pokedex) REFERENCES pokedex(idPokedex)
);

CREATE TABLE habilidade (
    idHabilidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    descricao VARCHAR(300),
    categoria VARCHAR(45),
		CONSTRAINT chkCategoria
        CHECK (categoria IN ('fisico', 'especial')),
    carga INT
);

CREATE TABLE moveset (
    idMoveset INT PRIMARY KEY AUTO_INCREMENT,
    fkMoveset_Habilidade INT,
    fkMoveset_Pokemon INT,
    numeracao INT,
		CONSTRAINT chkNumeracao
        CHECK (numeracao < 5 AND numeracao > 0),
    dtAprendido DATETIME,
    FOREIGN KEY (fkMoveset_Habilidade) REFERENCES habilidade(idHabilidade),
    FOREIGN KEY (fkMoveset_Pokemon) REFERENCES pokemon(idPokemon)
);

CREATE TABLE batalha (
    idBatalha INT PRIMARY KEY AUTO_INCREMENT,
    fkBatalha_Competicao INT,
    batalhaCol VARCHAR(45),
    fkBatalha_Treinador1 INT,
    fkBatalha_Treinador2 INT,
    vencedor INT,
    dia DATE,
    custoReparo DECIMAL(14,2),
    FOREIGN KEY (fkBatalha_Competicao) REFERENCES competicao(idCompeticao),
    FOREIGN KEY (fkBatalha_Treinador1) REFERENCES treinador(idTreinador),
    FOREIGN KEY (fkBatalha_Treinador2) REFERENCES treinador(idTreinador)
);

CREATE TABLE aposta (
    idAposta INT PRIMARY KEY AUTO_INCREMENT,
    fkAposta_Apostador INT,
    fkAposta_Batalha INT,
    valor DECIMAL(14,2),
    odd FLOAT,
    treinadorApostado INT,
    FOREIGN KEY (fkAposta_Apostador) REFERENCES espectador(idApostador),
    FOREIGN KEY (fkAposta_Batalha) REFERENCES batalha(idBatalha)
);

CREATE TABLE entrada (
    idEntrada INT PRIMARY KEY AUTO_INCREMENT,
    fkEntrada_Batalha INT,
    fkEntrada_Apostador INT,
    valor FLOAT,
    tipo VARCHAR(45),
		CONSTRAINT chkTipo
        CHECK (tipo IN ('Arquibancada', 'Numerada', 'Camarote')),
        -- Arquibancada: 20; Numerada: 70; Camarote: 200
    FOREIGN KEY (fkEntrada_Batalha) REFERENCES batalha(idBatalha),
    FOREIGN KEY (fkEntrada_Apostador) REFERENCES espectador(idApostador)
);

CREATE TABLE insignia (
    idInsignia INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
);

CREATE TABLE caseInsignia (
    idCaseInsignia INT PRIMARY KEY AUTO_INCREMENT,
    fkCaseInsignia_Treinador INT,
    fkCaseInsignia_Insignia INT,
    dtConquista DATE,
    FOREIGN KEY (fkCaseInsignia_Treinador) REFERENCES treinador(idTreinador),
    FOREIGN KEY (fkCaseInsignia_Insignia) REFERENCES insignia(idInsignia)
);

CREATE TABLE ginasio (
    idGinasio INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    lider VARCHAR(45),
    fkGinasio_Insignia INT,
    FOREIGN KEY (fkGinasio_Insignia) REFERENCES insignia(idInsignia)
);

-- Inserção de dados fictícios
INSERT INTO espectador (vulgo) VALUES 
    ('Ricas'), 
    ('Bolacha'),
    ('Zeca'), 
    ('Bigode'),
    ('Sasa');

INSERT INTO competicao (nome, dtInicio, dtFim, ganhador, premiacao) VALUES
    ('Torneio Elite', '2024-01-01', '2024-01-15', 'Ash Ketchum', 50000.00),
    ('Liga Johto', '2024-02-01', '2024-02-15', 'Brock', 75000.00);

INSERT INTO treinador (nome, idade) VALUES 
    ('Ash Ketchum', 15),
    ('Brock', 18),
    ('Misty', 14),
    ('Gary Oak', 16),
    ('May', 13),
    ('Fábiam', 23),
    ('Ricardo', 24),
    ('Natã', 19),
    ('Izael', 22),
    ('Igor', 19);

INSERT INTO pokedex (nome, tipo1, tipo2) VALUES 
    ('Pikachu', 'Elétrico', NULL),
    ('Onix', 'Pedra', 'Terra'),
    ('Squirtle', 'Água', NULL),
    ('Charizard', 'Fogo', 'Voador'),
    ('Bulbasaur', 'Planta', 'Veneno');

INSERT INTO pokemon (apelido, categoria, peso, tamanho, fkPokemon_TreinadorClandestino, fkPokemon_TreinadorMestre, fkPokemon_Pokedex) VALUES 
    ('Pikachu', 'Rato Elétrico', 6.00, 0.40, 6, 1, 1),
    ('Onix', 'Cobra Pedra', 210.00, 8.80, 7, 2, 2),
    ('Squirtle', 'Tartaruga', 9.00, 0.50, 8, 3, 3),
    ('Charizard', 'Dragão de Fogo', 90.50, 9, 1.70, 4, 4),
    ('Bulbasaur', 'Semente', 6.90, 0.70, 10, 5, 5);

INSERT INTO habilidade (nome, tipo, descricao, categoria, carga) VALUES 
    ('Choque do Trovão', 'Elétrico', 'Causa dano ao oponente com uma descarga elétrica.', 'Especial', 10),
    ('Explosão de Rocha', 'Pedra', 'Atira pedras no oponente.', 'Físico', 5),
    ('Jato de Água', 'Água', 'Dispara um jato de água forte.', 'Especial', 10),
    ('Lança-Chamas', 'Fogo', 'Emite uma chama intensa contra o oponente.', 'Especial', 8),
    ('Folha Navalha', 'Planta', 'Corta o inimigo com folhas afiadas.', 'Físico', 7);

INSERT INTO moveset (fkMoveset_Habilidade, fkMoveset_Pokemon, numeracao, dtAprendido) VALUES 
    (1, 1, 1, '2024-01-01'),
    (2, 2, 1, '2024-01-01'),
    (3, 3, 1, '2024-02-05'),
    (4, 4, 1, '2024-03-10'),
    (5, 5, 1, '2024-04-15');

INSERT INTO batalha (fkBatalha_Competicao, fkBatalha_Treinador1, fkBatalha_Treinador2, vencedor, dia, custoReparo) VALUES
    (1, 1, 2, 1, '2024-01-15', 500.00),
    (1, 1, 3, 1, '2024-01-16', 200.00),
    (1, 1, 4, 4, '2024-01-17', 150.00),
    (1, 2, 3, 3, '2024-01-18', 220.00),
    (1, 2, 4, 2, '2024-01-19', 170.00),
    (1, 3, 4, 3, '2024-01-20', 190.00),
    (1, 3, 4, 3, '2024-02-10', 300.00),
    (2, 1, 4, 1, '2024-03-20', 700.00),
    (2, 2, 5, 2, '2024-04-14', 400.00);

INSERT INTO aposta (fkAposta_Apostador, fkAposta_Batalha, valor, odd, treinadorApostado) VALUES
    (1, 1, 100.00, 2.5, 1),
    (2, 2, 200.00, 1.8, 3),
    (3, 3, 300.00, 2.0, 1),
    (4, 4, 150.00, 3.0, 2);
    
INSERT INTO entrada (fkEntrada_Batalha, fkEntrada_Apostador, valor, tipo) VALUES
    (1, 1, 20.00, 'Arquibancada'),
    (1, 2, 70.00, 'Numerada'),    
    (2, 3, 200.00, 'Camarote'),   
    (2, 4, 20.00, 'Arquibancada'), 
    (3, 5, 70.00, 'Numerada');    

INSERT INTO insignia (nome) VALUES 
    ('Insígnia Rocha'), 
    ('Insígnia Trovão'),
    ('Insígnia Água'),
    ('Insígnia Fogo'),
    ('Insígnia Planta');

INSERT INTO caseInsignia (fkCaseInsignia_Treinador, fkCaseInsignia_Insignia, dtConquista) VALUES
    (1, 2, '2024-01-10'),
    (2, 1, '2024-02-20'),
    (3, 3, '2024-02-25'),
    (4, 4, '2024-03-15'),
    (5, 5, '2024-04-10');

INSERT INTO ginasio (nome, lider, fkGinasio_Insignia) VALUES
    ('Ginásio Pewter', 'Brock', 1),
    ('Ginásio Cerulean', 'Misty', 3),
    ('Ginásio Vermilion', 'Lt. Surge', 2),
    ('Ginásio Cinnabar', 'Blaine', 4),
    ('Ginásio Celadon', 'Erika', 5);