import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://pbquickinv.happyfir.com'); // Adjust the URL if needed
const guildId = '751662000093921291';

Future<String> getUserRoles(String accessToken, String guildId) async {
  try {
    final response = await http.get(
      Uri.parse('https://discord.com/api/guilds/$guildId/members/@me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> roles = data['roles'];
      print('User roles: $roles'); // Print roles for verification

      if (roles.contains('751662317569179791')) {
        return 'Exec';
      } else if (roles.contains('1044742711162449920')) {
        return 'LabSupervisor';
      } else {
        return 'Guest';
      }
    } else {
      print('Failed to load user roles, status code: ${response.statusCode}');
      print('Response: ${response.body}');
      return 'Error';
    }
  } catch (e) {
    print('Error fetching user roles: $e');
    return 'Error';
  }
}

Future<String> authenticateWithPocketBase() async {
  try {
    final authData = await pb.collection('users').authWithOAuth2('discord', (url) async {
      if (await canLaunch(url.toString())) {
        await launch(url.toString());
      } else {
        throw 'Could not launch $url';
      }
    });

    if (pb.authStore.isValid) {
      print('Authentication successful');
      print('Token: ${pb.authStore.token}'); // these to debug
      print('User ID: ${pb.authStore.model.id}');

      await pb.collection('users').update(pb.authStore.model.id, body: {
        "oauth_token": pb.authStore.token,
      });

      return await getUserRoles(pb.authStore.token, guildId);
    } else {
      print('Authentication failed');
      return 'Error';
    }
  } catch (e) {
    print('Error during authentication: $e');
    return 'Error';
  }
}

void main() async {




  try {
    String result = await authenticateWithPocketBase();
    if (result == 'Exec') {
      print('User is an Exec.');
      // login as exec
    } else if (result == 'LabSupervisor') {
      //login as lab supervisor
      print('User is a Lab Supervisor.');
    } else if (result == 'Guest') {

      print('User is a Guest.');
      //login as guest
    } else {
      print('Error with user role.');
      // it didn't work
    }
  } catch (error) {
    print('Error: $error');
  }
}
