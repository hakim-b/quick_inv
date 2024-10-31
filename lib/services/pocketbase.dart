/*import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  final PocketBase client;

  PocketBaseService(this.client);

  Future<List<dynamic>> fetchItems(String collection) async {
    final response = await client.collection(collection).getList();
    return response.items;
  }

  Future<void> addItem(String collection, Map<String, dynamic> data) async {
    await client.collection(collection).create(data: data);
  }

  Future<void> updateItem(String collection, String itemId, Map<String, dynamic> data) async {
    await client.collection(collection).update(id: itemId, data: data);
  }

  Future<void> deleteItem(String collection, String itemId) async {
    await client.collection(collection).delete(id: itemId);
  }
}*/
