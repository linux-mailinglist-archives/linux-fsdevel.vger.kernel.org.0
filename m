Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3037B373
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhELB2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 21:28:33 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:51875 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhELB2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 21:28:23 -0400
IronPort-SDR: ogBk6sSzzwxQvEE8olUb8Wz7UlOjwbm2Wk6RZwRUmHBN8nUX4pXDRXrmhlXSukrJ79O5fSe8nR
 BUWAJurBRaMbAGB57DuYdZ3QZP7ES+SGXy0G/fpR9BiYkf9DSCZdTQoExbYzJtee5IgvTD+iia
 ITclwWBbO/k57cXYwHoEN+re42cj9JYFIi+wlj8aNi4sbjmLzJ8i23rgS5zE0c+TZrMMRkbiQo
 z7OB18TwTGuMHwsysJUZFddCHPmNkbW3yvkvIjy4I2bnlqBsmu8bhryCpfO3BawkGM4zvPLE25
 guE=
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="31167728"
X-IronPort-AV: E=Sophos;i="5.82,292,1613401200"; 
   d="scan'208";a="31167728"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 10:26:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX7WGA8psQRPvAlPWOHgDiJ9dapxO+6WjyHz5gkxEASjrIOwfTTb9XZJhVnCPdf0feThmaVRqduluolEFT/6G5n4uG+mKcl/jeXFNfW9YnQPhLmuXa53ghmpmcBGoxTV+QkDdeDXBjRbZizoQGeluDZj5NLy7M01WcIWIFkClPNLzeTNpw5SCJj3AX782ViltC911gpUDuZBES2yAXjwsd4Pxm9LnoGr4NsAW+WpzmfmOZjZCD2syetYsy4Tqg4Wftk41V0HKJBer5UoW1MJyEOndb/ZubUv/QAxXUxtikggacomh0mPRrhHOJipIhvJg57MoYprNAZ06ytO3J1OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GunQJCoQ5PZX41lKtKo2dnNUIl9zSXBMxpy7ebJlq7I=;
 b=J8j2Cf7d8+GK7SfE7iQLiTFnj05BiTIgeDEhvP6UarfcRMAN+Lao0CkgA48bUqVvLrSupUVOr9VdRPorRadrUbFbgw6aAMgL29c72/9/BsTIJIwfASDAa4eGoIkcMgx9uYDQIyFh3zvvD7qvgkujpaWBWwE4l97IAGMfwQ9VwSSBmsN7CPtNNALAMH66sPpWpdjucT7mscULhn1CE+NXhIgym5isjUADarvUteINeDFAK7snlRarJXrD1WDEwxmcR3qxW3ztB4Rn7LxMIPDtoHOAX8bE6+0lUJ/Qsk3bIBXLzS1EUTzomS2sx40W/SHa+Njzz3FGDi1zA5mlmChe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GunQJCoQ5PZX41lKtKo2dnNUIl9zSXBMxpy7ebJlq7I=;
 b=UiSS+ovlMtSGqXvIUs6NkbYj0U9ggVRpcoWMEI6yy47Osfa+5bEpB7xltSiRAAm6XjHiiILIyFWMawO9xaUsbP9+dq85gcJmPdK5WBczyENR4b/tocpPnQIgsFdWybDs/BanYsxnChOZUZsK8+npFwOkUN9zARyl0lDHAk6CuWU=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSZPR01MB6664.jpnprd01.prod.outlook.com (2603:1096:604:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 01:26:31 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 01:26:30 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v5 7/7] fs/xfs: Add dax dedupe support
Thread-Topic: [PATCH v5 7/7] fs/xfs: Add dax dedupe support
Thread-Index: AQHXRhNDCed4g25S+UadwA1j61+HmqrfCV0AgAADOLA=
Date:   Wed, 12 May 2021 01:26:30 +0000
Message-ID: <OSBPR01MB292025D1E3CA65493B714E63F4529@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-8-ruansy.fnst@fujitsu.com>
 <20210512010428.GQ8582@magnolia>
In-Reply-To: <20210512010428.GQ8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b6c3cc-111b-42ca-103c-08d914e4f8dc
x-ms-traffictypediagnostic: OSZPR01MB6664:
x-microsoft-antispam-prvs: <OSZPR01MB6664BAA7D9C809FC20771297F4529@OSZPR01MB6664.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEpItdJVn/ZUhP2tke/evJ4YEYUB5GFLjF1/uhQJfumPetHYWOLhsGRgCaYlD+k1opeVWpiLrKVsBGDHue+L7FB0fHUb8LYhjM2j0Z3i2+Hvs607mJtgMC4Wwk65zytjDp8lTcnebKK2Ol9paZG3DkJZXeVUPK261CsP6P4CkZCt/2FpQhYN0Zkskyom8DDXI2ecwZzds4I9avnKcR1QKt/TkDf0Pkpn4d8c3KdvFO3/zp+9CjsfXwEDt5q7v2qJp6Kq5B/wNYtgx7Jdt41PFCCS6pewunSZvw9VihcOqKi3RNVAhmE5AEGG20+8KHxtl19a1/6Uc1/ayVxhQlOIKSmYjOZQSjnr7iPIOTVUdwUAMbwygKGAsnhP4zsqM3vXl6kAG/TtH9gK6WqrHboG7o8apTp/D4+utCa8HNUAajdz5jaLxZ5NvkKfkWM4BaJ7cgbUQNdmw6ENW6zE62WXQjLobb3E7/jl4v9IadFG7rfYnfYnb43+9C5BdXuq6QgSURdSaJSYl+XVGtsVY5dYltt0ZbHVuddjtWp9Aejzz1BTz0azBT1gQ9CzwHiaw22M29fH7j8OuSty5L28g317wyH4VaNl68qh3B/VnTvnzPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(33656002)(66446008)(2906002)(9686003)(5660300002)(66476007)(4326008)(64756008)(186003)(7696005)(66556008)(55016002)(66946007)(54906003)(26005)(52536014)(86362001)(6506007)(122000001)(76116006)(6916009)(7416002)(71200400001)(316002)(8936002)(85182001)(478600001)(8676002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?c0QvOGI1cENpblJPc1VvQWJTR3czRzFTdDJTeXVZbVZPN05ENXBPMTRYekVR?=
 =?gb2312?B?Zzc1Nnd4a055KzdFMTJCeW9YTmtiQzJhc3BxOEFQQzlWU2dCUUR6TEVEdGdG?=
 =?gb2312?B?TlJBTE5DWUdiVnlyNzhtVEtadEpmRzdwbU5PYkZFaFdxVVpYbU1IUXpBVkIv?=
 =?gb2312?B?c1ZOUnRIZ0I0Q3lEMFliTTlTd0lyYVcyVXFCNmd5a2xFd2V5NE84NFN4UUZ1?=
 =?gb2312?B?dHRhTmhUME14cFJGZFNzMXZJRHRIS08veldrb1h2MVVNdWsvMkJzZmYzWGVv?=
 =?gb2312?B?dVc4Rml5MU1JV2tqSEZjRXhZUFZybUFnWk9wUjhWZlF3OStHa2NnbElrdWpN?=
 =?gb2312?B?QmNiTU1MaG5kSHNlT3QxbEthdCtBUlZNTS9BL2ZOMEZrVGo0SlFySThFSlMw?=
 =?gb2312?B?SlNmd0hPdk9iSHJCakZIWjd3WjAxNjJTWEY1c0dZZnNobVRVMWg4VW1YOVBp?=
 =?gb2312?B?Y1MxN3Vtb010UitaYmdYK2pUcy9Td2VhdEZ6RDhUSFNtOWNpeEZFTkFKUVlm?=
 =?gb2312?B?Y2dHR2tSNVNZZVZMWGlXNTBCK1IrbFBOZm1kOEg2azQ2T05KQWh1bk1CZS9q?=
 =?gb2312?B?b1IwbWlsRnJpTlc1UTgrZ3kyZlVhNjVKOE94S25qS3lxZ1JwblpESUU5MTY0?=
 =?gb2312?B?eklaK3BkU3UvUkFWNElyR3FxcXo1OGJjdlVCUHVid05kajdNL2VIVkN3azli?=
 =?gb2312?B?Z0RnTkdHYkhEUTIwUVJLa1UyK1pOdnpyMFoxMm9NaVRGc2ZrSmxEbWNtaytH?=
 =?gb2312?B?WGg2N1lsVUVCam5seDAxWEtEMS81OHROMHR5KzJuT0trUEM5N2tFUkFpb3NG?=
 =?gb2312?B?UFFzdVJ6RER5TXlEbUM3bk9tdThwQ2RPN2M5TDZPWWxXRHQ5NzJCYWdiTzBs?=
 =?gb2312?B?dVFhTW4xVTd2cnhGcHJ0bEp6UEwxbFFkcWNtTmFEaVNGV3hPWktjOVB3NytF?=
 =?gb2312?B?Ny9uUC9KcmJhTlBkZDF4ei9iYnN5cWg2S3JKRWxhcFpRVlowNVJkU1NKVXpx?=
 =?gb2312?B?T25pbGQ1TVp2SkxPQ1dlY2R6dnpwL01BSitzTi9hbUpRclB6Sys4bVcwd2Zz?=
 =?gb2312?B?Q2FBK1lwd2c3bitqUUpmUHZMWlpWenFISmhtSll4UEVvcUgreWNIRnFNYUFI?=
 =?gb2312?B?M2JTK29PQTF4dlR3NURLRmswWjZVUUFLc1A2RlZ1ZDZObXRoenR1a2t4QVNw?=
 =?gb2312?B?bjRrdmJaNlJpRmkxbTZVNlMvVCs5V0d1VUEzdlM2UXdrdkdVVDJob0xaS2pK?=
 =?gb2312?B?OUordENnaHhUeUFSM0FjdXBjaXNtakNNYVJxQUJEZ0JLYStrZWlpTTRwWGM0?=
 =?gb2312?B?S2FOSjgza0J1ZzVMejNMd1JiNk1GcnlKcW9jT1JUZU9PSHJnZGxLK2ViMWRI?=
 =?gb2312?B?QVNwOGlYcDR3ZENOY2VESnFrdE8rbkpBSWZmcjZJVWMwamN6bHZRZEhHSFZH?=
 =?gb2312?B?eE5rWFBldmsyKzI2Y05aSmk3bTJZd2xNTjdXeENxZ0JTcVRUcHJEYmQzekxx?=
 =?gb2312?B?RllRSzVpR3lEMzV5RVpNMmZVVFFwNVVnTzlLZ1FGbE9tdWh6aDNNVTRwYjJJ?=
 =?gb2312?B?UzZQamoxMnA1YW5wUUxHc01RUFNKRmV3TTZsVDZnaW9xOVVYU1o3K3NXb0dz?=
 =?gb2312?B?OGtFMWl3MlE1WWFmeExBSFpmWlNBRCtqM2VvL1Uzci95eldTUjZ1TEx3SkV1?=
 =?gb2312?B?R1FPY0JHaFV4M3dvSmUycEk0b1dwQkd5UU92K2FFUm5vTVFWRnowWm82TFdP?=
 =?gb2312?Q?GVkV6Y4mtHICwdXCKQYou8rnnW5QTxzbZiubxii?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b6c3cc-111b-42ca-103c-08d914e4f8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 01:26:30.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05MReelaDgfT3e+cYMKNOy3kvmvl9/BjY+A2JsvMiUhmMubYc/JbWjWpDEh3cMreoNcA6piqA3tQ7sCuDD8/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6664
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXJyaWNrIEouIFdvbmcgPGRq
d29uZ0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDcvN10gZnMveGZzOiBB
ZGQgZGF4IGRlZHVwZSBzdXBwb3J0DQo+IA0KPiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCAxMTow
OTozM0FNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+ID4gSW50cm9kdWNlIHhmc19tbWFw
bG9ja190d29faW5vZGVzX2FuZF9icmVha19kYXhfbGF5b3V0KCkgZm9yIGRheCBmaWxlcw0KPiA+
IHdobyBhcmUgZ29pbmcgdG8gYmUgZGVkdXBlZC4gIEFmdGVyIHRoYXQsIGNhbGwgY29tcGFyZSBy
YW5nZSBmdW5jdGlvbg0KPiA+IG9ubHkgd2hlbiBmaWxlcyBhcmUgYm90aCBEQVggb3Igbm90Lg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMveGZzL3hmc19maWxlLmMgICAgfCAgMiArLQ0KPiA+ICBm
cy94ZnMveGZzX2lub2RlLmMgICB8IDY2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gIGZzL3hmcy94ZnNfaW5vZGUuaCAgIHwgIDEgKw0KPiA+ICBm
cy94ZnMveGZzX3JlZmxpbmsuYyB8ICA0ICstLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDY5IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMveGZz
L3hmc19maWxlLmMgYi9mcy94ZnMveGZzX2ZpbGUuYyBpbmRleA0KPiA+IDM4ZDhlY2EwNWFlZS4u
YmQ1MDAyZDM4ZGY0IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3hmcy94ZnNfZmlsZS5jDQo+ID4gKysr
IGIvZnMveGZzL3hmc19maWxlLmMNCj4gPiBAQCAtODIzLDcgKzgyMyw3IEBAIHhmc193YWl0X2Rh
eF9wYWdlKA0KPiA+ICAJeGZzX2lsb2NrKGlwLCBYRlNfTU1BUExPQ0tfRVhDTCk7DQo+ID4gIH0N
Cj4gPg0KPiA+IC1zdGF0aWMgaW50DQo+ID4gK2ludA0KPiA+ICB4ZnNfYnJlYWtfZGF4X2xheW91
dHMoDQo+ID4gIAlzdHJ1Y3QgaW5vZGUJCSppbm9kZSwNCj4gPiAgCWJvb2wJCQkqcmV0cnkpDQo+
ID4gZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfaW5vZGUuYyBiL2ZzL3hmcy94ZnNfaW5vZGUuYyBp
bmRleA0KPiA+IDAzNjllYjIyYzFiYi4uMDc3NGI2ZTJiOTQwIDEwMDY0NA0KPiA+IC0tLSBhL2Zz
L3hmcy94ZnNfaW5vZGUuYw0KPiA+ICsrKyBiL2ZzL3hmcy94ZnNfaW5vZGUuYw0KPiA+IEBAIC0z
NzExLDYgKzM3MTEsNjQgQEAgeGZzX2lvbG9ja190d29faW5vZGVzX2FuZF9icmVha19sYXlvdXQo
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQNCj4gPiAreGZz
X21tYXBsb2NrX3R3b19pbm9kZXNfYW5kX2JyZWFrX2RheF9sYXlvdXQoDQo+ID4gKwlzdHJ1Y3Qg
aW5vZGUJCSpzcmMsDQo+ID4gKwlzdHJ1Y3QgaW5vZGUJCSpkZXN0KQ0KPiANCj4gTU1BUExPQ0sg
aXMgYW4geGZzX2lub2RlIGxvY2ssIHNvIHBsZWFzZSBwYXNzIHRob3NlIGluIGhlcmUuDQo+IA0K
PiA+ICt7DQo+ID4gKwlpbnQJCQllcnJvciwgYXR0ZW1wdHMgPSAwOw0KPiA+ICsJYm9vbAkJCXJl
dHJ5Ow0KPiA+ICsJc3RydWN0IHhmc19pbm9kZQkqaXAwLCAqaXAxOw0KPiA+ICsJc3RydWN0IHBh
Z2UJCSpwYWdlOw0KPiA+ICsJc3RydWN0IHhmc19sb2dfaXRlbQkqbHA7DQo+ID4gKw0KPiA+ICsJ
aWYgKHNyYyA+IGRlc3QpDQo+ID4gKwkJc3dhcChzcmMsIGRlc3QpOw0KPiANCj4gVGhlIE1NQVBM
T0NLIChhbmQgSUxPQ0spIGxvY2tpbmcgb3JkZXIgaXMgaW5jcmVhc2luZyBpbm9kZSBudW1iZXIs
IG5vdCB0aGUNCj4gYWRkcmVzcyBvZiB0aGUgaW5jb3JlIG9iamVjdC4gIFRoaXMgaXMgZGlmZmVy
ZW50IChhbmQgbm90IGNvbnNpc3RlbnQNCj4gd2l0aCkgaV9yd3NlbS9YRlNfSU9MT0NLLCBidXQg
dGhvc2UgYXJlIHRoZSBydWxlcy4NCg0KWWVzLCBJIG1pc3VuZGVyc3Rvb2QgaGVyZS4NCg0KPiAN
Cj4gPiArCWlwMCA9IFhGU19JKHNyYyk7DQo+ID4gKwlpcDEgPSBYRlNfSShkZXN0KTsNCj4gPiAr
DQo+ID4gK2FnYWluOg0KPiA+ICsJcmV0cnkgPSBmYWxzZTsNCj4gPiArCS8qIExvY2sgdGhlIGZp
cnN0IGlub2RlICovDQo+ID4gKwl4ZnNfaWxvY2soaXAwLCBYRlNfTU1BUExPQ0tfRVhDTCk7DQo+
ID4gKwllcnJvciA9IHhmc19icmVha19kYXhfbGF5b3V0cyhzcmMsICZyZXRyeSk7DQo+ID4gKwlp
ZiAoZXJyb3IgfHwgcmV0cnkpIHsNCj4gPiArCQl4ZnNfaXVubG9jayhpcDAsIFhGU19NTUFQTE9D
S19FWENMKTsNCj4gPiArCQlnb3RvIGFnYWluOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChz
cmMgPT0gZGVzdCkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwkvKiBOZXN0ZWQgbG9j
ayB0aGUgc2Vjb25kIGlub2RlICovDQo+ID4gKwlscCA9ICZpcDAtPmlfaXRlbXAtPmlsaV9pdGVt
Ow0KPiA+ICsJaWYgKGxwICYmIHRlc3RfYml0KFhGU19MSV9JTl9BSUwsICZscC0+bGlfZmxhZ3Mp
KSB7DQo+ID4gKwkJaWYgKCF4ZnNfaWxvY2tfbm93YWl0KGlwMSwNCj4gPiArCQkgICAgeGZzX2xv
Y2tfaW51bW9yZGVyKFhGU19NTUFQTE9DS19FWENMLCAxKSkpIHsNCj4gPiArCQkJeGZzX2l1bmxv
Y2soaXAwLCBYRlNfTU1BUExPQ0tfRVhDTCk7DQo+ID4gKwkJCWlmICgoKythdHRlbXB0cyAlIDUp
ID09IDApDQo+ID4gKwkJCQlkZWxheSgxKTsgLyogRG9uJ3QganVzdCBzcGluIHRoZSBDUFUgKi8N
Cj4gPiArCQkJZ290byBhZ2FpbjsNCj4gPiArCQl9DQo+ID4gKwl9IGVsc2UNCj4gPiArCQl4ZnNf
aWxvY2soaXAxLCB4ZnNfbG9ja19pbnVtb3JkZXIoWEZTX01NQVBMT0NLX0VYQ0wsIDEpKTsNCj4g
PiArCS8qDQo+ID4gKwkgKiBXZSBjYW5ub3QgdXNlIHhmc19icmVha19kYXhfbGF5b3V0cygpIGRp
cmVjdGx5IGhlcmUgYmVjYXVzZSBpdCBtYXkNCj4gPiArCSAqIG5lZWQgdG8gdW5sb2NrICYgbG9j
ayB0aGUgWEZTX01NQVBMT0NLX0VYQ0wgd2hpY2ggaXMgbm90IHN1aXRhYmxlDQo+ID4gKwkgKiBm
b3IgdGhpcyBuZXN0ZWQgbG9jayBjYXNlLg0KPiA+ICsJICovDQo+ID4gKwlwYWdlID0gZGF4X2xh
eW91dF9idXN5X3BhZ2UoZGVzdC0+aV9tYXBwaW5nKTsNCj4gPiArCWlmIChwYWdlKSB7DQo+ID4g
KwkJaWYgKHBhZ2VfcmVmX2NvdW50KHBhZ2UpICE9IDEpIHsNCj4gDQo+IFRoaXMgY291bGQgYmUg
ZmxhdHRlbmVkIHRvOg0KPiANCj4gCWlmIChwYWdlICYmIHBhZ2VfcmVmX2NvdW50KHBhZ2UpICE9
IDEpIHsNCj4gCQkuLi4NCj4gCX0NCg0KT0suDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFu
Zy4NCj4gDQo+IC0tRA0KPiANCj4gPiArCQkJeGZzX2l1bmxvY2soaXAxLCBYRlNfTU1BUExPQ0tf
RVhDTCk7DQo+ID4gKwkJCXhmc19pdW5sb2NrKGlwMCwgWEZTX01NQVBMT0NLX0VYQ0wpOw0KPiA+
ICsJCQlnb3RvIGFnYWluOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoNCj4gPiAgICogTG9jayB0d28gaW5vZGVzIHNvIHRo
YXQgdXNlcnNwYWNlIGNhbm5vdCBpbml0aWF0ZSBJL08gdmlhIGZpbGUgc3lzY2FsbHMgb3INCj4g
PiAgICogbW1hcCBhY3Rpdml0eS4NCj4gPiBAQCAtMzcyMSwxMCArMzc3OSwxNiBAQCB4ZnNfaWxv
Y2syX2lvX21tYXAoDQo+ID4gIAlzdHJ1Y3QgeGZzX2lub2RlCSppcDIpDQo+ID4gIHsNCj4gPiAg
CWludAkJCXJldDsNCj4gPiArCXN0cnVjdCBpbm9kZQkJKmlubzEgPSBWRlNfSShpcDEpOw0KPiA+
ICsJc3RydWN0IGlub2RlCQkqaW5vMiA9IFZGU19JKGlwMik7DQo+ID4NCj4gPiAtCXJldCA9IHhm
c19pb2xvY2tfdHdvX2lub2Rlc19hbmRfYnJlYWtfbGF5b3V0KFZGU19JKGlwMSksIFZGU19JKGlw
MikpOw0KPiA+ICsJcmV0ID0geGZzX2lvbG9ja190d29faW5vZGVzX2FuZF9icmVha19sYXlvdXQo
aW5vMSwgaW5vMik7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsJaWYgKElTX0RBWChpbm8xKSAmJiBJU19EQVgoaW5vMikpDQo+ID4gKwkJcmV0dXJuIHhm
c19tbWFwbG9ja190d29faW5vZGVzX2FuZF9icmVha19kYXhfbGF5b3V0KGlubzEsIGlubzIpOw0K
PiA+ICsNCj4gPiAgCWlmIChpcDEgPT0gaXAyKQ0KPiA+ICAJCXhmc19pbG9jayhpcDEsIFhGU19N
TUFQTE9DS19FWENMKTsNCj4gPiAgCWVsc2UNCj4gPiBkaWZmIC0tZ2l0IGEvZnMveGZzL3hmc19p
bm9kZS5oIGIvZnMveGZzL3hmc19pbm9kZS5oIGluZGV4DQo+ID4gY2E4MjZjZmJhOTFjLi4yZDBi
MzQ0ZmIxMDAgMTAwNjQ0DQo+ID4gLS0tIGEvZnMveGZzL3hmc19pbm9kZS5oDQo+ID4gKysrIGIv
ZnMveGZzL3hmc19pbm9kZS5oDQo+ID4gQEAgLTQ1Nyw2ICs0NTcsNyBAQCBlbnVtIHhmc19wcmVh
bGxvY19mbGFncyB7DQo+ID4NCj4gPiAgaW50CXhmc191cGRhdGVfcHJlYWxsb2NfZmxhZ3Moc3Ry
dWN0IHhmc19pbm9kZSAqaXAsDQo+ID4gIAkJCQkgIGVudW0geGZzX3ByZWFsbG9jX2ZsYWdzIGZs
YWdzKTsNCj4gPiAraW50CXhmc19icmVha19kYXhfbGF5b3V0cyhzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBib29sICpyZXRyeSk7DQo+ID4gIGludAl4ZnNfYnJlYWtfbGF5b3V0cyhzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCB1aW50ICppb2xvY2ssDQo+ID4gIAkJZW51bSBsYXlvdXRfYnJlYWtfcmVhc29uIHJl
YXNvbik7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMveGZzL3hmc19yZWZsaW5rLmMgYi9mcy94
ZnMveGZzX3JlZmxpbmsuYyBpbmRleA0KPiA+IDlhNzgwOTQ4ZGJkMC4uZmYzMDgzMDRjNWNkIDEw
MDY0NA0KPiA+IC0tLSBhL2ZzL3hmcy94ZnNfcmVmbGluay5jDQo+ID4gKysrIGIvZnMveGZzL3hm
c19yZWZsaW5rLmMNCj4gPiBAQCAtMTMyNCw4ICsxMzI0LDggQEAgeGZzX3JlZmxpbmtfcmVtYXBf
cHJlcCgNCj4gPiAgCWlmIChYRlNfSVNfUkVBTFRJTUVfSU5PREUoc3JjKSB8fCBYRlNfSVNfUkVB
TFRJTUVfSU5PREUoZGVzdCkpDQo+ID4gIAkJZ290byBvdXRfdW5sb2NrOw0KPiA+DQo+ID4gLQkv
KiBEb24ndCBzaGFyZSBEQVggZmlsZSBkYXRhIGZvciBub3cuICovDQo+ID4gLQlpZiAoSVNfREFY
KGlub2RlX2luKSB8fCBJU19EQVgoaW5vZGVfb3V0KSkNCj4gPiArCS8qIERvbid0IHNoYXJlIERB
WCBmaWxlIGRhdGEgd2l0aCBub24tREFYIGZpbGUuICovDQo+ID4gKwlpZiAoSVNfREFYKGlub2Rl
X2luKSAhPSBJU19EQVgoaW5vZGVfb3V0KSkNCj4gPiAgCQlnb3RvIG91dF91bmxvY2s7DQo+ID4N
Cj4gPiAgCWlmICghSVNfREFYKGlub2RlX2luKSkNCj4gPiAtLQ0KPiA+IDIuMzEuMQ0KPiA+DQo+
ID4NCj4gPg0K
