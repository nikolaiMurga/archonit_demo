import 'package:archonit_demo/domain/mixins/snack_bar_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/helpers/loading_indicator.dart';
import 'bloc/home_cubit.dart';
import 'widgets/currency_card.dart';
import 'widgets/empty_state_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SnackBarMixin {
  late final HomeCubit _homeCubit = context.read<HomeCubit>();
  final _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_fetchPage);
    super.initState();
  }

  void _resetController() {
    setState(() {
      if (_controller.hasClients) _controller.jumpTo(0);
    });
  }

  // infinity scroll method
  void _fetchPage() {
    final endOfPage = _controller.position.pixels == _controller.position.maxScrollExtent;
    if (endOfPage) {
      _homeCubit.getCurrencies(isScroll: true);
    }
  }

  // refresh method
  void _reloadList() {
    _resetController();
    _homeCubit.getCurrencies(isReload: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) showSnackBar(context, state.error);
        },
        buildWhen: (context, state) {
          return state is HomeSucceed || state is HomeLoading;
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const LoadingIndicator(width: double.maxFinite);
          }
          if (state is HomeSucceed) {
            return RefreshIndicator(
              onRefresh: () async => _reloadList(),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: _controller,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                itemCount: state.currenciesList.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.currenciesList.length) {
                    return CurrencyCard(currencyModel: state.currenciesList[index]);
                  } else if (state.isLastPage) {
                    return const SizedBox.shrink();
                  } else {
                    return const LoadingIndicator(height: 89, width: double.maxFinite);
                  }
                },
              ),
            );
          }
          if (state is HomeEmpty) return const EmptyStateWidget();
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
