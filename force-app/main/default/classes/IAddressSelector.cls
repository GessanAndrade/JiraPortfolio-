public interface IAddressSelector {
  List<Address__c> getAllAddresses();
  Address__c getAddressById(Id addressId);
}
