library frame_generator;

part 'frame_generator/default.dart';

abstract class FrameGenerator {
  Stream get frameStream;
}