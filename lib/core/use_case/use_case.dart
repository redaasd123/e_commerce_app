import 'package:dartz/dartz.dart';

import '../errors/failure.dart';


abstract class UseCase<type,param>{

   Future<Either<Failure,type>>call(param param);
}

class NoParam{}