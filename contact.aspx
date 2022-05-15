<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Contact.aspx.vb" Inherits="Contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Basic Page Needs 
========================================================= -->
    <title>Contact  |  Eveve - Reservation Systems</title>
    <meta charset="UTF-8">
    <meta name="description" content="Contact | Eveve - Reservation Systems, Business, ">
    <meta name="keywords" content="Business, ">
    <meta name="author" content="eveveadmin">

    <!--[if lt IE 9]>
	<script src="/web/20150528110835/http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

    <!-- Mobile Specific Metas & Favicons
========================================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <!-- WordPress Stuff
========================================================= -->

    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans%3A300italic%2C400italic%2C600italic%2C300%2C400%2C600&amp;subset=latin%2Clatin-ext&amp;ver=3.9.1' type='text/css' media='all' />

    <style type='text/css'>
        .tp-caption a {
            color: #ff7302;
            text-shadow: none;
            -webkit-transition: all 0.2s ease-out;
            -moz-transition: all 0.2s ease-out;
            -o-transition: all 0.2s ease-out;
            -ms-transition: all 0.2s ease-out;
        }

            .tp-caption a:hover {
                color: #ffa902;
            }
    </style>

    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans:100,100italic,200,200italic,300,300italic,400,400italic,600,600italic,700,700italic,800,800italic&amp;subset=latin,latin-ext,cyrillic,cyrillic-ext,greek-ext,greek,vietnamese' type='text/css' media='all' />



    <meta name="generator" content="WordPress 3.9.1" />

    <!-- This site is powered by Tweet, Like, Plusone and Share Plugin - /web/20150528110835/http://techxt.com/tweet-like-google-1-and-share-plugin-wordpress/ -->
    <meta property="og:type" content="article" />
    <meta property="og:title" content="Contact" />
    <meta property="og:url" content="https://www.eveve.com/contact/" />
    <meta property="og:site_name" content="Eveve" />
    <meta property="og:description" content="Contact" />
    <!--[if lt IE 9]>
	  <script src="/web/20150528110835/http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->


    <!-- Custom CSS Codes
========================================================= -->
    <style type="text/css">
        body {
            font-family: Open Sans, Arial, Helvetica, sans-serif;
            font-size: 13px;
            line-height: 24px;
            font-weight: normal;
            color: #717375;
            text-transform: none;
        }

        input, select, textarea {
            width: 100%;
        }

        input[type="submit"] {
            width:158px;
            background-color: #43B4F9;
            color: #fff !important;
            -webkit-appearance: none;
            margin: 0;
            font-size: 11px;
            font-weight: 400px;
            line-height: 12px;
            padding: 13px 35px;
            display: inline;
            display: inline-block;
            letter-spacing: 0px;
            text-transform: uppercase;
            border: none;
            position: relative;
            cursor: pointer;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border-radius: 2px;
            margin-bottom: 3px;
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <asp:Label ID="LblStatus" Visible="false" runat="server" Text=""></asp:Label>
    <form id="FrmEveveContact" class="wpcf7-form" novalidate="novalidate" runat="server">

        <div class="row">
            <div class="one_half">
                <b><i>Please fill all the fields with the required information, all the fields are mandatory.</i></b>
                <br>
                <br>
                    <span class="wpcf7-form-control-wrap your-name">
                        <label>Name:</label><br />
                <input required type="text" name="your-name" runat="server" id="TxtName" size="40" class="wpcf7-form-control wpcf7-text wpcf7-validates-as-required input" aria-required="true" aria-invalid="false" />
                </span>
            </div>
            <div class="one_half">
                <span class="wpcf7-form-control-wrap restname">
                    <label>Restaurant Name:</label><br />
			<input required type="text" name="restname" runat="server" id="TxtRestName" size="40" class="wpcf7-form-control wpcf7-text wpcf7-validates-as-required input" aria-required="true" aria-invalid="false" />
                </span>
            </div>
        </div>
        <div class="row">
            <div class="one_half">
                <span class="wpcf7-form-control-wrap your-email">
                    <label>Email Address:</label><br />
			<input required type="text" name="your-email" runat="server" id="TxtEmail" size="40" class="wpcf7-form-control wpcf7-text wpcf7-email wpcf7-validates-as-required wpcf7-validates-as-email input" aria-required="true" aria-invalid="false" />
                </span>
            </div>
            <div class="one_half">
                <span class="wpcf7-form-control-wrap phonenumber">
                    <label>Telephone Number:</label><br />
			<input required type="text" name="phonenumber" runat="server" id="TxtPhone" size="40" class="wpcf7-form-control wpcf7-text wpcf7-tel wpcf7-validates-as-required wpcf7-validates-as-tel input" aria-required="true" aria-invalid="false" />
                </span>
            </div>
        </div>
        <p>
            <span class="wpcf7-form-control-wrap coutrylist">
                <label>Country:</label><br />
		<select required name="coutrylist" runat="server" id="DDLCountries" class="wpcf7-form-control wpcf7-select" aria-invalid="false">
            <option value="">Please select your Country</option>
            <option value="United Kingdom">United Kingdom</option>
            <option value="USA">USA</option>
            <option value="New Zealand">New Zealand</option>
            <option value="Australia">Australia</option>
            <option value="Spain">Spain</option>
            <option value="Greece">Greece</option>
            <option value="Chile">Chile</option>

            <option value="Afghanistan">Afghanistan</option>
            <option value="Albania">Albania</option>
            <option value="Algeria">Algeria</option>
            <option value="American Samoa">American Samoa</option>
            <option value="Andorra">Andorra</option>
            <option value="Angola">Angola</option>
            <option value="Anguilla">Anguilla</option>
            <option value="Antarctica">Antarctica</option>
            <option value="Antigua and Barbuda">Antigua and Barbuda</option>
            <option value="Argentina">Argentina</option>
            <option value="Armenia">Armenia</option>
            <option value="Arctic Ocean">Arctic Ocean</option>
            <option value="Aruba">Aruba</option>
            <option value="Ashmore and Cartier Islands">Ashmore and Cartier Islands</option>
            <option value="Atlantic Ocean">Atlantic Ocean</option>

            <option value="Austria">Austria</option>
            <option value="Azerbaijan">Azerbaijan</option>
            <option value="Bahamas">Bahamas</option>
            <option value="Bahrain">Bahrain</option>
            <option value="Baker Island">Baker Island</option>
            <option value="Bangladesh">Bangladesh</option>
            <option value="Barbados">Barbados</option>
            <option value="Bassas da India">Bassas da India</option>
            <option value="Belarus">Belarus</option>
            <option value="Belgium">Belgium</option>
            <option value="Belize">Belize</option>
            <option value="Benin">Benin</option>
            <option value="Bermuda">Bermuda</option>
            <option value="Bhutan">Bhutan</option>
            <option value="Bolivia">Bolivia</option>
            <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
            <option value="Botswana">Botswana</option>
            <option value="Bouvet Island">Bouvet Island</option>
            <option value="Brazil">Brazil</option>
            <option value="British Virgin Islands">British Virgin Islands</option>
            <option value="Brunei">Brunei</option>
            <option value="Bulgaria">Bulgaria</option>
            <option value="Burkina Faso">Burkina Faso</option>
            <option value="Burundi">Burundi</option>
            <option value="Cambodia">Cambodia</option>
            <option value="Cameroon">Cameroon</option>
            <option value="Canada">Canada</option>
            <option value="Cape Verde">Cape Verde</option>
            <option value="Cayman Islands">Cayman Islands</option>
            <option value="Central African Republic">Central African Republic</option>
            <option value="Chad">Chad</option>

            <option value="China">China</option>
            <option value="Christmas Island">Christmas Island</option>
            <option value="Clipperton Island">Clipperton Island</option>
            <option value="Cocos Islands">Cocos Islands</option>
            <option value="Colombia">Colombia</option>
            <option value="Comoros">Comoros</option>
            <option value="Cook Islands">Cook Islands</option>
            <option value="Coral Sea Islands">Coral Sea Islands</option>
            <option value="Costa Rica">Costa Rica</option>
            <option value="Cote d&#039;Ivoire">Cote d&#039;Ivoire</option>
            <option value="Croatia">Croatia</option>
            <option value="Cuba">Cuba</option>
            <option value="Cyprus">Cyprus</option>
            <option value="Czech Republic">Czech Republic</option>
            <option value="Denmark">Denmark</option>
            <option value="Democratic Republic of the Congo">Democratic Republic of the Congo</option>
            <option value="Djibouti">Djibouti</option>
            <option value="Dominica">Dominica</option>
            <option value="Dominican Republic">Dominican Republic</option>
            <option value="East Timor">East Timor</option>
            <option value="Ecuador">Ecuador</option>
            <option value="Egypt">Egypt</option>
            <option value="El Salvador">El Salvador</option>
            <option value="Equatorial Guinea">Equatorial Guinea</option>
            <option value="Eritrea">Eritrea</option>
            <option value="Estonia">Estonia</option>
            <option value="Ethiopia">Ethiopia</option>
            <option value="Europa Island">Europa Island</option>
            <option value="Falkland Islands (Islas Malvinas)">Falkland Islands (Islas Malvinas)</option>
            <option value="Faroe Islands">Faroe Islands</option>
            <option value="Fiji">Fiji</option>
            <option value="Finland">Finland</option>
            <option value="France">France</option>
            <option value="French Guiana">French Guiana</option>
            <option value="French Polynesia">French Polynesia</option>
            <option value="French Southern and Antarctic Lands">French Southern and Antarctic Lands</option>
            <option value="Gabon">Gabon</option>
            <option value="Gambia">Gambia</option>
            <option value="Gaza Strip">Gaza Strip</option>
            <option value="Georgia">Georgia</option>
            <option value="Germany">Germany</option>
            <option value="Ghana">Ghana</option>
            <option value="Gibraltar">Gibraltar</option>
            <option value="Glorioso Islands">Glorioso Islands</option>

            <option value="Greenland">Greenland</option>
            <option value="Grenada">Grenada</option>
            <option value="Guadeloupe">Guadeloupe</option>
            <option value="Guam">Guam</option>
            <option value="Guatemala">Guatemala</option>
            <option value="Guernsey">Guernsey</option>
            <option value="Guinea">Guinea</option>
            <option value="Guinea-Bissau">Guinea-Bissau</option>
            <option value="Guyana">Guyana</option>
            <option value="Haiti">Haiti</option>
            <option value="Heard Island and McDonald Islands">Heard Island and McDonald Islands</option>
            <option value="Honduras">Honduras</option>
            <option value="Hong Kong">Hong Kong</option>
            <option value="Howland Island">Howland Island</option>
            <option value="Hungary">Hungary</option>
            <option value="Iceland">Iceland</option>
            <option value="India">India</option>
            <option value="Indian Ocean">Indian Ocean</option>
            <option value="Indonesia">Indonesia</option>
            <option value="Iran">Iran</option>
            <option value="Iraq">Iraq</option>
            <option value="Ireland">Ireland</option>
            <option value="Isle of Man">Isle of Man</option>
            <option value="Israel">Israel</option>
            <option value="Italy">Italy</option>
            <option value="Jamaica">Jamaica</option>
            <option value="Jan Mayen">Jan Mayen</option>
            <option value="Japan">Japan</option>
            <option value="Jarvis Island">Jarvis Island</option>
            <option value="Jersey">Jersey</option>
            <option value="Johnston Atoll">Johnston Atoll</option>
            <option value="Jordan">Jordan</option>
            <option value="Juan de Nova Island">Juan de Nova Island</option>
            <option value="Kazakhstan">Kazakhstan</option>
            <option value="Kenya">Kenya</option>
            <option value="Kingman Reef">Kingman Reef</option>
            <option value="Kiribati">Kiribati</option>
            <option value="Kerguelen Archipelago">Kerguelen Archipelago</option>
            <option value="Kosovo">Kosovo</option>
            <option value="Kuwait">Kuwait</option>
            <option value="Kyrgyzstan">Kyrgyzstan</option>
            <option value="Laos">Laos</option>
            <option value="Latvia">Latvia</option>
            <option value="Lebanon">Lebanon</option>
            <option value="Lesotho">Lesotho</option>
            <option value="Liberia">Liberia</option>
            <option value="Libya">Libya</option>
            <option value="Liechtenstein">Liechtenstein</option>
            <option value="Lithuania">Lithuania</option>
            <option value="Luxembourg">Luxembourg</option>
            <option value="Macau">Macau</option>
            <option value="Macedonia">Macedonia</option>
            <option value="Madagascar">Madagascar</option>
            <option value="Malawi">Malawi</option>
            <option value="Malaysia">Malaysia</option>
            <option value="Maldives">Maldives</option>
            <option value="Mali">Mali</option>
            <option value="Malta">Malta</option>
            <option value="Marshall Islands">Marshall Islands</option>
            <option value="Martinique">Martinique</option>
            <option value="Mauritania">Mauritania</option>
            <option value="Mauritius">Mauritius</option>
            <option value="Mayotte">Mayotte</option>
            <option value="Mexico">Mexico</option>
            <option value="Micronesia">Micronesia</option>
            <option value="Midway Islands">Midway Islands</option>
            <option value="Moldova">Moldova</option>
            <option value="Monaco">Monaco</option>
            <option value="Mongolia">Mongolia</option>
            <option value="Montenegro">Montenegro</option>
            <option value="Montserrat">Montserrat</option>
            <option value="Morocco">Morocco</option>
            <option value="Mozambique">Mozambique</option>
            <option value="Myanmar">Myanmar</option>
            <option value="Namibia">Namibia</option>
            <option value="Nauru">Nauru</option>
            <option value="Navassa Island">Navassa Island</option>
            <option value="Nepal">Nepal</option>
            <option value="Netherlands">Netherlands</option>
            <option value="Netherlands Antilles">Netherlands Antilles</option>
            <option value="New Caledonia">New Caledonia</option>
            <option value="Nicaragua">Nicaragua</option>
            <option value="Niger">Niger</option>
            <option value="Nigeria">Nigeria</option>
            <option value="Niue">Niue</option>
            <option value="Norfolk Island">Norfolk Island</option>
            <option value="North Korea">North Korea</option>
            <option value="North Sea">North Sea</option>
            <option value="Northern Mariana Islands">Northern Mariana Islands</option>
            <option value="Norway">Norway</option>
            <option value="Oman">Oman</option>
            <option value="Pacific Ocean">Pacific Ocean</option>
            <option value="Pakistan">Pakistan</option>
            <option value="Palau">Palau</option>
            <option value="Palmyra Atoll">Palmyra Atoll</option>
            <option value="Panama">Panama</option>
            <option value="Papua New Guinea">Papua New Guinea</option>
            <option value="Paracel Islands">Paracel Islands</option>
            <option value="Paraguay">Paraguay</option>
            <option value="Peru">Peru</option>
            <option value="Philippines">Philippines</option>
            <option value="Pitcairn Islands">Pitcairn Islands</option>
            <option value="Poland">Poland</option>
            <option value="Portugal">Portugal</option>
            <option value="Puerto Rico">Puerto Rico</option>
            <option value="Qatar">Qatar</option>
            <option value="Reunion">Reunion</option>
            <option value="Republic of the Congo">Republic of the Congo</option>
            <option value="Romania">Romania</option>
            <option value="Russia">Russia</option>
            <option value="Rwanda">Rwanda</option>
            <option value="Saint Helena">Saint Helena</option>
            <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
            <option value="Saint Lucia">Saint Lucia</option>
            <option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
            <option value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>
            <option value="Samoa">Samoa</option>
            <option value="San Marino">San Marino</option>
            <option value="Sao Tome and Principe">Sao Tome and Principe</option>
            <option value="Saudi Arabia">Saudi Arabia</option>
            <option value="Senegal">Senegal</option>
            <option value="Serbia">Serbia</option>
            <option value="Seychelles">Seychelles</option>
            <option value="Sierra Leone">Sierra Leone</option>
            <option value="Singapore">Singapore</option>
            <option value="Slovakia">Slovakia</option>
            <option value="Slovenia">Slovenia</option>
            <option value="Solomon Islands">Solomon Islands</option>
            <option value="Somalia">Somalia</option>
            <option value="South Africa">South Africa</option>
            <option value="South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</option>
            <option value="South Korea">South Korea</option>

            <option value="Spratly Islands">Spratly Islands</option>
            <option value="Sri Lanka">Sri Lanka</option>
            <option value="Sudan">Sudan</option>
            <option value="Suriname">Suriname</option>
            <option value="Svalbard">Svalbard</option>
            <option value="Swaziland">Swaziland</option>
            <option value="Sweden">Sweden</option>
            <option value="Switzerland">Switzerland</option>
            <option value="Syria">Syria</option>
            <option value="Taiwan">Taiwan</option>
            <option value="Tajikistan">Tajikistan</option>
            <option value="Tanzania">Tanzania</option>
            <option value="Thailand">Thailand</option>
            <option value="Togo">Togo</option>
            <option value="Tokelau">Tokelau</option>
            <option value="Tonga">Tonga</option>
            <option value="Trinidad and Tobago">Trinidad and Tobago</option>
            <option value="Tromelin Island">Tromelin Island</option>
            <option value="Tunisia">Tunisia</option>
            <option value="Turkey">Turkey</option>
            <option value="Turkmenistan">Turkmenistan</option>
            <option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
            <option value="Tuvalu">Tuvalu</option>
            <option value="Uganda">Uganda</option>
            <option value="Ukraine">Ukraine</option>
            <option value="United Arab Emirates">United Arab Emirates</option>
            <option value="Uruguay">Uruguay</option>
            <option value="Uzbekistan">Uzbekistan</option>
            <option value="Vanuatu">Vanuatu</option>
            <option value="Venezuela">Venezuela</option>
            <option value="Viet Nam">Viet Nam</option>
            <option value="Virgin Islands">Virgin Islands</option>
            <option value="Wake Island">Wake Island</option>
            <option value="Wallis and Futuna">Wallis and Futuna</option>
            <option value="West Bank">West Bank</option>
            <option value="Western Sahara">Western Sahara</option>
            <option value="Yemen">Yemen</option>
            <option value="Yugoslavia">Yugoslavia</option>
            <option value="Zambia">Zambia</option>
            <option value="Zimbabwe">Zimbabwe</option>
        </select>
            </span>
        </p>
        <p>
            <span class="wpcf7-form-control-wrap your-subject">
                <label>Subject:</label><br />
	<input required type="text" name="your-subject" runat="server" id="TxtSubject" size="40" class="wpcf7-form-control wpcf7-text wpcf7-validates-as-required input" aria-required="true" aria-invalid="false" />
            </span>
        </p>
        <p>
            <span class="wpcf7-form-control-wrap your-message">
                <label>Message:</label><br />
	<textarea required name="your-message" runat="server" id="TxtMessage" cols="40" rows="10" class="wpcf7-form-control wpcf7-textarea input" aria-invalid="false"></textarea>
            </span>
        </p>
        <p>
            <%--<button type="submit" value="Send Message" class="wpcf7-form-control wpcf7-submit button medium">Send Message</button>--%>
            <asp:Button ID="BtnSend" runat="server" cssclass="wpcf7-form-control wpcf7-submit button medium" Text="Send Message" />
        </p>
        <div id="form-messages" class="wpcf7-response-output wpcf7-display-none"></div>
    </form>
</body>
</html>
