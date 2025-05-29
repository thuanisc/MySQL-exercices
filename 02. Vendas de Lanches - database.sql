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

CREATE TABLE Itens_Comprados (
  id INT PRIMARY KEY,
  aluno_id INT,
  item_id INT,
  quantidade INT,
  data_compra DATE,
  FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
  FOREIGN KEY (item_id) REFERENCES Itens(id)
);

SELECT SUM(ic.quantidade * i.preco) AS Total_Gasto
FROM Itens_Comprados ic
JOIN Itens i ON ic.item_id = i.id;

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

INSERT INTO Itens_Comprados (id, aluno_id, item_id, quantidade, data_compra) VALUES
(1, 1, 1, 2, '2025-05-01'), -- Luana comprou 2 coxinhas
(2, 1, 2, 1, '2025-05-01'), -- Luana comprou 1 refrigerante
(3, 2, 3, 1, '2025-05-02'), -- Carlos comprou 1 pastel
(4, 2, 4, 1, '2025-05-02'), -- Carlos comprou 1 suco
(5, 1, 1, 1, '2025-05-03'), -- Luana comprou 1 coxinha
(6, 1, 4, 1, '2025-05-03'); -- Luana comprou 1 suco

-- consulta quanto cada aluno gastou no total
SELECT 
  a.nome AS Aluno,
  SUM(ic.quantidade * i.preco) AS Total_Gasto
FROM Alunos a
JOIN Itens_Comprados ic ON a.id = ic.aluno_id
JOIN Itens i ON ic.item_id = i.id
GROUP BY a.nome
ORDER BY Total_Gasto DESC;

-- atualizar preço de um item
UPDATE Itens SET preco = 6.00 WHERE id = 1; -- Coxinha

-- deletar uma venda e seus associados
DELETE FROM Itens_Comprados WHERE id = 3; -- Remove a compra do pastel do Carlos

-- consultar
SELECT * FROM Alunos;
SELECT * FROM Itens;
SELECT * FROM Itens_Comprados;

