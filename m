Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE92725AC58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgIBNv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 09:51:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55962 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727918AbgIBNvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:51:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-I6NBJ2z0PIWY5wEzjjZvMA-1; Wed, 02 Sep 2020 14:51:06 +0100
X-MC-Unique: I6NBJ2z0PIWY5wEzjjZvMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Sep 2020 14:51:05 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Sep 2020 14:51:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Christoph Hellwig' <hch@lst.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
Thread-Topic: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
Thread-Index: AQHWgSXGxcHfrrTX9UCmYjSyVg3SwKlVUsKA///zAICAABMqAA==
Date:   Wed, 2 Sep 2020 13:51:05 +0000
Message-ID: <0c298e0d972a48bd9ee178225e404b12@AcuMS.aculab.com>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
 <61b9a880a6424a34b841cf3dddb463ad@AcuMS.aculab.com>
 <8de54fe0-4be9-5624-dd1d-d95d792e933d@csgroup.eu>
In-Reply-To: <8de54fe0-4be9-5624-dd1d-d95d792e933d@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwMiBTZXB0ZW1iZXIgMjAyMCAxNDoyNQ0K
PiBMZSAwMi8wOS8yMDIwIMOgIDE1OjEzLCBEYXZpZCBMYWlnaHQgYSDDqWNyaXTCoDoNCj4gPiBG
cm9tOiBDaHJpc3RvcGggSGVsbHdpZw0KPiA+PiBTZW50OiAwMiBTZXB0ZW1iZXIgMjAyMCAxMzoz
Nw0KPiA+Pg0KPiA+PiBPbiBXZWQsIFNlcCAwMiwgMjAyMCBhdCAwODoxNToxMkFNICswMjAwLCBD
aHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPiA+Pj4+IC0JCXJldHVybiAwOw0KPiA+Pj4+IC0JcmV0
dXJuIChzaXplID09IDAgfHwgc2l6ZSAtIDEgPD0gc2VnLnNlZyAtIGFkZHIpOw0KPiA+Pj4+ICsJ
aWYgKGFkZHIgPj0gVEFTS19TSVpFX01BWCkNCj4gPj4+PiArCQlyZXR1cm4gZmFsc2U7DQo+ID4+
Pj4gKwlpZiAoc2l6ZSA9PSAwKQ0KPiA+Pj4+ICsJCXJldHVybiBmYWxzZTsNCj4gPj4+DQo+ID4+
PiBfX2FjY2Vzc19vaygpIHdhcyByZXR1cm5pbmcgdHJ1ZSB3aGVuIHNpemUgPT0gMCB1cCB0byBu
b3cuIEFueSByZWFzb24gdG8NCj4gPj4+IHJldHVybiBmYWxzZSBub3cgPw0KPiA+Pg0KPiA+PiBO
bywgdGhpcyBpcyBhY2NpZGVudGFsIGFuZCBicm9rZW4uICBDYW4geW91IHJlLXJ1biB5b3VyIGJl
bmNobWFyayB3aXRoDQo+ID4+IHRoaXMgZml4ZWQ/DQo+ID4NCj4gPiBJcyBUQVNLX1NJWkVfTUFT
SyBkZWZpbmVkIHN1Y2ggdGhhdCB5b3UgY2FuIGRvOg0KPiA+DQo+ID4gCXJldHVybiAoYWRkciB8
IHNpemUpIDwgVEFTS19TSVpFX01BWCkgfHwgIXNpemU7DQo+IA0KPiBUQVNLX1NJWkVfTUFYIHdp
bGwgdXN1YWxseSBiZSAweGMwMDAwMDAwDQo+IA0KPiBXaXRoOg0KPiBhZGRyID0gMHg4MDAwMDAw
MDsNCj4gc2l6ZSA9IDB4ODAwMDAwMDA7DQo+IA0KPiBJIGV4cGVjdCBpdCB0byBmYWlsIC4uLi4N
Cj4gDQo+IFdpdGggdGhlIGZvcm11bGEgeW91IHByb3Bvc2UgaXQgd2lsbCBzdWNjZWVkLCB3b24n
dCBpdCA/DQoNCkhtbW0uLi4gV2FzIGkgZ2V0dGluZyBjb25mdXNlZCBhYm91dCBzb21lIGNvbW1l
bnRzIGZvciA2NGJpdA0KYWJvdXQgdGhlcmUgYmVpbmcgc3VjaCBhIGJpZyBob2xlIGJldHdlZW4g
dmFsaWQgdXNlciBhbmQga2VybmVsDQphZGRyZXNzZXMgdGhhdCBpdCB3YXMgZW5vdWdoIHRvIGNo
ZWNrIHRoYXQgJ3NpemUgPCBUQVNLX1NJWkVfTUFYJy4NCg0KVGhhdCB3b3VsZCBiZSB0cnVlIGZv
ciA2NGJpdCB4ODYgKGFuZCBwcm9iYWJseSBwcGMgKCYgYXJtPz8pKQ0KaWYgVEFTS19TSVpFX01B
WCB3ZXJlIDB4NCA8PCA2MC4NCklJVUMgdGhlIGhpZ2hlc3QgdXNlciBhZGRyZXNzIGlzIChtdWNo
KSBsZXNzIHRoYW4gMHgwIDw8IDYwDQphbmQgdGhlIGxvd2VzdCBrZXJuZWwgYWRkcmVzcyAobXVj
aCkgZ3JlYXRlciB0aGFuIDB4ZiA8PCA2MA0Kb24gYWxsIHRoZXNlIDY0Yml0IHBsYXRmb3Jtcy4N
Cg0KQWN0dWFsbHkgaWYgZG9pbmcgYWNjZXNzX29rKCkgaW5zaWRlIGdldF91c2VyKCkgeW91IGRv
bid0DQpuZWVkIHRvIGNoZWNrIHRoZSBzaXplIGF0IGFsbC4NCllvdSBkb24ndCBldmVuIG5lZWQg
dG8gaW4gY29weV90by9mcm9tX3VzZXIoKSBwcm92aWRlZA0KaXQgYWx3YXlzIGRvZXMgYSBmb3J3
YXJkcyBjb3B5Lg0KKFJhdGhlciB0aGF0IGNvcHlpbmcgdGhlIGxhc3Qgd29yZCBmaXJzdCBmb3Ig
bWlzYWxpZ25lZCBsZW5ndGhzLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

