import 'package:e_commerce_app/core/app_widgets/app_dialog.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          AppDialog.loadingdialog(context);
        } else if (state is LoginSuccess) {
          context.pushNamedAndRemoveUntil(Routes.navscreen, false);
        } else if (state is LoginError) {
          context.pop();
          AppDialog.error(context, message: state.message);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
