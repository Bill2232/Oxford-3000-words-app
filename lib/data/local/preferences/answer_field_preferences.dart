import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/practice/application/answer_field_style.dart';

/// Persists the selected practice answer-field style locally.
class AnswerFieldPreferences {
  static const _styleKey = 'answer_field_style';

  Future<AnswerFieldStyle?> getSelectedStyle() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_styleKey);
    for (final style in AnswerFieldStyle.values) {
      if (style.name == stored) return style;
    }
    return null;
  }

  Future<void> setSelectedStyle(AnswerFieldStyle style) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_styleKey, style.name);
  }
}
