public with sharing class SprintSelector {
    
    public static List<Sprint__c> getAllSprints() {
        
        List<Sprint__c> sprints = [SELECT Id, Date_Begin__c, Date_End__c FROM Sprint__c];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                sprints
            );

        return (List<Sprint__c>)decision.getRecords();
    }

    public static List<Sprint__c> getActiveSprints() {
       
        List<Sprint__c> sprints = [SELECT Id, Date_Begin__c, Date_End__c FROM Sprint__c WHERE Status__c = 'Active' LIMIT 1];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                sprints
            );

        return (List<Sprint__c>)decision.getRecords();
    }

    public static Sprint__c getSprintById(Id sprintId){
       
        List<Sprint__c> sprints = [
            SELECT Id, Date_Begin__c, Date_End__c
            FROM Sprint__c
            WHERE Id = :sprintId
            LIMIT 1
        ];
        if (sprints.isEmpty()) {
            return null;
        }

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                sprints
            );
        List<Sprint__c> sanitized = (List<Sprint__c>)decision.getRecords();
        return sanitized.isEmpty() ? null : sanitized[0];
    }

}