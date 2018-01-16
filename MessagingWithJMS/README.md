# Messaging with JMS

This is a use-case example written in Ballerina language (https://ballerinalang.org) that explains
the process of publishing and subscribing to messages using a JMS broker.

# About This Use-case 
This is a sample use-case, which is written using Ballerina language. This demonstrates the usage of 
ballerina language publish and subscribe to topics/messages using a JMS broker. In this example WSO2 MB server has been used as the JMS broker. 
Ballerina JMS Connector is used to connect Ballerina with JMS Message Brokers. With the JMS Connector Ballerina can act as JMS Message Consumers and JMS Message Producers.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) Extract `ballerina-jms-connector-<version>.zip` and copy containing jars in to `<BRE_HOME>/bre/lib/`
5) Copy JMS Broker Client jars into `<BRE_HOME>/bre/lib/`
5) After setting up <ballerina_home>, navigate to the folder containing `{name}.bal` files and run: `$ ballerina run {fileName}.bal` 
