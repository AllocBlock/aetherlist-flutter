flutter pub run intl_translation:extract_to_arb --output-dir=l10n-arb lib/l10n/localization_intl.dart

flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_zh_CN.arb l10n-arb/intl_messages.arb