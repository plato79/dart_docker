import 'package:dart_frog/dart_frog.dart';
import 'package:dart_docker/dart_docker.dart';

Response onRequest(RequestContext context) {
  var body =
      '<html><head><meta charset="utf-8"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script></head><body>';

  final docker = DockerSocketClient();
  docker.container.containerList().then((value) {
    (value != null)
        ? body += '<p>containers</p>'
        : body += '<p>no containers</p>';
    for (final container in value!) {
      body += '<p>${container.id}</p>';
    }
  });
  // docker.containers(excludeStopped: true).forEach((container) {
  //   body += '<p>${container.name}</p>';
  // });
  body += '</body></html>';

  return Response(body: body, headers: {'Content-Type': 'text/html'});
}
