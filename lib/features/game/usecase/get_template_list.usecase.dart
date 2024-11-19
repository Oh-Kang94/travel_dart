import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/core/modules/usecase/base.usecase.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/features/game/repository/template.repository.dart';

part 'get_template_list.usecase.g.dart';

@riverpod
GetTemplateListUsecase getTemplateListUsecase(Ref ref) {
  final repository = ref.read(templateRepositoryProvider);
  return GetTemplateListUsecase(repository);
}

class GetTemplateListUsecase
    extends BaseNoParamUseCase<Result<List<Template?>>> {
  final TemplateRepository _repository;
  GetTemplateListUsecase(this._repository);

  @override
  FutureOr<Result<List<Template?>>> call() async =>
      await _repository.getTemplateList();
}
