Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06D263F44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgIJIEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:04:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49188 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730077AbgIJIEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:04:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-237-7fX8YZt7N6qAR3EaMh4m2w-1; Thu, 10 Sep 2020 09:04:19 +0100
X-MC-Unique: 7fX8YZt7N6qAR3EaMh4m2w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Sep 2020 09:04:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Sep 2020 09:04:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Topic: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Index: AQHWhvDyD2c/lZfV3kC0Ftay5UVebqlhgjnw
Date:   Thu, 10 Sep 2020 08:04:19 +0000
Message-ID: <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com>
 <20200909184001.GB28786@gate.crashing.org>
 <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
In-Reply-To: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDkgU2VwdGVtYmVyIDIwMjAgMjI6MzQNCj4g
T24gV2VkLCBTZXAgOSwgMjAyMCBhdCAxMTo0MiBBTSBTZWdoZXIgQm9lc3Nlbmtvb2wNCj4gPHNl
Z2hlckBrZXJuZWwuY3Jhc2hpbmcub3JnPiB3cm90ZToNCj4gPg0KPiA+IEl0IHdpbGwgbm90IHdv
cmsgbGlrZSB0aGlzIGluIEdDQywgbm8uICBUaGUgTExWTSBwZW9wbGUga25vdyBhYm91dCB0aGF0
Lg0KPiA+IEkgZG8gbm90IGtub3cgd2h5IHRoZXkgaW5zaXN0IG9uIHB1c2hpbmcgdGhpcywgYmVp
bmcgaW5jb21wYXRpYmxlIGFuZA0KPiA+IGV2ZXJ5dGhpbmcuDQo+IA0KPiBVbW0uIFNpbmNlIHRo
ZXknZCBiZSB0aGUgb25lcyBzdXBwb3J0aW5nIHRoaXMsICpnY2MqIHdvdWxkIGJlIHRoZQ0KPiBp
bmNvbXBhdGlibGUgb25lLCBub3QgY2xhbmcuDQoNCkkgaGFkIGFuICdpbnRlcmVzdGluZycgaWRl
YS4NCg0KQ2FuIHlvdSB1c2UgYSBsb2NhbCBhc20gcmVnaXN0ZXIgdmFyaWFibGUgYXMgYW4gaW5w
dXQgYW5kIG91dHB1dCB0bw0KYW4gJ2FzbSB2b2xhdGlsZSBnb3RvJyBzdGF0ZW1lbnQ/DQoNCldl
bGwgeW91IGNhbiAtIGJ1dCBpcyBpdCBndWFyYW50ZWVkIHRvIHdvcmsgOi0pDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

