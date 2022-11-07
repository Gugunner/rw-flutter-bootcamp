import 'package:accesible_insurance_capstone_project/sign_in/domain/model/onboarding_page_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Points to the root reference

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final pageController = PageController();
  late final List<PageModel> pages;
  int currentPage = 0;

  @override
  void initState() {
    _setupPages();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _handleEndOnboarding() async {
    await SharedPreferencesProvider.instance.setIsOnboarding(false);
    ref.read(routeProvider.state).state = AppRoutes.home.route;
  }

  void _handleCurrentPageSelect(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _setupPages() {
    final page1 = PageModel(
      imageUrl: onboardingImages[0],
      description: EnglishCopies.page1Description,
    );
    final page2 = PageModel(
        imageUrl: onboardingImages[1],
        description: EnglishCopies.page2Description);
    final page3 = PageModel(
        imageUrl: onboardingImages[2],
        description: EnglishCopies.page3Description);
    pages = [page1, page2, page3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
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
                        Expanded(
                          child: SizedBox(
                            width: context.width * 0.81,
                            height: context.height * 0.563,
                            child: Image.asset(
                              pages[index].imageUrl,
                              errorBuilder: (context, obj, stackTrace) {
                                return const Placeholder();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: context.width * 0.75,
                          height: context.height * 0.063,
                          margin: EdgeInsets.symmetric(
                            vertical: context.height * 0.014,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: pages.asMap().keys.map(
                              (key) {
                                final pageIndex = key;
                                return GestureDetector(
                                  onTap: () {
                                    //Updates the currentPage widget state
                                    _handleCurrentPageSelect(pageIndex);

                                    ///Creates tha animation flow to move to
                                    ///the selected page
                                    pageController.animateToPage(
                                      currentPage,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  //Builds the navigator selector
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: context.width * 0.014,
                                    ),
                                    width: context.height * 0.035,
                                    height: context.height * 0.035,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,

                                      ///Changes the color of the navigator
                                      ///selector
                                      color: pageIndex == currentPage
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.9,
                          height: context.height * 0.101,
                          child: Text(
                            pages[index].description,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context).textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Builds the skip/finish button that navigates to Home ('/')
                        Container(
                          margin: EdgeInsets.only(
                            top: context.height * 0.028,
                          ),
                          width: context.width * 0.437,
                          height: context.height * 0.07,
                          child: ElevatedButton(
                            //Changes routeProvider and starts redirection to Home ('/')
                            onPressed: _handleEndOnboarding,
                            child: Text(
                              currentPage == pages.length - 1
                                  ? 'FINISH'
                                  : 'SKIP',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //A simple close icon button that navigates to Home ('/')
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: _handleEndOnboarding,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    iconSize: context.height * 0.042,
                  ),
                )
              ],
            );
          },
          itemCount: pages.length,
          controller: pageController,

          ///Makes sure the navigator selector changes color by updating
          ///currentPage state when swiping left or right
          onPageChanged: _handleCurrentPageSelect,
        ),
      ),
    );
  }
}
