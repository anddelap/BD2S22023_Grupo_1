USE BD2;
GO

CREATE PROCEDURE dbo.PR4
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM practica1.Roles WHERE RoleName = @RoleName)
    BEGIN
        INSERT INTO practica1.Roles (Id, RoleName)
        VALUES (NEWID(), @RoleName);
        
        PRINT 'Rol Creado correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'El Rol ya existe.';
    END
END;
GO