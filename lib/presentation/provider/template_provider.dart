import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traveldart/core/modules/result/result.dart';
import 'package:traveldart/features/game/entities/template.dart';
import 'package:traveldart/features/game/usecase/get_template_list.usecase.dart';

part 'template_provider.g.dart';

@riverpod
class TemplateNotifier extends _$TemplateNotifier {
  @override
  FutureOr<List<Template?>> build() async {
    final result = await ref.read(getTemplateListUsecaseProvider).call();
    
    return result.fold(
      onSuccess: (value) => value,
      onFailure: (error) => throw error,
    );
  }

  Template? getTemplate(int index) => state.mapOrNull(
        data: (value) => value.value[index],
      );
}
