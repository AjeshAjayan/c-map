import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_poc/models/designation.dart';
import 'package:map_poc/models/infrastructure_paths.dart';
import 'package:map_poc/services/designations.dart';
import 'package:map_poc/services/infrastructure_path.dart';
import 'package:map_poc/widgets/add_designation_popup.dart';
import 'package:map_poc/widgets/add_intersection_popup.dart';

class HomeView extends StatefulWidget {
  final int infrastructureId;

  const HomeView(this.infrastructureId);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Offset user = new Offset(0, 0);
  Offset from = new Offset(0, 0);
  Offset to = new Offset(0, 0);

  final List<InfrastructurePaths> routes = [];
  final List<Designation> designations = [];

  Designation? currentDesignation;
  Designation? toWhere;
  bool createMode = false;

  String label = '';

  final int _movementFactor = 3;

  @override
  initState() {
    getExistingDestinations();
    getExistingInfraPaths();
    super.initState();
  }

  getExistingDestinations() async {
    final List<Designation> existingDestination =
        await DesignationService.getDestinationsByInfraId(
            widget.infrastructureId);
    setState(() {
      designations.addAll(existingDestination);
    });
  }

  getExistingInfraPaths() async {
    final List<InfrastructurePaths> existingRoutes =
        await InfrastructurePathService.getInfraPathById(
            widget.infrastructureId);
    setState(() {
      routes.addAll(existingRoutes);
    });
  }

  _moveForward() {
    setState(() {
      user = new Offset(user.dx, user.dy + _movementFactor);
      if (createMode) {
        to = user;
      }
    });
  }

  _moveBackward() {
    setState(() {
      user = new Offset(user.dx, user.dy - _movementFactor);
      if (createMode) {
        to = user;
      }
    });
  }

  _moveRight() {
    setState(() {
      user = new Offset(user.dx + _movementFactor, user.dy);
      if (createMode) {
        to = user;
      }
    });
  }

  _moveLeft() {
    setState(() {
      user = new Offset(user.dx - _movementFactor, user.dy);
      if (createMode) {
        to = user;
      }
    });
  }

  _onCreateModeChange(value) {
    setState(() {
      createMode = value;
    });
  }

  _onMarkIntersection() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Intersection'),
        content: Text('Are you sure to add intersection here'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final designation = await DesignationService.addDesignation(
                  new Designation(
                      x: user.dx,
                      y: user.dy,
                      label: '',
                      infId: widget.infrastructureId));

              InfrastructurePaths path = new InfrastructurePaths(
                  infId: widget.infrastructureId,
                  startX: from.dx,
                  startY: from.dy,
                  endX: user.dx,
                  endY: user.dy,
                  startLabel: '',
                  endLabel: '');
              final responsePath =
                  await InfrastructurePathService.addPath(path);
              designations.add(designation);
              setState(() {
                routes.add(responsePath);
                from = user;
              });

              Navigator.of(context).pop();
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

  _onMarkDesignation() async {
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
                    new Designation(
                        x: user.dx,
                        y: user.dy,
                        label: label,
                        infId: widget.infrastructureId));

                InfrastructurePaths path = new InfrastructurePaths(
                    infId: widget.infrastructureId,
                    startX: from.dx,
                    startY: from.dy,
                    endX: user.dx,
                    endY: user.dy,
                    startLabel: '',
                    endLabel: '');

                final responsePath =
                    await InfrastructurePathService.addPath(path);
                designations.add(designation);
                routes.add(responsePath);

                setState(() {
                  from = user;
                });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: CustomPaint(
              painter:
                  Painter(user, from, to, routes, createMode, designations),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Visibility(
                      visible: createMode,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _moveForward,
                            child: Text('Forward'),
                          ),
                          ElevatedButton(
                            onPressed: _moveBackward,
                            child: Text('Backward'),
                          ),
                          ElevatedButton(
                            onPressed: _moveRight,
                            child: Text('Right'),
                          ),
                          ElevatedButton(
                            onPressed: _moveLeft,
                            child: Text('Left'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !createMode
                            ? Container(
                                width: 100,
                                height: 50,
                                child: DropdownButton<Designation>(
                                  value: currentDesignation,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (Designation? newValue) {
                                    setState(() {
                                      currentDesignation = newValue!;
                                    });
                                  },
                                  items: this
                                      .designations
                                      .map<DropdownMenuItem<Designation>>(
                                          (Designation value) {
                                    return DropdownMenuItem<Designation>(
                                      value: value,
                                      child: Text(value.label),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Flexible(
                                child: ElevatedButton(
                                  onPressed: _onMarkDesignation,
                                  child: Text('Mark Destination'),
                                ),
                              ),
                        Switch(
                            value: createMode, onChanged: _onCreateModeChange),
                        !createMode
                            ? Container(
                                width: 100,
                                height: 50,
                                child: DropdownButton<Designation>(
                                  value: toWhere,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (Designation? newValue) {
                                    setState(() {
                                      toWhere = newValue!;
                                    });
                                  },
                                  items: this
                                      .designations
                                      .map<DropdownMenuItem<Designation>>(
                                          (Designation value) {
                                    return DropdownMenuItem<Designation>(
                                      value: value,
                                      child: Text(value.label),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Flexible(
                                child: ElevatedButton(
                                  onPressed: _onMarkIntersection,
                                  child: Text('Mark Intersection'),
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final Offset user;
  final Offset from;
  final Offset to;
  final bool createMode;
  final List<InfrastructurePaths> routes;
  final List<Designation> designations;

  Painter(this.user, this.from, this.to, this.routes, this.createMode,
      this.designations);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1, -1);

    // draw all designations and intersections
    for (var designation in designations) {
      canvas.drawCircle(
          new Offset(designation.x, designation.y),
          25,
          Paint()
            ..color = designation.label != '' ? Colors.red : Colors.blue
            ..strokeWidth = designation.label != '' ? 5 : 2);

      final ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.justify,
      ))
        ..addText(designation.label);
      final Paragraph paragraph = paragraphBuilder.build()
        ..layout(ParagraphConstraints(width: size.width));

      canvas.drawParagraph(
          paragraph, new Offset(designation.x + 10, designation.y + 10));
    }

    // draw all paths
    for (var route in routes) {
      canvas.drawLine(
        new Offset(route.startX, route.startY),
        new Offset(route.endX, route.endY),
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 10,
      );
    }

    canvas.drawLine(
      this.from,
      this.to,
      Paint()
        ..color = createMode ? Colors.yellow : Colors.red
        ..strokeWidth = createMode ? 10 : 5,
    );

    canvas.drawCircle(
        this.user,
        15,
        Paint()
          ..color = Colors.green
          ..strokeWidth = 10);
  }

  void _drawAllRoutes(Canvas canvas) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
