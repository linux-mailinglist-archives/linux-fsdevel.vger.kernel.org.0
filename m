Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5D1A6547
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgDMIQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 04:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgDMIQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:16:19 -0400
Received: from mx06.melco.co.jp (mx06.melco.co.jp [192.218.140.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42EC00860B;
        Mon, 13 Apr 2020 01:16:19 -0700 (PDT)
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 13D123A4140;
        Mon, 13 Apr 2020 17:16:17 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 4911fS74ZwzRjMR;
        Mon, 13 Apr 2020 17:16:16 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 4911fS6mF5zRjKP;
        Mon, 13 Apr 2020 17:16:16 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4911fS6cfYzRkCv;
        Mon, 13 Apr 2020 17:16:16 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.59])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4911fS69rczRk8h;
        Mon, 13 Apr 2020 17:16:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASqxjPJVFccHAldcb1dJBhtOd2Pg7icaSMNpu7v0sSVptiHa29ofTeye+Nvu3iP2hwnhyyasWUxardjPbqQ1WEwBUvdAQnllzhf+2tzwPG0TKTJ/y+9yMIxuggKil7dRfz1mgaTnHrWbXS2FlUPI5UqiHS0DyJgKkOFr6m+hdiKFy4Wa2N/o0IbcAtC+NZNo0IkBaQwYP88F1ukFEEXsSXseNlRsmuCCoQJkDbRM2HAcM14WvawEAvEQ4uyVTAiZpZtSsfWMJmQjAvb1w7oUtk0V70RwVjaSI3Dxw9T/Q44MlLLxmN3c9NkGwn8pqMzwCb9WPFSquDnDsWT5WXlDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zht/yYmsPAY4Xs5tzCVoLHlW9PaYN10OQpTtmgxjyUQ=;
 b=XYrcdev1n6bemJy+5JxLkVYx5bO7Cal36XQPoH7pvvNTno70CpKvqOygkDRxl4OfPH08M23WA89WXMP5iJB43oIujP7LVVXwKP8Qzh6Ns9DrzW/0wlehiZRXN6R4E/EPrfyaMZGYV1JuQRrGU8isEmv46o0WanvjhjoTXT2ituQ5sde7vHl3cPNy9SOBZB5qUpbXm+58HoKx8ikCdHGFpwErsR6KGjR+A/WwsyxLuZ5PHG31gNJmatf45MuRSA3LY/Jw+XCLwsQ3oV0friDyMXR4RZVbFBpNiCqi+7UGOZ1G+g2+oVpDFKesNk3+NRTGcGgtxugxlgY4wWGP6f8dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zht/yYmsPAY4Xs5tzCVoLHlW9PaYN10OQpTtmgxjyUQ=;
 b=Gza5qcbvMIbRmfVMhr0j7N0aKVIfcWlrPikAi/D8LmkxVR+YxSsvgJmhlIWrk7n6zQc09ZeTmfYv7dpKq9ipZ3HvlK8ktgmUSeEN9eV05LbRGwkU96OXoW1tAu70AB2SXv9zxCvV2jnrxiAWjQZsdDNIKVShyb5+v2S57rjhPkA=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1849.jpnprd01.prod.outlook.com (52.133.161.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Mon, 13 Apr 2020 08:16:16 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2878.022; Mon, 13 Apr 2020
 08:16:16 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>
Subject: RE: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Topic: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Index: AQHWCfgm33iC4HYp6U6hpobeaScABqhrVdFggAIevgCAARtD4IAAZbCAgAd0CHA=
Date:   Mon, 13 Apr 2020 08:13:45 +0000
Deferred-Delivery: Mon, 13 Apr 2020 08:16:00 +0000
Message-ID: <TY1PR01MB15784063EED4CEC93A2B501390DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
 <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200408090435.i3ufmbfinx5dyd7w@pali>
In-Reply-To: <20200408090435.i3ufmbfinx5dyd7w@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc98d28-5756-4de2-7ea6-08d7df82f021
x-ms-traffictypediagnostic: TY1PR01MB1849:
x-microsoft-antispam-prvs: <TY1PR01MB18499D4D2E3EF81220D93BAB90DD0@TY1PR01MB1849.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(136003)(5660300002)(33656002)(2906002)(26005)(478600001)(186003)(8676002)(66556008)(66446008)(52536014)(9686003)(55016002)(54906003)(4326008)(110136005)(66946007)(8936002)(76116006)(64756008)(66476007)(6506007)(86362001)(7696005)(71200400001)(81156014)(316002)(6666004);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esXop6033GcWd0Kpz+HDbMRC1IaQZFRCARSR6x0uvupPsV4qNGh4QTCsaoVvQppRjn8gpIrWMQD3wbhF5gk5BlS+WWJoIH+O+BA9m3+r1hPIoSo8qIdIAtrzWNSVOQb/Vq/HzQO8DYvFa5M0iNvQXoaqg/7XC2E7Lf1DNVspSH+nq3CM3aOChaxEFunJ3xPdE7ewqlKjldo9jHAcjM7nDnISn3fvCzfpmIYJQLNvEOJdp9+4sFdl6aSrbZPnfM6NEI8cjywBUh2gy2iTqlgbwEMDf8igbnqS5ZjyW6HCO0ik0IUpmuu6dqX1yrmIdQi8Y7zParrbJNfWtJK9ZFQaUKG4oueA4zDy6wG3CZMSeQqO1ep82PvNAPQQrzC6VhBZFQjB6CWhFhQL+e0ZOQu90JFBVBMFbJpRYmolMecsqceYdX8bkLGg5iZ26kObVCN0
x-ms-exchange-antispam-messagedata: Rn3n6uSWga6aRdXuvl4JPX7PecqKpqzviOt7xHxpTfsbKL9qveA/2sFUrr1aCnL5CvrvCj26LqybTXFfZ7NXD0jSrbOAXae084uB4CLNA2j/fgx/NkEgjt7brrTi3In8I1HaOVyBZu7PdSXQTeQOUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: adc98d28-5756-4de2-7ea6-08d7df82f021
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 08:16:16.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYg9gSuQL5/Mge3Expwkq1/YoMU2SAMQ0VgXRSjY8A8+aFLTlE6JjOJh9z0i7XW354MhLji7zatxVNsncUPbjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1849
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBXZWRuZXNkYXkgMDggQXByaWwgMjAyMCAwMzo1OTowNiBLb2hhZGEuVGV0c3VoaXJvQGRj
Lk1pdHN1YmlzaGlFbGVjdHJpYy5jby5qcCB3cm90ZToNCj4gPiA+IFNvIHBhcnRpYWxfbmFtZV9o
YXNoKCkgbGlrZSBJIHVzZWQgaXQgaW4gdGhpcyBwYXRjaCBzZXJpZXMgaXMgZW5vdWdoPw0KPiA+
DQo+ID4gSSB0aGluayBwYXJ0aWFsX25hbWVfaGFzaCgpIGlzIGVub3VnaCBmb3IgOC8xNi8yMWJp
dCBjaGFyYWN0ZXJzLg0KPiANCj4gR3JlYXQhDQo+IA0KPiBBbCwgY291bGQgeW91IHBsZWFzZSB0
YWtlIHRoaXMgcGF0Y2ggc2VyaWVzPw0KDQpJIHRoaW5rIGl0J3MgZ29vZC4NCg0KDQo+ID4gQW5v
dGhlciBwb2ludCBhYm91dCB0aGUgZGlzY3JpbWluYXRpb24gb2YgMjFiaXQgY2hhcmFjdGVyczoN
Cj4gPiBJIHRoaW5rIHRoYXQgY2hlY2tpbmcgaW4gZXhmYXRfdG91cHBlciAoKSBjYW4gYmUgbW9y
ZSBzaW1wbGlmaWVkLg0KPiA+DQo+ID4gIGV4OiByZXR1cm4gYSA8IFBMQU5FX1NJWkUgJiYgc2Jp
LT52b2xfdXRibFthXSA/IHNiaS0+dm9sX3V0YmxbYV0gOiBhOw0KPiANCj4gSSB3YXMgdGhpbmtp
bmcgYWJvdXQgaXQsIGJ1dCBpdCBuZWVkcyBtb3JlIHJlZmFjdG9yaW5nLiBDdXJyZW50bHkNCj4g
ZXhmYXRfdG91cHBlcigpIGlzIHVzZWQgb24gb3RoZXIgcGxhY2VzIGZvciBVVEYtMTYgKHUxNiBh
cnJheSkgYW5kIHRoZXJlZm9yZSBpdCBjYW5ub3QgYmUgZXh0ZW5kZWQgdG8gdGFrZSBtb3JlIHRo
ZW4gMTYNCj4gYml0IHZhbHVlLg0KDQpJ4oCZbSBhbHNvIGEgbGl0dGxlIHdvcnJpZWQgdGhhdCBl
eGZhdF90b3VwcGVyKCkgaXMgZGVzaWduZWQgZm9yIG9ubHkgdXRmMTYuDQpDdXJyZW50bHksIGl0
IGlzIGNvbnZlcnRpbmcgZnJvbSB1dGY4IHRvIHV0ZjMyIGluIHNvbWUgcGxhY2VzLCBhbmQgZnJv
bSB1dGY4IHRvIHV0ZjE2IGluIG90aGVycy4NCkFub3RoZXIgd2F5IHdvdWxkIGJlIHRvIHVuaWZ5
IHRvIHV0ZjE2Lg0KDQo+IEJ1dCBJIGFncmVlIHRoYXQgdGhpcyBpcyBhbm90aGVyIHN0ZXAgd2hp
Y2ggY2FuIGJlIGltcHJvdmVkLg0KDQpZZXMuDQoNCg==
