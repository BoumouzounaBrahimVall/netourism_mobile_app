abstract class Response {}

class Failure extends Response {
  String message;
  Failure(this.message);
}

class Success extends Response {
  String message;
  Success(this.message);
}
