import 'package:flutter/material.dart';

class PressIcon extends StatefulWidget{
  final IconData icon;
  final VoidCallback onTap;
  final bool open;
  final Color color;

  const PressIcon ({
    super.key,
    required this.icon,
    required this.onTap,
    required this.open,
    this.color = Colors.black,  
  });

  @override
  State<PressIcon> createState() => _PressIconState();
}

class _PressIconState extends State<PressIcon> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _rotation;
  
  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _rotation = Tween<double>(begin: 0, end: 0.25).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    if (widget.open) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant PressIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.open != widget.open){
      if(widget.open){
        _animationController.forward();
      }else{
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onTap,
      icon: RotationTransition(
        turns:  _rotation,
        child: Icon(widget.icon, color: widget.color),
      )
    );
  }

}