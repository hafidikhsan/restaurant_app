import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/api/restaurants.dart';
import 'api_service_test.mocks.dart';
import 'package:restaurant_app/services/api_service.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'Fetch Restaurant',
    () {
      test(
        'Returns an Restaurans if the http call completes successfully',
        () async {
          final client = MockClient();
          final api = ApiServices(client: client);

          when(
            client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/list'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              '{"error": false, "message": "success", "count": 20, "restaurants": [{"id": "rqdv5juczeskfw1e867", "name": "Melting Pot", "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.", "pictureId": "14", "city": "Medan", "rating": 4.2 }]}',
              200,
            ),
          );

          expect(
            await api.restaurantsList(),
            isA<Restaurants>(),
          );
        },
      );

      test(
        'Throws an exception if the http call completes with an error',
        () {
          final client = MockClient();
          final api = ApiServices(client: client);

          when(
            client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/list'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'Not Found',
              404,
            ),
          );

          expect(
            api.restaurantsList(),
            throwsException,
          );
        },
      );
    },
  );
}
