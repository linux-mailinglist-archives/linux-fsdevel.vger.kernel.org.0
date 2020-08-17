Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE67246360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 11:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHQJ30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 05:29:26 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:60368 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHQJ3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:29:24 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id A16913A48B9;
        Mon, 17 Aug 2020 18:29:21 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 4BVTJd4JM5zRkJB;
        Mon, 17 Aug 2020 18:29:21 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 4BVTJd4089zRjtT;
        Mon, 17 Aug 2020 18:29:21 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4BVTJd3xXLzRk9H;
        Mon, 17 Aug 2020 18:29:21 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.54])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4BVTJd3bzpzRk8w;
        Mon, 17 Aug 2020 18:29:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZyIFNFV/0ZxnjHhNYS38Ufx+myV7GajJvx8jT9HdjKYCH2NUg5AfmvblRJWl0QhBSTUkarZfXl4PPiL6qiT11DkGHz3rNdZcqO1/IyCMwi57hmlGYdTzXNMoFpqca7FP+07nkmENYVxJfpJ99gtUDRFScV6op/pKYW4orv+V9bevXbx3X/3OzzuiAOmGy5gsTxom2WPMeLcLq44HGtO1MPpLm4AriBlQ6Q7DLUTPxThC7tUFl/E1k/apKmjC5gFGQQfbPG6I2HWWDt9FqLyQ7B6lF2bwoWj+xT/BxwADYVDkZRdbLgCfO6AWpX5SscRTOXycr57Z6U+Rfwj/iOxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTaoEm28VO9XI/LU2PU1RDphPcEkE+zaxamD4WT+wdw=;
 b=d7NLFEHuTCrvzphQr+pPLvUTEewPvx5gGU9D83Qb3cju/8seL9Hvrvjj9I+QZTz315pg5RrJU3/a1XwQtbjqjAUQd1E8oIprzHBxkFCdSmJ/qo+/ukpd7U44ZGQ3RFg/KybPNF7UDA2/CDqE7cZBCr9KUbm7pDVa+RD2HfDqhsxtMuz8gxdSfLhshr5XTfYgyPtQvGCnRMtTp7E7zygPlzzZQllufHEoTuGaAiJ+EYgVPWcXusmrSG64zz7nCCXc0i59+HYw/rJ6FxCPpfKZTSrOGjK2VaO4ymA8eDCxANxLrhWi7nJSRvVOIrpwW0RQ9lf+viHQYvWGKWOi+YNB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTaoEm28VO9XI/LU2PU1RDphPcEkE+zaxamD4WT+wdw=;
 b=jWEveoAPUWj+vesMBxqsBlaBci/fmU4MMwNYiCECCpssf3D35sWclzhbCsJ42f4s6ahcrRUJPo08aB14XkHuyUz40FAbaLHwdV8UMWmtwr2ryeS3lR1q0hrRv47o8YWTbHl/TSpzKX0iUgKASBbkPcvY6cXU/vQEFNISYkwWJto=
Received: from OSBPR01MB4535.jpnprd01.prod.outlook.com (2603:1096:604:76::20)
 by OSBPR01MB2982.jpnprd01.prod.outlook.com (2603:1096:604:13::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Mon, 17 Aug
 2020 09:29:21 +0000
Received: from OSBPR01MB4535.jpnprd01.prod.outlook.com
 ([fe80::70f4:7774:9c8a:1d4]) by OSBPR01MB4535.jpnprd01.prod.outlook.com
 ([fe80::70f4:7774:9c8a:1d4%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:29:20 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Namjae Jeon' <namjae.jeon@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] exfat: add NameLength check when extracting name
Thread-Topic: [PATCH 1/2] exfat: add NameLength check when extracting name
Thread-Index: AQHWcRzqbJeXXmc47EK1TqkvgE8Y06k7jaUw
Date:   Mon, 17 Aug 2020 09:26:43 +0000
Deferred-Delivery: Mon, 17 Aug 2020 09:29:00 +0000
Message-ID: <OSBPR01MB4535529FC60111A075E3FC1F905F0@OSBPR01MB4535.jpnprd01.prod.outlook.com>
References: <CGME20200806055718epcas1p1763d92dbf47e2a331a74d0bb9ea03c15@epcas1p1.samsung.com>
        <20200806055653.9329-1-kohada.t2@gmail.com>
        <003d01d66edd$5baf4810$130dd830$@samsung.com>
        <ed561c17-3b85-9bf1-e765-5d9a15786585@gmail.com>
 <001001d6711c$def48c80$9cdda580$@samsung.com>
In-Reply-To: <001001d6711c$def48c80$9cdda580$@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e860541d-ccf8-43bf-95eb-08d84290059a
x-ms-traffictypediagnostic: OSBPR01MB2982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2982C6AA79220D546270C51E905F0@OSBPR01MB2982.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+ZLGzXC5ppeDRxVoNAgessiCU7+m0tj2r9/wWx/zN0aO7651xCZ6vj41e+qdrmTwRJT+YYGknR0uWNbVb3MREWw5Q4zeGyt9wO2vhe6kWaSKudH7gXOu59PXAjjHfY7TAurycfFOopDwOMq9B6PUR9zGay4mF8ERYvIjp+1HvNN0Nd9FwEuMQx65EAKl4hnes7ei39caPWWWk331w/XIUMR0+hGI+bv2zo8Sjxwh9DTqkHocdQLRbuyOkaXwW5NLBS2uZlGjykmlQef69P/8VO/TtFG+28da4z9hACBcoXEzD1I0EfCHNT7qrLzRM3Hq06Vsu6wB5SsWKBZoKCLRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4535.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(376002)(366004)(83380400001)(71200400001)(54906003)(66946007)(86362001)(8676002)(26005)(55016002)(9686003)(66446008)(66556008)(316002)(64756008)(5660300002)(66476007)(6666004)(2906002)(186003)(478600001)(33656002)(7696005)(6506007)(76116006)(8936002)(4326008)(52536014)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Rr/QoK/gaXUFvGs3n5kRoNE7pbb7ezhwtWzY/3AxWFNEtBQzbVr72ZPBNT+g0YGSHVqF5hwQJzdEvHpsKoIwY7mXZNVwjETV0+oaHpokT4n39B6yvwUqH0UiuBhmoEA7l2J45rqpeEBvq3JvY/+Df+2+/W6wUvcsiz4tiPE4uW6qb9agOkRoPnZAo+EYkut+9uprG4GTp6t6UO+j18XOOJVHk0AzwgFl27nrzETZyiUkaWJRsPxZKYOyyjNrSrABNE4bEbziz2LQwATvup551skPtVkwgCOGZCn1joN31uBybW4jYlY4LOUS48KsDwhyjAx2TtbuFhzNH4mr2io0ezr/U718Sccd6sPly1xAsx3MHwWbPZ0W2Xn+9YukuQU8i7QJfuekJcCReYEuaomR9l2FkwbX/WWJQCycp/jwg6tLUQT9vWRz+l5gN7qkImZTuxHsgvmfFHJaoM6h5jcSdWr6HkBU+F2cCaZkqJISCEfdYaYR53V+4+tV1FtizxXDX28JaVl1ElpCtA/VRTM4b98QZKY53mp/sCKImbV212fLkcVTmKSauUNIlgv2a/I6triHFjjhO4JufpOadozS/pX7+fMVcbLtwC8Z1eYnLAu5fPUC4U7I8eNQjVcvUc6AgS2n19A5dx7AxkF2cZDxrg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e860541d-ccf8-43bf-95eb-08d84290059a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 09:29:20.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxOD3adk8LWO38z66R+/xDcUDFjVXkGSjjs4Qln2ce7TLDcppKKQKxrZQkik944BSGcwjBlE/rwlgZcietjNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2982
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gPj4gLXN0YXRpYyB2b2lkIGV4ZmF0X2dl
dF91bmluYW1lX2Zyb21fZXh0X2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ID4gPj4g
LQkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwgaW50IGVudHJ5LCB1bnNpZ25lZCBzaG9ydCAq
dW5pbmFtZSkNCj4gPiA+PiArc3RhdGljIGludCBleGZhdF9nZXRfdW5pbmFtZV9mcm9tX25hbWVf
ZW50cmllcyhzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCj4gPiA+PiArCQlzdHJ1
Y3QgZXhmYXRfdW5pX25hbWUgKnVuaW5hbWUpDQo+ID4gPj4gICB7DQo+ID4gPj4gLQlpbnQgaTsN
Cj4gPiA+PiAtCXN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzOw0KPiA+ID4+ICsJaW50
IG4sIGwsIGk7DQo+ID4gPj4gICAJc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQo+ID4gPj4NCj4g
PiA+PiAtCWVzID0gZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc2IsIHBfZGlyLCBlbnRyeSwgRVNfQUxM
X0VOVFJJRVMpOw0KPiA+ID4+IC0JaWYgKCFlcykNCj4gPiA+PiAtCQlyZXR1cm47DQo+ID4gPj4g
Kwl1bmluYW1lLT5uYW1lX2xlbiA9IGVzLT5kZV9zdHJlYW0tPm5hbWVfbGVuOw0KPiA+ID4+ICsJ
aWYgKHVuaW5hbWUtPm5hbWVfbGVuID09IDApDQo+ID4gPj4gKwkJcmV0dXJuIC1FSU87DQo+ID4g
PiBDYW4gd2UgdmFsaWRhdGUgLT5uYW1lX2xlbiBhbmQgbmFtZSBlbnRyeSAtPnR5cGUgaW4gZXhm
YXRfZ2V0X2RlbnRyeV9zZXQoKSA/DQo+ID4NCj4gPiBZZXMuDQo+ID4gQXMgSSB3cm90ZSBpbiBh
IHByZXZpb3VzIGVtYWlsLCBlbnRyeSB0eXBlIHZhbGlkYXRpb24sIG5hbWUtbGVuZ3RoDQo+ID4g
dmFsaWRhdGlvbiwgYW5kIG5hbWUgZXh0cmFjdGlvbiBzaG91bGQgbm90IGJlIHNlcGFyYXRlZCwg
c28gaW1wbGVtZW50IGFsbCBvZiB0aGVzZSBpbiBleGZhdF9nZXRfZGVudHJ5X3NldCgpLg0KPiA+
IEl0IGNhbiBiZSBlYXNpbHkgaW1wbGVtZW50ZWQgYnkgYWRkaW5nIHVuaW5hbWUgdG8NCj4gPiBl
eGZhdF9lbnRyeV9zZXRfY2FjaGUgYW5kIGNhbGxpbmcNCj4gPiBleGZhdF9nZXRfdW5pbmFtZV9m
cm9tX25hbWVfZW50cmllcygpIGZyb20gZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKS4NCj4gTm8sIFdl
IGNhbiBjaGVjayBzdHJlYW0tPm5hbWVfbGVuIGFuZCBuYW1lIGVudHJ5IHR5cGUgaW4gZXhmYXRf
Z2V0X2RlbnRyeV9zZXQoKS4NCg0KSSBoYXZlIG5vIG9iamVjdGlvbiB0byB0aGF0IHBvaW50Lg0K
DQo+IEFuZCB5b3UgYXJlIGFscmVhZHkgY2hlY2tpbmcgZW50cnkgdHlwZSB3aXRoIFRZUEVfU0VD
T05EQVJZIGluIGV4ZmF0X2dldF9kZW50cnlfc2V0KCkuIFdoeSBkbyB3ZSBoYXZlIHRvIGNoZWNr
IHR3aWNlPw0KDQpUaGlzIHZlcmlmaWNhdGlvbiBpcyBhY2NvcmRpbmcgdG8gdGhlIGRlc2NyaXB0
aW9uIGluICc2LjMgR2VuZXJpYyBQcmltYXJ5IERpcmVjdG9yeUVudHJ5IFRlbXBsYXRlJy4NClRo
ZSBFbnRyeVNldCBpcyBjb21wb3NlZCBvZiBvbmUgcHJpbWFyeSBkaXItZW50cnkgYW5kIG11bHRp
cGxlIFNlY29uZGFyeSBkaXItZW50cmllcy4gDQpXZSBjYW4gdmFsaWRhdGUgdGhlIEVudHJ5U2V0
IGJ5IFNlY29uZGFyeUNvdW50IGFuZCBTZXRDaGVja3N1bSByZWNvcmRlZCBpbiB0aGUgUHJpbWFy
eSBkaXItZW50cnkuDQoNClRoZSBFbnRyeVNldCBjaGVja3N1bSB2YWxpZGF0aW9uIGFuZCBkaXIt
ZW50cmllcyBvcmRlciB2YWxpZGF0aW9uIGFyZSBhY2NvcmRpbmcgdG8gZGlmZmVyZW50IGRlc2Ny
aXB0aW9ucy4gDQpUaGVyZWZvcmUsIGl0IGlzIG5vdCBhIGRvdWJsZSBjaGVjay4NCg0KDQo+ID4g
SG93ZXZlciwgdGhhdCB3b3VsZCBiZSBvdmVyLWltcGxlbWVudGF0aW9uLg0KPiA+IE5vdCBhbGwg
Y2FsbGVycyBvZiBleGZhdF9nZXRfZGVudHJ5X3NldCgpIG5lZWQgYSBuYW1lLg0KPiBXaGVyZT8g
SXQgd2lsbCBub3QgY2hlY2tlZCB3aXRoIEVTXzJfRU5UUklFUy4NCg0KVGhlIGZvbGxvd2luZyBm
dW5jdGlvbnMgZG9uJ3QgcmVxdWlyZSBuYW1lLg0KX19leGZhdF90cnVuY2F0ZSgpDQpfX2V4ZmF0
X3dyaXRlX2lub2RlKCkNCmV4ZmF0X21hcF9jbHVzdGVyKCkNCmV4ZmF0X2ZpbmQoKQ0KDQoNCj4g
PiBJdCBpcyBlbm91Z2ggdG8gdmFsaWRhdGUgdGhlIG5hbWUgd2hlbiBpdCBpcyBuZWVkZWQuDQo+
ID4gVGhpcyBpcyBhIGZpbGUtc3lzdGVtIGRyaXZlciwgbm90IGZzY2suDQo+IFNvcnJ5LCBJIGRv
bid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHRhbGtpbmcgYWJvdXQuIElmIHRoZXJlIGlzIGEg
cHJvYmxlbSBpbiBvbmRpc2stbWV0YWRhdGEsIEZpbGVzeXN0ZW0gc2hvdWxkIHJldHVybg0KPiBl
cnJvci4NCg0KTXkgZXhwbGFuYXRpb24gbWF5IGhhdmUgYmVlbiBpbmFwcHJvcHJpYXRlLg0KKFZl
cmlmaWVyIGlzIGEgYmV0dGVyIG1ldGFwaG9yIHRoYW4gZnNjaykNCkVzc2VudGlhbGx5LCB0aGUg
cHVycG9zZSBvZiBmaWxlLXN5c3RlbSBkcml2ZXIgaXMgbm90IHRvIGRldGVjdCBpbmNvbnNpc3Rl
bmNpZXMuDQpPZiBjb3Vyc2UsIEZTRCBzaG91bGQgcmV0dXJuIGVycm9yIHdoZW4gaXQgZGV0ZWN0
cyBhbiBpbmNvbnNpc3RlbmN5LCBhcyB5b3Ugc2F5Lg0KSG93ZXZlciwgSSB0aGluayBpdCBpcyBu
by1uZWVkIGZvciBhY3RpdmUgaW5jb25zaXN0ZW5jeSBkZXRlY3Rpb24uDQoNCg0KPiA+IFZhbGlk
YXRpb24gaXMgcG9zc2libGUgaW4gZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSwgYnV0IHVubmVjZXNz
YXJ5Lg0KPiA+DQo+ID4gV2h5IGRvIHlvdSB3YW50IHRvIHZhbGlkYXRlIHRoZSBuYW1lIGluIGV4
ZmF0X2dldF9kZW50cnlfc2V0KCk/DQo+IGV4ZmF0X2dldF9kZW50cnlfc2V0IHZhbGlkYXRlcyBm
aWxlLCBzdHJlYW0gZW50cnkuIA0KDQo+IEFuZCB5b3UgYXJlIHRyeWluZyB0byBjaGVjayBuYW1l
IGVudHJpZXMgd2l0aCB0eXBlX3NlY29uZGFyeS4gDQoNCkl0J3MgYSBsaXR0bGUgZGlmZmVyZW50
Lg0KSSdtIHRyeWluZyB0byB2YWxpZGF0ZSB0aGUgY2hlY2tzdW0gYWNjb3JkaW5nIHRvICc2LjMg
R2VuZXJpYyBQcmltYXJ5IERpcmVjdG9yeUVudHJ5IFRlbXBsYXRlJy4NCg0KPiBJbiBhZGRpdGlv
biwgdHJ5aW5nIGFkZCB0aGUgY2hlY2tzdW0gY2hlY2suDQo+IENvbnZlcnNlbHksIFdoeSB3b3Vs
ZCB5b3Ugd2FudCB0byBhZGQgdGhvc2UgY2hlY2tzIHRvIGV4ZmF0X2dldF9kZW50cnlfc2V0KCk/
DQoNCldlIHNob3VsZCB2YWxpZGF0ZSB0aGUgRW50cnlTZXQgYmVmb3JlIHVzaW5nIGl0cyBjb250
ZW50cy4NCihzaG91bGQgbm90IHVzZSBjb250ZW50cyBvZiB0aGUgRW50cnlTZXQgd2l0aG91dCB2
YWxpZGF0aW5nIGl0KQ0KVGhlcmUgYXJlIG90aGVyIGZpbGVzeXN0ZW0gZGVzaWducyB0aGF0IGlu
Y2x1ZGUgY3JjL2NoZWNrc3VtIGluIHRoZWlyIGVhY2ggbWV0YWRhdGEgaGVhZGVycy4NClN1Y2gg
YSBkZXNpZ24gY2FuIGRldGVjdCBpbmNvbnNpc3RlbmNpZXMgZWFzaWx5IGFuZCBlZmZlY3RpdmVs
eS4NClRoaXMgdmVyaWZpY2F0aW9uIGlzIGVzcGVjaWFsbHkgZWZmZWN0aXZlIHdoZW4gbWV0YS1k
YXRhIGlzIHJlY29yZGVkIGluIG11bHRpcGxlIHNlY3RvcnMgbGlrZSB0aGUgRW50cnlTZXQuDQoN
Cj4gV2h5IGRvIHdlIGNoZWNrIG9ubHkgbmFtZSBlbnRyaWVzIHNlcGFyYXRlbHk/IA0KDQpUaGlz
IHZlcmlmaWNhdGlvbiBpcyBhY2NvcmRpbmcgdG8gdGhlIGRlc2NyaXB0aW9uIGluICc3LjYuMyBO
YW1lTGVuZ3RoIEZpZWxkJyBhbmQgJzcuNyBGaWxlIE5hbWUgRGlyZWN0b3J5IEVudHJ5Jy4NClNl
cGFyYXRlZCBiZWNhdXNlIGl0IGlzICBhY2NvcmRpbmcgdG8gZGlmZmVyZW50IGRlc2NyaXB0aW9u
IGZyb20gY2hlY2tzdW0uDQpBcyBJIHdyb3RlIGJlZm9yZSwgSSB0aGluayBUWVBFX05BTUUgYW5k
IE5hbWVMZW5ndGggdmFsaWRhdGlvbiBzaG91bGQgbm90IGJlIHNlcGFyYXRlZCBmcm9tIHRoZSBu
YW1lIGV4dHJhY3Rpb24uDQooQmVjYXVzZSB0aGV5IGFyZSBtb3JlIHN0cm9uZ2x5IHJlbGF0ZWQg
dGhhbiBvcmRlciBvZiBkaXItZW50cmllcykNClNvIEkgdGhpbmsgdGhlc2Ugc2hvdWxkIG5vdCBi
ZSBtaXhlZCB3aXRoIGNoZWNrc3VtIHZlcmlmaWNhdGlvbi4NCg0KV2hlbiBwYWNraW5nIG5hbWVz
IGludG8gTmFtZSBEaXItRW50cnkuLi4NCldlIGNhbiBhbHNvIGNhbGN1bGF0ZSB0aGUgY2hlY2tz
dW0gd2hpbGUgcGFja2luZyB0aGUgbmFtZSBpbnRvIHRoZSBOYW1lIERpci1FbnRyeS4NCkhvd2V2
ZXIsIHdlIHNob3VsZG4ndCBtaXggdGhlbS4NCg0KDQo+IEFyZW4ndCB5b3UgaW50ZW50IHRvIHJl
dHVybiB2YWxpZGF0ZWQgZW50cnkgc2V0IGluIGV4ZmF0X2dldF9kZW50cnlfc2V0KCk/DQoNCklm
IHNvLCBhZGQgZXhmYXRfZ2V0X3VuaW5hbWVfZnJvbV9uYW1lX2VudHJpZXMoKSBhZnRlciBjaGVj
a3N1bSB2ZXJpZmljYXRpb24uKGFzIGJlbG93KQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KCS8qIEVudHJ5U2V0IGNoZWNrc3VtIHZlcmlmaWNh
dGlvbiAqLw0KDQorCWlmIChtYXhfZW50cmllcyA9PSBFU19BTExfRU5UUklFUyAmJg0KKwkgICAg
ZXhmYXRfZ2V0X3VuaW5hbWVfZnJvbV9uYW1lX2VudHJpZXMoZXMsIGVzLT51bmluYW1lKSkNCisJ
CWdvdG8gZnJlZV9lczsNCglyZXR1cm4gZXM7DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNClRoZSBvbmx5IGNhbGxlcnMgdGhhdCBuZWVkIGEg
bmFtZSBhcmUgZXhmYXRfcmVhZGRpcigpIGFuZCBleGZhdF9maW5kX2Rpcl9lbnRyeSgpLCBub3Qg
dGhlIG90aGVycy4NClVubmVjZXNzYXJ5IG5hbWUgZXh0cmFjdGlvbiB2aW9sYXRlcyB0aGUgSklU
IHByaW5jaXBsZS4NCihUaGUgc2l6ZSBvZiBleGZhdF9lbnRyeV9zZXRfY2FjaGUgd2lsbCBhbHNv
IGluY3JlYXNlKQ0KQW5kIGV2ZW4gaWYgd2UgY2FsbCBleGZhdF9nZXRfdW5pbmFtZV9mcm9tX25h
bWVfZW50cmllcygpIGxhdGVyLCB3ZSBjYW4gY29ycmVjdGx5IGRldGVybWluZSANCiJGaWxlIE5h
bWUgZGlyZWN0b3J5IGVudHJpZXMgYXJlIHZhbGlkIG9ubHkgaWYgdGhleSBpbW1lZGlhdGVseSBm
b2xsb3cgdGhlIFN0cmVhbSBFeHRlbnNpb24gZGlyZWN0b3J5IGVudHJ5IGFzIGEgY29uc2VjdXRp
dmUgc2VyaWVzIg0KDQpGaWxlIGRpci1lbnRyeSBzZXQgY2FuIGNvbnRhaW4gZGlyLWVudHJpZXMg
b3RoZXIgdGhhbiBmaWxlLCBzdHJlYW0tZXh0IGFuZCBuYW1lLg0KV2UgZG9uJ3QgbmVlZCB0byB2
YWxpZGF0ZSBvciBleHRyYWN0IHRoZW0gYWxsIGluIGV4ZmF0X2dldF9kZW50cnlfc2V0KCkuDQpJ
IHRoaW5rIGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBvbmx5IG5lZWRzIHRvIHByb3ZpZGUgYSBmcmFt
ZXdvcmsgZm9yIGVhc3kgYWNjZXNzIHdoZW4gbmVlZGVkLg0KDQpCUg0KLS0tDQpLb2hhZGEgVGV0
c3VoaXJvIDxLb2hhZGEuVGV0c3VoaXJvQGRjLk1pdHN1YmlzaGlFbGVjdHJpYy5jby5qcD4NCg0K
DQo=
