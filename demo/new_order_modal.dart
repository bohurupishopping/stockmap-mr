import 'package:flutter/material.dart';
import 'new_order_widget';

class NewOrderModal {
  static Future<void> show({
    required BuildContext context,
    VoidCallback? onSuccess,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: NewOrderWidget(
                onSuccess: () {
                  Navigator.of(context).pop();
                  onSuccess?.call();
                },
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> showFullScreen({
    required BuildContext context,
    VoidCallback? onSuccess,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.indigo,
            body: SafeArea(
              child: NewOrderWidget(
                onSuccess: () {
                  Navigator.of(context).pop();
                  onSuccess?.call();
                },
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}