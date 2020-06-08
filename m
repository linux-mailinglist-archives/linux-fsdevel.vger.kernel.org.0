Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179C21F126D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 07:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgFHFEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 01:04:11 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:34710 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHFEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:04:10 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 9662F3A3579;
        Mon,  8 Jun 2020 14:04:08 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 49gLkw3vkqzRjgj;
        Mon,  8 Jun 2020 14:04:08 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 49gLkw3ZZrzRkBV;
        Mon,  8 Jun 2020 14:04:08 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 49gLkw3XvkzRjnS;
        Mon,  8 Jun 2020 14:04:08 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.59])
        by mf03.melco.co.jp (Postfix) with ESMTP id 49gLkw3MlszRjYK;
        Mon,  8 Jun 2020 14:04:08 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0BahaD/fV9Thv92bBG0YXI/Ybl/Ba0cZio/tbibCoTpQctjkWkvl96ei6cyxP+qGhjbTVu0L9yVa5lRT0ebpDBHeOc5qZ5gFVMTB36FRFzp5ec+wjVKm6Gnw+of9YuU65Yy1OUknrxNZTVdh2qGzNaKmux+ct/MoK0hFGLmYyV5DOwgHmuJhtNJg3Gj72bUbYkucxPax701Ac0NZdok7Y9cQR4Vw3xFTu/9XXHsNv//iXO2yZRxesZ36ltRopnuqFnZIfqePQFGYTbQhyaYKDkpqvp9drdOvDYXnI7WdpNIr5oeNpx2sv+N4Vpiij3udM5V4SySypvfZroQY8iLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqTr/2DK5MOi1Nd+jSfbDbW91m/++Qf0WImK6B09RNU=;
 b=cooHtwBPV82bEyza2azXrqda6YH4r3cRdt9Y67Yd0ISfiTy5s75JnGj0I/GZxAIa7yPaYLuGOBXvKswQ66elbNGsudb2ZcYGtiqRKVTXxoZBJ7PHMfn0SDTb9mDnHG2kO2txi8w1v43cranCAONMckK4E0Eyl9jEJ7GJrs8QAYVe5xMXDpen/NO+piWnTmNbDo3dtZzOwErQAcsMhwg6lpzCEvnmLieI24AKrdLThoGDUg3yM0ilKPUDO1WWd6fueCGmjtxYcfd+bNug73C4TlXwNvD575LgSunaEArsh5bg9KaxiqyAjWXHk+QQ5oKloruJ1rNNplx5rezBHvvKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqTr/2DK5MOi1Nd+jSfbDbW91m/++Qf0WImK6B09RNU=;
 b=SGnx4/fIQfG0Ck18oDx4qn+eW0kyh/ipv+l5vbZaR4NSzjzNzeAUHt3vMU5cSd7SpHCs+WYVIsO9nIlCCmW/B+sBTSMxwoqA+wlv8BEBaMXs/XTtiO90aBEMd9AQfvYathLIylrnnGOowTzCT8z+ezS4QerY9YkSLEZj65n8avM=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TY1PR01MB1513.jpnprd01.prod.outlook.com (2603:1096:403:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 05:04:07 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1d6f:af96:18c1:ebe5]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1d6f:af96:18c1:ebe5%5]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 05:04:07 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Namjae Jeon' <linkinjeon@kernel.org>
CC:     Namjae Jeon <namjae.jeon@samsung.com>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] exfat: set EXFAT_SB_DIRTY and VOL_DIRTY at the same
 timing
Thread-Topic: [PATCH 3/3] exfat: set EXFAT_SB_DIRTY and VOL_DIRTY at the same
 timing
Thread-Index: AQHWPGJVs9UShpqC3UOUVd1py4iKVKjN886g
Date:   Mon, 8 Jun 2020 05:02:19 +0000
Deferred-Delivery: Mon, 8 Jun 2020 05:04:00 +0000
Message-ID: <TY1PR01MB157812F9DFC574527D8AA26E90850@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200604084445.19205-1-kohada.t2@gmail.com>
 <CGME20200604084534epcas1p281a332cd6d556b5d6c0ae61ec816c5a4@epcas1p2.samsung.com>
 <20200604084445.19205-3-kohada.t2@gmail.com>
 <000401d63b0b$8664f290$932ed7b0$@samsung.com>
 <229ab132-c5f1-051c-27c4-4f962ceff700@gmail.com>
 <CAKYAXd8SqaMj6e9urqdKWCdaexgAoN78Pzh0NYQ35iRYA=2tiA@mail.gmail.com>
In-Reply-To: <CAKYAXd8SqaMj6e9urqdKWCdaexgAoN78Pzh0NYQ35iRYA=2tiA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e3058dc-e6bf-40f0-e7e7-08d80b695fa3
x-ms-traffictypediagnostic: TY1PR01MB1513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB15138B7EF34C8D6546300B1990850@TY1PR01MB1513.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: td2BTIkYMPd9D4jVtUMeizqdmYwOFvLXrZyD+DX4kmKGrIRmCTqulXvPynsAXFyX0PEy85rqAUbMzZohPH7hj5BX/lZjfpkr/SXIJouvUZFyfAP9VcNTfZE920/6LLGxo9l5AuEE10Ac75ggUp5XD6gaCBy+DCYv5vsohQ1VZCt7Tx/AEZ5deWbQzfgS1jydA/vL/0qLSsS7PufqxsZDcpDZEGK15eSCrqwi+bHaQa5Po1y8JghIvgueh9Xobi0OwVThr9VtC0wU3yot5YXbXUQnKeOfqo44oHZZHrU4ezsnXE+ZXbreY5e0E+JcdDMTP5WXE6pQnFs9bo6P9HWyUjnB8YaqpWKvKm7YYGd7RQVETcG03c7d5eYvvr05t5kW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(186003)(8676002)(33656002)(6506007)(316002)(26005)(9686003)(6916009)(54906003)(8936002)(5660300002)(6666004)(55016002)(66556008)(86362001)(52536014)(66476007)(76116006)(66946007)(4326008)(7696005)(71200400001)(83380400001)(2906002)(66446008)(64756008)(478600001)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZwFAZvaJu8nqoIfFzTbJG6+4luQKJl3uKR8AWxEKtgKuClO54Xs+MNQdnNGF6/rAk0M7MSmILjCCX5z4zTa1Za5MctPJdHWi0EBGX0gmgq/vhvUyFf0gudHH9C7gFnwfbjLGlBPGCTOLYqFu85EXslDr77m4vodAFQ+5VruNp7VSdgBfk3QOYxMMVmXON01+yOMWtzBBY2ZRnH0wuPhAKL7/qkoK5TmOKEb3+wSI3VEgO56LIiyjAifiN4uO42Dhl6w9zblnLYY7Yg1JgSAi+jbEfGZc0l6bm6m07Qg0zfa+2PFqJWEUzp5uxeIQr5KEKHGb2zSzJpa6CzhdwRIilFiE5OGRBUo576xuTeiVu/AX2koTPPj1Vvb/+1ipAA4rgkNV0roMLqD0X7EPNgbCzQd0NM5l+NBmLQtNoz1oRFStgfk+PMROZaRs2hHMXmsAAFFcXODc3q8wowPdHsLIHZcDHb2AZtg6mrvOg9ueDZE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3058dc-e6bf-40f0-e7e7-08d80b695fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 05:04:07.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hJ2W4AaWae+bLymGt0JbH7z8I6Fiq+ux2ExiDXKuXmfOlKYu/DSV57pM5gjYtaVDvH1txYSTkGU743AjKtbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1513
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuDQoNCj4gPj4gQ2FuIHlvdSBzcGxpdCB0aGlzIHBh
dGNoIGludG8gdHdvPyAoRG9uJ3Qgc2V0IFZPTF9ESVJUWSBvbiAtRU5PVEVNUFRZIGFuZA0KPiA+
PiBTZXR0aW5nIEVYRkFUX1NCX0RJUlRZIGlzDQo+ID4+IG1lcmdlZCBpbnRvIGV4ZmF0X3NldF92
b2xfZmxhZykuIEkgbmVlZCB0byBjaGVjayB0aGUgc2Vjb25kIG9uZSBtb3JlLg0KPiA+DQo+ID4g
Q2FuJ3QgZG8gdGhhdC4NCj4gPg0KPiA+IGV4ZmF0X3NldF92b2xfZmxhZygpIGlzIGNhbGxlZCB3
aGVuIHJtZGlyIHByb2Nlc3NpbmcgYmVnaW5zLiBXaGVuIE5vdC1lbXB0eQ0KPiA+IGlzIGRldGVj
dGVkLA0KPiA+IFZPTF9ESVJUWSBoYXMgYWxyZWFkeSBiZWVuIHdyaXR0ZW4gYW5kIHN5bmNlZCB0
byB0aGUgbWVkaWEuDQo+IFlvdSBjYW4gbW92ZSBpdCBiZWZvcmUgY2FsbGluZyBleGZhdF9yZW1v
dmVfZW50cmllcygpLg0KDQpDYW4gYmUgbW92ZWQsIGJ1dCB0aGF0IGRvZXNuJ3Qgc29sdmUgdGhl
IHByb2JsZW0uDQpJdCBjYXVzZXMgdGhlIHNpbWlsYXIgcHJvYmxlbSBhcyBiZWZvcmUuDQoNCmV4
ZmF0X3JlbW92ZV9lbnRyaWVzKCkgY2FsbHMgZXhmYXRfZ2V0X2RlbnRyeSgpLg0KSWYgZXhmYXRf
Z2V0X2RlbnRyeSgpIGZhaWxzLCB1cGRhdGUgYmggYW5kIHNldCBTQl9ESVJUWSB3aWxsIG5vdCBi
ZSBleGVjdXRlZC4NCkFzIGEgcmVzdWx0LCBTQl9ESVJUWSBpcyBub3Qgc2V0IGFuZCBzeW5jIGRv
ZXMgbm90IHdvcmsuDQpTaW1pbGFyIHByb2JsZW1zIG9jY3VyIHdpdGggb3RoZXIgd3JpdGluZyBm
dW5jdGlvbnMuDQpTaW1pbGFyIHByb2JsZW1zIG9jY3VyIHdoZW4gcHJlLXdyaXRlIGNoZWNrcyBh
cmUgYWRkZWQgaW4gdGhlIGZ1dHVyZS4NCg0KSWYgeW91IGRvbid0IHNldCBWT0xfRElSVFkgYXQg
dGhlIGJlZ2lubmluZywgeW91IHNob3VsZCBkZWxheSB0byBzZXQgVk9MX0RJUlRZIHVudGlsIHVw
ZGF0ZS1iaCAmIHNldCBTQl9ESVJUWS4NClRoaXMgYXZvaWRzIHVubmVjZXNzYXJ5IGNoYW5nZXMg
dG8gVk9MX0RJUlRZL1ZPTF9DTEVBTi4NCkkgdGhpbmsgdGhpcyBtZXRob2QgaXMgc21hcnQsIGJ1
dCBpdCBpcyBkaWZmaWN1bHQgdG8gZGVjaWRlIHdoZW4gdG8gc2V0IFZPTF9DTEVBTi4NCihJIHRy
aWVkIHRvIGltcGxlbWVudCBpdCwgYnV0IGdhdmUgdXApDQoNCj4gPiBCeSBkb2luZyB0aGlzLCBz
eW5jIGlzIGd1YXJhbnRlZWQgaWYgVk9MX0RJUlRZIGlzIHNldCBieSBjYWxsaW5nDQo+ID4gZXhm
YXRfc2V0X3ZvbF9mbGFnLg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgbWF5IHN0aWxsIGhhdmUgcHJv
YmxlbXMsIGJ1dCBpdCdzIGxpdHRsZSBiZXR0ZXIgdGhhbiBiZWZvcmUsIEkNCj4gPiB0aGluay4N
Cj4gSSBuZWVkIHRvIGNoZWNrIG1vcmUgaWYgaXQgaXMgdGhlIGJlc3Qgb3IgdGhlcmUgaXMgbW9y
ZSBiZXR0ZXIgd2F5Lg0KDQpJIHRoaW5rIHRoZSBzeW5jLXByb2JsZW1zIHN0aWxsIGV4aXN0Lg0K
TGV0J3MgaW1wcm92ZSBsaXR0bGUgYnkgbGl0dGxlLiA6LSkNCg0KQlINCi0tLQ0KS29oYWRhIFRl
dHN1aGlybyA8S29oYWRhLlRldHN1aGlyb0BkYy5NaXRzdWJpc2hpRWxlY3RyaWMuY28uanA+DQo=
