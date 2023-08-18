USE BD2;
GO

CREATE FUNCTION dbo.F1
(
    @CodCourse varchar(max)
)
RETURNS TABLE
AS
RETURN
(
    SELECT U.Id, U.Firstname, U.Lastname
    FROM practica1.CourseAssignment AS CA
    JOIN practica1.Usuarios AS U ON CA.StudentId = U.Id
    WHERE CA.CourseCodCourse = @CodCourse
);
GO