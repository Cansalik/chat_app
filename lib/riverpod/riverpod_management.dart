import 'package:chat_app/riverpod/register_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_riverpod.dart';

final loginRiverpod = ChangeNotifierProvider((_) => LoginRiverpod());
final registerRiverpod = ChangeNotifierProvider((_) => RegisterRiverpod());
