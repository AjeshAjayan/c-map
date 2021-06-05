import 'package:flutter/material.dart';
import 'package:map_poc/models/designation.dart';
import 'package:map_poc/models/infrastructure_paths.dart';
import 'package:map_poc/services/designations.dart';
import 'package:map_poc/services/infrastructure_path.dart';

designationPopup(
  context,
  Offset user,
  Offset from,
  List<Designation> designations,
  List<InfrastructurePaths> infrastructurePath,
) {
  String label = '';

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Add Designation'),
      content: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 0.3,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  onChanged: (e) => label = e,
                  obscureText: false,
                  style: TextStyle(color: const Color(0xFF673AB7)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'title',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            try {
              final designation = await DesignationService.addDesignation(
                  new Designation(x: user.dx, y: user.dy, label: label));

              InfrastructurePaths path = new InfrastructurePaths(
                  startX: from.dx,
                  startY: from.dy,
                  endX: user.dx,
                  endY: user.dy,
                  startLabel: '',
                  endLabel: '');

              final responsePath =
                  await InfrastructurePathService.addPath(path);
              designations.add(designation);
              infrastructurePath.add(responsePath);
              // setting current co-ordinates as from
              Navigator.of(context).pop();
            } catch (e) {
              print(e);
            }
          },
          child: Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        )
      ],
    ),
  );
}
