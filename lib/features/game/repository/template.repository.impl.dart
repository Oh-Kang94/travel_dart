import 'package:isar/isar.dart';
import 'package:traveldart/core/datasource/isar_datasource.dart';
import 'package:traveldart/core/modules/result/exception.dart';
import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/features/game/repository/template.repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  final IsarDataSource _isarDataSource;

  TemplateRepositoryImpl(this._isarDataSource);

  @override
  Future<Result> addTemplate(Template template) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Template?>>> getTemplateList() async {
    try {
      final isar = await _isarDataSource.db;
      final List<Template?> templateList =
          await isar.templates.where().findAll();
      return Result.success(templateList);
    } catch (e) {
      throw const DatabaseException();
    }
  }
}
