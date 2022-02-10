/*
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:stock_social/widgets/my_linear_progress_indicator.dart';

/// Sample linear data type.
class LinearSales {
  final String year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class MyPieChart extends StatefulWidget {
  const MyPieChart({Key? key}) : super(key: key);

  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createBearBullData() {
    final data = [
      new LinearSales("Bear", 70),
      new LinearSales("Bull", 30),
    ];

    var colors = [
      charts.Color(r: 0X72, g: 0X1B, b: 0XE0),
      charts.Color(r: 0X1E, g: 0XDC, b: 0XC5),
    ];

    return [
      charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) =>
            '${(row.sales * 100 / 100).round()}%',
        colorFn: (_, index) => colors[index!],
      )
    ];
  }

  static List<charts.Series<LinearSales, String>> _createBuySellData() {
    final data = [
      new LinearSales("Buy ", 25),
      new LinearSales("Sell ", 35),
      new LinearSales("Hold", 40),
    ];

    var colors = [
      charts.Color(r: 0XF8, g: 0XC7, b: 0X18),
      charts.Color(r: 0X8A, g: 0XDD, b: 0X1F),
      charts.Color(r: 0X37, g: 0X8E, b: 0XFF),
    ];

    return [
      charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) =>
            '${(row.sales * 100 / 100).round()}%',
        colorFn: (_, index) => colors[index!],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 180,
                  height: 180,
                  child: charts.PieChart(_createBearBullData(),
                      animate: true,
                      */
/*behaviors: [
                                                charts.DatumLegend<Object>(
                                                  position: charts
                                                      .BehaviorPosition.bottom,
                                                  outsideJustification: charts
                                                      .OutsideJustification
                                                      .middleDrawArea,
                                                  entryTextStyle:
                                                      charts.TextStyleSpec(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12),
                                                )
                                              ],
                                              *//*

                      defaultRenderer: charts.ArcRendererConfig<Object>(
                          //     arcRendererDecorators: [
                          //   new charts
                          //       .ArcLabelDecorator()
                          // ],
                          arcRatio: 0.4,
                          arcWidth: 60))),
              Padding(
                  padding: const EdgeInsets.only(left: 12, right: 10),
                  child: MyLinearProgressIndicator(
                    title: "Bear",
                    value: 0.3,
                    valueColor: Color(0xFF1EDCC5),
                    backgroundColor: Color(0xFFE5E5E5),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 12, right: 10, top: 8),
                  child: MyLinearProgressIndicator(
                    title: "Bull",
                    value: 0.7,
                    valueColor: Color(0xFF721BE0),
                    backgroundColor: Color(0xFFE5E5E5),
                  )),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 62.0, top: 14, bottom: 14),
                child: Column(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Color(0XFFB0B0B0),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: (17 / 12),
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '13,366',
                      style: TextStyle(
                        color: Color(0XFFB0B0B0),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: (22 / 18),
                        fontFamily: "Roboto",
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Bull',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: (17 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '1,806',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 1,
                    height: 35,
                    color: Color(0XFFE5E5E5),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Bear',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: (17 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '11,806',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 1,
            height: 370,
            color: Color(0XFFE5E5E5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 180,
                  height: 180,
                  child: charts.PieChart(_createBuySellData(),
                      animate: true,
                      // behaviors: [
                      //   charts.DatumLegend<Object>(
                      //     position: charts
                      //         .BehaviorPosition.bottom,
                      //     outsideJustification: charts
                      //         .OutsideJustification.end,
                      //     entryTextStyle:
                      //         charts.TextStyleSpec(
                      //             fontFamily: 'Roboto',
                      //             fontSize: 12),
                      //   )
                      // ],
                      defaultRenderer: charts.ArcRendererConfig<Object>(
                          arcRatio: 0.4, arcWidth: 60))),
              Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: MyLinearProgressIndicator(
                    title: "Buy more",
                    value: 0.4,
                    valueColor: Color(0xFF378EFF),
                    backgroundColor: Color(0xFFE5E5E5),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 7, right: 8, top: 7),
                  child: MyLinearProgressIndicator(
                    title: "Sell more",
                    value: 0.35,
                    valueColor: Color(0xFF8ADD1F),
                    backgroundColor: Color(0xFFE5E5E5),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 7, right: 10, top: 8),
                  child: MyLinearProgressIndicator(
                    title: "Hold",
                    value: 0.25,
                    valueColor: Color(0xFFF8C718),
                    backgroundColor: Color(0xFFE5E5E5),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 62.0, top: 14, bottom: 14),
                child: Column(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Color(0XFFB0B0B0),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: (17 / 12),
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '35,526',
                      style: TextStyle(
                        color: Color(0XFFB0B0B0),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: (22 / 18),
                        fontFamily: "Roboto",
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Buy',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: (17 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '1,406',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: 1,
                    height: 35,
                    color: Color(0XFFE5E5E5),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Sell',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: (17 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '1,160',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: 1,
                    height: 35,
                    color: Color(0XFFE5E5E5),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Hold',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: (17 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '960',
                        style: TextStyle(
                          color: Color(0XFFB0B0B0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 6,
                  ),
                ],
              )
            ],
          ),
        ]),
        SizedBox(
          height: 22,
        ),
      ],
    );
  }
}
*/
