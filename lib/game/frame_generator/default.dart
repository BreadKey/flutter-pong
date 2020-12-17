part of frame_generator;

class DefaultFrameGenerator extends FrameGenerator {
  @override
  Stream get frameStream => Stream.periodic(const Duration(milliseconds: 10));
}
