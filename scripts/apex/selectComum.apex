Log__c log1 = new Log__c(
    message__c = 'teste1 erro', 
    Error__c = 'teste1 trace'
);

insert log1;

List<Log__c> logs = [SELECT Error__c FROM Log__c LIMIT 100];

for (Log__c log : logs) {
    System.debug('Log: ' + log.Error__c  );
}