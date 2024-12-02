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
    ('Bulbasaur', 'Planta', 'Veneno'),
    ('Ivysaur', 'Planta', 'Veneno'),
    ('Venusaur', 'Planta', 'Veneno'),
    ('Charmander', 'Fogo', NULL),
    ('Charmeleon', 'Fogo', NULL),
    ('Charizard', 'Fogo', 'Voador'),
    ('Squirtle', 'Água', NULL),
    ('Wartortle', 'Água', NULL),
    ('Blastoise', 'Água', NULL),
    ('Caterpie', 'Inseto', NULL),
    ('Metapod', 'Inseto', NULL),
    ('Butterfree', 'Inseto', 'Voador'),
    ('Weedle', 'Inseto', 'Veneno'),
    ('Kakuna', 'Inseto', 'Veneno'),
    ('Beedrill', 'Inseto', 'Veneno'),
    ('Pidgey', 'Normal', 'Voador'),
    ('Pidgeotto', 'Normal', 'Voador'),
    ('Pidgeot', 'Normal', 'Voador'),
    ('Rattata', 'Normal', NULL),
    ('Raticate', 'Normal', NULL),
    ('Spearow', 'Normal', 'Voador'),
    ('Fearow', 'Normal', 'Voador'),
    ('Ekans', 'Veneno', NULL),
    ('Arbok', 'Veneno', NULL),
    ('Pikachu', 'Elétrico', NULL),
    ('Raichu', 'Elétrico', NULL),
    ('Sandshrew', 'Terra', NULL),
    ('Sandslash', 'Terra', NULL),
    ('Nidoran♀', 'Veneno', NULL),
    ('Nidorina', 'Veneno', NULL),
    ('Nidoqueen', 'Veneno', 'Terra'),
    ('Nidoran♂', 'Veneno', NULL),
    ('Nidorino', 'Veneno', NULL),
    ('Nidoking', 'Veneno', 'Terra'),
    ('Clefairy', 'Fada', NULL),
    ('Clefable', 'Fada', NULL),
    ('Vulpix', 'Fogo', NULL),
    ('Ninetales', 'Fogo', NULL),
    ('Jigglypuff', 'Normal', 'Fada'),
    ('Wigglytuff', 'Normal', 'Fada'),
    ('Zubat', 'Veneno', 'Voador'),
    ('Golbat', 'Veneno', 'Voador'),
    ('Oddish', 'Planta', 'Veneno'),
    ('Gloom', 'Planta', 'Veneno'),
    ('Vileplume', 'Planta', 'Veneno'),
    ('Paras', 'Inseto', 'Planta'),
    ('Parasect', 'Inseto', 'Planta'),
    ('Venonat', 'Inseto', 'Veneno'),
    ('Venomoth', 'Inseto', 'Voador'),
    ('Diglett', 'Terra', NULL),
    ('Dugtrio', 'Terra', NULL),
    ('Meowth', 'Normal', NULL),
    ('Persian', 'Normal', NULL),
    ('Psyduck', 'Água', NULL),
    ('Golduck', 'Água', NULL),
    ('Mankey', 'Lutador', NULL),
    ('Primeape', 'Lutador', NULL),
    ('Growlithe', 'Fogo', NULL),
    ('Arcanine', 'Fogo', NULL),
    ('Poliwag', 'Água', NULL),
    ('Poliwhirl', 'Água', NULL),
    ('Poliwrath', 'Água', 'Lutador'),
    ('Abra', 'Psíquico', NULL),
    ('Kadabra', 'Psíquico', NULL),
    ('Alakazam', 'Psíquico', NULL),
    ('Machop', 'Lutador', NULL),
    ('Machoke', 'Lutador', NULL),
    ('Machamp', 'Lutador', NULL),
    ('Bellsprout', 'Planta', 'Veneno'),
    ('Weepinbell', 'Planta', 'Veneno'),
    ('Victreebel', 'Planta', 'Veneno'),
    ('Tentacool', 'Água', 'Veneno'),
    ('Tentacruel', 'Água', 'Veneno'),
    ('Geodude', 'Pedra', 'Terra'),
    ('Graveler', 'Pedra', 'Terra'),
    ('Golem', 'Pedra', 'Terra'),
    ('Ponyta', 'Fogo', NULL),
    ('Rapidash', 'Fogo', NULL),
    ('Slowpoke', 'Água', 'Psíquico'),
    ('Slowbro', 'Água', 'Psíquico'),
    ('Magnemite', 'Elétrico', 'Aço'),
    ('Magneton', 'Elétrico', 'Aço'),
    ('Farfetch’d', 'Normal', 'Voador'),
    ('Doduo', 'Normal', 'Voador'),
    ('Dodrio', 'Normal', 'Voador'),
    ('Seel', 'Água', NULL),
    ('Dewgong', 'Água', 'Gelo'),
    ('Grimer', 'Veneno', NULL),
    ('Muk', 'Veneno', NULL),
    ('Shellder', 'Água', NULL),
    ('Cloyster', 'Água', 'Gelo'),
    ('Gastly', 'Fantasma', 'Veneno'),
    ('Haunter', 'Fantasma', 'Veneno'),
    ('Gengar', 'Fantasma', 'Veneno'),
    ('Onix', 'Pedra', 'Terra'),
    ('Drowzee', 'Psíquico', NULL),
    ('Hypno', 'Psíquico', NULL),
    ('Krabby', 'Água', NULL),
    ('Kingler', 'Água', NULL),
    ('Voltorb', 'Elétrico', NULL),
    ('Electrode', 'Elétrico', NULL),
    ('Exeggcute', 'Planta', 'Psíquico'),
    ('Exeggutor', 'Planta', 'Psíquico'),
    ('Cubone', 'Terra', NULL),
    ('Marowak', 'Terra', NULL),
    ('Hitmonlee', 'Lutador', NULL),
    ('Hitmonchan', 'Lutador', NULL),
    ('Lickitung', 'Normal', NULL),
    ('Koffing', 'Veneno', NULL),
    ('Weezing', 'Veneno', NULL),
    ('Rhyhorn', 'Terra', 'Pedra'),
    ('Rhydon', 'Terra', 'Pedra'),
    ('Chansey', 'Normal', NULL),
    ('Tangela', 'Planta', NULL),
    ('Kangaskhan', 'Normal', NULL),
    ('Horsea', 'Água', NULL),
    ('Seadra', 'Água', NULL),
    ('Goldeen', 'Água', NULL),
    ('Seaking', 'Água', NULL),
    ('Staryu', 'Água', NULL),
    ('Starmie', 'Água', 'Psíquico'),
    ('Mr. Mime', 'Psíquico', 'Fada'),
    ('Scyther', 'Inseto', 'Voador'),
    ('Jynx', 'Gelo', 'Psíquico'),
    ('Electabuzz', 'Elétrico', NULL),
    ('Magmar', 'Fogo', NULL),
    ('Pinsir', 'Inseto', NULL),
    ('Tauros', 'Normal', NULL),
    ('Magikarp', 'Água', NULL),
    ('Gyarados', 'Água', 'Voador'),
    ('Lapras', 'Água', 'Gelo'),
    ('Ditto', 'Normal', NULL),
    ('Eevee', 'Normal', NULL),
    ('Vaporeon', 'Água', NULL),
    ('Jolteon', 'Elétrico', NULL),
    ('Flareon', 'Fogo', NULL),
    ('Porygon', 'Normal', NULL),
    ('Omanyte', 'Pedra', 'Água'),
    ('Omastar', 'Pedra', 'Água'),
    ('Kabuto', 'Pedra', 'Água'),
    ('Kabutops', 'Pedra', 'Água'),
    ('Aerodactyl', 'Pedra', 'Voador'),
    ('Snorlax', 'Normal', NULL),
    ('Articuno', 'Gelo', 'Voador'),
    ('Zapdos', 'Elétrico', 'Voador'),
    ('Moltres', 'Fogo', 'Voador'),
    ('Dratini', 'Dragão', NULL),
    ('Dragonair', 'Dragão', NULL),
    ('Dragonite', 'Dragão', 'Voador'),
    ('Mewtwo', 'Psíquico', NULL),
    ('Mew', 'Psíquico', NULL);

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

-- fácil
SELECT e.vulgo, max(a.valor) as MaiorAposta FROM espectador as e JOIN aposta as a ON a.fkAposta_Apostador = e.idApostador WHERE e.vulgo LIKE 'b%' and e.vulgo LIKE '%h_' group by e.vulgo;
SELECT * FROM habilidade WHERE nome LIKE '%a' and tipo like '%a' and descricao like '%oponente%';
SELECT dia FROM batalha WHERE vencedor = 1;
SELECT * FROM pokedex WHERE nome LIKE '%saur';
SELECT * FROM entrada WHERE valor > 20 AND valor < 100 AND tipo LIKE '%d_' ORDER BY idEntrada DESC;
SELECT nome, lider FROM ginasio WHERE nome LIKE '% _e%' ORDER BY lider;
SELECT * FROM pokemon WHERE peso > 50 AND tamanho < 10 AND apelido LIKE '%x';
SELECT idEntrada, valor, tipo FROM entrada WHERE valor > 20 AND valor < 200 AND tipo = 'Numerada';
SELECT nome, descricao, categoria, carga FROM habilidade WHERE categoria = 'Especial' AND tipo = 'Elétrico';
SELECT * FROM competicao WHERE ganhador LIKE '%h %' AND premiacao = 50000;
SELECT idApostador FROM espectador WHERE vulgo = 'Bolacha';
SELECT * FROM caseInsignia WHERE dtConquista > '2024-02-01' AND dtConquista < '2024-02-29';
SELECT * FROM aposta WHERE odd > 1.8 AND treinadorApostado = 1;
SELECT fkBatalha_Treinador1, fkBatalha_Treinador2 FROM batalha WHERE custoReparo >= 190 AND custoReparo <= 500;
SELECT apelido, categoria, peso, tamanho FROM pokemon WHERE apelido LIKE '%a%' OR apelido LIKE '%e%' OR apelido LIKE '%i%' OR apelido LIKE '%o%' OR apelido LIKE '%u%';
SELECT * FROM treinador WHERE idade = '14' OR nome = 'Brock';


-- médio
SELECT count(nome) FROM pokedex WHERE tipo1 = 'veneno' AND nome LIKE '%a';
SELECT e.vulgo, max(a.valor) as MaiorAposta FROM espectador as e JOIN aposta as a ON a.fkAposta_Apostador = e.idApostador WHERE e.vulgo LIKE 'b%' and e.vulgo LIKE '%h_' group by e.vulgo;
SELECT count(a.fkAposta_Apostador) as QuantidadeApostas FROM aposta as a JOIN batalha as b ON b.idBatalha = a.fkAposta_Batalha  JOIN competicao as c ON c.idCompeticao = b.fkBatalha_Competicao WHERE dtInicio >= '2024-01-01' and dtFim <= '2024-12-31';
SELECT t.nome FROM treinador AS t JOIN caseInsignia AS ci ON t.idTreinador = ci.fkCaseInsignia_Treinador ORDER BY ci.dtConquista DESC LIMIT 1;
SELECT treinador.nome FROM treinador JOIN caseInsignia ON caseInsignia.fkCaseInsignia_Treinador = treinador.idTreinador JOIN insignia ON insignia.idInsignia = caseInsignia.fkCaseInsignia_Insignia JOIN ginasio ON ginasio.fkGinasio_Insignia = insignia.idInsignia WHERE ginasio.lider = 'Misty';


-- difícil
SELECT p.apelido, COUNT(*) AS vezes_usado FROM pokemon p INNER JOIN treinador t ON p.fkPokemon_TreinadorMestre = t.idTreinador INNER JOIN caseInsignia ci ON t.idTreinador = ci.fkCaseInsignia_Treinador INNER JOIN insignia i ON ci.fkCaseInsignia_Insignia = i.idInsignia WHERE i.nome = 'Insígnia Rocha' GROUP BY p.apelido ORDER BY vezes_usado DESC LIMIT 1;
SELECT count(idPokedex) AS qtd, tipo1 FROM pokedex GROUP BY tipo1 ORDER BY qtd DESC LIMIT 3;
SELECT espectador.vulgo, aposta.valor, aposta.odd FROM espectador LEFT JOIN aposta ON espectador.idApostador = aposta.fkAposta_Apostador;


-- challenge
SELECT h.nome FROM habilidade as h JOIN moveset as m ON m.fkMoveset_Habilidade = h.idHabilidade JOIN pokemon as p ON p.idPokemon = m.fkMoveset_Pokemon JOIN treinador as t ON t.idTreinador = p.fkPokemon_TreinadorMestre JOIN batalha as b ON t.idTreinador = b.fkBatalha_Treinador1 JOIN aposta AS a ON a.fkAposta_Batalha = b.idBatalha ORDER BY valor LIMIT 1;
SELECT e.idApostador, e.vulgo, c.idCompeticao, c.nome AS nome_competicao, t.idTreinador, t.nome AS nome_treinador, p.idPokemon, p.apelido, h.idHabilidade, h.nome AS nome_habilidade, m.idMoveset, m.numeracao, b.idBatalha, a.idAposta, a.valor, en.idEntrada, en.tipo, i.idInsignia, i.nome AS nome_insignia, ci.idCaseInsignia, ci.dtConquista, g.idGinasio, g.nome AS nome_ginasio FROM espectador e INNER JOIN aposta a ON e.idApostador = a.fkAposta_Apostador INNER JOIN batalha b ON a.fkAposta_Batalha = b.idBatalha INNER JOIN treinador t ON b.fkBatalha_Treinador1 = t.idTreinador INNER JOIN pokemon p ON t.idTreinador = p.fkPokemon_TreinadorMestre INNER JOIN moveset m ON p.idPokemon = m.fkMoveset_Pokemon INNER JOIN habilidade h ON m.fkMoveset_Habilidade = h.idHabilidade INNER JOIN competicao c ON b.fkBatalha_Competicao = c.idCompeticao INNER JOIN entrada en ON b.idBatalha = en.fkEntrada_Batalha INNER JOIN insignia i ON en.fkEntrada_Apostador = i.idInsignia INNER JOIN caseInsignia ci ON i.idInsignia = ci.fkCaseInsignia_Insignia INNER JOIN ginasio g ON ci.fkCaseInsignia_Treinador = g.idGinasio;