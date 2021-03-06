CREATE DATABASE WINNCHAY;
	USE WINNCHAY;

CREATE TABLE CATEGORIES(
	IDCATEGORY INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	CATEGORY VARCHAR(25) NOT NULL,

	CONSTRAINT UQ_CATEGORY UNIQUE (CATEGORY)
);

CREATE TABLE HISTORIC(
	IDHISTORIC INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	NAME_CHAMP VARCHAR(50) NOT NULL,
	PLAYER1 INT(11) NOT NULL,
	PLAYER2 INT(11) NOT NULL,
	P1VICTORY VARCHAR(10) DEFAULT 'NO',
	P2VICTORY VARCHAR(10) DEFAULT 'NO',
	P1GOALS INT(2) NOT NULL,
	P2GOALS INT(2) NOT NULL,
	HISTORIC_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ESPORTS(
	ID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	GAME VARCHAR(25) NOT NULL,

	CONSTRAINT UQ_GAME UNIQUE (GAME)
);

CREATE TABLE PLATFORMS(
	IDPLATFORM INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	PLATFORM VARCHAR(20) NOT NULL,

	CONSTRAINT UQ_PLATFORM UNIQUE (PLATFORM)
);

CREATE TABLE PICTURES(
	IDPICTURE INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	PICTURE VARCHAR(100) NOT NULL
);

CREATE TABLE PLAYERS(
	IDPLAYER INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FIRST_NAME VARCHAR(20) NOT NULL,
	LAST_NAME VARCHAR(20) NOT NULL,
	USERNAME VARCHAR(16) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	PASSWORD VARCHAR(16) NOT NULL,
	TEAM VARCHAR(16),
	CPF INT(11),
	PHONE CHAR(14) NOT NULL,
	AVALIACAO DECIMAL(2,1),
	FOLLOWERS INT(11) NOT NULL DEFAULT 0,
	WINS INT(11) NOT NULL DEFAULT 0,
	LOSES INT(11) NOT NULL DEFAULT 0,
	DRAWS INT(11) NOT NULL DEFAULT 0,
	LEVEL INT(11) DEFAULT 1,
	POINTS INT(11) DEFAULT 0,
	MAXPOINTS INT(11) DEFAULT 100,

	CONSTRAINT UQ_EMAIL_PLAYERS UNIQUE (EMAIL),
	CONSTRAINT UQ_CPF_PLAYERS UNIQUE (CPF),
	CONSTRAINT UQ_USERNAME_PLAYERS UNIQUE (USERNAME)
);

CREATE TABLE NOTIFICATIONS(
	IDNOTIFICATIONS INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	IDPLAYER INT(11) NOT NULL,
	TITLE VARCHAR(25) NOT NULL,
	DESCRIPTION VARCHAR(150) NOT NULL,

	CONSTRAINT FK_IDPLAYER_NOTIFICATIONS FOREIGN KEY (IDPLAYER) REFERENCES PLAYERS (IDPLAYER)
);

CREATE TABLE FOLLOWERS(
	IDFOLLOWERS INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	IDFOLLOWER INT(11),
	IDFOLLOWED INT(11)
);

CREATE TABLE TEAM(
	IDTEAM INT(11) NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	NAME VARCHAR(16) NOT NULL,
	IDPICTURE INT(11) NOT NULL DEFAULT 2,
	IDPLAYER INT(11),
	BIOGRAPHY VARCHAR(120),

	CONSTRAINT UQ_NAME_TEAMS UNIQUE (NAME),
	CONSTRAINT FK_IDPLAYER_TEAMS FOREIGN KEY (IDPLAYER) REFERENCES PLAYERS (IDPLAYER),
	CONSTRAINT FK_IDPICTURE_TEAMS FOREIGN KEY (IDPICTURE) REFERENCES PICTURES (IDPICTURE)
);


CREATE TABLE PROFILE_PICTURES(
	IDPROFILE INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	IDPLAYER INT(11) NOT NULL,
	PICTURE VARCHAR(35) NOT NULL,

	CONSTRAINT FK_IDPLAYER_PROFILE FOREIGN KEY (IDPLAYER) REFERENCES PLAYERS (IDPLAYER)
);

CREATE TABLE RANKING_FIFA(
	IDRKG_FIFA INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	IDPLAYER INT(11) NOT NULL,
	USERNAME VARCHAR(16) NOT NULL,

	CONSTRAINT FK_IDPLAYER_RKGFIFA FOREIGN KEY (IDPLAYER) REFERENCES PLAYERS (IDPLAYER)
);

CREATE TABLE NUMPLAYERS(
	IDNUMPLAYERS INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	NAME_CHAMP VARCHAR(50) NOT NULL,
	IDADM INT(11) NOT NULL,
	NUMPLAYERS INT(11) NOT NULL,

	CONSTRAINT UQ_NAMECHAMP_NPLAYERS UNIQUE (NAME_CHAMP),
	CONSTRAINT FK_IDADM_NPLAYERS FOREIGN KEY (IDADM) REFERENCES PLAYERS (IDPLAYER)
);

CREATE TABLE THOPHY(
	IDTHOPHY INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	THOPHY VARCHAR(20) NOT NULL,

	CONSTRAINT UQ_THOPHY_THOPHY UNIQUE (THOPHY)
);

CREATE TABLE CHAMPIONSHIPS (
	IDCHAMP INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	IDADM INT(11) NOT NULL,
	IDPICTURE INT(11) DEFAULT 1,
	IDTHOPHY INT(11),
	CHAMPION VARCHAR(16),
	NAME VARCHAR(50) NOT NULL,
	REAL_NAME VARCHAR(50) NOT NULL,
	START_DATE VARCHAR(10) NOT NULL,
	IDPLATFORM INT(11) NOT NULL,
	AWARDS VARCHAR(100),
	DESCRIPTION VARCHAR(160) NOT NULL,
	IDNUMPLAYERS INT(11) NOT NULL,

	CONSTRAINT UQ_NAMECHAMP_CHAMP UNIQUE (NAME),
	CONSTRAINT FK_IDTHOPHY_CHAMP FOREIGN KEY (IDTHOPHY) REFERENCES THOPHY (IDTHOPHY),
	CONSTRAINT FK_IDADM_CHAMP FOREIGN KEY (IDADM) REFERENCES PLAYERS (IDPLAYER),
	CONSTRAINT FK_NUMPLAYERS_CHAMP  FOREIGN KEY (IDNUMPLAYERS) REFERENCES NUMPLAYERS (IDNUMPLAYERS),
	CONSTRAINT FK_IDPLATFORM_CHAMP FOREIGN KEY (IDPLATFORM) REFERENCES PLATFORMS (IDPLATFORM),
	CONSTRAINT FK_PICTURES_CHAMP FOREIGN KEY (IDPICTURE) REFERENCES PICTURES (IDPICTURE)
);

INSERT INTO PICTURES (PICTURE) VALUES('uploads/up_pictures/default_champ.png');
INSERT INTO PICTURES (PICTURE) VALUES('uploads/up_pictures/default_team.png');

INSERT INTO PLATFORMS (PLATFORM) VALUES ('PC');
INSERT INTO PLATFORMS (PLATFORM) VALUES ('PS4');
INSERT INTO PLATFORMS (PLATFORM) VALUES ('XBOX');

INSERT INTO PLAYERS (FIRST_NAME, LAST_NAME, USERNAME, EMAIL, PASSWORD, CPF, PHONE, WINS, LOSES, DRAWS) VALUES ('DANILO', 'ALMEIDA', 'DAN', 'DANILO8ALMEIDA@HOTMAIL.COM', '12345', '42409149812', '11963273155',  8, 2, 0);
