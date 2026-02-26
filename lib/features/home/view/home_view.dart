import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';
import 'package:riverpod_app/core/constants/text_style.dart';
import 'package:riverpod_app/features/auth/login/controller/login_controller.dart';
import 'package:riverpod_app/features/auth/login/view/login_view.dart';
import 'package:riverpod_app/features/home/controller/daraz_listing_controller.dart';
import 'package:riverpod_app/features/home/widget/product_card.dart';
import '../widget/header_banner.dart';

const List<String> homeTabs = ['For You', 'Top Rated', 'Budget'];

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(loginControllerProvider.select((state) => state.isLoggedIn));
    final userProfile =
        ref.watch(loginControllerProvider.select((state) => state.userProfile));

    if (!isLoggedIn) {
      return const LoginView();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        color: AppColors.primary,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: AppColors.background,
            // 1. DefaultTabController binds the TabBar and TabBarView naturally
            child: DefaultTabController(
              length: homeTabs.length,
              child: EasyRefresh(
                header: const MaterialHeader(color: AppColors.primary),
                onRefresh: () async {
                  await ref.read(darazListingProvider.notifier).loadProducts();
                },
                // 2. NestedScrollView is the MASTER OWNER of the vertical scroll
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      // 3. OverlapAbsorber syncs the header scroll with the inner lists
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          pinned: true,
                          toolbarHeight:
                              0, // No extra space above TabBar when collapsed
                          expandedHeight:
                              200, // Must fit HeaderBanner (~170px content)
                          backgroundColor: AppColors.primary,
                          flexibleSpace: FlexibleSpaceBar(
                            background: HeaderBanner(user: userProfile),
                          ),
                          // 4. Native TabBar acts as the sticky header
                          bottom: TabBar(
                            indicatorColor: AppColors.background,
                            labelColor: AppColors.background,
                            unselectedLabelColor:
                                AppColors.background.withAlpha(153),
                            indicatorWeight: 3,
                            labelStyle: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.background,
                            ),
                            unselectedLabelStyle: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.background.withAlpha(153),
                            ),
                            tabs: homeTabs
                                .map((title) => Tab(text: title))
                                .toList(),
                          ),
                        ),
                      ),
                    ];
                  },
                  // 5. Native TabBarView handles horizontal swipe without scroll conflict
                  body: const TabBarView(
                    children: [
                      _ProductListTab(tabIndex: 0),
                      _ProductListTab(tabIndex: 1),
                      _ProductListTab(tabIndex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Inner Tab Widget to handle separate scroll states and filtering
class _ProductListTab extends ConsumerWidget {
  final int tabIndex;
  const _ProductListTab({required this.tabIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products =
        ref.watch(darazListingProvider.select((state) => state.products));
    final isLoading =
        ref.watch(darazListingProvider.select((state) => state.isLoading));
    final errorMessage =
        ref.watch(darazListingProvider.select((state) => state.errorMessage));

    // Filtering logic purely inside the tab to avoid full screen re-renders
    final allProducts = products;
    final filteredProducts = tabIndex == 1
        ? allProducts.where((p) => (p.rating ?? 0) >= 4.0).toList()
        : tabIndex == 2
            ? allProducts.where((p) => p.price < 50).toList()
            : allProducts;

    return CustomScrollView(
      // PageStorageKey ensures vertical scroll position is saved when switching tabs
      key: PageStorageKey<String>('tab_$tabIndex'),
      slivers: [
        // Injector pushes the list down so it's not hidden behind the pinned TabBar
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        if (isLoading)
          const SliverFillRemaining(
            child: Center(
                child: CircularProgressIndicator(color: AppColors.primary)),
          )
        else if (errorMessage != null)
          SliverFillRemaining(
            child: Center(child: Text('Error: $errorMessage')),
          )
        else if (filteredProducts.isEmpty)
          const SliverFillRemaining(
            child: Center(child: Text('No products found')),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    ProductCard(product: filteredProducts[index]),
                childCount: filteredProducts.length,
              ),
            ),
          ),
      ],
    );
  }
}
