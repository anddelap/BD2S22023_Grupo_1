USE BD2;
GO

CREATE OR ALTER PROCEDURE dbo.PR3
    @Email varchar(max),
    @CodCourse varchar(max)
AS
BEGIN
    DECLARE @ErrorMessage nvarchar(300);
    DECLARE @ErrorSeverity int;
    DECLARE @UserId uniqueidentifier;
    DECLARE @CourseId uniqueidentifier;
	DECLARE @TutorId uniqueidentifier;

    BEGIN TRY
        -- Validar si el usuario existe y está activo
        IF NOT EXISTS (SELECT 1 FROM practica1.Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
            BEGIN
                SET @ErrorMessage = 'El usuario no existe o no está activo';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Validar si el curso existe
        IF NOT EXISTS (SELECT 1 FROM practica1.Course WHERE CodCourse = @CodCourse)
            BEGIN
                SET @ErrorMessage = 'El curso no existe';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Validar si el usuario ya está asignado al curso
        IF EXISTS (SELECT 1 FROM practica1.CourseAssignment WHERE UserId = @UserId AND CodCourse = @CodCourse)
            BEGIN
                SET @ErrorMessage = 'El usuario ya está asignado a este curso';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Validar si el usuario cumple con los créditos necesarios del curso
        IF NOT EXISTS (SELECT 1 FROM practica1.ProfileStudent WHERE UserId = @UserId AND Credits >= (SELECT CreditsRequired FROM practica1.Course WHERE CodCourse = @CodCourse))
            BEGIN
                SET @ErrorMessage = 'El usuario no cumple con los créditos necesarios para este curso';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Obtener UserId
        SET @UserId = (SELECT Id FROM practica1.Usuarios WHERE Email = @Email);

        -- Obtener CourseId
        SET @CourseId = (SELECT Id FROM practica1.Course WHERE CodCourse = @CodCourse);

		 -- Obtener TutorId
        SET @TutorId = (SELECT TutorId FROM practica1.CourseTutor WHERE CourseCodCourse = @CodCourse);

        -- Inicio de la transacción
        BEGIN TRANSACTION;

        -- Insertar asignación de curso
        INSERT INTO practica1.CourseAssignment (UserId, CourseId, AssignmentDate)
        VALUES (@UserId, @CourseId, GETDATE());
		INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla CourseAssignment');

        -- Insertar notificación para el usuario
        INSERT INTO practica1.Notification (UserId, Message, Date)
        VALUES (@UserId, 'Ha sido asignado al curso ' + @CodCourse, GETDATE());
		INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla Notification');

		-- Insertar notificación para el Tutor
        INSERT INTO practica1.Notification (UserId, Message, Date)
        VALUES (@TutorId, 'Se asigno al curso el estudiante' + @UserId, GETDATE());
		INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla Notification');

        -- Confirmación de la transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Cancelación de la transacción en caso de error
        ROLLBACK;
        SELECT @ErrorMessage = ERROR_MESSAGE();

        -- Registro del error en la tabla HistoryLog
        INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Error Asignacion - ' + @ErrorMessage);

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH;
END;
