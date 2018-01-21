import ballerina.data.sql;
import ballerina.log;

// struct user, which contains basic details of a user
struct user {
    string name;
    string password;
    int age;
    string country;
}

// DB configurations
const string DB_HOST = "localhost";
const string DB_NAME = "userDB?useSSL=false";
const string DB_USER_NAME = "root";
const string DB_PASSWORD = "Mathematics";
const int DB_PORT = 3306;
const int DB_MAX_POOL_SIZE = 5;

// Create SQL connector
sql:ClientConnector sqlConnector = create sql:ClientConnector(sql:DB.MYSQL, DB_HOST, DB_PORT, DB_NAME, DB_USER_NAME,
                                                              DB_PASSWORD, {maximumPoolSize:DB_MAX_POOL_SIZE});

function main (string[] args) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }

    // Create USERINFO table
    _ = userDB.update("DROP TABLE IF EXISTS USERINFO", null);
    _ = userDB.update("CREATE TABLE USERINFO(USERNAME VARCHAR(10), PASSWORD VARCHAR(20),
                                AGE INT, COUNTRY VARCHAR(255), PRIMARY KEY (USERNAME))", null);

    // Transaction 1 - Expected to be successful
    user user1 = {name:"Alice", password:"Alice123", age:20, country:"USA"};
    user user2 = {name:"Bob", password:"bob123", age:21, country:"UK"};
    user[] usersArray1 = [user1, user2];
    transaction with retries(0) {
        addUsers(usersArray1);
        // Expected Results
        log:printInfo("'Alice' and 'Bob' have succesfully registered");
        log:printInfo("Transaction committed");
    } failed {
        log:printError("Transaction failed");
    }
    log:printInfo("Registered users: " + getUsers());
    log:printInfo("Expected Results: You should see 'Alice' and 'Bob'\n");

    // Transaction 2 - Expected to fail
    user user3 = {name:"Charles", password:"Charles123", age:25, country:"India"};
    user user4 = {name:"Alice", password:"AliceNew123", age:32, country:"Sri Lanka"};
    user[] usersArray2 = [user3, user4];
    try {
        transaction with retries(0) {
            addUsers(usersArray2);
            log:printInfo("Transaction committed");
        } failed {
            // Expected Results
            log:printError("Transaction failed");
            println(getUsers());
        }
    } catch (error e) {
        log:printInfo("Above error occurred as expected: username 'Alice' is already taken");
    }
    log:printInfo("Registered users: " + getUsers() + "\n" +
                  "Expected Results: You shouldn't see 'charles'. " +
                  "Attempt to reuse username 'Alice' is a DB constraint violation. " +
                  "Therefore, Charles was rolled back in the same TX\n");

    userDB.close();
}

// Function to add users to USERINFO table of userDB database
function addUsers (user[] users) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    int numOfUsers = lengthof users;
    int i;

    while (i < numOfUsers) {
        sql:Parameter parameter1 = {sqlType:sql:Type.VARCHAR, value:users[i].name};
        sql:Parameter parameter2 = {sqlType:sql:Type.VARCHAR, value:users[i].password};
        sql:Parameter parameter3 = {sqlType:sql:Type.INTEGER, value:users[i].age};
        sql:Parameter parameter4 = {sqlType:sql:Type.VARCHAR, value:users[i].country};
        sql:Parameter[] parameters = [parameter1, parameter2, parameter3, parameter4];
        _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", parameters);
        i = i + 1;
    }
}

// Function to get the registered users from the USERINFO table
function getUsers () (string registeredUsers) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    datatable dt = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
    // Convert datatable to JSON
    var dtJson, _ = <json>dt;
    registeredUsers = dtJson.toString();
    return;
}
