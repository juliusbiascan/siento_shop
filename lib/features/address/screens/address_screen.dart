import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:siento_shop/main.dart';
import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/common/widgets/bottom_bar.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/common/widgets/custom_button.dart';
import 'package:siento_shop/common/widgets/custom_textfield.dart';
import 'package:siento_shop/features/address/widgets/delivery_product.dart';
import 'package:siento_shop/features/search_delegate/my_search_screen.dart';
import 'package:siento_shop/features/address/services/address_services.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController flatBuildingController = TextEditingController();

  int totalAmount = 0;
  int currentStep = 0;
  bool goToPayment = false;
  String addressToBeUsed = "";
  bool goToFinalPayment = false;
  List<PaymentItem> paymentItems = [];
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  List<String> checkoutSteps = ["Address", "Delivery", "Payment"];

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset("google_pay_config.json");
    paymentItems.add(
      PaymentItem(
        label: 'Total Amount',
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price,
      ),
    );

    super.initState();

    totalAmount = double.parse(widget.totalAmount).toInt();
  }

  @override
  void dispose() {
    areaController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    flatBuildingController.dispose();
    super.dispose();
  }

  void onGooglePayResult(paymentResult) {
    // implement google pay function
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: num.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isFormValid = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormValid) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
      } else {
        throw Exception("Please enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context: context, text: "Error in address module");
    }

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
      // print( s of user in provider ====> : ${Provider.of<UserProvider>(context, listen: false).user.address}");
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: num.parse(widget.totalAmount));
  }

  void deliverToThisAddress(String addressFromProvider) {
    addressToBeUsed = "";

    bool isFormValid = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormValid) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
        setState(() {
          goToPayment = true;
        });
      } else {
        throw Exception("Please enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      setState(() {
        goToPayment = true;
      });
    } else {
      showSnackBar(context: context, text: "Error in address module");
    }

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
      // print( s of user in provider ====> : ${Provider.of<UserProvider>(context, listen: false).user.address}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    var address = user.address;

    // var address = context.watch<UserProvider>().user.address;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: GlobalVariables.getAppBar(
          context: context,
          onClickSearchNavigateTo: const MySearchScreen(),
          title: "Checkout",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .02),
            child: Column(
              children: [
                SizedBox(
                  width: mq.width * .8,
                  height: mq.height * .06,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // left container
                          Container(
                            // alignment: Alignment.centerLeft,
                            height: mq.height * .004,
                            width: mq.width * .3,
                            color: goToPayment
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                          // right container
                          Container(
                            // alignment: Alignment.centerLeft,
                            height: mq.height * .004,
                            width: mq.width * .3,
                            color: goToFinalPayment
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: i == 0
                                    ? const BorderSide(width: 1.5)
                                    : goToPayment && i == 1
                                        ? const BorderSide(width: 1.5)
                                        : goToFinalPayment && i == 2
                                            ? const BorderSide(width: 1.5)
                                            : BorderSide.none,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(mq.height * .01),
                                // color: Colors.red,
                                alignment: Alignment.center,

                                child: Text(checkoutSteps[i]),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                goToPayment
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: mq.height * .02),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: const Text("Order Summary",
                                  style: TextStyle(fontSize: 20))),
                          SizedBox(height: mq.height * .02),
                          SizedBox(
                            height: mq.height * .55,
                            width: double.infinity,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(10),
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: user.cart.length,
                                itemBuilder: (context, index) {
                                  // return CartProdcut
                                  return DeliveryProduct(index: index);
                                }),
                          ),

                          //google pay
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Select payment method",
                                  style: GlobalVariables.appBarTextStyle),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(mq.width * .025),
                                  child: const Text(
                                    "GOOGLE PAY",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(height: mq.height * .025),
                              FutureBuilder<PaymentConfiguration>(
                                future: _googlePayConfigFuture,
                                builder: (context, snapshot) => snapshot.hasData
                                    ? GooglePayButton(
                                        onPressed: () {
                                          payPressed(address);
                                        },
                                        paymentConfiguration: snapshot.data!,
                                        paymentItems: paymentItems,
                                        type: GooglePayButtonType.buy,
                                        margin:
                                            const EdgeInsets.only(top: 15.0),
                                        onPaymentResult: onGooglePayResult,
                                        loadingIndicator: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : const SizedBox(
                                        child: Center(
                                            child: Text(
                                                "Snapshot does not have data")),
                                      ),
                              ),
                            ],
                          ),
                          CustomButton(
                              text: "Pay now",
                              onTap: () {
                                setState(() {
                                  goToFinalPayment = true;
                                });
                                try {
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Colors.black12, width: 4),
                                        ),
                                        actionsAlignment: MainAxisAlignment.end,
                                        // actionsPadding: EdgeInsets.only(right: 20, bottom: 20),
                                        title: Image.asset(
                                            "assets/images/successpayment.JPG",
                                            height: 150),
                                        content: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // with google fonts
                                              const Text(
                                                "Your order has been placed",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 18,
                                                    color: Colors.black87),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "Transaction ID : ${DateTime.now().millisecondsSinceEpoch}\nTime: ${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}"),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              payPressed(address);
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacementNamed(
                                                  context, BottomBar.routeName);
                                            },
                                            child: const Text("OK"),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error : $e")));
                                }
                              },
                              color: const Color.fromARGB(255, 108, 255, 255)),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Pick an address",
                              style: GlobalVariables.appBarTextStyle),
                          address.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(mq.width * .025),
                                    child: Text(
                                      "Delivery to : $address",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(mq.width * .025),
                                    child: const Text(
                                      "Delivery to : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                          SizedBox(height: mq.height * .025),
                          address.isNotEmpty
                              ? const Text(
                                  "OR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                )
                              : const Text("Please add an address first",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                          SizedBox(height: mq.height * .025),
                          Form(
                            key: _addressFormKey,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                    controller: flatBuildingController,
                                    hintText: "Flat, House No."),
                                SizedBox(height: mq.height * .01),
                                CustomTextField(
                                    controller: areaController,
                                    hintText: "Area, Street"),
                                SizedBox(height: mq.height * .01),
                                CustomTextField(
                                    controller: pincodeController,
                                    hintText: "Pincode",
                                    inputType: TextInputType.number),
                                SizedBox(height: mq.height * .01),
                                CustomTextField(
                                    controller: cityController,
                                    hintText: "Town/City"),
                                SizedBox(height: mq.height * .04),
                                CustomButton(
                                  text: "Deliver to this address",
                                  onTap: () {
                                    deliverToThisAddress(address);
                                    setState(() {
                                      goToPayment = true;
                                    });
                                  },
                                  color: Colors.amber[400],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
