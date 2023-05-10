import 'package:places/domain/categories.dart';
import 'package:places/domain/sight.dart';

List<Sight> mocks = [
  Sight(
    name: 'Мамаев Курган',
    lat: 48.742,
    lon: 44.539,
    url:
        'https://xcourse.me/images/showplaces/707/609e59b44302c77175f2479ee51213ef.jpg',
    details:
        'Возвышенность на правом берегу реки Волги в Центральном районе города Волгограда, где во время Сталинградской битвы происходили ожесточённые бои, начиная с сентября 1942 года и заканчивая январём 1943 года. Сегодня Мамаев курган известен в первую очередь памятником-ансамблем «Героям Сталинградской битвы» с главным монументом «Родина-мать зовёт!». ',
    type: Categories.specialPlace,
  ),
  Sight(
    name: 'Парк ЦПКиО',
    lat: 43.986,
    lon: 32.592,
    url:
        'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
    details: 'Хорошее место для прогулок.',
    type: Categories.park,
  ),
  Sight(
    name: 'Кофе',
    lat: 70.986,
    lon: 40.592,
    url:
        'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
    details: 'Кофе',
    type: Categories.cafe,
  ),
  Sight(
    name: 'Кофейня у Леры',
    lat: 23,
    lon: 40.592,
    url:
        'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
    details: 'Вкусный кофе',
    type: Categories.cafe,
  ),
];
