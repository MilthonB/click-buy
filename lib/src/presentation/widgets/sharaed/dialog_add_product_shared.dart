import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingDialog {
  static void show(BuildContext context, {required dynamic product, required int quantity}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(product.imagen, height: 80, width: 80, fit: BoxFit.cover),
              ),
              const SizedBox(height: 12),
              const Text('Agregando al carrito...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${product.title} x $quantity',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 12),
              const CircularProgressIndicator(color: Colors.teal, strokeWidth: 3),
            ],
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }
}
