import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_social/bottombar/dashboard/category/category_details.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/categories_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_progress_indicator.dart';

class Category extends StatefulWidget {
  final List<Categories> categoriesData;
  final bool watchListSelected;
  final Function(bool) scrollScreen;
  const Category({Key? key,required this.categoriesData,required this.watchListSelected,required this.scrollScreen}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController=new ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            child:  ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount:widget.categoriesData.length>0  ? widget.categoriesData.length : 0,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                   return Padding(
                     padding: EdgeInsets.all(8),
                     child: Container(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [


                           Container(
                             margin: EdgeInsets.only(left: 10,bottom: 5),
                             child: Text("${widget.categoriesData[index].name}",style: TextStyle( color: Color(0XFFFFFFFF),
                                 fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Roboto"),),
                           ),

                           Container(
                               height: MediaQuery.of(context).size.height/2.5,
                               child: ListView.builder(
                                   shrinkWrap: true,
                                   scrollDirection: Axis.horizontal,
                                   itemCount:widget.categoriesData[index].subCategory.length>0
                                       ? widget.categoriesData[index].subCategory.length: 0,
                                   physics: AlwaysScrollableScrollPhysics(),
                                   itemBuilder: (context,subIndex) {
                                     return InkWell(
                                       splashColor: Colors.blue,
                                       onTap: (){
                                         print(widget.watchListSelected.toString());
                                         setState(() {
                                           widget.categoriesData[index].subCategory[subIndex].watchListed=widget.watchListSelected;
                                         });
                                         Navigator.push(context,CupertinoPageRoute(builder: (context) =>
                                             CategoryDetails(mainCategoryName:widget.categoriesData[index].name,
                                                 subCategoryData:widget.categoriesData[index].subCategory[subIndex])));
                                       },
                                       child:Container(
                                           child: Card(
                                             color: Color(0XFFEFF8FC),
                                             elevation: 5,
                                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                             child: Container(
                                               padding: EdgeInsets.all(10),
                                               width: MediaQuery.of(context).size.width/2,
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [

                                                   Container(
                                                     child: Text("${widget.categoriesData[index].subCategory[subIndex].name}",
                                                       style: TextStyle( color: Colors.grey,
                                                           fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
                                                   ),

                                                   Align(
                                                     alignment: Alignment.center,
                                                     child: Container(
                                                       margin: EdgeInsets.only(top: 5,bottom: 10),
                                                       child: CircleAvatar(
                                                         radius: 45,
                                                         backgroundColor: Colors.white,
                                                         child:widget.categoriesData[index].subCategory[subIndex].image!=""
                                                           ?CircleAvatar(
                                                           radius: 42,
                                                           backgroundColor: Colors.pink,
                                                           backgroundImage:NetworkImage("${widget.categoriesData[index].subCategory[subIndex].image}")
                                                         )
                                                         : CircleAvatar(
                                                             radius: 42,
                                                             backgroundColor: Colors.white,
                                                             backgroundImage:AssetImage("assets/images/default.jpg"),
                                                         ),
                                                       ),
                                                     ),
                                                   ),

                                                   Container(
                                                     child: Row(
                                                       children: [

                                                         Container(
                                                           child: Image.asset("assets/icons/engagement.png",width: MediaQuery.of(context).size.width/40,),
                                                         ),

                                                         Container(
                                                           width:MediaQuery.of(context).size.width/6.3,
                                                           margin: EdgeInsets.only(left: 5,right: 5),
                                                           child: Text("Engagement",
                                                             style: TextStyle( color: Colors.grey,
                                                                 fontSize: 10,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                                         ),

                                                         Container(
                                                           margin: EdgeInsets.only(right: 5),
                                                           child: MyProgressIndicator(progressColor:Colors.blue,backgroundColor:Colors.grey ,
                                                             value:3,activity: 1,
                                                             height: 4,width: MediaQuery.of(context).size.width/8,
                                                           ),
                                                         ),

                                                         Container(
                                                           child: Text("High",
                                                             style: TextStyle( color: Colors.grey,
                                                                 fontSize: 10,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                                         ),

                                                       ],
                                                     ),
                                                   ),

                                                   SizedBox(height: 10,),

                                                   Container(
                                                     child: Row(
                                                       children: [

                                                         Container(
                                                           child: Image.asset("assets/icons/post.png",width: MediaQuery.of(context).size.width/40,),
                                                         ),

                                                         Container(
                                                           width:MediaQuery.of(context).size.width/6.3,
                                                           margin: EdgeInsets.only(left: 5,right: 5),
                                                           child: Text("Total Post",
                                                             style: TextStyle( color: Colors.grey,
                                                                 fontSize: 10,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                                         ),

                                                         Container(
                                                           margin: EdgeInsets.only(right: 5),
                                                           child:MyProgressIndicator(progressColor:Colors.green,backgroundColor:Colors.grey ,
                                                              value:widget.categoriesData[index].subCategory[subIndex].postCount,activity: 2,
                                                             height: 4,width: MediaQuery.of(context).size.width/8,
                                                           ),
                                                         ),

                                                         Container(
                                                             child: Text("${NumberFormat.compactCurrency(
                                                               decimalDigits: widget.categoriesData[index].subCategory[subIndex].postCount.toString().length <3 ? 0 : 1,
                                                               symbol: '',).format(widget.categoriesData[index].subCategory[subIndex].postCount)}",
                                                               style: TextStyle( color: Colors.grey,
                                                                   fontSize: 10,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                                         ),

                                                       ],
                                                     ),
                                                   ),

                                                   SizedBox(height: 10,),

                                                   Container(
                                                     child: Row(
                                                       children: [

                                                         Container(
                                                           child: Image.asset("assets/icons/questions.png",width: MediaQuery.of(context).size.width/40,),
                                                         ),

                                                         Container(
                                                           width:MediaQuery.of(context).size.width/6.3,
                                                           margin: EdgeInsets.only(left: 5,right: 5),
                                                           child: Text("Questions",
                                                             style: TextStyle( color: Colors.grey,
                                                                 fontSize: 10,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                                         ),

                                                         Container(
                                                           margin: EdgeInsets.only(right: 5),
                                                           child:MyProgressIndicator(progressColor:Colors.orange,backgroundColor:Colors.grey ,
                                                             value:12,activity: 3,
                                                             height: 4,width: MediaQuery.of(context).size.width/8,
                                                           ),
                                                         ),

                                                         Container(
                                                           child: Text("12",
                                                             style: TextStyle( color: Colors.grey,
                                                                 fontSize: 10,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
                                                         ),

                                                       ],
                                                     ),
                                                   ),

                                                   SizedBox(height: 10,),

                                                  widget.watchListSelected || widget.categoriesData[index].subCategory[subIndex].watchListed==true
                                                   ?InkWell(
                                                    onTap: ()async{
                                                      showLoadingSpinner(context, "");
                                                      final response = await API.removeFromWatchList(
                                                          { "categoryId": widget.categoriesData[index].subCategory[subIndex].id,   }
                                                      );
                                                      hideLoadingSpinner(context);
                                                      if (response["STATUSCODE"] == 200) {
                                                        ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                        setState(() {
                                                          widget.categoriesData[index].subCategory[subIndex].watchListed=false;
                                                          if(widget.watchListSelected) widget.categoriesData.removeAt(index);
                                                        });
                                                      }
                                                      else  ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                    },
                                                     child: Container(
                                                      height: 40,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color(0XFFFE99AC),
                                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                                      ),
                                                      child: Container(
                                                        child:Text("Remove",
                                                          style: TextStyle( color: Colors.white,
                                                              fontSize: 10,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
                                                      )
                                                     ),
                                                   )
                                                   :InkWell(
                                                    onTap: ()async{
                                                      showLoadingSpinner(context, "Please wait...");
                                                      final response = await API.addToWatchList(
                                                          { "categoryId": widget.categoriesData[index].subCategory[subIndex].id,   }
                                                      );
                                                      hideLoadingSpinner(context);
                                                      if (response["STATUSCODE"] == 200) {
                                                                  ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                                  setState(() {
                                                                    widget.categoriesData[index].subCategory[subIndex].watchListed=true;
                                                                  });
                                                      }
                                                      else  ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                    },
                                                     child: Container(
                                                      height: 40,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey,width: 0.2),
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                          Container(
                                                            child: Icon(Icons.add,color: Colors.grey,size: 20,),
                                                          ),

                                                          Container(
                                                            child:Text("  Add to watchlist",
                                                              style: TextStyle( color: Colors.grey,
                                                                  fontSize: 10,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                   )

                                                 ],
                                               )
                                             ),

                                           )
                                       ),
                                     );

                                   }
                               ),
                           )


                         ],
                       )
                     )
                   );

              }
            )
    );
  }

  void _scrollListener(){

    if (scrollController!.position.pixels == scrollController!.position.minScrollExtent) {
      widget.scrollScreen(false);
    }
    else{
      if(widget.categoriesData.length>1)widget.scrollScreen(true);
    }

  }
}
