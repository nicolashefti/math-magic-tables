library sunflower;
import "dart:html";
import "dart:math";

const String SEED_COLOR = "#D2D2D2";
const String LINE_COLOR = "#C2C2C2";
const int POINT_RADIUS = 2;
const int SCALE_FACTOR = 100;
const num TAU = PI * 2;
const int MAX_D = 300;
const num centerX = MAX_D / 2;
const num centerY = centerX;
final InputElement inputModulo = query("#modulo");
final InputElement inputFactor = query("#factor");

int modulo = 10;
int factor = 2;
final CanvasRenderingContext2D context =
(query("#canvas") as CanvasElement).context2D;

void main() {
  inputModulo.onChange.listen((e) => draw());
  inputFactor.onChange.listen((e) => draw());
  draw();
}

/// Draw the complete figure
void draw() {
  modulo = int.parse(inputModulo.value);
  factor = int.parse(inputFactor.value);

  context.clearRect(0, 0, MAX_D, MAX_D);

  for (var i = 0; i < modulo; i++) {
    final num r = SCALE_FACTOR;
    final num theta = (TAU * i / modulo) - PI/2;
    final num thetaFactor = (TAU * (i * factor % modulo) / modulo) - PI/2;
    drawPoint(centerX + r * cos(theta), centerY + r * sin(theta), centerX + r * cos(thetaFactor), centerY + r * sin(thetaFactor));
  }
}

/// Draw a small circle and the line corresponding of it multiplication
void drawPoint(num x, num y, num x2, num y2) {
  context
    ..beginPath()
    ..lineWidth = 2
    ..fillStyle = SEED_COLOR
    ..strokeStyle = SEED_COLOR
    ..arc(x, y, POINT_RADIUS, 0, TAU, false)
    ..fill()
    ..closePath()
    ..stroke();

  context
    ..beginPath()
    ..lineWidth = 1
    ..fillStyle = LINE_COLOR
    ..strokeStyle = LINE_COLOR
    ..moveTo(x, y)
    ..lineTo(x2, y2)
    ..closePath()
    ..stroke();
}
