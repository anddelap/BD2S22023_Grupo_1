USE BD2;
GO

CREATE OR ALTER PROCEDURE dbo.PR1 
    @Firstname varchar(max),
    @Lastname varchar(max), 
    @Email varchar(max), 
    @DateOfBirth datetime2(7), 
    @Password varchar(max), 
    @Credits int
AS
BEGIN
    DECLARE @ErrorMessage nvarchar(300);
    DECLARE @ErrorSeverity int;
    DECLARE @UserId uniqueidentifier;
    DECLARE @RolId uniqueidentifier;

    -- Validaciones de campos
    IF(@Firstname IS NULL OR @Firstname='')
        BEGIN 
            SET @ErrorMessage = 'El nombre no puede estar vacio';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    IF(@Lastname IS NULL OR @Lastname='')
        BEGIN 
            SET @ErrorMessage = 'El apellido no puede estar vacio';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    IF(@Email IS NULL OR @Email='')
        BEGIN 
            SET @ErrorMessage = 'El correo no puede estar vacio';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    IF(@DateOfBirth IS NULL)
        BEGIN
            SET @ErrorMessage = 'La fecha de nacimiento no puede ser null';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    IF(@Password IS NULL OR @Password='')
        BEGIN
            SET @ErrorMessage = 'El password no puede estar en blanco';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    IF(@Credits < 0)
        BEGIN
            SET @ErrorMessage = 'La cantidad de creditos no puede ser negativa';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END
    BEGIN TRY
        -- Validación de datos utilizando el procedimiento PR6
        EXEC practica1.PR6 @Firstname, @Lastname, @Credits;

        -- Validar si el correo ya está registrado
        IF EXISTS (SELECT 1 FROM practica1.Usuarios WHERE Email = @Email)
            BEGIN
                SET @ErrorMessage = 'Ya hay un usuario asociado con el correo indicado';
                SET @ErrorSeverity = 16;
                RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
                RETURN;
            END

        -- Creación de roles para estudiantes
        SET @RolId = (SELECT Id FROM practica1.Roles WHERE RoleName = 'Student');
        IF @RolId IS NULL
            BEGIN
                RAISERROR('El rol del estudiante no existe', 16, 1);
                RETURN;
            END

        -- Inicio de la transacción
        BEGIN TRANSACTION;

        -- Inserción en la tabla Usuarios
        SET @UserId = NEWID();
        INSERT INTO practica1.Usuarios(Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
        VALUES (@UserId, @Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 1);
        INSERT INTO practica1.HistoryLog(Date, Description) VALUES (GETDATE(), 'Insert - Tabla usuarios');

        -- Inserción en la tabla UsuarioRole
        INSERT INTO practica1.UsuarioRole (RoleId, UserId, IsLatestVersion)
        VALUES (@RolId, @UserId, 1);
        INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla UsuarioRole');

        -- Inserción en la tabla ProfileStudent
        INSERT INTO practica1.ProfileStudent (UserId, Credits)
        VALUES (@UserId, @Credits);
        INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla ProfileStudent');

        -- Inserción en la tabla TFA
        INSERT INTO practica1.TFA (UserId, Status, LastUpdate)
        VALUES (@UserId, 1, GETDATE());
        INSERT INTO practica1.HistoryLog (Date, Description)
        VALUES (GETDATE(), 'Insert - Tabla TFA');

        -- Inserción en la tabla Notification
        INSERT INTO practica1.Notification (UserId, Message, Date)
        VALUES (@UserId, 'Se ha registrado en el sistema', GETDATE());
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
        VALUES (GETDATE(), 'Error Regristro - ' + @ErrorMessage);
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH;
END;
