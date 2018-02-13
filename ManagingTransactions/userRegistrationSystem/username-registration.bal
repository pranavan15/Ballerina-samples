package userRegistrationSystem;

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
    int updateStatus;
    while (i < numOfUsers) {
        sql:Parameter parameter1 = {sqlType:sql:Type.VARCHAR, value:users[i].username};
        sql:Parameter parameter2 = {sqlType:sql:Type.VARCHAR, value:users[i].password};
        sql:Parameter parameter3 = {sqlType:sql:Type.INTEGER, value:users[i].age};
        sql:Parameter parameter4 = {sqlType:sql:Type.VARCHAR, value:users[i].country};
        sql:Parameter[] parameters = [parameter1, parameter2, parameter3, parameter4];
        // Insert query
        updateStatus = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", parameters);
        // If no rows updated break and return
        if (updateStatus == 0) {
            break;
        }
        i = i + 1;
    }
    return updateStatus;
}

// Function to get the registered users from the 'USERINFO' table
public function getAllRegisteredUsers () (string, TypeConversionError) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    // Select query
    table dt = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
    // Convert datatable to JSON
    var dtJson, conversionError = <json>dt;
    return dtJson.toString(), conversionError;
}

function initializeDB () (boolean) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    // TODO: Uncomment reading config file logic and delete hardcoded value
    // TODO: Currently the problem is Testerina is not reading values from config file - So cannot write test cases
    //string dbName = config:getGlobalValue("DB_NAME");
    string dbName = "userDB";

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

    if (updateStatus1 != 1 && updateStatus2 != 0 && updateStatus3 != 0 && updateStatus4 != 0) {
        return false;
    }
    return true;
}