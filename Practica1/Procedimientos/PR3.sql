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
    DECLARE @CourseId varchar(max);
	DECLARE @TutorId uniqueidentifier;

    BEGIN TRY
	   -- Obtener UserId
        SET @UserId = (SELECT Id FROM practica1.Usuarios WHERE Email = @Email);

        -- Obtener CourseId
        SET @CourseId = (SELECT CodCourse FROM practica1.Course WHERE CodCourse = @CodCourse);

		 -- Obtener TutorId
        SET @TutorId = (SELECT TutorId FROM practica1.CourseTutor WHERE CourseCodCourse = @CodCourse);

        -- Validar si el usuario existe y está activo
        IF NOT EXISTS (SELECT * FROM practica1.Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
            BEGIN
                SET @ErrorMessage = 'El usuario no existe o no está activo';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Validar si el curso existe
        IF NOT EXISTS (SELECT * FROM practica1.Course WHERE CodCourse = @CodCourse)
            BEGIN
                SET @ErrorMessage = 'El curso no existe';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Validar si el usuario ya está asignado al curso
        IF EXISTS (SELECT * FROM practica1.CourseAssignment WHERE StudentId = @UserId AND CourseCodCourse = @CodCourse)
            BEGIN
                SET @ErrorMessage = 'El usuario ya está asignado a este curso';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Validar si el usuario cumple con los créditos necesarios del curso
        IF NOT EXISTS (SELECT * FROM practica1.ProfileStudent WHERE UserId = @UserId AND Credits >= (SELECT CreditsRequired FROM practica1.Course WHERE CodCourse = @CodCourse))
            BEGIN
                SET @ErrorMessage = 'El usuario no cumple con los créditos necesarios para este curso';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        

        -- Inicio de la transacción
        BEGIN TRANSACTION;

        -- Insertar asignación de curso
        INSERT INTO practica1.CourseAssignment (StudentId,CourseCodCourse)
        VALUES (@UserId, @CourseId);
		INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla CourseAssignment');

        -- Insertar notificación para el usuario
        INSERT INTO practica1.Notification (UserId, Message, Date)
        VALUES (@UserId, 'Ha sido asignado al curso ' + @CodCourse, GETDATE());
		INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla Notification');

		-- Insertar notificación para el Tutor
        INSERT INTO practica1.Notification (UserId, Message, Date)
        VALUES (@TutorId, 'Se asigno al curso un estudiante', GETDATE());
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

EXEC dbo.PR3 'Wichox12@Hotmail.com','964';

SELECT Id FROM practica1.Usuarios WHERE Email = 'Wichox12@Hotmail.com' ;
SELECT TutorId FROM practica1.CourseTutor WHERE CourseCodCourse = '964';
Select * from practica1.Course;
Select * from practica1.Usuarios;
SELECT * FROM practica1.ProfileStudent;
Select * From practica1.TutorProfile;
Select * From practica1.CourseTutor;

INSERT INTO practica1.TutorProfile (UserId, TutorCode)
        VALUES ('00A649EB-F7A1-4D7B-BD3F-57012CF8C005', 'ola');

INSERT INTO practica1.CourseTutor(TutorId,CourseCodCourse)
        VALUES ('00A649EB-F7A1-4D7B-BD3F-57012CF8C005', '964');
