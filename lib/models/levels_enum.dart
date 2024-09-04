
import 'package:musicapp/models/module.dart';

import 'package:musicapp/models/page.dart';

enum Level {
  beginner(number: 0,collectionname:"basic_modules"),
  intermediate(number: 1,
  collectionname:"intermediate_modules"),
  expert(number: 2,collectionname: "expert_modules");

  const Level({
    required this.number,
    required this.collectionname
  });
  final int number;
  final String collectionname;
  
}

class LevelInfo {
   LevelInfo({
    required this.moduleInfo,
    required this.moduleList,
    required this.locked,
  });
  final List<List<PageInfo>> moduleInfo;
  final List<Module> moduleList;
  bool locked;
}

// final levelInfoMap = {
//   Level.beginner: LevelInfo(
//     moduleInfo: beginnerModuleList,
//     moduleList:modulesbeginnertedata,
//     locked:false
//   ),
//   Level.intermediate: LevelInfo(
//     moduleInfo: intermediateModuleList,
//     moduleList: modulesintermediatedata,
//     locked:true
//   ),
//   Level.expert: LevelInfo(
//     moduleInfo: expertModuleList,
//     locked:true,
//     moduleList: expertintermediatedata,
//   ),
// };
