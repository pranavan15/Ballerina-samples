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

    datatable dt = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
    var dtJson, _ = <json>dt;
    println("Initially from DB: " + dtJson.toString());

    _ = userDB.update("DROP TABLE IF EXISTS USERINFO", null);
    _ = userDB.update("CREATE TABLE USERINFO(USERNAME VARCHAR(10), PASSWORD VARCHAR(20),
                                AGE INT, COUNTRY VARCHAR(255), PRIMARY KEY (USERNAME))", null);

    // Adding a new user
    log:printInfo("Adding a new user 'Alice'");
    user newUser1 = {name:"Alice", password:"Alice123", age:20, country:"USA"};
    sql:Parameter paraA1 = {sqlType:sql:Type.VARCHAR, value:newUser1.name};
    sql:Parameter paraA2 = {sqlType:sql:Type.VARCHAR, value:newUser1.password};
    sql:Parameter paraA3 = {sqlType:sql:Type.INTEGER, value:newUser1.age};
    sql:Parameter paraA4 = {sqlType:sql:Type.VARCHAR, value:newUser1.country};
    sql:Parameter[] paramsA = [paraA1, paraA2, paraA3, paraA4];
    _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", paramsA);

    datatable dt2 = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
    var dtJson2, _ = <json>dt2;
    println("After Alice " + dtJson2.toString());
    log:printInfo("-------------------------------------------------------------------");

    log:printInfo("Perform a transaction, which is expected to fail");

    // Transaction (Which is expected to fail)
    user newUser2 = {name:"Bob", password:"bob123", age:27, country:"SL"};
    user newUser3 = {name:"IAmNewUserAlice", password:"abc123", age:25, country:"SL"};

    try {
        transaction with retries(0) {
            sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:newUser2.name};
            sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:newUser2.password};
            sql:Parameter para3 = {sqlType:sql:Type.INTEGER, value:newUser2.age};
            sql:Parameter para4 = {sqlType:sql:Type.VARCHAR, value:newUser2.country};
            sql:Parameter[] params = [para1, para2, para3, para4];
            _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", params);

            sql:Parameter para21 = {sqlType:sql:Type.VARCHAR, value:newUser3.name};
            sql:Parameter para22 = {sqlType:sql:Type.VARCHAR, value:newUser3.password};
            sql:Parameter para23 = {sqlType:sql:Type.INTEGER, value:newUser3.age};
            sql:Parameter para24 = {sqlType:sql:Type.VARCHAR, value:newUser3.country};
            sql:Parameter[] params2 = [para21, para22, para23, para24];
            _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", params2);

            log:printInfo("Transaction committed");
        } failed {
            log:printWarn("Transaction failed");
        }
    } catch (error e) {
        datatable dt3 = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
        var dtJson3, _ = <json>dt3;
        println("Registered users: " + dtJson3.toString());
        log:printInfo("Expected Results: You should not see 'Bob' and 'IAmNewUserAlice'");
        log:printInfo("-------------------------------------------------------------------");
    } finally {
        userDB.close();
    }

    // Adding a new user 'Charles' after a failing transaction

    secondConnector();
    log:printInfo("Close the database connection");
    log:printInfo("-------------------------------------------------------------------");
    log:printInfo("Now perform a select query using mysql to see 'charles' is correctly added or not");
    log:printInfo("i.e: 'SELECT USERNAME FROM USERINFO'");
    log:printError("'Charles' cannot be found in the USERINFO table of userDB after closing the connection");
}

//function addUsers (user newUser) {
//    endpoint<sql:ClientConnector> userDB {
//        sqlConnector;
//    }
//    sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:newUser.name};
//    sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:newUser.password};
//    sql:Parameter para3 = {sqlType:sql:Type.INTEGER, value:newUser.age};
//    sql:Parameter para4 = {sqlType:sql:Type.VARCHAR, value:newUser.country};
//    sql:Parameter[] params = [para1, para2, para3, para4];
//    _ = userDB.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", params);
//}

//function getUsers () (string registeredUsers) {
//    endpoint<sql:ClientConnector> userDB {
//        sqlConnector;
//    }
//    datatable dt = userDB.select("SELECT USERNAME FROM USERINFO", null, null);
//    var dtJson, _ = <json>dt;
//    registeredUsers = dtJson.toString();
//    return;
//}

function secondConnector () {
    endpoint<sql:ClientConnector> userDBConn2 {
        create sql:ClientConnector(sql:DB.MYSQL, DB_HOST, DB_PORT, DB_NAME, DB_USER_NAME, DB_PASSWORD,
                                   {maximumPoolSize:DB_MAX_POOL_SIZE});
    }
    try {
        log:printInfo("Adding a new user 'Charles' after a failing transaction");
        user newUser4 = {name:"Charles", password:"charles123", age:21, country:"SL"};
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:newUser4.name};
        sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:newUser4.password};
        sql:Parameter para3 = {sqlType:sql:Type.INTEGER, value:newUser4.age};
        sql:Parameter para4 = {sqlType:sql:Type.VARCHAR, value:newUser4.country};
        sql:Parameter[] params = [para1, para2, para3, para4];
        _ = userDBConn2.update("INSERT INTO USERINFO VALUES (?, ?, ?, ?)", params);

        datatable dt = userDBConn2.select("SELECT USERNAME FROM USERINFO", null, null);
        var dtJson, _ = <json>dt;
        println(dtJson);

    } catch (error e) {

    } finally {
        userDBConn2.close();
    }
}