Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B6C1A7762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437672AbgDNJc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 05:32:29 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:60522 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437663AbgDNJc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:32:27 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id BB7673A3F3D;
        Tue, 14 Apr 2020 18:32:20 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 491gHm50bnzRkGt;
        Tue, 14 Apr 2020 18:32:20 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr06.melco.co.jp (Postfix) with ESMTP id 491gHm4hldzRkGX;
        Tue, 14 Apr 2020 18:32:20 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 491gHm4pmVzRk0Z;
        Tue, 14 Apr 2020 18:32:20 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.54])
        by mf04.melco.co.jp (Postfix) with ESMTP id 491gHm4NCfzRk5B;
        Tue, 14 Apr 2020 18:32:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGv3LQIpP6mhTEAD7hFwCtyMhTDwhyxi2YnBDGjCaiwAUmjgFE+hbacXp1IOeFD2cyOOaN9AoIxWbVFnf1+xxZ4emmuElFK4Tp3lWHYbR4uJA+CYaNS/eTzVUI5KUn96gus3NNmw2oOqhc8ibFyvyJmm8mDkWAlHsgzsuXN75cAL8Qb2Ve5wldHHuhrok6EVfAXUKdMk18XS5KMd0pHEuCJt8lPrL9WEocHY1U42TNitJhuqlXpFCKHBzdIYk4eZq+m+CVXvb+3ihoslTBZRYFSMB6Oig8OWGjfDFT8KN8r8NVcEXK6T56ag4ULAzHmAC+y8GZ7ylJUtWOBRM+tw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcGEiFIBF3Vp4Y9xN87k6uIX2rQKUCC2lhQwmDK1mk8=;
 b=ZA4mDjf5fveHIJLReU4QaU9uNnW1En0/pBdk4zqXdTK7R1YNJQTyWVded03aTOs1PHtmNPCyG0zFNctQlBFB09HIQ3bS8El2zXLjYSan3CDdBi5StqKw7HYd8pQbP3xOJEXmaRdx8uKZP3LLDrfoISoHQLjoDw72vcy388kLmnbguCflC+fy1yOLW7EQFXHvCCuRLXrVBBImKolW5topVDbw09ZgepuKbVNfsPyhhY9Zcq6LY6phKXgw1R2SqwoANN1lUkuB78fPpO+bznxjd/7MJITYtqEdcEVM5ViXqfxuxAhRQ4bTMJbJC0HXEqwz5rb3l96W+H/1m71qP5HBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcGEiFIBF3Vp4Y9xN87k6uIX2rQKUCC2lhQwmDK1mk8=;
 b=FQfMMI1P1cYvZLVBcPID9AQPVOw2Eci5RI8gLiFMQYDu62yzN5HpqP2GXEP6ri7IR1FQDRqLN3zAxmO/6mw4xlO3/fcMEXN/mKGE/2gT6ufEPJo+ir7WYA6332WSW4iK9JA077KqIhGh4R0lEjeQEI52vcqsEG0jrWiiikY+ZrE=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1658.jpnprd01.prod.outlook.com (52.133.162.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Tue, 14 Apr 2020 09:32:20 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:32:20 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Subject: RE: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Topic: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Index: AQHWCfgm33iC4HYp6U6hpobeaScABqhrVdFggAIevgCAARtD4IAAZbCAgAd0CHCAAHnvgIABFVvA
Date:   Tue, 14 Apr 2020 09:29:32 +0000
Deferred-Delivery: Tue, 14 Apr 2020 09:32:00 +0000
Message-ID: <TY1PR01MB15782010C68C0C568A6AE68690DA0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
 <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200408090435.i3ufmbfinx5dyd7w@pali>
 <TY1PR01MB15784063EED4CEC93A2B501390DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200413101007.lbey6q5u6jz3ulmr@pali>
In-Reply-To: <20200413101007.lbey6q5u6jz3ulmr@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f618125-4664-4cae-e068-08d7e056bab2
x-ms-traffictypediagnostic: TY1PR01MB1658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB165800C119B0787B158DB6F490DA0@TY1PR01MB1658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(45080400002)(66946007)(71200400001)(316002)(54906003)(4326008)(8936002)(107886003)(186003)(33656002)(7696005)(9686003)(55016002)(76116006)(6916009)(86362001)(478600001)(66476007)(64756008)(66446008)(66556008)(52536014)(5660300002)(26005)(6506007)(8676002)(2906002)(6666004)(81156014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvO/3O26I2vE0sRxan/6Z6EcEFo+9f3A8q7GnHLR6Zp2ZNGsyExZS8/oze2vDlQNDEG4ez61WpUFRkZnP0wLweh+5EvfJDaXi5Cf1YCi9WuRmdIUWq/sVVueTh/QM0+6tYcvloam4a39y1efdDF9ujY0SUROzKDqB3QcGOFUh/3JUkOaZ4WT00zA9qZAxnrRu1QEx3n3nSQp0DxIjoxqg1Tc54vY/pEfxo9I1rC4lpbjLNmaEWx50wuWG0dMfYg/bp2DloOF5X2ahF+/l9mp6WXz72tGojGS5tdxobBt7bq7baFroVLP5n1/qdxc3JazHID8lHUEUnljoQcUVbB4rPmawJ26S/DzTOuwxz52lpyLX98ozH7Qd7axSJ3EoP2T6S7KHqPr6046D1fi0bQ3FmMcTleLg1c5+IKu3f9swLS9OXSt4E6l7zpqAEltEy3R
x-ms-exchange-antispam-messagedata: /7Mqaor1SXlonFtH//w7DT+EJZQaAIwN+QdqNDdLWW4CxUXm56IqQiC8ceiqlderGps6/BXxlilAuom+2o8gKNRj1u+sj3R69XH7GlILoNG/APzMfJD8c+ZEJ5Z4zfzE2j7UtAnjE1nuHSIl4DG8XQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f618125-4664-4cae-e068-08d7e056bab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 09:32:19.9539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRLSwWQoqX+kKSVy78k/d/+aYM/bEKzlS0WXS4jjAHKdBvzVOF75UibR/UvnqoUa0XSwz7yhQYzdxU+9aubFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1658
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBXZSBkbyBub3Qga25vdyBob3cgY29kZSBwb2ludHMgYWJvdmUgVStGRkZGIGNvdWxkIGJlIGNv
bnZlcnRlZCB0byB1cHBlciBjYXNlLiANCg0KQ29kZSBwb2ludHMgYWJvdmUgVStGRkZGIGRvIG5v
dCBuZWVkIHRvIGJlIGNvbnZlcnRlZCB0byB1cHBlcmNhc2UuDQoNCj4gQmFzaWNhbGx5IGZyb20g
ZXhmYXQgc3BlY2lmaWNhdGlvbiBjYW4gYmUgZGVkdWNlZCBpdCBvbmx5IGZvcg0KPiBVKzAwMDAg
Li4gVStGRkZGIGNvZGUgcG9pbnRzLiANCg0KZXhGQVQgc3BlY2lmaWNhdGlvbnMgKHNlYy43LjIu
NS4xKSBzYWlkcyAuLi4NCi0tIHRhYmxlIHNoYWxsIGNvdmVyIHRoZSBjb21wbGV0ZSBVbmljb2Rl
IGNoYXJhY3RlciByYW5nZSAoZnJvbSBjaGFyYWN0ZXIgY29kZXMgMDAwMGggdG8gRkZGRmggaW5j
bHVzaXZlKS4NCg0KVUNTLTIsIFVDUy00LCBhbmQgVVRGLTE2IHRlcm1zIGRvIG5vdCBhcHBlYXIg
aW4gdGhlIGV4ZmF0IHNwZWNpZmljYXRpb24uDQpJdCBqdXN0IHNheXMgIlVuaWNvZGUiLg0KDQoN
Cj4gU2Vjb25kIHByb2JsZW0gaXMgdGhhdCBhbGwgTVMgZmlsZXN5c3RlbXMgKHZmYXQsIG50ZnMg
YW5kIGV4ZmF0KSBkbyBub3QgdXNlIFVDUy0yIG5vciBVVEYtMTYsIGJ1dCByYXRoZXIgc29tZSBt
aXggYmV0d2Vlbg0KPiBpdC4gQmFzaWNhbGx5IGFueSBzZXF1ZW5jZSBvZiAxNmJpdCB2YWx1ZXMg
KGV4Y2VwdCB0aG9zZSA6Lzw+Li4uIHZmYXQgY2hhcnMpIGlzIHZhbGlkLCBldmVuIHVucGFpcmVk
IHN1cnJvZ2F0ZSBoYWxmLiBTbw0KPiBzdXJyb2dhdGUgcGFpciAodHdvIDE2Yml0IHZhbHVlcykg
cmVwcmVzZW50cyBvbmUgdW5pY29kZSBjb2RlIHBvaW50IChhcyBpbiBVVEYtMTYpLCBidXQgb25l
IHVucGFpcmVkIHN1cnJvZ2F0ZSBoYWxmIGlzDQo+IGFsc28gdmFsaWQgYW5kIHJlcHJlc2VudCAo
aW52YWxpZCkgdW5pY29kZSBjb2RlIHBvaW50IG9mIGl0cyB2YWx1ZS4gSW4gdW5pY29kZSBhcmUg
bm90IGRlZmluZWQgY29kZSBwb2ludHMgZm9yIHZhbHVlcw0KPiBvZiBzaW5nbGUgLyBoYWxmIHN1
cnJvZ2F0ZS4NCg0KTWljcm9zb2Z0J3MgRmlsZSBTeXN0ZW1zIHVzZXMgdGhlIFVURi0xNiBlbmNv
ZGVkIFVDUy00IGNvZGUgc2V0Lg0KVGhlIGNoYXJhY3RlciB0eXBlIGlzIGJhc2ljYWxseSAnd2No
YXJfdCcoMTZiaXQpLg0KVGhlIGRlc2NyaXB0aW9uICIwMDAwaCB0byBGRkZGaCIgYWxzbyBhc3N1
bWVzIHRoZSB1c2Ugb2YgJ3djaGFyX3QnLg0KDQpUaGlzIOKAnDAwMDBoIHRvIEZGRkZo4oCdIGFs
c28gaW5jbHVkZXMgc3Vycm9nYXRlIGNoYXJhY3RlcnMoVStEODAwIHRvIFUrREZGRiksDQpidXQg
dGhlc2Ugc2hvdWxkIG5vdCBiZSBjb252ZXJ0ZWQgdG8gdXBwZXIgY2FzZS4NClBhc3NpbmcgYSBz
dXJyb2dhdGUgY2hhcmFjdGVyIHRvIFJ0bFVwY2FzZVVuaWNvZGVDaGFyKCkgb24gV2luZG93cywg
anVzdCByZXR1cm5zIHRoZSBzYW1lIHZhbHVlLg0KKCogUnRsVXBjYXNlVW5pY29kZUNoYXIoKSBp
cyBvbmUgb2YgV2luZG93cyBuYXRpdmUgQVBJKQ0KDQpJZiB0aGUgdXBjYXNlLXRhYmxlIGNvbnRh
aW5zIHN1cnJvZ2F0ZSBjaGFyYWN0ZXJzLCBleGZhdF90b3VwcGVyKCkgd2lsbCBjYXVzZSBpbmNv
cnJlY3QgY29udmVyc2lvbi4NCldpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHRoZSBy
ZXN1bHRzIG9mIGV4ZmF0X3V0ZjhfZF9jbXAoKSBhbmQgZXhmYXRfdW5pbmFtZV9uY21wKCkgbWF5
IGRpZmZlci4NCg0KVGhlIG5vcm1hbCBleGZhdCdzIHVwY2FzZS10YWJsZSBkb2VzIG5vdCBjb250
YWluIHN1cnJvZ2F0ZSBjaGFyYWN0ZXJzLCBzbyB0aGUgcHJvYmxlbSBkb2VzIG5vdCBvY2N1ci4N
ClRvIGJlIG1vcmUgc3RyaWN0Li4uDQpEODAwaCB0byBERkZGaCBzaG91bGQgYmUgZXhjbHVkZWQg
d2hlbiBsb2FkaW5nIHVwY2FzZS10YWJsZSBvciBpbiBleGZhdF90b3VwcGVyKCkuDQoNCj4gVGhl
cmVmb3JlIGlmIHdlIHRhbGsgYWJvdXQgZW5jb2RpbmcgVVRGLTE2IHZzIFVURi0zMiB3ZSBmaXJz
dCBuZWVkIHRvIGZpeCBhIHdheSBob3cgdG8gaGFuZGxlIHRob3NlIG5vbi1yZXByZXNlbnRhdGl2
ZQ0KPiB2YWx1ZXMgaW4gVkZTIGVuY29kaW5nIChpb2NoYXJzZXQ9KSBhcyBVVEYtOCBpcyBub3Qg
YWJsZSB0byByZXByZXNlbnQgaXQgdG9vLiBPbmUgb3B0aW9uIGlzIHRvIGV4dGVuZCBVVEYtOCB0
byBXVEYtOCANCj4gZW5jb2RpbmcgWzFdICh5ZXMsIHRoaXMgaXMgYSByZWFsIGFuZCBtYWtlIHNl
bnNlISkgYW5kIHRoZW4gaWRlYWxseSBjaGFuZ2UgZXhmYXRfdG91cHBlcigpIHRvIFVURi0zMiB3
aXRob3V0IHJlc3RyaWN0aW9uIA0KPiBmb3Igc3Vycm9nYXRlIHBhaXJzIHZhbHVlcy4NCg0KV1RG
LTggaXMgbmV3IHRvIG1lLg0KVGhhdCdzIGFuIGludGVyZXN0aW5nIGlkZWEsIGJ1dCBpcyBpdCBu
ZWVkZWQgZm9yIGV4ZmF0Pw0KDQpGb3IgY2hhcmFjdGVycyBvdmVyIFUrRkZGRiwNCiAtRm9yIFVU
Ri0zMiwgYSB2YWx1ZSBvZiAweDEwMDAwIG9yIG1vcmUNCiAtRm9yIFVURi0xNiwgdGhlIHZhbHVl
IGZyb20gMHhkODAwIHRvIDB4ZGZmZg0KSSB0aGluayB0aGVzZSBhcmUganVzdCAiZG9uJ3QgY29u
dmVydCB0byB1cHBlcmNhc2UuIg0KDQpJZiB0aGUgRmlsZSBOYW1lIERpcmVjdG9yeSBFbnRyeSBj
b250YWlucyBpbGxlZ2FsIHN1cnJvZ2F0ZSBjaGFyYWN0ZXJzKHN1Y2ggYXMgb25lIHVucGFpcmVk
IHN1cnJvZ2F0ZSBoYWxmKSwNCml0IHdpbGwgc2ltcGx5IGJlIGlnbm9yZWQgYnkgdXRmMTZzX3Rv
X3V0ZjhzKCkuDQpzdHJpbmcgYWZ0ZXIgdXRmOCBjb252ZXJzaW9uIGRvZXMgbm90IGluY2x1ZGUg
aWxsZWdhbCBieXRlIHNlcXVlbmNlLg0KDQoNCj4gQnR3LCBzYW1lIHByb2JsZW0gd2l0aCBVVEYt
MTYgYWxzbyBpbiB2ZmF0LCBudGZzIGFuZCBhbHNvIGluIGlzby9qb2xpZXQga2VybmVsIGRyaXZl
cnMuDQoNClVnaC4uLg0KDQoNCkJSDQotLS0NCktvaGFkYSBUZXRzdWhpcm8gPEtvaGFkYS5UZXRz
dWhpcm9AZGMuTWl0c3ViaXNoaUVsZWN0cmljLmNvLmpwPg0KDQo=
