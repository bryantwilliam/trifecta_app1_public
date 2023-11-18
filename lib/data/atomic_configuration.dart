import 'package:atomic_sdk_flutter/atomic_stream_container.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trifecta_app1/data/models/secret_config.dart';

class AtomicConfiguration {
  static const environmentId = '1YlBd6Vd';
  static const containerId1 = 'eDMojPLZ';
  static const containerId2 = 'M4aApg4p';
  static const containerId3 = 'xLAkrZD1';
  static const containerId4 = '6LXmKXwx';
  static final token = _createToken();
  static SecretConfig? _secretConfig;

  static Future<SecretConfig> get secretConfig async {
    if (_secretConfig == null || !dotenv.isInitialized) {
      await dotenv.load();
      _secretConfig = SecretConfig(
        apiKey: dotenv.env['API_KEY']!,
        userId: dotenv.env['USER_ID']!,
        apiUrl: dotenv.env['API_URL']!,
      );
    }
    return _secretConfig!;
  }

  static Future<RSAPrivateKey> _loadPrivateKey() async {
    final privKey = await rootBundle.loadString('assets/jwtRS512.key');
    return RSAPrivateKey(privKey);
  }

  static Future<String> _createToken() async {
    final jwt = JWT({'sub': (await secretConfig).userId});
    final jwtToken = jwt.sign(
      await _loadPrivateKey(),
      algorithm: JWTAlgorithm.RS256,
      expiresIn: const Duration(days: 3),
    );
    return jwtToken;
  }

  static AACStreamContainerConfiguration _getConfig(
    AACStreamContainerConfiguration config,
    String? header,
    String? footer,
  ) {
    config
      ..pollingInterval = 5
      ..votingOption = AACVotingOption.both
      ..interfaceStyle = AACInterfaceStyle.automatic
      ..presentationStyle = AACPresentationStyle.withActionButton
      ..enabledUiElements = AACUIElement.defaultValue
      // ignore: invalid_assignment
      ..enabledUiElements |= AACUIElement.cardListFooterMessage;
    if (footer != null) {
      // Set Card Container Footer
      config.setValueForCustomString(
        AACCustomString.cardListFooterMessage,
        footer,
      );
    } else {
      // To disable card list coast:
      config.enabledUiElements &=
          // ignore: invalid_assignment, argument_type_not_assignable
          ~AACUIElement.cardListToast;
    }
    if (header != null) {
      // Set Card Container Title
      config.setValueForCustomString(
        AACCustomString.cardListTitle,
        header,
      );
    } else {
      // To disable card list header:
      config.enabledUiElements &=
          // ignore: invalid_assignment, argument_type_not_assignable
          ~AACUIElement.cardListHeader;
    }

    return config;
  }

  static AACSingleCardConfiguration getSingleCardConfiguration() {
    return _getConfig(
      AACSingleCardConfiguration()..automaticallyLoadNextCard = true,
      null,
      null,
    ) as AACSingleCardConfiguration;
  }

  static AACStreamContainerConfiguration getStreamContainerConfiguration({
    String? header,
    String? footer,
  }) {
    return _getConfig(AACStreamContainerConfiguration(), header, footer);
  }
}
