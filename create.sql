-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cecs323sec5s22
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cecs323sec5s22
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cecs323sec5s22` DEFAULT CHARACTER SET utf8 ;
USE `cecs323sec5s22` ;

-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Customer` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Customer` (
  `CID` INT NOT NULL,
  `mimingDollars` INT NULL,
  PRIMARY KEY (`CID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`PrivateCust`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`PrivateCust` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`PrivateCust` (
  `cName` VARCHAR(40) NOT NULL,
  `email` VARCHAR(45) NULL,
  `mailingAddress` VARCHAR(45) NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`CID`, `cName`),
  CONSTRAINT `privatecust_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5s22`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`corporation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`corporation` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`corporation` (
  `corpName` VARCHAR(45) NOT NULL,
  `orgName` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`corpName`, `CID`),
  CONSTRAINT `corp_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5s22`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`order` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`order` (
  `OID` INT NOT NULL,
  `orderStart` DATETIME NULL,
  `orderFinish` DATETIME NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`OID`, `CID`),
  CONSTRAINT `order_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5s22`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`togo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`togo` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`togo` (
  `togoID` INT NOT NULL,
  `orderStart` DATETIME NULL,
  `orderFinish` VARCHAR(45) NULL,
  `pickUpTime` VARCHAR(45) NULL,
  PRIMARY KEY (`togoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`togoTime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`togoTime` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`togoTime` (
  `togoID` INT NOT NULL,
  `OID` INT NOT NULL,
  `orderStart` DATETIME NOT NULL,
  `orderFinish` DATETIME NULL,
  PRIMARY KEY (`togoID`, `OID`, `orderStart`),
  CONSTRAINT `togotime_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5s22`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `togotime_fk_togoID`
    FOREIGN KEY (`togoID`)
    REFERENCES `cecs323sec5s22`.`togo` (`togoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`menuItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`menuItem` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`menuItem` (
  `name` VARCHAR(45) NOT NULL,
  `spicyness` VARCHAR(45) NULL,
  `catagorey` VARCHAR(45) NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Menu` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Menu` (
  `menuType` INT NOT NULL,
  PRIMARY KEY (`menuType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`ItemOnMenu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`ItemOnMenu` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`ItemOnMenu` (
  `MenuItemID` INT NOT NULL,
  `menuType` INT NULL,
  `price` INT NULL,
  `size` VARCHAR(1) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemID`),
  
  CONSTRAINT `itemonmenu_fk_name`
    FOREIGN KEY (`name`)
    REFERENCES `cecs323sec5s22`.`menuItem` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `itemonmenu_fk_menuType`
    FOREIGN KEY (`menuType`)
    REFERENCES `cecs323sec5s22`.`Menu` (`menuType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`orderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`orderItem` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`orderItem` (
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`OID`, `CID`, `MenuItemID`),

  CONSTRAINT `orderitem_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5s22`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitem_fk_MenuItemID`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `cecs323sec5s22`.`ItemOnMenu` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitem_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5s22`.`order` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Brunch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Brunch` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Brunch` (
  `menuType` INT NOT NULL,
  `SetPrice` INT NULL,
  PRIMARY KEY (`menuType`),
  CONSTRAINT `brunch_fk_menuType`
    FOREIGN KEY (`menuType`)
    REFERENCES `cecs323sec5s22`.`Menu` (`menuType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Employee` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Employee` (
  `EID` INT NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `payMethod` VARCHAR(4) NULL,
  PRIMARY KEY (`EID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`shift`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`shift` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`shift` (
  `SID` INT NOT NULL,
  `timeShift` DATETIME NULL,
  PRIMARY KEY (`SID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`WaitStaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`WaitStaff` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`WaitStaff` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `hours` INT NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `waitstaff_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `waitstaff_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Table` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Table` (
  `EID` INT NULL,
  `TableNumber` INT NOT NULL,
  PRIMARY KEY (`TableNumber`),
  CONSTRAINT `table_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`WaitStaff` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`InPerson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`InPerson` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`InPerson` (
  `OID` INT NOT NULL,
  `partySize` INT NULL,
  `tableNumber` INT NULL,
  PRIMARY KEY (`OID`),
  CONSTRAINT `inperson_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5s22`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inperson_fk_tableNumber`
    FOREIGN KEY (`tableNumber`)
    REFERENCES `cecs323sec5s22`.`Table` (`TableNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Manager` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Manager` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `salaryAmount` INT NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `manager_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `manager_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Dishwasher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Dishwasher` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Dishwasher` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `hours` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `dishwasher_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dishwasher_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`MaitreD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`MaitreD` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`MaitreD` (
  `SID` INT NOT NULL,
  `EID` INT NOT NULL,
  `hours` INT NULL,
  PRIMARY KEY (`SID`, `EID`),
  CONSTRAINT `maitreD_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `maitreD_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`LineCook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`LineCook` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`LineCook` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `linecook_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `linecook_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`SousChef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`SousChef` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`SousChef` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `souschef_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `souschef_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`HeadChef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`HeadChef` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`HeadChef` (
  `SID` INT NOT NULL,
  `EID` INT NOT NULL,
  PRIMARY KEY (`SID`, `EID`),
  CONSTRAINT `headchef_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `headchef_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5s22`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Recipe` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Recipe` (
  `EID` INT NOT NULL,
  `RecipeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EID`, `RecipeName`),
  CONSTRAINT `recipe_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`HeadChef` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Department` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Department` (
  `EID` INT NOT NULL,
  `departmentID` INT NOT NULL,
  `dName` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `departmentID`),
  CONSTRAINT `deparment_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`LineCook` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`skills` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`skills` (
  `EID` INT NULL,
  `skillName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`skillName`),
  CONSTRAINT `skills_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Mentorship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Mentorship` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Mentorship` (
  `EID` INT NOT NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `skillName` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`),
  CONSTRAINT `mentorship_skillName_fk`
    FOREIGN KEY (`skillName`)
    REFERENCES `cecs323sec5s22`.`skills` (`skillName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menotorship1_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5s22`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Web`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Web` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Web` (
  `OID` INT NOT NULL,
  `ip` INT NULL,
  PRIMARY KEY (`OID`),
  CONSTRAINT `web_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5s22`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5s22`.`Phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5s22`.`Phone` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5s22`.`Phone` (
  `OID` INT NOT NULL,
  `phone` INT NULL,
  PRIMARY KEY (`OID`),
  CONSTRAINT `phone_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5s22`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
