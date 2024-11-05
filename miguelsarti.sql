-- Criação do DATABASE

CREATE TABLE hospital;
\c hospital

--Criação das tabelas "pacientes" e "medicos"

CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nome_paciente VARCHAR(100) NOT NULL,
    email_paciente VARCHAR(130) UNIQUE NOT NULL,
    telefone_paciente VARCHAR(15) UNIQUE NOT NULL,
    cpf VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome_medico VARCHAR(100) NOT NULL,
    email_medico VARCHAR(130) UNIQUE NOT NULL,
    telefone_medico VARCHAR(15) UNIQUE NOT NULL,
    formacao VARCHAR(100) NOT NULL
);

-- Inserir pacientes e médicos

INSERT INTO pacientes (nome_paciente, email_paciente, telefone_paciente, cpf) VALUES
('Pablo Delgado', 'pablodelgado@gmail.com', 19992813822, 26632183176),
('Vitor Argeri', 'vitorargeri@gmail.com', 11987067326, 48039814482),
('Vinicius Rocha', 'viniciusrocha@gmail.com', 19971272121, 10235231138);

INSERT INTO medicos (nome_medico, email_medico, telefone_medico, formacao) VALUES
('Felipe Dev', 'felipedev@gmail.com', 19973127591, 'Nutricao'),
('Thiago Ferreira', 'thiagoferreira@gmail.com', 11985203721, 'Cirurgiao'),
('Brad Pitt', 'bradpitt@gmail.com', 11943728108, 'Neurologista');

-- Criação da tabela de consultas

CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL, 
    data_agendada DATE NOT NULL DEFAULT CURRENT_DATE,
    consulta_realizada VARCHAR(3) NOT NULL,
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- Inserir id do paciente e do médico, junto com a data agendada e se foi realizada na tabela de consultas

INSERT INTO consultas (id_paciente, id_medico, data_agendada, consulta_realizada) VALUES
(1, 2, '2024-11-07', 'nao'),
(2, 3, '2024-11-05', 'sim'),
(3, 1, '2024-11-02', 'nao');

-- Consulta que liste apenas os pacientes que já tiveram consultas realizadas, mostrando o nome do paciente, o nome do médico, a data da consulta e a especialidade do médico.

SELECT p.id_paciente,
p.nome_paciente,
m.nome_medico,
c.data_agendada,
m.formacao,
c.consulta_realizada
FROM consultas c
JOIN
pacientes p ON c.id_paciente = p.id_paciente
JOIN
medicos m ON c.id_medico = m.id_medico
WHERE consulta_realizada = 'sim';

-- Consulta para mostrar todos os pacientes que não realizaram nenhuma consulta(passadas ou futuro).

SELECT p.id_paciente,
p.nome_paciente,
c.data_agendada,
c.consulta_realizada
FROM consultas c
JOIN
pacientes p ON c.id_paciente = p.id_paciente
WHERE consulta_realizada = 'nao';

-- Consulta que mostre apenas os médicos que ainda não realizaram nenhuma consulta.

SELECT m.id_medico,
m.nome_medico,
c.data_agendada,
c.consulta_realizada
FROM consultas c
JOIN
medicos m ON c.id_medico = m.id_medico
WHERE consulta_realizada = 'nao';



