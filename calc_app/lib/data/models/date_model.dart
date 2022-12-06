import 'package:calc_app/domain/entities/date.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_model.freezed.dart';

part 'date_model.g.dart';

@freezed
class DateModel with _$DateModel implements DateEntity {
  const DateModel._();

  const factory DateModel({
    required DateTime create,
    required DateTime edit,
  }) = _DateModel;

  factory DateModel.fromJson(Map<String, dynamic> json) =>
      _$DateModelFromJson(json);


}
