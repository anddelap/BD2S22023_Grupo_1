USE BD2;
GO

CREATE OR ALTER FUNCTION dbo.F4 ()
RETURNS TABLE
AS
RETURN
(
    SELECT Date, Description
    FROM practica1.HistoryLog
);
Go