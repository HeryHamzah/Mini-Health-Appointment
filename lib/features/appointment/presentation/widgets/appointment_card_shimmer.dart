import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/shared/shimmer_widget.dart';

class AppointmentCardShimmer extends StatelessWidget {
  const AppointmentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ShimmerWidget(
                  width: 45,
                  height: 45,
                  borderRadius: BorderRadius.circular(22.5),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      ShimmerWidget(
                        width: MediaQuery.sizeOf(context).width / 4,
                        height: 18,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      ShimmerWidget(
                        width: double.infinity,
                        height: 12,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ShimmerWidget(
                  width: 100,
                  height: 30,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ShimmerWidget(
              width: double.infinity,
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
