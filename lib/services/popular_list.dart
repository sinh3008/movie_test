import 'package:movie_test/services/networking.dart';

const apiKey = '26763d7bf2e94098192e629eb975dab0';
const page = 1;

class PopularListModel {
  Future<dynamic> getPopular() async {
    var url = Uri.https(
      'api.themoviedb.org',
      '3/discover/movie',
      {
        'api_key': apiKey,
        'page': page,
      },
    );
    NetWorkHelper netWorkHelper = NetWorkHelper(url: url);
    var popularData = await netWorkHelper.getData();
    return popularData;
  }
}
