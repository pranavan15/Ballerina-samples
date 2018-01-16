import ballerina.net.jms;
import ballerina.math;

function main (string[] args) {
    messageGenerator();
}

function messageGenerator () {
    endpoint<jms:JmsClient> jmsEP {
        create jms:JmsClient(getConnectorConfig());
    }
    // Create an empty Ballerina message.
    jms:JMSMessage queueMessage = jms:createTextMessage(getConnectorConfig());
    // Set a string payload to the message.
    queueMessage.setTextMessageContent("Hello!");
    // Send the Ballerina message to the JMS provider.
    jmsEP.send("MyQueue", queueMessage);
    int command = 1;

    while (true) {
        int delay = math:randomInRange(50, 100) * 100;
        sleep(delay);
        if (command == 1) {
            queueMessage.setTextMessageContent("Start Timer");
            jmsEP.send("MyQueue", queueMessage);
        }
        else {
            queueMessage.setTextMessageContent("Stop Timer");
            jmsEP.send("MyQueue", queueMessage);
        }
        command = math:randomInRange(1, 3);
    }
}

function getConnectorConfig () (jms:ClientProperties) {
    // We define the connection properties as a map. 'providerUrl' or 'configFilePath' and the 'initialContextFactory' vary according to the JMS provider you use.
    // In this example we connect to the WSO2 MB server.
    jms:ClientProperties properties = {initialContextFactory:"wso2mbInitialContextFactory",
                                          configFilePath:"/home/pranavan/IdeaProjects/Ballerina-samples/MessagingWithJMS/resources/jndi.properties",
                                          connectionFactoryName:"QueueConnectionFactory",
                                          connectionFactoryType:"queue"};
    return properties;
}