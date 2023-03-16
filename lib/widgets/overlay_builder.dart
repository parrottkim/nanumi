import 'package:flutter/material.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:unicons/unicons.dart';

class OverlayBuilder<T> extends StatefulWidget {
  const OverlayBuilder({
    Key? key,
    this.hintText = '',
  }) : super(key: key);

  final String hintText;

  @override
  _OverlayBuilderState createState() => _OverlayBuilderState();
}

class _OverlayBuilderState extends State<OverlayBuilder>
    with WidgetsBindingObserver {
  bool _isOpen = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    _renderBox = context.findRenderObject() as RenderBox?;
    var size = _renderBox!.size;

    return OverlayEntry(
      maintainState: false,
      builder: (context) => Stack(
        children: [
          ModalBarrier(
            onDismiss: () {
              _removeOverlay();
            },
          ),
          Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(UniconsLine.search),
                          ),
                        ),
                      ),
                      DefaultIconButton(
                        onPressed: () {
                          _removeOverlay();
                        },
                        icon: Icon(UniconsLine.multiply),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Material(
        color: Colors.transparent,
        child: DefaultIconButton(
          onPressed: () {
            _isOpen ? _removeOverlay() : _addOverlay();
          },
          icon: Icon(UniconsLine.search),
        ),
      ),
    );
  }
}
