<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Properties" %>			
<%@ page import="com.photon.phresco.configuration.ConfigReader" %>
<%@ page import="com.photon.phresco.configuration.Configuration" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>E-Shop | Phresco</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="images/favicon.ico">
        <meta charset="utf-8">
        <meta name="viewport" content="user-scalable=0, width=device-width, minimum-scale=1.0, maximum-scale=1.0">

        <!-- Linking styles -->
        <link rel="stylesheet" href="css/eshop/bootstrap.css" type="text/css" />
        <link rel="stylesheet" href="css/eshop/reset.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/eshop/phresco_style.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/eshop/mediaquery.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/eshop/mediaquery_ipad.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/eshop/nivo-slider.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/eshop/jquery.loadmask.css" type="text/css" />
        <!-- Linking scripts -->
        <script src="lib/jquery/jquery.js"></script>
		<script type="text/javascript" src="lib/xml2json/jquery.xml2json.js"></script>
        <script src="lib/others/jquery.nivo.slider.pack.js"></script>
        <script src="lib/others/jquery.jqzoom1.0.1.js"></script>
        <script src="js/eshop/main.js"></script>
        <script src="js/eshop/jquery.loadmask.js"></script>

        <script type="text/javascript" src="lib/yui/build/yui/yui-min.js"></script>
        <script src="lib/jsonpath/jsonpath.js"></script>
		
		<%
			String currentEnv = System.getProperty("SERVER_ENVIRONMENT");
			String path = getServletContext().getRealPath("/WEB-INF/resources/phresco-env-config.xml");
			File file = new File(path);
			ConfigReader reader = new ConfigReader(file);
			String configJson = reader.getConfigAsJSON(currentEnv, "WebService");
		%>
		
		<!-- EShop API JS -->
        <script type="text/javascript" src="js/eshop/controller/EShopAPI.js"></script>

        <!-- Widget JS -->
        <script type="text/javascript" src="js/eshop/widgets/PhrescoWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/NavigationWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/HeaderWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/CategoryWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/SliderWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/ProductsWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/ProductDetailsWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/TopSellsWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/FooterWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/MyCartWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/ShoppingCartWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/OrderFormWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/ProductOrderFormWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/OrderSuccess.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/AboutusWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/ContactusWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/LoginWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/RegisterWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/RegisterSuccessWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/LoginSuccessWidget.js"></script>
        <script type="text/javascript" src="js/eshop/widgets/OrderHistoryWidget.js"></script>


        <!-- Event JS -->
        <script type="text/javascript" src="js/eshop/events/PhrescoEvent.js"></script>
        <!--[if lt IE 9]>
        <script type="text/javascript" src="js/eshop/html5.js"></script>
        <![endif]-->
        
        
		
        <script type='text/javascript'>
	        $(document).ready(function () {
                $('div.menu_class').click(function () {
                    $('ul.the_menu').css('z-index:9999;');
                    $('ul.the_menu').slideToggle('medium');
                });

                $('#cancel').click(function() {
                    popup('none');
                    //$('body').css('overflow','scroll');
                });

                $('#close').click(function() {
                    popup('none');
                    //$('body').css('overflow','scroll');
                });

                $('#ok').click(function() {
                    //$('#deleteObjects').submit();
                    alert("Okay cicked");
                });
            });

            function popup(enableProp) {
                $('#registerpopup').css("display", enableProp);
                $('#popup').css("display", enableProp);
                $('.wel_come').css("display", enableProp);
            }

        </script>

        <script type="text/javascript">
            YUI().use('node', 'widget', 'eshopAPI', 'phrescoWidget', 'phrescoEvent', 'navigationWidget',
                    'headerWidget', 'categoryWidget', 'sliderWidget', 'productsWidget','productDetailsWidget', 'topSellsWidget',
                    'footerWidget', 'myCartWidget', 'shoppingCartWidget', 'orderFormWidget', 'orderSuccess', 'productOrderFormWidget',
                    'aboutusWidget', 'contactusWidget', 'inputex-yui3', 'loginWidget', 'registerWidget', 'registerSuccessWidget',
                    'loginSuccessWidget', 'orderHistoryWidget', function(Y) {

                Y.on("domready", function () {
					var configJson = '<%= configJson %>';
					console.info('configJson = ' , configJson);
                    var eshopAPI = new Y.Phresco.EShopAPI($.parseJSON(configJson));

                    // instantiate NavigationWidget with the HTML
                    var navigationWidget = new Y.Phresco.NavigationWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#navigation",
                        apiReference : eshopAPI
                    });

                    // instantiate HeaderWidget with the HTML
                    var headerWidget = new Y.Phresco.HeaderWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#header",
                        apiReference : eshopAPI
                    });

                    // instantiate CategoryWidget with the HTML
                    var categoryWidget = new Y.Phresco.CategoryWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#submenu",
                        apiReference : eshopAPI
                    });

                    // instantiate SliderWidget with the HTML
                    var sliderWidget = new Y.Phresco.SliderWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#slider-wrapper",
                        apiReference : eshopAPI
                    });

                    // instantiate ProductsWidget with the HTML
                    var productsWidget = new Y.Phresco.ProductsWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#left",
                        apiReference : eshopAPI
                    });

                    // instantiate MyCartWidget with the HTML
                    var myCartWidget = new Y.Phresco.MyCartWidget ({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#cashbanner",
                        apiReference : eshopAPI
                    });

                    // instantiate TopSellsWidget with the HTML
                    var topSellsWidget = new Y.Phresco.TopSellsWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#right",
                        apiReference : eshopAPI
                    });

                    // instantiate FooterWidget with the HTML
                    var footerWidget = new Y.Phresco.FooterWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#privacy",
                        apiReference : eshopAPI
                    });

                    // instantiate ProductDetailsWidget with the HTML
                    var productDetailsWidget = new Y.Phresco.ProductDetailsWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#left",
                        apiReference : eshopAPI
                    });

                    // instantiate Shoppingcart with the HTML
                    var shoppingCartWidget = new Y.Phresco.ShoppingCartWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#left",
                        apiReference : eshopAPI
                    });
                     // instantiate ProductOrderFormWidget with the HTML
                    var productOrderFormWidget = new Y.Phresco.ProductOrderFormWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#left",
                        apiReference : eshopAPI
                    });

                     // instantiate OrderFormWidget with the HTML
                    var orderFormWidget = new Y.Phresco.OrderFormWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#left",
                        apiReference : eshopAPI
                    });

                    // instantiate OrderSuccess with the HTML
                    var orderSuccess = new Y.Phresco.OrderSuccess({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#left",
                        apiReference : eshopAPI
                    });

                    // instantiate OrderSuccess with the HTML
                    var aboutusWidget = new Y.Phresco.AboutusWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });

                    // instantiate contactusWidget with the HTML
                    var contactusWidget = new Y.Phresco.ContactusWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });

                    // instantiate contactusWidget with the HTML
                    var loginWidget = new Y.Phresco.LoginWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });

                    // instantiate contactusWidget with the HTML
                    var registerWidget = new Y.Phresco.RegisterWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });

                    // instantiate contactusWidget with the HTML
                    var registerSuccessWidget = new Y.Phresco.RegisterSuccessWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });

                    // instantiate contactusWidget with the HTML
                    var loginSuccessWidget = new Y.Phresco.LoginSuccessWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });
					
					 var orderHistoryWidget = new Y.Phresco.OrderHistoryWidget({
                        // place holder can be decided by specifying the attribute
                        targetNode : "#wrapper",
                        apiReference : eshopAPI
                    });

                    eshopAPI.getWsConfig();
                    eshopAPI.getConfig();
                    //eshopAPI.postReview(); // it will be removed in future
                    //eshopAPI.doRegister(); // it will be removed in future
                    eshopAPI.getCategories([categoryWidget]);
                    eshopAPI.getNewProducts([productsWidget]);
                    eshopAPI.getTopsellProducts([topSellsWidget]);

                    var slider = '#slider';

                    categoryWidget.hideWidgets([slider]);
                    categoryWidget.addSelectedListener([productsWidget]);


                    headerWidget.hideWidgets([slider]);
                    headerWidget.addSearchListener([productsWidget]);

                    productsWidget.hideWidgets([slider]);
                    productsWidget.addSelectedListener([productDetailsWidget]);
                    productsWidget.addCartListener([shoppingCartWidget]);

                    productDetailsWidget.addSelectedListener([productsWidget]);
                    shoppingCartWidget.addSelectedListener([productsWidget]);
                    shoppingCartWidget.addBackButtonListener([productDetailsWidget]);
                    productDetailsWidget.addReviewListener([productDetailsWidget]);
                    productDetailsWidget.addCartListener([shoppingCartWidget]);
                    shoppingCartWidget.addOrderListener([productOrderFormWidget]);

                    productOrderFormWidget.addOrderSubmitListener([orderFormWidget]);
                    productOrderFormWidget.addSelectedListener([productsWidget]);

                    orderFormWidget.addOrderListener([productOrderFormWidget]);
                    navigationWidget.addSelectedListener([productsWidget]);
					navigationWidget.addTestListener([navigationWidget,loginWidget,headerWidget]);
                    navigationWidget.addSelectedMenuListener([aboutusWidget, contactusWidget, registerWidget, loginWidget, orderHistoryWidget]);

                    navigationWidget.hideWidgets([slider]);
                    navigationWidget.showWidgets([slider]);


                    orderFormWidget.addOrderSuccessListener([orderSuccess]);
                    topSellsWidget.addCartListener([shoppingCartWidget]);
                    topSellsWidget.addSelectedListener([productDetailsWidget]);
                    topSellsWidget.hideWidgets([slider]);

                    loginWidget.addSelectedListener([loginSuccessWidget, navigationWidget,headerWidget]);
                    registerWidget.addSelectedListener([registerSuccessWidget]);					
					myCartWidget.addMycartviewListener([shoppingCartWidget]);
					productOrderFormWidget.addMycartviewListener([shoppingCartWidget]);

                    navigationWidget.renderUI();
                    headerWidget.renderUI();
                    sliderWidget.renderUI();
                    categoryWidget.renderUI();
                    productsWidget.renderUI();
                    myCartWidget.renderUI();
                    topSellsWidget.renderUI();
                    footerWidget.renderUI();
                    //loginWidget.renderUI();
                    //registerWidget.renderUI();
                    //productDetailsWidget.renderUI();
                    //orderFormWidget.renderUI();
                    //productOrderFormWidget.renderUI();
                });
            });
        </script>

    </head>

    <body>

        <div class="wel_come"></div>

        <div id="popup" class="loginModal" style="display:none;z-index:60000;">
        </div>

        <div id="registerpopup" class="loginModal" style="display:none;z-index:60000;">
        </div>
        <div class="container">

                <header><!-- Defining the header section of the page -->

                    <nav id="navigation"><!-- Defining the navigation menu -->
                    </nav>

                    <div id="header" class="top_head"><!-- Defining the top head element -->
                    </div>

                    <section id="submenu"><!-- Defining the sub menu -->
                    </section>

                </header>

                <div id="slider"><!-- Defining the main content section -->

                <!-- Promo slider -->
                    <section id="slider-wrapper">
                        <div id="slider" class="nivoSlider">
                           <img style="display: none;" src="images/eshop/promo1.jpg" alt="" title="#htmlcaption-1">
                            <img style="display: none;" src="images/eshop/promo2.jpg" alt="" title="#htmlcaption-2">

                        </div>
                    </section>
                </div>
                <div id="wrapper">
                </div>
                <div id="main"><!-- Defining submain content section -->
                    <section id="content"><!-- Defining the content section #2 -->

                        <div id="left">
                            &nbsp;
                        </div>
                        <div id="cashbanner">
                        <!--
                           <div class="cashbanner"><img src="images/eshop/cashdelivery_banner.png" width="181" height="70" alt="Cash delivery"></div>
                            <div class="mycartbg">
                                <div class="carticon"><img src="images/eshop/mycart_icon.png" width="28" height="21" alt="My Cart icon"> </div>
                                <div class="cartheader">My Cart </div>
                                <div class="split"></div>
                                <div class="mycarttext"> Item </div>
                                <div class="split2"></div>
                                <div class="mycarttext">Total Price </div>
                                <div class="clear"></div>
                                <div class="mycarttextvalue1"> 1000 </div>
                                <div class="mycarttextvalue2">100000 </div>
                            </div>
                            -->
                        </div>
                        <aside>
                            <div id="right">
                            </div>
                        </aside>
                </section>
            </div>

            <footer><!-- Defining the footer section of the page -->
                <div id="privacy">
                </div>
            </footer>
        </div>
    </body>
</html>
<script language="javascript">
   $("#wrapper").hide();
</script>