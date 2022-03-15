Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7EE4DA4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 22:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352072AbiCOVtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352068AbiCOVts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:49:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F3A4B86F;
        Tue, 15 Mar 2022 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647380916; x=1678916916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FJ/nv0WorJTEuFcoXAmerkCZSn4K52bCi+GsEhA8ABw=;
  b=NwAh45oGX8UnMHhG9eAXJuPiFcUEPJIYUUGmcEeDAlbjByhk2QrgDCSS
   mfyKX9RUEwcyDqirlOwUi+On9I8ki0Zdn/l9AKtqfxjnPhYv3rUAfyqme
   mUgEpt36aYzNOuM20FQTlvc705no5lLhl88PteC6w452PA/zIzmuSU0PI
   f61/Kd0DkBBTP5FZJbDFADVKLJp42lKIf5aEpQydDxoCt0GtOHvYU25zI
   +gh8B1WeRPkLZ3gtZ+tWdRZhTwX6CM+1ZCMIcl8pLSsUqur/rYWeIDhAI
   5/ZXQF7ja8GQe2TNMEW2faVDJj9JAA0eHvfNpJQHmOSGffC8WBSD1AMOm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256381000"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256381000"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="557125767"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 14:48:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 14:48:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 14:48:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 14:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffr9IpDfJRU0jwDeWsN+KUxMA/e/Mn6eNCxloeUVRjneFDT4wCkFTUuVcm2832via9XiCFWNuZxrUxuOcxtu3z7DVqeykGqEbPfOGWAkWVUJbbsrfZMEdkJeWa888aDyrWIqmhP9DGLkaQrq9aPTLPefY1qJ5qGixulifAohYVzhpkDnCmOIsLIv87y7g+PoF/yZZXExCRwU58nVVSWz6ra/ly3IFU1FBsXNZC3L18IqWw0aep+wnwzd/mlt3aWGqAqP9/oGPmA1bJJgL+AnbWPZ6665MjGwkSxkpvLKtGwsaqniX659yu95l358ehJJ+4LqjrgoOrS3zhkd05T8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ/nv0WorJTEuFcoXAmerkCZSn4K52bCi+GsEhA8ABw=;
 b=L5uSCKshyldWa7uSS7NcRYZmh2bJj0tjSCfy0eQ9A5QvSd8ycNeA/+k0ZubB8MKQY+7dxt1bm/vZKkQhwKVrJ2TXBQbVCC0y187GhnZm79EoC7CRVMnHN8XtuhIpo6/MZN4SmvRVBM2rs3BuJH3sUHk2iV5d1Qo8QcTBjJVtU/2xIrMHFEfKcbDSHZb/0/l/A1p8yTneq0PnKDQ/6E13ZUUokmxH4OWC1qY+AdQYo8NcQCVUrDQSHhLJMxW5sKzEcWwYmCTTY0gk52UUqv0Lu+U62dwWAEmTPCP8yA8YKtoa2lmpPz2HX06MjA0BbZCHq85WSPzZa+8y+mHz9KWT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB2907.namprd11.prod.outlook.com (2603:10b6:5:64::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 21:48:30 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 21:48:29 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 3/3] elf: Don't write past end of notes for regset gap
Thread-Topic: [PATCH 3/3] elf: Don't write past end of notes for regset gap
Thread-Index: AQHYOKnNJjqblEZCTEyM9zMxB6sKmazA57eAgAATxAA=
Date:   Tue, 15 Mar 2022 21:48:29 +0000
Message-ID: <983f20076ae02f0b33d4609b19cb22ab379174f1.camel@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
         <20220315201706.7576-4-rick.p.edgecombe@intel.com>
         <202203151329.0483BED@keescook>
In-Reply-To: <202203151329.0483BED@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dbdc59b-de9d-47ba-2cf8-08da06cd8b2a
x-ms-traffictypediagnostic: DM6PR11MB2907:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM6PR11MB2907D2DBBDEA93ED66D44760C9109@DM6PR11MB2907.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqEwVja3W+fuNgjKm9/j2jIyO2Sf2Dlo6OnyRhh3lWNUie/znByz+3rCTOel+xK1jq65ZukKiG9h5U8tCbf5rUORt/v28Q1gF75/jakjyZbp2z+NCfSRnqCASxT41O8XGCwqzSKbQ61Y+3o9+NHPp6uXpa7fvq0OXPvK7qardWW2Aw3OTtPEIV+aS7SQnTj+VbV/wVpvhFE1p0wh4aQX3io3Gfxom/ERmSnYTLbcdX6Sq779laYeqEp3x1W908+7QWP1TCdbC+9YhRBiue1E6R2W+I5D/KdW/6bdOc2gypmBiFn9qV5gWX8fhH0MpnnYL7ECgNB2MpFs/0C0oqO4REr9dAlGtQ8Nu/FwwscNWwV7QQ+Rv3hTSiu7R+1FSK3G+S6m2K70Uh367YfhIPuHKTFAK/TKgNtNbL2VJuX8sihlXXnV4k0Q5iY3famzmaGLEVqvkPRyfe2lEN2JU4vX5cwTzupFBxnP+ygJpZ3is/BkH/O1RCcnzExPspmL05WiwPCv0KNFRRDG3qhMaCovg3EGf/ycrKKIywAwKruCYOPCqECLQzhV3YiXiFD04R9WM4l5qFmV8gYOHGnl285XvbngbfRWktyPVfwb4msA3Vl3gQdrqm6LzZnc68P8efZYM9+o6LUxXHuUH9C36M0W1d6FYb76G9zDcKPSJWIqBIiMWnk3IuBOtddYVlKpE2gazj99SwfXRphobaC/JIQU2Byq6KbCX+/9rOqVzqEkcQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(36756003)(5660300002)(38070700005)(26005)(82960400001)(186003)(2616005)(2906002)(122000001)(508600001)(4326008)(6506007)(38100700002)(54906003)(6916009)(316002)(6512007)(71200400001)(86362001)(6486002)(76116006)(8676002)(64756008)(66446008)(66946007)(66556008)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGlmalhtN0RVNWhRc3VKVzJHTDlGQVJGMGN3OEdTUzI3WjJPYW9xeUEwSFUz?=
 =?utf-8?B?LytVQnpFNUNwMkhuQ0VnZnpOM1dTdVlRVnA3R2RHTWFvM2lNQjYrSVNBTUNC?=
 =?utf-8?B?MVhJTXVPRWRyb2tBQ3dCQkVLcy9RdlJaNVU1MS9yUkRhMVJYdWdTU3o1M0xz?=
 =?utf-8?B?K3dCOCt2Q3NYS2hDMWVINVgyelg2VXZKWFRTdXpMejBkM1BHV25mRW1qQi93?=
 =?utf-8?B?NWdibmRCbWlDaDdOYVpJaldZc01abG9KWklxSkFFQXVSaHIya1BCbXkrQmRz?=
 =?utf-8?B?MnNQeWFHTHAvR3RGR2RuQi9LWHByVGpMQ3VEWVhhMytueXp2ODVMRkZFTmVM?=
 =?utf-8?B?Wk8yQ0RWTzJTZi8xL2VjbG9nc253S0NFVTdrY0dMUlpQc0dNa1cvdmxiTzlr?=
 =?utf-8?B?SFZ5cVpiZ3ZBdWZ2eGFMS2dvNjdnaW9Ra2kyMjhqVTdUYmkzTjZCVTBoTzFi?=
 =?utf-8?B?TjlwSnVTanphUGVRdEh6clNVc3FCTk1xd29QdW51NWVLOHpocEpSc2VkNXRS?=
 =?utf-8?B?WTM3WXlsaEJidzh2OCtidjNpWDArY21QMUcxdGd2SGNROW1xSWRqYVRmL2Uy?=
 =?utf-8?B?RWZoQittbnBMV1cwUitnZWxsdlZyenZjdjV2OGdVcEh5NUYvYlFXWGtnMlFh?=
 =?utf-8?B?VmVNOWo5R1ZsMFg2clVkMGM1blcrZDgra2FTQTZFK0UvNUlKbzI2bmlQRWNH?=
 =?utf-8?B?K2tBc0xLM01sNlMrL0lsaVJibHloU0JiV1dVSitvOVZpMVpscFZqc1E5dEZ6?=
 =?utf-8?B?L2VRMTNKaXBXN0tDcEkxYnAvWjVGenJmaC8rcTVsdUhtT0k4N0ZKMXFKMGVU?=
 =?utf-8?B?WGdxVkZOM1RuNHRocUNrT2Z3dGFxVEgwQ3Y3a0t2MWcvRjlFNmduWUVKLzV2?=
 =?utf-8?B?Z1ZCamt3TXkxWUx2anViWEV5VEhITm1oSFc1aW1PaU0veEFVbFhlRWZJK2tE?=
 =?utf-8?B?ZWJHaEx3bUVyRjl3bExGTU9SdzNWamM3N1JFYVNXNGlCTHFtNjZrUmZaMWFk?=
 =?utf-8?B?VGUrbVEwUW1zOUxWRDlzTEppbjdJTyt2NHk1bE1ETERWQ1lFOE1Lclk1MUdS?=
 =?utf-8?B?S1ZQRjhLNldOck9WeWx0UHNnMElDamtjdEJmcWYyb3A2K0g4YVlJNERkV1Y4?=
 =?utf-8?B?UWZpeGZiay9TRFhIUjgzY0RPQ25kaWE5Nmg0bUtUNUZRWXZaMUpXVkhmZGhq?=
 =?utf-8?B?VDJWZ3JDM0o0SWMvVDdDeVpuZzNxRVpoS2pxcEVDUDUxa3lseUIyT3A5b0tj?=
 =?utf-8?B?cDJGQUxkM1NCTDJUa2Jjdk9jSCt1SjhhQWFza0dNOXY0TWVYUlRHL0Z3dFEw?=
 =?utf-8?B?NENHc2EvM2lnYXM5UGpJTTNwNWUrbUZlNW1qLzRIMFlranVlMGNrekJYQ3pq?=
 =?utf-8?B?VWJIU1QyQ3JiVVJJSVBKcXRKcisxNWxIb1o1VEN1ZG9PT1pxNFpKVGw5Vmkz?=
 =?utf-8?B?RWJBeVZydUg1MFBRVFZ0UTY2NmY1U0ZGK3FTYytWMUw0cENNMXl4RDZDZG42?=
 =?utf-8?B?RHV5aVI1V0E5N3F2ZXBXV0xnR3l5LzhVQytnWXlWcmNwV1ZEdmZ6c29xMkxS?=
 =?utf-8?B?Rk1DWERJTmc3UWxTKzMxVXJ2L1BNdVlJMDM4eVZtTmNFSWdVT0k1L0p6UDAr?=
 =?utf-8?B?TFRtMGh0YkFNWnJUT3R6U3p6UWhjU3cyeXRBRGM3VWtUV0UrRDdiRi9IRW1W?=
 =?utf-8?B?YXBHZ293anlYSU9wem0wUzN1S2xkYWNxNGxaeVdCdmpHTnRtcStGejJBN1lN?=
 =?utf-8?B?NVJKYUNTUVFsVG1iWGNCNmVmdGdpbUpKMWpydy9lbXhobTVJaTdEdjN1OC9P?=
 =?utf-8?B?c0g2ZVlNVDJlL2ZFRHVrOGZDclFzQVRLV29HVEFhZC9JOEN0ald5YUhjeGNI?=
 =?utf-8?B?YWxCWkZiUXVXNEhtNzMrZ3lsOFZqWXFzOHQ0OGNpbUlhUkkyYVA2T2ZYSVZM?=
 =?utf-8?B?bkE3VGR0SU5FMEFGZ2tVNUc1b1dBcXhWZlNkc1ZMNTF4QmorS1hrSDhqUUNC?=
 =?utf-8?Q?T6Kp3+lK8EN1ILExAhKkQiuqZyFyMo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15AB98E330FEF443A05C56D6E2B3EE00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbdc59b-de9d-47ba-2cf8-08da06cd8b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 21:48:29.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KddcLGZ/r+p0sYq3M0o1XE/TQfjRFD2ltfVeo/WCHmS9vS94HZTjOLXwgAnqxlNlPSxt0Pkp8FjsXhBV7Gii/7dp2XjIPFlyWDhjyO/ENo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2907
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDEzOjM3IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
ICAgICAgIC8qDQo+ID4gICAgICAgICAqIEVhY2ggb3RoZXIgcmVnc2V0IG1pZ2h0IGdlbmVyYXRl
IGEgbm90ZSB0b28uICBGb3IgZWFjaA0KPiA+IHJlZ3NldA0KPiA+IC0gICAgICAqIHRoYXQgaGFz
IG5vIGNvcmVfbm90ZV90eXBlIG9yIGlzIGluYWN0aXZlLCB3ZSBsZWF2ZSB0LQ0KPiA+ID5ub3Rl
c1tpXQ0KPiA+IC0gICAgICAqIGFsbCB6ZXJvIGFuZCB3ZSdsbCBrbm93IHRvIHNraXAgd3JpdGlu
ZyBpdCBsYXRlci4NCj4gPiArICAgICAgKiB0aGF0IGhhcyBubyBjb3JlX25vdGVfdHlwZSBvciBp
cyBpbmFjdGl2ZSwgc2tpcCBpdC4NCj4gPiAgICAgICAgICovDQo+ID4gLSAgICAgZm9yIChpID0g
MTsgaSA8IHZpZXctPm47ICsraSkgew0KPiA+IC0gICAgICAgICAgICAgY29uc3Qgc3RydWN0IHVz
ZXJfcmVnc2V0ICpyZWdzZXQgPSAmdmlldy0+cmVnc2V0c1tpXTsNCj4gPiArICAgICBub3RlX2l0
ZXIgPSAxOw0KPiA+ICsgICAgIGZvciAodmlld19pdGVyID0gMTsgdmlld19pdGVyIDwgdmlldy0+
bjsgKyt2aWV3X2l0ZXIpIHsNCj4gPiArICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCB1c2VyX3Jl
Z3NldCAqcmVnc2V0ID0gJnZpZXctDQo+ID4gPnJlZ3NldHNbdmlld19pdGVyXTsNCj4gPiAgICAg
ICAgICAgICAgICBpbnQgbm90ZV90eXBlID0gcmVnc2V0LT5jb3JlX25vdGVfdHlwZTsNCj4gPiAg
ICAgICAgICAgICAgICBib29sIGlzX2ZwcmVnID0gbm90ZV90eXBlID09IE5UX1BSRlBSRUc7DQo+
ID4gICAgICAgICAgICAgICAgdm9pZCAqZGF0YTsNCj4gPiBAQCAtMTgwMCwxMCArMTgwMCwxMSBA
QCBzdGF0aWMgaW50IGZpbGxfdGhyZWFkX2NvcmVfaW5mbyhzdHJ1Y3QNCj4gPiBlbGZfdGhyZWFk
X2NvcmVfaW5mbyAqdCwNCj4gPiAgICAgICAgICAgICAgICBpZiAoaXNfZnByZWcpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICBTRVRfUFJfRlBWQUxJRCgmdC0+cHJzdGF0dXMpOw0KPiA+ICAg
DQo+IA0KPiBpbmZvLT50aHJlYWRfbm90ZXMgY29udGFpbnMgdGhlIGNvdW50LiBTaW5jZSBmaWxs
X3RocmVhZF9jb3JlX2luZm8oKQ0KPiBwYXNzZXMgYSBpbmZvIG1lbWJlciBieSByZWZlcmVuY2Us
IGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8ganVzdCBwYXNzDQo+IGluZm8NCj4gaXRzZWxmLCB0aGVu
IHRoZSBzaXplIGNhbiBiZSB3cml0dGVuIGFuZCBhIGJvdW5kcy1jaGVjayBjYW4gYmUgYWRkZWQN
Cj4gaGVyZToNCj4gDQo+ICAgICAgICAgICAgICAgICBpZiAoV0FSTl9PTl9PTkNFKGkgPj0gaW5m
by0+dGhyZWFkX25vdGVzKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQoN
CkhpIEtlZXMsDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLg0KDQpBcmUgeW91IHNh
eWluZyBpbiBhZGRpdGlvbiB0byB1dGlsaXppbmcgdGhlIGFsbG9jYXRpb24gYmV0dGVyLCBhbHNv
DQpjYXRjaCBpZiB0aGUgYWxsb2NhdGlvbiBpcyBzdGlsbCB0b28gc21hbGw/IE9yIGRvIHRoaXMg
Y2hlY2sgaW5zdGVhZCBvZg0KdGhlIGNoYW5nZSBpbiBob3cgdG8gdXRpbGl6ZSB0aGUgYXJyYXks
IGFuZCB0aGVuIG1haW50YWluIHRoZQ0KcmVzdHJpY3Rpb24gb24gaGF2aW5nIGdhcHMgaW4gdGhl
IHJlZ3NldHM/DQoNCklmIGl0J3MgdGhlIGZvcm1lciwgaXQgc2VlbXMgYSBiaXQgZXhjZXNzaXZl
IHNpbmNlIHRoZSBhbGxvY2F0aW9uIGFuZA0KdXNhZ2UgYXJlIG9ubHkgb25lIGZ1bmN0aW9uIGNh
bGwgYXdheSBmcm9tIGVhY2ggb3RoZXIgYW5kIHRoZSBsb2dpYyBpcw0Kbm93IHN1Y2ggdGhhdCBp
dCBjYW4ndCBvdmVyZmxvdy4gSSBjYW4gYWRkIGl0IGlmIHlvdSB3YW50Lg0KDQpJZiBpdCdzIHRv
IGp1c3Qgd2FybiBvbiB0aGUgZ2FwcywgaXQgY291bGQgYWxzbyBiZSBkb25lIGRpcmVjdGx5IGxp
a2U6DQovKiBEb24ndCBleHBlY3QgZ2FwcyBpbiByZWdzZXQgdmlld3MgKi8NCldBUk5fT04oIXJl
Z3NldC0+cmVnc2V0X2dldCk7DQoNCkFuZCBpdCBtaWdodCBiZSBhIGxpdHRsZSBjbGVhcmVyIG9m
IGEgaGludCBhYm91dCB0aGlzIGV4cGVjdGF0aW9uIG9mDQp0aGUgYXJjaCdzLg0KDQpMZXQgbWUg
a25vdyB3aGF0IHlvdSBwcmVmZXIgYW5kIEkgY2FuIG1ha2UgdGhlIGNoYW5nZS4NCg0KDQo=
