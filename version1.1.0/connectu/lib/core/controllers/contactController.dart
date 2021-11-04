import 'dart:convert';

import 'package:connectu/core/controllers/hiveController.dart';
import 'package:connectu/core/models/hiveContact.dart';
import 'package:connectu/core/models/userContact.dart';
import 'package:connectu/core/service/contactService.dart';
import 'package:connectu/core/service/contactServiceImpl.dart';
import 'package:connectu/core/controllers/RTCcontroller.dart';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  late ContactService _contactService;
  late RTCcontroller _rtCcontroller;
  late UserController _userContact;
  late HiveController _hiveController;
  // ignore: deprecated_member_use
  RxList contacts = [].obs;
  RxBool isLoadig = false.obs;

  ContactController() {
    _contactService = Get.find<ContactServiceImpl>();
    _rtCcontroller = Get.find<RTCcontroller>();
    _userContact = Get.find<UserController>();
    _hiveController = Get.find<HiveController>();
    _contactService.requestContactPermission();
    fetchContacts();
    _contactService.listenContactDb(listenContactUpdate);
    _rtCcontroller.catchFiltredContact(catchFiltredContac);
  }

  fetchContacts() async {
    contacts.value = [];
    isLoadig.value = true;
    if (_userContact.token != null) {
      List<HiveContcats> con =
          await _hiveController.fetchContacts() as List<HiveContcats>;
      if (con.length > 0) {
        contacts.value = sortArray(con);
      } else {
        List<Contact> ContactsList = await _contactService.fetchContacts();
        _rtCcontroller.filtredContact(ContactsList);
      }
    }
    isLoadig.value = false;
  }

  listenContactUpdate() async {
    await _hiveController.deleteAllContacts();
    fetchContacts();
  }

  catchFiltredContac(data) async {
    List<HiveContcats> list = [];
    data['contacts'].forEach((e) {
      UserContact userContact = UserContact.fromJson(e);
      list.add(HiveContcats(
        contactId: userContact.contactId,
        id: userContact.id == null ? '' : userContact.id,
        number: userContact.number,
        connected: userContact.isConnected,
        // ignore: unnecessary_null_comparison
        displayName: userContact.name == null ? '' : userContact.name,
        name: userContact.serverName == null ? '' : userContact.serverName,
        img: userContact.img == null ? '' : userContact.img,
        status: userContact.status == null ? '' : userContact.status,
      ));
    });

    await _hiveController.addContact(list);
    contacts.value = sortArray(list);
  }

  refreshContacts() async {
    await _hiveController.deleteAllContacts();
    await fetchContacts();
  }

  List<HiveContcats> sortArray(List<HiveContcats> contact) {
    List<HiveContcats> a = [];
    List<HiveContcats> b = [];
    if (contact.length > 0) {
      contact.forEach((element) {
        if (element.connected == true)
          a.add(element);
        else
          b.add(element);
      });
      return a + b;
    } else
      return [];
  }

  Future fetchContactById(id) async {
    try {
      final contact = await _contactService.fetchSingleContact(id);
      return contact;
    } catch (e) {
      throw e;
    }
  }

  updateContactsTable(data) {
    print(data);
  }
}
