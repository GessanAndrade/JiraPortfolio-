List<Sprint_Task__c> sprintTasks = [
    SELECT Task__c, Id, Sprint_FKN__c
    FROM Sprint_Task__c
    WHERE Sprint_FKN__c IN (
        SELECT Id FROM Sprint__c WHERE Status__c = 'Active'
    )
];

for (Sprint_Task__c task : sprintTasks) {
    System.debug('Sprint Task Id: ' + task.Id);
}