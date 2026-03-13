import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/theme/app_colors.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';

class PerfomanceBarchart extends StatelessWidget {
  const PerfomanceBarchart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.card,
        border: Border.all(
          color: AppColors.border,
          width: 0.5
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            
            children: [
              const Text(
                "Weekly Perfomance",
                style: AppTextStyles.txtSm,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "~12% vs last month",
                  style: AppTextStyles.txtXs,
                ),
              )
            ],
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              
              BarChartData(
                
                borderData: FlBorderData(show: false),
                maxY: 10,
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 8,
                        color: Colors.orange,
                        width: 20,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)
                        )
                      )
                    ]
                  ),

                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 8,
                        color: Colors.orange,
                        width: 20,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)
                        )
                      )
                    ]
                  ),

                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 8,
                        color: Colors.orange,
                        width: 20,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)
                        )
                      )
                    ]
                  ),

                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 8,
                        color: Colors.orange,
                        width: 20,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)
                        )
                      )
                    ]
                  ),
                ],
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = AppTextStyles.amountLabel;
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('Mon', style: style);
                            break;
                          case 1:
                            text = const Text('Tue', style: style);
                            break;
                          case 2:
                            text = const Text('Wed', style: style);
                            break;
                          case 3:
                            text = const Text('Thu', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          meta: TitleMeta(
                            axisSide: meta.axisSide,
                            appliedInterval: 12,
                            axisPosition: 10,
                            formattedValue: String.fromEnvironment(""),
                            max: 5,
                            min: 1,
                            parentAxisSize: 10,
                            rotationQuarterTurns: 0,
                            sideTitles: SideTitles(

                            )
                          ),
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false
                    )
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false
                    )
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false
                    )
                  ),
                ),
                gridData: FlGridData(
                  show: false
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}