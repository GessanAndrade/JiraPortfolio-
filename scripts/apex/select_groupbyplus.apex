// 1. Buscar todos os developers
List<Developer__c> developers = [
    SELECT Id, Name__c, Task_On__c
    FROM Developer__c
];

// 2. Buscar quantidade de Doing por developer
Map<Id, Integer> doingMap = new Map<Id, Integer>();

for (AggregateResult ar : [
    SELECT Developer__c, COUNT(Id) total
    FROM Task__c
    WHERE Status__c = 'Doing'
    GROUP BY Developer__c
]) {
    doingMap.put(
        (Id) ar.get('Developer__c'),
        (Integer) ar.get('total')
    );
}

// 3. Exibir todos
for (Developer__c dev : developers) {
    Integer total = doingMap.containsKey(dev.Id) ? doingMap.get(dev.Id) : 0;

    System.debug('Antes Developer: ' + dev.Name__c + ' - Tasks On: ' + dev.Task_On__c);

    dev.Task_On__c = total;
    
    update dev;

    System.debug('Depois Developer: ' + dev.Name__c + ' - Tasks On: ' + dev.Task_On__c);
}
