import 'package:flutter/material.dart';
import 'package:mastering_flutter/second_page.dart';

class DraggableFloatingActionCustom extends StatelessWidget {
  final GlobalKey _parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Floating Button Action'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
          ),
          Container(
            width: 300,
            height: 300,
            child: Stack(
              key: _parentKey,
              children: [
                Container(
                  color: Colors.teal,
                ),
                Center(
                    child: const Text(
                  'Draggable Floating',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                )),
                DraggableFloatingActionBtn(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.flutter_dash,
                          color: Colors.blue, size: 50),
                    ),
                    initialOffset: const Offset(100, 100),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SecondPage();
                      }));
                    },
                    parentKey: _parentKey)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DraggableFloatingActionBtn extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;
  final GlobalKey parentKey;

  DraggableFloatingActionBtn({
    @required this.child,
    @required this.initialOffset,
    @required this.onPressed,
    @required this.parentKey,
  });

  @override
  _DraggableFloatingActionBtnState createState() =>
      _DraggableFloatingActionBtnState();
}

class _DraggableFloatingActionBtnState
    extends State<DraggableFloatingActionBtn> {
  final GlobalKey _key = GlobalKey();

  bool _isDragging = false;
  Offset _offset;
  Offset _minOffset;
  Offset _maxOffset;

  @override
  void initState() {
    super.initState();

    _offset = widget.initialOffset;
    WidgetsBinding.instance?.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
      });
    } catch (e) {
      print('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: Listener(
          onPointerMove: (PointerMoveEvent pointerMoveEvent) {
            _updatePosition(pointerMoveEvent);

            setState(() {
              _isDragging = true;
            });
          },
          onPointerUp: (PointerUpEvent pointerUpEvent) {
            if (_isDragging) {
              setState(() {
                _isDragging = false;
              });
            } else {
              widget.onPressed();
            }
          },
          child: Container(key: _key, child: widget.child),
        ));
  }
}
