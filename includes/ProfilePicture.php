<?php
	class ProfilePicture
	{
		private $conn;

		public function __construct()
		{
			require_once 'config/DbConnect.php';

			// Chamando o método connect da classe Database e inicializando um link de conexão
			$this->conn = connect();
		}

		// Quando este método é chamado, parâmetros de inserção da imagem são definidos
		public function createPicture(){
			// Definindo a pasta para upload
			$_UP['folder'] 	= 'uploads/up_profile/';
			// Definindo o tamanho do arquivo
	    $_UP['size'] 		= 1024*1024*2; // 2MB

	    // Definindo as extensões que serão aceitas
	    $_UP['extensions'] 	= array('jpg', 'png', 'jpeg');
	    $_UP['rename'] 			= true;
	    // Definindo a váriavel para receber a imagem
			$file_tmp = $_FILES['image']['tmp_name'];
	    $file 		= $_FILES['image'];
			// Pega a extensão
	    $extesion = pathinfo($file['name'], PATHINFO_EXTENSION);
			// Converte o nome da extensão em minúsculo
			$extesion = strtolower($extesion);

	   	if (array_search($extesion, $_UP['extensions']) === false):
				// Se a extensão da imagem não for a requerida, é efetuada uma mensagem de erro na tela do usuário
	      $_SESSION['error'] = "<h5 style='color: red;'><b>ERROR:</b> Por favor insira nos formato .jpg, .png ou .jpeg</h6>";
	      exit;
	    elseif ($_UP['size'] < $file['size']):
				// Se o tamanho da imagem não for a requerida, é efetuada uma mensagem de erro na tela do usuário
	      $_SESSION['error'] = "<h5 style='color: red;'><b>ERROR:</b> Por favor insira um imagem com o tamanho menor que 2MB!</h6>";
	      exit;
	    else:
				// Determinando o nome do arquivo
				$newName 	= uniqid(time()) . '-' . $extesion;
				// Determinando o nome do arquivo
	      $_SESSION["finalName"] 	= $newName;
				$_SESSION['error'] 			= null;
	    endif;

	    // Movendo o arquivo e renomeando o arquivo.
	    if (move_uploaded_file($file['tmp_name'], $_UP['folder'].$_SESSION["finalName"])):
				$stmt = $this->conn->prepare('INSERT INTO PROFILE_PICTURES (PICTURE, IDPLAYER) VALUES (?, ?)');
				$stmt->bindParam(1, $_SESSION['finalName'], PDO::PARAM_STR);
				$stmt->bindValue(2, 1, PDO::PARAM_INT);
				$stmt->execute();

				if ($stmt->rowCount() > 0):
					exit;
				endif;
	    else:
				// Caso não seja possível mover a imagem para a pasta destinada, é efutado uma mensagem de erro na tela do usuário e retorna false
	      $_SESSION['error'] = "<h5 style='color: red;'><b>ERRO:</b>Não foi possível fazer o upload da imagem neste momento, tente mais tarde!</h6>";
	      return false;
	      exit;
	    endif;
		}

		// Quando este método é chamado, é retornado um registro do Banco de dados
		public function image(){
			$stmt  = $this->conn->prepare('SELECT * FROM PROFILE_PICTURES WHERE IDPLAYER = ?');
			$stmt->bindValue(1, 1, PDO::PARAM_INT);
			$stmt->execute();

			if ($stmt->rowCount() > 0):
				while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
					$_SESSION['picture'] 	= 'uploads/up_profile/'.$row['PICTURE'];
					$_SESSION['change'] 	= true;
				}
			else:
				$_SESSION['picture'] 	= 'uploads/up_profile/user_default.png';
				$_SESSION['change'] 	= false;
			endif;
		}

		// Quando este método é chamado, é realizado o processo de mudança da foto de perfil
		public function changePicture(){
			// Definindo a pasta para upload
			$_UP['folder'] 	= 'uploads/up_profile/';
			// Definindo o tamanho do arquivo
	    $_UP['size'] 		= 1024*1024*2; // 2MB

	    // Definindo as extensões que serão aceitas
	    $_UP['extensions'] 	= array('jpg', 'png', 'jpeg');
	    $_UP['rename'] 			= true;
	    // Definindo a váriavel para receber a imagem
			$file_tmp = $_FILES['image']['tmp_name'];
	    $file 		= $_FILES['image'];
			// Pega a extensão
	    $extesion = pathinfo($file['name'], PATHINFO_EXTENSION);
			// Converte o nome da extensão em minúsculo
			$extesion = strtolower($extesion);

	   	if (array_search($extesion, $_UP['extensions']) === false):
				// Se a extensão da imagem não for a requerida, é efetuada uma mensagem de erro na tela do usuário
	      $_SESSION['error'] = "<h5 style='color: red;'><b>ERROR:</b> Por favor insira nos formato .jpg, .png ou .jpeg</h6>";
	      exit;
	    elseif ($_UP['size'] < $file['size']):
				// Se o tamanho da imagem não for a requerida, é efetuada uma mensagem de erro na tela do usuário
	      $_SESSION['error'] = "<h5 style='color: red;'><b>ERROR:</b> Por favor insira um imagem com o tamanho menor que 2MB!</h6>";
	      exit;
	    else:
				$delete 	= $this->conn->prepare('DELETE FROM PROFILE_PICTURES WHERE IDPLAYER = ?');
				$delete->bindParam(1, 1, PDO::PARAM_INT);
				$delete->execute();

				// Determinando o nome do arquivo
				$newName 	= uniqid(time()) . '-' . $extesion;

				// Determinando o nome do arquivo
	      $_SESSION["finalName"] 	= $newName;
				$_SESSION['error'] 			= null;
	    endif;

	    // Movendo o arquivo e renomeando o arquivo.
	    if (move_uploaded_file($file['tmp_name'], $_UP['folder'].$_SESSION["finalName"])):
				$stmt 	= $this->conn->prepare('UPDATE PROFILE_PICTURES SET PICTURE = ? WHERE IDPLAYER = ?');
				$stmt->bindParam(1, $_SESSION['finalName'], PDO::PARAM_STR);
				$stmt->bindValue(2, 1, PDO::PARAM_INT);
				$stmt->execute();
	    else:
				// Caso não seja possível mover a imagem para a pasta destinada, é efutado uma mensagem de erro na tela do usuário e retorna false
	      $_SESSION['error'] = "<h5 style='color: red;'><b>ERRO:</b>Não foi possível fazer o upload da imagem neste momento, tente mais tarde!</h6>";
	      return false;
	      exit;
	    endif;
		}
	}
?>
