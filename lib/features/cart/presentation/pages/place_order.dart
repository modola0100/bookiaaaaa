import 'package:bookia/components/app_bar/app_bar_widget.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custome_text_form_field.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/data/models/gov_list.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: BlocListener<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state is CartSuccessState) {
                  pop(context);
                  pushAndRemoveUntil(context, Routes.mainscreen, extra: 0);
                } else if (state is CartErrorState) {
                  pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Somthing wrong')));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Your Order', style: TextStyles.styleSize30()),
                  Gap(10),
                  Text('Don\'t worry! It occurs. Please enter the email\naddress linked with your account.', style: TextStyles.styleSize16(color: AppColors.greyColor)),
                  Gap(25),
                  CustomeTextFormField(
                    title: 'Full Name',
                    controller: cubit.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Full Name is Required';
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    title: 'Email',
                    controller: cubit.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    title: 'Address',
                    controller: cubit.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    title: 'Phone',
                    controller: cubit.phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone is required';
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    title: 'Governorate',
                    controller: cubit.govController,
                    suffix: const Icon(Icons.arrow_drop_down),
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.wightColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 27, bottom: 10, top: 36),
                                  child: Text('Select Governoarate', style: TextStyles.styleSize20()),
                                ),
                                Divider(),
                                Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                        leading: Icon(Icons.location_city),
                                        title: Text(governoarateList[index].governorateNameEn ?? ''),
                                        trailing: cubit.selcetGovId == governoarateList[index].id ? Icon(Icons.check) : null,
                                        onTap: () {
                                          pop(context);
                                          cubit.govController.text = governoarateList[index].governorateNameEn ?? '';
                                          cubit.selcetGovId = governoarateList[index].id ?? 0;
                                        },
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return Divider();
                                    },
                                    itemCount: governoarateList.length,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Governorate is required';
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Total:', style: TextStyles.styleSize20(color: AppColors.greyColor)),
                Spacer(),
                Text('₹${total}', style: TextStyles.styleSize20()),
              ],
            ),
            Gap(13),
            MainButton(
              title: 'Submit Order',
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.placeOrder();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
