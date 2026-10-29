
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final DateTime selectedDate;

  const CustomTimePicker({
    super.key,
    required this.selectedDate,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    selectedHour = now.hour;
    selectedMinute = now.minute;

    if (!_isTimeAvailable(selectedHour, selectedMinute)) {
      _selectFirstAvailableTime();
    }
  }

  bool get isToday {
    final now = DateTime.now();

    return widget.selectedDate.year == now.year &&
        widget.selectedDate.month == now.month &&
        widget.selectedDate.day == now.day;
  }

  bool _isTimeAvailable(int hour, int minute) {
    final now = DateTime.now();

    final selectedDateTime = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      hour,
      minute,
    );

    return selectedDateTime.isAfter(now);
  }

  void _selectFirstAvailableTime() {
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute++) {
        if (_isTimeAvailable(hour, minute)) {
          selectedHour = hour;
          selectedMinute = minute;
          return;
        }
      }
    }

    selectedHour = 0;
    selectedMinute = 0;
  }

  @override
  Widget build(BuildContext context) {
    final hasAvailableTime = !isToday ||
        DateTime(
          widget.selectedDate.year,
          widget.selectedDate.month,
          widget.selectedDate.day,
          23,
          59,
        ).isAfter(DateTime.now());

    return AlertDialog(
      title: const Text('Select time'),
      content: SizedBox(
        width: 300,
        child: !hasAvailableTime
            ? const Text('No available time for this date.')
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildTimeList(
                      itemCount: 24,
                      selectedValue: selectedHour,
                      label: 'Hour',
                      isEnabled: (hour) {
                        return List.generate(
                          60,
                          (minute) => minute,
                        ).any(
                          (minute) =>
                              _isTimeAvailable(hour, minute),
                        );
                      },
                      onSelected: (hour) {
                        setState(() {
                          selectedHour = hour;

                          if (!_isTimeAvailable(
                            selectedHour,
                            selectedMinute,
                          )) {
                            final availableMinute =
                                List.generate(60, (i) => i)
                                    .firstWhere(
                              (minute) => _isTimeAvailable(
                                selectedHour,
                                minute,
                              ),
                              orElse: () => -1,
                            );

                            if (availableMinute != -1) {
                              selectedMinute = availableMinute;
                            }
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTimeList(
                      itemCount: 60,
                      selectedValue: selectedMinute,
                      label: 'Minute',
                      isEnabled: (minute) {
                        return _isTimeAvailable(
                          selectedHour,
                          minute,
                        );
                      },
                      onSelected: (minute) {
                        setState(() {
                          selectedMinute = minute;
                        });
                      },
                    ),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: !hasAvailableTime ||
                  !_isTimeAvailable(
                    selectedHour,
                    selectedMinute,
                  )
              ? null
              : () {
                  Navigator.pop(
                    context,
                    TimeOfDay(
                      hour: selectedHour,
                      minute: selectedMinute,
                    ),
                  );
                },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  Widget _buildTimeList({
    required int itemCount,
    required int selectedValue,
    required String label,
    required bool Function(int value) isEnabled,
    required ValueChanged<int> onSelected,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final enabled = isEnabled(index);
              final selected = index == selectedValue;

              return InkWell(
                onTap: enabled
                    ? () => onSelected(index)
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected && enabled
                        ? Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: !enabled
                            ? Colors.grey.shade500
                            : selected
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
