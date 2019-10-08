Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF127CF6A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 12:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfJHJ62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 05:58:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20879 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730442AbfJHJ61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:58:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-21-VWCztQ1aNFyz46d4CGNx0w-1; Tue, 08 Oct 2019 10:58:24 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 8 Oct 2019 10:58:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 8 Oct 2019 10:58:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Thread-Topic: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Thread-Index: AQHVfL0BUpJ/upywWEKRtOjvaDvCEKdPT9ewgAAbG4CAAQw74A==
Date:   Tue, 8 Oct 2019 09:58:24 +0000
Message-ID: <18992f7f25b44f2898812ffc203c4b35@AcuMS.aculab.com>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <c58c2a8a5366409abd4169d10a58196a@AcuMS.aculab.com>
 <CAHk-=wjF2fkhuN8N-MnTwvzNig83XdQK50nir8oieF7jV6Om=A@mail.gmail.com>
In-Reply-To: <CAHk-=wjF2fkhuN8N-MnTwvzNig83XdQK50nir8oieF7jV6Om=A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VWCztQ1aNFyz46d4CGNx0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBT
ZW50OiAwNyBPY3RvYmVyIDIwMTkgMTk6MTENCi4uLg0KPiBJJ3ZlIGJlZW4gdmVyeSBjbG9zZSB0
byBqdXN0IHJlbW92aW5nIF9fZ2V0X3VzZXIvX19wdXRfdXNlciBzZXZlcmFsDQo+IHRpbWVzLCBl
eGFjdGx5IGJlY2F1c2UgcGVvcGxlIGRvIGNvbXBsZXRlbHkgdGhlIHdyb25nIHRoaW5nIHdpdGgg
dGhlbQ0KPiAtIG5vdCBzcGVlZGluZyBjb2RlIHVwLCBidXQgbWFraW5nIGl0IHVuc2FmZSBhbmQg
YnVnZ3kuDQoNClRoZXkgY291bGQgZG8gdGhlIHZlcnkgc2ltcGxlIGNoZWNrIHRoYXQgJ3VzZXJf
cHRyK3NpemUgPCBrZXJuZWxfYmFzZScNCnJhdGhlciB0aGFuIHRoZSBmdWxsIHdpbmRvdyBjaGVj
ayB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IGFjY2Vzc19vaygpDQpoYXMgYmVlbiBjYWxsZWQg
YW5kIHRoYXQgdGhlIGxpa2VseSBlcnJvcnMgYXJlIGp1c3Qgb3ZlcnJ1bnMuDQoNCj4gVGhlIG5l
dyAidXNlcl9hY2Nlc3NfYmVnaW4vZW5kKCkiIG1vZGVsIGlzIG11Y2ggYmV0dGVyLCBidXQgaXQg
YWxzbw0KPiBoYXMgYWN0dWFsIFNUQVRJQyBjaGVja2luZyB0aGF0IHRoZXJlIGFyZSBubyBmdW5j
dGlvbiBjYWxscyBldGMgaW5zaWRlDQo+IHRoZSByZWdpb24sIHNvIGl0IGZvcmNlcyB5b3UgdG8g
ZG8gdGhlIGxvb3AgcHJvcGVybHkgYW5kIHRpZ2h0bHksIGFuZA0KPiBub3QgdGhlIGluY29ycmVj
dCAiSSBjaGVja2VkIHRoZSByYW5nZSBzb21ld2hlcmUgZWxzZSwgbm93IEknbSBkb2luZw0KPiBh
biB1bnNhZmUgY29weSIuDQo+IA0KPiBBbmQgaXQgYWN0dWFsbHkgc3BlZWRzIHRoaW5ncyB1cCwg
dW5saWtlIHRoZSBhY2Nlc3Nfb2soKSBnYW1lcy4NCg0KSSd2ZSBjb2RlIHRoYXQgZG9lczoNCglp
ZiAoIWFjY2Vzc19vayguLi4pKQ0KCQlyZXR1cm4gLUVGQVVMVDsNCgkuLi4NCglmb3IgKC4uLikg
ew0KCQlpZiAoX19nZXRfdXNlcih0bXBfdTY0LCB1c2VyX3B0cisrKSkNCgkJCXJldHVybiAtRUZB
VUxUOw0KCQl3cml0ZXEodG1wX3U2NCwgaW9fcHRyKyspOw0KCX0NCihBbHRob3VnaCB0aGUgY29k
ZSBpcyBtb3JlIGNvbXBsZXggYmVjYXVzZSBub3QgYWxsIHRyYW5zZmVycyBhcmUgbXVsdGlwbGVz
IG9mIDggYnl0ZXMuKQ0KDQpXaXRoIHVzZXJfYWNjZXNzX2JlZ2luL2VuZCgpIEknZCBwcm9iYWJs
eSB3YW50IHRvIHB1dCB0aGUgY29weSBsb29wDQppbnNpZGUgYSBmdW5jdGlvbiAod2hpY2ggd2ls
bCBwcm9iYWJseSBnZXQgaW5saW5lZCkgdG8gYXZvaWQgY29udm9sdXRlZA0KZXJyb3IgcHJvY2Vz
c2luZy4NClNvIHlvdSBlbmQgdXAgd2l0aDoNCglpZiAoIXVzZXJfYWNjZXNzX29rKCkpDQoJCXJl
dHVybiBfRUZBVUxUOw0KCXVzZXJfYWNjZXNzX2JlZ2luKCk7DQoJcnZhbCA9IGRvX2NvcHlfY29k
ZSguLi4pOw0KCXVzZXJfYWNjZXNzX2VuZCgpOw0KCXJldHVybiBydmFsOw0KV2hpY2gsIGF0IHRo
ZSBzb3VyY2UgbGV2ZWwgKGF0IGxlYXN0KSBicmVha3MgeW91ciAnbm8gZnVuY3Rpb24gY2FsbHMn
IHJ1bGUuDQpUaGUgd3JpdGVxKCkgbWlnaHQgYWxzbyBicmVhayBpdCBhcyB3ZWxsLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

