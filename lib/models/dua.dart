enum DuaBy {
  all('all'),
  allah('allah'),
  prophet('prophet'),
  angel('angel'),
  followers('followers');

  final String type;
  const DuaBy(this.type);
}

extension ConvertDuaBy on String {
  DuaBy toDuaByTypeEnum() {
    switch (this) {
      case 'allah':
        return DuaBy.allah;
      case 'angel':
        return DuaBy.angel;
      case 'prophet':
        return DuaBy.prophet;
      case 'followers':
        return DuaBy.followers;
      default:
        return DuaBy.all;
    }
  }
}

// -----------------------------------------------------------------------------
class DuaModel {
  final int id;
  final String titleEn;
  final String titleBn;
  final DuaBy duaBy;
  final String duaByStringEn;
  final String duaByStringBn;
  final String arabicDua;
  final String transliterationEn;
  final String transliterationBn;
  final String translationEn;
  final String translationBn;
  final String summaryEn;
  final String summaryBn;
  final String referenceEn;
  final String referenceBn;
  DuaModel({
    required this.id,
    required this.titleEn,
    required this.titleBn,
    required this.duaBy,
    required this.duaByStringEn,
    required this.duaByStringBn,
    required this.arabicDua,
    required this.transliterationEn,
    required this.transliterationBn,
    required this.translationEn,
    required this.translationBn,
    required this.summaryEn,
    required this.summaryBn,
    required this.referenceEn,
    required this.referenceBn,
  });
}
