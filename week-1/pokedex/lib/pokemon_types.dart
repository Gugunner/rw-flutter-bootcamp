

import 'package:flutter/material.dart';
import 'package:pokedex/types.dart';

class Types extends StatelessWidget {
  const Types({
    Key? key,
    required this.types,
  }) : super(key: key);

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [...types.map((type) => TypeTag(type: type))],
    );
  }
}

class TypeTag extends StatelessWidget {
  const TypeTag({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final displayName = type.substring(0, 1).toUpperCase() + type.substring(1);

    return Card(
      color: TagTypes.tagColor(type),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Text(
          displayName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}