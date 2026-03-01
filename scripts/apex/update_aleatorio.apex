List<String> statusList = new List<String>{ 'Doing', 'Done', 'To Do' };

List<Task__c> tasks = [SELECT Id, Status__c FROM Task__c];

for (Task__c t : tasks) {
    Integer randomIndex = Math.mod(Math.abs(Crypto.getRandomInteger()), statusList.size());
    t.Status__c = statusList[randomIndex];
}

update tasks;

System.debug('Tasks atualizadas com status aleatório.');
