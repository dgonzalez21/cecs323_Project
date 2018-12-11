-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cecs323sec5og7
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cecs323sec5og7
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cecs323sec5og7` DEFAULT CHARACTER SET utf8 ;
USE `cecs323sec5og7` ;

-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Customer` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Customer` (
  `CID` INT NOT NULL,
  `mimingDollars` INT NULL,
  PRIMARY KEY (`CID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`PrivateCust`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`PrivateCust` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`PrivateCust` (
  `cName` VARCHAR(40) NOT NULL,
  `email` VARCHAR(45) NULL,
  `mailingAddress` VARCHAR(45) NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`CID`, `cName`),
  CONSTRAINT `privatecust_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`corporation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`corporation` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`corporation` (
  `corpName` VARCHAR(45) NOT NULL,
  `orgName` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`corpName`, `CID`),
  CONSTRAINT `corp_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`order` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`order` (
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  `payMethod` VARCHAR(45) NULL,
  `orderDate` DATETIME NULL,
  PRIMARY KEY (`OID`, `CID`),
  CONSTRAINT `order_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`Customer` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`togo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`togo` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`togo` (
  `orderStart` DATETIME NOT NULL,
  `orderFinish` VARCHAR(45) NULL,
  `pickUpTime` VARCHAR(45) NULL,
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`OID`, `CID`, `orderStart`),

  CONSTRAINT `togo_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `togo_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`order` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`togoTime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`togoTime` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`togoTime` (
  `OID` INT NOT NULL,
  `orderStart` DATETIME NOT NULL,
  `orderFinish` DATETIME NULL,
  `CID` INT NOT NULL,
  PRIMARY KEY (`OID`, `orderStart`, `CID`),
  CONSTRAINT `togotime_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`togo` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `togotime_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`togo` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`menuItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`menuItem` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`menuItem` (
  `name` VARCHAR(45) NOT NULL,
  `spicyness` VARCHAR(45) NULL,
  `catagorey` VARCHAR(45) NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Menu` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Menu` (
  `menuType` INT NOT NULL,
  PRIMARY KEY (`menuType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`ItemOnMenu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`ItemOnMenu` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`ItemOnMenu` (
  `MenuItemID` INT NOT NULL,
  `menuType` INT NULL,
  `price` INT NULL,
  `size` VARCHAR(1) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemID`),
 
  CONSTRAINT `itemonmenu_fk_name`
    FOREIGN KEY (`name`)
    REFERENCES `cecs323sec5og7`.`menuItem` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `itemonmenu_fk_menuType`
    FOREIGN KEY (`menuType`)
    REFERENCES `cecs323sec5og7`.`Menu` (`menuType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`orderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`orderItem` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`orderItem` (
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`OID`, `CID`, `MenuItemID`),
  CONSTRAINT `orderitem_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitem_fk_MenuItemID`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `cecs323sec5og7`.`ItemOnMenu` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitem_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`order` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Brunch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Brunch` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Brunch` (
  `menuType` INT NOT NULL,
  `SetPrice` INT NULL,
  PRIMARY KEY (`menuType`),
  CONSTRAINT `brunch_fk_menuType`
    FOREIGN KEY (`menuType`)
    REFERENCES `cecs323sec5og7`.`Menu` (`menuType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Employee` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Employee` (
  `EID` INT NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `payMethod` VARCHAR(4) NULL,
  PRIMARY KEY (`EID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`shift`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`shift` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`shift` (
  `SID` INT NOT NULL,
  `timeShift` VARCHAR(2) NULL,
  PRIMARY KEY (`SID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`WaitStaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`WaitStaff` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`WaitStaff` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `hours` INT NULL,
  `tipAmount` INT NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `waitstaff_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `waitstaff_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Table` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Table` (
  `EID` INT NULL,
  `TableNumber` INT NOT NULL,
  PRIMARY KEY (`TableNumber`),
  CONSTRAINT `table_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`WaitStaff` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`InPerson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`InPerson` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`InPerson` (
  `OID` INT NOT NULL,
  `partySize` INT NULL,
  `tableNumber` INT NULL,
  PRIMARY KEY (`OID`),
  CONSTRAINT `inperson_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`order` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inperson_fk_tableNumber`
    FOREIGN KEY (`tableNumber`)
    REFERENCES `cecs323sec5og7`.`Table` (`TableNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Manager` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Manager` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `salaryAmount` INT NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `manager_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `manager_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Dishwasher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Dishwasher` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Dishwasher` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `hours` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `dishwasher_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dishwasher_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`MaitreD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`MaitreD` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`MaitreD` (
  `SID` INT NOT NULL,
  `EID` INT NOT NULL,
  `hours` INT NULL,
  PRIMARY KEY (`SID`, `EID`),
  CONSTRAINT `maitreD_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `maitreD_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`LineCook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`LineCook` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`LineCook` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `salaryAmount` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `linecook_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `linecook_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`SousChef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`SousChef` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`SousChef` (
  `EID` INT NOT NULL,
  `SID` INT NOT NULL,
  `salaryAmount` VARCHAR(45) NULL,
  PRIMARY KEY (`EID`, `SID`),
  CONSTRAINT `souschef_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `souschef_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`HeadChef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`HeadChef` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`HeadChef` (
  `SID` INT NOT NULL,
  `EID` INT NOT NULL,
  `salaryAmount` INT NULL,
  `recipeNum` INT NOT NULL,
  PRIMARY KEY (`SID`, `EID`, `recipeNum`),
  CONSTRAINT `headchef_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`Employee` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `headchef_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`shift` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Recipe` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Recipe` (
  `EID` INT NOT NULL,
  `RecipeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EID`, `RecipeName`),
  CONSTRAINT `recipe_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`HeadChef` (`SID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Department` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Department` (
  `departmentID` INT NOT NULL,
  `dName` VARCHAR(45) NULL,
  PRIMARY KEY (`departmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`skills` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`skills` (
  `EID` INT NULL,
  `skillName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`skillName`),
  CONSTRAINT `skills_fk_EID`
    FOREIGN KEY (`EID`)
    REFERENCES `cecs323sec5og7`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `skills_fk_skillName`
    FOREIGN KEY (`skillName`)
    REFERENCES `cecs323sec5og7`.`menuItem` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Mentorship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Mentorship` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Mentorship` (
  `TeacherID` INT NOT NULL,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NULL,
  `skillName` VARCHAR(45) NULL,
  `LearnerID` INT NOT NULL,
  PRIMARY KEY (`TeacherID`, `LearnerID`, `startDate`),
  INDEX `skillName_idx` (`skillName` ASC) VISIBLE,
  INDEX `mentorship2_fk_EId_idx` (`LearnerID` ASC) VISIBLE,
  CONSTRAINT `mentorship_skillName_fk`
    FOREIGN KEY (`skillName`)
    REFERENCES `cecs323sec5og7`.`skills` (`skillName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menotorship1_fk_EID`
    FOREIGN KEY (`TeacherID`)
    REFERENCES `cecs323sec5og7`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mentorship2_fk_EId`
    FOREIGN KEY (`LearnerID`)
    REFERENCES `cecs323sec5og7`.`SousChef` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Web`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Web` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Web` (
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  `ipAddress` VARCHAR(20) NULL,
  PRIMARY KEY (`OID`, `CID`),
  CONSTRAINT `web_fk_oid`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`togo` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `web_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`togo` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`Phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`Phone` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`Phone` (
  `OID` INT NOT NULL,
  `CID` INT NOT NULL,
  `phoneNumber` INT NULL,
  PRIMARY KEY (`OID`, `CID`),
  CONSTRAINT `phone_fk_oid`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`togo` (`OID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `phone_fk_CID`
    FOREIGN KEY (`CID`)
    REFERENCES `cecs323sec5og7`.`togo` (`CID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cecs323sec5og7`.`CooksInDepartment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cecs323sec5og7`.`CooksInDepartment` ;

CREATE TABLE IF NOT EXISTS `cecs323sec5og7`.`CooksInDepartment` (
  `OID` INT NOT NULL,
  `SID` INT NOT NULL,
  `departmentID` INT NOT NULL,
  PRIMARY KEY (`OID`, `SID`, `departmentID`),
  CONSTRAINT `cookdepartment_fk_OID`
    FOREIGN KEY (`OID`)
    REFERENCES `cecs323sec5og7`.`LineCook` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cookdepartment_fk_SID`
    FOREIGN KEY (`SID`)
    REFERENCES `cecs323sec5og7`.`LineCook` (`EID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cookdepartment_fk_DepID`
    FOREIGN KEY (`departmentID`)
    REFERENCES `cecs323sec5og7`.`Department` (`departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
