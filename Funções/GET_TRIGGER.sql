CREATE FUNCTION GET_TRIGGER(@TABELA VARCHAR(1000))
	RETURNS VARCHAR(1000)
BEGIN
	DECLARE @TRIGGER		VARCHAR(1000) = ''
	DECLARE @TRIGGERAUX		VARCHAR(1000)

	SELECT	@TRIGGER =  REPLACE(REPLACE((	SELECT A.name
						FROM	sys.triggers					A(NOLOCK) 
								INNER JOIN sys.tables			B(NOLOCK) ON A.parent_id = B.object_id
						WHERE B.name = @TABELA 
						FOR XML PATH
					), '<row><name>', ''), '</name></row>', ', ')

	SET @TRIGGER = LEFT(@TRIGGER, LEN(@TRIGGER) - 1)

	RETURN @TRIGGER

END