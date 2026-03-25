public with sharing class DeveloperSelector {

    public static List<Developer__c> getAllDevelopers() {
        
        List<Developer__c> developers = [SELECT Id, Name__c FROM Developer__c LIMIT 100];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                developers
            );

        return (List<Developer__c>)decision.getRecords();
    }

    public static Developer__c getDeveloperById(Id developerId) {
       
        Developer__c developer = [
            SELECT Id, Name__c, Age__c, Level__c, Role__c, Bio__c, Birth__c, Start_Job__c, Task_On__c, Address__c
            FROM Developer__c
            WHERE Id = :developerId
            LIMIT 1
        ];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                new List<Developer__c>{developer}
            );

        return (Developer__c)decision.getRecords()[0];
    }

}