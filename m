Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85025AF81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBPkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:40:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35662 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbgIBPCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:02:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-288-m2mOhcL7OFeLx9bWhCsspw-1; Wed, 02 Sep 2020 16:02:01 +0100
X-MC-Unique: m2mOhcL7OFeLx9bWhCsspw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Sep 2020 16:02:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Sep 2020 16:02:00 +0100
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
Thread-Index: AQHWgSXGxcHfrrTX9UCmYjSyVg3SwKlVUsKA///zAICAABMqAP//+kwAgAAcsTA=
Date:   Wed, 2 Sep 2020 15:02:00 +0000
Message-ID: <1599b80426ec4759b5c1beb9d9543fdc@AcuMS.aculab.com>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
 <61b9a880a6424a34b841cf3dddb463ad@AcuMS.aculab.com>
 <8de54fe0-4be9-5624-dd1d-d95d792e933d@csgroup.eu>
 <0c298e0d972a48bd9ee178225e404b12@AcuMS.aculab.com>
 <6e88048a-8b30-400e-11c6-8d91ba77cbb0@csgroup.eu>
In-Reply-To: <6e88048a-8b30-400e-11c6-8d91ba77cbb0@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwMiBTZXB0ZW1iZXIgMjAyMCAxNToxMw0K
PiANCj4gDQo+IExlIDAyLzA5LzIwMjAgw6AgMTU6NTEsIERhdmlkIExhaWdodCBhIMOpY3JpdMKg
Og0KPiA+IEZyb206IENocmlzdG9waGUgTGVyb3kNCj4gPj4gU2VudDogMDIgU2VwdGVtYmVyIDIw
MjAgMTQ6MjUNCj4gPj4gTGUgMDIvMDkvMjAyMCDDoCAxNToxMywgRGF2aWQgTGFpZ2h0IGEgw6lj
cml0wqA6DQo+ID4+PiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZw0KPiA+Pj4+IFNlbnQ6IDAyIFNl
cHRlbWJlciAyMDIwIDEzOjM3DQo+ID4+Pj4NCj4gPj4+PiBPbiBXZWQsIFNlcCAwMiwgMjAyMCBh
dCAwODoxNToxMkFNICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPiA+Pj4+Pj4gLQkJ
cmV0dXJuIDA7DQo+ID4+Pj4+PiAtCXJldHVybiAoc2l6ZSA9PSAwIHx8IHNpemUgLSAxIDw9IHNl
Zy5zZWcgLSBhZGRyKTsNCj4gPj4+Pj4+ICsJaWYgKGFkZHIgPj0gVEFTS19TSVpFX01BWCkNCj4g
Pj4+Pj4+ICsJCXJldHVybiBmYWxzZTsNCj4gPj4+Pj4+ICsJaWYgKHNpemUgPT0gMCkNCj4gPj4+
Pj4+ICsJCXJldHVybiBmYWxzZTsNCj4gPj4+Pj4NCj4gPj4+Pj4gX19hY2Nlc3Nfb2soKSB3YXMg
cmV0dXJuaW5nIHRydWUgd2hlbiBzaXplID09IDAgdXAgdG8gbm93LiBBbnkgcmVhc29uIHRvDQo+
ID4+Pj4+IHJldHVybiBmYWxzZSBub3cgPw0KPiA+Pj4+DQo+ID4+Pj4gTm8sIHRoaXMgaXMgYWNj
aWRlbnRhbCBhbmQgYnJva2VuLiAgQ2FuIHlvdSByZS1ydW4geW91ciBiZW5jaG1hcmsgd2l0aA0K
PiA+Pj4+IHRoaXMgZml4ZWQ/DQo+ID4+Pg0KPiA+Pj4gSXMgVEFTS19TSVpFX01BU0sgZGVmaW5l
ZCBzdWNoIHRoYXQgeW91IGNhbiBkbzoNCj4gPj4+DQo+ID4+PiAJcmV0dXJuIChhZGRyIHwgc2l6
ZSkgPCBUQVNLX1NJWkVfTUFYKSB8fCAhc2l6ZTsNCj4gPj4NCj4gPj4gVEFTS19TSVpFX01BWCB3
aWxsIHVzdWFsbHkgYmUgMHhjMDAwMDAwMA0KPiA+Pg0KPiA+PiBXaXRoOg0KPiA+PiBhZGRyID0g
MHg4MDAwMDAwMDsNCj4gPj4gc2l6ZSA9IDB4ODAwMDAwMDA7DQo+ID4+DQo+ID4+IEkgZXhwZWN0
IGl0IHRvIGZhaWwgLi4uLg0KPiA+Pg0KPiA+PiBXaXRoIHRoZSBmb3JtdWxhIHlvdSBwcm9wb3Nl
IGl0IHdpbGwgc3VjY2VlZCwgd29uJ3QgaXQgPw0KPiA+DQo+ID4gSG1tbS4uLiBXYXMgaSBnZXR0
aW5nIGNvbmZ1c2VkIGFib3V0IHNvbWUgY29tbWVudHMgZm9yIDY0Yml0DQo+ID4gYWJvdXQgdGhl
cmUgYmVpbmcgc3VjaCBhIGJpZyBob2xlIGJldHdlZW4gdmFsaWQgdXNlciBhbmQga2VybmVsDQo+
ID4gYWRkcmVzc2VzIHRoYXQgaXQgd2FzIGVub3VnaCB0byBjaGVjayB0aGF0ICdzaXplIDwgVEFT
S19TSVpFX01BWCcuDQo+ID4NCj4gPiBUaGF0IHdvdWxkIGJlIHRydWUgZm9yIDY0Yml0IHg4NiAo
YW5kIHByb2JhYmx5IHBwYyAoJiBhcm0/PykpDQo+ID4gaWYgVEFTS19TSVpFX01BWCB3ZXJlIDB4
NCA8PCA2MC4NCj4gPiBJSVVDIHRoZSBoaWdoZXN0IHVzZXIgYWRkcmVzcyBpcyAobXVjaCkgbGVz
cyB0aGFuIDB4MCA8PCA2MA0KPiA+IGFuZCB0aGUgbG93ZXN0IGtlcm5lbCBhZGRyZXNzIChtdWNo
KSBncmVhdGVyIHRoYW4gMHhmIDw8IDYwDQo+ID4gb24gYWxsIHRoZXNlIDY0Yml0IHBsYXRmb3Jt
cy4NCj4gPg0KPiA+IEFjdHVhbGx5IGlmIGRvaW5nIGFjY2Vzc19vaygpIGluc2lkZSBnZXRfdXNl
cigpIHlvdSBkb24ndA0KPiA+IG5lZWQgdG8gY2hlY2sgdGhlIHNpemUgYXQgYWxsLg0KPiANCj4g
WW91IG1lYW4gb24gNjQgYml0IG9yIG9uIGFueSBwbGF0Zm9ybSA/DQoNCjY0Yml0IGFuZCAzMmJp
dA0KDQo+IFdoYXQgYWJvdXQgYSB3b3JkIHdyaXRlIHRvIDB4YmZmZmZmZmUsIHdvbid0IGl0IG92
ZXJ3cml0ZSAweGMwMDAwMDAwID8NCj4gDQo+ID4gWW91IGRvbid0IGV2ZW4gbmVlZCB0byBpbiBj
b3B5X3RvL2Zyb21fdXNlcigpIHByb3ZpZGVkDQo+ID4gaXQgYWx3YXlzIGRvZXMgYSBmb3J3YXJk
cyBjb3B5Lg0KPiANCj4gRG8geW91IG1lYW4gZHVlIHRvIHRoZSBnYXAgPw0KPiBJcyBpdCBnYXJh
bnRpZWQgdG8gYmUgYSBnYXAgPyBFdmVuIG9uIGEgMzIgYml0cyBoYXZpbmcgVEFTS19TSVpFIHNl
dCB0bw0KPiAweGMwMDAwMDAwIGFuZCBQQUdFX09GRlNFVCBzZXQgdG8gdGhlIHNhbWUgPw0KDQpJ
IHJlYWQgc29tZXdoZXJlIChJIHdvbid0IGZpbmQgaXQgYWdhaW4pIHRoYXQgdGhlIGxhc3QgNGsg
cGFnZQ0KKGJlbG93IDB4YzAwMDAwMDApIG11c3Qgbm90IGJlIGFsbG9jYXRlZCBvbiBpMzg2IGJl
Y2F1c2Ugc29tZQ0KY3B1IChib3RoIGludGVsIGFuZCBhbWQpIGRvICdob3JyaWQgdGhpbmdzJyBp
ZiB0aGV5IHRyeSB0bw0KKElJUkMpIGRvIGluc3RydWN0aW9uIHByZWZldGNoZXMgYWNyb3NzIHRo
ZSBib3VuZGFyeS4NClNvIHRoZSBhY2Nlc3NlcyB0byAweGJmZmZmZmZlIHdpbGwgZmF1bHQgYW5k
IHRoZSBvbmUgdG8gMHhjMDAwMDAwMA0Kd29uJ3QgaGFwcGVuIChpbiBhbnkgdXNlZnVsIHdheSBh
dCBsZWFzdCkuDQoNCkknZCBzdXNwZWN0IHRoYXQgbm90IGFsbG9jYXRpbmcgdGhlIDNHLTRrIHBh
Z2Ugd291bGQgYmUgYSBzYWZlDQpiZXQgb24gYWxsIGFyY2hpdGVjdHVyZXMgLSBldmVuIDY4ay4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

