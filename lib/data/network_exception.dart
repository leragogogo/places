class NetworkException implements Exception{
  final String queryPath;
  final String error;
  NetworkException({required this.queryPath, required this.error}){}

 @override
  String toString() => 'В запросе $queryPath возникла ошибка: $error';
}