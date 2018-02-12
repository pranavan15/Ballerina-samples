package userRegistrationSystem.dbUtil;

import ballerina.config;
import ballerina.data.sql;

public function getDatabaseClientConnector () (sql:ClientConnector) {
    // DB configurations
    string dbHost = config:getGlobalValue("DB_HOST");
    string dbUsername = config:getGlobalValue("DB_USER_NAME");
    string dbPassword = config:getGlobalValue("DB_PASSWORD");
    var dbPort, conversionError1 = <int>config:getGlobalValue("DB_PORT");
    if (conversionError1 != null) {
        throw conversionError1;
    }
    var dbMaxPoolSize, conversionError2 = <int>config:getGlobalValue("DB_MAX_POOL_SIZE");
    if (conversionError2 != null) {
        throw conversionError2;
    }
    // Construct connection URL
    string connectionUrl = "jdbc:mysql://" + dbHost + ":" + dbPort + "?useSSL=true";

    // Create SQL connector
    sql:ClientConnector sqlConnector = create sql:ClientConnector(sql:DB.GENERIC, "", 0, "", dbUsername, dbPassword,
                                                                  {url:connectionUrl, maximumPoolSize:dbMaxPoolSize});
    return sqlConnector;
}

public function createDatabase (sql:ClientConnector sqlConnector, string dbName) (int) {
    endpoint<sql:ClientConnector> databaseEP {
        sqlConnector;
    }
    int updateStatus = databaseEP.update("CREATE DATABASE IF NOT EXISTS " + dbName, null);
    return updateStatus;
}
