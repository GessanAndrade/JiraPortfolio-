List<Address__c> add = [SELECT id FROM Address__c LIMIT 1];

Developer__c localDev = new Developer__c(
                Name__c = 'Developer',
                Age__c = 25,
                Bio__c = 'Bio for Developer ',
                Address__c = add[0].id,
                Birth__c = Date.newInstance(1990, 1, 1).addDays(3 * 365),
                Level__c = 'Junior',
                Role__c = 'Developer',
                Start_Job__c = Date.today().addDays(-3 * 30),
                Task_On__c = 3);

localDev.Name__c = 'Krystyana Andrade';
localDev.Age__c = 28;
localDev.Level__c = 'Senior';            

insert localDev;    

Developer__c seachDev = [SELECT Name__c, Age__c, Bio__c, Birth__c, Level__c, Role__c, Start_Job__c, Task_On__c FROM Developer__c WHERE Name__c = 'Gessan Andrade' LIMIT 1]; 
System.debug('Developer Name: ' + seachDev.Name__c); 