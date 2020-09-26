Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E96279997
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgIZNRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 09:17:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35182 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIZNRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 09:17:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-180-5VJINhz9NTSAtIoj2E6Mig-1; Sat, 26 Sep 2020 14:17:05 +0100
X-MC-Unique: 5VJINhz9NTSAtIoj2E6Mig-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 26 Sep 2020 14:17:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 26 Sep 2020 14:17:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'syzbot' <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: WARNING in __kernel_read (2)
Thread-Topic: WARNING in __kernel_read (2)
Thread-Index: AQHWk7DmAtv55MEfq0C+fzgffzQfPql6xRLQgAAhQ/A=
Date:   Sat, 26 Sep 2020 13:17:04 +0000
Message-ID: <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com>
References: <000000000000da992305b02e9a51@google.com>
 <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com>
In-Reply-To: <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDI2IFNlcHRlbWJlciAyMDIwIDEyOjE2DQo+IFRv
OiAnc3l6Ym90JyA8c3l6Ym90KzUxMTc3ZTQxNDRkNzY0ODI3YzQ1QHN5emthbGxlci5hcHBzcG90
bWFpbC5jb20+OyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbTsgdmlyb0B6
ZW5pdi5saW51eC5vcmcudWsNCj4gU3ViamVjdDogUkU6IFdBUk5JTkcgaW4gX19rZXJuZWxfcmVh
ZCAoMikNCj4gDQo+ID4gRnJvbTogc3l6Ym90IDxzeXpib3QrNTExNzdlNDE0NGQ3NjQ4MjdjNDVA
c3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4NCj4gPiBTZW50OiAyNiBTZXB0ZW1iZXIgMjAyMCAw
Mzo1OA0KPiA+IFRvOiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbTsNCj4gPiB2
aXJvQHplbml2LmxpbnV4Lm9yZy51aw0KPiA+IFN1YmplY3Q6IFdBUk5JTkcgaW4gX19rZXJuZWxf
cmVhZCAoMikNCj4gDQo+IEkgc3VzcGVjdCB0aGlzIGlzIGNhbGxpbmcgZmluaXRfbW9kdWxlKCkg
b24gYW4gZmQNCj4gdGhhdCBkb2Vzbid0IGhhdmUgcmVhZCBwZXJtaXNzaW9ucy4NCg0KQ29kZSBp
bnNwZWN0aW9uIGFsc28gc2VlbXMgdG8gaW1wbHkgdGhhdCB0aGUgY2hlY2sgbWVhbnMNCnRoZSBl
eGVjKCkgYWxzbyByZXF1aXJlcyByZWFkIHBlcm1pc3Npb25zIG9uIHRoZSBmaWxlLg0KDQpUaGlz
IGlzbid0IHRyYWRpdGlvbmFsbHkgdHJ1ZS4NCnN1aWQgIyEgc2NyaXB0cyBhcmUgcGFydGljdWxh
cmx5IG9kZCB3aXRob3V0ICdvd25lciByZWFkJw0KKGV2ZXJ5b25lIGV4Y2VwdCB0aGUgb3duZXIg
Y2FuIHJ1biB0aGVtISkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

