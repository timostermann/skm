
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:skm_services/enums/interaction_type.dart';
import 'package:skm_services/enums/template_type.dart';
import 'package:skm_services/models/cache.dart';
import 'package:skm_services/models/sketch_template.dart';

part 'sketch_event.dart';
part 'sketch_state.dart';

class SketchBloc extends Bloc<SketchEvent, SketchState> {
  final Cache cache;

  SketchBloc(this.cache)
      : super(SketchLoaded(
            template: SketchTemplate.defaultCoordinates(TemplateType.Free))) {
    on<SketchEvent>((event, emit) async {
      if (event is SketchLoadTemplate) {
        emit(SketchLoaded(
            template: cache.sketch[event.type] ??
                SketchTemplate.defaultCoordinates(event.type)));
      }

      if (event is SketchUpdateProperties) {
        cache.sketch[event.template.type] = event.template;
        emit(SketchLoaded(template: event.template));
      }

      if (event is SketchToggleTextPopup) {
        emit(SketchShowTextField(
          template: event.template,
          coordinateIndex: event.coordinateIndex,
          interactionType: event.interactionType,
        ));
      }

      if (event is SketchScreenshot) {
        cache.screenshot = event.screenshot;
      }
    });
  }
}