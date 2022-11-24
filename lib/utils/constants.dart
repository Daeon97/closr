import 'package:flutter/material.dart';

const defaultScreenRoute = '/';
const selectCategoryScreenRoute = '/selectCategoryScreen';
const signInScreenRoute = '/signInScreen';
const signUpScreenRoute = '/signUpScreen';
const homeScreenRoute = '/homeScreen';
const childDetailsScreenRoute = '/childDetailsScreen';
const addModulesToChildScreenRoute = '/addModulesToChildScreen';
const quizzesScreenRoute = '/quizzesScreen';
const quizzesToQuestionsTransitionScreenRoute =
    '/quizzesToQuestionsTransitionScreen';
const questionsScreenRoute = '/questionsScreen';
const questionsToQuizzesTransitionScreenRoute =
    '/questionsToQuizzesTransitionScreen';

const childrenCollectionName = 'children';
const modulesCollectionName = 'modules';
const questionsCollectionName = 'questions';

const childrenField = 'children';
const nameField = 'name';
const ageField = 'age';
const classField = 'class';
const genderField = 'gender';
const descriptionField = 'description';
const questionField = 'question';
const optionsField = 'options';
const timestampField = 'timestamp';
const parentField = 'parent';
const answerField = 'answer';

const baseColor = Color(0xFF1A2B47);
const baseColorLight = Color(0xFF2D3D5E);
const scaffoldBackgroundColor = Color(0xFFF3EFF5);
const bodyLargeTextColor = baseColor;
const floatingActionButtonColor = Color(0xFFFF7900);
const addModulesToChildScreenButtonColor = Color(0xFFB9B9B9);

const mixingAnimationsCharacterRiveAsset =
    'assets/mixing_animations_character.riv';
const mixingAnimationsCharacterStateMachineName = 'State Machine 1';
const mixingAnimationsCharacterlevelSMIInput = 'level';

const animatedLoginCharacterRiveAsset = 'assets/animated_login_character.riv';
const animatedLoginCharacterStateMachineName = 'Login Machine';
const animatedLoginCharacterIsCheckingSMIInput = 'isChecking';
const animatedLoginCharacterNumLookSMIInput = 'numLook';
const animatedLoginCharacterIsHandsUpSMIInput = 'isHandsUp';
const animatedLoginCharacterTrigSuccessSMIInput = 'trigSuccess';
const animatedLoginCharacterTrigFailSMIInput = 'trigFail';

const manatimeLoginCharacterRiveAsset = 'assets/manatime_login_character.riv';

const avatarPrototypeCharacterRiveAsset =
    'assets/avatar_prototype_character.riv';
const avatarPrototypeCharacterStateMachineName = 'State Machine 1';
const avatarPrototypeCharacterBodiesSMIInput = 'Bodies';
const avatarPrototypeCharacterEyesSMIInput = 'Eyes';
const avatarPrototypeCharacterMouthSMIInput = 'Mouth';

const breathingBookCharacterRiveAsset = 'assets/breathing_book_character.riv';

const holdingPhoneOneImage = AssetImage(
  'assets/holding_phone_one.png',
);
const holdingPhoneTwoImage = AssetImage(
  'assets/holding_phone_two.png',
);

const extraLargePadding = 128.0;
const veryLargePadding = 64.0;
const largePadding = 32.0;
const padding = 16.0;
const smallPadding = 8.0;
const tinyPadding = 2.0;
const veryTinyPadding = 1.0;
const nil = 0.0;

const oneDotFive = 1.5;
const oneHundredDotNil = 100.0;
const eightHundredDotNil = 800.0;
const threeHundredDotNil = 300.0;
const fourHundredDotNil = 400.0;
const childrenCardHeight = 294.0;
const childrenCardWidth = 220.0;
const questionModulesHeight = 358.0;
const questionModulesWidth = 313.0;
const nilDotFiveFive = 0.55;
const nilDotThreeEight = 0.38;
const nilDotThreeThree = 0.33;
const nilDotTwoOne = 0.21;
const childDetailsFirstCardHeight = 227.36;
const childDetailsThirdCardHeight = 220.0;
const gridItemWidthAndHeight = 169.0;

const signInText = 'Sign in';
const emailText = 'Email';
const atSignText = '@';
const dotComText = '.com';
const emptyEmailFieldText = 'Email field cannot be empty';
const badEmailFormatText = 'Email is badly formatted';
const passwordText = 'Password';
const emptyPasswordFieldText = 'Password field cannot be empty';
const newToClosrQuestionText = 'New to Closr?';
const whiteSpaceText = ' ';
const emptyStringText = '';
const signUpText = 'Sign up';
const anErrorOccurredText = 'An error occurred. Please try again later';
const nameText = 'Name';
const emptyNameFieldText = 'Name field cannot be empty';
const emptyAgeFieldText = 'Age field cannot be empty';
const passwordIsTooShortText = 'Password is too short';
const alreadHaveAnAccountQuestionText = 'Already have an account?';
const selectACategoryText = 'Select a category';
const selectACategorySubText =
    'Please select a category that appropriately describes you';
const childText = 'Child';
const parentText = 'Parent';
const proceedText = 'Proceed';
const orText = 'Or';
const goBackToText = 'Go back to';
const selectCategoryText = 'Select category';
const helloText = 'Hello';
const youCanOnlyProceedAsAParentText =
    'You can only proceed as a parent at this time';
const newLineText = '\n';
const signOutQuestionText = 'Are you sure you want to sign out?';
const signOutText = 'Sign out';
const childrenText = 'Children';
const questionModulesText = 'Question Modules';
const ageText = 'Age';
const fillInChildsDetailsText = 'Fill in child\'s details';
const addChildText = 'Add Child';
const maleText = 'Male';
const femaleText = 'Female';
const genderText = 'Gender';
const classText = 'Class';
const emptyGenderFieldText = 'Please select at least one gender';
const emptyClassFieldText = 'Please select at least one class';
const jss1Text = 'JSS1';
const jss2Text = 'JSS2';
const jss3Text = 'JSS3';
const sss1Text = 'SSS1';
const sss2Text = 'SSS2';
const sss3Text = 'SSS3';
const clickTheText = 'Click the';
const toAddKidsToYourProfileText = 'To add kids to your profile';
const toAssignQuestionModulesToText = 'To assign question modules to';
const temperText = 'Temper';
const depressionText = 'Depression';
const complianceText = 'Compliance';
const empathyText = 'Empathy';
const adaptabilityText = 'Adaptability';
const temperTestText = 'Temper Test';
const depressionTestText = 'Depression Test';
const complianceTestText = 'Compliance Test';
const empathyTestText = 'Empathy Test';
const adaptabilityTestText = 'Adaptability Test';
const noModulesText = 'There are no modules at this time';
const addModuleText = 'Add module';
const differentHeroTagText = '<different FloatingActionButton tag>';
const anotherDifferentHeroTagText =
    '<another different FloatingActionButton tag>';
const historyText = 'History';
const connectWithAProfessionalText = 'Connect with a professional';
const moduleProgressText = 'Module Progress';
const modulesText = 'Modules';
const addToText = 'Add to';
const apostropheSText = '\'s';
const profileText = 'profile';
const takeQuizzesText = 'Take Quizzes';
const allAvailableQuestionsHaveBeenAddedToText =
    'All available questions have been added to';
const quizzesText = 'Quizzes';
const noAvailableQuizzesForText = 'There are no available quizzes for';
const percentText = '%';
const startText = 'Start';
const continueText = 'Continue';
const instructionText = 'Instruction';
const passYourText = 'Pass Your';
const passTheText = 'Pass The';
const phoneToText = 'Phone To';
const yourText = 'Your';
const noAvailableQuestionsForThisModuleText =
    'There are no available questions for this module';
const doneText = 'Done';
const quizDateFormatText = 'dd MMM y';

const waveHandSignEmoji = '👋';
