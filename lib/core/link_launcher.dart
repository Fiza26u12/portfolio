import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

/// Safari only allows `window.open` while the browser is still inside the tap
/// handler, so every launch below must be fired synchronously — never after an
/// `await` (animation, haptic, or otherwise).
abstract final class LinkLauncher {
  /// Project / profile links: new tab on web, external browser on mobile.
  static void openExternal(String? url) {
    final uri = _parse(url);
    if (uri == null) return;

    if (kIsWeb) {
      unawaited(launchUrl(uri, webOnlyWindowName: '_blank'));
    } else {
      unawaited(launchUrl(uri, mode: LaunchMode.externalApplication));
    }
  }

  /// `mailto:` / `tel:` links, which must stay in the current tab on web so
  /// Safari hands them to the mail or phone app instead of opening a blank tab.
  static void openScheme(String? url) {
    final uri = _parse(url);
    if (uri == null) return;

    if (kIsWeb) {
      unawaited(launchUrl(uri, webOnlyWindowName: '_self'));
    } else {
      unawaited(launchUrl(uri, mode: LaunchMode.externalApplication));
    }
  }

  static Uri? _parse(String? url) {
    if (url == null || url.isEmpty) return null;
    return Uri.tryParse(url);
  }
}
