Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8819F2C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgDFJkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 05:40:04 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:43437 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgDFJkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:40:04 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 113243A459E;
        Mon,  6 Apr 2020 18:40:03 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 48wlrL6tbBzRkCH;
        Mon,  6 Apr 2020 18:40:02 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr06.melco.co.jp (Postfix) with ESMTP id 48wlrL6ZcgzRjLr;
        Mon,  6 Apr 2020 18:40:02 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48wlrL6kcTzRjK8;
        Mon,  6 Apr 2020 18:40:02 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.59])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48wlrL6YcbzRjN9;
        Mon,  6 Apr 2020 18:40:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwgZUZcpHNcLEb5LiIBveEJcD//eMr+143HzKseSwULbNV3/b8abW+ilB2g8UAeR/xaMLd3X6b3g6UH48tH58a8stTxUusjwyAmVBpCCoJGKiGBzkknaPX/bunUoMK10Q2JV9ChpklufZ+2YFoz3zru6QnHPR/7JO6hKo1eYgCEXgwTNt/h+lsm1BoUlE/u3BYx58Hxw2JMvtN6aGFQYvIm3FAOZ5JtvTovsKgMRvkWTLAr+ox+FZrXl78TgtcAQ9ByfMjyyAxXQfDB+s8IxYc8hZj/s8mc0a3vfa58sZRV5u1YKgU8FhSQuun+tr6lj5MWBJI4avtPgyqwbnvvIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeGtULxZk6Wk4EraseR3WS16P4iDDzXWV7Tk5pSetDk=;
 b=ogA7+osCmmXEvTYXb4TZnBzSXfpxZMcxpL+CwsE/Euf6ORUcVyaULkJLaKznHgK9xhADT9wQGKIimZHs0qQj/HvGsevkQQYZh5Y+rJ5eIT9WRuZ9xO3i7XhlFr1W4oth9kM3cXx1OSHreZsauWC9NpYgpWfPB1YYysyTdJVteaOYJZVaOaEjKb/SVu+QDehZbDswhJVev0WbcNFBCuW1pY3R7X8LPVkB4CuQ43qTeRsW2e6haBtnD7mC/3T7Yfdl2fFBbJ2c73LI4gbxk5H+QqWNvH3maiympq93xAAIqQaAdanhOsrPEA7OAnq4UBrpqGVbt8eSA21niWV6dZzzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeGtULxZk6Wk4EraseR3WS16P4iDDzXWV7Tk5pSetDk=;
 b=pubkCScc7vwQno0Z8uWEqDBGXlgIvExVJaIm79uPjo8u/q07YjV6RkkQ9Kw7zriCk27qZo19JB7ELIBin6LTNguM/bucVmQB8XbMxDRzSk0xysackzxQBew2/Y7OyV3Tjj4h+Dci1jGNEe7K98Mx6U6hq4Hnj0rh2cUTxodmPDU=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1611.jpnprd01.prod.outlook.com (52.133.164.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 6 Apr 2020 09:40:02 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2856.027; Mon, 6 Apr 2020
 09:40:02 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>
CC:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "'viro@zeniv.linux.org.uk'" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Topic: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Index: AQHWCfgm33iC4HYp6U6hpobeaScABqhrVdFg
Date:   Mon, 6 Apr 2020 09:37:38 +0000
Deferred-Delivery: Mon, 6 Apr 2020 09:40:00 +0000
Message-ID: <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
In-Reply-To: <20200403204037.hs4ae6cl3osogrso@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78801c05-e509-46e9-44f1-08d7da0e7ad7
x-ms-traffictypediagnostic: TY1PR01MB1611:
x-microsoft-antispam-prvs: <TY1PR01MB16111B5C2FBCDC1F0F4F4A3990C20@TY1PR01MB1611.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(66946007)(64756008)(6666004)(71200400001)(186003)(55016002)(4326008)(8676002)(54906003)(9686003)(6506007)(2906002)(26005)(7696005)(5660300002)(316002)(52536014)(478600001)(81156014)(66446008)(66556008)(66476007)(8936002)(86362001)(81166006)(33656002)(6916009);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGgNHR6//UhH0b1SUfg633dKeeXJiLQlHkNTP6UUVafJHY/CZVRPoUJuFEkaQxpzvj0S1GUpR69WTGczHWDeuETs1ZBD6QNU/dvdbu3pI1HkbkSjCRbS4iyz0a7/epv1Hh23WM8ahzrb/u4cSPbpIFQEjEu7PjPf0CXmbaM7aYv52RX/qee+JPaE1WdZzb/EG8oAt1eCSHbmTfrufneYj9zcaI2DlqYTLxKU+2BTfVL5lwRr42jv7g3Tz3mxgWLU+SYjLus/XKXD22rmj3HSgCa+wjLvRowceDup3RNJCLzio3GZmWweVpDYg4i3xqYzYsTS3rjLLFqHMsQQSxRWWWFnnzETvX8ZGO5GPaRJnmjpXXZDKo1Av4hCJHEH9rqqAtDcwMIUGlTTtx8v8qQc0Uylr3SU02vzdqJ0IeokYyrfppPTqss828wC2ggkKAv2
x-ms-exchange-antispam-messagedata: hCkFxiExkx93QIhWE3ckAHHhwj4QdL6KhOnsHk0Y0i/0Yxm4lTLQl2ZY1IEb0zunfMxQP6ELLjQYSRn5G4Ej1Go7ES1jrrHQpZTkoDNCGDShvmonkaRYBmkZjkw4EaLQQA9FHTUZm++x9ptKluKFBg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78801c05-e509-46e9-44f1-08d7da0e7ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 09:40:02.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ihMSzd/e5DJzpOLThKS80MdV/Kwn3j1jgpI6bZWBnhc1YQ1yGczc1wtRi1C6iveDe2l2MwbJkq9Js8VQNnWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1611
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IElmIHlvdSB3YW50IHRvIGdldCBhbiB1bmJpYXNlZCBoYXNoIHZhbHVlIGJ5IHNwZWNpZnlp
bmcgYW4gOCBvciAxNi1iaXQNCj4gPiB2YWx1ZSwNCj4gDQo+IEhlbGxvISBJbiBleGZhdCB3ZSBo
YXZlIHNlcXVlbmNlIG9mIDIxLWJpdCB2YWx1ZXMgKG5vdCA4LCBub3QgMTYpLg0KDQpoYXNoXzMy
KCkgZ2VuZXJhdGVzIGEgbGVzcy1iaWFzZWQgaGFzaCwgZXZlbiBmb3IgMjEtYml0IGNoYXJhY3Rl
cnMuDQoNClRoZSBoYXNoIG9mIHBhcnRpYWxfbmFtZV9oYXNoKCkgZm9yIHRoZSBmaWxlbmFtZSB3
aXRoIHRoZSBmb2xsb3dpbmcgY2hhcmFjdGVyIGlzIC4uLg0KIC0gMjEtYml0KHN1cnJvZ2F0ZSBw
YWlyKTogdGhlIHVwcGVyIDMtYml0cyBvZiBoYXNoIHRlbmQgdG8gYmUgMC4NCiAtIDE2LWJpdCht
b3N0bHkgQ0pLVik6IHRoZSB1cHBlciA4LWJpdHMgb2YgaGFzaCB0ZW5kIHRvIGJlIDAuDQogLSA4
LWJpdChtb3N0bHkgbGF0aW4pOiB0aGUgdXBwZXIgMTYtYml0cyBvZiBoYXNoIHRlbmQgdG8gYmUg
MC4NCg0KSSB0aGluayB0aGUgbW9yZSBmcmVxdWVudGx5IHVzZWQgbGF0aW4vQ0pLViBjaGFyYWN0
ZXJzIGFyZSBtb3JlIGltcG9ydGFudA0Kd2hlbiBjb25zaWRlcmluZyB0aGUgaGFzaCBlZmZpY2ll
bmN5IG9mIHN1cnJvZ2F0ZSBwYWlyIGNoYXJhY3RlcnMuDQoNClRoZSBoYXNoIG9mIHBhcnRpYWxf
bmFtZV9oYXNoKCkgZm9yIDgvMTYtYml0IGNoYXJhY3RlcnMgaXMgYWxzbyBiaWFzZWQuDQpIb3dl
dmVyLCBpdCB3b3JrcyB3ZWxsLg0KDQpTdXJyb2dhdGUgcGFpciBjaGFyYWN0ZXJzIGFyZSB1c2Vk
IGxlc3MgZnJlcXVlbnRseSwgYW5kIHRoZSBoYXNoIG9mIA0KcGFydGlhbF9uYW1lX2hhc2goKSBo
YXMgbGVzcyBiaWFzIHRoYW4gZm9yIDgvMTYgYml0IGNoYXJhY3RlcnMuDQoNClNvIEkgdGhpbmsg
dGhlcmUgaXMgbm8gcHJvYmxlbSB3aXRoIHlvdXIgcGF0Y2guDQoNCg0KPiBEaWQgeW91IG1lYW4g
aGFzaF8zMigpIGZ1bmN0aW9uIGZyb20gbGludXgvaGFzaC5oPw0KDQpPb3BzLiBJIGZvcmdvdCAn
XycuDQpoYXNoXzMyKCkgaXMgY29ycmVjdC4NCg0KDQotLS0NCktvaGFkYSBUZXRzdWhpcm8gPEtv
aGFkYS5UZXRzdWhpcm9AZGMuTWl0c3ViaXNoaUVsZWN0cmljLmNvLmpwPg0K
