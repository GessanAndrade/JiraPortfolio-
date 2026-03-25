public with sharing class DeveloperDomain {
    
    public static void validateDeveloperFields(Developer__c developer) {
        if(String.isBlank(developer.Name__c)) {
            throw new AuraHandledException('Name is required.');
        }
        if(developer.Address__c == null) {
            throw new AuraHandledException('Address is required.');
        }
    }

    public static void validateDeveloperAcessibility() {
        if(!Schema.sObjectType.Developer__c.isAccessible()) {
            throw new AuraHandledException('You do not have permission to access Developer.');
        }
    }

    public static void validateDeveloperCreateability() {
        if(!Schema.sObjectType.Developer__c.isCreateable()) {
            throw new AuraHandledException('You do not have permission to create Developer.');
        }
    }

    public static void validateDeveloperUpdateability() {
        if(!Schema.sObjectType.Developer__c.isUpdateable()) {
            throw new AuraHandledException('You do not have permission to update Developer.');
        }
    }

    public static void validateDeveloperDeletability() {
        if(!Schema.sObjectType.Developer__c.isDeletable()) {
            throw new AuraHandledException('You do not have permission to delete Developer.');
        }
    }
}