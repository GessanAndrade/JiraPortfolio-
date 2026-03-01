public with sharing class DeveloperSelector {

    public static List<Developer__c> getAllDevelopers() {
        return [SELECT Id, Name__c FROM Developer__c LIMIT 100];
    }

    public static Developer__c getDeveloperById(Id developerId) {
        return [SELECT Id, Name__c, Age__c, Level__c, Role__c, Bio__c, Birth__c, Start_Job__c, Task_On__c, Address__c FROM Developer__c WHERE Id = :developerId LIMIT 1];
    }

}