Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751ED25D318
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 09:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgIDH7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:59:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58777 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgIDH7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:59:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-u9TZWDNaNCSHyguiU6M2MQ-1; Fri, 04 Sep 2020 08:59:13 +0100
X-MC-Unique: u9TZWDNaNCSHyguiU6M2MQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 4 Sep 2020 08:59:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 4 Sep 2020 08:59:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 12/14] x86: remove address space overrides using set_fs()
Thread-Topic: [PATCH 12/14] x86: remove address space overrides using set_fs()
Thread-Index: AQHWggEOyEQXa7QqyE6TJTq6U2S8aalXbNZggAARhwCAAJziAA==
Date:   Fri, 4 Sep 2020 07:59:12 +0000
Message-ID: <4ec56728ace54dd081f02a6c0f32f781@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-13-hch@lst.de>
 <9ab40244a2164f7db2ff0c1d23ab59a0@AcuMS.aculab.com>
 <CAHk-=whDtnudkbZ8-hR8HiDE7zog0dv+Gu9Sx5i6SPakrDtajQ@mail.gmail.com>
In-Reply-To: <CAHk-=whDtnudkbZ8-hR8HiDE7zog0dv+Gu9Sx5i6SPakrDtajQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDQgU2VwdGVtYmVyIDIwMjAgMDA6MjYNCj4g
DQo+IE9uIFRodSwgU2VwIDMsIDIwMjAgYXQgMjozMCBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEEgbm9uLWNhbm9uaWNhbCAoaXMgdGhh
dCB0aGUgcmlnaHQgdGVybSkgYWRkcmVzcyBiZXR3ZWVuIHRoZSBoaWdoZXN0DQo+ID4gdmFsaWQg
dXNlciBhZGRyZXNzIGFuZCB0aGUgbG93ZXN0IHZhbGlkIGtlcm5lbCBhZGRyZXNzICg3ZmZlIHRv
IGZmZmU/KQ0KPiA+IHdpbGwgZmF1bHQgYW55d2F5Lg0KPiANCj4gWWVzLg0KPiANCj4gQnV0IHdl
IGFjdHVhbGx5IHdhcm4gYWdhaW5zdCB0aGF0IGZhdWx0LCBiZWNhdXNlIGl0J3MgYmVlbiBhIGdv
b2Qgd2F5DQo+IHRvIGNhdGNoIHBsYWNlcyB0aGF0IGRpZG4ndCB1c2UgdGhlIHByb3BlciAiYWNj
ZXNzX29rKCkiIHBhdHRlcm4uDQo+IA0KPiBTZWUgZXhfaGFuZGxlcl91YWNjZXNzKCkgYW5kIHRo
ZQ0KPiANCj4gICAgICAgICBXQVJOX09OQ0UodHJhcG5yID09IFg4Nl9UUkFQX0dQLCAiR2VuZXJh
bCBwcm90ZWN0aW9uIGZhdWx0IGluDQo+IHVzZXIgYWNjZXNzLiBOb24tY2Fub25pY2FsIGFkZHJl
c3M/Iik7DQo+IA0KPiB3YXJuaW5nLiBJdCdzIGJlZW4gZ29vZCBmb3IgcmFuZG9taXplZCB0ZXN0
aW5nIC0gYSBtaXNzaW5nIHJhbmdlIGNoZWNrDQo+IG9uIGEgdXNlciBhZGRyZXNzIHdpbGwgb2Z0
ZW4gaGl0IHRoaXMuDQo+IA0KPiBPZiBjb3Vyc2UsIHlvdSBzaG91bGQgbmV2ZXIgc2VlIGl0IGlu
IHJlYWwgbGlmZSAoYW5kIGhvcGVmdWxseSBub3QgaW4NCj4gdGVzdGluZyBlaXRoZXIgYW55IG1v
cmUpLiBCdXQgYmVsdC1hbmQtc3VzcGVuZGVycy4uDQoNClRoYXQgY291bGQgc3RpbGwgYmUgZWZm
ZWN0aXZlLCBqdXN0IHBpY2sgYW4gYWRkcmVzcyBsaW1pdCB0aGF0IGlzDQphcHByb3ByaWF0ZSBm
b3IgdGhlIG9uZSBhY2Nlc3Nfb2soKSBpcyB1c2luZy4NCg0KRXZlbiBpZiBhY2Nlc3Nfb2soKSB1
c2VzIDE8PDYzIHRoZXJlIGFyZSBwbGVudHkgb2YgYWRkcmVzc2VzIGFib3ZlIGl0IHRoYXQgZmF1
bHQuDQpCdXQgdGhlIHVwcGVyIGxpbWl0IGZvciA1LWxldmVsIHBhZ2UgdGFibGVzIGNvdWxkIGJl
IHVzZWQgYWxsIHRoZSB0aW1lLg0KDQpPbmUgb3B0aW9uIGlzIHRvIHRlc3QgJyhhZGRyZXNzIHwg
bGVuZ3RoKSA8ICgzPDw2MiknIGluIGFjY2Vzc19vaygpLg0KVGhhdCBpcyBhbHNvIG1vZGVyYXRl
bHkgc3VpdGFibGUgZm9yIG1hc2tpbmcgaW52YWxpZCBhZGRyZXNzZXMgdG8gMC4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

