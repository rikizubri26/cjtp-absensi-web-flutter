library constants;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// SharedPreferences
const BOOL_FIRST_INSTALL = 'FIRST_INSTALL';
const ODOO_ACCESS_TOKEN = 'ODOO_ACCESS_TOKEN';
const GOOGLE_ACCESS_TOKEN = 'GOOGLE_ACCESS_TOKEN';
const UID = 'UID';
const BRANCH_ID = 'BRANCH_ID';
const BRANCH_NAME = 'BRANCH_NAME';
const EMPLOYEE_ID = 'EMPLOYEE_ID';
const NAME = 'AGENT_NAME';
const ROLE_ID = 'ROLE_ID';
const ROLE_NAME = 'ROLE_NAME';
const JOB_ID = 'JOB_ID';
const JOB_NAME = 'JOB_NAME';

// const HOME_URL = 'https://tunas.honda-ku.com';
// const DB_NAME = 'TunasHonda';
// const CLIENT_ID_GMAIL =
//     '688716427641-4p6p6crfm9otfggau0fregaae51s716s.apps.googleusercontent.com';

//const HOME_URL = 'http://192.168.100.9:8071';
//http://20.84.80.186:13001/
//hr_testing
//192.168.10.67

const HOME_URL = 'https://erp.ceriatambang.com';
const DB_NAME = 'CJTP2021';

// const HOME_URL = 'http://192.168.100.9:8071';
// const DB_NAME = 'cjtp';

//https://erp.ceriatambang.com
//CJTP2021

const CLIENT_ID_GMAIL ='805825788640-gigd9kjsgkqvf959v9m2jegpfqedsa0b.apps.googleusercontent.com';

const URL_SIGNIN = '/auth/get_tokens';


// local //// URL 192.168.10.67 5.5.5.4 192.168.43.238
// const HOME_URL = 'http://192.168.100.11:8069';
// const HOME_URL = 'http://192.168.10.132:8069';
// const DB_NAME = 'tunas_honda';
// const URL_SIGNIN = 'auth_oauth/signin';
// const CLIENT_ID_GMAIL = '907532798351-u7a0skehsekdteo2n6oaeamc2j0f1eba.apps.googleusercontent.com';

// const HOME_URL = 'http://5.5.5.4:8020';
// const DB_NAME = 'dms_apps';
// const CLIENT_ID_GMAIL = '907532798351-u7a0skehsekdteo2n6oaeamc2j0f1eba.apps.googleusercontent.com';

// const HOME_URL = 'https://teshoki.honda-ku.com';
// const DB_NAME = 'dms_close_062020';
// const CLIENT_ID_GMAIL =
//     '688716427641-4p6p6crfm9otfggau0fregaae51s716s.apps.googleusercontent.com';

const URL_OAUTH_SIGNIN = '/auth_oauth/signin_google';
const URL_OAUTH_SIGNIN_WEB = '/auth_oauth/signin_google_web';
const URL_OAUTH_SIGOUT = '/auth/delete_tokens';
const URL_VERSION = '/apps/version';

const API_GET_ABSENSI = '/api/cni/v1/get_absensi';
const API_POST_ABSENSI_MASUK = '/api/cni/v1/post_absen_masuk';
const API_POST_ABSENSI_KELUAR = '/api/cni/v1/post_absen_keluar';
const API_POST_ASSESSMENT = '/api/dms.assessment';

const double defaultMargin = 24;

Color mainColor = Color(0xFF007AFF);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFFBD460);
Color accentColor3 = Color(0xFFADADAD);

TextStyle blackTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle blueTextFont = GoogleFonts.poppins()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.poppins()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);
