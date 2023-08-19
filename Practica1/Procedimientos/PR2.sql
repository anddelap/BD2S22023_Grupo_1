USE BD2;
GO

CREATE PROCEDURE dbo.PR2
    @Email NVARCHAR(100),
    @CodCourse INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el usuario existe y su cuenta está confirmada
    DECLARE @UserId UNIQUEIDENTIFIER;
    SELECT @UserId = Id FROM practica1.Usuarios WHERE Email = @Email AND EmailConfirmed = 1;

    IF @UserId IS NOT NULL
    BEGIN
            -- Insertar el rol de tutor para el estudiante
            INSERT INTO practica1.UsuarioRole (RoleId, UserId, IsLatestVersion)
            VALUES ('2cf8e1cf-3cd6-44f3-8f86-1386b7c17657', @UserId, 1);

            -- Insertar el perfil de tutor
            INSERT INTO practica1.TutorProfile (UserId, TutorCode)
            VALUES (@UserId, NEWID());

            -- Asignar el estudiante como tutor del curso especificado
            INSERT INTO practica1.CourseTutor (TutorId, CourseCodCourse)
            VALUES (@UserId, @CodCourse);

            -- Enviar notificación por correo electrónico
            DECLARE @Message NVARCHAR(MAX);
            SET @Message = 'Usted ha sido promovido a tutor correctamente' + CAST(@CodCourse AS NVARCHAR(10)) + '.';
            INSERT INTO practica1.Notification (UserId, Message, Date)
            VALUES (@UserId, @Message, GETDATE());

            PRINT 'El estudiante ha sido promovido como tutor y se le ha notificado';
    END
    ELSE
    BEGIN
        PRINT 'usuario no existe o no ha confirmado su cuenta.';
    END
END;
GO