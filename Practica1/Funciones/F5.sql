USE BD2;
GO

CREATE FUNCTION dbo.F5()
RETURNS TABLE
AS
RETURN (
    SELECT
        U.Firstname,
        U.Lastname,
        U.Email,
        U.DateOfBirth,
        PS.Credits,
        R.RoleName
    FROM
        practica1.Usuarios U
    JOIN
        practica1.ProfileStudent PS ON U.Id = PS.UserId
    JOIN
        practica1.UsuarioRole UR ON U.Id = UR.UserId
    JOIN
        practica1.Roles R ON UR.RoleId = R.Id
    WHERE
        R.RoleName = 'Student'
);