import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/features/game/repository/template.repository.impl.dart';

part 'template.repository.g.dart';

@riverpod
TemplateRepository templateRepository(Ref ref) {
  final IsarDataSource isar = ref.read(isarProvider);
  return TemplateRepositoryImpl(isar);
}

abstract class TemplateRepository {
  Future<Result<List<Template?>>> getTemplateList();

  Future<Result> addTemplate(Template template);
}
