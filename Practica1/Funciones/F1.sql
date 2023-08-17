USE BD2;
GO

CREATE OR ALTER FUNCTION dbo.F1
(
    @CodCourse varchar(max)
)
RETURNS TABLE
AS
RETURN
(
    SELECT U.Id, U.Firstname, U.Lastname
    FROM practica1.CourseAssignment AS CA
    JOIN practica1.Usuarios AS U ON CA.UserId = U.Id
    WHERE CA.CourseId = @CodCourse
);
