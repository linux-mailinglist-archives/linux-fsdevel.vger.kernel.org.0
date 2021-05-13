Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE337F2A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 07:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhEMFh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 01:37:56 -0400
Received: from mail-eopbgr1400051.outbound.protection.outlook.com ([40.107.140.51]:6154
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229935AbhEMFhz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 01:37:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtQUcQyFpNEw/v9BUXOLGuLzB4Xo1yRBxOgL0ywZpOOb8fmdXQOlLL0u4625pMC8Uma30N8LSgcdO5ixvW/Jx9j6eeNI1eT653Tv7koyf+2jaR4wuCgdIphaqsdVpxXLX9X7/AB4HzxCtxgdefisk9Q3UuVzlPpvYk1RHY49DnwAE/mcagy0UphjZlRwtrRkoC5ETQMoE958LskYGN1KDW2iOVn6q9CBjW9PS3uaIft/P5l59hjxIeNIWFn4LlR+MD5QBN4+ANkT4GTTzxNzcJKQSFcyczylKUdL9V6W7UlpnlvfA+8ucpzJaDIiZ1FINyGMP+r1i0fwGiPUtnimkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/mk61btYcv1OEYSX+DhKxxi6MAAYH16zL4v6d8RwoI=;
 b=nozo3DDX8KUmcKijzC5vOPso9d049dcu6r322schob4Bdk4zyaBQoHSlB7dGA8O+sExtUAzyoT974J4w/duS7I8qIo8vAU75WiMtZ0fGebpaNlFt2vVJogofOhd8O3JfZbKww3D6VngWF1sUO0TMTLWt6rgw8vkIyxruSi3k/ZgLpUnBnCivKLwh38C0Xqp8WZJjLyXpoCUFlpVxl6J1ODR5FNJNZKtnDFDT0ALMPqaG8J44IldHTa2n9JDQzmkyU/U3Ob7Cz4Ki8cO1KoWpuBC37QtQYYlmbua5ie0i2qgeU3kMakbiMmpRXCMLC1wkulqo+vjQF1Flkj09lvB29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/mk61btYcv1OEYSX+DhKxxi6MAAYH16zL4v6d8RwoI=;
 b=S84F67IdhXyq4/ghiNAApWdQQvG3KcA9Fj6RF16GWhmeNqXPZbi+dhOhB6yLH4CK1kIO67ysoUHnuP1UiUhpS4bT6Rqt6ut0zlPzGvcefwou5osaJ54MQAOPcGqoq5AQEXXnlOJfaOcF5MIAk8OpBZ+CdU8Z12mZ6no5G6Eh2RM=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6639.jpnprd01.prod.outlook.com (2603:1096:400:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 05:36:44 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 05:36:44 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: mmotm 2021-05-12-21-46 uploaded (mm/memory_failure.c)
Thread-Topic: mmotm 2021-05-12-21-46 uploaded (mm/memory_failure.c)
Thread-Index: AQHXR7jdyYVK6N0FZUeq7PdbRdsEQ6rg5HeA
Date:   Thu, 13 May 2021 05:36:44 +0000
Message-ID: <20210513053643.GA661371@hori.linux.bs1.fc.nec.co.jp>
References: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
 <91fd4441-b84b-ceb0-8d4c-c62e631711fc@infradead.org>
In-Reply-To: <91fd4441-b84b-ceb0-8d4c-c62e631711fc@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f571d10f-1df1-4e33-d87e-08d915d117f4
x-ms-traffictypediagnostic: TYCPR01MB6639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6639E07878851257D0F30CD2E7519@TYCPR01MB6639.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/3drPkVhc3S8WY8o1ivsenIvKGhbJh2ZrmG3X98Ek+HUn/v/1U4yyDUu+6Eqr1m53YCEBw8wgx0X9rk+hVtpO8zOxJ9bBlnbVDOmKm1oXIQWotGW2uEw2SzzvuR84SzIZeu8+y0cTkQHlUKCe9iiuXeKxwnffH2Hq1m0vH3yKM3BMnniAZ+7ukIR2dicWV6SWsnjyZilytva3hmQ41u40Fj2UwJj4M9+xUKzmZBde6XZCxnI3BwNvqd2xRIUXwh4s9hR6B3bhh5BeTTxF/MObpaSyvlcGPV0P+MG9kURtqkPpWnoa6He1hBnlh0kdUcKKDvvjP/Vdzo6+m01HFdBT1WRV5L6N1X6AbSElXrYb2HMQcj/j9vrZlqkxttlhindtjnFMwudNfrsuPHsZ/+6wBNQXm9pvC/aTiSbURzLXnPYrHpmMvqnXp2GwczBWK/oBmR/70voS441BYvVEaAngsb9uio90pZ5KNUwyVS93s2JkDtR7bE15f4JKe9tO87qhREsXNQetJ4hOH1fTYWXITre1hQQD3aObAv19RINjcclVxkjCKEQ6aKrj/xfjNuUT/NftJPKu8Lncfgid4DV0GbOY5Md4snGmkI8jr5g+mgXHK1BDS/Yx9wr/BTwdNMDFfUNYbJGCKp59yEIqMwgBaaiDnqRmAorgz3pxSiAQmi9i9j2yWIyZs2G1s0D/9D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(54906003)(85182001)(186003)(71200400001)(110136005)(83380400001)(4326008)(2906002)(33656002)(316002)(6512007)(86362001)(64756008)(66446008)(66476007)(38100700002)(66556008)(122000001)(1076003)(8676002)(76116006)(966005)(9686003)(66946007)(7416002)(6486002)(5660300002)(6506007)(26005)(8936002)(53546011)(478600001)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QU4yV0I0MWt3K1A0ckhWdmNGTFBEaTRmWEgwbjhjTjF1M3ZweFVFUm0zTjlm?=
 =?utf-8?B?VzJ0NzRrTkphN0dla0pLRFdkYVBFQU9aVG9DQkt1Y21lcnVsTjN3NWd6NnVJ?=
 =?utf-8?B?dHRaRE1EK0xJTk54RXN5ZGlNZktzd1kwUXYxcmNSdEpQOW83Q01xQVlvRDJY?=
 =?utf-8?B?MFVrSEp3WmJBUG5uOFdxQkRCQWVKN3QxaXVyM3M0bVlIMXZEMnFXZVd3Q0hy?=
 =?utf-8?B?VkFXdXhrSDkzSmthOVpzWjlwY1JPZyt2RDVtczdRcG93OG14OUFtNS9MTFBG?=
 =?utf-8?B?N2N0amVmV2JDQ2NSZkgyWTZvY2E5am1pQzNrd1JTNmNvdjRlbGdJMXYvRGNW?=
 =?utf-8?B?RVB5M0cwb2RsYWlzZ1daWTRqSWV6anVXSmsrRHkzU09mRm51R2RhZytiYjBl?=
 =?utf-8?B?RC9YUTJMa00zU3dTTmovWXYxL2RtNllwRVVRSnRiZERuelBGa3l4OFdmUkQy?=
 =?utf-8?B?VFpySXpjYU02emNySVZmZGxEbXdnQlZIK2dmSVg2Q1NuY21aalBMQkdZb3E5?=
 =?utf-8?B?dVhuMGh1Q0ZUcTBQUEJvaStEQURzaWRWenE0NjRMR3NuaGxHWlMrWGJBd0tx?=
 =?utf-8?B?NDV2M0R2N21Rd3c4N0lEU2sydTYwL3Z2OGMvdm94ZGN3V2w4c2hjOTRwOU9E?=
 =?utf-8?B?SUJ1UkxQWDllblFwS0RlQXVLSWoxSXdUNDhIcnZEWjUzUHM5TzF3VGRrK0No?=
 =?utf-8?B?Z0tXUnhETmt0ZDdvdXJFMEhuMXFBZXoybzNpNzNBUnFHSWhvMUdnaTZOYnhQ?=
 =?utf-8?B?TDFscHJrUzd3QlRxWTlyZVNTY1l1OGY5YnhIdmxLNllYRGtnb1dVQ2RaOFN4?=
 =?utf-8?B?MlpiUEdvZ0Y4eXplZE5STmovUmJZSlY1aUN1blp1QTVwZ2NjcWpNbThkUnZD?=
 =?utf-8?B?YkhycWN4STE1YTZVNVlpT002YjhZQzIxQXpOb3FWMmxIYmNKNlorL0ZVaU9U?=
 =?utf-8?B?SG5xcGtFbXNzSDVJd0dzaURXODdEVTdUNEJwMlkwUm9Rd1R4cTdhY2dHdEp5?=
 =?utf-8?B?d0hqZnZSczNKYXkwdGRPQldVeElubTUwb1poVVpsUGlrcmRHVzZWRk1rVWF1?=
 =?utf-8?B?bmM0Qkp2Q0hpQ20vMU9NUHAxNnI3cm5vdTFBWFdETGcwUXk5V1FnOWNGNTlj?=
 =?utf-8?B?eWt4dXFLZnI1dVpzaVZOTHRoMWdTRXpDanpKUW1iOXVJdVlCaGdzVmdMOU9j?=
 =?utf-8?B?ZzlFbmNGNjQ5Wm8xQ2RVUVRmV2NhTEl6RmNWUmcvK3JjVnhCZHEvS29OaXJD?=
 =?utf-8?B?Qmpvd2t6QTJDcWFQZmtDOHVXU2w5VDdYQ2pmRWpqZnpzMFp5R2dRZ0dxVHlR?=
 =?utf-8?B?bUdieXlqUlNUb3RwUmp4d1RiV1E3T3hHYnVPQU96V29ibEpMYnJ4ckloU3J0?=
 =?utf-8?B?MkZwTU4rVStXVSs0ekYwV2JuUlVTSHk0UGZJVU1tdmpDNUdXay8vUUVYNnRw?=
 =?utf-8?B?bTJmZkwzeHJEODdiZGVCcDQySFZRQXkxUU5Fejg1WnhKV3ovZXdVV1kwaFg3?=
 =?utf-8?B?YllvQnBxbzBUemRUSEZxZXZVaWxrc1UyaDc0aVZuZTJMcVMvYzMrZXJQd1Y4?=
 =?utf-8?B?R0Z0ZGRBYmNoTy9NWlpxWUhlbkg4bXk0SlVadWVMUFhJdW5IN2UzMERobitK?=
 =?utf-8?B?RnQ2S0V4UHNMZjhMYU9UaXBWVU82NTJyTGsxdDIwbVhOaUFETGdrTjBBN28z?=
 =?utf-8?B?NVIvZE80c2JGOU84S2ZIR2JSZWxFMXR1aGxFbE9SZmMyN3NmZW9oT0ExNjBQ?=
 =?utf-8?Q?iNoijuS6y31/ga1Vc4c5fEYCOdF6f0sKOfJTTOh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91C4D4D30EBDC24995211F00F2F506DE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f571d10f-1df1-4e33-d87e-08d915d117f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 05:36:44.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fM0xIwUkNadzTIEVP7Yd+GGASe9wIMVwbjirpm8v1Y3kUas8JB+3fh96ieK1hvZZvDFk8C07+37v1rcFMw7h9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6639
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgMTA6Mjg6MjlQTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOg0KPiBPbiA1LzEyLzIxIDk6NDcgUE0sIGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcgd3Jv
dGU6DQo+ID4gVGhlIG1tLW9mLXRoZS1tb21lbnQgc25hcHNob3QgMjAyMS0wNS0xMi0yMS00NiBo
YXMgYmVlbiB1cGxvYWRlZCB0bw0KPiA+IA0KPiA+ICAgIGh0dHBzOi8vd3d3Lm96bGFicy5vcmcv
fmFrcG0vbW1vdG0vDQo+ID4gDQo+ID4gbW1vdG0tcmVhZG1lLnR4dCBzYXlzDQo+ID4gDQo+ID4g
UkVBRE1FIGZvciBtbS1vZi10aGUtbW9tZW50Og0KPiA+IA0KPiA+IGh0dHBzOi8vd3d3Lm96bGFi
cy5vcmcvfmFrcG0vbW1vdG0vDQo+ID4gDQo+ID4gVGhpcyBpcyBhIHNuYXBzaG90IG9mIG15IC1t
bSBwYXRjaCBxdWV1ZS4gIFVwbG9hZGVkIGF0IHJhbmRvbSBob3BlZnVsbHkNCj4gPiBtb3JlIHRo
YW4gb25jZSBhIHdlZWsuDQo+ID4gDQo+ID4gWW91IHdpbGwgbmVlZCBxdWlsdCB0byBhcHBseSB0
aGVzZSBwYXRjaGVzIHRvIHRoZSBsYXRlc3QgTGludXMgcmVsZWFzZSAoNS54DQo+ID4gb3IgNS54
LXJjWSkuICBUaGUgc2VyaWVzIGZpbGUgaXMgaW4gYnJva2VuLW91dC50YXIuZ3ogYW5kIGlzIGR1
cGxpY2F0ZWQgaW4NCj4gPiBodHRwczovL296bGFicy5vcmcvfmFrcG0vbW1vdG0vc2VyaWVzDQo+
ID4gDQo+ID4gVGhlIGZpbGUgYnJva2VuLW91dC50YXIuZ3ogY29udGFpbnMgdHdvIGRhdGVzdGFt
cCBmaWxlczogLkRBVEUgYW5kDQo+ID4gLkRBVEUteXl5eS1tbS1kZC1oaC1tbS1zcy4gIEJvdGgg
Y29udGFpbiB0aGUgc3RyaW5nIHl5eXktbW0tZGQtaGgtbW0tc3MsDQo+ID4gZm9sbG93ZWQgYnkg
dGhlIGJhc2Uga2VybmVsIHZlcnNpb24gYWdhaW5zdCB3aGljaCB0aGlzIHBhdGNoIHNlcmllcyBp
cyB0bw0KPiA+IGJlIGFwcGxpZWQuDQo+ID4gDQo+ID4gVGhpcyB0cmVlIGlzIHBhcnRpYWxseSBp
bmNsdWRlZCBpbiBsaW51eC1uZXh0LiAgVG8gc2VlIHdoaWNoIHBhdGNoZXMgYXJlDQo+ID4gaW5j
bHVkZWQgaW4gbGludXgtbmV4dCwgY29uc3VsdCB0aGUgYHNlcmllcycgZmlsZS4gIE9ubHkgdGhl
IHBhdGNoZXMNCj4gPiB3aXRoaW4gdGhlICNORVhUX1BBVENIRVNfU1RBUlQvI05FWFRfUEFUQ0hF
U19FTkQgbWFya2VycyBhcmUgaW5jbHVkZWQgaW4NCj4gPiBsaW51eC1uZXh0Lg0KPiANCj4gb24g
eDg2XzY0Og0KPiAjIENPTkZJR19IVUdFVExCRlMgaXMgbm90IHNldA0KPiANCj4gLi4vbW0vbWVt
b3J5LWZhaWx1cmUuYzogSW4gZnVuY3Rpb24g4oCYX19nZXRfaHdwb2lzb25fcGFnZeKAmToNCj4g
Li4vbW0vbWVtb3J5LWZhaWx1cmUuYzo5NjI6MTU6IGVycm9yOiDigJhodWdldGxiX2xvY2vigJkg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCY
aHVnZV9wdGVfbG9ja+KAmT8NCj4gICAgIHNwaW5fbG9jaygmaHVnZXRsYl9sb2NrKTsNCj4gICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+DQo+IA0KPiAtLSANCj4gflJhbmR5DQo+IFJlcG9ydGVk
LWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCg0KVGhhbmtzLCB3ZSBu
ZWVkICIjaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHRSIgZm9yIHRoZSBhZGRlZCBjb2RlLg0KQW5k
IHRoaXMgcGF0Y2ggaXMgc3RpbGwgdW5kZXIgZGlzY3Vzc2lvbiBhbmQgbmVlZHMgdG8gYmUgdXBk
YXRlZC4NClNvIEFuZHJldywgY291bGQgeW91IGRyb3AgdGhlIGZvbGxvd2luZyBwYXRjaGVzIGZy
b20gbGludXgtbW0/DQoNCm1taHdwb2lzb24tbWFrZS1nZXRfaHdwb2lzb25fcGFnZS1jYWxsLWdl
dF9hbnlfcGFnZS5wYXRjaCBhZGRlZCB0byAtbW0gdHJlZQ0KbW1od3BvaXNvbi1maXgtcmFjZS13
aXRoLWNvbXBvdW5kLXBhZ2UtYWxsb2NhdGlvbi5wYXRjaCBhZGRlZCB0byAtbW0gdHJlZQ0KDQot
IE5hb3lh
