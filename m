Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB40820C0D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgF0Ktq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 06:49:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25702 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgF0Ktq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 06:49:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-123-vJ8joaIvN8aZFMN3JjXhHA-1; Sat, 27 Jun 2020 11:49:42 +0100
X-MC-Unique: vJ8joaIvN8aZFMN3JjXhHA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 27 Jun 2020 11:49:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 27 Jun 2020 11:49:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Thread-Topic: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Thread-Index: AQHWSlL8Fz5PlOyONku9ShNOCTqEYajsST7A
Date:   Sat, 27 Jun 2020 10:49:41 +0000
Message-ID: <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de>
 <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgSnVuZSAyMDIwIDE5OjEyDQo+IE9uIFdl
ZCwgSnVuIDI0LCAyMDIwIGF0IDEwOjU1IEFNIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
PiB3cm90ZToNCj4gPg0KPiA+IEkgZG9uJ3QgY2FyZSBhdCBhbGwuICBCYXNlZCBvbiBvdXIgcHJl
dmlvdXMgY2hhdCBJIGFzc3VtZWQgeW91DQo+ID4gd2FudGVkIHNvbWV0aGluZyBsaWtlIHRoaXMu
ICBXZSBtaWdodCBzdGlsbCBuZWVkIHRoZSB1cHRyX3QgZm9yDQo+ID4gc2V0c29ja29wdCwgdGhv
dWdoLg0KPiANCj4gTm8uDQo+IA0KPiBXaGF0IEkgbWVhbiB3YXMgKm5vdCogc29tZXRoaW5nIGxp
a2UgdXB0cl90Lg0KPiANCj4gSnVzdCBrZWVwIHRoZSBleGlzdGluZyAic2V0X2ZzKCkiLiBJdCdz
IG5vdCBoYXJtZnVsIGlmIGl0J3Mgb25seSB1c2VkDQo+IG9jY2FzaW9uYWxseS4gV2Ugc2hvdWxk
IHJlbmFtZSBpdCBvbmNlIGl0J3MgcmFyZSBlbm91Z2gsIHRob3VnaC4NCg0KQW0gSSByaWdodCBp
biB0aGlua2luZyB0aGF0IGl0IGp1c3Qgc2V0cyBhIGZsYWcgaW4gJ2N1cnJlbnQnID8NCkFsdGhv
dWdoIEkgZG9uJ3QgcmVtZW1iZXIgYWNjZXNzX29rKCkgZG9pbmcgYSBzdWl0YWJsZSBjaGVjaw0K
KHdvdWxkIG5lZWQgdG8gYmUgKGFkZHJlc3MgLSBiYXNlKSA8IGxpbWl0KS4NCg0KPiBUaGVuLCBt
YWtlIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4gDQo+ICAtIGFsbCB0aGUgbm9ybWFsIHVzZXIg
YWNjZXNzIGZ1bmN0aW9ucyBzdG9wIGNhcmluZy4gVGhleSB1c2UNCj4gVEFTS19TSVpFX01BWCBh
bmQgYXJlIGRvbmUgd2l0aCBpdC4gVGhleSBiYXNpY2FsbHkgc3RvcCByZWFjdGluZyB0bw0KPiBz
ZXRfZnMoKS4NCj4gDQo+ICAtIHRoZW4sIHdlIGNhbiBoYXZlIGEgZmV3ICp2ZXJ5KiBzcGVjaWZp
YyBjYXNlcyAobGlrZSBzZXRzb2Nrb3B0LA0KPiBtYXliZSBzb21lIHJhbmRvbSByZWFkL3dyaXRl
KSB0aGF0IHdlIHRlYWNoIHRvIHVzZSB0aGUgbmV3IHNldF9mcygpDQo+IHRoaW5nLg0KDQpDZXJ0
YWlubHkgdGhlcmUgaXMgYSAnQlBGJyBob29rIGluIHRoZSBzZXRzb2Nrb3B0KCkgc3lzY2FsbCBo
YW5kbGVyDQp0aGF0IGNhbiBzdWJzdGl0dXRlIGEga2VybmVsIGJ1ZmZlciBmb3IgYW55IHNldHNv
Y2tvcHQoKSByZXF1ZXN0Lg0KDQpJZiB0aGF0IGlzIG5lZWRlZCAoSSBwcmVzdW1lIGl0IHdhcyBh
ZGRlZCBmb3IgYSBwdXJwb3NlKSB0aGVuIGFsbA0KdGhlIHNvY2tldCBvcHRpb24gY29kZSBuZWVk
cyB0byBiZSBhYmxlIHRvIGhhbmRsZSBrZXJuZWwgYnVmZmVycy4NCihBY3R1YWxseSBnaXZlbiB3
aGF0IHNvbWUgZ2V0c29ja29wdCgpIGRvLCBpZiB0aGVyZSB3YXMgYQ0KcmVxdWlyZW1lbnQgdG8g
J2FkanVzdCcgc2V0c29ja29wdCgpIHRoZW4gdGhlcmUgc2hvdWxkIGJlIGEgaG9vaw0KaW4gdGhl
IGdldHNvY2tvcHQoKSBjb2RlIGFzIHdlbGwuKQ0KDQpJZiB5b3UgYXJlIGdvaW5nIHRvIGdvIHRo
cm91Z2ggYWxsIHRoZSBzb2NrZXQgb3B0aW9uIGNvZGUgdG8gY2hhbmdlDQp0aGUgbmFtZSBvZiBh
bGwgdGhlIGJ1ZmZlciBhY2Nlc3MgZnVuY3Rpb25zIHRoZW4gaXQgaXMgcHJvYmFibHkNCmFsbW9z
dCBhcyBlYXN5IHRvIG1vdmUgdGhlIHVzZXJjb3BpZXMgb3V0IGludG8gdGhlIHdyYXBwZXJzLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

