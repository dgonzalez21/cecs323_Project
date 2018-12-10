//Generate customer insert 
// CID 1-50 and mimiDollar is a random number 1-500
for(var i = 0;i<50 ;i++ ){
    var randomMimiDollar = Math.random() * (500-1) + 1 ;
    randomMimiDollar = Math.floor(randomMimiDollar)
    console.log("INSERT INTO `mydb`.`Customer` (`CID`, `mimingDollars`) VALUES (" + i + ", " +  randomMimiDollar+ ");")
    
}

//Generate Private Customer's data
//First half of customers
for(var i = 0; i<25; i++){
  //  INSERT INTO `mydb`.`PrivateCust` (`cName`, `email`, `mailingAddress`, `CID`) VALUES (NULL, NULL, NULL, NULL);

  console.log(faker.fake("INSERT INTO `mydb`.`PrivateCust` (`cName`, `email`, `mailingAddress`, `CID`) VALUES ({{name.findName}}, {{internet.email}}, {{address.streetAddress}}, " + i +");" ));
}

//Generate Coprate Customer's data
//Second half of customers
for(var i = 25; i<50; i++){
  //  INSERT INTO `mydb`.`corporation` (`corpName`, `orgName`, `address`, `contact`, `CID`) VALUES (NULL, NULL, NULL, NULL, NULL);

var beg = "INSERT INTO `mydb`.`corporation` (`corpName`, `orgName`, `address`, `contact`, `CID`) ";
    
 var end = faker.fake( "VALUES({{company.companyName}}, {{company.bs}}, {{address.streetAddress}}, {{name.findName}},"+ i + " );" );
console.log(beg+end)
}

