USE BD2;
-- Trigger para el procedimiento PR1



-- Trigger para el procedimiento PR2
GO
CREATE TRIGGER TR_PR2
ON practica1.TutorProfile
AFTER INSERT, UPDATE
AS
BEGIN
    INSERT INTO practica1.HistoryLog (Date, Description)
    VALUES (GETDATE(), 'Se creo un nuevo tutor');
END;

-- Trigger para el procedimiento PR3



-- Trigger para el procedimiento PR4
GO
CREATE TRIGGER TR_PR4
ON practica1.Roles
AFTER INSERT, UPDATE
AS
BEGIN
    INSERT INTO practica1.HistoryLog (Date, Description)
    VALUES (GETDATE(), 'Se creo un nuevo rol');
END;

-- Trigger para el procedimiento PR5
GO
CREATE TRIGGER TR_PR5
ON practica1.Course
AFTER INSERT, UPDATE
AS
BEGIN
    INSERT INTO practica1.HistoryLog (Date, Description)
    VALUES (GETDATE(), 'Se creo un nuevo curso');
END;