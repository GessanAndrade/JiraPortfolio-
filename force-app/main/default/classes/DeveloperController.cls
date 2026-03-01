public with sharing class DeveloperController {
    @AuraEnabled(cacheable=true)
    public static List<Developer__c> getAllDevelopers() {
        return DeveloperService.getAllDevelopers();
    }

    @AuraEnabled(cacheable=true)
    public static Developer__c getDeveloperById(Id developerId) {
        return DeveloperService.getDeveloperById(developerId);
    }

    @AuraEnabled
    public static void createDeveloper(String name, Id addressId) {
        DeveloperService.createDeveloper(name, addressId);
    }

    @AuraEnabled
    public static void updateDeveloper(Developer__c developer) {
        DeveloperService.updateDeveloper(developer);
    }   
}