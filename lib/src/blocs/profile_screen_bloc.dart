
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ProfileScreenBloc extends Bloc{

  BehaviorSubject<User> _userController = BehaviorSubject();

  Stream<User> get userStream => _userController.stream.asBroadcastStream();

  void getUser() async {
    User user = await Utils.getLoggedUserInfo();

    _userController.sink.add(user);

  }
  @override
  void dispose() {

  }

}