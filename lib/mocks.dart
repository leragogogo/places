import 'package:places/domain/categories.dart';
import 'package:places/domain/sight.dart';

List<Sight> mocks = [
  Sight(
    name: 'Мамаев Курган',
    lat: 48.742,
    lon: 44.539,
    images: [
      'https://xcourse.me/images/showplaces/707/609e59b44302c77175f2479ee51213ef.jpg',
      'https://mamaev-hill.ru/files/publications/2020/23-20201113-12350-tzuja7.wyyq8.jpg',
      'https://xcourse.me/images/showplaces/707/609e59b44302c77175f2479ee51213ef.jpg',
      'https://mamaev-hill.ru/files/publications/2020/23-20201113-12350-tzuja7.wyyq8.jpg',
      'https://mamaev-hill.ru/files/publications/2020/23-20201113-12350-tzuja7.wyyq8.jpg',
    ],
    details:
        'Возвышенность на правом берегу реки Волги в Центральном районе города Волгограда, где во время Сталинградской битвы происходили ожесточённые бои, начиная с сентября 1942 года и заканчивая январём 1943 года. Сегодня Мамаев курган известен в первую очередь памятником-ансамблем «Героям Сталинградской битвы» с главным монументом «Родина-мать зовёт!». ',
    type: Categories.specialPlace,
  ),
  Sight(
    name: 'Парк ЦПКиО',
    lat: 43.986,
    lon: 32.592,
    images: [
      'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
      'https://volganet.net/wp-content/uploads/2021/05/cpkio.jpg',
    ],
    details: 'Хорошее место для прогулок.',
    type: Categories.park,
  ),
  Sight(
    name: 'Кофе',
    lat: 70.986,
    lon: 40.592,
    images: [
      'https://s0.rbk.ru/v6_top_pics/media/img/3/39/756738625992393.webp',
      'https://img.championat.com/c/900x900/news/big/k/l/kak-prigotovit-populjarnyj-dalgona-kofe_15876377302054158540.jpg',
    ],
    details: 'Кофе',
    type: Categories.cafe,
  ),
  Sight(
    name: 'Кофейня у Леры',
    lat: 23,
    lon: 40.592,
    images: [
      'https://media.admagazine.ru/photos/621f66e87ad8aa465cd46220/1:1/w_5789,h_5789,c_limit/IMG_5704.JPG',
      'https://www.gastronom.ru/binfiles/images/20200909/b67cae74.jpg',
    ],
    details: 'Вкусный кофе',
    type: Categories.cafe,
  ),
];
