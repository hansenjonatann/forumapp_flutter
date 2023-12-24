import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum_app/constants/constants.dart';
import 'package:forum_app/models/post_models.dart';
import 'package:forum_app/models/comment_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}'
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in json.decode(response.body)['feeds']) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      var data = {
        'content': content,
      };

      var response = await http.post(
        Uri.parse('${url}feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComments(id) async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('${url}feed/comments/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['comments'];
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createComment(id, body) async {
    try {
      isLoading.value = true;
      var data = {
        "body": body,
      };

      var request = await http.post(Uri.parse('${url}feed/comment/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);

      if (request.statusCode == 201) {
        isLoading.value = false;
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deletePost(id) async {
    try {
      var response = await http.delete(Uri.parse('${url}feed/$id'));

      if (response.statusCode == 200) {
        print('Hapus data berhasil');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
