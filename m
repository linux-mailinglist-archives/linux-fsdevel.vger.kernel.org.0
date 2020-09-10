Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60BF264604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgIJM30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 08:29:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31639 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730657AbgIJM1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:27:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-242-gUIwh0VwNUeXA06T7Iw4zQ-1; Thu, 10 Sep 2020 13:26:54 +0100
X-MC-Unique: gUIwh0VwNUeXA06T7Iw4zQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Sep 2020 13:26:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Sep 2020 13:26:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Topic: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Index: AQHWhvDyD2c/lZfV3kC0Ftay5UVebqlhgjnw///zuACAABnIEIAAOoMg
Date:   Thu, 10 Sep 2020 12:26:53 +0000
Message-ID: <5050b43687c84515a49b345174a98822@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com>
 <20200909184001.GB28786@gate.crashing.org>
 <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
 <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com>
 <186a62fc-042c-d6ab-e7dc-e61b18945498@csgroup.eu>
 <59a64e9a210847b59f70f9bd2d02b5c3@AcuMS.aculab.com>
In-Reply-To: <59a64e9a210847b59f70f9bd2d02b5c3@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDEwIFNlcHRlbWJlciAyMDIwIDEwOjI2DQouLi4N
Cj4gPiA+IEkgaGFkIGFuICdpbnRlcmVzdGluZycgaWRlYS4NCj4gPiA+DQo+ID4gPiBDYW4geW91
IHVzZSBhIGxvY2FsIGFzbSByZWdpc3RlciB2YXJpYWJsZSBhcyBhbiBpbnB1dCBhbmQgb3V0cHV0
IHRvDQo+ID4gPiBhbiAnYXNtIHZvbGF0aWxlIGdvdG8nIHN0YXRlbWVudD8NCj4gPiA+DQo+ID4g
PiBXZWxsIHlvdSBjYW4gLSBidXQgaXMgaXQgZ3VhcmFudGVlZCB0byB3b3JrIDotKQ0KPiA+ID4N
Cj4gPg0KPiA+IFdpdGggZ2NjIGF0IGxlYXN0IGl0IHNob3VsZCB3b3JrIGFjY29yZGluZyB0bw0K
PiA+IGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvTG9jYWwtUmVnaXN0ZXItVmFy
aWFibGVzLmh0bWwNCj4gPg0KPiA+IFRoZXkgZXZlbiBleHBsaWNpdGVseSB0ZWxsOiAiVGhlIG9u
bHkgc3VwcG9ydGVkIHVzZSBmb3IgdGhpcyBmZWF0dXJlIGlzDQo+ID4gdG8gc3BlY2lmeSByZWdp
c3RlcnMgZm9yIGlucHV0IGFuZCBvdXRwdXQgb3BlcmFuZHMgd2hlbiBjYWxsaW5nIEV4dGVuZGVk
DQo+ID4gYXNtICINCj4gDQo+IEEgcXVpY2sgdGVzdCBpc24ndCBnb29kLi4uLg0KPiANCj4gaW50
IGJhcihjaGFyICp6KQ0KPiB7DQo+ICAgICAgICAgX19sYWJlbF9fIGxhYmVsOw0KPiAgICAgICAg
IHJlZ2lzdGVyIGludCBlYXggYXNtICgiZWF4IikgPSA2Ow0KPiAgICAgICAgIGFzbSB2b2xhdGls
ZSBnb3RvICgiIG1vdiAkMSwgJSVlYXgiIDo6OiAiZWF4IiA6IGxhYmVsKTsNCj4gbGFiZWw6DQo+
ICAgICAgICAgcmV0dXJuIGVheDsNCj4gfQ0KPiANCj4gMDAwMDAwMDAwMDAwMDA0MCA8YmFyPjoN
Cj4gICA0MDogICBiOCAwMSAwMCAwMCAwMCAgICAgICAgICBtb3YgICAgJDB4MSwlZWF4DQo+ICAg
NDU6ICAgYjggMDYgMDAgMDAgMDAgICAgICAgICAgbW92ICAgICQweDYsJWVheA0KPiAgIDRhOiAg
IGMzICAgICAgICAgICAgICAgICAgICAgIHJldHENCj4gDQo+IGFsdGhvdWdoIGFkZGluZzoNCj4g
ICAgICAgICBhc20gdm9sYXRpbGUgKCIiIDogIityIiAoZWF4KSk7DQo+IGVpdGhlciBzaWRlIG9m
IHRoZSAnYXNtIHZvbGF0aWxlIGdvdG8nIGRvZXMgZml4IGl0Lg0KDQpBY3R1YWxseSB0aGlzIGlz
IHByZXR0eSBzb3VuZDoNCglfX2xhYmVsX18gbGFiZWw7DQoJcmVnaXN0ZXIgaW50IGVheCBhc20g
KCJlYXgiKTsNCgkvLyBFbnN1cmUgZWF4IGNhbid0IGJlIHJlbG9hZGVkIGZyb20gYW55d2hlcmUN
CgkvLyBJbiBwYXJ0aWN1bGFyIGl0IGNhbid0IGJlIHJlbG9hZGVkIGFmdGVyIHRoZSBhc20gZ290
byBsaW5lDQoJYXNtIHZvbGF0aWxlICgiIiA6ICI9ciIgKGVheCkpOw0KCS8vIFByb3ZpZGVkIGdj
YyBkb2Vzbid0IHNhdmUgZWF4IGhlcmUuLi4NCglhc20gdm9sYXRpbGUgZ290byAoInh4eHh4IiA6
OjogImVheCIgOiBsYWJlbCk7DQoJLy8gLi4uIGFuZCByZWxvYWQgdGhlIHNhdmVkIHZhbHVlIGhl
cmUuDQoJLy8gVGhlIGlucHV0IHZhbHVlIGhlcmUgd2lsbCBiZSB0aGF0IG1vZGlmaWVkIGJ5IHRo
ZSAnYXNtIGdvdG8nLg0KCS8vIFNpbmNlIHRoaXMgbW9kaWZpZXMgZWF4IGl0IGNhbid0IGJlIG1v
dmVkIGJlZm9yZSB0aGUgJ2FzbSBnb3RvJy4NCglhc20gdm9sYXRpbGUgKCIiIDogIityIiAoZWF4
KSk7DQoJLy8gU28gaGVyZSBlYXggbXVzdCBjb250YWluIHRoZSB2YWx1ZSBzZXQgYnkgdGhlICJ4
eHh4eCIgaW5zdHJ1Y3Rpb25zLg0KDQogICAgRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

