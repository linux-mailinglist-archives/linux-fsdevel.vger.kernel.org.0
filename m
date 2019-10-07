Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9DCE7F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfJGPk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 11:40:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:54342 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbfJGPkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:40:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-223-2sMXyru-MEeYMtfSCrrM3w-1; Mon, 07 Oct 2019 16:40:21 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Oct 2019 16:40:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Oct 2019 16:40:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Thread-Topic: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Thread-Index: AQHVfL0BUpJ/upywWEKRtOjvaDvCEKdPT9ew
Date:   Mon, 7 Oct 2019 15:40:21 +0000
Message-ID: <c58c2a8a5366409abd4169d10a58196a@AcuMS.aculab.com>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
In-Reply-To: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 2sMXyru-MEeYMtfSCrrM3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBMaW51cyBUb3J2YWxkcw0KPiBTZW50OiAwNyBPY3RvYmVyIDIwMTkgMDQ6MTINCi4u
Lg0KPiBJbiB0aGlzIGNhc2UsIEkgdGhpbmsgaXQncyBkb25lIGEgZmV3IGNhbGxlcnMgdXAgaW4g
aTkxNV9nZW1fcHJlYWRfaW9jdGwoKToNCj4gDQo+ICAgICAgICAgaWYgKCFhY2Nlc3Nfb2sodTY0
X3RvX3VzZXJfcHRyKGFyZ3MtPmRhdGFfcHRyKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICBh
cmdzLT5zaXplKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiANCj4gYnV0
IGhvbmVzdGx5LCB0cnlpbmcgdG8gb3B0aW1pemUgYXdheSBhbm90aGVyICJhY2Nlc3Nfb2soKSIg
aXMganVzdA0KPiBub3Qgd29ydGggaXQuIEknZCByYXRoZXIgaGF2ZSBhbiBleHRyYSBvbmUgdGhh
biBtaXNzIG9uZS4NCg0KWW91IGRvbid0IHJlYWxseSB3YW50IGFuIGV4dHJhIGFjY2Vzc19vaygp
IGZvciBldmVyeSAnd29yZCcgb2YgYSBjb3B5Lg0KU29tZSBjb3BpZXMgaGF2ZSB0byBiZSBkb25l
IGEgd29yZCBhdCBhIHRpbWUuDQoNCkFuZCB0aGUgY2hlY2tzIHNvbWVvbmUgYWRkZWQgdG8gY29w
eV90by9mcm9tX3VzZXIoKSB0byBkZXRlY3Qga2VybmVsDQpidWZmZXIgb3ZlcnJ1bnMgbXVzdCBr
aWxsIHBlcmZvcm1hbmNlIHdoZW4gdGhlIGJ1ZmZlcnMgYXJlIHdheSBkb3duIHRoZSBzdGFjaw0K
b3IgaW4ga21hbGxvYygpZWQgc3BhY2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

