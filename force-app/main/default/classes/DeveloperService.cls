public with sharing class DeveloperService {
    
    public static List<Developer__c> getAllDevelopers() {
        try {
            return DeveloperSelector.getAllDevelopers();
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load developers.');
        }
    }

    public static Developer__c getDeveloperById(Id developerId) {
        if (developerId == null) {
            throw new AuraHandledException('DeveloperId cannot be null.');
        }

        try {
            Developer__c developer = DeveloperSelector.getDeveloperById(developerId);
            if (developer == null) {
                throw new AuraHandledException('Developer not found.');
            }
            return developer;
        } catch (AuraHandledException e) {
            throw e;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load developer.');
        }
    }

    public static void createDeveloper(String name, Id addressId) {
        if (String.isBlank(name)) {
            throw new AuraHandledException('Developer name is required.');
        }

        if (addressId == null) {
            throw new AuraHandledException('AddressId is required.');
        }

        Developer__c developer = new Developer__c(
            Name__c = name.trim(),
            Address__c = addressId
        );

        try {
            insert developer;
        } catch (DmlException e) {
            throw new AuraHandledException('Unable to create developer.');
        }
    }

    public static void updateDeveloper(Developer__c developer) {
        if (developer == null || developer.Id == null) {
            throw new AuraHandledException('Valid developer is required.');
        }

        try {
            update developer;
        } catch (DmlException e) {
            throw new AuraHandledException('Unable to update developer.');
        }
    }   
}