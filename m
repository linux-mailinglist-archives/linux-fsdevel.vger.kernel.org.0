Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FDE37F3B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEMHuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 03:50:06 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:36223 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230318AbhEMHuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 03:50:04 -0400
IronPort-SDR: 91ai3ZutwbcG8padoo+45WrebX6xiv8Boyyo2SfCCxkPs7X2PYH/dZ+yQfaUDjeC9/DctlcoSJ
 lQM41EMWFR6oTnqfAIO7J9lrfVDh3A4q156hCWVZw6qulkbjKjuH72YDZdPvOXaBEajwKR0KFS
 OFWLQNX9jT8wpgr3mvYOJSS7tMHrxtyS4j4gJqf9GTd2f7/1GVOAAo1/E2vvoAzbQpr+ECil2N
 bp4PPCV49UDnBQeGSiZVPpUZ46TWp8IAlwq4c0VhXUhMj0CP0EHckd9NkUH/b4LFvKXW3yObnv
 opQ=
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="31120942"
X-IronPort-AV: E=Sophos;i="5.82,296,1613401200"; 
   d="scan'208";a="31120942"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 16:48:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjNoBn5DAI8ILKRuJAYnquIJ2VXIkW4lnbzfBwHW2fMUej2+fAkQvnN0/aK96eXycic5Z/zDaeKpMprQfmLHL7LRTqagARvHB6uQ/fAi945+TXS7JbdcdrTrqx9uEYIpIfRloLfnsP7VChkY/m96n8Ks1x8Wr06Uki5+8sxBr75YHB2U6k4wmBwO+AvC+PltEf1dkvOxs5noxtv/gtZIMyhg0A6Ht/LblTcRc9dz8BsEei8q0k2VJGsN0MuustWvvNsNxx5j2cJlKV1C4fav81iVCO4tR0xPSWpvzqMngd0Efj8Klmi4FnOIQN6csxAWCnRIKUZV2KbjrZCBT+NywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=909CQEj0V5ekvY6VDrxY0ZWBd0QVFLHsM3KJCzf/1eo=;
 b=jo2N4mXsaViSbJzRerjfQn1wVw4qwLWv9wAgjwbx55CqR1zcKS3JORziSt3b7V2bhTz55PLzlk09t+w0ydtEVKVbzE6ogeSzRUwFG1WXJZKitkn4+57v66JRt7fcKVdMk4kpR0g/FNCfuLWimPNzWpjZAyPb5Sb5JA0aZNj1hw9hIteXJRIpb1gfzbaVtSZa53nA+H87daZGN+iCvyjiahnewLGbs27WEaPz6vEgu3x4bGbbiDyJLToiMVRtAunGScjNsIHXVxxNsbwwExuUgXh2ZV4Qh7/DU0iJIcPEZ9Bi78tjplkRmFu9lKL7CkGVIZZF8GjP5+RJj7tNre2Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=909CQEj0V5ekvY6VDrxY0ZWBd0QVFLHsM3KJCzf/1eo=;
 b=cWvlLKRy/kZWm/mJyn3Z0aidC6oTrnfIEBgF74f20x9WWyYb2k4T9PywcEAFMqWKTsm+pNiKGNxqfSTwi7gqdkEwoQgpVPwIhVN9e1HUezq1fhW5ZmbsrhvM7X0WbVa/UqxJHYCH0I8WI4I26zZCgL25IgEW/QTnZ9OHfwseo00=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB5587.jpnprd01.prod.outlook.com (2603:1096:604:b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 07:48:47 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 07:48:47 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     =?utf-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@nextfour.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: RE: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Thread-Topic: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Thread-Index: AQHXRhMzaICBJaaoNUiclL46cJ8Bn6rfIH8AgAHrs9A=
Date:   Thu, 13 May 2021 07:48:46 +0000
Message-ID: <OSBPR01MB2920731784E0804AD7BB0DA8F4519@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
 <4c944ccc-7708-5dbd-18c3-9ecb5c3a539f@nextfour.com>
In-Reply-To: <4c944ccc-7708-5dbd-18c3-9ecb5c3a539f@nextfour.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nextfour.com; dkim=none (message not signed)
 header.d=none;nextfour.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a496d8-77ba-4d4b-3e5f-08d915e38a4a
x-ms-traffictypediagnostic: OS0PR01MB5587:
x-microsoft-antispam-prvs: <OS0PR01MB5587E058A954026B63272EE8F4519@OS0PR01MB5587.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X64Y9/GI5aaLb9miKYzE4PVsXWiZ1gakiMXS0hGXFpJFOelVdwJGcMYcG8HD9ZIAug6X0aBKhl2w0gp39n5+9bkqDBLLG2rC5Rove/7PaZyYMlV0F8VgWYbo9MXxy/IA1KR1Vpf6O47t4eeFURngFT8U0a2Bt41Jfoeza0NQQ0YjGOTqL/9fOLizWtzO3/lTbfSL1HdbqJZSlvEZWmwVJMPa1u/fO7IAFWHAVbuHJGCJKVjfYPr01TmLu/rQrK1xTXTySrYE0JQd0Yaz5mm7W1Ik9Vt3izb2fYPXagQKZQtIjqB712re9RuvBe71pSo8nOyQxWLZgEmN29F6M0wxYGQ4fa5xrnsBgkodVEChTmTVHqcdnrEDgZaBikibIVM3hsGU708m5vVW/jW8S9rqtmys/4iyGEdNpMTZn5Zmg4iyT5YIPccSg68bb39ugeXazNQdsUVra2qawTiPUpe7l90veovHIqCc5oAQf1+5v4R5PzZ8J91ovDVUbaICT8qyd3jE4PkxYNRi1YHrvzR1odRuyeL+YtTbv8G8pCAHXux8+wBYFbHJY8x51SE3FVW6U11nncp7hezdnq091ZIIKfFd4TDfOiG1bfdVAahROOs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(7416002)(8936002)(66946007)(110136005)(186003)(54906003)(38100700002)(86362001)(66476007)(478600001)(83380400001)(26005)(76116006)(7696005)(71200400001)(66556008)(66446008)(52536014)(316002)(5660300002)(6506007)(33656002)(4326008)(85182001)(122000001)(2906002)(55016002)(64756008)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dHdQU1NxeEp3V3FEK084MU02Y28zK3JhSWc1N29JN3lsMUhRNElwajlIdE1K?=
 =?utf-8?B?TTQ5RDZ5WUFnL2lBa3QvSGd3bkNzQ3ZnK1dvdWxJSWRvZW0xYXRBOW9FVGg4?=
 =?utf-8?B?L1RGZDZiMjBnTE5aL1AyZGF6WmRMeHpYZDJzdE5TYVNmTUlWb01KWGFTTG91?=
 =?utf-8?B?Rk5rWnJGREhHQ3p3RFQvRmdoa0RPVEprb2FiS0s0SWZ4THNiWml4dzNid0tZ?=
 =?utf-8?B?Vk8za3d2enZ3Q3RPdy96dlRGenVYMU9xMy9DbkVRcExqQ01sVHN3T0hidzdt?=
 =?utf-8?B?eUhScUJDYmJqZEd1OFErWlBSZ3Bsb09waTg1bGsweUhLSVJ3VGpDM0xjNDFW?=
 =?utf-8?B?WC84bit1UG1veVdGMW9GWitXT0k3MjR1RVZZcUNCbTRWMm9GWlEwZ1Y1b0h5?=
 =?utf-8?B?UjZJdktqMEFPN0ZVVFRYRWdyZFhORmtOVU1uK0k2d0VnMEtrNUtNKzlkc1Vp?=
 =?utf-8?B?dVVFbDVBS24xbUtpOTFCL3JiWFFpRUlNZ2s2WXVaSmIyOUVjRHhza256Ukth?=
 =?utf-8?B?Z29URy8rK1FySVRySnVDTjFhWGxaY0dEL1FWN2pYa29Xb2F1REhzK1FyZGZx?=
 =?utf-8?B?UElwcGN3R09lZHFzVHVhb1JkMW8vSjNHWnlnYTV1bDNHL3l6YS9HaUlYdkdz?=
 =?utf-8?B?cE5BdmhjcHVVL2w1eEU1U2JXNU4wZWVzQW5BRkdkaGdsSFp0ZjVvZXhDWTJp?=
 =?utf-8?B?ZFlSQVVKdXRMaTFBY2Z6OTdZbEl0c1Nwd0xqOTF4dkt4c2FydWV1Ri9Lc1l5?=
 =?utf-8?B?TFZjaFJOeFNJd3kzaGw4SldwcFRXb3NLTXlVOFF2dlBCSDhVOGphcnhLVEdC?=
 =?utf-8?B?ZGZBZGlLaVZyM05HSCtjRDdYNTFxYVpWNW4yVkdINVErOWtta1l6alpHSzFi?=
 =?utf-8?B?RnhiUXE4SjFtRjRXbk9pdVQvUDI5RnZ3YlU2NUYwcVRUR0tRVHpDZkltK2tQ?=
 =?utf-8?B?c3hRc3U5eEVRZmYrZzA0enNHTm13dThGL0xNZ0JmbjVHc1hxYlNNVW96MS81?=
 =?utf-8?B?YUw1OEtlUVlZN1p1WHVvZ0JObHdhVlpVU0VsUG1qK0ZPTWFscnRMMjV5VUdG?=
 =?utf-8?B?Y2d3QkNyUFFnUzhJOUpYbEtqWVhKdzEvdEx3dzBxVE1QNlNtaEo3NWNUMW9m?=
 =?utf-8?B?QWVlcEpaRGQyVlltbHV4UnU0RDZ3Uk82Q3NzamU0aUxlOUNEY1I4Wk9GV1VR?=
 =?utf-8?B?UENsbk1OZW5aVkQrQWNXM3Zac25PL0FLditlamdsNnRvZnpCZ1FiTWVBTG5l?=
 =?utf-8?B?aHJPdmwxQ3padW5TeWVqTldmVjlTSUdHZXJHWCtOeDlaVnd6elNVUTRROW9i?=
 =?utf-8?B?QUV6NVg0VndKZWhBWkxuTkRDdlRIMU52UHFzOVJFaWJFVFE1NHI3NFNsd0lS?=
 =?utf-8?B?NlovYWhNcVNoRkI0UDF5ZFhKWWhrb0hka096ODZidEZNUk5vVVVVQkZZbnBP?=
 =?utf-8?B?RTlPV1NxK2hyTU1hR0dYWm85N2hCSU5oNllIbE9mL3lYZ1g5amttZFVyQWZh?=
 =?utf-8?B?ZGlZczYrZFhJNG9OczVDZFpSWnFDY0E4TlFGK1o4b2hoZC9RREh6ZUE1SG1Q?=
 =?utf-8?B?UC9kU1V4dTlwZjFoWExxcTZMdm5FdWVnRE5YbEtLclh5dEx6Y2Z2NXBMY1l5?=
 =?utf-8?B?dTFVUUc3ZG84cWlkRHFTS1ZkbVBFdEpKOG5Ga0d3NXlCZDBLclZkOVlSMlFp?=
 =?utf-8?B?RUVBQzEyMmU2SzVtUzFsaWsyK2ozUGFLYmJmak1UdWRJVnpBd1l5aVpsdlhx?=
 =?utf-8?Q?cbPJiLvi6HlRqTS4FWpdjav6hvFvVVBLESZ4GRS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a496d8-77ba-4d4b-3e5f-08d915e38a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 07:48:47.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaIpe7iUwSHtspEE/RUKaJdPRKMe1uZvpxxx6wPmlPw6+BomqzSVjUl/c+OX6DLoFVDgItWTj04IcmMYYO9beA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5587
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWthIFBlbnR0aWzDpCA8bWlr
YS5wZW50dGlsYUBuZXh0Zm91ci5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy83XSBm
c2RheDogQWRkIGRheF9pb21hcF9jb3dfY29weSgpIGZvcg0KPiBkYXhfaW9tYXBfemVybw0KPiAN
Cj4gSGksDQo+IA0KPiBPbiAxMS41LjIwMjEgNi4wOSwgU2hpeWFuZyBSdWFuIHdyb3RlOg0KPiA+
IFB1bmNoIGhvbGUgb24gYSByZWZsaW5rZWQgZmlsZSBuZWVkcyBkYXhfY29weV9lZGdlKCkgdG9v
LiAgT3RoZXJ3aXNlLA0KPiA+IGRhdGEgaW4gbm90IGFsaWduZWQgYXJlYSB3aWxsIGJlIG5vdCBj
b3JyZWN0LiAgU28sIGFkZCB0aGUgc3JjbWFwIHRvDQo+ID4gZGF4X2lvbWFwX3plcm8oKSBhbmQg
cmVwbGFjZSBtZW1zZXQoKSBhcyBkYXhfY29weV9lZGdlKCkuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBSaXRlc2ggSGFyamFuaSA8cml0ZXNoaEBsaW51eC5pYm0uY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZnMvZGF4LmMgICAgICAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0N
Cj4gPiAgIGZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMgfCAgMiArLQ0KPiA+ICAgaW5jbHVkZS9saW51
eC9kYXguaCAgICB8ICAzICsrLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9kYXguYyBiL2Zz
L2RheC5jDQo+ID4gaW5kZXggZWYwZTU2NGU3OTA0Li5lZTlkMjhhNzliZmIgMTAwNjQ0DQo+ID4g
LS0tIGEvZnMvZGF4LmMNCj4gPiArKysgYi9mcy9kYXguYw0KPiA+IEBAIC0xMTg2LDcgKzExODYs
OCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkYXhfcG1kX2xvYWRfaG9sZShzdHJ1Y3QNCj4geGFfc3Rh
dGUgKnhhcywgc3RydWN0IHZtX2ZhdWx0ICp2bWYsDQo+ID4gICB9DQo+ID4gICAjZW5kaWYgLyog
Q09ORklHX0ZTX0RBWF9QTUQgKi8NCj4gPg0KPiA+IC1zNjQgZGF4X2lvbWFwX3plcm8obG9mZl90
IHBvcywgdTY0IGxlbmd0aCwgc3RydWN0IGlvbWFwICppb21hcCkNCj4gPiArczY0IGRheF9pb21h
cF96ZXJvKGxvZmZfdCBwb3MsIHU2NCBsZW5ndGgsIHN0cnVjdCBpb21hcCAqaW9tYXAsDQo+ID4g
KwkJc3RydWN0IGlvbWFwICpzcmNtYXApDQo+ID4gICB7DQo+ID4gICAJc2VjdG9yX3Qgc2VjdG9y
ID0gaW9tYXBfc2VjdG9yKGlvbWFwLCBwb3MgJiBQQUdFX01BU0spOw0KPiA+ICAgCXBnb2ZmX3Qg
cGdvZmY7DQo+ID4gQEAgLTEyMDgsMTkgKzEyMDksMjMgQEAgczY0IGRheF9pb21hcF96ZXJvKGxv
ZmZfdCBwb3MsIHU2NCBsZW5ndGgsDQo+ID4gc3RydWN0IGlvbWFwICppb21hcCkNCj4gPg0KPiA+
ICAgCWlmIChwYWdlX2FsaWduZWQpDQo+ID4gICAJCXJjID0gZGF4X3plcm9fcGFnZV9yYW5nZShp
b21hcC0+ZGF4X2RldiwgcGdvZmYsIDEpOw0KPiA+IC0JZWxzZQ0KPiA+ICsJZWxzZSB7DQo+ID4g
ICAJCXJjID0gZGF4X2RpcmVjdF9hY2Nlc3MoaW9tYXAtPmRheF9kZXYsIHBnb2ZmLCAxLCAma2Fk
ZHIsIE5VTEwpOw0KPiA+IC0JaWYgKHJjIDwgMCkgew0KPiA+IC0JCWRheF9yZWFkX3VubG9jayhp
ZCk7DQo+ID4gLQkJcmV0dXJuIHJjOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCWlmICghcGFnZV9h
bGlnbmVkKSB7DQo+ID4gLQkJbWVtc2V0KGthZGRyICsgb2Zmc2V0LCAwLCBzaXplKTsNCj4gPiAr
CQlpZiAocmMgPCAwKQ0KPiA+ICsJCQlnb3RvIG91dDsNCj4gPiArCQlpZiAoaW9tYXAtPmFkZHIg
IT0gc3JjbWFwLT5hZGRyKSB7DQo+ID4gKwkJCXJjID0gZGF4X2lvbWFwX2Nvd19jb3B5KG9mZnNl
dCwgc2l6ZSwgUEFHRV9TSVpFLCBzcmNtYXAsDQo+ID4gKwkJCQkJCWthZGRyKTsNCj4gDQo+IG9m
ZnNldCBhYm92ZSBpcyBvZmZzZXQgaW4gcGFnZSwgdGhpbmsgZGF4X2lvbWFwX2Nvd19jb3B5KCkg
ZXhwZWN0cyBhYnNvbHV0ZSBwb3MNCg0KWW91IGFyZSByaWdodC4gIFNob3VsZCBwYXNzIHBvcyBo
ZXJlLiAgVGhhbmtzIGZvciBwb2ludGluZyBvdXQuDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hp
eWFuZy4NCg0KPiANCj4gPiArCQkJaWYgKHJjIDwgMCkNCj4gPiArCQkJCWdvdG8gb3V0Ow0KPiA+
ICsJCX0gZWxzZQ0KPiA+ICsJCQltZW1zZXQoa2FkZHIgKyBvZmZzZXQsIDAsIHNpemUpOw0KPiA+
ICAgCQlkYXhfZmx1c2goaW9tYXAtPmRheF9kZXYsIGthZGRyICsgb2Zmc2V0LCBzaXplKTsNCj4g
PiAgIAl9DQo+ID4gKw0KPiA+ICtvdXQ6DQo+ID4gICAJZGF4X3JlYWRfdW5sb2NrKGlkKTsNCj4g
PiAtCXJldHVybiBzaXplOw0KPiA+ICsJcmV0dXJuIHJjIDwgMCA/IHJjIDogc2l6ZTsNCj4gPiAg
IH0NCj4gPg0KPiA+ICAgc3RhdGljIGxvZmZfdA0KPiA+IGRpZmYgLS1naXQgYS9mcy9pb21hcC9i
dWZmZXJlZC1pby5jIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyBpbmRleA0KPiA+IGYyY2QyMDM0
YTg3Yi4uMjczNDk1NWVhNjdmIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2lvbWFwL2J1ZmZlcmVkLWlv
LmMNCj4gPiArKysgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jDQo+ID4gQEAgLTkzMyw3ICs5MzMs
NyBAQCBzdGF0aWMgbG9mZl90IGlvbWFwX3plcm9fcmFuZ2VfYWN0b3Ioc3RydWN0IGlub2RlDQo+
ICppbm9kZSwgbG9mZl90IHBvcywNCj4gPiAgIAkJczY0IGJ5dGVzOw0KPiA+DQo+ID4gICAJCWlm
IChJU19EQVgoaW5vZGUpKQ0KPiA+IC0JCQlieXRlcyA9IGRheF9pb21hcF96ZXJvKHBvcywgbGVu
Z3RoLCBpb21hcCk7DQo+ID4gKwkJCWJ5dGVzID0gZGF4X2lvbWFwX3plcm8ocG9zLCBsZW5ndGgs
IGlvbWFwLCBzcmNtYXApOw0KPiA+ICAgCQllbHNlDQo+ID4gICAJCQlieXRlcyA9IGlvbWFwX3pl
cm8oaW5vZGUsIHBvcywgbGVuZ3RoLCBpb21hcCwgc3JjbWFwKTsNCj4gPiAgIAkJaWYgKGJ5dGVz
IDwgMCkNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kYXguaCBiL2luY2x1ZGUvbGlu
dXgvZGF4LmggaW5kZXgNCj4gPiBiNTJmMDg0YWE2NDMuLjMyNzVlMDFlZDMzZCAxMDA2NDQNCj4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RheC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9kYXgu
aA0KPiA+IEBAIC0yMzcsNyArMjM3LDggQEAgdm1fZmF1bHRfdCBkYXhfZmluaXNoX3N5bmNfZmF1
bHQoc3RydWN0IHZtX2ZhdWx0DQo+ICp2bWYsDQo+ID4gICBpbnQgZGF4X2RlbGV0ZV9tYXBwaW5n
X2VudHJ5KHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90DQo+IGluZGV4KTsN
Cj4gPiAgIGludCBkYXhfaW52YWxpZGF0ZV9tYXBwaW5nX2VudHJ5X3N5bmMoc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKm1hcHBpbmcsDQo+ID4gICAJCQkJICAgICAgcGdvZmZfdCBpbmRleCk7DQo+ID4g
LXM2NCBkYXhfaW9tYXBfemVybyhsb2ZmX3QgcG9zLCB1NjQgbGVuZ3RoLCBzdHJ1Y3QgaW9tYXAg
KmlvbWFwKTsNCj4gPiArczY0IGRheF9pb21hcF96ZXJvKGxvZmZfdCBwb3MsIHU2NCBsZW5ndGgs
IHN0cnVjdCBpb21hcCAqaW9tYXAsDQo+ID4gKwkJc3RydWN0IGlvbWFwICpzcmNtYXApOw0KPiA+
ICAgc3RhdGljIGlubGluZSBib29sIGRheF9tYXBwaW5nKHN0cnVjdCBhZGRyZXNzX3NwYWNlICpt
YXBwaW5nKQ0KPiA+ICAgew0KPiA+ICAgCXJldHVybiBtYXBwaW5nLT5ob3N0ICYmIElTX0RBWCht
YXBwaW5nLT5ob3N0KTsNCg0K
