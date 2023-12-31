-- MySQL Script generated by MySQL Workbench
-- Wed Aug 30 22:43:13 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
--  Measure-Command {mysqldump -u root -p BD2_Prac2 > bk_completo1.sql}

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD2_Prac2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD2_Prac2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD2_Prac2` DEFAULT CHARACTER SET utf8 ;
USE `BD2_Prac2` ;

-- -----------------------------------------------------
-- Table `BD2_Prac2`.`HABITACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD2_Prac2`.`HABITACION` (
  `idHabitacion` INT NOT NULL AUTO_INCREMENT,
  `habitacion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idHabitacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD2_Prac2`.`LOG_HABITACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD2_Prac2`.`LOG_HABITACION` (
  `timestampx` VARCHAR(100) NOT NULL,
  `statusx` VARCHAR(45) NOT NULL,
  `idHabitacion` INT NOT NULL,
  PRIMARY KEY (`timestampx`, `idHabitacion`),
  INDEX `fk_log_habitacion_Habitacion_idx` (`idHabitacion` ASC) VISIBLE,
  CONSTRAINT `fk_log_habitacion_Habitacion`
    FOREIGN KEY (`idHabitacion`)
    REFERENCES `BD2_Prac2`.`HABITACION` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD2_Prac2`.`PACIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD2_Prac2`.`PACIENTE` (
  `idPaciente` INT NOT NULL AUTO_INCREMENT,
  `edad` INT NOT NULL,
  `genero` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idPaciente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD2_Prac2`.`LOG_ACTIVIDAD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD2_Prac2`.`LOG_ACTIVIDAD` (
  `id_log_actividad` INT NOT NULL AUTO_INCREMENT,
  `timestampx` VARCHAR(100) NOT NULL,
  `actividad` VARCHAR(500) NOT NULL,
  `HABITACION_idHabitacion` INT NOT NULL,
  `PACIENTE_idPaciente` INT NOT NULL,
  PRIMARY KEY (`id_log_actividad`),
  INDEX `fk_LOG_ACTIVIDAD_HABITACION1_idx` (`HABITACION_idHabitacion` ASC) VISIBLE,
  INDEX `fk_LOG_ACTIVIDAD_PACIENTE1_idx` (`PACIENTE_idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_LOG_ACTIVIDAD_HABITACION1`
    FOREIGN KEY (`HABITACION_idHabitacion`)
    REFERENCES `BD2_Prac2`.`HABITACION` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LOG_ACTIVIDAD_PACIENTE1`
    FOREIGN KEY (`PACIENTE_idPaciente`)
    REFERENCES `BD2_Prac2`.`PACIENTE` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
