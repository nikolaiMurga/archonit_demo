import 'package:archonit_demo/presentation/home_bloc/bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/helpers/loading_indicator.dart';
import 'widgets/empty_state_widget.dart';

class HomeBlocScreen extends StatefulWidget {
  const HomeBlocScreen({super.key});

  @override
  State<HomeBlocScreen> createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {
  late final HomeBlocCubit _homeBlocCubit = context.read<HomeBlocCubit>();
  final _controller = ScrollController();

  // refresh method
  void _reloadList() {
    // _resetController();
    // _categoriesDetailsCubit.searchPackagesAndSingleTests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBlocCubit, HomeBlocState>(
        listener: (context, state) {
          if (state is HomeBlocError) {} /*showErrorToast(context, state.error);*/
        },
        // buildWhen: (context, state) {
        //   return state is HomeBlocSucceed || state is HomeBlocLoading;
        // },
        builder: (context, state) {
          if (state is HomeBlocLoading) {
            return const LoadingIndicator(width: double.maxFinite);
          }
          if (state is HomeBlocSucceed) {
            return RefreshIndicator(
              // backgroundColor: AppColors.whiteCream,
              // color: AppColors.primaryColor,
              onRefresh: () async => _reloadList(),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: _controller,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                itemCount: state.currencyUiModelList.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.currencyUiModelList.length) {
                    return const Placeholder();
                  } else if (state.isLastPage) {
                    return const SizedBox.shrink();
                  } else {
                    return const LoadingIndicator(height: 89, width: double.maxFinite);
                  }
                },
              ),
            );
          }
          if (state is HomeBlocEmpty) return const EmptyStateWidget();
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
