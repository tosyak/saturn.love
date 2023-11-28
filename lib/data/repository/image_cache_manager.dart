import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saturn/utils/logger.dart';

class SvgImageCacheManager {
  final _cacheManager = DefaultCacheManager();

  Future<bool> cacheImageFile(List<String> urlList) async {
    bool imageCached = false;
    try {
      for (var i = 0; i < urlList.length; i++) {
        final file = await _cacheManager.getSingleFile(urlList[i]);
        logger.i(urlList[i]);
        logger.i('svg image file $file');
        logger.i('image index $i');
        if (i + 1 == urlList.length) {
          imageCached = true;
        }
      }
      return imageCached;
    } catch (e, stackTrace) {
      logger.e('Error caching SVG image: $e,stackTrace $stackTrace');
      throw Exception('Error caching SVG image: $e,stackTrace $stackTrace');
    }
  }

  Future<File?> getCachedFile(String url) async {
    try {
      final FileInfo? fileInfo = await _cacheManager.getFileFromCache(url);
      if (fileInfo != null) {
        return fileInfo.file;
      } else {
        logger.e('Error getting cached SVG file was null');
        throw Exception('Error getting cached SVG file was null');
      }
    } catch (e, stackTrace) {
      logger.e('Error getting cached SVG file: $e,stackTrace $stackTrace');
      throw Exception(
          'Error getting cached SVG file: $e,stackTrace $stackTrace');
    }
  }

  Future<void> clearCache() async {
    try {
      await _cacheManager.emptyCache();
    } catch (e, stackTrace) {
      logger.e('Error clearing cache: $e,stackTrace $stackTrace');
      throw Exception('Error clearing cache: $e,stackTrace $stackTrace');
    }
  }
}
