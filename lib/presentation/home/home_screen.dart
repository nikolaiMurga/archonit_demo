import 'package:archonit_demo/core/auto_router.dart';
import 'package:archonit_demo/domain/mixins/snack_bar_mixin.dart';
import 'package:archonit_demo/presentation/common/widgets/currency_card.dart';
import 'package:archonit_demo/presentation/common/widgets/loading_indicator.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:archonit_demo/presentation/common/widgets/empty_state_widget.dart';
import 'package:archonit_demo/resources/app_strings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _homeCubit.fetchPaginatedCurrencies();
    }
  }

  // refresh method
  void _reloadList() {
    _resetController();
    _homeCubit.initialFetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.currencies),
        actions: [IconButton(onPressed: () => context.router.push(const FavoritesRoute()), icon: const Icon(Icons.favorite))],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.hasError) {
            showSnackBar(context, state.errorMessage ?? AppStrings.noErrorMessage);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingIndicator(width: double.maxFinite);
          }
          if (state.currenciesList.isEmpty && !state.isLoading) return const EmptyStateWidget();
          return RefreshIndicator(
            onRefresh: () async => _reloadList(),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              controller: _controller,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemCount: state.currenciesList.length + 1,
              itemBuilder: (context, index) {
                if (index < state.currenciesList.length) {
                  return CurrencyCard(currency: state.currenciesList[index]);
                } else if (state.isLastPage) {
                  return const SizedBox.shrink();
                } else {
                  return const LoadingIndicator(height: 89, width: double.maxFinite);
                }
              },
            ),
          );
          // }

          // return const SizedBox.shrink();
        },
      ),
    );
  }
}
