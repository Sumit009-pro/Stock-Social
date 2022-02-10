import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class AddNewCreaditOrDebitCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewCreaditOrDebitCardState();
  }
}

class AddNewCreaditOrDebitCardState extends State<AddNewCreaditOrDebitCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          centerTitle: true,
          title: Text(
            'Add Card',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0XFFFFFFFF),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: (30 / 24),
              fontFamily: "Roboto",
            ),
          ),
          elevation: 0,
          actions: [
            new Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Color(0XFFE5E5E5),
                    ),
                    onPressed: () {}),
                new Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Color(0XFFFE99AC),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            new IconButton(
                icon: Icon(
                  Icons.mail,
                  color: Color(0XFFE5E5E5),
                  size: 22,
                ),
                onPressed: () {}),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[

              SizedBox(height: 32, ),

            /*  CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
              ),*/

              Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 16,left: 15,right: 15),
                  //  width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            blurRadius:4.0, // soften the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              -1.0, // Move to bottom 10 Vertically
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 10,left: 13,right: 15),
                          child: Text( 'Add New Debit/Credit Card',softWrap: true,
                              style: TextStyle(
                                color: Color(0XFFFF808080),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: (17 / 14),
                                fontFamily: "Roboto",
                              ),
                          ),
                        ),

                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Color(0XFFFE99AC),
                          cardNumberDecoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color(0XFFFE99AC) )
                            ),
                            hoverColor:Color(0XFFFE99AC) ,
                            fillColor: Color(0XFFFE99AC) ,
                            focusColor:  Color(0XFFFE99AC),
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: const InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color:Color(0XFFFE99AC) )
                            ),
                            hoverColor:Color(0XFFFE99AC) ,
                            fillColor: Color(0XFFFE99AC) ,
                            focusColor:  Color(0XFFFE99AC),
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: const InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color:Color(0XFFFE99AC) )
                            ),
                            hoverColor:Color(0XFFFE99AC) ,
                            fillColor: Color(0XFFFE99AC) ,
                            focusColor:  Color(0XFFFE99AC),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: const InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color:Color(0XFFFE99AC) )
                            ),
                            hoverColor:Color(0XFFFE99AC) ,
                            fillColor: Color(0XFFFE99AC) ,
                            focusColor:  Color(0XFFFE99AC),
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),


                        SizedBox(  height: 75, ),

                        MyMaterialButton(
                          tittle: 'Add New Card',
                          width: MediaQuery.of(context).size.width/5,
                          onTap: () {},
                        )

                      ],
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
