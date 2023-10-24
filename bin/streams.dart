import 'dart:async';

void main() async {
  Stream myStream(int interval, [int? maxCount]) async* {
    int i = 1;
    while (i != maxCount) {
      print("Counting: $i");
      await Future.delayed(Duration(seconds: interval));
      yield i++;
    }
    print("The Stream is finished");
  }
  var kakoStream = myStream(1,5).asBroadcastStream();
  StreamSubscription mySubscriber = kakoStream.listen((event) {
    if (event.isEven) {
      print("This number is Even");
    }
  }, onError: (e) {
    print("An Error ocurrend:$e");
  }, onDone: () {
    print("The subscriber is gone");
  });

  kakoStream.map((event) => "Subscriber 2 watching: $event").listen(print);

  await Future.delayed(Duration(seconds: 3));
  mySubscriber.pause();
  print('pause');
  await Future.delayed(Duration(seconds: 3));
  mySubscriber.resume();
  print('Play');
  await Future.delayed(Duration(seconds: 3));
  mySubscriber.cancel();
  print('cancel');


  print("Main is Finished");
}
