import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Caja De Ahorros'**
  String get appTitle;

  /// No description provided for @btnLogin.
  ///
  /// In es, this message translates to:
  /// **'Acceder'**
  String get btnLogin;

  /// No description provided for @btnForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu usuario o contraseña?'**
  String get btnForgotPassword;

  /// No description provided for @contactIcon.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contactIcon;

  /// No description provided for @tokenIcon.
  ///
  /// In es, this message translates to:
  /// **'Token'**
  String get tokenIcon;

  /// No description provided for @userIcon.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Usuario'**
  String get userIcon;

  /// No description provided for @formUsuario.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get formUsuario;

  /// No description provided for @formPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get formPassword;

  /// No description provided for @drawerTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Qué desea hacer?'**
  String get drawerTitle;

  /// No description provided for @contact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contact;

  /// No description provided for @token.
  ///
  /// In es, this message translates to:
  /// **'Token'**
  String get token;

  /// No description provided for @newUser.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Usuario'**
  String get newUser;

  /// No description provided for @drawerServicePlace.
  ///
  /// In es, this message translates to:
  /// **'Oficinas, cajeros y subagentes'**
  String get drawerServicePlace;

  /// No description provided for @drawerServiceMail.
  ///
  /// In es, this message translates to:
  /// **'Envíanos un correo'**
  String get drawerServiceMail;

  /// No description provided for @drawerService.
  ///
  /// In es, this message translates to:
  /// **'Caja en Línea'**
  String get drawerService;

  /// No description provided for @drawerServiceDocument.
  ///
  /// In es, this message translates to:
  /// **'Documentos legales'**
  String get drawerServiceDocument;

  /// No description provided for @drawerServicePromotion.
  ///
  /// In es, this message translates to:
  /// **'Promociones'**
  String get drawerServicePromotion;

  /// No description provided for @modalTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Como deseas contactarnos?'**
  String get modalTitle;

  /// No description provided for @modalCallCenter.
  ///
  /// In es, this message translates to:
  /// **'Call Center'**
  String get modalCallCenter;

  /// No description provided for @modalChatAndrea.
  ///
  /// In es, this message translates to:
  /// **'Chat con A.N.D.R.E.A'**
  String get modalChatAndrea;

  /// No description provided for @modalLossTarget.
  ///
  /// In es, this message translates to:
  /// **'Reportar tarjeta perdida'**
  String get modalLossTarget;

  /// No description provided for @modalInternationalContact.
  ///
  /// In es, this message translates to:
  /// **'Contactos internacionales'**
  String get modalInternationalContact;

  /// No description provided for @scanFaceTitle.
  ///
  /// In es, this message translates to:
  /// **'Captura tu rostro'**
  String get scanFaceTitle;

  /// No description provided for @scanFaceMessage.
  ///
  /// In es, this message translates to:
  /// **'Mira directamente a la cámara y ajusta tu rostro dentro del marco. Usa un lugar bien iluminado para obtener una captura precisa.'**
  String get scanFaceMessage;

  /// No description provided for @recomendation.
  ///
  /// In es, this message translates to:
  /// **'Recomendaciones'**
  String get recomendation;

  /// No description provided for @useLightPlace.
  ///
  /// In es, this message translates to:
  /// **'Utilice un lugar iluminado.'**
  String get useLightPlace;

  /// No description provided for @documentMustBeLegible.
  ///
  /// In es, this message translates to:
  /// **'El documento debe estar legible.'**
  String get documentMustBeLegible;

  /// No description provided for @noUsingCap.
  ///
  /// In es, this message translates to:
  /// **'No utilice sombreros ni gorras.'**
  String get noUsingCap;

  /// No description provided for @noUsingItems.
  ///
  /// In es, this message translates to:
  /// **'No utilizar accesorios que puedan obstruir la visualización del documento.'**
  String get noUsingItems;

  /// No description provided for @seeCamera.
  ///
  /// In es, this message translates to:
  /// **'Debe mirar directamente a la cámara.'**
  String get seeCamera;

  /// No description provided for @btnTakePhoto.
  ///
  /// In es, this message translates to:
  /// **'Tomar foto'**
  String get btnTakePhoto;

  /// No description provided for @btnCapture.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get btnCapture;

  /// No description provided for @scanDocumentTitle.
  ///
  /// In es, this message translates to:
  /// **'Captura tu cédula de identidad'**
  String get scanDocumentTitle;

  /// No description provided for @scanDocumentMessage.
  ///
  /// In es, this message translates to:
  /// **'Caja de Ahorros no establecerá contacto por ninguna vía para solicitar números de token bajo ningún concepto.'**
  String get scanDocumentMessage;

  /// No description provided for @welcomeUser.
  ///
  /// In es, this message translates to:
  /// **'Hola'**
  String get welcomeUser;

  /// No description provided for @sujestion.
  ///
  /// In es, this message translates to:
  /// **'Sugerencias para ti'**
  String get sujestion;

  /// No description provided for @requestProductTitle.
  ///
  /// In es, this message translates to:
  /// **'Solicitar productos'**
  String get requestProductTitle;

  /// No description provided for @quickAccesTitle.
  ///
  /// In es, this message translates to:
  /// **'Accesos rápidos'**
  String get quickAccesTitle;

  /// No description provided for @recargaTitle.
  ///
  /// In es, this message translates to:
  /// **'Recargar'**
  String get recargaTitle;

  /// No description provided for @transferenciaTitle.
  ///
  /// In es, this message translates to:
  /// **'Transferir'**
  String get transferenciaTitle;

  /// No description provided for @more.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get more;

  /// No description provided for @options.
  ///
  /// In es, this message translates to:
  /// **'opciones'**
  String get options;

  /// No description provided for @payService.
  ///
  /// In es, this message translates to:
  /// **'Pagar servicio'**
  String get payService;

  /// No description provided for @transfer.
  ///
  /// In es, this message translates to:
  /// **'Transferencia'**
  String get transfer;

  /// No description provided for @yappyTitle.
  ///
  /// In es, this message translates to:
  /// **'Yappy'**
  String get yappyTitle;

  /// No description provided for @kuaraTitle.
  ///
  /// In es, this message translates to:
  /// **'Kuara'**
  String get kuaraTitle;

  /// No description provided for @accountTabTitle.
  ///
  /// In es, this message translates to:
  /// **'Cuentas'**
  String get accountTabTitle;

  /// No description provided for @cardTabTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get cardTabTitle;

  /// No description provided for @prestamosTabTitle.
  ///
  /// In es, this message translates to:
  /// **'Préstamos'**
  String get prestamosTabTitle;

  /// No description provided for @depositosTabTitle.
  ///
  /// In es, this message translates to:
  /// **'Depósitos'**
  String get depositosTabTitle;

  /// No description provided for @account.
  ///
  /// In es, this message translates to:
  /// **'Cuenta'**
  String get account;

  /// No description provided for @creditCard.
  ///
  /// In es, this message translates to:
  /// **'Tarjeta de crédito'**
  String get creditCard;

  /// No description provided for @loan.
  ///
  /// In es, this message translates to:
  /// **'Préstamo'**
  String get loan;

  /// No description provided for @fixedTermDeposit.
  ///
  /// In es, this message translates to:
  /// **'Depósito a plazo fijo'**
  String get fixedTermDeposit;

  /// No description provided for @accountsGroupTitle.
  ///
  /// In es, this message translates to:
  /// **'Cuentas'**
  String get accountsGroupTitle;

  /// No description provided for @cardsGroupTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get cardsGroupTitle;

  /// No description provided for @loanGroupTitle.
  ///
  /// In es, this message translates to:
  /// **'Préstamos'**
  String get loanGroupTitle;

  /// No description provided for @fixedTermGroupTitle.
  ///
  /// In es, this message translates to:
  /// **'Depósitos a largo plazo'**
  String get fixedTermGroupTitle;

  /// No description provided for @requestTitle.
  ///
  /// In es, this message translates to:
  /// **'Solicitudes'**
  String get requestTitle;

  /// No description provided for @tabButtonRequestProduct.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get tabButtonRequestProduct;

  /// No description provided for @tabButtonRequestService.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get tabButtonRequestService;

  /// No description provided for @buttonRequest.
  ///
  /// In es, this message translates to:
  /// **'Nueva solicitud'**
  String get buttonRequest;

  /// No description provided for @requestCardItemTitle.
  ///
  /// In es, this message translates to:
  /// **'Solicitud'**
  String get requestCardItemTitle;

  /// No description provided for @requestCardItemNumberRequest.
  ///
  /// In es, this message translates to:
  /// **'No. Solicitud'**
  String get requestCardItemNumberRequest;

  /// No description provided for @requestCardItemDay.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get requestCardItemDay;

  /// No description provided for @tabItem.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get tabItem;

  /// No description provided for @tabItemProducts.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get tabItemProducts;

  /// No description provided for @tabItemRequest.
  ///
  /// In es, this message translates to:
  /// **'Solicitudes'**
  String get tabItemRequest;

  /// No description provided for @tabItemDrawer.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get tabItemDrawer;

  /// No description provided for @accountTitle.
  ///
  /// In es, this message translates to:
  /// **'Cuenta de ahorros'**
  String get accountTitle;

  /// No description provided for @productsSaldoTitle.
  ///
  /// In es, this message translates to:
  /// **'Saldo disponible'**
  String get productsSaldoTitle;

  /// No description provided for @fixedtermTitle.
  ///
  /// In es, this message translates to:
  /// **'Depósito a plazo fijo'**
  String get fixedtermTitle;

  /// No description provided for @cardTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarjeta de crédito'**
  String get cardTitle;

  /// No description provided for @loanTitle.
  ///
  /// In es, this message translates to:
  /// **'Préstamo'**
  String get loanTitle;

  /// No description provided for @mainDrawerDataTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis datos'**
  String get mainDrawerDataTitle;

  /// No description provided for @mainDraweToken.
  ///
  /// In es, this message translates to:
  /// **'Token'**
  String get mainDraweToken;

  /// No description provided for @mainDraweBiometry.
  ///
  /// In es, this message translates to:
  /// **'Biometría'**
  String get mainDraweBiometry;

  /// No description provided for @mainDraweLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get mainDraweLanguage;

  /// No description provided for @mainDraweCards.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get mainDraweCards;

  /// No description provided for @mainDrawePreferredAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuentas favoritas'**
  String get mainDrawePreferredAccount;

  /// No description provided for @mainDraweSettings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get mainDraweSettings;

  /// No description provided for @mainDraweQuickAccess.
  ///
  /// In es, this message translates to:
  /// **'Acceso rápido'**
  String get mainDraweQuickAccess;

  /// No description provided for @mainDraweFindUs.
  ///
  /// In es, this message translates to:
  /// **'Ubícanos'**
  String get mainDraweFindUs;

  /// No description provided for @mainDraweUserService.
  ///
  /// In es, this message translates to:
  /// **'Atención al cliente'**
  String get mainDraweUserService;

  /// No description provided for @mainDraweTermsConditions.
  ///
  /// In es, this message translates to:
  /// **'Términos y condiciones'**
  String get mainDraweTermsConditions;

  /// No description provided for @mainDrawerLogOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get mainDrawerLogOut;

  /// No description provided for @moneyBottomTransferTitle.
  ///
  /// In es, this message translates to:
  /// **'Transferir'**
  String get moneyBottomTransferTitle;

  /// No description provided for @moneyBottomTransferSubTitle.
  ///
  /// In es, this message translates to:
  /// **'Realiza transferencias seguras a tus cuentas y otros bancos.'**
  String get moneyBottomTransferSubTitle;

  /// No description provided for @moneyBottomTransferAccount.
  ///
  /// In es, this message translates to:
  /// **'Entre mis cuentas'**
  String get moneyBottomTransferAccount;

  /// No description provided for @moneyBottomTransferThirdPartyAccount.
  ///
  /// In es, this message translates to:
  /// **'Terceros en banco'**
  String get moneyBottomTransferThirdPartyAccount;

  /// No description provided for @moneyBottomTransferBanks.
  ///
  /// In es, this message translates to:
  /// **'Otros\nbancos'**
  String get moneyBottomTransferBanks;

  /// No description provided for @moneyBottomTransferInternational.
  ///
  /// In es, this message translates to:
  /// **'Internacional'**
  String get moneyBottomTransferInternational;

  /// No description provided for @moneyBottomTransferScheduled.
  ///
  /// In es, this message translates to:
  /// **'Programadas'**
  String get moneyBottomTransferScheduled;

  /// No description provided for @moneyBottomTransferYappy.
  ///
  /// In es, this message translates to:
  /// **'Yappy'**
  String get moneyBottomTransferYappy;

  /// No description provided for @moneyBottomTransferKuara.
  ///
  /// In es, this message translates to:
  /// **'Kuara'**
  String get moneyBottomTransferKuara;

  /// No description provided for @moneyBottomPayTitle.
  ///
  /// In es, this message translates to:
  /// **'Pagar'**
  String get moneyBottomPayTitle;

  /// No description provided for @moneyBottomPaySubTitle.
  ///
  /// In es, this message translates to:
  /// **'Realiza pago a productos, servicios y recargos.'**
  String get moneyBottomPaySubTitle;

  /// No description provided for @moneyBottomPayCard.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get moneyBottomPayCard;

  /// No description provided for @moneyBottomPayLoan.
  ///
  /// In es, this message translates to:
  /// **'Préstamos'**
  String get moneyBottomPayLoan;

  /// No description provided for @moneyBottomPayService.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get moneyBottomPayService;

  /// No description provided for @moneyBottomPayrecharge.
  ///
  /// In es, this message translates to:
  /// **'Recargas'**
  String get moneyBottomPayrecharge;

  /// No description provided for @listProductsTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis productos'**
  String get listProductsTitle;

  /// No description provided for @listProductsAccountButtonPay.
  ///
  /// In es, this message translates to:
  /// **'Pagar'**
  String get listProductsAccountButtonPay;

  /// No description provided for @listProductsAccountButtonTransfer.
  ///
  /// In es, this message translates to:
  /// **'Transferir'**
  String get listProductsAccountButtonTransfer;

  /// No description provided for @listProductsCardButtonImportantDays.
  ///
  /// In es, this message translates to:
  /// **'Fechas importantes'**
  String get listProductsCardButtonImportantDays;

  /// No description provided for @listProductsCardButtonPay.
  ///
  /// In es, this message translates to:
  /// **'Pagar tarjeta'**
  String get listProductsCardButtonPay;

  /// No description provided for @listProductsLoanButtonPay.
  ///
  /// In es, this message translates to:
  /// **'Pagar cuota'**
  String get listProductsLoanButtonPay;

  /// No description provided for @listProductsButton.
  ///
  /// In es, this message translates to:
  /// **'Solicitar productos'**
  String get listProductsButton;

  /// No description provided for @productDetailAvailable.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get productDetailAvailable;

  /// No description provided for @productDetailAverage.
  ///
  /// In es, this message translates to:
  /// **'Consumo promedio mensual'**
  String get productDetailAverage;

  /// No description provided for @productDetailHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial de transacciones'**
  String get productDetailHistory;

  /// No description provided for @productDetailMoreButton.
  ///
  /// In es, this message translates to:
  /// **'Ver más'**
  String get productDetailMoreButton;

  /// No description provided for @productDetailProccesTransactions.
  ///
  /// In es, this message translates to:
  /// **'Transacciones en proceso'**
  String get productDetailProccesTransactions;

  /// No description provided for @noRequests.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes solicitudes creadas'**
  String get noRequests;

  /// No description provided for @btnCardInfo.
  ///
  /// In es, this message translates to:
  /// **'Ver datos de\ntarjeta'**
  String get btnCardInfo;

  /// No description provided for @btnCardInfoLine.
  ///
  /// In es, this message translates to:
  /// **'Ver datos de tarjeta'**
  String get btnCardInfoLine;

  /// No description provided for @btnStatusCard.
  ///
  /// In es, this message translates to:
  /// **'Estado de\nCuenta'**
  String get btnStatusCard;

  /// No description provided for @btnCardPay.
  ///
  /// In es, this message translates to:
  /// **'Pagar\ntarjeta'**
  String get btnCardPay;

  /// No description provided for @btnCardBlock.
  ///
  /// In es, this message translates to:
  /// **'Bloquear\ntarjeta'**
  String get btnCardBlock;

  /// No description provided for @detailCardImportantDay.
  ///
  /// In es, this message translates to:
  /// **'Fechas importantes'**
  String get detailCardImportantDay;

  /// No description provided for @detailCardPoints.
  ///
  /// In es, this message translates to:
  /// **'Puntos generados'**
  String get detailCardPoints;

  /// No description provided for @detailCardPointsTitle.
  ///
  /// In es, this message translates to:
  /// **'puntos'**
  String get detailCardPointsTitle;

  /// No description provided for @availableBalance.
  ///
  /// In es, this message translates to:
  /// **'Saldo disponible'**
  String get availableBalance;

  /// No description provided for @available.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get available;

  /// No description provided for @debitCard.
  ///
  /// In es, this message translates to:
  /// **'Tarjeta de débito'**
  String get debitCard;

  /// No description provided for @card.
  ///
  /// In es, this message translates to:
  /// **'Tarjeta'**
  String get card;

  /// No description provided for @reference.
  ///
  /// In es, this message translates to:
  /// **'Referencia'**
  String get reference;

  /// No description provided for @balance.
  ///
  /// In es, this message translates to:
  /// **'Saldo'**
  String get balance;

  /// No description provided for @usedAmount.
  ///
  /// In es, this message translates to:
  /// **'Monto utilizado/saldado'**
  String get usedAmount;

  /// No description provided for @languajeDescription.
  ///
  /// In es, this message translates to:
  /// **'Caja de Ahorros utiliza Español como idioma predeterminado. Podra cambiarlo en cualquier momento según tu preferencia, y su elección se mantendrá en tus próximos inicios de sesión.'**
  String get languajeDescription;

  /// No description provided for @checkingAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta corriente'**
  String get checkingAccount;

  /// No description provided for @digitalAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta digital'**
  String get digitalAccount;

  /// No description provided for @aproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobado'**
  String get aproved;

  /// No description provided for @review.
  ///
  /// In es, this message translates to:
  /// **'Revisión'**
  String get review;

  /// No description provided for @pending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pending;

  /// No description provided for @servicePayment.
  ///
  /// In es, this message translates to:
  /// **'Servicio de Pago'**
  String get servicePayment;

  /// No description provided for @version.
  ///
  /// In es, this message translates to:
  /// **'Versión'**
  String get version;

  /// No description provided for @totalTransactionAmount.
  ///
  /// In es, this message translates to:
  /// **'Monto total de transacciones'**
  String get totalTransactionAmount;

  /// No description provided for @limit.
  ///
  /// In es, this message translates to:
  /// **'Límite'**
  String get limit;

  /// No description provided for @defaultKey.
  ///
  /// In es, this message translates to:
  /// **'Predeterminado'**
  String get defaultKey;

  /// No description provided for @products_load_error.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar\nlos productos en este momento.'**
  String get products_load_error;

  /// No description provided for @wrongLoginMessage.
  ///
  /// In es, this message translates to:
  /// **'Tus datos no coinciden, por favor verifica y vuelve a intentarlo. Si no recuerdas tu contraseña, ingresa en ¿Olvidaste tu contraseña?'**
  String get wrongLoginMessage;

  /// No description provided for @blockedUserMessage.
  ///
  /// In es, this message translates to:
  /// **'Tu usuario ha sido bloqueado.'**
  String get blockedUserMessage;

  /// No description provided for @defaultLoginMessageError.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error, por favor intenta de nuevo.'**
  String get defaultLoginMessageError;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @productTransferDestination.
  ///
  /// In es, this message translates to:
  /// **'Selección producto destino'**
  String get productTransferDestination;

  /// No description provided for @productTransferOrigin.
  ///
  /// In es, this message translates to:
  /// **'Selección producto origen'**
  String get productTransferOrigin;

  /// No description provided for @productTransferButton.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get productTransferButton;

  /// No description provided for @loanShare.
  ///
  /// In es, this message translates to:
  /// **'Cuota'**
  String get loanShare;

  /// No description provided for @loanArrears.
  ///
  /// In es, this message translates to:
  /// **'Monto en atraso'**
  String get loanArrears;

  /// No description provided for @loanPending.
  ///
  /// In es, this message translates to:
  /// **'Monto pendiente'**
  String get loanPending;

  /// No description provided for @loanOriginal.
  ///
  /// In es, this message translates to:
  /// **'Monto original'**
  String get loanOriginal;

  /// No description provided for @loanRate.
  ///
  /// In es, this message translates to:
  /// **'Tasa de interés anual'**
  String get loanRate;

  /// No description provided for @biometryText.
  ///
  /// In es, this message translates to:
  /// **'Ingresar con FaceID o Huella'**
  String get biometryText;

  /// No description provided for @tryAgain.
  ///
  /// In es, this message translates to:
  /// **'Volver a intentar'**
  String get tryAgain;

  /// No description provided for @noInternet.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión a internet'**
  String get noInternet;

  /// No description provided for @noInternetMessage.
  ///
  /// In es, this message translates to:
  /// **'No hay conexión a internet. Verifica tu WiFi ó datos móviles e inténtalo de nuevo.'**
  String get noInternetMessage;

  /// No description provided for @accountOrigin.
  ///
  /// In es, this message translates to:
  /// **'Cuenta origen:'**
  String get accountOrigin;

  /// No description provided for @selectAccountOrigin.
  ///
  /// In es, this message translates to:
  /// **'Seleccione producto origen'**
  String get selectAccountOrigin;

  /// No description provided for @destinationProduct.
  ///
  /// In es, this message translates to:
  /// **'Producto destino:'**
  String get destinationProduct;

  /// No description provided for @confirmTransfer.
  ///
  /// In es, this message translates to:
  /// **'Confirmar transferencia'**
  String get confirmTransfer;

  /// No description provided for @amountToTransfer.
  ///
  /// In es, this message translates to:
  /// **'Monto a transferir'**
  String get amountToTransfer;

  /// No description provided for @verifyTransactionData.
  ///
  /// In es, this message translates to:
  /// **'Verifique que todos los datos estén correctos antes de proceder con la transacción.'**
  String get verifyTransactionData;

  /// No description provided for @slideToSend.
  ///
  /// In es, this message translates to:
  /// **'Desliza para enviar'**
  String get slideToSend;

  /// No description provided for @transfersBetweenAccounts.
  ///
  /// In es, this message translates to:
  /// **'Transferencia entre cuentas'**
  String get transfersBetweenAccounts;

  /// No description provided for @selectDestinationProduct.
  ///
  /// In es, this message translates to:
  /// **'Seleccione producto destino'**
  String get selectDestinationProduct;

  /// No description provided for @amountLabel.
  ///
  /// In es, this message translates to:
  /// **'Monto:'**
  String get amountLabel;

  /// No description provided for @descriptionOptional.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get descriptionOptional;

  /// No description provided for @maxCharacters.
  ///
  /// In es, this message translates to:
  /// **'Max. 45 caracteres'**
  String get maxCharacters;

  /// No description provided for @scheduleTransaction.
  ///
  /// In es, this message translates to:
  /// **'Programar transacción'**
  String get scheduleTransaction;

  /// No description provided for @amountRequired.
  ///
  /// In es, this message translates to:
  /// **'Campo requerido'**
  String get amountRequired;

  /// No description provided for @amountInvalid.
  ///
  /// In es, this message translates to:
  /// **'Monto incorrecto'**
  String get amountInvalid;

  /// No description provided for @select.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar'**
  String get select;

  /// No description provided for @status.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get status;

  /// No description provided for @amountExceedsLimit.
  ///
  /// In es, this message translates to:
  /// **'El monto excede el límite disponible'**
  String get amountExceedsLimit;

  /// No description provided for @bankTransfer.
  ///
  /// In es, this message translates to:
  /// **'Transferencia a otros bancos'**
  String get bankTransfer;

  /// No description provided for @beneficiary.
  ///
  /// In es, this message translates to:
  /// **'Beneficiario'**
  String get beneficiary;

  /// No description provided for @selectBeneficiary.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar beneficiario'**
  String get selectBeneficiary;

  /// No description provided for @beneficiarySelection.
  ///
  /// In es, this message translates to:
  /// **'Selección beneficiario'**
  String get beneficiarySelection;

  /// No description provided for @search.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get search;

  /// No description provided for @newBeneficiary.
  ///
  /// In es, this message translates to:
  /// **'Nuevo beneficiario'**
  String get newBeneficiary;

  /// No description provided for @validating.
  ///
  /// In es, this message translates to:
  /// **'Validando'**
  String get validating;

  /// No description provided for @cardInfo.
  ///
  /// In es, this message translates to:
  /// **'Datos de tarjeta'**
  String get cardInfo;

  /// No description provided for @cardNumber.
  ///
  /// In es, this message translates to:
  /// **'Número de la tarjeta'**
  String get cardNumber;

  /// No description provided for @cardExpiration.
  ///
  /// In es, this message translates to:
  /// **'Fecha de expiración'**
  String get cardExpiration;

  /// No description provided for @cardCvv.
  ///
  /// In es, this message translates to:
  /// **'CVV'**
  String get cardCvv;

  /// No description provided for @cardName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la tarjeta'**
  String get cardName;

  /// No description provided for @cardPin.
  ///
  /// In es, this message translates to:
  /// **'Código PIN asignado'**
  String get cardPin;

  /// No description provided for @transferCompleted.
  ///
  /// In es, this message translates to:
  /// **'Transferencia completada'**
  String get transferCompleted;

  /// No description provided for @amountTransferred.
  ///
  /// In es, this message translates to:
  /// **'Monto transferido'**
  String get amountTransferred;

  /// No description provided for @from.
  ///
  /// In es, this message translates to:
  /// **'Desde'**
  String get from;

  /// No description provided for @destination.
  ///
  /// In es, this message translates to:
  /// **'Destino'**
  String get destination;

  /// No description provided for @comment.
  ///
  /// In es, this message translates to:
  /// **'Comentario'**
  String get comment;

  /// No description provided for @share.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get share;

  /// No description provided for @goToHome.
  ///
  /// In es, this message translates to:
  /// **'Ir a inicio'**
  String get goToHome;

  /// No description provided for @makingTransfer.
  ///
  /// In es, this message translates to:
  /// **'Realizando transferencia'**
  String get makingTransfer;

  /// No description provided for @requestDebitCard.
  ///
  /// In es, this message translates to:
  /// **'Solicitar tarjeta de débito'**
  String get requestDebitCard;

  /// No description provided for @faceIdLoginAlertTitle.
  ///
  /// In es, this message translates to:
  /// **'No tienes configurado Face ID o huella digital.'**
  String get faceIdLoginAlertTitle;

  /// No description provided for @faceIdLoginAlertDescription.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión con tus credenciales y activa esta opción en acceso rápido.'**
  String get faceIdLoginAlertDescription;

  /// No description provided for @faceidConfigurationScreenTitile.
  ///
  /// In es, this message translates to:
  /// **'Acceso rápido'**
  String get faceidConfigurationScreenTitile;

  /// No description provided for @faceidConfigurationScreenDescription.
  ///
  /// In es, this message translates to:
  /// **'Configura tu acceso y empieza a ingresar a la app de forma rápida y segura.'**
  String get faceidConfigurationScreenDescription;

  /// No description provided for @faceIdLabel.
  ///
  /// In es, this message translates to:
  /// **'Acceso con Face ID ó Huella'**
  String get faceIdLabel;

  /// No description provided for @faceIdDisclaimer.
  ///
  /// In es, this message translates to:
  /// **'En caso de que actives esta opción, todos los rostros o huellas registrados en tu dispositivo podrán acceder a la app y a tu información.'**
  String get faceIdDisclaimer;

  /// No description provided for @ready.
  ///
  /// In es, this message translates to:
  /// **'¡Listo!'**
  String get ready;

  /// No description provided for @faceIdCompleted.
  ///
  /// In es, this message translates to:
  /// **'Podrás usar tu rostro o huella la próxima vez que inicies sesión en la app.'**
  String get faceIdCompleted;

  /// No description provided for @tokenNumber.
  ///
  /// In es, this message translates to:
  /// **'Número de Token'**
  String get tokenNumber;

  /// No description provided for @generateNewToken.
  ///
  /// In es, this message translates to:
  /// **'Generar nuevo token'**
  String get generateNewToken;

  /// No description provided for @moreOptions.
  ///
  /// In es, this message translates to:
  /// **'Más opciones'**
  String get moreOptions;

  /// No description provided for @tokenNotice.
  ///
  /// In es, this message translates to:
  /// **'Caja de Ahorros no establecerá contacto por ninguna vía para solicitar números de token bajo ningún concepto.'**
  String get tokenNotice;

  /// No description provided for @tokenOptions.
  ///
  /// In es, this message translates to:
  /// **'Opciones del Token'**
  String get tokenOptions;

  /// No description provided for @serial.
  ///
  /// In es, this message translates to:
  /// **'Serial'**
  String get serial;

  /// No description provided for @expiration.
  ///
  /// In es, this message translates to:
  /// **'Expiración'**
  String get expiration;

  /// No description provided for @disableToken.
  ///
  /// In es, this message translates to:
  /// **'Desactivar'**
  String get disableToken;

  /// No description provided for @tokenWarning.
  ///
  /// In es, this message translates to:
  /// **'Los números de token le serán requeridos para la realización de algunas operaciones en los diferentes canales digitales de Caja de Ahorro. Nunca será contactado por nuestros agentes para que proporcione un número de token por ninguna via.​'**
  String get tokenWarning;

  /// No description provided for @fixedTermButtonRequest.
  ///
  /// In es, this message translates to:
  /// **'Solicitudes'**
  String get fixedTermButtonRequest;

  /// No description provided for @fixedTermButtonStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado de cuenta'**
  String get fixedTermButtonStatus;

  /// No description provided for @fixedTermMonto.
  ///
  /// In es, this message translates to:
  /// **'Monto'**
  String get fixedTermMonto;

  /// No description provided for @fixedTermAssociatedAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta asociada'**
  String get fixedTermAssociatedAccount;

  /// No description provided for @fixedTermStartDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de inicio'**
  String get fixedTermStartDate;

  /// No description provided for @fixedTermExpireDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de vencimiento'**
  String get fixedTermExpireDate;

  /// No description provided for @mainDrawerNotifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get mainDrawerNotifications;

  /// No description provided for @mainDrawerBeneficiary.
  ///
  /// In es, this message translates to:
  /// **'Beneficiarios'**
  String get mainDrawerBeneficiary;

  /// No description provided for @transactionsHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de transacciones'**
  String get transactionsHistoryTitle;

  /// No description provided for @filtersButton.
  ///
  /// In es, this message translates to:
  /// **'Filtros'**
  String get filtersButton;

  /// No description provided for @filtersDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get filtersDate;

  /// No description provided for @filtersRangePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Seleccione rango de fecha'**
  String get filtersRangePlaceholder;

  /// No description provided for @filtersLast3Months.
  ///
  /// In es, this message translates to:
  /// **'Últimos 3 meses'**
  String get filtersLast3Months;

  /// No description provided for @filtersLast6Months.
  ///
  /// In es, this message translates to:
  /// **'Últimos 6 meses'**
  String get filtersLast6Months;

  /// No description provided for @filtersAmount.
  ///
  /// In es, this message translates to:
  /// **'Monto'**
  String get filtersAmount;

  /// No description provided for @filtersFrom.
  ///
  /// In es, this message translates to:
  /// **'Desde'**
  String get filtersFrom;

  /// No description provided for @filtersTo.
  ///
  /// In es, this message translates to:
  /// **'Hasta'**
  String get filtersTo;

  /// No description provided for @filtersCurrency.
  ///
  /// In es, this message translates to:
  /// **'B/.'**
  String get filtersCurrency;

  /// No description provided for @filtersTransactionType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de transacción'**
  String get filtersTransactionType;

  /// No description provided for @filtersCredit.
  ///
  /// In es, this message translates to:
  /// **'Crédito'**
  String get filtersCredit;

  /// No description provided for @filtersDebit.
  ///
  /// In es, this message translates to:
  /// **'Débito'**
  String get filtersDebit;

  /// No description provided for @filtersClear.
  ///
  /// In es, this message translates to:
  /// **'Limpiar filtros'**
  String get filtersClear;

  /// No description provided for @filtersApply.
  ///
  /// In es, this message translates to:
  /// **'Aplicar filtros'**
  String get filtersApply;

  /// No description provided for @dialogSelectRange.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar rango de fecha'**
  String get dialogSelectRange;

  /// No description provided for @dialogStartDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de inicio'**
  String get dialogStartDate;

  /// No description provided for @dialogEndDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de fin'**
  String get dialogEndDate;

  /// No description provided for @dialogCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get dialogCancel;

  /// No description provided for @dialogAccept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get dialogAccept;

  /// No description provided for @errorInvalidDateFormat.
  ///
  /// In es, this message translates to:
  /// **'Fechas inválidas. Usa formato dd/mm/aaaa'**
  String get errorInvalidDateFormat;

  /// No description provided for @hintDateFormat.
  ///
  /// In es, this message translates to:
  /// **'dd/mm/aaaa'**
  String get hintDateFormat;

  /// No description provided for @alertLogOutAccept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get alertLogOutAccept;

  /// No description provided for @alertLogOutBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get alertLogOutBack;

  /// No description provided for @closeSession.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get closeSession;

  /// No description provided for @alertLogOutTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres cerrar sesión?'**
  String get alertLogOutTitle;

  /// No description provided for @alertLogOutSubTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión se cerrará y necesitarás iniciar sesión nuevamente para continuar.'**
  String get alertLogOutSubTitle;

  /// No description provided for @noResultsFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron resultados.'**
  String get noResultsFound;

  /// No description provided for @activateToken.
  ///
  /// In es, this message translates to:
  /// **'Activar token CA'**
  String get activateToken;

  /// No description provided for @activateTokenDescription.
  ///
  /// In es, this message translates to:
  /// **'Captura tu rostro para verificar tu identidad y continuar con el proceso de forma sencilla.'**
  String get activateTokenDescription;

  /// No description provided for @faceScreenTokenActivationScreenTerms.
  ///
  /// In es, this message translates to:
  /// **'Acepto los términos y condiciones'**
  String get faceScreenTokenActivationScreenTerms;

  /// No description provided for @faceScreenTokenActivationScreenData.
  ///
  /// In es, this message translates to:
  /// **'Acepto que se almacenen mis datos biométricos para validar mi identidad de forma rápida en otra ocasión.'**
  String get faceScreenTokenActivationScreenData;

  /// No description provided for @activateTokenButton.
  ///
  /// In es, this message translates to:
  /// **'Activar token'**
  String get activateTokenButton;

  /// No description provided for @createBeneficiary.
  ///
  /// In es, this message translates to:
  /// **'Nuevo beneficiario'**
  String get createBeneficiary;

  /// No description provided for @createBeneficiaryDropdownTitle.
  ///
  /// In es, this message translates to:
  /// **'Nombre del banco'**
  String get createBeneficiaryDropdownTitle;

  /// No description provided for @createBeneficiaryDropdownHint.
  ///
  /// In es, this message translates to:
  /// **'Seleccione banco'**
  String get createBeneficiaryDropdownHint;

  /// No description provided for @createBeneficiaryDropdownType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de producto'**
  String get createBeneficiaryDropdownType;

  /// No description provided for @createBeneficiaryDropdownSelectType.
  ///
  /// In es, this message translates to:
  /// **' Seleccione tipo de producto'**
  String get createBeneficiaryDropdownSelectType;

  /// No description provided for @activateTokenDisclaimer.
  ///
  /// In es, this message translates to:
  /// **'Activa Token Caja de Ahorros para poder\nacceder a tus finanzas y realizar transacciones\nde forma digital y segura.'**
  String get activateTokenDisclaimer;

  /// No description provided for @createBeneficiaryNoProduct.
  ///
  /// In es, this message translates to:
  /// **'Número de producto'**
  String get createBeneficiaryNoProduct;

  /// No description provided for @createBeneficiaryNameBeneficiary.
  ///
  /// In es, this message translates to:
  /// **'Nombre del beneficiario'**
  String get createBeneficiaryNameBeneficiary;

  /// No description provided for @createBeneficiaryMail.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get createBeneficiaryMail;

  /// No description provided for @createBeneficiaryoptional.
  ///
  /// In es, this message translates to:
  /// **'opcional'**
  String get createBeneficiaryoptional;

  /// No description provided for @registerDeviceAlertTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrar dispositivo'**
  String get registerDeviceAlertTitle;

  /// No description provided for @registerDeviceAlertDescription.
  ///
  /// In es, this message translates to:
  /// **'¿Deseas registrar este dispositivo como de confianza para facilitar futuros accesos?'**
  String get registerDeviceAlertDescription;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'Si'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @createBeneficiaryButton.
  ///
  /// In es, this message translates to:
  /// **'Guardar beneficiario'**
  String get createBeneficiaryButton;

  /// No description provided for @createBeneficiaryAlert.
  ///
  /// In es, this message translates to:
  /// **'¿Desea cancelar registro?'**
  String get createBeneficiaryAlert;

  /// No description provided for @interbankTransferAlertTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Desea cancelar la transferencia actual?'**
  String get interbankTransferAlertTitle;

  /// No description provided for @interbankTransferAlertSubTitle.
  ///
  /// In es, this message translates to:
  /// **'Al cancelar la transferencia, los cambios realizados no se guardarán.'**
  String get interbankTransferAlertSubTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
