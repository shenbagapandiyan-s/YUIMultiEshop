/*
 * ###
 * PHR_HTML5YUIWidget
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
Event = YUI.event,
YUI.add("headerWidget", function(Y) {
    function HeaderWidget(config) {
        HeaderWidget.superclass.constructor.apply(this, arguments);
    }

    HeaderWidget.NAME = "headerWidget";

    HeaderWidget.ATTRS = {        
        color : {
            value : []
        },
        imgUrl : {
            value : []
        },
        hideWidgets: {
            value : []
        },
        onSearchListeners : {
            value : []
        }
    };

    Y.extend(HeaderWidget, Y.Phresco.PhrescoWidget, {
        initializer: function() {
        /*
         * initializer is part of the lifecycle introduced by 
         * the Base class. It is invoked during construction,
         * and can be used to setup instance specific state or publish events which
         * require special configuration (if they don't need custom configuration, 
         * events are published lazily only if there are subscribers).
         *
         * It does not need to invoke the superclass initializer. 
         * init() will call initializer() for all classes in the hierarchy.
         */
        },

        destructor : function() {
        /*
         * destructor is part of the lifecycle introduced by 
         * the Widget class. It is invoked during destruction,
         * and can be used to cleanup instance specific state.
         *
         * Anything under the boundingBox will be cleaned up by the Widget base class
         * We only need to clean up nodes/events attached outside of the bounding Box
         *
         * It does not need to invoke the superclass destructor. 
         * destroy() will call initializer() for all classes in the hierarchy.
         */
        },

        renderUI : function() {
            /*
         * renderUI is part of the lifecycle introduced by the
         * Widget class. Widget's renderer method invokes:
         *
         *     renderUI()
         *     bindUI()
         *     syncUI()
         *
         * renderUI is intended to be used by the Widget subclass
         * to create or insert new elements into the DOM. 
         */       
            this.createContent(this.getTargetNode());
        },

        bindUI : function() {
        },

        syncUI : function() {
        /*
         * syncUI is intended to be used by the Widget subclass to
         * update the UI to reflect the initial state of the widget,
         * after renderUI. From there, the event listeners we bound above
         * will take over.
         */
        },

        captureData : function(jsonData) {
            this.set("header", jsonData);
			this.createContent(this.getTargetNode());
          },

        createContent : function(targetNode) {
            targetNode.empty();

            var apiRef = this.get("apiReference");
		    var userId = 0;
				if(apiRef.get("userId")){
					userId = apiRef.get("userId");
				}
					
            var logoDiv = this.createElement('<div class="logo"/><!-- Defining the logo element -->');
            logoDiv.appendChild('<a href="#"><img src="images/eshop/logo.png" title="Phresco" alt="Phresco" /></a>');

            var searchSection = this.createElement('<section id="search"/>');

            var formElement = this.createElement('<form action="#" onsubmit="return false;" method="get">');
            formElement.appendChild('<input type="text" id="searchText" placeholder="Search" name="q">');
			
			
			var search = Y.Node.create('<input type="image" src="images/eshop/searchicon.png" width="20" height="20"  alt="searchicon" class="searchbtn"></a>');
            search.obj = this;
            Y.on('click' , this.searchProducts , search);
            formElement.appendChild(search);


            searchSection.appendChild(formElement);
			
			if(userId > 0){
				var userData = apiRef.get("userData");
				console.info('user data = ', userData);
					var statusMsg = this.createElement('<div class="login_txt">Welcome : '+userData.response.userName+' </div>');
					searchSection.appendChild(statusMsg);
			}
			
            targetNode.appendChild(logoDiv);
            targetNode.appendChild(searchSection);
            this.bindUI();
        },
        callback : function (id, data) {
            data = Y.JSON.parse(data.responseText);
            if(data["Errors : "] !== undefined){
                $('#modify_reservation_alert_msg').html('We were unable to locate your reservation. Please confirm the information you entered is correct.');
            }
            else if(data["Errors"] !== undefined){
				$('#modify_reservation_alert_msg').html('We were unable to connect server.');
            }
            else{ 
                window.location = "index.html";
            }
        },
        addSearchListener : function(widget) {
            var listeners = this.get("onSearchListeners");
            listeners = widget;
            this.set("widgets", widget);
            this.set("onSearchListeners", listeners);
        },
        searchProducts : function() {
            var widgetObj = this.obj;
            var searchCriteria = jQuery.trim($("#searchText").val());
            
            var hideWidgets = widgetObj.get("hideWidgets");
            for (var i = 0; i < hideWidgets.length; i++) {
                console.info('targetNode = ', hideWidgets[i]);
                $(hideWidgets[i]).hide();
            }

            var apiRef = widgetObj.get("apiReference");
            var listeners = widgetObj.get("onSearchListeners");

            for (var i = 0; i < listeners.length; i++) {
                var target = listeners[i].get("targetNode");
                $(target).mask("Loading...");
                apiRef.searchProducts(listeners[i], searchCriteria, listeners[i]);
            }
           
        },
        hideWidgets : function (hideWidgets) {
            this.set("hideWidgets", hideWidgets);
        }
    });

    Y.namespace("Phresco").HeaderWidget = HeaderWidget;
}, "3.3.0", {
    requires:["widget", "node", "substitute"]
});
