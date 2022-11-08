
## **Week 12 Final work**

## Assignment 1 

The app needs to connect the master policy current sum insured with what is happening with the child policies acquisition, in this case the create, update and delete methods should be reflected both in the master policy visualized by the user and the master policy in Firestore. 

Here are the final code snippet of the master policy model

```dart
///Constructor 
const MasterPolicyModel({
    required this.policyId,
    required this.type,
    required this.currentSI,
    required this.currentPremium,
    required this.insured,
    required this.name,
    this.status = PolicyStatus.pending,
    this.location,
    this.roomDescription,
    this.index,
    this.activeSince,
    this.expires,
    this.documentId,
    this.userPicture,
    this.age,
    this.beneficiary,
  });

  //Declared properties
  final String policyId;
  final num currentSI;
  final num currentPremium;
  final InsuredModel insured;
  final PolicyType type;
  final String? documentId;
  final String? userPicture;
  final DateTime? activeSince;
  final DateTime? expires;
  final String name;
  final PolicyStatus? status;
  final LocationModel? location;
  final RoomDescription? roomDescription;
  final BeneficiaryModel? beneficiary;
  final int? index;
  final BeneficiaryModel? age;

///How it transforms to Firestore object
Map<String, dynamic> toFirestore() {
    return {
      'policyId': policyId,
      'name': name,
      'currentSI': currentSI,
      'currentPremium': currentPremium,
      'insured': insured.toMap(),
      'status': status?.name ?? PolicyStatus.pending.name,
      'type': type.name,
      'location': location?.toMap(),
      'roomDescription': roomDescription?.toMap(),
      'beneficiary': beneficiary?.toMap(),
      'activeSince': activeSince?.millisecondsSinceEpoch,
      'expires': expires?.millisecondsSinceEpoch,
    };
  }
```

To check the code with all the models it can be found in [master_policy_model.dart](/capstone-project/accesible_insurance_capstone_project/lib/master_policy/domain/model/master_policy_model.dart)

___

## Assignment 2

To reduce calling the master policy from Firestore and instead update it through the stream process, the master policy is updated both locally and in Firestore each time a create, update or delete operation occurs with its child policies.

Here are the snippets that update the current sum insured and premium paid of a master policy.

```dart
//Creates a new demo Child Policy based on the premium paid and the sum insured
//calculated
void onCreateNewChildPolicy(
  WidgetRef ref, {
  required MasterPolicyModel masterPolicy,
  required num currentSI,
  required num currentPremium,
}) {
  //For the tech demo random values where used to simulate SI 
  //and premiums
  final randomPremiumPaid =
      double.parse((Random().nextDouble() * 20.99 + 3.99).toStringAsFixed(2));
  final randomSumInsured =
      double.parse((randomPremiumPaid * 140).toStringAsFixed(2));
  final nowDate = DateTime.now();
  final nextDate = nowDate.add(const Duration(days: 365));
  final childPolicy = ChildPolicyModel(
    masterPolicyId: masterPolicy.policyId,
    premiumPaid: randomPremiumPaid,
    sumInsured: randomSumInsured,
    activeSinceDate: DateTime.now(),
    expirationDate: DateTime(nextDate.year, nextDate.month, nextDate.day),
  );
  //Master Policy is immutable so a new instance must be created
  final newMasterPolicy = masterPolicy.copyWith(
    currentSI: currentSI + randomSumInsured,
    currentPremium: currentPremium + randomPremiumPaid,
  );
  //Updates local SQL child policy row
  ref.read(
      childPoliciesProviderInstance.childPolicyInsertProvider(childPolicy));
  //Updates Master Policy document in Firestore
  ref.read(
    MasterPoliciesProvider.instance.updateMasterPolicyProvider(
      newMasterPolicy,
    ),
  );
  //Updates the Master Policy that is selected with the new values
  ref
      .read(MasterPoliciesProvider.instance.selectedMasterPolicy.notifier)
      .state = newMasterPolicy;
}

//Deletes a Child Policy and updates the SI and premium of the master policy
Future<bool> onDeleteChildPolicy(
  WidgetRef ref, {
  required BuildContext context,
  required ChildPolicyModel childPolicy,
  required MasterPolicyModel masterPolicy,
}) async {
  final shouldDelete = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Center(
        child: Card(
          ...
        ),
      );
    },
  );
  //Only calls the provider to delete the child policy if the
  //dialog if the user confirms and there is an id.
  if (shouldDelete && childPolicy.childPolicyId != null) {
    ///Calculates new SI and premium
    final currentSI = masterPolicy.currentSI;
    final sumInsured = childPolicy.sumInsured;
    final currentPremium = masterPolicy.currentPremium;
    final premium = childPolicy.premiumPaid;
    final newCurrenSI = currentSI - sumInsured;
    final newPremium = currentPremium - premium;
    final newMasterPolicy = masterPolicy.copyWith(
      currentSI: newCurrenSI,
      currentPremium: newPremium,
    );
    //Updates Master Policy document in Firestore
    ref.read(
      MasterPoliciesProvider.instance.updateMasterPolicyProvider(
        newMasterPolicy,
      ),
    );
    //Deletes Child Policy from local SQL row
    ref.read(
      childPoliciesProviderInstance
          .childPolicyDeleteProvider(childPolicy.childPolicyId!),
    );
    //Updates the Master Policy that is selected with the new values
    ref
        .read(MasterPoliciesProvider.instance.selectedMasterPolicy.notifier)
        .state = newMasterPolicy;
  }
  return shouldDelete;
}

//Updates a Child Policy and updates the SI and premium of the master policy
Future<void> onUpdate(
  WidgetRef ref, {
  required BuildContext context,
  required ChildPolicyModel childPolicy,
  required MasterPolicyModel masterPolicy,
}) async {
  final newPremiumPaid = childPolicy.premiumPaid + 1.00;
  final newSumInsured = double.parse((newPremiumPaid * 140).toStringAsFixed(2));
  final shouldUpdate = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Center(
        child: Card(
          child: Container(
            ...
        ),
      );
    },
  );
  //Only calls the provider to update the child policy if the
  //user confirms
  if (shouldUpdate && childPolicy.childPolicyId != null) {
    ///Calculates new SI and premium
    final currentSI = masterPolicy.currentSI;
    final sumInsured = childPolicy.sumInsured;
    final currentPremium = masterPolicy.currentPremium;
    final premium = childPolicy.premiumPaid;
    final newCurrenSI = currentSI - sumInsured + newSumInsured;
    final newPremium = currentPremium - premium + newPremiumPaid;
    final newMasterPolicy = masterPolicy.copyWith(
      currentSI: newCurrenSI,
      currentPremium: newPremium,
    );
    //Updates Master Policy document in Firestore
    ref.read(
      MasterPoliciesProvider.instance.updateMasterPolicyProvider(
        newMasterPolicy,
      ),
    );
    //Updates the new Child Policy in local SQL row
    ref.read(
      childPoliciesProviderInstance.childPolicyUpdateProvider(
        childPolicy.copyWith(
          premiumPaid: newPremiumPaid,
          sumInsured: newSumInsured,
        ),
      ),
    );
    //Updates the Master Policy that is selected with the new values
    ref
        .read(MasterPoliciesProvider.instance.selectedMasterPolicy.notifier)
        .state = newMasterPolicy;
  }
```

To check the full code and the dialog widget check [child_policy_utils.dart](/capstone-project/accesible_insurance_capstone_project/lib/child_policy/utils/child_policy_utils.dart)

___

## Assignment 3

One main feature for the tech demo is the ability to acquire Master Policies either property or life, for this Riverpod FutureProvider was used for the creation of a Master Policy in Firestore, to accomplish this, the user clics on the purchase button and the screen changes and inside the screen the watch method is used to handle the triple pattern for the request (data, loading and error).

Here is the snippet on how the watch method is called once from the build method

```dart
@override
  Widget build(BuildContext context) {
    //Inside the build method watch is called to check for 
    //the status of the request to create a masterPolicy, 
    //which is passed through the widget parameter constructor
    //as final.
    return ref
        .watch(
      MasterPoliciesProvider.instance.createMasterPolicyProvider(masterPolicy),
    )
        .when(data: (_) {
            //Shows the success option if the creation is completed
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Success Buying the Policy!',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          TextButton(
            onPressed: () {
              controller.stop();
              ref.read(buyinPolicyProvider.notifier).state = false;
            },
            child: Text('ACCEPT'),
          ),
          SizedBox(
            height: context.height * 0.0233,
          ),
          Icon(
            Icons.check_circle_outline_rounded,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
        ],
      );
    }, error: (error, stackTrace) {
        //Shows the error option if the creation 
        //can't be completed
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error Buying the Policy',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          TextButton(
            onPressed: () {
              controller.stop();
              ref.read(buyinPolicyProvider.notifier).state = false;
            },
            child: Text('GO BACK'),
          ),
          SizedBox(
            height: context.height * 0.0233,
          ),
          Icon(
            Icons.check_circle_outline_rounded,
            color: Theme.of(context).errorColor,
            size: 48,
          ),
        ],
      );
    }, loading: () {
        //Shows a custom animation while the request is being
        //processed.
      return Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
          ),
          ..._buildMatrix(context),
        ],
      );
    });
  }
```

To check the code it can be found in [animated_logo_matrix.dart](/capstone-project/accesible_insurance_capstone_project/lib/policy_store/ui/widgets/animated_logo_matrix.dart)

___

## Final notes 

This project has taught me so much about Flutter, state management and different storage solutions, it has also improved my understanding of app architecture specially the usage of MVVM and how to handle asynchronous programming better. It has also allowed me to test out new ideas for an app which is always a plus :stuck_out_tongue_winking_eye:.

Here is a link to the final app with a narration, this video is of the day of graduation so I apologize in advance if any stutter or misspronunciation is made but I still hope you find my effort and frustration a bit funny. 

:rocket:[Blunge Tech Demo](https://drive.google.com/file/d/1-DmeUPWiPKQpyBhQ3PrChpmxIsRRJqhn/view?usp=share_link)