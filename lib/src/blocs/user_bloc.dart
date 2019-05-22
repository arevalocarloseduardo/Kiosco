import 'dart:async';

import 'package:contabilidad/Models/user.dart';
import 'package:contabilidad/src/blocs/proveedor_bloc.dart';

class UserBloc implements BlocBase{
 User _user;

 StreamController<User>_userController = StreamController<User>();
 Sink<User> get _inUser =>_userController.sink;
 Stream<User>get outUser =>_userController.stream;

 StreamController<User>_updateUserController=StreamController(); 
 Sink<User> get updateUser =>_updateUserController.sink;
 
 StreamController<String>_updateNameController=StreamController(); 
 Sink<String> get updateName =>_updateNameController.sink;

UserBloc(){  
  _updateUserController.stream.listen(_updateUser);
  _updateNameController.stream.listen(_updateName);
  
    }
  @override
  void dispose() {
    _userController.close();
    _updateUserController.close();
    _updateNameController.close();
  }
    
      void _updateUser(User user) {
        _user = user;
        _inUser.add(_user);
    }
  
    void _updateName(String name) {
      _user.name = name;
      _inUser.add(_user);

  }
}