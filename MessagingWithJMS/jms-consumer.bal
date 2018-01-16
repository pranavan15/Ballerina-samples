import ballerina.net.jms;
import ballerina.log;

@Description {value:"Service level annotation to provide connection details.
                      Connection factory type can be either queue or topic depending on the requirement. "}

@jms:configuration {
    initialContextFactory:"wso2mbInitialContextFactory",
    providerUrl:
    "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5675'",
    connectionFactoryName:"QueueConnectionFactory",
    concurrentConsumers:300,
    destination:"MyQueue"
}
service<jms> remoteTimer {
    boolean timerRunning = false;
    Time startTime;
    Time endTime;
    int startHour;
    int startMin;
    int startSec;
    int startMilliSec;
    int endHour;
    int endMin;
    int endSec;
    int endMilliSec;

    resource onMessage (jms:JMSMessage m) {
        // Retrieve the string payload using native function.
        string stringPayload = m.getTextMessageContent();

        log:printInfo("Message from Producer: " + stringPayload);

        if (stringPayload.equalsIgnoreCase("Start Timer")) {
            startTime = currentTime();
            startHour, startMin, startSec, startMilliSec = startTime.getTime();
            log:printInfo("(Re)Starting Timer at (hour:min:sec:milli)- "
                          + startHour + ":" + startMin + ":" + startSec + ":" + startMilliSec);
            timerRunning = true;
        }

        if (stringPayload.equalsIgnoreCase("Stop Timer")) {
            if (timerRunning == true) {
                endTime = currentTime();
                endHour, endMin, endSec, endMilliSec = endTime.getTime();
                log:printInfo("Stopping Timer at (hour:min:sec:milli)- "
                              + endHour + ":" + endMin + ":" + endSec + ":" + endMilliSec);
                Time duration = endTime.subtractDuration(0, 0, 0, startHour, startMin, startSec, startMilliSec);
                var hour, min, sec, milliSec = duration.getTime();
                log:printInfo("Duration (hour:min:sec:milli)- " + hour + ":" + min + ":" + sec + ":" +
                              milliSec);
                timerRunning = false;
            }
            else {
                log:printWarn("Timer is not running - Command not possible");
            }
        }
    }
}