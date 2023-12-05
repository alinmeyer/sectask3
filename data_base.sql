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