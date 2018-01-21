import ballerina.data.sql;
import ballerina.log;

struct user {
    string name;
    string password;
    int age;
    string country;
}

const string DB_HOST = "localhost";
const string DB_NAME = "userDB?useSSL=false";
const string DB_USER_NAME = "root";
const string DB_PASSWORD = "Mathematics";
const int DB_PORT = 3306;
const int DB_MAX_POOL_SIZE = 5;

sql:ClientConnector sqlConnector = create sql:ClientConnector(sql:DB.MYSQL, DB_HOST, DB_PORT, DB_NAME, DB_USER_NAME,
                                                              DB_PASSWORD, {maximumPoolSize:DB_MAX_POOL_SIZE});

function main (string[] args) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    _ = userDB.update("DROP TABLE IF EXISTS USERINFO", null);
    _ = userDB.update("CREATE TABLE USERINFO(USERNAME VARCHAR(10), PASSWORD VARCHAR(20),
                                AGE INT, COUNTRY VARCHAR(255), PRIMARY KEY (USERNAME))", null);

    // Transaction 1
    user u1 = {name:"Alice", password:"Alice123", age:20, country:"USA"};
    user u2 = {name:"Bob", password:"bob123", age:21, country:"UK"};
    user[] userArr = [u1, u2];
    transaction with retries(0) {
        addUsers(userArr);
        // Expected Results
        log:printInfo("'Alice' and 'Bob' have succesfully registered");
        log:printInfo("Transaction committed");
    } failed {
        log:printError("Transaction failed");
    }
    log:printInfo("Registered users: " + getUsers());
    log:printInfo("Expected Results: You should see 'Alice' and 'Bob'\n");

    // Transaction 2
    user u3 = {name:"Charles", password:"Charles123", age:25, country:"India"};
    user u4 = {name:"Alice", password:"AliceNew123", age:32, country:"Sri Lanka"};
    user[] userArr2 = [u3, u4];
    try {
        transaction with retries(0) {
            addUsers(userArr2);
            log:printInfo("Transaction committed");
        } failed {
            log:printError("Transaction failed");
            println(getUsers());
        }
    } catch(error e) {
        log:printInfo("Above error occurred as expected: username 'Alice' is already taken");
    }
    log:printInfo("Registered users: " + getUsers() + "\n" +
                  "Expected Results: You shouldn't see 'charles'. " +
                  "Attempt to reuse username 'Alice' is a DB constraint violation. " +
                  "Therefore, Charles was rolled back in the same TX\n");

    // Adding a new user 'abc' after a failing transaction
    sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:"abc"};
    sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:"abc123"};
    sql:Parameter para3 = {sqlType:sql:Type.INTEGER, value:3};
    sql:Parameter para4 = {sqlType:sql:Type.VARCHAR, value:"abc"};
    sql:Parameter[] parameters = [para1, para2, para3, para4];
    _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", parameters);


    //user u5 = {name:"Dias", password:"Dias123", age:24, country:"Sri Lanka"};
    //user u6 = {name:"UserWhoLovesCats", password:"ABC123", age:27, country:"India"};
    //user[] userArr3 = [u5, u6];
    //try {
    //    transaction with retries(0) {
    //        addUsers(userArr3);
    //        log:printInfo("Transaction committed");
    //    } failed {
    //        log:printError("Transaction failed");
    //    }
    //} catch (error e) {
    //    log:printInfo("Above error occurred as expected: username is too big (Atmost 10 characters)");
    //}
    //log:printInfo("Registered users: " + getUsers() + "\n" +
    //              "Expected Results: You shouldn't see 'Dias' and 'UserWhoLovesCats'. " +
    //              "'UserWhoLovesCats' violated DB constraints, and 'Dias' was rolled back in the same TX\n");

    userDB.close();
}

function addUsers (user[] users) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    int numOfUsers = lengthof users;
    int i;

    while (i < numOfUsers) {
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:users[i].name};
        sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:users[i].password};
        sql:Parameter para3 = {sqlType:sql:Type.INTEGER, value:users[i].age};
        sql:Parameter para4 = {sqlType:sql:Type.VARCHAR, value:users[i].country};
        sql:Parameter[] params = [para1, para2, para3, para4];
        _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", params);
        i = i + 1;
    }
}

function getUsers () (string registeredUsers) {
    endpoint<sql:ClientConnector> userDB {
        sqlConnector;
    }
    datatable dt = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
    var dtJson, _ = <json>dt;
    //println(dtJson);
    registeredUsers = dtJson.toString();
    return;
}
