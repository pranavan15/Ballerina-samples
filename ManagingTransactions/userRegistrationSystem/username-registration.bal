package userRegistrationSystem;

import ballerina.config;
import ballerina.data.sql;
import ballerina.log;
import userRegistrationSystem.dbUtil;


// struct user, which contains basic details of a user
struct user {
    string username;
    string password;
    int age;
    string country;
}

// Get the SQL client connector
sql:ClientConnector sqlConnector = dbUtil:getDatabaseClientConnector();

// Execute the initialization function
boolean init = initializeDB();

// Function to add users to 'USERINFO' table of 'userDB' database
public function registerUsers (user[] users) (int) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    int numOfUsers = lengthof users;
    int i;
    int updatedRows;
    while (i < numOfUsers) {
        sql:Parameter parameter1 = {sqlType:sql:Type.VARCHAR, value:users[i].username};
        sql:Parameter parameter2 = {sqlType:sql:Type.VARCHAR, value:users[i].password};
        sql:Parameter parameter3 = {sqlType:sql:Type.INTEGER, value:users[i].age};
        sql:Parameter parameter4 = {sqlType:sql:Type.VARCHAR, value:users[i].country};
        sql:Parameter[] parameters = [parameter1, parameter2, parameter3, parameter4];
        // Insert query
        updatedRows = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", parameters);
        // If no rows updated break and return
        if (updatedRows == 0) {
            break;
        }
        i = i + 1;
    }
    return updatedRows;
}

// Function to get the registered users from the 'USERINFO' table
public function getAllRegisteredUsers () (string, TypeConversionError) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    // Select query
    datatable dt = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
    // Convert datatable to JSON
    var dtJson, conversionError = <json>dt;
    return dtJson.toString(), conversionError;
}

function initializeDB () (boolean) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    string dbName = config:getGlobalValue("DB_NAME");
    int updateStatus1 = dbUtil:createDatabase(sqlConnector, dbName);
    log:printInfo("---------------------------------- Initialization ----------------------------------");
    log:printInfo("Creating database '" + dbName + "' if not exists - Status: " + updateStatus1);
    int updateStatus2 = userDB.update("USE " + dbName, null);
    log:printInfo("Selecting database " + dbName + " - status: " + updateStatus2);
    // Create USERINFO table
    int updateStatus3 = userDB.update("DROP TABLE IF EXISTS USERINFO", null);
    log:printInfo("Dropping table 'USERINFO' if exists - Status: " + updateStatus3);
    int updateStatus4 = userDB.update("CREATE TABLE USERINFO(USERNAME VARCHAR(10), PASSWORD VARCHAR(20),
                                AGE INT, COUNTRY VARCHAR(255), PRIMARY KEY (USERNAME))", null);
    log:printInfo("Creating table 'USERINFO' - Status: " + updateStatus4 + "\n");
    return true;
}