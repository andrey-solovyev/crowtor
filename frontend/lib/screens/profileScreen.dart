import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/model/subscribeModel.dart';
import 'package:crowtor/model/unSubscribeModel.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, this.nickName}) : super(key: key);

  final String nickName;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isSubscribed = false;
  bool _isChanged = false;

  void _changeSub(isSub) {
    setState(() {
      _isChanged = true;
      _isSubscribed = isSub;
    });
  }

  @override
  Widget build(BuildContext context) {
    APIService apiService = new APIService();

    List<Widget> tweets = [];

    apiService
        .getUserByNickName(
            UserRequestModelByNickName(nickName: widget.nickName))
        .then((value) => _isSubscribed = value.isSubscribed);

    return Scaffold(
      appBar: AppBar(
        title: Text("Crowtor"),
      ),
      body: FutureBuilder<UserResponseModel>(
        future: apiService.getUserByNickName(
            UserRequestModelByNickName(nickName: widget.nickName)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserResponseModel responseModel = snapshot.data;

            FeedResponseModel feedResponseModel =
                FeedResponseModel.fromJson(snapshot.data.twitts);

            for (int i = 0; i < feedResponseModel.tweets.length; i++) {
              tweets.add(Tweet(
                tweet: feedResponseModel.tweets[i],
              ));
            }

            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        responseModel.firstName + " " + responseModel.lastName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text("@" + responseModel.nickName,
                              style: TextStyle(fontSize: 18))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                              ),
                              Text(
                                " Дата регистрации: " +
                                    responseModel.dateRegistration
                                        .substring(0, 10),
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          )),
                      _isSubscribed
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: SizedBox(
                                child: ElevatedButton(
                                  child: Text("Отписаться"),
                                  onPressed: () {
                                    apiService
                                        .unSubscribe(UnSubscribeRequestModel(
                                            subscribeUser: responseModel.id))
                                        .then((value) {
                                      _changeSub(false);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.purple,
                                  ),
                                ),
                                width: double.infinity,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: SizedBox(
                                child: ElevatedButton(
                                  child: Text("Подписаться"),
                                  onPressed: () {
                                    apiService
                                        .subscribe(SubscribeRequestModel(
                                            subscribeUser: responseModel.id))
                                        .then((value) {
                                      _changeSub(true);
                                    });
                                  },
                                ),
                                width: double.infinity,
                              ),
                            ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                responseModel.subscribers.toString() +
                                    " подписчиков",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                responseModel.subscription.toString() +
                                    " подписок",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Твиты",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Нравится",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: tweets.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: tweets[index],
                    );
                  },
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// import 'package:crowtor/api/apiService.dart';
// import 'package:crowtor/model/UserModel.dart';
// import 'package:flutter/material.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({Key key, this.nickName}) : super(key: key);
//
//   final String nickName;
//
//   @override
//   _ProfileState createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     APIService apiService = new APIService();
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Crowtor"),),
//       body: FutureBuilder<UserResponseModel>(
//         future: apiService.getUserByNickName(UserRequestModelByNickName(nickName: widget.nickName)),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             UserResponseModel responseModel = snapshot.data;
//
//             return Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     responseModel.firstName + " " + responseModel.lastName,
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                       child: Text("@" + responseModel.nickName,
//                           style: TextStyle(fontSize: 18))),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                       child:
//                       Row(children: [
//                         Icon(Icons.calendar_today_outlined, size: 20,),
//                         Text(
//                           " Дата регистрации: " + responseModel.dateRegistration.substring(0, 10), style: TextStyle(fontSize: 16),
//                         )
//                       ],)
//                   ),
//
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
//                       child:
//                       SizedBox(
//                         child: ElevatedButton(
//                           child: Text("Подписаться"),
//                           onPressed: () => print("ПОДПИСАТЬСЯЯЯЯЯ"),
//                         ),
//                         width: double.infinity,
//                       ),
//                   ),
//
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(responseModel.subscribers.toString() +
//                               " подписчиков", style: TextStyle(fontSize: 20),),
//                           Text(
//                             responseModel.subscription.toString() + " подписок", style: TextStyle(fontSize: 20),)
//                         ],
//                       )),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text("Твиты", style: TextStyle(fontSize: 18),),
//                           Text("Нравиться", style: TextStyle(fontSize: 18),),
//                         ],
//                       )),
//                 ],
//               ),
//             );
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
