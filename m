Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54D41A9513
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 09:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635315AbgDOHsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 03:48:25 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:59542 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635311AbgDOHsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:48:23 -0400
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 4B7F33A43A9;
        Wed, 15 Apr 2020 16:48:21 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 492DxK1vXQzRkHC;
        Wed, 15 Apr 2020 16:48:21 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 492DxK1bTRzRjKt;
        Wed, 15 Apr 2020 16:48:21 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 492DxK1GH3zRkBs;
        Wed, 15 Apr 2020 16:48:21 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.58])
        by mf03.melco.co.jp (Postfix) with ESMTP id 492DxK1055zRjJW;
        Wed, 15 Apr 2020 16:48:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYkIbQQVN2CAp/EvgSq31TdcJ3+BUDlXExlJwHhdjTUTJ4gJUoUiLZbYBlsuy9iFzXGN9BZd6uBLIA/1kwIperLH+gETIIvXKS7bxsQFuw6s6ia+GvcsNMFUPdAySNFtFvvhR3HcDr/rWhf28yBxppklYWNnkDK/j61TQt4PfCoqw9+F9tt5BzmIqgR/QG/DWOqm/yMRYEfGdzDOJuA1g+0aCF5IsWS6lbgME1rVMTraB/VptuFo6S3xN/pljE1izbG+HbtJrk+xKmFgKjYT45F2oLLukf/cdHbk8ZW+QA0QW3c2vrTnfIcrmXR7SBZ06sd4CE9yQZrdKADn9sYabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7Y+1FjTZO/Dhuo4ezOfq0KGI/C0safWyZkyFfK2T2k=;
 b=bAW8k0JNIUuXiSX9OpYlVBQnh0VrM990+QjdiBcZmXsxN60mTZTTh+PzljR3MQyNI0zvDVBl4Xul9gvXIiiCH4GxD6uhH4+CMWJdl2t92rdUmFH2qGA27/jEc2gOr0+doLCCe1tu+oLBm5EVe+z0cmf/BiEr/Pq52RbOcSuLay6NbEJSk/aKi/KM/aIIon+qJa0J0lYLo/T9jP9uXoh+II1JKLgv7nw5VQG6/cFqXjiWr2cq2CKkxM5ciTL3SWUFn55fGyYgKZh4L2h5NQhslYkHvey42aetAlWksNAb2TT+FyOHonI/AmQST07l7FNZ4PgukHR/Fl4BzXXEMivJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7Y+1FjTZO/Dhuo4ezOfq0KGI/C0safWyZkyFfK2T2k=;
 b=KTufnvm5pGFL1SDJyNwKyydXqkjqIsWGV20rUfZw8kUEIBWFBDHjBd0mlVmJ6eDe2lhsw+ddi289aujjr9YNULpbCN9CjrT+mxKhNofQKvCoVATw1GsNKqd5sTYIPeLj74f7bMvBJ2jDKNbIXtqOQZzJjVwwElUb7PJ1AMUu4Og=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1803.jpnprd01.prod.outlook.com (52.133.163.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.24; Wed, 15 Apr 2020 07:48:20 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 07:48:20 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Ohara.Eiji@bk.MitsubishiElectric.co.jp" 
        <Ohara.Eiji@bk.MitsubishiElectric.co.jp>
Subject: RE: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Topic: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Index: AQHWCfgm33iC4HYp6U6hpobeaScABqhrVdFggAIevgCAARtD4IAAZbCAgAd0CHCAAHnvgIABFVvAgAB2xICAARY8kA==
Date:   Wed, 15 Apr 2020 07:46:27 +0000
Deferred-Delivery: Wed, 15 Apr 2020 07:48:00 +0000
Message-ID: <TY1PR01MB157892A6218DBF733EDC0F1590DB0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
 <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200408090435.i3ufmbfinx5dyd7w@pali>
 <TY1PR01MB15784063EED4CEC93A2B501390DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200413101007.lbey6q5u6jz3ulmr@pali>
 <TY1PR01MB15782010C68C0C568A6AE68690DA0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200414094753.kk2q2elgtwl6ubft@pali>
In-Reply-To: <20200414094753.kk2q2elgtwl6ubft@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dc93944-b2ce-47ff-a838-08d7e1115e1f
x-ms-traffictypediagnostic: TY1PR01MB1803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB18031808A7B35A4C52FC0F7090DB0@TY1PR01MB1803.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(66476007)(66946007)(6506007)(186003)(66446008)(76116006)(71200400001)(54906003)(64756008)(7696005)(316002)(8936002)(4326008)(2906002)(66556008)(81156014)(52536014)(5660300002)(45080400002)(86362001)(33656002)(55016002)(478600001)(26005)(9686003)(8676002)(6916009)(107886003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c41KxSJ+pknGTfLP/5abRYyzHO6gw0m8Hyc5h2iffMiodgM9JEn79ASVyZvuHbnfeksgB/Hu+3Wv+25w6/iTK/kuEg19Oo+oxOySFzHau7gWpO+VoUD2bL/1TiQZvixOV8V1ikBVdnfedQq46KK6bxTjbH/teXIEEHZ1gh8Z54MOtFeVXNNcww3o7hQP/dA6g8QUVRzK/exmmnfVbxtLULb9X7KZ+HMxIRyW0JDPQUB58+82nLqMKwCgbY2gUiLdGJmnop8LCG9sqAP5+0qLwPCYUd+X7uwlSY6Ph7swd4awIg54aCaBRD9raJJKG/pOpJh8S69upp89JqX/rQvR+0nvn0U3yDj9IFMTlpPrRoEn/MWY728R18aUOimpqVQgJIERlfl+oRaDWFKywxz1bq6vxcFC4lYjbj541XNyfLbRfsfGKynPKvhszI/ezQ5b
x-ms-exchange-antispam-messagedata: yixxIB28/uniQHEphVJZ2QRRMiKhGJqj+lZEqiQCguQirZTDg/3CBGavpawHPrH6SDg99o7v7vsUFo87tECTt/PtVvaDm4tR3OCW6R+tBedfXr3Jw9PM8VVu0qG8v45B2wdhHOvnv7f8AN5Je9S2ng==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc93944-b2ce-47ff-a838-08d7e1115e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 07:48:20.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: od6XfwxOBjcaxMyuJOKnW5IYlMiAzwCYNzWwMuUy+DAtdSCpvlroC+tCvpDvjOyeXoMySkt5M3EzdJnXg4qBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1803
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IFVDUy0yLCBVQ1MtNCwgYW5kIFVURi0xNiB0ZXJtcyBkbyBub3QgYXBwZWFyIGluIHRoZSBl
eGZhdCBzcGVjaWZpY2F0aW9uLg0KPiA+IEl0IGp1c3Qgc2F5cyAiVW5pY29kZSIuDQo+IA0KPiBU
aGF0IGlzIGJlY2F1c2UgaW4gTVMgd29ybGQsICJVbmljb2RlIiB0ZXJtIGxvdCBvZiB0aW1lcyBt
ZWFucyBVQ1MtMiBvciBVVEYtMTYuIA0KDQpGb3IgZXhhbXBsZSwgdGhlIEpvbGlldCBTcGVjaWZp
Y2F0aW9uIGRlc2NyaWJlcyB1c2luZyBVQ1MtMiBmb3IgY2hhcmFjdGVyIHNldHMuDQpTaW1pbGFy
bHksIHRoZSBVREYgU3BlY2lmaWNhdGlvbiBkZXNjcmliZXMgdXNpbmcgVW5pY29kZSBWZXJzaW9u
IDIuMCBmb3IgY2hhcmFjdGVyIHNldHMuDQpIb3dldmVyLCBXaW5kb3dzIEZpbGUgU3lzdGVtcyBh
bHNvIGFjY2VwdHMgVVRGLTE2IGVuY29kZWQgVUNTLTQuDQpUaGUgZm91bmRhdGlvbiBvZiB0aGVp
ciBtYWluIHByb2R1Y3QoV2luZG93cyBOVCkgd2FzIGRlc2lnbmVkIGluIHRoZSBlcmEgd2hlbiBV
VEYtMTYgYW5kIFVDUy0yIHdlcmUgZXF1YWwuDQpUaGUgbm9uLUJNUCBwbGFpbnMgd2VyZSBwcm9i
YWJseSBub3QgZnVsbHkgY29uc2lkZXJlZC4NCg0KPiBZb3UgbmVlZCB0byBoYXZlIGEgY3J5c3Rh
bCBiYWxsIHRvIGNvcnJlY3RseSB1bmRlcnN0YW5kIHRoZWlyIHNwZWNpZmljYXRpb25zLg0KDQpF
eGFjdGx5ISENCk15IGNyeXN0YWwgYmFsbCBzYXlzIC4uLg0KIlRoZXkndmUgZGVzaWduZWQgRDgw
MC1ERkZGIHRvIGJlIGEgbXlzdGVyaW91cyBhcmVhLCBzbyBpdCdzIGdvaW5nIHRocm91Z2ggaXQu
Ig0KDQo+ID4gTWljcm9zb2Z0J3MgRmlsZSBTeXN0ZW1zIHVzZXMgdGhlIFVURi0xNiBlbmNvZGVk
IFVDUy00IGNvZGUgc2V0Lg0KPiA+IFRoZSBjaGFyYWN0ZXIgdHlwZSBpcyBiYXNpY2FsbHkgJ3dj
aGFyX3QnKDE2Yml0KS4NCj4gPiBUaGUgZGVzY3JpcHRpb24gIjAwMDBoIHRvIEZGRkZoIiBhbHNv
IGFzc3VtZXMgdGhlIHVzZSBvZiAnd2NoYXJfdCcuDQo+ID4NCj4gPiBUaGlzIOKAnDAwMDBoIHRv
IEZGRkZo4oCdIGFsc28gaW5jbHVkZXMgc3Vycm9nYXRlIGNoYXJhY3RlcnMoVStEODAwIHRvDQo+
ID4gVStERkZGKSwgYnV0IHRoZXNlIHNob3VsZCBub3QgYmUgY29udmVydGVkIHRvIHVwcGVyIGNh
c2UuDQo+ID4gUGFzc2luZyBhIHN1cnJvZ2F0ZSBjaGFyYWN0ZXIgdG8gUnRsVXBjYXNlVW5pY29k
ZUNoYXIoKSBvbiBXaW5kb3dzLCBqdXN0IHJldHVybnMgdGhlIHNhbWUgdmFsdWUuDQo+ID4gKCog
UnRsVXBjYXNlVW5pY29kZUNoYXIoKSBpcyBvbmUgb2YgV2luZG93cyBuYXRpdmUgQVBJKQ0KPiA+
DQo+ID4gSWYgdGhlIHVwY2FzZS10YWJsZSBjb250YWlucyBzdXJyb2dhdGUgY2hhcmFjdGVycywg
ZXhmYXRfdG91cHBlcigpIHdpbGwgY2F1c2UgaW5jb3JyZWN0IGNvbnZlcnNpb24uDQo+ID4gV2l0
aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgdGhlIHJlc3VsdHMgb2YgZXhmYXRfdXRmOF9k
X2NtcCgpIGFuZCBleGZhdF91bmluYW1lX25jbXAoKSBtYXkgZGlmZmVyLg0KPiA+DQo+ID4gVGhl
IG5vcm1hbCBleGZhdCdzIHVwY2FzZS10YWJsZSBkb2VzIG5vdCBjb250YWluIHN1cnJvZ2F0ZSBj
aGFyYWN0ZXJzLCBzbyB0aGUgcHJvYmxlbSBkb2VzIG5vdCBvY2N1ci4NCj4gPiBUbyBiZSBtb3Jl
IHN0cmljdC4uLg0KPiA+IEQ4MDBoIHRvIERGRkZoIHNob3VsZCBiZSBleGNsdWRlZCB3aGVuIGxv
YWRpbmcgdXBjYXNlLXRhYmxlIG9yIGluIGV4ZmF0X3RvdXBwZXIoKS4NCj4gDQo+IEV4YWN0bHks
IHRoYXQgaXMgd2h5IHN1cnJvZ2F0ZSBwYWlycyBjYW5ub3QgYmUgcHV0IGludG8gYW55ICJ0byB1
cHBlciINCj4gZnVuY3Rpb24uIE9yIHJhdGhlciAidG8gdXBwZXIiIGZ1bmN0aW9uIG5lZWRzIHRv
IGJlIGlkZW50aXR5IGZvciB0aGVtIHRvIG5vdCBicmVhayBhbnl0aGluZy4gInRvIHVwcGVyIiBk
b2VzIG5vdCBtYWtlDQo+IGFueSBzZW5zZSBvbiBvbmUgdTE2IGl0ZW0gZnJvbSBVVEYtMTYgc2Vx
dWVuY2Ugd2hlbiB5b3UgZG8gbm90IGhhdmUgYSBjb21wbGV0ZSBjb2RlIHBvaW50Lg0KPiBTbyBB
UEkgZm9yIFVURi0xNiAidG8gdXBwZXIiIGZ1bmN0aW9uIG5lZWRzIHRvIHRha2UgZnVsbCBzdHJp
bmcsIG5vdCBqdXN0IG9uZSB1MTYuDQo+DQo+IFNvIGZvciBjb2RlIHBvaW50cyBhYm92ZSBVK0ZG
RkYgaXQgaXMgbmVlZGVkIHNvbWUgb3RoZXIgbWVjaGFuaXNtIGhvdyB0byByZXByZXNlbnQgdXBj
YXNlIHRhYmxlIChlLmcuIGJ5IHByb3ZpZGluZyBmdWxsDQo+IFVURi0xNiBwYWlyIG9yIGNvZGUg
cG9pbnQgZW5jb2RlZCBpbiBVVEYtMzIpLiBBbmQgdGhpcyBpcyB1bmtub3duIGFuZCByZWFzb24g
d2h5IEkgcHV0IHF1ZXN0aW9uIHdoaWNoIHdhcyBJSVJDIGZvcndhcmRlZA0KPiB0byBNUy4NCg0K
VGhhdCdzIGV4YWN0bHkgdGhlIGNhc2Ugd2l0aCB0aGUgImdlbmVyaWMiIFVURi0xNiB0b3VwcGVy
IGZ1bmN0aW9uLg0KSG93ZXZlciwgZXhmYXQgKGFuZCBvdGhlciBNUy1GUydzKSBkb2VzIG5vdCBy
ZXF1aXJlIHVwcGVyY2FzZSBjb252ZXJzaW9uIGZvciBub24tQk1QIHBsYWlucyBjaGFyYWN0ZXJz
Lg0KRm9yIG5vbi1CTVAgY2hhcmFjdGVycywgSSB0aGluayBpdCdzIGVub3VnaCB0byBqdXN0IGRv
IG5vdGhpbmcgKG5vIHNraXAsIG5vIGNvbnZlcnNpb24pLlNvIGxpa2UgV2luZG93cy4NCg0KDQo+
ID4gV1RGLTggaXMgbmV3IHRvIG1lLg0KPiA+IFRoYXQncyBhbiBpbnRlcmVzdGluZyBpZGVhLCBi
dXQgaXMgaXQgbmVlZGVkIGZvciBleGZhdD8NCj4gPg0KPiA+IEZvciBjaGFyYWN0ZXJzIG92ZXIg
VStGRkZGLA0KPiA+ICAtRm9yIFVURi0zMiwgYSB2YWx1ZSBvZiAweDEwMDAwIG9yIG1vcmUgIC1G
b3IgVVRGLTE2LCB0aGUgdmFsdWUgZnJvbQ0KPiA+IDB4ZDgwMCB0byAweGRmZmYgSSB0aGluayB0
aGVzZSBhcmUganVzdCAiZG9uJ3QgY29udmVydCB0byB1cHBlcmNhc2UuIg0KPiA+DQo+ID4gSWYg
dGhlIEZpbGUgTmFtZSBEaXJlY3RvcnkgRW50cnkgY29udGFpbnMgaWxsZWdhbCBzdXJyb2dhdGUN
Cj4gPiBjaGFyYWN0ZXJzKHN1Y2ggYXMgb25lIHVucGFpcmVkIHN1cnJvZ2F0ZSBoYWxmKSwgaXQg
d2lsbCBzaW1wbHkgYmUgaWdub3JlZCBieSB1dGYxNnNfdG9fdXRmOHMoKS4NCj4gDQo+IFRoaXMg
aXMgdGhlIGV4YW1wbGUgd2h5IGl0IGNhbiBiZSB1c2VmdWwgZm9yIGV4ZmF0IG9uIGxpbnV4LiBl
eGZhdCBmaWxlbmFtZSBjYW4gY29udGFpbiBqdXN0IHNlcXVlbmNlIG9mIHVucGFpcmVkIGhhbHZl
cw0KPiBvZiBzdXJyb2dhdGUgcGFpcnMuIFN1Y2ggdGhpbmcgaXMgbm90IHJlcHJlc2VudGFibGUg
aW4gVVRGLTgsIGJ1dCB2YWxpZCBpbiBleGZhdC4NCj4gVGhlcmVmb3JlIGN1cnJlbnQgbGludXgg
a2VybmVsIGV4ZmF0IGRyaXZlciB3aXRoIFVURi04IGVuY29kaW5nIGNhbm5vdCBoYW5kbGUgc3Vj
aCBmaWxlbmFtZXMuIEJ1dCB3aXRoIFdURi04IGl0IGlzIHBvc3NpYmxlLg0KDQpJbiBmYWN0LCBl
eGZhdChhbmQgb3RoZXIgTVMtRlNzKSBhY2NlcHQgdW5wYWlyZWQgc3Vycm9nYXRlIGNoYXJhY3Rl
cnMuDQpCdXQgdGhpcyBpcyBpbGxlZ2FsIHVuaWNvZGUuDQpBbHNvLCBpdCBpcyB2ZXJ5IHJhcmVs
eSBnZW5lcmF0ZWQgYnkgbm9ybWFsIHVzZXIgb3BlcmF0aW9uIChleGNlcHQgZm9yIFZGQVQgc2hv
cnRuYW1lKS4NCklsbGVnYWwgdW5pY29kZSBjaGFyYWN0ZXJzIHdlcmUgb2Z0ZW4gYSBzZWN1cml0
eSByaXNrIGFuZCBJIHRoaW5rIHRoZXkgc2hvdWxkIG5vdCBiZSBhY2NlcHRlZC4gZXZlbiBpZiBw
b3NzaWJsZS4NCg0KPiBTbyBpZiB3ZSB3YW50IHRoYXQgdXNlcnNwYWNlIHdvdWxkIGJlIGFibGUg
dG8gcmVhZCBzdWNoIGZpbGVzIGZyb20gZXhmYXQgZnMsIHNvbWUgbWVjaGFuaXNtIGZvciBjb252
ZXJ0aW5nICJ1bnBhaXJlZCBoYWx2ZXMiDQo+IHRvIE5VTEwtdGVybSBjaGFyKiBzdHJpbmcgc3Vp
dGFibGUgZm9yIGZpbGVuYW1lcyBpcyBuZWVkZWQuIEFuZCBXVEYtOCBzZWVtcyBsaWtlIGEgZ29v
ZCBjaG9pY2UgYXMgaXQgaXMgYmFja3dhcmQgY29tcGF0aWJsZQ0KPiB3aXRoIFVURi04Lg0KDQpJ
IHRoaW5rIHRoZXJlIGFyZSB2ZXJ5IGZldyByZXF1aXJlbWVudHMgdG8gYWNjZXNzIHN1Y2ggZmls
ZSBuYW1lcy4NCkl0IGlzIHJhcmUgdG8gdXNlIG5vbi1CTVAgY2hhcmFjdGVycyBpbiBmaWxlIG5h
bWVzLCBhbmQgaXQgaXMgZXZlbiByYXJlciB0byBpbGxlZ2FsbHkgcmVjb3JkIG9ubHkgaGFsZiBv
ZiB0aGVtLg0KDQo+ID4gc3RyaW5nIGFmdGVyIHV0ZjggY29udmVyc2lvbiBkb2VzIG5vdCBpbmNs
dWRlIGlsbGVnYWwgYnl0ZSBzZXF1ZW5jZS4NCj4gDQo+IFllcywgYnV0IHRoaXMgaXMgbG9vc3kg
Y29udmVyc2lvbi4gV2hlbiB5b3Ugd291bGQgaGF2ZSB0d28gZmlsZW5hbWVzIHdpdGggZGlmZmVy
ZW50ICJzdXJyb2dhdGUgaGFsdmVzIiB0aGV5IHdvdWxkIGJlIGNvbnZlcnRlZA0KPiB0byBzYW1l
IGZpbGUgbmFtZS4gU28geW91IHdvdWxkIG5vdCBiZSBhYmxlIHRvIGFjY2VzcyBib3RoIG9mIHRo
ZW0uDQoNCkkgYWxzbyB0aGluayB0aGVyZSBpcyBhIHByb2JsZW0gd2l0aCB0aGlzIGNvbnZlcnNp
b24uDQpJbGxlZ2FsIGJ5dGUgc2VxdWVuY2VzIGFyZSBzdHJpcHBlZCBvZmYsIGFuZCBiZWhhdmUg
YXMgaWYgdGhleSBkaWRuJ3QgZXhpc3QgDQpmcm9tIHRoZSBiZWdpbm5pbmcgKGxpa2UgYSBsZWdh
bCBVVEYtOCBzdHJpbmcpLg0KSSB0aGluayBpdCdzIHNhZmVzdCB0byBmYWlsIHRoZSBjb252ZXJz
aW9uIGlmIGl0IGRldGVjdHMgYW4gaWxsZWdhbCBieXRlIHNlcXVlbmNlLg0KQW5kIGl0J3MgYWxz
byBwb3B1bGFyIHRvIHJlcGxhY2UgaXQgd2l0aCBhbm90aGVyIGNoYXJhY3RlcihzdWNoIGFzJ18g
JykuDQoobm90IHBlcmZlY3QsIGJ1dCB3b3JrcyByZWFzb25hYmx5KQ0KDQpBbnl3YXksIHdlIGRv
bid0IG5lZWQgdG8gY29udmVydCBub24tQk1QIGNoYXJhY3RlcnMgb3IgdW5wYWlyZWQgc3Vycm9n
YXRlIGNoYXJhY3RlcnMgDQp0byB1cHBlcmNhc2UgaW4gZXhmYXQoYW5kIG90aGVyIE1TLUZTcyku
DQoNCg0KQlINCi0tLQ0KS29oYWRhIFRldHN1aGlybyA8S29oYWRhLlRldHN1aGlyb0BkYy5NaXRz
dWJpc2hpRWxlY3RyaWMuY28uanA+DQo=
