Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE76414D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 08:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiLCH45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Dec 2022 02:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiLCH4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:56:54 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2067.outbound.protection.outlook.com [40.92.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7D98E8B;
        Fri,  2 Dec 2022 23:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5kfi4fJE+DNbBk2xDjoCZ0iAK2vsBhtZF+PHmZRHi+FyvVqpspDPGLSi3BBBwsAiEZeiR/39T7RE5ZdNWeXEL30U58L+JAhLasMuUe2Gkkb6agiHfXG74nJx0DoJExpOjq9XS3pYtniQG560QflaKpmWk63kInlOj4aZkVoSqNrAfvEPQQRLQCUvIqu+Lkd/hMipeZWnoZ0DZnKQGv9iLSJ4RHDNL7z9ZFAvN/HftfgMYeY/E1Qh3oRy4UKNugVlpcqQZWwwGwHJXCAWj/c/dHN03i7R0/t1tGz6gk1LRqtFc/FoJGS6rqFv0jw2xNtbz3DprbYg+dJtvn5yxPtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx7iOFPcBJM5D27C0e4gbj2zC8OcOo4pPOqph9Lm9pw=;
 b=g0y0kmHrgHuC5tv0HA986oRKXf/d4D0inUUB3/MY4pTNcrq9DKZnAOz0Hw0ESkMXCmFjjBaH7Uu/fcGbTUVLcJ9fSl/SrYXjOtAyhGBuQ+dtlbtPFX4cOXS1PIOXbr9CupkIc7BmbPyX+PZXgxGoS5xDL78jQ8meQHjX0nVOY4trUxATTpFVZLFIE2mXrPzUbttKcN+BtxTOxAeIJyM/Kdgm4+TwKgC2VdXOMTidyeMgkNh770E9I+17ubSwAfjfPj7o+0C2jSYPV1M7FScGWJP60sCUa6qN3wbaK19QuTte7tmDULbP/Zo74Zwr30Cl2JcoIUErTHeczZJMUEyM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx7iOFPcBJM5D27C0e4gbj2zC8OcOo4pPOqph9Lm9pw=;
 b=OQdmazbBZzl/iIEsug+wEGJS6FFX2Ogkeo8BPRtcI2jEAPhjSlMt/AsU1l2aXNzHrrErSaej/WG3MmdkKPDXdYa6d60QOOpgbvmQdmiI//xpT2YsdItN3u8R+0SmllsuoWbrc/a242i76djg+x0XbbICZIq2qUs3s2RpsCKXTwEeJ0cCYhJp5+m+4T+KX+Pb8Q5rktZbdkl/M7XvBu+i3B4q0LQrAYoPdPJuoCKzvsCfHfodk4KcaJhUmkM26Urih/VRBhwMIxWBTzvk/k7H/ajTHzYpjYsRcKJtHSwJy4/2OLfI1qpXsYI0Es4Owe/L+a08K4gfxCZs/h/7FezBBw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB8281.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Sat, 3 Dec 2022 07:56:48 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 07:56:48 +0000
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
Thread-Index: AQHZBmRIqZUco1oHfUewwcIrvr9k1a5bExaAgAC5qIA=
Date:   Sat, 3 Dec 2022 07:56:47 +0000
Message-ID: <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
 <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
In-Reply-To: <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HX+Dwn22VB6uSb4CkWyKaLWbpY9d9Mhq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB8281:EE_
x-ms-office365-filtering-correlation-id: 6c421cdc-c2a1-43bb-58ef-08dad503edd0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCDjRyBNS50cuklGgrAiHtn+/ttEyDvYwTg91x52cguTlyniaRqAvXQ4j7Rjk/68V7yMuEvCjyQHh03hT6Tg1ajQ9LIy9NyfBGY98E7ttP2peNzKSCSpYd2NScVXXwU9zmm/Knwvtksi6tgzoXzG/BQIgRJSA47l66LlwcsT3wvktssDZb9J6nPwaEpHkxZZFkEUz9MBarUCMcYEPH4lFP5aA75mPza8vUhfik7JlwPLUj3KN+iaRq2mPNcWMxzAepG46Nqze9qWj1NB3rDlYncr5r6mst1+cSqJY0/Az/7XAJwz4zP81yYR/xr7FkxbXZsBB2qN2Z1jMPSU5tPKbkInYov64mLsTkqlL5p2xHran11FdQkngpPD2Qm1Uq0oGBy9S8bnCTvOLc2ajqrZ/plEz5UgB+pMgd6TojC9VjpaJWvpH4moWGB8CS3fySWhXCZAL4HCpJkd9F5Vn4cKZD5ZatjM+njsn1k8GNY95Xbs4kDlzLGNCw+d4L9Fx10O1kQUcajykSqYEpmBtEYtTouKmxmMGWC3ny0+lMi3HPXn14s4bgsyIP9pI98fxp/Cvk8vVO/Up1trVxMlMEVckuanPTjCihZSBhpNEV2wyVRp+9Yc9Nu2lclZJXMIr1tjAAMygze5sSWYRwxAmdADOQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MndkZWQrQmVqcXFhWk5tKzBFZWtobHdjaW12OGJoVnRLR2h2UGhXaUdVVVdj?=
 =?utf-8?B?OUwwdlZaMU1iblh1anc1eU5IVHZ5WDJJSG5zRGJzRWRvNTcwbnZQOEpITHlC?=
 =?utf-8?B?STc2cWowMW1rbnl2YnVWNXR5VnR1S2IxMlZlLy9WSWZTVXFZV0RZUDlFUDZD?=
 =?utf-8?B?WUVWd1RNRTJ5dDloRDJweHdweVhQQlN6WjV4cy9SR2VmRzlPYWt4emEzYjZw?=
 =?utf-8?B?WXdsSElmTldzMnN2cnFmUmJBMjZlM2lQUUptdXBVanExME42em5hVEE0N0dz?=
 =?utf-8?B?M2l6R0NibXdQa01KMGR6aVVObEVCS0dRYXJVVTExbkpLQkVydmNsY2FZWTFV?=
 =?utf-8?B?bWJ0VmVBYTh4WUJkQlIxVHpXM1owcGQ4MnR3ekJIM01NckF0c0MrcVBNZHhS?=
 =?utf-8?B?MW9JZ2loQjNreVh2R0JFVk9LUjQ3a1pmUmhPbGRYMWFDWjZqUkZOSUFoYnls?=
 =?utf-8?B?N09GWURRMnFaTFdqTndMTDNnMHdMVUUvelMwKzVkeHhEQXJrZldxWDlYV0pB?=
 =?utf-8?B?K1htampMdzV6ZUU3Z1dLNlIvcnhLNjFtalJyMHpJSEswWlJKRGt2Q2JNWnRR?=
 =?utf-8?B?NEQrems0YTI2dkZ5dW94dERXVFYzY2xjNDU4eE5oZXBFaTNyR2NqaE1oL3JS?=
 =?utf-8?B?cWlWRDdISUlDVzFnTDZKVktIVDgzUEppTmNFL01YVTRlejN5VkNTdGpuV2tC?=
 =?utf-8?B?aXlrMzRpVmpJRGdDQ3NHZjRlbVEwNGZQb1ZmVURlVzJjcTRCRVBML2w3NmxF?=
 =?utf-8?B?WmdhUFpSVXJFeXJLT2wzZTh2SGtydTY0RWVUNm9DYjFtR05mbnozWElEWnNT?=
 =?utf-8?B?eFJsWVRUOHA4dDhPa3R6SzJ0QzlpY1hTd2lRaXkrdVpsMnJGWktYQUxwekk3?=
 =?utf-8?B?cU9YVVVLeUF3ekNhQWRDR0x0OExPR2wyWUsxVWp0OWtXVEFRd3M2QW9qOWhj?=
 =?utf-8?B?bXlTRHdyQ1lHak5meU5XbWVOZHhjYXNtMExMVDRRaDloVjRZQXJ0a25oQWh5?=
 =?utf-8?B?MlRtclI3bHI0MHVydTlPeEV0SnNiNEpxaDgrSVM1WDljWDRGSHYzc0dtMmkx?=
 =?utf-8?B?Y0IwSnVWQTE5VUtoSE9hendiandjVXZnRm5DcGkyRXB5NnJndlhtaG5CL1dz?=
 =?utf-8?B?dk1rckd0YXZEeWluMGlONG84K0F6c3VnU2NVbW1wWjl2WE1KUFdMVXRDdkF5?=
 =?utf-8?B?aUQrZEdtZ2dza3N5OGN3RldPTk9DSS9WcjZuZ0h2NFBhbCtTN2FGWmlOaXpT?=
 =?utf-8?B?ZkJ0L1I5TGM1WmNqS1ZMdTNSc0IvTFJXOFEwYVJQRDgvNDVvUDVPQWMrOXBo?=
 =?utf-8?B?aVJaM2VrbzNPT080NGdBeVBjcC9qbEJLRXB3cXpMT1dqMlZYbHJYWTJhcGd0?=
 =?utf-8?B?SmFEK3N2dUpJckZPOFlWejg1S3VCNjV4YnZERGlwKzFwZ3ZVNjlIMVdOK0Z3?=
 =?utf-8?B?TzNseHdXNEkvd2JIR055bXI4ekpMKys5cThEejhDaTB4YjFXYjFaVXRMNEEx?=
 =?utf-8?B?QmdoVzJMMkFvZXVieWJ0QWdSSUFlNStiRm5lNVl4SDJTbTVLazlyQnJGcWdo?=
 =?utf-8?B?bEZtRUxKZ2E4L3BJZWlLcUZyQ0ZlM09aMzI1dUdXVVAxcHlUSjQ2YXdDemIx?=
 =?utf-8?B?YWhUay9zdURpNkFYK3RKRHpkZWN2SExXR1dwQkM4ZE9JZXhjNjhJYXdGVFk1?=
 =?utf-8?B?Um5zR05UZFErSnZidlJJNmhDNmEvbVU3UHB4TWo4UWRyUDdPeVNwWDdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF56E5892D5E63439C1204D1D46C66DE@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c421cdc-c2a1-43bb-58ef-08dad503edd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 07:56:47.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8281
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IEkgYW0gc2xpZ2h0bHkgY29uZnVzZWQuIERvIHlvdSBtZWFuIHRoYXQgYWxsIGZpbGVzL2Zv
bGRlcnMgd2lsbCBoYXZlIHRoZSBzYW1lIFVJRC9HSUQgYWx3YXlzPw0KDQpEZXNjcmlwdGlvbiBh
Ym91dCB0aGlzIG1vdW50IG9wdGlvbiBpcyBnaXZlbiBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0
ZW1zL2hmc3BsdXMucnN0DQoNClRoZSBVSURzIGFuZCBHSURzIG9mIGZpbGVzIHdyaXR0ZW4gYnkg
bWFjT1MgMTMgb24gYW55IEhGUysgdm9sdW1lIGFyZSA5OSBieSBkZWZhdWx0IGFuZCBmb3IgaVBh
ZE9TIDE2LCBpdCBpcyA1MDEuDQpTbywgd3JpdGluZyB0by9lZGl0aW5nIHRoZXNlIGZpbGVzIG9u
IExpbnV4IGNhdXNlcyBGaWxlIHBlcm1pc3Npb24gZXJyb3JzLg0KDQpUaGUgVUlEL0dJRCBvcHRp
b25zIGluIG1vdW50IGtpbmRhIHNwb29mcyB0aGUgVUlEcy9HSURzIG9mIGFsbCB0aGUgZmlsZXMg
aW4gYSB2b2x1bWUgdG8gdGhlIG9uZXMgc3BlY2lmaWVkIGJ5IHRoZSB1c2VyLg0KDQpTbyBmb3Ig
ZXhhbXBsZSBpZiBJIHJ1biAic3VkbyBtb3VudCAtbyB1aWQ9MTAwMCxnaWQ9MTAwMCAvZGV2L3Nk
YTEgL21udOKAnSwgd2hlcmUgL2Rldi9zZGExIGlzIG15IEhGUysgdm9sdW1lLCBpdCB3aWxsIGJl
IG1vdW50ZWQgYXQgL21udCBhbmQgYWxsIHRoZSBmaWxlcyBhbmQgZm9sZGVycyBvdmVyIHRoZXJl
IHdpbGwgaGF2ZSB1aWQgYXMgd2VsbCBhcyBnaWQgYXMgMTAwMCwgd2hpY2ggaXMgZ2VuZXJhbGx5
IHRoZSB1c2VybmFtZSBpbiBtb3N0IExpbnV4IGRpc3RyaWJ1dGlvbnMsIHRodXMgbWFraW5nIG1l
IHRoZSBvd25lciBvZiB0aGUgZmlsZXMuDQoNCj4gV2hhdCBpZiB1c2VyIGNoYW5nZXMgdGhlIFVJ
RC9HSUQgYSBwYXJ0aWN1bGFyIGZpbGUvZm9sZGVyPw0KDQpOb3RlIHRoYXQsIHRoZSBhYm92ZSBt
b3VudCBvcHRpb24gaXMganVzdCBhIHNwb29maW5nIGFuZCBhY3R1YWxseSBkb2Vzbid0IGNoYW5n
ZSB0aGUgcGVybWlzc2lvbiBvZiB0aGUgZmlsZXMuIFNvIHRoZSBmaWxlcyB3cml0dGVuIGJ5IG1h
Y09TIHNoYWxsIHN0aWxsIGhhdmUgOTkgYXMgdGhlaXIgVUlEL0dJRCBhbmQgdGhvc2Ugd3JpdHRl
biBieSBpUGFkT1MgaGF2ZSA1MDEuDQoNCklmIHlvdSB3YW50IHRvIGFjdHVhbGx5IGNoYW5nZSB0
aGUgdXNlci9ncm91cCBvZiBhIGZpbGUvZm9sZGVyLCB1c2UgY2hvd24uIFRoZSBjaGFuZ2Ugd2ls
bCBiZSBwZXJzaXN0ZW50LiBBbHRob3VnaCwgaWYgcGFydGl0aW9uIGlzIHJlbW91bnRlZCB3aXRo
IFVJRC9HSUQgb3B0aW9ucywgYWdhaW4gdGhlIGRyaXZlciB3aWxsIHNwb29mIHRoZSBvd25lcnNo
aXAsIGJ1dCB0aGUgcmVhbCB1c2VyL2dyb3VwIGhhcyBiZWVuIGNoYW5nZWQgYnkgY2hvd24sIHRo
aXMgY2FuIGJlIHByb3ZlZCBieSBtb3VudGluZyB3aXRob3V0IHRoZSBVSUQvR0lEIG9wdGlvbnMs
IGFzIGRlc2NyaWJlZCBmdXJ0aGVyLg0KDQo+IEFsc28sIHdoYXQgaWYgd2UgbW91bnRlZA0KPiBm
aWxlIHN5c3RlbSB3aXRob3V0IHNwZWNpZnlpbmcgdGhlIFVJRC9HSUQsIHRoZW4gd2hhdCBVSUQv
R0lEIHdpbGwgYmUgcmV0dXJuZWQgYnkNCj4geW91ciBsb2dpYz8NCg0KU28gdGhpcyBjYXNlIGlz
IGlmIEkgcnVuIOKAnHN1ZG8gbW91bnQgL2Rldi9zZGExIC9tbnTigJ0NCg0KSGVyZSB0aGUgZHJp
dmVyIHdpbGwgbm90IGRvIGFueSBzcG9vZmluZywgYW5kIHRoZSByZWFsIG93bmVycyBvZiB0aGUg
ZmlsZXMgc2hhbGwgYmUgZGlzcGxheWVkLiBUaHVzIHJ1bm5pbmcg4oCcbHMgLWzigJ0gb24gYSBt
b3VudGVkIHBhcnRpdGlvbiB3aXRob3V0IHNwZWNpZnlpbmcgVUlEL0dJRCwgZmlsZXMgd3JpdHRl
biBieSBtYWNPUyBzaGFsbCBiZSBzaG93biBhcyA5OSBhcyB0aGUgb3duZXIsIGlQYWRPUyBhcyA1
MDEsIGFuZCBpZiBhbnkgZmlsZSB3YXMgd3JpdHRlbiBvbiBMaW51eCwgdGhlIHVzZXIgd2hvIHdy
b3RlIGl0IHdpbGwgYmUgdGhlIG93bmVyLg0KDQpJZiB0aGUgdXNlci9ncm91cCBvZiBhbnkgZmls
ZSB3YXMgY2hhbmdlZCB1c2luZyBjaG93biwgdGhlbiB0aGUgbmV3IHVzZXIvZ3JvdXAgb2YgdGhl
IGZpbGUgd2lsbCBiZSBkaXNwbGF5ZWQu
