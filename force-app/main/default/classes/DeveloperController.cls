public with sharing class DeveloperController {
    @AuraEnabled(cacheable=true)
    public static List<Developer__c> getAllDevelopers() {

        DeveloperDomain.validateDeveloperAcessibility();

        return DeveloperService.getAllDevelopers();
    }

    @AuraEnabled(cacheable=true)
    public static Developer__c getDeveloperById(Id developerId) {

        DeveloperDomain.validateDeveloperAcessibility();

        return DeveloperService.getDeveloperById(developerId);
    }

    @AuraEnabled
    public static void createDeveloper(String name, Id addressId) {

        DeveloperDomain.validateDeveloperCreateability();

        DeveloperService.createDeveloper(name, addressId);
    }

    @AuraEnabled
    public static void updateDeveloper(Developer__c developer) {

        DeveloperDomain.validateDeveloperUpdateability();

        DeveloperService.updateDeveloper(developer);
    }   
}