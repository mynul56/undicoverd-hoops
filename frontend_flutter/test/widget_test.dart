// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:undiscovered_hoops/main.dart';
import 'package:undiscovered_hoops/features/auth/repositories/auth_repository.dart';
import 'package:undiscovered_hoops/core/network/api_client.dart';
import 'package:undiscovered_hoops/features/calls/services/signaling_service.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      // Provide mocked dependencies for the test
      final mockApiClient = ApiClient();
      final mockAuthRepo = AuthRepositoryImpl(apiClient: mockApiClient);
      final mockSignaling = SignalingService();

      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp(
        authRepository: mockAuthRepo,
        signalingService: mockSignaling,
        apiClient: mockApiClient,
      ));

      // Verify that the title text is rendered
      expect(find.text('UNDISCOVERED'), findsOneWidget);
    });
  });
}
