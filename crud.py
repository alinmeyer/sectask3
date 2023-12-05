import mysql.connector

# Configurações de conexão
config = {
    'user': 'root',
    'password': '0000',
    'host': '127.0.0.1',
    'database': 'sectask',
    'raise_on_warnings': True,
}


def cadastrar_funcionario(conn, nomeFuncionario, email, telefone, endereco, dtCadastro, idSupervisor):
    try:
        cursor = conn.cursor()

        # Verificar se o e-mail já está em uso
        cursor.execute("""
            SELECT * FROM Funcionario WHERE email = %s
        """, (email,))
        existing_funcionario = cursor.fetchone()

        if existing_funcionario:
            print("E-mail já cadastrado. Tente outro.")
        else:
            # Inserir novo funcionário no banco de dados
            cursor.execute("""
                INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro, idSupervisor)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (nomeFuncionario, email, telefone, endereco, dtCadastro, idSupervisor))

            # Confirmar a transação
            conn.commit()
            print("Funcionário cadastrado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar funcionário: {err}")


def ler_funcionario_por_email(conn, email):
    try:
        cursor = conn.cursor()

        # Consultar funcionário por e-mail
        cursor.execute("""
            SELECT * FROM Funcionario WHERE email = %s
        """, (email,))
        funcionario = cursor.fetchone()

        if funcionario:
            print("Informações do Funcionário:")
            print(f"Nome: {funcionario[1]}")
            print(f"E-mail: {funcionario[2]}")
            print(f"Telefone: {funcionario[3]}")
            print(f"Endereço: {funcionario[4]}")
            print(f"Data de Cadastro: {funcionario[5]}")
            print(f"ID do Supervisor: {funcionario[6]}")
        else:
            print("Funcionário não encontrado.")

    except mysql.connector.Error as err:
        print(f"Erro ao ler funcionário por e-mail: {err}")


def deletar_funcionario_por_email(conn, email):
    try:
        cursor = conn.cursor()

        # Verificar se o e-mail já está cadastrado
        cursor.execute("""
            SELECT * FROM Funcionario WHERE email = %s
        """, (email,))
        existing_funcionario = cursor.fetchone()

        if existing_funcionario:
            # Excluir funcionário do banco de dados
            cursor.execute("""
                DELETE FROM Funcionario WHERE email = %s
            """, (email,))

            # Confirmar a transação
            conn.commit()
            print("Funcionário excluído com sucesso!")
        else:
            print("Funcionário não encontrado.")

    except mysql.connector.Error as err:
        print(f"Erro ao excluir funcionário: {err}")


def atualizar_funcionario(conn, nomeFuncionario, email, telefone, endereco, dtCadastro, idSupervisor):
    try:
        cursor = conn.cursor()

        # Verificar se o e-mail já está em uso
        cursor.execute("""
            SELECT * FROM Funcionario WHERE email = %s
        """, (email,))
        existing_funcionario = cursor.fetchone()

        if existing_funcionario:
            # Atualizar as informações do funcionário
            cursor.execute("""
                UPDATE Funcionario
                SET nomeFuncionario = %s, telefone = %s, endereco = %s, dtCadastro = %s, idSupervisor = %s
                WHERE email = %s
            """, (nomeFuncionario, telefone, endereco, dtCadastro, idSupervisor, email))

            # Confirmar a transação
            conn.commit()
            print("Informações do funcionário atualizadas com sucesso!")
        else:
            # Inserir novo funcionário no banco de dados
            cursor.execute("""
                INSERT INTO Funcionario (nomeFuncionario, email, telefone, endereco, dtCadastro, idSupervisor)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (nomeFuncionario, email, telefone, endereco, dtCadastro, idSupervisor))

            # Confirmar a transação
            conn.commit()
            print("Funcionário cadastrado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar/atualizar funcionário: {err}")



def cadastrar_tarefa(conn, tituloTarefa, descricao, dtVencimento, prioridade, dtCriacao, dtConclusao):
    try:
        cursor = conn.cursor()

        # Inserir nova tarefa no banco de dados
        cursor.execute("""
            INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, prioridade, dtCriacao, dtConclusao)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (tituloTarefa, descricao, dtVencimento, prioridade, dtCriacao, dtConclusao))

        # Confirmar a transação
        conn.commit()
        print("Tarefa criada com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar tarefa: {err}")


def ler_tarefa_por_titulo(conn, tituloTarefa):
    try:
        cursor = conn.cursor()

        # Consultar tarefa por título
        cursor.execute("""
            SELECT * FROM Tarefa WHERE tituloTarefa = %s
        """, (tituloTarefa,))
        tarefa = cursor.fetchone()

        if tarefa:
            print("Detalhes da Tarefa:")
            print(f"Título: {tarefa[1]}")
            print(f"Descrição: {tarefa[2]}")
            print(f"Data de Vencimento: {tarefa[3]}")
            print(f"Prioridade: {tarefa[4]}")
            print(f"Data de Criação: {tarefa[5]}")
            print(f"Data de Conclusão: {tarefa[6]}")
        else:
            print("Tarefa não encontrada.")

    except mysql.connector.Error as err:
        print(f"Erro ao ler tarefa por título: {err}")


def deletar_tarefa_por_titulo(conn, tituloTarefa):
    try:
        cursor = conn.cursor()

        # Verificar se a tarefa existe
        cursor.execute("""
            SELECT * FROM Tarefa WHERE tituloTarefa = %s
        """, (tituloTarefa,))
        existing_tarefa = cursor.fetchone()

        if existing_tarefa:
            # Excluir a tarefa do banco de dados
            cursor.execute("""
                DELETE FROM Tarefa WHERE tituloTarefa = %s
            """, (tituloTarefa,))

            # Confirmar a transação
            conn.commit()
            print("Tarefa excluída com sucesso!")
        else:
            print("Tarefa não encontrada.")

    except mysql.connector.Error as err:
        print(f"Erro ao excluir tarefa: {err}")


def atualizar_tarefa(conn, tituloTarefa, descricao, dtVencimento, prioridade, dtCriacao, dtConclusao):
    try:
        cursor = conn.cursor()

        # Verificar se a tarefa já existe
        cursor.execute("""
            SELECT * FROM Tarefa WHERE tituloTarefa = %s
        """, (tituloTarefa,))
        existing_tarefa = cursor.fetchone()

        if existing_tarefa:
            # Atualizar as informações da tarefa
            cursor.execute("""
                UPDATE Tarefa
                SET descricao = %s, dtVencimento = %s, prioridade = %s, dtCriacao = %s, dtConclusao = %s
                WHERE tituloTarefa = %s
            """, (descricao, dtVencimento, prioridade, dtCriacao, dtConclusao, tituloTarefa))

            # Confirmar a transação
            conn.commit()
            print("Informações da tarefa atualizadas com sucesso!")
        else:
            # Inserir nova tarefa no banco de dados
            cursor.execute("""
                INSERT INTO Tarefa (tituloTarefa, descricao, dtVencimento, prioridade, dtCriacao, dtConclusao)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (tituloTarefa, descricao, dtVencimento, prioridade, dtCriacao, dtConclusao))

            # Confirmar a transação
            conn.commit()
            print("Tarefa criada com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar/atualizar tarefa: {err}")




def cadastrar_projeto(conn, nomeProjeto, descricao, dtConclusao, dtInicio):
    try:
        cursor = conn.cursor()

        # Inserir novo projeto no banco de dados
        cursor.execute("""
            INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio)
            VALUES (%s, %s, %s, %s)
        """, (nomeProjeto, descricao, dtConclusao, dtInicio))

        # Confirmar a transação
        conn.commit()
        print("Projeto cadastrado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar projeto: {err}")


def ler_projeto_por_nome(conn, nomeProjeto):
    try:
        cursor = conn.cursor()

        # Consultar projeto por nome
        cursor.execute("""
            SELECT * FROM Projeto WHERE nomeProjeto = %s
        """, (nomeProjeto,))
        projeto = cursor.fetchone()

        if projeto:
            print("Detalhes do Projeto:")
            print(f"Nome do Projeto: {projeto[1]}")
            print(f"Descrição: {projeto[2]}")
            print(f"Data de Conclusão: {projeto[3]}")
            print(f"Data de Início: {projeto[4]}")
        else:
            print("Projeto não encontrado.")

    except mysql.connector.Error as err:
        print(f"Erro ao ler projeto por nome: {err}")


def deletar_projeto_por_nome(conn, nomeProjeto):
    try:
        cursor = conn.cursor()

        # Verificar se o projeto existe
        cursor.execute("""
            SELECT * FROM Projeto WHERE nomeProjeto = %s
        """, (nomeProjeto,))
        existing_projeto = cursor.fetchone()

        if existing_projeto:
            # Excluir o projeto do banco de dados
            cursor.execute("""
                DELETE FROM Projeto WHERE nomeProjeto = %s
            """, (nomeProjeto,))

            # Confirmar a transação
            conn.commit()
            print("Projeto excluído com sucesso!")
        else:
            print("Projeto não encontrado.")

    except mysql.connector.Error as err:
        print(f"Erro ao excluir projeto: {err}")

def atualizar_projeto(conn, nomeProjeto, descricao, dtConclusao, dtInicio):
    try:
        cursor = conn.cursor()

        # Verificar se o projeto já existe
        cursor.execute("""
            SELECT * FROM Projeto WHERE nomeProjeto = %s
        """, (nomeProjeto,))
        existing_projeto = cursor.fetchone()

        if existing_projeto:
            # Atualizar as informações do projeto
            cursor.execute("""
                UPDATE Projeto
                SET descricao = %s, dtConclusao = %s, dtInicio = %s
                WHERE nomeProjeto = %s
            """, (descricao, dtConclusao, dtInicio, nomeProjeto))

            # Confirmar a transação
            conn.commit()
            print("Informações do projeto atualizadas com sucesso!")
        else:
            # Inserir novo projeto no banco de dados
            cursor.execute("""
                INSERT INTO Projeto (nomeProjeto, descricao, dtConclusao, dtInicio)
                VALUES (%s, %s, %s, %s)
            """, (nomeProjeto, descricao, dtConclusao, dtInicio))

            # Confirmar a transação
            conn.commit()
            print("Projeto cadastrado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar/atualizar projeto: {err}")




def cadastrar_equipe(conn, nomeEquipe, descricao, dtFormacao, apoio):
    try:
        cursor = conn.cursor()

        # Inserir nova equipe no banco de dados
        cursor.execute("""
            INSERT INTO Equipe (nomeEquipe, descricao, dtFormacao, apoio)
            VALUES (%s, %s, %s, %s)
        """, (nomeEquipe, descricao, dtFormacao, apoio))

        # Confirmar a transação
        conn.commit()
        print("Equipe cadastrada com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar equipe: {err}")



def ler_equipe_por_nome(conn, nomeEquipe):
    try:
        cursor = conn.cursor()

        # Consultar equipe por nome
        cursor.execute("""
            SELECT * FROM Equipe WHERE nomeEquipe = %s
        """, (nomeEquipe,))
        equipe = cursor.fetchone()

        if equipe:
            print("Detalhes da Equipe:")
            print(f"Nome da Equipe: {equipe[1]}")
            print(f"Descrição: {equipe[2]}")
            print(f"Data de Formação: {equipe[3]}")
            print(f"Apoio: {equipe[4]}")
        else:
            print("Equipe não encontrada.")

    except mysql.connector.Error as err:
        print(f"Erro ao ler equipe por nome: {err}")


def deletar_equipe_por_nome(conn, nomeEquipe):
    try:
        cursor = conn.cursor()

        # Verificar se a equipe existe
        cursor.execute("""
            SELECT * FROM Equipe WHERE nomeEquipe = %s
        """, (nomeEquipe,))
        existing_equipe = cursor.fetchone()

        if existing_equipe:
            # Excluir a equipe do banco de dados
            cursor.execute("""
                DELETE FROM Equipe WHERE nomeEquipe = %s
            """, (nomeEquipe,))

            # Confirmar a transação
            conn.commit()
            print("Equipe excluída com sucesso!")
        else:
            print("Equipe não encontrada.")

    except mysql.connector.Error as err:
        print(f"Erro ao excluir equipe: {err}")

def atualizar_equipe(conn, nomeEquipe, descricao, dtFormacao, apoio):
    try:
        cursor = conn.cursor()

        # Verificar se a equipe já existe
        cursor.execute("""
            SELECT * FROM Equipe WHERE nomeEquipe = %s
        """, (nomeEquipe,))
        existing_equipe = cursor.fetchone()

        if existing_equipe:
            # Atualizar as informações da equipe
            cursor.execute("""
                UPDATE Equipe
                SET descricao = %s, dtFormacao = %s, apoio = %s
                WHERE nomeEquipe = %s
            """, (descricao, dtFormacao, apoio, nomeEquipe))

            # Confirmar a transação
            conn.commit()
            print("Informações da equipe atualizadas com sucesso!")
        else:
            # Inserir nova equipe no banco de dados
            cursor.execute("""
                INSERT INTO Equipe (nomeEquipe, descricao, dtFormacao, apoio)
                VALUES (%s, %s, %s, %s)
            """, (nomeEquipe, descricao, dtFormacao, apoio))

            # Confirmar a transação
            conn.commit()
            print("Equipe cadastrada com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar/atualizar equipe: {err}")




def cadastrar_categoria(conn, nomeCategoria, descricao):
    try:
        cursor = conn.cursor()

        # Inserir nova categoria no banco de dados
        cursor.execute("""
            INSERT INTO Categoria (nomeCategoria, descricao)
            VALUES (%s, %s)
        """, (nomeCategoria, descricao))

        # Confirmar a transação
        conn.commit()
        print("Categoria cadastrada com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar categoria: {err}")


def ler_categoria_por_nome(conn, nomeCategoria):
    try:
        cursor = conn.cursor()

        # Consultar categoria por nome
        cursor.execute("""
            SELECT * FROM Categoria WHERE nomeCategoria = %s
        """, (nomeCategoria,))
        categoria = cursor.fetchone()

        if categoria:
            print("Detalhes da Categoria:")
            print(f"Nome da Categoria: {categoria[1]}")
            print(f"Descrição: {categoria[2]}")
        else:
            print("Categoria não encontrada.")

    except mysql.connector.Error as err:
        print(f"Erro ao ler categoria por nome: {err}")


def deletar_categoria_por_nome(conn, nomeCategoria):
    try:
        cursor = conn.cursor()

        # Verificar se a categoria existe
        cursor.execute("""
            SELECT * FROM Categoria WHERE nomeCategoria = %s
        """, (nomeCategoria,))
        existing_categoria = cursor.fetchone()

        if existing_categoria:
            # Excluir a categoria do banco de dados
            cursor.execute("""
                DELETE FROM Categoria WHERE nomeCategoria = %s
            """, (nomeCategoria,))

            # Confirmar a transação
            conn.commit()
            print("Categoria excluída com sucesso!")
        else:
            print("Categoria não encontrada.")

    except mysql.connector.Error as err:
        print(f"Erro ao excluir categoria: {err}")


def atualizar_categoria(conn, nomeCategoria, descricao):
    try:
        cursor = conn.cursor()

        # Verificar se a categoria já existe
        cursor.execute("""
            SELECT * FROM Categoria WHERE nomeCategoria = %s
        """, (nomeCategoria,))
        existing_categoria = cursor.fetchone()

        if existing_categoria:
            # Atualizar as informações da categoria
            cursor.execute("""
                UPDATE Categoria
                SET descricao = %s
                WHERE nomeCategoria = %s
            """, (descricao, nomeCategoria))

            # Confirmar a transação
            conn.commit()
            print("Informações da categoria atualizadas com sucesso!")
        else:
            # Inserir nova categoria no banco de dados
            cursor.execute("""
                INSERT INTO Categoria (nomeCategoria, descricao)
                VALUES (%s, %s)
            """, (nomeCategoria, descricao))

            # Confirmar a transação
            conn.commit()
            print("Categoria cadastrada com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar/atualizar categoria: {err}")




def cadastrar_documento(conn, tituloDocumento, dtPublicacao):
    try:
        cursor = conn.cursor()

        # Inserir novo documento no banco de dados
        cursor.execute("""
            INSERT INTO Documentacao (tituloDocumento, dtPublicacao)
            VALUES (%s, %s)
        """, (tituloDocumento, dtPublicacao))

        # Confirmar a transação
        conn.commit()
        print("Documento cadastrado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar documento: {err}")



def ler_documento_por_titulo(conn, tituloDocumento):
    try:
        cursor = conn.cursor()

        # Consultar documento por título
        cursor.execute("""
            SELECT * FROM Documentacao WHERE tituloDocumento = %s
        """, (tituloDocumento,))
        documento = cursor.fetchone()

        if documento:
            print("Detalhes do Documento:")
            print(f"Título do Documento: {documento[1]}")
            print(f"Data de Publicação: {documento[2]}")
        else:
            print("Documento não encontrado.")

    except mysql.connector.Error as err:
        print(f"Erro ao ler documento por título: {err}")

def deletar_documento_por_titulo(conn, tituloDocumento):
    try:
        cursor = conn.cursor()

        # Verificar se o documento existe
        cursor.execute("""
            SELECT * FROM Documentacao WHERE tituloDocumento = %s
        """, (tituloDocumento,))
        existing_documento = cursor.fetchone()

        if existing_documento:
            # Excluir o documento do banco de dados
            cursor.execute("""
                DELETE FROM Documentacao WHERE tituloDocumento = %s
            """, (tituloDocumento,))

            # Confirmar a transação
            conn.commit()
            print("Documento excluído com sucesso!")
        else:
            print("Documento não encontrado.")

    except mysql.connector.Error as err:
        print(f"Erro ao excluir documento: {err}")


def atualizar_documento(conn, tituloDocumento, dtPublicacao):
    try:
        cursor = conn.cursor()

        # Verificar se o documento já existe
        cursor.execute("""
            SELECT * FROM Documentacao WHERE tituloDocumento = %s
        """, (tituloDocumento,))
        existing_documento = cursor.fetchone()

        if existing_documento:
            # Atualizar as informações do documento
            cursor.execute("""
                UPDATE Documentacao
                SET dtPublicacao = %s
                WHERE tituloDocumento = %s
            """, (dtPublicacao, tituloDocumento))

            # Confirmar a transação
            conn.commit()
            print("Informações do documento atualizadas com sucesso!")
        else:
            # Inserir novo documento no banco de dados
            cursor.execute("""
                INSERT INTO Documentacao (tituloDocumento, dtPublicacao)
                VALUES (%s, %s)
            """, (tituloDocumento, dtPublicacao))

            # Confirmar a transação
            conn.commit()
            print("Documento cadastrado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar/atualizar documento: {err}")


conn.close()



