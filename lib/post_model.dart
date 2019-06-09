import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}
String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
class Post {
  String patient_id;
  String spimo_id;
  String pedal_id;
  String device_id;


  Post({
    this.patient_id,
    this.spimo_id,
    this.pedal_id,
    this.device_id,
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    patient_id: json["patient_id"],
    spimo_id: json["device_id"],
    pedal_id: json["pedal_id"],
  );
  Map<String, dynamic> toJson() => {
    "patient_id": patient_id,
    "spimo_id": spimo_id,
    "pedal_id": pedal_id,
  };
}

Future<String> getData(String patient_id,String device_id,String secondURL) async{
      final response = await http.get('$baseurl/$secondURL?patient_id=$patient_id&device_id=$device_id');
//      return postFromJson(response.body);
        print(response.body);
        return response.body;
}

Future<http.Response> createPost(Post post,String url) async{
  final response = await http.post('$url',
      headers:{
        HttpHeaders.contentTypeHeader:' application/json'
      },
      body: postToJson(post)
  );
  return response;
  //return postFromJson(response.body);
}


String baseurl = "http://spimo.azurewebsites.net/";
String post_res = '';

String postData(String patient_id, String spimo_id,String pedal_id, String secondUrl){
  Post post = Post(
    patient_id: patient_id,
    spimo_id: spimo_id,
    pedal_id: pedal_id,
  );
  createPost(post, baseurl+secondUrl).then((response) {
    post_res = response.body;
//    print(post_res);
  }).catchError((error) {
    print('error : $error');
  });
  return post_res;
}


String startCount(String patient_id,String device_id,String secondUrl){
//  if (device_type == "Spimo"){
    Post post = Post(
      patient_id: patient_id,
      device_id: device_id
    );
//  }else if(device_type=="Pedal"){
    createPost(post,baseurl+ secondUrl).then((response){
      post_res = response.body;
    }).catchError((error){
      print("error: $error");
  });
    return post_res;
//  }
}