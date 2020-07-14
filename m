Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571A21E56A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGNB6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 21:58:34 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:52276 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGNB6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:58:33 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id D976E3A461A;
        Tue, 14 Jul 2020 10:58:30 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4B5Nw665qBzRjv1;
        Tue, 14 Jul 2020 10:58:30 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4B5Nw65nTHzRjjn;
        Tue, 14 Jul 2020 10:58:30 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4B5Nw65SFWzRjw6;
        Tue, 14 Jul 2020 10:58:30 +0900 (JST)
Received: from APC01-HK2-obe.outbound.protection.outlook.com (unknown [104.47.124.58])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4B5Nw63JNSzRjws;
        Tue, 14 Jul 2020 10:58:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsOrPXkFUP/kk6eD1PoKUqo4oXdsDgwzm3RFBFePRpaWXGvpZn8JXeChy0usgUENg28TMGzZfrKaxVUpBtya4jzaoNjHhv/763i/O9U5PDHF8sBHOCvea5mNAf6eYSTW37uZ4PxeKV9199zt2rPX4DcIiQgMKDi8EcFu8Yd3XVsdqrh509gmCsqeWFRhHN7ZsUnU1QgW5LG0i0PLwBSqAYGporap7WOdehGvdTCZAjj7PwHFpBSMIYpPUNXDKHaDYbuL7yLvk4HhTaqLgNBKdtMEFxCJeMLKEr8hxtOWzRcrvsxZgUeVgzQESqXDPYNRjSQvvoODhQ/SGGkpwhgteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kjDilVTmpZ1FtZslpqPbA8kRqifqSYZukp2s74RobY=;
 b=Sy3zwnByN0Tl0P18gJwjqlDNSnmysx6nuhPzSE37h4IDhwkCTw2qrI3glPUoaggUBSWawoH96K+eJSaM3pUBk7MTOuaw5Nf54XOYsPilC4EJvTbMhZMqzvN4J9fN11A/JqDgk8bpHuACJOgHLqMXHqGGBpEPzMc0AFwE+gOTnzDBbaWGn5DtBW7tLzwGTFz+lGqiEy2MlVz6P39osZuCcyA1VPcRLN7ngi7Wrqa93gxBGa+np1VoUTA5nFgtFS1bDXlpqXVQT5XyJkF1ErGE+ibPLzcnM+Ub52vOE4Zo/4wvyd9InwcXvtPL9MZ2np7dYZ7r9Y6SfIU0GaoT+45gEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kjDilVTmpZ1FtZslpqPbA8kRqifqSYZukp2s74RobY=;
 b=Io0sIA30jAd5QLPC15xqeQEB+OOnSN04147+72DTbf5kdCKKkNNC7GWnVbVOfEetqHZCUHi+cMSau3wHe878JRPS7AHR8Yq1SbWahzTGLub3OpwLi30q1fgXawAzj26XvfDthiyS9BS5zr1JzKHE+Mjv+tBG1s13uJFXgoiw1Ro=
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com (2603:1096:404:6b::11)
 by TY2PR01MB4105.jpnprd01.prod.outlook.com (2603:1096:404:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 01:58:29 +0000
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51f8:6ee3:3a68:20e6]) by TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51f8:6ee3:3a68:20e6%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 01:58:29 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Namjae Jeon' <namjae.jeon@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Tetsuhiro Kohada'' <kohada.t2@gmail.com>
Subject: RE: [PATCH] exfat: retain 'VolumeFlags' properly
Thread-Topic: [PATCH] exfat: retain 'VolumeFlags' properly
Thread-Index: AQHWWNF3XIWNewnjOkCXG4imrImUuqkFQdCw
Date:   Tue, 14 Jul 2020 01:56:23 +0000
Deferred-Delivery: Tue, 14 Jul 2020 01:58:00 +0000
Message-ID: <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
        <20200708095746.4179-1-kohada.t2@gmail.com>
 <005101d658d1$7202e5d0$5608b170$@samsung.com>
In-Reply-To: <005101d658d1$7202e5d0$5608b170$@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb38d36c-53f3-4ce9-6a88-08d8279967c5
x-ms-traffictypediagnostic: TY2PR01MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4105C17D5ACB4216EAF057E790610@TY2PR01MB4105.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvWpeSiK69lzNALC28FIAt1augiqYAGMcg6gC1erFv+cxpxos285Lf6IGyjEWyW4gfXF7Ec6NH6UaO84Y6aoZ+VsWXX9n5XUglacPbFp2j7u/NcdthjllKEsTX0vT2OZry1P4LKHbXJ1XyLYGlEP+fDmz8fl/ClRly97+LLwkA4XF7Bq0DUmd0V3y56hYhGJ1hbsawxRl5JZk8qTBQyPTGdnQgQ59jW0eZQnk3sbgBOPCe7Gq/BXjBhB9Mc1epwwxud0qi0k7yZCwcuisDWtGxNOcGUBPH8STkiwE61wrPhDWo2J6/s/3vR6Maneb6ThVYWfdQnQ8ot+Db5IOoIN4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2875.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(478600001)(6916009)(6506007)(66446008)(66476007)(55016002)(64756008)(66556008)(66946007)(4326008)(76116006)(9686003)(8936002)(52536014)(33656002)(7696005)(71200400001)(83380400001)(8676002)(6666004)(54906003)(2906002)(26005)(316002)(186003)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qY8ckC9fvWczikxlSe2ZZckNh9vOqsdPVmC+oVArTAXGc0iz6n2yxWWXB8gAw5tD+ebX99x6cYgaRHedia16y/iwcTZxuG1jENsKLaIqHoHziUFNJ4sDjhMdBXtl+iZkX11Yx7DwthHmYtV/CoM1L7WVvihM9oIkL6r1YwL2jsmFf0vLk59ibuI99LIZxfSPAgVoODSQaQcWJ0FvuA49MV4j0K5yEUjPVo3DGLQdBW4atPnh+6K+l9RIP60JGP83LJS8s45R6mur6E/kUhNjBHFy2Vn4l02IfCODywE0789fIDH80gBkguDA4TgRIVIyKDIN9BekwCFBC6Ht1BWR9PjZRpcTkKDKHkzt/Vu26U24IYCuoc2XccnbtcLYUJvc3GUGVS7S1TRoNelqYorMNkwjr8f6iJ+qCDEUA2a7LLCekNusiDCEYiChGJqn/xeTdWKx9EAf3qhQf+IJGJOPJHqfUOxeBz6Rucxu/fM0g70=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2875.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb38d36c-53f3-4ce9-6a88-08d8279967c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 01:58:29.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9i0trMHKIfGC5GGpW7cC6nYrTjj9p2BYtiCwUeorog0BEa8SxwVObKXDyHGT+fsS/uxiJ0RS9dV9WwyBZswIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4105
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gQWxzbywgcmVuYW1lIEVSUl9NRURJVU0gdG8g
TUVEX0ZBSUxVUkUuDQo+IEkgdGhpbmsgdGhhdCBNRURJQV9GQUlMVVJFIGxvb2tzIGJldHRlci4N
Cg0KSSB0aGluayBzbyB0b28uDQpJZiBzbywgc2hvdWxkIEkgY2hhbmdlIFZPTF9ESVJUWSB0byBW
T0xVTUVfRElSVFk/DQoNCj4gPiAtaW50IGV4ZmF0X3NldF92b2xfZmxhZ3Moc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiwgdW5zaWduZWQgc2hvcnQNCj4gPiBuZXdfZmxhZykNCj4gPiAraW50IGV4ZmF0
X3NldF92b2xfZmxhZ3Moc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgc2hvcnQNCj4g
PiArbmV3X2ZsYWdzKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0g
RVhGQVRfU0Ioc2IpOw0KPiA+ICAJc3RydWN0IGJvb3Rfc2VjdG9yICpwX2Jvb3QgPSAoc3RydWN0
IGJvb3Rfc2VjdG9yICopc2JpLT5ib290X2JoLT5iX2RhdGE7DQo+ID4gIAlib29sIHN5bmM7DQo+
IElmIGRpcnR5IGJpdCBpcyBzZXQgaW4gb24tZGlzayB2b2x1bWUgZmxhZ3MsIHdlIGNhbiBqdXN0
IHJldHVybiAwIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhpcyBmdW5jdGlvbiA/DQoNClRoYXQncyBy
aWdodC4NCk5laXRoZXIgJ3NldCBWT0xfRElSVFknIG5vciAnc2V0IFZPTF9DTEVBTicgbWFrZXMg
YSBjaGFuZ2UgdG8gdm9sdW1lIGZsYWdzLg0KDQoNCj4gPiArCWlmIChuZXdfZmxhZ3MgPT0gVk9M
X0NMRUFOKQ0KPiA+ICsJCW5ld19mbGFncyA9IChzYmktPnZvbF9mbGFncyAmIH5WT0xfRElSVFkp
IHwgc2JpLT52b2xfZmxhZ3Nfbm9jbGVhcjsNCj4gPiArCWVsc2UNCj4gPiArCQluZXdfZmxhZ3Mg
fD0gc2JpLT52b2xfZmxhZ3M7DQo+ID4gKw0KPiA+ICAJLyogZmxhZ3MgYXJlIG5vdCBjaGFuZ2Vk
ICovDQo+ID4gLQlpZiAoc2JpLT52b2xfZmxhZyA9PSBuZXdfZmxhZykNCj4gPiArCWlmIChzYmkt
PnZvbF9mbGFncyA9PSBuZXdfZmxhZ3MpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAtCXNi
aS0+dm9sX2ZsYWcgPSBuZXdfZmxhZzsNCj4gPiArCXNiaS0+dm9sX2ZsYWdzID0gbmV3X2ZsYWdz
Ow0KPiA+DQo+ID4gIAkvKiBza2lwIHVwZGF0aW5nIHZvbHVtZSBkaXJ0eSBmbGFnLA0KPiA+ICAJ
ICogaWYgdGhpcyB2b2x1bWUgaGFzIGJlZW4gbW91bnRlZCB3aXRoIHJlYWQtb25seSBAQCAtMTE0
LDkgKzExOSw5DQo+ID4gQEAgaW50IGV4ZmF0X3NldF92b2xfZmxhZ3Moc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwgdW5zaWduZWQgc2hvcnQgbmV3X2ZsYWcpDQo+ID4gIAlpZiAoc2JfcmRvbmx5KHNi
KSkNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+IC0JcF9ib290LT52b2xfZmxhZ3MgPSBjcHVf
dG9fbGUxNihuZXdfZmxhZyk7DQo+ID4gKwlwX2Jvb3QtPnZvbF9mbGFncyA9IGNwdV90b19sZTE2
KG5ld19mbGFncyk7DQo+IEhvdyBhYm91dCBzZXQgb3IgY2xlYXIgb25seSBkaXJ0eSBiaXQgdG8g
b24tZGlzayB2b2x1bWUgZmxhZ3MgaW5zdGVhZCBvZiB1c2luZw0KPiBzYmktPnZvbF9mbGFnc19u
b2NsZWFyID8NCj4gICAgICAgIGlmIChzZXQpDQo+ICAgICAgICAgICAgICAgIHBfYm9vdC0+dm9s
X2ZsYWdzIHw9IGNwdV90b19sZTE2KFZPTF9ESVJUWSk7DQo+ICAgICAgICBlbHNlDQo+ICAgICAg
ICAgICAgICAgIHBfYm9vdC0+dm9sX2ZsYWdzICY9IGNwdV90b19sZTE2KH5WT0xfRElSVFkpOw0K
DQpJbiB0aGlzIHdheSwgdGhlIGluaXRpYWwgIFZPTF9ESVJUWSBjYW5ub3QgYmUgcmV0YWluZWQu
DQpUaGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzIHRvIGF2b2lkIGxvc2luZyB0aGUgaW5pdGlh
bCBWT0xfRElSVFkgYW5kIE1FRF9GQUlMVVJFLg0KRnVydGhlcm1vcmUsIEknbSBhbHNvIHRoaW5r
aW5nIG9mIHNldHRpbmcgTUVEX0ZBSUxVUkUuDQoNCkhvd2V2ZXIsIHRoZSBmb3JtdWxhIGZvciAn
bmV3X2ZsYWdzJyBtYXkgYmUgYSBiaXQgY29tcGxpY2F0ZWQuDQpJcyBpdCBiZXR0ZXIgdG8gY2hh
bmdlIHRvIHRoZSBmb2xsb3dpbmc/DQoNCglpZiAobmV3X2ZsYWdzID09IFZPTF9DTEVBTikNCgkJ
bmV3X2ZsYWdzID0gc2JpLT52b2xfZmxhZ3MgJiB+Vk9MX0RJUlRZDQoJZWxzZQ0KCQluZXdfZmxh
Z3MgfD0gc2JpLT52b2xfZmxhZ3M7DQoNCgluZXdfZmxhZ3MgfD0gc2JpLT52b2xfZmxhZ3Nfbm9j
bGVhcjsNCg0KDQpvbmUgbW9yZSBwb2ludCwNCklzIHRoZXJlIGEgYmV0dGVyIG5hbWUgdGhhbiAn
dm9sX2ZsYWdzX25vY2xlYXInPw0KKEkgY2FuJ3QgY29tZSB1cCB3aXRoIGEgZ29vZCBuYW1lIGFu
eW1vcmUpDQoNCkJSDQotLS0NCktvaGFkYSBUZXRzdWhpcm8gPEtvaGFkYS5UZXRzdWhpcm9AZGMu
TWl0c3ViaXNoaUVsZWN0cmljLmNvLmpwPg0K
