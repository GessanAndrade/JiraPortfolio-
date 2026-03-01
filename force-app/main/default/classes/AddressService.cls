public with sharing class AddressService {

    public static List<Address__c> getAllAddresses() {
        try {
            return AddressSelector.getAllAddresses();
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load addresses.');
        }
    }

    public static Address__c getAddressById(Id addressId) {
        if (addressId == null) {
            throw new AuraHandledException('AddressId cannot be null.');
        }

        try {
            Address__c address = AddressSelector.getAddressById(addressId);
            if (address == null) {
                throw new AuraHandledException('Address not found.');
            }
            return address;
        } catch (AuraHandledException e) {
            throw e;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load address.');
        }
    }

    public static void createAddress(String city, String cep) {
        if (String.isBlank(city)) {
            throw new AuraHandledException('City is required.');
        }

        if (String.isBlank(cep)) {
            throw new AuraHandledException('CEP is required.');
        }

        Address__c address = new Address__c(City__c = city.trim(), CEP__c = cep.trim());

        try {
            insert address;
        } catch (DmlException e) {
            throw new AuraHandledException('Unable to create address.');
        }
    }
}