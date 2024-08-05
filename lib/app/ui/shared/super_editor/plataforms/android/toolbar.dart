import 'package:flutter/material.dart';

class AndroidTextEditingFloatingToolbar extends StatelessWidget {
  const AndroidTextEditingFloatingToolbar({
    super.key,
    this.floatingToolbarKey,
    this.onCutPressed,
    this.onCopyPressed,
    this.onPastePressed,
    this.onSelectAllPressed,
  });

  final Key? floatingToolbarKey;

  final VoidCallback? onCutPressed;
  final VoidCallback? onCopyPressed;
  final VoidCallback? onPastePressed;
  final VoidCallback? onSelectAllPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Theme(
      data: ThemeData(
        colorScheme: brightness == Brightness.light //
            ? const ColorScheme.light(primary: Colors.black)
            : const ColorScheme.dark(primary: Colors.white),
      ),
      child: Material(
        key: floatingToolbarKey,
        borderRadius: BorderRadius.circular(1),
        elevation: 1,
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onCutPressed != null)
              _buildButton(
                onPressed: onCutPressed!,
                title: 'Cut',
              ),
            if (onCopyPressed != null)
              _buildButton(
                onPressed: onCopyPressed!,
                title: 'Copy',
              ),
            if (onPastePressed != null)
              _buildButton(
                onPressed: onPastePressed!,
                title: 'Paste',
              ),
            if (onSelectAllPressed != null)
              _buildButton(
                onPressed: onSelectAllPressed!,
                title: 'Select All',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
