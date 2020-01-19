import 'package:digital_clock/core/model/vector.dart';

/// Relative width and height
/// All the elements will be build based on this
const double DEVICE_WIDTH = 1500;
const double DEVICE_HEIGHT = 900;

/// Each building bricks is ant
/// an below it's size ratio is 3:1
const double ANT_WIDTH = 40;
const double ANT_HEIGHT = 120;
const double ANT_MARGIN = 10;
const double NUMBER_MARGIN = 100;
const double NUMBER_HEIGHT = 300; 

/// Numbers positions Number size will depend on
/// ANT size
/// Number generally mean one of the four item of
/// time for instance 12:34 [1] - is one of the number
///
/// Below demonstrated starting point of number
const double NUMBER_WIDTH =
    ANT_HEIGHT + 2 * ANT_WIDTH + ANT_MARGIN * 2; // generally it equal to 270
const double NUMBER_X_START =
    (DEVICE_WIDTH - (NUMBER_WIDTH * 4 + NUMBER_MARGIN * 3)) / 2;
const Vector NUMBER_1 = const Vector(NUMBER_X_START, NUMBER_HEIGHT);
const Vector NUMBER_2 =
    const Vector(NUMBER_X_START + NUMBER_WIDTH + NUMBER_MARGIN, NUMBER_HEIGHT);
const Vector NUMBER_3 =
    const Vector(NUMBER_X_START + NUMBER_WIDTH * 2 + NUMBER_MARGIN * 2, NUMBER_HEIGHT);
const Vector NUMBER_4 =
    const Vector(NUMBER_X_START + NUMBER_WIDTH * 3 + NUMBER_MARGIN * 3, NUMBER_HEIGHT);

/// Timing
/// When all ants will change positions
const int ANT_MOVEMENT_TIME = 600;
const int ANT_ANGLE_TIME = 300;