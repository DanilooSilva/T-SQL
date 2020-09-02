/*SP_CONFIGURE 'SHOW ADVANCED OPTIONS', 1
GO
RECONFIGURE
GO
SP_CONFIGURE 'OLE AUTOMATION PROCEDURES', 1
GO
RECONFIGURE
GO*/

DECLARE		@TOKEN				INT,
			@ENDERECO			VARCHAR(MAX),
			@URL				VARCHAR(MAX),
			@JSON				VARCHAR(8000),
			@STATUS				VARCHAR(MAX),
			@QTDE_RESULTADO		INT,
			@USUARIO			VARCHAR(MAX),

			--MAPEAR JSON
			@LOGIN				VARCHAR(MAX),
			@ID					VARCHAR(MAX),
			@NAME				VARCHAR(MAX),
			@TYPE				VARCHAR(MAX)

			SET @USUARIO = 'DanilooSilva'
			SET @URL = 'https://api.github.com/users/' + @USUARIO
			
			--OLE AUTOMATION E MECANISMO PARA COMUNICA��O ENTRE PORCESSOS BASEADO EM COMPONENT OBJECT MODEL (COM)
			EXEC SP_OACREATE 'MSXML2.XMLHTTP', @TOKEN OUT;
			-- CHAMANDA PARA M�TODO OPEN
			EXEC SP_OAMETHOD @TOKEN, 'OPEN', NULL, 'GET' , @URL, 'FALSE';
			-- CHAMADA PARA M�TODO SEND
			EXEC SP_OAMETHOD @TOKEN, 'SEND';
			-- CHAMDA PARA M�TODO RESPONSE TEXT
			EXEC SP_OAMETHOD @TOKEN, 'RESPONSETEXT', @JSON OUTPUT;

			-- SITE PARA VISUALIZAR JSON http://jsonviewer.stack.hu/
			--SELECT @JSON

			IF ISJSON(@JSON) = 1
			BEGIN

				SET @LOGIN = (SELECT [VALUE] FROM OPENJSON(@JSON) WHERE [KEY] = 'login')
				SET @ID = (SELECT [VALUE] FROM OPENJSON(@JSON) WHERE [KEY] = 'id')
				SET @TYPE = (SELECT [VALUE] FROM OPENJSON(@JSON) WHERE [KEY] = 'type')
				

				print @LOGIN
				PRINT @ID
				PRINT @TYPE 

			END

			EXEC SP_OADESTROY TOKEN