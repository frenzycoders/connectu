abstract class ContactService {
  Future<bool> requestContactPermission();
  Future fetchContacts();
  Future fetchSingleContact(id);
  listenContactDb(Function cb);
}
