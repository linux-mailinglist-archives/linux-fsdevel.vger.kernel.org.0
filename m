Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91421E667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 05:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgGNDid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 23:38:33 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:52982 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgGNDid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:38:33 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 68FCE3A4497;
        Tue, 14 Jul 2020 12:38:31 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 4B5R7W2chpzRjpb;
        Tue, 14 Jul 2020 12:38:31 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 4B5R7W2JXMzRk9B;
        Tue, 14 Jul 2020 12:38:31 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4B5R7W2D8pzRjwN;
        Tue, 14 Jul 2020 12:38:31 +0900 (JST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (unknown [104.47.125.58])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4B5R7V6l9QzRjw6;
        Tue, 14 Jul 2020 12:38:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiM19rwF4jQQbQr/2u+uEmPHaU+LFGrCngaTZZC9PC7YgVFrQ1oDuHekoVLKolo8LbgWM6dYR15/9HfpDsmhZcAJx7FcxLQWDRX9vHb5muL4Q3kkVZuRnwQp+c1bwlp6CCIHgCIyn5BzJclLgenwqxepPQd4bMQSLSrhAu57tFkuvIwlquED2VqkGRT9h4IPYfW4Kp64Y+Qn82fS4OjZLSJ8l+aPlQSE04U96e2Rkwgdq/FkKU97dpBYkM9QWtWkk0PcG34gUTLr7Hgm/qR3F09La9lnmKpJz5WkFVNyuaovgM5EmllcojEC4yoM236B7rxIjKyCQIQBXKlPH5HLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhB7ud2Xu9rJsJecsm3x5bP9VkLaZ1GXmA/UUYNG6B4=;
 b=YexOxTBTJ2jBBDhGqJfUvRqI856Lj3iq06CpGxZcmF11keMZ+M1VliJQvfRqk8h11CtL4PfQiyilo+sIDDHcMFsXLrhiOIxKA+X2WWA3QP78SS43K/YRGPp7eFVtZxrvdb0J7TeUKsooeWxzQWLeU8c4Yxap1IOcFzCjKlS0d0ieaJy9LnTzDV0lTZvuZDnnmgJ1LzxBfJQ2FEpCbeWr444OTDIFLUXUd5iyV3gTofMLPdGFdoD00Sjv62Ki4CPhjInNt0ITJcOxSZ4zYNfqLgiH4vOyMpsHCkSTG/tm0lq4KU/EPcwTyEhe8IdezJemun5DIujoRXyNRM1EVQ1BZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhB7ud2Xu9rJsJecsm3x5bP9VkLaZ1GXmA/UUYNG6B4=;
 b=Ym4MJsGvYziYF4yh/YOGRIwjiWIEcX+tSh4Vs37y6gEReIBVkLS0+7UwQ+aVgYPKKYdv9oUnUrWCMIX0oZp+lEYY3/e0eatuRLN+GlKZBGvHoTnxKzZmpiiDBe/l89CHZlH/Hxw6BuDzLg1tHeSAAKSb9kDlaM7AH+Fo2ianPKQ=
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com (2603:1096:404:6b::11)
 by TY2PR01MB4425.jpnprd01.prod.outlook.com (2603:1096:404:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 03:38:29 +0000
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51f8:6ee3:3a68:20e6]) by TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51f8:6ee3:3a68:20e6%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 03:38:29 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Sungjong Seo' <sj1557.seo@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC]PATCH] exfat: integrates dir-entry getting and validation
Thread-Topic: [RFC]PATCH] exfat: integrates dir-entry getting and validation
Thread-Index: AQHWWLwPRt+8581iI0We4lRfkrRHoKkGVDbQ
Date:   Tue, 14 Jul 2020 03:35:57 +0000
Deferred-Delivery: Tue, 14 Jul 2020 03:38:00 +0000
Message-ID: <TY2PR01MB2875E617CBA988EEF65A7DD390610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
References: <CGME20200626061009epcas1p24585a6472e7103dc878bf9fc1d0f7d12@epcas1p2.samsung.com>
        <20200626060947.24709-1-kohada.t2@gmail.com>
 <4a6201d658bc$09e3fa80$1dabef80$@samsung.com>
In-Reply-To: <4a6201d658bc$09e3fa80$1dabef80$@samsung.com>
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
x-ms-office365-filtering-correlation-id: 7827d877-6a80-4ed3-8a20-08d827a7600f
x-ms-traffictypediagnostic: TY2PR01MB4425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB44251C748C04CA5A4F5BF13590610@TY2PR01MB4425.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8AwGQhcbGEF5bsJN+ZcuNN05UzjhNcIUJAPSyiBbmH+VvTDkkDdIlX9vy2s5QdmSMxjosdd0HfuUtH/Jb5vmFLuNWrDCj6SKrdR0tZiZ+b7bM5aJHn9fVEScG+Dm4BFaFfl7yavM8HnJUqjpPQaGrVtR/A6YqXpecSno6lvmJUJZK1EjOeDcteetpZjowxVic8KionoO2dk6hJsjNhxW6jA44t/r9FfV0xbnr7SuR6xkjb07kMtLTIQn9Fx9o+e6E+ot6PO7mx9ZGn8QpdLKdCRcRkfkEwzRPxmJDTliIoC65BWSdthVqMlWQH7wjytvKZFyq6jmHydjn2UEEQnww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2875.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(9686003)(83380400001)(186003)(86362001)(66556008)(66476007)(64756008)(76116006)(66946007)(26005)(66446008)(8676002)(54906003)(71200400001)(316002)(6666004)(478600001)(55016002)(6506007)(33656002)(7696005)(2906002)(6916009)(5660300002)(52536014)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3mgQEe71m9MZ2qC7aEBNbdjl663nw/FLjYWB9ELR1NeSizcQ2aHMPthSagWxYa5NCKH2vGvB709HFp/RZADlpcqQmWQR/6anM1+lXXmQUgvxsVrXaEm4QlQAQ0Zh9YfoQEPKNaCa3z6Eb2PCvofecsPdzv1KPP11l+MuvbOFje7jd03IW49ywKue5l+6Eek+gTGgvB/xRMXs4n/Ko5xIIoblRDiCR0ofJgu9qjrazzdB80EOUYU6LaAm1TFtCxwVD+zzICLoBermGUjbzMtL6RBpSzdTcdR2L0t+9ZbxCA664iUYeBid18NBlX6PRowvfsDBIyuEXTTI8tnQWy/xWJyf/oNTWmuRxMHnKYhhFMKIUuo/AYd/mpqCeKTKWWsej26TeHiRhwn56MgyXx84H8lZsMOd8W27RyiPL5CU6shT/fGeRvuU2/CGT2YBDpIHd+8W4rpN+IVJ17c14LIdlWRy7U5La3nVqY8eaFHGrHg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2875.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7827d877-6a80-4ed3-8a20-08d827a7600f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 03:38:29.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAiAT1+0dZHru98OHd/XcHYjTQ7ARkK3pjUNH/TBy2kUqBo0wcRK34mpzR/rN4O1TDDRM12+cOxmoT/rxOAwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4425
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4NCj4gPiAgCS8qIHZhbGlkaWF0ZSBjYWNoZWQg
ZGVudHJpZXMgKi8NCj4gPiAtCWZvciAoaSA9IDE7IGkgPCBudW1fZW50cmllczsgaSsrKSB7DQo+
ID4gLQkJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQo+ID4gLQkJaWYgKCFl
eGZhdF92YWxpZGF0ZV9lbnRyeShleGZhdF9nZXRfZW50cnlfdHlwZShlcCksICZtb2RlKSkNCj4g
DQo+ID4gKwlmb3IgKGkgPSAxOyBpIDwgZXMtPm51bV9lbnRyaWVzOyBpKyspIHsNCj4gPiArCQlp
ZiAoIWV4ZmF0X2dldF92YWxpZGF0ZWRfZGVudHJ5KGVzLCBpLCBUWVBFX1NFQ09OREFSWSkpDQo+
ID4gIAkJCWdvdG8gZnJlZV9lczsNCj4gPiAgCX0NCj4gPiArCWlmICghZXhmYXRfZ2V0X3ZhbGlk
YXRlZF9kZW50cnkoZXMsIDEsIFRZUEVfU1RSRUFNKSkNCj4gPiArCQlnb3RvIGZyZWVfZXM7DQo+
IA0KPiBJdCBsb29rcyBiZXR0ZXIgdG8gbW92ZSBjaGVja2luZyBUWVBFX1NUUkVBTSBhYm92ZSB0
aGUgZm9yLWxvb3AuDQo+IEFuZCB0aGVuIGZvci1sb29wIHNob3VsZCBzdGFydCBmcm9tIGluZGV4
IDIuDQoNCk9LLiBJJ2xsIGNoYW5nZSB0aGF0LiANCkhvd2V2ZXIsIHRoaXMgZm9yLWxvb3AgaXMg
Y29uc2lkZXJpbmcgY2hhbmdpbmcgdG8gY2hlY2tzdW0gdmVyaWZpY2F0aW9uLg0KDQoNCj4gQlRX
LCBkbyB5b3UgdGhpbmsgaXQgaXMgZW5vdWdoIHRvIGNoZWNrIG9ubHkgVFlQRV9TRUNPTkRBUlkg
bm90IFRZUEUgTkFNRT8NCj4gQXMgeW91IG1pZ2h0IGtub3csIEZJTEUsIFNUUkVBTSBhbmQgTkFN
RSBlbnRyaWVzIG11c3QgYmUgY29uc2VjdXRpdmUgaW4gb3JkZXIuDQoNCkkgdGhpbmsgaXQgaXMg
YXBwcm9wcmlhdGUgYXMgYSBjaGVjayBoZXJlLg0KVFlQRV9OQU1FIHN0YXJ0aW5nIHdpdGhvdXQg
aW5kZXg9MiBkb2Vzbid0IGFjY2VwdCBpbiBleGZhdF9nZXRfdW5pbmFtZV9mcm9tX2V4dF9lbnRy
eSgpLg0KSG93ZXZlciwgSSB0aGluayB0aGlzIGlzIG5vdCBlbm91Z2guDQpUaGlzIGlzIGJlY2F1
c2UgdGhlcmUgaXMgbm8gY2hlY2sgZm9yIG5hbWUtbGVuZ3RoLiAoc2FtZSB3aXRoIG9yIHdpdGhv
dXQgcGF0Y2gpDQoNCkkgd2lsbCBjaGVjayB0aGUgbmFtZS1sZW5ndGggaW4gdGhlIG5leHQob3Ig
YWZ0ZXIgbmV4dCkgcGF0Y2guDQoNCg0KQlINCi0tLQ0KS29oYWRhIFRldHN1aGlybyA8S29oYWRh
LlRldHN1aGlyb0BkYy5NaXRzdWJpc2hpRWxlY3RyaWMuY28uanA+DQo=
