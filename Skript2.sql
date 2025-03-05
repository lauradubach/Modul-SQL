-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Location` (
  `idLocation` INT NOT NULL AUTO_INCREMENT,
  `Standort` VARCHAR(45) NULL,
  PRIMARY KEY (`idLocation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trainer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Trainer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Trainer` (
  `idTrainer` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Vorname` VARCHAR(45) NULL,
  `Telefonnummer` VARCHAR(45) NULL,
  `Location_idLocation` INT NOT NULL,
  PRIMARY KEY (`idTrainer`),
  INDEX `fk_Trainer_Standort Gym_idx` (`Location_idLocation` ASC) VISIBLE,
  CONSTRAINT `fk_Trainer_Standort Gym`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `mydb`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Session` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Session` (
  `idSession` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Trainer_idTrainer` INT NOT NULL,
  PRIMARY KEY (`idSession`),
  INDEX `fk_Session_Trainer1_idx` (`Trainer_idTrainer` ASC) VISIBLE,
  CONSTRAINT `fk_Session_Trainer1`
    FOREIGN KEY (`Trainer_idTrainer`)
    REFERENCES `mydb`.`Trainer` (`idTrainer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Plan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Plan` (
  `idPlan` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlan`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Membership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Membership` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Membership` (
  `idMembership` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Plan_idPlan` INT NULL,
  PRIMARY KEY (`idMembership`),
  INDEX `fk_Membership_Plans1_idx` (`Plan_idPlan` ASC) VISIBLE,
  CONSTRAINT `fk_Membership_Plans1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Member` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Member` (
  `idMember` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Vorname` VARCHAR(45) NULL,
  `Telefonnummer` VARCHAR(45) NULL,
  `Membership_idMembership` INT NOT NULL,
  PRIMARY KEY (`idMember`),
  INDEX `fk_Member_Membership1_idx` (`Membership_idMembership` ASC) VISIBLE,
  CONSTRAINT `fk_Member_Membership1`
    FOREIGN KEY (`Membership_idMembership`)
    REFERENCES `mydb`.`Membership` (`idMembership`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipment` (
  `idEquipment` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Location_idLocation` INT NOT NULL,
  PRIMARY KEY (`idEquipment`),
  INDEX `fk_Equipment_Standort Gym1_idx` (`Location_idLocation` ASC) VISIBLE,
  CONSTRAINT `fk_Equipment_Standort Gym1`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `mydb`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exercise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Exercise` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Exercise` (
  `idExercise` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`idExercise`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Session_has_Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Session_has_Member` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Session_has_Member` (
  `Session_idSession` INT NOT NULL,
  `Member_idMember` INT NOT NULL,
  PRIMARY KEY (`Session_idSession`, `Member_idMember`),
  INDEX `fk_Session_has_Member_Member1_idx` (`Member_idMember` ASC) VISIBLE,
  INDEX `fk_Session_has_Member_Session1_idx` (`Session_idSession` ASC) VISIBLE,
  CONSTRAINT `fk_Session_has_Member_Session1`
    FOREIGN KEY (`Session_idSession`)
    REFERENCES `mydb`.`Session` (`idSession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Session_has_Member_Member1`
    FOREIGN KEY (`Member_idMember`)
    REFERENCES `mydb`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exercise_has_Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Exercise_has_Plan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Exercise_has_Plan` (
  `Exercise_idExercise` INT NOT NULL,
  `Plan_idPlan` INT NOT NULL,
  PRIMARY KEY (`Exercise_idExercise`, `Plan_idPlan`),
  INDEX `fk_Exercise_has_Plan_Plan1_idx` (`Plan_idPlan` ASC) VISIBLE,
  INDEX `fk_Exercise_has_Plan_Exercise1_idx` (`Exercise_idExercise` ASC) VISIBLE,
  CONSTRAINT `fk_Exercise_has_Plan_Exercise1`
    FOREIGN KEY (`Exercise_idExercise`)
    REFERENCES `mydb`.`Exercise` (`idExercise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exercise_has_Plan_Plan1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Member_has_Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Member_has_Plan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Member_has_Plan` (
  `Member_idMember` INT NOT NULL,
  `Plan_idPlan` INT NOT NULL,
  PRIMARY KEY (`Member_idMember`, `Plan_idPlan`),
  INDEX `fk_Member_has_Plan_Plan1_idx` (`Plan_idPlan` ASC) VISIBLE,
  INDEX `fk_Member_has_Plan_Member1_idx` (`Member_idMember` ASC) VISIBLE,
  CONSTRAINT `fk_Member_has_Plan_Member1`
    FOREIGN KEY (`Member_idMember`)
    REFERENCES `mydb`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Member_has_Plan_Plan1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipment_has_Exercise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipment_has_Exercise` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipment_has_Exercise` (
  `Equipment_idEquipment` INT NOT NULL,
  `Exercise_idExercise` INT NOT NULL,
  PRIMARY KEY (`Equipment_idEquipment`, `Exercise_idExercise`),
  INDEX `fk_Equipment_has_Exercise_Exercise1_idx` (`Exercise_idExercise` ASC) VISIBLE,
  INDEX `fk_Equipment_has_Exercise_Equipment1_idx` (`Equipment_idEquipment` ASC) VISIBLE,
  CONSTRAINT `fk_Equipment_has_Exercise_Equipment1`
    FOREIGN KEY (`Equipment_idEquipment`)
    REFERENCES `mydb`.`Equipment` (`idEquipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipment_has_Exercise_Exercise1`
    FOREIGN KEY (`Exercise_idExercise`)
    REFERENCES `mydb`.`Exercise` (`idExercise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
