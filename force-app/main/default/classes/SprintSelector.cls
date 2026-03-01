public with sharing class SprintSelector {
    
    public static List<Sprint__c> getAllSprints() {
        return  [SELECT Id, Date_Begin__c, Date_End__c FROM Sprint__c];
    }

    public static List<Sprint__c> getActiveSprints() {
        return [SELECT Id, Date_Begin__c, Date_End__c FROM Sprint__c WHERE Status__c = 'Active' LIMIT 1];
    }

    public static Sprint__c getSprintById(Id sprintId){
       return [SELECT Id, Date_Begin__c, Date_End__c FROM Sprint__c WHERE Id = :sprintId LIMIT 1];
    }

}