import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/sign_in/domain/model/onboarding_page_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/scaffold_navigation_bottom_bar.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/animated_logo_matrix.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldNavigationBottomBar(
      hasAppBar: true,
      child: SizedBox(
        width: context.width,
        height: context.height,
        child: const SelectShoppingPolicy(),
      ),
    );
  }
}

final buyinPolicyProvider = StateProvider<bool>((ref) => false);

class SelectShoppingPolicy extends ConsumerStatefulWidget {
  const SelectShoppingPolicy({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectShoppingPolicyState();
}

class _SelectShoppingPolicyState extends ConsumerState<SelectShoppingPolicy> {
  int currentPage = 0;
  late final List<PageModel> pages;
  final pageController = PageController();
  PolicyType type = PolicyType.unknown;

  @override
  void initState() {
    super.initState();
    _setupPages();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _setupPages() {
    const page1 = PageModel(
        imageUrl: property,
        title: 'Property',
        description: 'Property is one of the hardest things to acquire, '
            'let us help you protect it.');
    const page2 = PageModel(
        imageUrl: life,
        title: 'Life',
        description: 'We know life can be a surprise, your '
            'loved ones will be grateful.');
    pages = [page1, page2];
  }

  @override
  Widget build(BuildContext context) {
    final buying = ref.watch(buyinPolicyProvider.state).state;
    return PageView.builder(
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return buying
            ? AnimatedLogoMatrix(type: type)
            : Container(
                height: context.height,
                width: context.width,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(
                  context.width * 0.025,
                  context.height * 0.07,
                  context.width * 0.025,
                  context.height * 0.028,
                ),
                child: SizedBox(
                  height: context.height,
                  child: Column(
                    children: [
                      SizedBox(
                        width: context.width * 0.6,
                        height: context.height * 0.34,
                        child: Image.asset(
                          pages[index].imageUrl,
                          errorBuilder: (context, obj, stackTrace) {
                            return const Placeholder();
                          },
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.046,
                      ),
                      Text(
                        pages[index].title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        height: context.height * 0.023,
                      ),
                      Text(
                        pages[index].description,
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: context.height * 0.023,
                      ),
                      Center(
                        child: SizedBox(
                          width: context.width * 0.437,
                          height: context.height * 0.07,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                type = index == 0
                                    ? PolicyType.property
                                    : PolicyType.life;
                              });
                              ref.read(buyinPolicyProvider.notifier).state =
                                  true;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: index == 0
                                  ? AppColors.property
                                  : AppColors.life,
                            ),
                            child: Text(
                              'BUY',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.023,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: context.width * 0.37,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: pages.asMap().keys.map(
                              (key) {
                                final pageIndex = key;
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: context.width * 0.014,
                                  ),
                                  width: context.height * 0.015,
                                  height: context.height * 0.015,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: pageIndex == currentPage
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.6),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
      itemCount: pages.length,
    );
  }
}
