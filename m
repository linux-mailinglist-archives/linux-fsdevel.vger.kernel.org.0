Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC29170E4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 03:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgB0CPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 21:15:20 -0500
Received: from mx04.melco.co.jp ([192.218.140.144]:59448 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgB0CPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:15:19 -0500
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id E51273A41E5;
        Thu, 27 Feb 2020 11:15:17 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48Sbq96DmBzRk6K;
        Thu, 27 Feb 2020 11:15:17 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48Sbq95wfczRk2c;
        Thu, 27 Feb 2020 11:15:17 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48Sbq95PNlzRkCy;
        Thu, 27 Feb 2020 11:15:17 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.53])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48Sbq94wK3zRk5y;
        Thu, 27 Feb 2020 11:15:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAmlVIj8Zriv9QKtkuIBLcX2ZQUDVwTFh4rH265Ey9mvCDYl9kdsiFhD+UBgRgwk4PuWBg7Jc+XVo23kRFHBUhTaSX9+tLTjkq9dALShTkjrAWoGF7vlVZsuU040J2pG2mR5V5b+1/Z9bmERk7lT+U79y4lgJiVVAwDcGL05VfNNkRCK0Ah8v73dETYseECKYLiG2NQXBA+H7yC5VbFrofwzhU+LLj7oUnwo0BaYK8Hqa1QSagim+SNRKOGO0ilX6DtIIlnfFdTZL0K7oiftjxkfzNF/9U5UDE0CWV8UrJSmV7Ln/Te47Q/uSGHHJTiLw1aAFIjuzu6WDG6H1uTtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aoM88uGSv7AGtJwV0+vu4r0ByKyMqB2Uq1+fGWzyKs=;
 b=KH6wgsLBSkl8FShkqxPJtfuh+CvKDryFAjDAFnGeNI1ES7aRPc8PSJQPSUNVsbyKOr6sqw6xL59dNYbnwgUxipdOgzBySKVm3n7BOnE9aTmBO1BJ+sqqrKqMN89/YH3DBMTNWEgGKx/N3WL5OqLB406WH0jsuzc9E0ndnjru7B9UBRbKUe9mj29Icoq+hHdxvpq2BgeriHR+ShYPkv3826BwCoSSbwxWJnRTUmdi5FnnghB6qg0CH0x2jjPX5qfmHQJTWHVAvPnBC7EiHUiNsdSeVN6SrhH/ao7EYLUL+my3EAQxhvIMqMVKUdTO7owpGjdlqZabQY9lIvBaXfe5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aoM88uGSv7AGtJwV0+vu4r0ByKyMqB2Uq1+fGWzyKs=;
 b=Po3Vm6z+ZArLB3ofy6ffpYM8bV3au14v1WS6S94Z6f2PgzvyV8T3ZMXVuUpKI/TScLE9JhNbFoAO8BXGnEvmZG4MN/eaaXROi9RXcdVgyejZR9EhYvvmS8Ry4ZEwGkabut+yb/qqjGcEgGL4lD1puav83nZxssKWEso/KZvR0AA=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1723.jpnprd01.prod.outlook.com (52.133.163.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 02:15:16 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1cea:e753:3a3b:8e1b]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::1cea:e753:3a3b:8e1b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 02:15:16 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     =?utf-8?B?J1ZhbGRpcyBLbMSTdG5pZWtzJw==?= <valdis.kletnieks@vt.edu>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: exfat: remove symlink feature : Additional patch
Thread-Topic: [PATCH] staging: exfat: remove symlink feature : Additional
 patch
Thread-Index: AQHV7G9EzJ7fbVbdR0u44Wg1uFjkEKgtEzmAgAE2T4A=
Date:   Thu, 27 Feb 2020 02:14:02 +0000
Deferred-Delivery: Thu, 27 Feb 2020 02:15:01 +0000
Message-ID: <TY1PR01MB1578C8F3D1A9F130C5844C6890EB0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200226063746.3128-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <503049.1582701983@turing-police>
In-Reply-To: <503049.1582701983@turing-police>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68306f99-ee77-4bfd-acbc-08d7bb2ae2f6
x-ms-traffictypediagnostic: TY1PR01MB1723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB1723280B49F8477144B565F990EB0@TY1PR01MB1723.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(86362001)(26005)(186003)(8676002)(4326008)(81156014)(8936002)(6506007)(33656002)(7696005)(81166006)(66946007)(9686003)(52536014)(55016002)(4744005)(66476007)(5660300002)(6916009)(2906002)(71200400001)(54906003)(6666004)(76116006)(66446008)(66556008)(64756008)(316002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1723;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15+Oz4nu8ShxcGMkmeFFwKWVjhUInyY4uuAP7M91h5DnVlJnf93Fxb4F68/0FhbV6b0zpYmDf8W2I3W9d5KePHEou7aGmBCFtJkFOl5ylXL8fjqNIg4VuVj5XCx5ICV5cEyxq8xwqq3to9oX3Qa8ZelE6m9Bt6jJXexd41cfuEZXshayS4Nrroy7W6p/478v9D4fJN6t/hAqK2BZ9gxPKNGY2xI3crDjWCB2jdGYrHqRRTqCHHbEuKPMJeyKTMdXqWiJ9CkJPB+NTJqISH4kHvpJp/3DTuWQi60KEOq66Fa9BxDDetbZwM2sIvf/qaDTeUVdcwZIlCmXXx/ZJv4uXT43/WMI2briV0GJikA5uRd9HSNXoWHrMYMalKyHknOsu6qJId1K7zDsZfZwKG9rtcUVL/w281LU/nVuTLg5NNkv6jT4TMQvfrJwpR5fIeL+
x-ms-exchange-antispam-messagedata: 60a9uVU/M8C5ILxlXD6XOz6BVvo8XaRGNGYr2WYf2nZ/nOx/dsImuQoddlGb5FyLNdixG2fkZuoKut9Wp+yHBQOlWGC1EAEJqwsTAER+Jz4mSmwDE8F4K715P/XZIxzmipzFILiBGwX4cB/8AcryqA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68306f99-ee77-4bfd-acbc-08d7bb2ae2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 02:15:16.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2bOpwIZ+jhO3FK54tgjuo4pm8fSb6ZGQdcY+Bnc/j+EbUpQczUBAsVeofthC1bJ5Io0DrCd72PEdvMwauF3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1723
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIGZvciBjb21tZW50Lg0KDQo+IFRoZW4gdGhpcyBzaG91bGQgaGF2ZSBiZWVuIFtQQVRD
SCB2Ml0sIGFuZCB0aGUgZml4ZWQgdmVyc2lvbiBbUEFUQ0ggDQo+IHYzXQ0KDQoybmQgcGF0Y2go
QWRkaXRpb25hbCBwYXRjaCkgbm90IGluY2x1ZGUgMXN0IHBhdGNoKFJGQyBQQVRDSCkuDQpBbmQg
dGhlIDFzdCBwYXRjaCBoYXMgYmVlbiBtZXJnZWQgaW50byAnc3RhZ2luZy1uZXh0Jy4NCk5vdyBJ
IGNhbid0IGRlY2lkZS4NCmEpIEFkZCBvbmx5IHZlcnNpb24gaW5mb3JtYXRpb24gdG8gdGhlIDJu
ZCBwYXRjaC4NCmIpIE1lcmdlIHRoZSAxc3QgYW5kIDJuZCBwYXRjaGVzLg0KDQpXaGljaCBpcyBi
ZXR0ZXIgZm9yIHYzPw0KDQotLQ0KS29oYWRhIFRldHN1aGlybyA8S29oYWRhLlRldHN1aGlyb0Bk
Yy5NaXRzdWJpc2hpRWxlY3RyaWMuY28uanA+DQo=
