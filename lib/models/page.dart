

class PageInfo {
  PageInfo({required this.title, required this.subtitle,required this.userhint, required this.image,required  this.audiopath, required this.isGestureon });
  final String? title;
  final List<String> subtitle;
  final bool isGestureon;
  final String? userhint;
  final List<String> image;
  final List<String>? audiopath;

  
  factory PageInfo.fromFirestore(Map<String, dynamic> data) {
    return PageInfo(
      title: data['title'],
      subtitle: List<String>.from(data['subtitle']),
      isGestureon: data['isGestureon'],
      userhint: data['userhint'],
      image: List<String>.from( data['image']),
      audiopath: List<String>.from(data['audiopath']),
    );
  }
}