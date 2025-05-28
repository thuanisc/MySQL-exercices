CREATE DATABASE Jogo;
USE Jogo;

-- criação das tabelas
CREATE TABLE Jogadores(
id INT PRIMARY KEY,
nome VARCHAR(100)
);

ALTER TABLE Jogadores ADD COLUMN pontuacao INT;
ALTER TABLE Jogadores DROP COLUMN pontuacao;

CREATE TABLE Missoes(
id INT PRIMARY KEY,
nome VARCHAR(100),
descricao VARCHAR(300),
pontos INT
);

 CREATE TABLE Conclusoes_Missoes(
id INT PRIMARY KEY,
jogador_id INT, FOREIGN KEY (jogador_id) REFERENCES Jogadores(id),
missoes_id INT, FOREIGN KEY (missoes_id) REFERENCES Missoes(id),
data_conclusao DATE
);

SELECT * FROM Conclusoes_missoes;

-- Inserção dos jogadores com pontuação inicial 0 (vai ser atualizada após concluir missão)
INSERT INTO Jogadores (id, nome) VALUES
(1, 'Mario'),
(2, 'Samus Aran'),
(3, 'Gordon Freeman');

SELECT * FROM Jogadores;

-- Inserção das missões
INSERT INTO MISSOES (id, nome, descricao, pontos)
VALUES
(1, 'Nivel 1', 'Yoshi s Island', 100),
(2, 'Nivel 2', 'Planeta Zebes', 200),
(3, 'Nivel 3', 'Half-life', 500);

-- Inserção das conclusões
INSERT INTO Conclusoes_Missoes(id, jogador_id, missoes_id, data_conclusao) VALUES
(1, 1, 1, '2025-05-01'), -- Mario concluiu Nivel 1
(2, 1, 2, '2025-05-02'), -- Mario concluiu Nivel 2
(3, 2, 2, '2025-05-03'), -- Samus concluiu Nivel 2
(4, 3, 3, '2025-05-04'); -- Gordon concluiu Nivel 3

-- Atualizar a pontuação dos jogadores baseado nas conclusões
SELECT j.id, j.nome AS Jogador, SUM(m.pontos) AS Pontos FROM Conclusoes_Missoes cm
JOIN Jogadores j ON cm.jogador_id = j.id
JOIN Missoes m ON cm.missoes_id = m.id
GROUP BY j.id, j.nome
ORDER BY Pontos DESC;
 
UPDATE Missoes SET pontos = 200 WHERE id = 3;
 
SELECT * FROM Missoes;
 
SELECT j.id, j.nome AS Jogador, SUM(m.pontos) AS Pontos FROM Conclusoes_Missoes cm
JOIN Jogadores j ON cm.jogador_id = j.id
JOIN Missoes m ON cm.missoes_id = m.id
GROUP BY j.id, j.nome
ORDER BY Pontos DESC;

INSERT INTO Conclusoes_Missoes(id, jogador_id, missoes_id, data_conclusao) VALUES
(5, 1, 2, '2025-05-03'), -- Mario concluiu Nivel 1
(6, 2, 3, '2025-05-03'); -- Samus concluiu Nivel 3

SELECT j.id, j.nome AS Jogador, SUM(m.pontos) AS Pontos FROM Conclusoes_Missoes cm
JOIN Jogadores j ON cm.jogador_id = j.id
JOIN Missoes m ON cm.missoes_id = m.id
GROUP BY j.id, j.nome
ORDER BY Pontos DESC;