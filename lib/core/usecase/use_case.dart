import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

abstract interface class UseCase<SuccessType, Parameters>{
  Future<Either<Failure, SuccessType>> call(Parameters params);
}