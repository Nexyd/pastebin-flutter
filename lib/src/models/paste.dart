import 'package:xml/xml.dart';

import 'models.dart';

///
/// Models a Pastebin paste
///
class Paste {
  final String? key;
  final DateTime createdDate;
  final DateTime expiredDate;
  final String? title;
  final int? sizeInBytes;
  final Visibility visibility;
  final Format format;
  final Uri? url;
  final int? hits;

  const Paste({
    required this.createdDate,
    required this.expiredDate,
    required this.format,
    required this.hits,
    required this.key,
    required this.sizeInBytes,
    required this.title,
    required this.url,
    required this.visibility,
  });

  static List<Paste> fromXmlDocument(final XmlDocument xmlDocument) {
    final pasteList = xmlDocument.findElements('paste_list');
    if (pasteList.isEmpty) return [];

    final paste = pasteList.first.findElements('paste');
    final map = paste.map((element) => Paste.fromXmlNode(element));
    return map.toList();
  }

  static Paste fromXmlNode(final XmlNode xmlNode) {
    return Paste(
      createdDate: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(xmlNode.getElement('paste_date')!.innerText)!,
      ),
      expiredDate: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(xmlNode.getElement('paste_expire_date')!.innerText)!,
      ),
      format: FormatExtension.tryParse(
        xmlNode.getElement('paste_format_short')?.innerText,
      ),
      visibility: VisibilityExtension.tryParse(
        xmlNode.getElement('paste_private')?.innerText,
      ),
      hits: int.tryParse(xmlNode.getElement('paste_hits')!.innerText),
      key: xmlNode.getElement('paste_key')?.innerText,
      sizeInBytes: int.tryParse(xmlNode.getElement('paste_size')!.innerText),
      title: xmlNode.getElement('paste_title')?.innerText,
      url: Uri.tryParse(xmlNode.getElement('paste_url')!.innerText),
    );
  }
}
