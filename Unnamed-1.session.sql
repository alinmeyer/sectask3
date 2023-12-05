CREATE TABLE Funcionario 
( 
 idFuncionario INT PRIMARY KEY AUTO_INCREMENT,  
 nomeFuncionario VARCHAR(255) NOT NULL,  
 email VARCHAR(255) NOT NULL,  
 telefone INT NOT NULL,  
 endereco VARCHAR(255) NOT NULL,  
 dtCadastro DATE NOT NULL,  
 idSupervisor INT,  
 CHECK (email LIKE '%_@__%.__%'),
 UNIQUE (email)
); 

CREATE TABLE Tarefa 
( 
 idTarefa INT PRIMARY KEY AUTO_INCREMENT,  
 tituloTarefa VARCHAR(255) NOT NULL,  
 descricao VARCHAR(255) NOT NULL,  
 dtVencimento DATE,  
 status CHAR(1) NOT NULL DEFAULT 'P',  
 prioridade CHAR(1) NOT NULL,  
 dtCriacao DATE NOT NULL,  
 dtConclusao DATE,  
 idProjeto INT NOT NULL,  
 CHECK (status IN ('P', 'A', 'C') AND prioridade IN ('A', 'C'))
); 

CREATE TABLE Projeto 
( 
 idProjeto INT PRIMARY KEY AUTO_INCREMENT,  
 nomeProjeto VARCHAR(255) NOT NULL,  
 descricao VARCHAR(255) NOT NULL,  
 dtConclusao DATE,  
 dtInicio DATE NOT NULL,  
 idCategoria INT NOT NULL,  
 idEquipe INT,  
 UNIQUE (nomeProjeto)
); 

CREATE TABLE Equipe 
( 
 nomeEquipe VARCHAR(255) NOT NULL,  
 descricao VARCHAR(255) NOT NULL,  
 dtFormacao DATE NOT NULL,  
 apoio CHAR(1) NOT NULL DEFAULT 'N',  
 idEquipe INT PRIMARY KEY AUTO_INCREMENT,  
 CHECK (apoio IN ('N', 'S'))
); 

CREATE TABLE Categoria 
( 
 idCategoria INT PRIMARY KEY AUTO_INCREMENT,  
 nomeCategoria VARCHAR(255) NOT NULL,  
 descricao VARCHAR(255) NOT NULL,  
 UNIQUE (nomeCategoria)
); 

CREATE TABLE Documentacao 
( 
 idDocumento INT PRIMARY KEY AUTO_INCREMENT,  
 tituloDocumento VARCHAR(255) NOT NULL,  
 dtPublicacao DATE NOT NULL,  
 arquivo VARCHAR(255) NOT NULL,  
 idFuncionario INT NOT NULL 
); 

CREATE TABLE DocumentoProjeto 
( 
 dtAssociacao INT PRIMARY KEY,  
 idProjeto INT NOT NULL,  
 idDocumentacao INT NOT NULL 
); 

CREATE TABLE TarefaAlocada 
( 
 dtAlocacao INT PRIMARY KEY,  
 idFuncionario INT NOT NULL,  
 idTarefa INT NOT NULL
); 

CREATE TABLE FuncionarioEquipe 
( 
 dtAlocacao INT PRIMARY KEY,  
 idFuncionario INT NOT NULL,  
 idEquipe INT NOT NULL
); 

ALTER TABLE Funcionario ADD FOREIGN KEY(idSupervisor) REFERENCES Funcionario (idFuncionario);
ALTER TABLE Tarefa ADD FOREIGN KEY(idProjeto) REFERENCES Projeto (idProjeto);
ALTER TABLE Projeto ADD FOREIGN KEY(idCategoria) REFERENCES Categoria (idCategoria);
ALTER TABLE Projeto ADD FOREIGN KEY(idEquipe) REFERENCES Equipe (idEquipe);
ALTER TABLE Documentacao ADD FOREIGN KEY(idFuncionario) REFERENCES Funcionario (idFuncionario);
ALTER TABLE DocumentoProjeto ADD FOREIGN KEY(idProjeto) REFERENCES Projeto (idProjeto);
ALTER TABLE DocumentoProjeto ADD FOREIGN KEY(idDocumentacao) REFERENCES Documentacao (idDocumento);
ALTER TABLE TarefaAlocada ADD FOREIGN KEY(idFuncionario) REFERENCES Funcionario (idFuncionario);
ALTER TABLE TarefaAlocada ADD FOREIGN KEY(idTarefa) REFERENCES Tarefa (idTarefa);
ALTER TABLE FuncionarioEquipe ADD FOREIGN KEY(idFuncionario) REFERENCES Funcionario (idFuncionario);
ALTER TABLE FuncionarioEquipe ADD FOREIGN KEY(idEquipe) REFERENCES Equipe (idEquipe);


INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Carlos Oliveira', 'carlos.oliveira@email.com', 111223344, 'Rua X, 789', '2023-03-01');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Ana Santos', 'ana.santos@email.com', 222334455, 'Avenida Y, 456', '2023-03-15');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Pedro Lima', 'pedro.lima@email.com', 333445566, 'Rua Z, 101', '2023-04-01');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Mariana Costa', 'mariana.costa@email.com', 444556677, 'Avenida W, 202', '2023-04-15');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Lucas Pereira', 'lucas.pereira@email.com', 555667788, 'Rua M, 303', '2023-05-01');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Isabel Silva', 'isabel.silva@email.com', 666778899, 'Avenida N, 404', '2023-05-15');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Ricardo Santos', 'ricardo.santos@email.com', 777889900, 'Rua P, 505', '2023-06-01');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Camila Oliveira', 'camila.oliveira@email.com', 888990011, 'Avenida Q, 606', '2023-06-15');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Fernando Lima', 'fernando.lima@email.com', 999000111, 'Rua R, 707', '2023-07-01');
INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro) VALUES ('Juliana Costa', 'juliana.costa@email.com', 123456789, 'Avenida S, 808', '2023-07-15');



INSERT INTO Categoria (nomeCategoria, descricao) VALUES ('Segurança de Rede', 'Medidas para fortalecer a segurança de rede');
INSERT INTO Categoria (nomeCategoria, descricao) VALUES ('Gestão de Incidentes', 'Protocolos para gestão eficaz de incidentes de segurança');
INSERT INTO Categoria (nomeCategoria, descricao) VALUES ('Criptografia', 'Pesquisa e implementação de técnicas avançadas de criptografia');


INSERT INTO Equipe (nomeEquipe, descricao, dtFormacao, apoio) VALUES ('Equipe de Redes', 'Responsável pela segurança de rede', '2023-01-01', 'N');
INSERT INTO Equipe (nomeEquipe, descricao, dtFormacao, apoio) VALUES ('Equipe de Incidentes', 'Atua na gestão de incidentes de segurança', '2023-01-15', 'S');
INSERT INTO Equipe (nomeEquipe, descricao, dtFormacao, apoio) VALUES ('Equipe de Criptografia', 'Especializada em técnicas avançadas de criptografia', '2023-02-01', 'N');
INSERT INTO Equipe (nomeEquipe, descricao, dtFormacao, apoio) VALUES ('Equipe de Testes', 'Realiza testes regulares de segurança', '2023-02-15', 'S');


-- Inserções para a tabela Projeto

INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio, idCategoria, idEquipe) VALUES ('Projeto de Segurança de Rede', 'Implementação de medidas para fortalecer a segurança de rede', '2023-12-31', '2023-01-01', 1, 1);

INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio, idCategoria, idEquipe) VALUES ('Projeto de Gestão de Incidentes', 'Desenvolvimento de protocolos para gestão eficaz de incidentes de segurança', NULL, '2023-01-15', 2, 2);

INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio, idCategoria, idEquipe) VALUES ('Projeto de Criptografia Avançada', 'Pesquisa e implementação de técnicas avançadas de criptografia', '2023-11-30', '2023-02-01', 1, 3);

INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio, idCategoria, idEquipe) VALUES ('Projeto de Prevenção de Ataques', 'Desenvolvimento de estratégias para prevenir ataques cibernéticos', '2023-12-31', '2023-04-01', 1, 3);

INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio, idCategoria, idEquipe) VALUES ('Projeto de Testes de Segurança', 'Realização de testes regulares de segurança', NULL, '2023-04-15', 2, 2);


-- Inserções para a tabela Tarefa relacionadas com os Projetos

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Revisão de Firewall', 'Avaliar e ajustar regras do firewall', '2023-03-15', 'P', 'A', '2023-03-01', NULL, 1);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Análise de Vulnerabilidades', 'Realizar escaneamento de vulnerabilidades', '2023-04-01', 'P', 'A', '2023-03-15', NULL, 2);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Implementação de Criptografia', 'Configurar criptografia para comunicações seguras', '2023-04-15', 'P', 'C', '2023-04-01', NULL, 3);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Treinamento em Conscientização de Segurança', 'Realizar sessão de treinamento para funcionários', '2023-05-01', 'P', 'A', '2023-04-15', NULL, 4);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Auditoria de Logs', 'Analisar logs do sistema em busca de atividades suspeitas', '2023-05-15', 'P', 'C', '2023-05-01', NULL, 5);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Revisão de Políticas de Segurança', 'Atualizar e revisar políticas de segurança', '2023-06-01', 'P', 'A', '2023-05-15', NULL, 1);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Monitoramento de Atividades Anômalas', 'Implementar ferramentas de monitoramento contínuo', '2023-06-15', 'P', 'C', '2023-06-01', NULL, 3);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Teste de Penetração', 'Realizar teste de penetração na infraestrutura', '2023-07-01', 'P', 'A', '2023-06-15', NULL, 2);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Backup de Dados Críticos', 'Realizar backup de dados sensíveis', '2023-07-15', 'P', 'C', '2023-07-01', NULL, 1);

INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, status, prioridade, dtCriacao, dtConclusao, idProjeto) VALUES ('Revisão de Controles de Acesso', 'Verificar e atualizar os controles de acesso', '2023-08-01', 'P', 'A', '2023-07-15', NULL, 3);

-- Inserções para a tabela Documentacao

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Manual de Segurança de Rede', '2023-03-01', 'manual_seguranca_rede.pdf', 1);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Procedimentos de Incidentes', '2023-03-15', 'procedimentos_incidentes.pdf', 2);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Guia de Criptografia Avançada', '2023-04-01', 'guia_criptografia_avancada.pdf', 3);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Políticas de Prevenção de Ataques', '2023-04-15', 'politicas_prevencao_ataques.pdf', 4);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Relatório de Testes de Segurança', '2023-05-01', 'relatorio_testes_seguranca.pdf', 5);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Procedimentos de Revisão de Políticas', '2023-05-15', 'procedimentos_revisao_politicas.pdf', 1);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Manual de Monitoramento Anômalas', '2023-06-01', 'manual_monitoramento_anomalas.pdf', 2);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Relatório de Teste de Penetração', '2023-06-15', 'relatorio_teste_penetracao.pdf', 3);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Backup de Dados Críticos - Procedimentos', '2023-07-01', 'procedimentos_backup_dados.pdf', 4);

INSERT INTO Documentacao (tituloDocumento, dtPublicacao, arquivo, idFuncionario) VALUES ('Políticas de Controles de Acesso', '2023-07-15', 'politicas_controles_acesso.pdf', 5);



INSERT INTO FuncionarioEquipe (dtAlocacao, idFuncionario, idEquipe)
VALUES (UNIX_TIMESTAMP('2023-01-01'), 1, 1),
       (UNIX_TIMESTAMP('2023-01-15'), 2, 2),
       (UNIX_TIMESTAMP('2023-02-01'), 3, 1),
       (UNIX_TIMESTAMP('2023-02-15'), 4, 3),
       (UNIX_TIMESTAMP('2023-03-01'), 5, 2),
       (UNIX_TIMESTAMP('2023-03-15'), 6, 1),
       (UNIX_TIMESTAMP('2023-04-01'), 7, 3),
       (UNIX_TIMESTAMP('2023-04-15'), 8, 2),
       (UNIX_TIMESTAMP('2023-05-01'), 9, 1),
       (UNIX_TIMESTAMP('2023-05-15'), 10, 3);


INSERT INTO TarefaAlocada (dtAlocacao, idFuncionario, idTarefa)
VALUES (UNIX_TIMESTAMP('2023-03-01'), 1, 1),
       (UNIX_TIMESTAMP('2023-04-01'), 2, 2),
       (UNIX_TIMESTAMP('2023-04-15'), 3, 3),
       (UNIX_TIMESTAMP('2023-05-01'), 4, 4),
       (UNIX_TIMESTAMP('2023-05-15'), 5, 5),
       (UNIX_TIMESTAMP('2023-06-01'), 6, 6),
       (UNIX_TIMESTAMP('2023-06-15'), 7, 7),
       (UNIX_TIMESTAMP('2023-07-01'), 8, 8),
       (UNIX_TIMESTAMP('2023-07-15'), 9, 9),
       (UNIX_TIMESTAMP('2023-08-01'), 10, 10);


INSERT INTO DocumentoProjeto (dtAssociacao, idProjeto, idDocumentacao)
VALUES (UNIX_TIMESTAMP('2023-03-01'), 1, 1),
       (UNIX_TIMESTAMP('2023-03-15'), 2, 2),
       (UNIX_TIMESTAMP('2023-04-01'), 3, 3),
       (UNIX_TIMESTAMP('2023-04-15'), 4, 4),
       (UNIX_TIMESTAMP('2023-05-01'), 5, 5),
       (UNIX_TIMESTAMP('2023-05-15'), 1, 6),
       (UNIX_TIMESTAMP('2023-06-01'), 2, 7),
       (UNIX_TIMESTAMP('2023-06-15'), 3, 8),
       (UNIX_TIMESTAMP('2023-07-01'), 4, 9),
       (UNIX_TIMESTAMP('2023-07-15'), 5, 10);