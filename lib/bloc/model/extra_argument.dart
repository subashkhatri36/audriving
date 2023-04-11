import 'package:driveaustralia/bloc/model/models.dart';

class ExtraArgument {
  final List<DktModel> categoryModelList;
  final int id;
  final String category;
  final String? lastPath;

  ExtraArgument({
    required this.id,
    required this.category,
    this.lastPath,
    required this.categoryModelList,
  });
}
/*
 id: state.params['id'],
            category: state.params['category'],
            lastPath: state.params['lastPath'] ?? '',
            catmodel: state.params['catmodel'] ?? [],
 */
