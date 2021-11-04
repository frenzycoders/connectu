import 'package:flutter_contacts/flutter_contacts.dart';
import 'contactService.dart';

class ContactServiceImpl implements ContactService {
  @override
  Future<bool> requestContactPermission() async {
    bool isPermit = await FlutterContacts.requestPermission();
    if (isPermit)
      return true;
    else
      return false;
  }

  @override
  Future fetchContacts() async {
    final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
        withThumbnail: true,
        sorted: true,
        deduplicateProperties: true);
    return contacts;
  }

  @override
  Future fetchSingleContact(id) async {
    try {
      final contact = await FlutterContacts.getContact(
        id,
        withProperties: true,
        withPhoto: true,
        withThumbnail: true,
        //deduplicateProperties: true,
      );
      return contact;
    } catch (e) {
      throw e;
    }
  }

  
  @override
  listenContactDb(Function cb) {
    FlutterContacts.addListener(() {
      cb();
    });
  }
}
