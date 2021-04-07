Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1B356C11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352154AbhDGM3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 08:29:33 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:46082 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352148AbhDGM3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:29:31 -0400
IronPort-SDR: 9GmG6k+ATVr6pdXNs/WQqIEuQFMLZ/Ile5tpe9T8DgaKufQyFp0/h6pEA05QRVF5l2n1M4hd0y
 fJYJ4ICoxMR+SLoC1KGsFyG0iwBwZTMyUy+JVJS3bXRITnfBm3zmxF9blLib71qfkAmcE2BZ9d
 rodGHBpPF/PL5LOMmaS2Gc3PyV7aqoCFCOdvzCw7ud6XPd2eFXJIlquXkd4w2JddlgT/NyCLJk
 XSAueUAafnElQIy8uRY2bJEzbca9p8KSsdrYLH1v8kfH5t5hKpS+1k7N5ZSCneLzyUHNwJ1/4X
 UFw=
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="29261524"
X-IronPort-AV: E=Sophos;i="5.82,203,1613401200"; 
   d="scan'208";a="29261524"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 21:29:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqRdJn3i0NKhSV05C8D44Ih3qbLpZxQOJbfqY2N2Batqis2mNMgKs4OI2yqZmLWmc9/2tqXvxi69rkYZqjO341FCQEjvjBv1jqNBkBhJ1DZ8RSXcrfsjnm/ACTwuFPXpXmHbBVrdBQRNR8u6Wcytqwgv/ZGJSE8eTHg443EzrQFa8lYy9wPexxAm7n4r4Khq7kcSBXAYHpx7vY/u+T6rzhuw5Xp+2gdeNXOsRrxOsuZxt/PSKhqI5eUoFjCpQdrddUldkhE3LenhZvyl+5otzXo5BzbPsqRYJFj3KuRWb5GdRHD/sjdKMHFXQEJ10hge8/69CVZA6HkXPm2nt+M9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFS+LKDg8+IcBsytAsmxUDCgv7LLet7Y9JiTGWfLnqA=;
 b=Pq7F/6kot+VIvVovPcjgRC8KKHufbSKRhrFYA3E4KPyfW3rqmyPVG3pytx+Z20jA17cFEdh5DsyHVhRVNozFJiKh2Se9vD0nbqfZBOTsQrJzKdWEeG5wh+rkMBmRrad86PVOR33xfH73NNnJUPRBX85fRC6Ydo6LGTsTjwxoyYRLX2dxZMSfuDrrUdPJk6tqH6UXHNgdbira8RUz5nj3AmiKuhvjOuOwzWxZP/uBJDkJUWw2VOVZ4nb2sy4KFZZ4wQ2B6PRuMQhENA+XOFE5qYKOZcBfMnR7cSBZzCwusiuippMptx7pGzhCasFHExNipkkPGelpyerHxVmiAwfFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFS+LKDg8+IcBsytAsmxUDCgv7LLet7Y9JiTGWfLnqA=;
 b=VgJPlykFU/cO4xn0j/6DnWZjrXEUO2sB9/O+5kbafI3dy+DPvRIqTqJm1dNKyeV4xRQpbT9xhM5QZrMIDQgN+cUohNkcioA7oUsH+DPt5A0Rt2U+XarN8ECo/q7y38B+2X7sCB6d8Ooc/sJV41THrHGTZvbh2kLYz6X+IE/UZMg=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OS3PR01MB5686.jpnprd01.prod.outlook.com (2603:1096:604:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 12:29:13 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 12:29:13 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Ritesh Harjani <riteshh@gmail.com>
Subject: RE: [PATCH 1/3] fsdax: Factor helpers to simplify dax fault code
Thread-Topic: [PATCH 1/3] fsdax: Factor helpers to simplify dax fault code
Thread-Index: AQHXK3fd/Yc+yjqDB0KdDizDnw40hqqo50KAgAAUs8A=
Date:   Wed, 7 Apr 2021 12:29:13 +0000
Message-ID: <OSAPR01MB2913CC6A36BFBBCDCFBE2B9BF4759@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210407063207.676753-1-ruansy.fnst@fujitsu.com>
 <20210407063207.676753-2-ruansy.fnst@fujitsu.com>
 <20210407111355.GD2531743@casper.infradead.org>
In-Reply-To: <20210407111355.GD2531743@casper.infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5804fb02-44e9-47a1-a319-08d8f9c0c085
x-ms-traffictypediagnostic: OS3PR01MB5686:
x-microsoft-antispam-prvs: <OS3PR01MB56869E5CA404A31C5DD74DE7F4759@OS3PR01MB5686.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1E3+6+lKIgZ4V0YajdKDKsbUZmugOEKq0gIV3fQEi3BB7ONvdjrGWTqdjsDLsWug1r1aET7g5dJuUXRYCPwUGO0V9jXV9XctKPzy5YKRTkxkR0t4IEMAjQl0bx8uxFDCyDK+ArNurFfArprVbHdZBFxqj8hXdaflNpdlL3gE7GmuhdFelAZzP/fhf2bVWa9kLvUwIj57mWei+y3Ht996Yt2EWYFhPGfp6y4375ICe3yNSg5gNjohXhk7Xr+RS5fVxOoPArRwfvTvdKoh2RLvbOphT/az/RoJy6236EeeK5Zv6ynTKOJ2T5O1fT83blyW8ZprY0qR4iccAKGh8m7WV7HUPB1xGCx6AniJkMOg14heqAgLTjUV1cSkW9otTLPryKjaTCVj2biNP1jv7n+1SJjk/fnAipktjTZL65aBzdhCHjZfppVTM/UCj0wS0ILzlNFEKQKM00b/cikqMBGEJTIWdeKvfmGZlMUIefxr2bD8cfowv6n/8igZ7QJum3tU1Rrd6VsghoyFUEW4C4Zu9cIAzlt4G5Wu+sfE5GMZch5f+XJKtFCVhlQlb10osW7Bg9Qd2DlIM9y3UrgzpI9ZJSE59yHvOKS3dg9a7wXhTHVs1vzpo3etGGVn5gsyEs2pcASESNo3B7J3s1pAefgXFc1S3DiK7eiiGSkV2IhFeq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(66476007)(66446008)(83380400001)(55016002)(9686003)(71200400001)(6506007)(53546011)(6916009)(52536014)(316002)(76116006)(66946007)(66556008)(64756008)(4326008)(54906003)(5660300002)(8676002)(8936002)(186003)(85182001)(86362001)(38100700001)(478600001)(7696005)(7416002)(2906002)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?V0lMWW1DZXUyM20wUnoyUU1PRkE0akh1WSs3cHI3cldib0s2VUYxNmFDM0Rt?=
 =?gb2312?B?elRlck1ieElld0MxaysvdmVlUE44NmpNbW9LMHZSbDV0SzNra2djU3FGcElV?=
 =?gb2312?B?OHdTaVF6Ym0zaU4za1ZzVHViKy9CZjhTWWNRN0pDckFhWk5BenJTRHBnQ1Bh?=
 =?gb2312?B?RHpWNndVMVpzemdKWkwrL0tBNXROaTF5ck1sS25ZMkdMdnVaNnBhNThtNkQz?=
 =?gb2312?B?ZzcyS2hJMk5YQzdzRmRCSmtrNGQ3dFM5Z011VGtZdG0xemU4OXAwOWhVQUdy?=
 =?gb2312?B?THdVTnF6NEFkRFRuR3ZRNW54WjFDWFdENThBcTNVb1RBZVRuT0NRV29FMEZW?=
 =?gb2312?B?TTJzWk1odHMwUGlBV0NVamV5cG9tWXY0VHNBaVBldzRSVE9ZN1JxbUVjdzl5?=
 =?gb2312?B?NkRmdit6Vnk4VVlCTkdPN0ovbGJqOXRSQlJoTkpCMEZ1alZ5VTEvSW04YldY?=
 =?gb2312?B?ODRwMCtpRjBiWndMZFpVVVVybU9laW5hQjBHYmUrdFRkUGdaTWFNdFROMHdU?=
 =?gb2312?B?OXZkSzRBLytBR1I0WUtOeTdpWWVteHUxRktKSFU2N3ppcGE4Tmx5YTIvNWtN?=
 =?gb2312?B?bjIvaEIxaW9kcUFrc3V1VmVXMTJKSE8zVkZsS0JKc1BYNDhvZGQzRXZWUEFO?=
 =?gb2312?B?WU5OQmZMU0tqY0NUTnlKeTVHaFIybjJacXVya2pZcDJhNjRVdlBzVXFnY1RC?=
 =?gb2312?B?MHBBZkozcGR0ZjlxZjJyYUVweGk4cDluWUR4YmlhY3F4aFVQOEtrMXc5TzFY?=
 =?gb2312?B?TzRHa2N4Z3ptYnlRMDNlU1NDSXRlVGg1YmIrQ3Jmd1ZIeTEwNXVRVGdEREli?=
 =?gb2312?B?VmxNRkJuODFWV0VjYVNVN2l0TEtqYXlqeTlDNi9ISjNWV016OVlZT0xsZU04?=
 =?gb2312?B?RnlaV3U3K0poQTZRK3QwUVEvWkwvZUpUTi9Wc2VvcGROczg1bDk4dGo1RG5y?=
 =?gb2312?B?K0ZSOU9UV2YwZGJDZXZDWWpDck1BdGc0akszVGZpSXZ1YkhMZkp2Nlg1b3ZY?=
 =?gb2312?B?Smo2ajhDajlZMi9TS1V3bTRRT1YwVmtUdDlWTjEzall5aDZtYlI5djVCOVlB?=
 =?gb2312?B?Z1poODNkWGVqaWJweE16ZW94QVJiZlRSU2pRSVpJSVZMVXhCSWY5RzJidHhP?=
 =?gb2312?B?SEF5MDRFVGN6T3NPQkJxQU1MRW5lWFhOa1c5ZXJjQWlwMGtxd0kwdHhLeTFR?=
 =?gb2312?B?QjdSenJCZktCb0Z5UlozcHdhVzE5S2JMMnp5dGtjYVBmUWNYMDZxcFpxeWJj?=
 =?gb2312?B?MnJCT1ZJR0ZuRkFGaUpRM3crcDlEZVRjUjlpWXErb1FFT29ocGZqUlg1cTZr?=
 =?gb2312?B?TlRoS0JCaHl1N0liMHhEU2FkcTFycG5mR20zYTViTkxlNHZzMUVHamhyeWNG?=
 =?gb2312?B?akdoVGNNQzI3bTljWFl1Y3dFaW1zLyszMjYvTlVLSklsTW1VbGtoajNiY0dI?=
 =?gb2312?B?UjY1TWRiWEduUGtERlk5dXJWN1cwZXprb091VXVOTFBzTXNEejNzMjVSYmZy?=
 =?gb2312?B?NXhpa21QcWlpZERXdVFtc1dTYlRuWStGSjlrbEM1TVFFNUNUMXNMNm1WK0NM?=
 =?gb2312?B?VEkvZnM3Y0JjcC9ZOHUrUG4zSlpnbG9QTW5QUGpDdlBzREx5cURjdW5VK3gw?=
 =?gb2312?B?V0lMSFZFL21EdVJraDFLVUhqbVVwTHN2OW5LTTA2Zkx2N21BYUtpRytwejlP?=
 =?gb2312?B?OTNGeHd2MENicDJ4RWZvRXovVkZBSHNlN3JYcFAxS3MrSHQ0cmh1WG1zYU5V?=
 =?gb2312?Q?A80/DgdCCJPlucn6v1HOyBHPimHgLVvc6DhjB0C?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5804fb02-44e9-47a1-a319-08d8f9c0c085
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 12:29:13.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c+HDiTfCO55CJmmksL7M2QoC3bDCJTYSLTMLtnNaYmFnjqKFyEQmbahUO9P1viEgMRkfVAHIjBL7TUIkhLwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5686
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGhldyBXaWxjb3gg
PHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgNywgMjAyMSA3
OjE0IFBNDQo+IFRvOiBSdWFuLCBTaGl5YW5nL8juIMrA0fQgPHJ1YW5zeS5mbnN0QGZ1aml0c3Uu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgteGZzQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZzsgbGludXgtZnNkZXZlbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGRhcnJpY2sud29uZ0BvcmFjbGUuY29tOyBkYW4uai53aWxsaWFt
c0BpbnRlbC5jb207IGphY2tAc3VzZS5jejsNCj4gdmlyb0B6ZW5pdi5saW51eC5vcmcudWs7IGxp
bnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZzsgZGF2aWRAZnJvbW9yYml0LmNvbTsNCj4gaGNoQGxz
dC5kZTsgcmdvbGR3eW5Ac3VzZS5kZTsgUml0ZXNoIEhhcmphbmkgPHJpdGVzaGhAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZnNkYXg6IEZhY3RvciBoZWxwZXJzIHRvIHNp
bXBsaWZ5IGRheCBmYXVsdCBjb2RlDQo+IA0KPiBPbiBXZWQsIEFwciAwNywgMjAyMSBhdCAwMjoz
MjowNVBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgZGF4X2Zh
dWx0X2Nvd19wYWdlKHN0cnVjdCB2bV9mYXVsdCAqdm1mLCBzdHJ1Y3QgaW9tYXAgKmlvbWFwLA0K
PiA+ICsJCWxvZmZfdCBwb3MsIHZtX2ZhdWx0X3QgKnJldCkNCj4gPiArew0KPiA+ICsJaW50IGVy
cm9yID0gMDsNCj4gPiArCXVuc2lnbmVkIGxvbmcgdmFkZHIgPSB2bWYtPmFkZHJlc3M7DQo+ID4g
KwlzZWN0b3JfdCBzZWN0b3IgPSBkYXhfaW9tYXBfc2VjdG9yKGlvbWFwLCBwb3MpOw0KPiA+ICsN
Cj4gPiArCXN3aXRjaCAoaW9tYXAtPnR5cGUpIHsNCj4gPiArCWNhc2UgSU9NQVBfSE9MRToNCj4g
PiArCWNhc2UgSU9NQVBfVU5XUklUVEVOOg0KPiA+ICsJCWNsZWFyX3VzZXJfaGlnaHBhZ2Uodm1m
LT5jb3dfcGFnZSwgdmFkZHIpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBJT01BUF9NQVBQ
RUQ6DQo+ID4gKwkJZXJyb3IgPSBjb3B5X2Nvd19wYWdlX2RheChpb21hcC0+YmRldiwgaW9tYXAt
PmRheF9kZXYsDQo+ID4gKwkJCQkJCXNlY3Rvciwgdm1mLT5jb3dfcGFnZSwgdmFkZHIpOw0KPiA+
ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlXQVJOX09OX09OQ0UoMSk7DQo+ID4g
KwkJZXJyb3IgPSAtRUlPOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlm
IChlcnJvcikNCj4gPiArCQlyZXR1cm4gZXJyb3I7DQo+ID4gKw0KPiA+ICsJX19TZXRQYWdlVXB0
b2RhdGUodm1mLT5jb3dfcGFnZSk7DQo+ID4gKwkqcmV0ID0gZmluaXNoX2ZhdWx0KHZtZik7DQo+
ID4gKwlpZiAoISpyZXQpDQo+ID4gKwkJKnJldCA9IFZNX0ZBVUxUX0RPTkVfQ09XOw0KPiA+ICsJ
cmV0dXJuIDA7DQo+ID4gK30NCj4gLi4uDQo+IA0KPiA+ICsJCWVycm9yID0gZGF4X2ZhdWx0X2Nv
d19wYWdlKHZtZiwgJmlvbWFwLCBwb3MsICZyZXQpOw0KPiA+ICAJCWlmIChlcnJvcikNCj4gPiAr
CQkJcmV0ID0gZGF4X2ZhdWx0X3JldHVybihlcnJvcik7DQo+ID4gIAkJZ290byBmaW5pc2hfaW9t
YXA7DQo+IA0KPiBUaGlzIHNlZW1zIHVubmVjZXNzYXJpbHkgY29tcGxleC4gIFdoeSBub3QgcmV0
dXJuIHRoZSB2bV9mYXVsdF90IGluc3RlYWQgb2YNCj4gcmV0dXJuaW5nIHRoZSBlcnJubyBhbmQg
dGhlbiBjb252ZXJ0aW5nIGl0Pw0KDQpZZXMsIEknbGwgZml4IGl0Lg0KDQoNCi0tDQpUaGFua3Ms
DQpSdWFuIFNoaXlhbmcuDQo=
