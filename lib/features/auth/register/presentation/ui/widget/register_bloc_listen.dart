import 'package:e_commerce_app/core/app_widgets/app_dialog.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBlocListen extends StatelessWidget {
  const RegisterBlocListen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoading) {
          AppDialog.loadingdialog(context);
        } else if (state is RegisterSuccess) {
          context.pushNamedAndRemoveUntil(Routes.loginscreen, false);
        } else if (state is RegisterError) {
          context.pop();
          AppDialog.error(context, message: state.message);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
