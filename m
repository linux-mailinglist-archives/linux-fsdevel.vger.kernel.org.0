Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77133645261
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 04:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLGDEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 22:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGDEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:04:35 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2079.outbound.protection.outlook.com [40.92.103.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B4532FC;
        Tue,  6 Dec 2022 19:04:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8KZ2RMUlPL8HjTZfavcGbJObHjGcq21j8PwBZzH1dSH43lRjo7vWFFepkL77YAcwQZ+vVsbOUky8jJvGT5CuO4jPDFtn4CnaG77qG9fXAjI+EtzBQUmDdUKxiVFYYyb+ropfBdN3pBw+j2Hq4sC/aD9NwnaJmVoO47ts17WrrpRCUQhzacVrmy155tA1YI2fWdL35DQj9998dYZh4Unuup7Ta82xeAaUS3Nb6MXlQccHCTuF1u3plWmxrJ/k4V8eeFgKufIFcAsf2TKRd22yGCTiZBITFbxiaBUB6hOslvpDTPHmg0IIKg0Wa4FzO58N4GqExpFI6KlaSv43dco+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj3ljViyE4oDDNbA+A8ttEK4QEsL+U5FeyfzcGreTSA=;
 b=dSkqPCwYj+yAZqrwE46VcMTeiwOLUYiHdFP4P8ftkq6PhAx0C4X5j2dlhvJX02o40J/mRRX67YajF+wKOhu2yUZaMZiLv8ALkHNRGJj2VXnxlvOa94twydADTZ0gQhI/MQ8v8w1JkBzNY0CtG8FhxC1YoS2TdnyQD48RaVGsQWNpI4ywyu+lN4St3NuzCXAW/lbE5HAOhEYwhkR66uTUVI1iDwvCLLkqLfwBKukz9wf5xFQoOoqbEVF/Bm4KtjhVYBqMvXUOEVYcpzvux/yV7D7vP/AUk6pBUObKftnM3zGVrK98Fb9AjNzUUdboCPOzFirUKJ4tQEC3CIX27ACO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj3ljViyE4oDDNbA+A8ttEK4QEsL+U5FeyfzcGreTSA=;
 b=gFl/1HKjarJvNq8ENb8WFpWDD4mMOOe6hANmuG3/WjAbGafzQFPwG28qYI1SNtsYleo4R9Bdo626xr0BKbTq/IbnFxNHiGD4/xK9UoSckPVQrE2VlDNTyvZXPRMn3JaEVn9exkOC8VYM8oCSJzZek7184MXQ5J/GJ9gsvzXNsQLJ80oiDRRx2QQbR7FAP+8l9/wDrdrHVCeoVSvbRkOT6roT1VOgBbUGRFKN8mOmgK63OphSiyHRCe8HSE91S3/v9ib5B5mvBAnKEk5+946IxBRX4Xn++iOsRSbLpHHOdESxUlaK3udEmkaTJ7THUnk3iZwy9fFz5zAHj2LnO8oU0g==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB8896.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:115::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Wed, 7 Dec 2022 03:04:28 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 03:04:28 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Topic: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Index: AQHZBmRIqZUco1oHfUewwcIrvr9k1a5bExaAgAC5qICABDvJAIAAf4aAgAAKbwCAAKnBAIAAiCkA
Date:   Wed, 7 Dec 2022 03:04:28 +0000
Message-ID: <267A1533-B2A2-4A83-ABC8-39A27D9B734D@live.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
 <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
 <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
 <A2B962C1-AD33-413D-B64A-CD179AFBEA8D@dubeyko.com>
 <FBF299DB-E235-4BD3-82BD-5A54EE9E26DA@live.com>
 <CD80923F-4422-416B-AAC1-A676D37C564F@live.com>
 <20EA622D-12B9-49B6-8564-C8EE2A2329D2@dubeyko.com>
In-Reply-To: <20EA622D-12B9-49B6-8564-C8EE2A2329D2@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [CWOAJFbUqbCmKzU66eAU5I+r8D+epfXH]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB8896:EE_
x-ms-office365-filtering-correlation-id: c2b91fe5-bbe5-4b5e-e4bd-08dad7ffc142
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dH0jkvw58R4jT8qg6esXdumsxnnbMnR07Pa+Dy87yvZwoRYbLS42nzRqTyH+UR3fvhvYBQxClDjZAXhaM1mfNiG0IHZrMuKXU+ekeXUofwCIkHHObm/iz0PNmr/9G4zcFTIKYpZlMWKcrXen4M5mvrY4v7fKHBUZNdHKuGDPxibkHbvgLycVonlWDVlVPdUmbjFR33SDtQHi+F7CgIkY5+KH0WBQN4vxucAjjrcB1bhf6cuS5l/JJW3mRdwc5P8W1zFMwwRDe3YRAewPvZQiFQEdMKRiWh/i1MRT6VbkL4sGZe8X4mdOyJgAmv5WiW2jTdzM+S5t3Fn7iPtWtWinlbMXUus5/Luz9WrRzjilWoopQmZgAd9SoyfWKUneLOiXMqAuOmlPzUDTiqxgQx6H6KyhLQN2Ap+48LowT/rkKLLurDOj4Xml99lNrh2TDzIR14OJsTqqlkjgbuhlL2jMGRSkiIcCrG+36OzywlE3Vci6aMlgMvvQgr+Tjp0RxZGR5z3WZ+F/S1zkQzoHozZiZ25nZ+yQ8l84rR0zL2oXT0yFTTng77Qw8N4hcYiXzj6tFGTnixcVvlg8wV6vuLbZ1cgogmh6xgysnaqEzv3d+nJMJV8pYDusL2wixx42g6Xqv/2t1gBhBLFUIdyAL5gzUw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnVXaWNQRWVPSWVPdnN3Tml1cjFhalU2ekhZKy80YXRHUkI2QldvdG5XWVpM?=
 =?utf-8?B?Um4vWGRjNXAyaHZkOWs3UGp4UmlEYXpzU0ZDbi8zMytzbjdIUm1yUmRubGZ3?=
 =?utf-8?B?cVdNRHh5OW45NkFBQmxtQllPWEt2S3p0b3JnZjU2RWpGZ2ZJQk40OHdaMnlB?=
 =?utf-8?B?Qk5LWkxlQU05L3gvbEg1RWVVRWdFSTFIR01oY3ZKSzgrY0htM0YvTWFhb1RT?=
 =?utf-8?B?ZnA0Y0xUd3NWdFpQWFRaLzdFY3JIUGF3d2I3RCtXY1Qvc095cEl4cFhFV0dP?=
 =?utf-8?B?cmNYaHRab2t2SlhyNVRPTC8vcUZ5MXBoRGIyMzh3UEhFTW9GcmNFV3ZPajFQ?=
 =?utf-8?B?amRqRDJmaCtiRldNVnZHUThqU3IvTE1RcDFvT2IxaHMxZUZFK2JwQkNURGVY?=
 =?utf-8?B?Qkp0TGdpOXhRenBwQzZqVjR5Yzd2WUt3aEMxVTRrb1k0b3drbHBobjBGeEdF?=
 =?utf-8?B?bjk1bXhJSzBGekZqZFVMMlEzMXpFbDBLNDhmV25QOFRaWjNtc1BpYnBqdjdp?=
 =?utf-8?B?aDFXUjVtc0F2WlVHcGxDKzM4UnRGUDRVNEppaUxORGRHTlA3VkloOHNzSVV4?=
 =?utf-8?B?VHU4R2g2dkJJWnczeDZNbmVESFFvMnRqc1NuQnFFQ1g5OWlpZzN4L1R2ODJu?=
 =?utf-8?B?QlBaMjN5Ry85VUZ0OHJ4TFhnVFkrb2pSSHJSa2RZVGt2S3p6RkRORWVBTVZz?=
 =?utf-8?B?cWt0T1RhVktqMG9OUU14aXhxTHFrbnRVRUlaa1VONFdjcjhhbXdzb0Vyb0dv?=
 =?utf-8?B?Y0t6dlBGbmNCM08vdDFYTEhacytVd0VlaVZmWlJVTHlWWnpEMDdHMHBkeHBy?=
 =?utf-8?B?bXpCMzBDMm1LZkcrMW5UUjBvbXVHWHRJTW1xTm0yK0dKWTZEQWwyQzFHdDhO?=
 =?utf-8?B?Nm5OZU90TVFud3pmU0IvVzJpdFVkcVFET0JoNmkxdHdxTXRxZ2FkaGlQSUhH?=
 =?utf-8?B?ZnY3dG9mWG42VGtVcCtiK2M1cDVndHdOQllDcmVRbFBwaHFZUFNPN05nbTZR?=
 =?utf-8?B?eDZTeis5VGhqT3pUSCtFSGowekZoczdrcDJOSkNvUk5VOG04eXpJaTBjMXdq?=
 =?utf-8?B?Vm8yQjJ2MEF0cC9kV0ZiRXZ3dTZsMkVqbHRZTGZMTllBbE5CS081ZmFzVEZl?=
 =?utf-8?B?a1NkaTdqbUUwcGZpRDV3OVppTWR1WlhpQVpkdGVKMEZJQ2JKOWJRWlZ1TGdD?=
 =?utf-8?B?eXBCOUpNNk9XS2k4eEFldnRna09xRnBMRFdtd0w3QnFySlA2S0ZSa3VMUUR1?=
 =?utf-8?B?Nk9pc1IwUUNVRmhXckpKT045cU5wOElVK2s0aDFjNmVucE5zbzk1MEhkVmJh?=
 =?utf-8?B?c0wyQWdvMk9MN3VyUmpIVUg4SmpDcUpDVzlHNmhPQnUrVkJTOFJhYnBwOHMx?=
 =?utf-8?B?cXFvK0VKazBlTzdpWmpOTHAwcDRMWkJKSGVVTkVEamR1ckR5dnROdDF5bHow?=
 =?utf-8?B?eUI4SXdZcThUWWpWUnkrZjRZVjJ4dDNkOHFWM2d1YXYxaWpXS21WMVpaeDE1?=
 =?utf-8?B?Rm9FMTEvcS9kY2M5MFN0dDB6b0ZoeDhjWGMvblhBeDlTbENZR0E3VFl2WERi?=
 =?utf-8?B?SWtUY3N2dFRjSXBDTnBnYmYvbWFJaytqUlVTMmpQem9JcVJscTdBNFo3ak1t?=
 =?utf-8?B?NXlsTlpIRUlObXc0ZHNRWno5NzVLb1Z1SEZzMzVHTUp5M1lzcHk3akJOdTNq?=
 =?utf-8?B?eXdTMzlhdHRucEUyTkcrOHBLMks1aHhFM2pyU3pOQmd1QzhHSXZSS0RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E0FBD352EA3E043899F430F8B7FA814@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b91fe5-bbe5-4b5e-e4bd-08dad7ffc142
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 03:04:28.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8896
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IExvb2tzIHJlYXNvbmFibHkgd2VsbC4gSSBiZWxpZXZlIGl04oCZcyBiZXR0ZXIgZml4Lg0K
PiANCj4gVGhhbmtzLA0KPiBTbGF2YS4NCg0KU2VuZGluZyBhIHZlcnNpb24gMi4gSSBhbHNvIGZv
cmdvdCB0byBDYyB0byBzdGFibGUsIHNvIHNoYWxsIGRvIHRoYXQgaW4gdjIuDQoNCg==
