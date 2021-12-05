import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:skm_services/src/core/helpers.dart';

void main() {
  math.Random randomGenerator = math.Random();

  group('test rounding to nth decimal', () {
    test('round zero', () {
      expect(roundToNthDecimal(0.0, randomGenerator.nextInt(10)), 0);
    });

    test('round negative number', () {
      expect(roundToNthDecimal(-47.34385031, 4), -47.3439);
    });

    test('round non-zero number to zero', () {
      expect(roundToNthDecimal(0.0119, 1), 0);
    });

    test('round pi', () {
      expect(roundToNthDecimal(math.pi, 7), 3.1415927);
    });
  });

  group('angle & radian measure conversion', () {
    test('convert angle to radian', () {
      expect(angleToRadianMeasure(75.3), 1.31423292675173);
    });

    test('convert radian to angle', () {
      expect(radianToAngleMeasure(-5), -286.4788975654116);
    });

    test('convert back and forth', () {
      double randomDouble = randomGenerator.nextDouble();
      expect(radianToAngleMeasure(angleToRadianMeasure(randomDouble)),
          randomDouble);
    });
  });

  group('triangle formulas', () {
    test('get third angle by angle sum', () {
      expect(getAngleByAngleSum(95, 17.3), 67.7);
    });

    test('get angle by length of 2 sides', () {
      expect(getBetaAngle(10, 23, 3), 23.499);
    });
  });
}
