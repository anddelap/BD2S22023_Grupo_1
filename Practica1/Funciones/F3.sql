USE BD2;
GO

CREATE FUNCTION dbo.F3
    (@UserId UNIQUEIDENTIFIER)
RETURNS TABLE
AS
RETURN
(
    SELECT N.Id, N.Message, N.Date
    FROM practica1.Notification N
    WHERE N.UserId = @UserId
);
GO