CREATE DATABASE Loja_RPG;
USE Loja_RPG;

-- criar tabelas

CREATE TABLE Jogadores (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  saldo DECIMAL(10,2)
);

CREATE TABLE Itens (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  preco DECIMAL(10,2)
);

CREATE TABLE Compras (
  id INT PRIMARY KEY,
  jogador_id INT,
  item_id INT,
  data_compra DATE,
  FOREIGN KEY (jogador_id) REFERENCES Jogadores(id),
  FOREIGN KEY (item_id) REFERENCES Itens(id)
);

-- inserindo dados

INSERT INTO Jogadores (id, nome, saldo) VALUES
(1, 'Zelda', 100.00),
(2, 'Link', 150.00),
(3, 'Kratos', 200.00);

INSERT INTO Itens (id, nome, preco) VALUES
(1, 'Espada Lendária', 75.00),
(2, 'Poção de Vida', 20.00),
(3, 'Armadura de Titânio', 120.00);

INSERT INTO Compras (id, jogador_id, item_id, data_compra) VALUES
(1, 1, 2, '2025-05-01'), -- Zelda comprou Poção
(2, 2, 1, '2025-05-02'), -- Link comprou Espada
(3, 3, 3, '2025-05-03'); -- Kratos comprou Armadura

-- consulta itens comprados por jogador
SELECT 
  j.nome AS Jogador,
  i.nome AS Item_Comprado,
  i.preco,
  c.data_compra
FROM Compras c
JOIN Jogadores j ON c.jogador_id = j.id
JOIN Itens i ON c.item_id = i.id
ORDER BY j.nome, c.data_compra;

-- consulta gasto total do jogador

SELECT 
  j.nome AS Jogador,
  SUM(i.preco) AS Total_Gasto
FROM Compras c
JOIN Jogadores j ON c.jogador_id = j.id
JOIN Itens i ON c.item_id = i.id
GROUP BY j.nome
ORDER BY Total_Gasto DESC;

-- atualiza saldo
UPDATE Jogadores
SET saldo = saldo - 75.00
WHERE id = 2;

-- remover compra
DELETE FROM Compras WHERE id = 1;

-- ver tudo (nomes jogadores e o que cada um comprou)
SELECT 
  j.nome AS Jogador,
  i.nome AS Item_Comprado,
  i.preco,
  c.data_compra
FROM Compras c
JOIN Jogadores j ON c.jogador_id = j.id
JOIN Itens i ON c.item_id = i.id
ORDER BY j.nome, c.data_compra;






