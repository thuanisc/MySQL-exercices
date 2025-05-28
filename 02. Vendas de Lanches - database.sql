CREATE DATABASE Cantina;
USE Cantina;

-- criação das tabelas

CREATE TABLE Alunos (
  id INT PRIMARY KEY,
  nome VARCHAR(100)
);

CREATE TABLE Itens (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  preco DECIMAL(6,2),
  categoria VARCHAR(50)
);

CREATE TABLE Vendas (
  id INT PRIMARY KEY,
  aluno_id INT,
  data_venda DATE,
  FOREIGN KEY (aluno_id) REFERENCES Alunos(id)
);

CREATE TABLE Itens_Vendidos (
  id INT PRIMARY KEY,
  venda_id INT,
  item_id INT,
  quantidade INT,
  FOREIGN KEY (venda_id) REFERENCES Vendas(id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES Itens(id)
);

SELECT SUM(iv.quantidade * i.preco) AS Total_Gasto
FROM Itens_Vendidos iv
JOIN Itens i ON iv.item_id = i.id
JOIN Vendas v ON iv.venda_id = v.id;

-- inserindo dados

INSERT INTO Alunos (id, nome) VALUES
(1, 'Luana'),
(2, 'Carlos'),
(3, 'Fernanda');

INSERT INTO Itens (id, nome, preco, categoria) VALUES
(1, 'Coxinha', 5.00, 'Salgado'),
(2, 'Refrigerante', 4.50, 'Bebida'),
(3, 'Pastel', 6.00, 'Salgado'),
(4, 'Suco Natural', 5.50, 'Bebida');

INSERT INTO Vendas (id, aluno_id, data_venda) VALUES
(1, 1, '2025-05-01'),  -- Luana
(2, 2, '2025-05-02'),  -- Carlos
(3, 1, '2025-05-03');  -- Luana de novo

INSERT INTO Itens_Vendidos (id, venda_id, item_id, quantidade) VALUES
(1, 1, 1, 2), -- Luana comprou 2 coxinhas
(2, 1, 2, 1), -- Luana comprou 1 refrigerante
(3, 2, 3, 1), -- Carlos comprou 1 pastel
(4, 2, 4, 1), -- Carlos comprou 1 suco
(5, 3, 1, 1), -- Luana comprou 1 coxinha
(6, 3, 4, 1); -- Luana comprou 1 suco

-- consulta quanto cada aluno gastou no total
SELECT 
  a.nome AS Aluno,
  SUM(iv.quantidade * i.preco) AS Total_Gasto
FROM Alunos a
JOIN Vendas v ON a.id = v.aluno_id
JOIN Itens_Vendidos iv ON v.id = iv.venda_id
JOIN Itens i ON iv.item_id = i.id
GROUP BY a.nome
ORDER BY Total_Gasto DESC;

-- atualizar preço de um item
UPDATE Itens SET preco = 6.00 WHERE id = 1;

-- deletar uma venda e seus associados
DELETE FROM Vendas WHERE id = 2;  -- Exclui a venda do Carlos, e automaticamente os itens comprados por ele

-- consultar
SELECT * FROM Alunos;
SELECT * FROM Itens;
SELECT * FROM Venda;

