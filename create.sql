-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CID` INT NOT NULL,
  `mimingDollars` INT NULL,
  PRIMARY KEY (`CID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PrivateCust`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PrivateCust` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PrivateCust` (
  `cName` VARCHAR(40) NOT NULL,
  `email` VARCHAR(45) NULL,
  `mailingAddress` VARCHAR(45) NULL,
  `CID` INT NOT NULL,
  INDEX `CID_idx` (`CID` ASC) VISIBLE,
  PRIMARY KEY (`CID`, `cName`),
  CONSTRAINT `privatecust_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `mydb`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`corporation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`corporation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`corporation` (
  `corpName` VARCHAR(45) NOT NULL,
  `orgName` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`corpName`, `CID`),
  INDEX `CID_idx` (`CID` ASC) VISIBLE,
  CONSTRAINT `corp_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `mydb`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `OID` INT NOT NULL,
  `orderStart` DATETIME NULL,
  `orderFinish` DATETIME NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`OID`, `CID`),
  INDEX `CID_idx` (`CID` ASC) VISIBLE,
  CONSTRAINT `order_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `mydb`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`togo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`togo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`togo` (
  `togoID` INT NOT NULL,
  `orderStart` DATETIME NULL,
  `orderFinish` VARCHAR(45) NULL,
  `pickUpTime` VARCHAR(45) NULL,
  PRIMARY KEY (`togoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`togoTime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`togoTime` ;

CREATE TABLE IF NOT EXISTS `mydb`.`togoTime` (
  `togoID` INT NOT NULL,
  `OID` INT NOT NULL,
  `orderStart` DATETIME NOT NULL,
  `orderFinish` DATETIME NULL,
  PRIMARY KEY (`togoID`, `OID`, `orderStart`),
  INDEX `OID_idx` (`OID` ASC) VISIBLE,
  CONSTRAINT `togotime_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `mydb`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `togotime_fk_togoID`
    FOREIGN KEY (`togoID`)
    REFERENCES `mydb`.`togo` (`togoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menuItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`menuItem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`menuItem` (
  `name` VARCHAR(45) NOT NULL,
  `spicyness` VARCHAR(45) NULL,
  `catagorey` VARCHAR(45) NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Menu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `menuType` INT NOT NULL,
  PRIMARY KEY (`menuType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ItemOnMenu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ItemOnMenu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ItemOnMenu` (
  `MenuItemID` INT NOT NULL,
  `menuType` INT NULL,
  `price` INT NULL,
  `size` VARCHAR(1) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemID`),
  INDEX `name_idx` (`name` ASC) VISIBLE,
  INDEX `menuType_idx` (`menuType` ASC) VISIBLE,
  CONSTRAINT `itemonmenu_fk_name`
    FOREIGN KEY (`name`)
    REFERENCES `mydb`.`menuItem` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `itemonmenu_fk_menuType`
    FOREIGN KEY (`menuType`)
    REFERENCES `mydb`.`Menu` (`menuType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orderItem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orderItem` (
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`OID`, `CID`, `MenuItemID`),
  INDEX `MenuItemID_idx` (`MenuItemID` ASC) VISIBLE,
  INDEX `CID_idx` (`CID` ASC) VISIBLE,
  CONSTRAINT `orderitem_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `mydb`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitem_fk_MenuItemID`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `mydb`.`ItemOnMenu` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitem_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `mydb`.`order` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Brunch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Brunch` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Brunch` (
  `menuType` INT NOT NULL,
  `SetPrice` INT NULL,
  PRIMARY KEY (`menuType`),
  CONSTRAINT `brunch_fk_menuType`
    FOREIGN KEY (`menuType`)
    REFERENCES `mydb`.`Menu` (`menuType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `EID` INT NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `payMethod` VARCHAR(4) NULL,
  PRIMARY KEY (`EID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shift`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`shift` ;

CREATE TABLE IF NOT EXISTS `mydb`.`shift` (
  `SID` INT NOT NULL,
  `timeShift` DATETIME NULL,
  PRIMARY KEY (`SID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WaitStaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`WaitStaff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`WaitStaff` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `hours` INT NULL,
  PRIMARY KEY (`EID`, `SID`),
  INDEX `SID_idx` (`SID` ASC) VISIBLE,
  CONSTRAINT `waitstaff_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `waitstaff_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Table` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Table` (
  `EID` INT NULL,
  `TableNumber` INT NOT NULL,
  PRIMARY KEY (`TableNumber`),
  INDEX `EID_idx` (`EID` ASC) VISIBLE,
  CONSTRAINT `table_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`WaitStaff` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InPerson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`InPerson` ;

CREATE TABLE IF NOT EXISTS `mydb`.`InPerson` (
  `OID` INT NOT NULL,
  `partySize` INT NULL,
  `tableNumber` INT NULL,
  PRIMARY KEY (`OID`),
  INDEX `tableNumber_idx` (`tableNumber` ASC) VISIBLE,
  CONSTRAINT `inperson_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `mydb`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inperson_fk_tableNumber`
    FOREIGN KEY (`tableNumber`)
    REFERENCES `mydb`.`Table` (`TableNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Manager` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Manager` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `salaryAmount` INT NULL,
  PRIMARY KEY (`EID`, `SID`),
  INDEX `SID_idx` (`SID` ASC) VISIBLE,
  CONSTRAINT `manager_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `manager_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dishwasher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dishwasher` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dishwasher` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `hours` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `SID`),
  INDEX `SID_idx` (`SID` ASC) VISIBLE,
  CONSTRAINT `dishwasher_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dishwasher_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MaitreD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MaitreD` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MaitreD` (
  `SID` INT NOT NULL,
  `EID` INT NOT NULL,
  `hours` INT NULL,
  PRIMARY KEY (`SID`, `EID`),
  CONSTRAINT `maitreD_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `maitreD_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LineCook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LineCook` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LineCook` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  PRIMARY KEY (`EID`, `SID`),
  INDEX `SID_idx` (`SID` ASC) VISIBLE,
  CONSTRAINT `linecook_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `linecook_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SousChef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SousChef` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SousChef` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  PRIMARY KEY (`EID`, `SID`),
  INDEX `souschef_fk_SID_idx` (`SID` ASC) VISIBLE,
  CONSTRAINT `souschef_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `souschef_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HeadChef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`HeadChef` ;

CREATE TABLE IF NOT EXISTS `mydb`.`HeadChef` (
  `SID` INT NOT NULL,
  `EID` INT NOT NULL,
  PRIMARY KEY (`SID`, `EID`),
  INDEX `EID_idx` (`EID` ASC) VISIBLE,
  CONSTRAINT `headchef_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `headchef_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `mydb`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Recipe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Recipe` (
  `EID` INT NOT NULL,
  `RecipeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EID`, `RecipeName`),
  CONSTRAINT `recipe_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`HeadChef` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Department` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `EID` INT NOT NULL,
  `departmentID` INT NOT NULL,
  `dName` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `departmentID`),
  CONSTRAINT `deparment_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`LineCook` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`skills` ;

CREATE TABLE IF NOT EXISTS `mydb`.`skills` (
  `EID` INT NULL,
  `skillName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`skillName`),
  CONSTRAINT `skills_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mentorship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mentorship` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mentorship` (
  `EID` INT NOT NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `skillName` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`),
  INDEX `skillName_idx` (`skillName` ASC) VISIBLE,
  CONSTRAINT `mentorship_skillName_fk`
    FOREIGN KEY (`skillName`)
    REFERENCES `mydb`.`skills` (`skillName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menotorship1_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `mydb`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Web`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Web` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Web` (
  `OID` INT NOT NULL,
  `ip` INT NULL,
  PRIMARY KEY (`OID`),
  CONSTRAINT `web_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `mydb`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Phone` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Phone` (
  `OID` INT NOT NULL,
  `phone` INT NULL,
  PRIMARY KEY (`OID`),
  CONSTRAINT `phone_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `mydb`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
