USE BD2;
GO

CREATE PROCEDURE dbo.PR5
	@CodCourse INT,
    @Name NVARCHAR(MAX),
    @CreditsRequired INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ErrorMessage nvarchar(300);
    DECLARE @ErrorSeverity int;

    -- Validaciones de campos
    IF(@Name IS NULL OR @Name='')
        BEGIN 
            SET @ErrorMessage = 'El nombre no puede estar vacio';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    IF(@CreditsRequired < 0)
        BEGIN
            SET @ErrorMessage = 'La cantidad de creditos no puede ser negativa';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    DECLARE @IsValid BIT;
    EXEC dbo.PR6 'Course', NULL, NULL, @Name, @CreditsRequired, @IsValid OUTPUT;
    IF(@IsValid = 0)
        BEGIN
            SET @ErrorMessage = 'Los atributos son inválidos';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    DECLARE @id INT;
    SELECT @id = CodCourse FROM practica1.Course WHERE CodCourse = @CodCourse;
	IF(@id IS NOT NULL)
    BEGIN
        SET @ErrorMessage = 'Ese curso ya existe';
        SET @ErrorSeverity = 16;
        RAISERROR(@ErrorMessage,@ErrorSeverity,1);
        RETURN;
    END

    -- Insertar el nuevo registro en la tabla "cursos"
    INSERT INTO practica1.Course (CodCourse, Name, CreditsRequired)
    VALUES (@CodCourse, @Name, @CreditsRequired);

    PRINT 'Curso creado correctamente';
END;
GO