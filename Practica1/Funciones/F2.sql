USE BD2;
GO

CREATE FUNCTION dbo.F2
    (@TutorProfileId uniqueidentifier)
RETURNS TABLE
AS
RETURN
(
    SELECT C.CodCourse, C.Name
    FROM practica1.CourseTutor CT
    JOIN practica1.Course C ON CT.CourseCodCourse = C.CodCourse
    WHERE CT.TutorId = @TutorProfileId
);
GO