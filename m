Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF58620EFD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgF3Hve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 03:51:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34985 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728073AbgF3Hvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:51:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-240-2NQ4wyHpMc6BIopA1a4Nxw-1; Tue, 30 Jun 2020 08:51:29 +0100
X-MC-Unique: 2NQ4wyHpMc6BIopA1a4Nxw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 30 Jun 2020 08:51:29 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 30 Jun 2020 08:51:29 +0100
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
Thread-Index: AQHWSlL8Fz5PlOyONku9ShNOCTqEYajsST7AgAOQcieAAPIagA==
Date:   Tue, 30 Jun 2020 07:51:29 +0000
Message-ID: <025de688a10d459489e8110a108fed43@AcuMS.aculab.com>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de>
 <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com>
 <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
 <20200629152912.GA26172@lst.de>
 <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjkgSnVuZSAyMDIwIDE4OjAzDQo+IE9uIE1v
biwgSnVuIDI5LCAyMDIwIGF0IDg6MjkgQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
IHdyb3RlOg0KPiA+DQo+ID4gU28gYmFzZWQgb24gdGhhdCBJJ2QgcmF0aGVyIGdldCBhd2F5IHdp
dGhvdXQgb3VyIGZsYWcgYW5kIHRhZyB0aGUNCj4gPiBrZXJuZWwgcG9pbnRlciBjYXNlIGluIHNl
dHNvY2tvcHQgZXhwbGljaXRseS4NCj4gDQo+IFllYWgsIEknZCBiZSBvayB0byBwYXNzIHRoYXQg
a2luZCBvZiBmbGFnIGFyb3VuZCBmb3Igc2V0c29ja29wdCwgaW4NCj4gd2F5cyBJIF9kb24ndF8g
d2FudCB0byBkbyBmb3Igc29tZSB2ZXJ5IGNvcmUgdmZzIHRoaW5nIGxpa2UgJ3JlYWQoKScuDQo+
IA0KPiBUaGF0IHNhaWQsIGlzIHRoZXJlIG5vIHByYWN0aWNhbCBsaW1pdCBvbiBob3cgYmlnICJv
cHRsZW4iIGNhbiBiZT8NCj4gU3VyZSwgSSByZWFsaXplIHRoYXQgYSBsb3Qgb2Ygc2V0c29ja29w
dCB1c2VycyBtYXkgbm90IHVzZSBhbGwgb2YgdGhlDQo+IGRhdGEsIGJ1dCBsZXQncyBzYXkgdGhh
dCAib3B0bGVuIiBpcyAxMjgsIGJ1dCB0aGUgYWN0dWFsIGxvdy1sZXZlbA0KPiBzZXRzb2Nrb3B0
IG9wZXJhdGlvbiBvbmx5IHVzZXMgdGhlIGZpcnN0IDE2IGJ5dGVzLCBtYXliZSB3ZSBjb3VsZA0K
PiBhbHdheXMganVzdCBjb3B5IHRoZSAxMjggYnl0ZXMgZnJvbSB1c2VyIHNwYWNlIGludG8ga2Vy
bmVsIHNwYWNlLCBhbmQNCj4ganVzdCBzYXkgInNldHNvY2tvcHQoKSBhbHdheXMgZ2V0cyBhIGtl
cm5lbCBwb2ludGVyIi4NCj4gDQo+IFRoZW4gdGhlIGJwZiB1c2UgaXMgZXZlbiBzaW1wbGVyLiBJ
dCB3b3VsZCBqdXN0IHBhc3MgdGhlIGtlcm5lbA0KPiBwb2ludGVyIG5hdGl2ZWx5Lg0KPiANCj4g
QmVjYXVzZSB0aGF0IHNlZW1zIHRvIGJlIHdoYXQgdGhlIEJQRiBjb2RlIHJlYWxseSB3YW50cyB0
byBkbzogaXQNCj4gdGFrZXMgdGhlIHVzZXIgb3B0dmFsLCBhbmQgbXVuZ2VzIGl0IGludG8gYSBr
ZXJuZWwgb3B0dmFsLCBhbmQgdGhlbg0KPiAoaWYgdGhhdCBoYXMgYmVlbiBkb25lKSBydW5zIHRo
ZSBsb3ctbGV2ZWwgc29ja19zZXRzb2Nrb3B0KCkgdW5kZXINCj4gS0VSTkVMX0RTLg0KPiANCj4g
Q291bGRuJ3Qgd2Ugc3dpdGNoIHRoaW5ncyBhcm91bmQgaW5zdGVhZCwgYW5kIGp1c3QgKmFsd2F5
cyogY29weQ0KPiB0aGluZ3MgZnJvbSB1c2VyIHNwYWNlLCBhbmQgc29ja19zZXRzb2Nrb3B0IChh
bmQNCj4gc29jay0+b3BzLT5zZXRzb2Nrb3B0KSBfYWx3YXlzXyBnZXQgYSBrZXJuZWwgYnVmZmVy
Pw0KPiANCj4gQW5kIGF2b2lkIHRoZSBzZXRfZnMoS0VSTkVMX0RTKSBnYW1lcyBlbnRpcmVseSB0
aGF0IHdheT8NCg0KSSBkaWQgYSBwYXRjaCBmb3IgU0NUUCB0byBkbyB0aGUgY29waWVzIGluIHRo
ZSBwcm90b2NvbCB3cmFwcGVyLg0KQXBhcnQgZnJvbSB0aGUgaXNzdWUgb2YgYmFkIGFwcGxpY2F0
aW9ucyBwcm92aWRpbmcgb3ZlcmxhcmdlDQpidWZmZXJzIGFuZCBlZmZlY3RpbmcgYSBsb2NhbCBE
b1MgYXR0YWNrIHRoZXJlIHdlcmUgc29tZSBvZGQgaXNzdWVzOg0KDQoxKSBTQ1RQIGNvbXBsZXRl
bHkgYWJ1c2VzIGJvdGggc2V0c29ja29wdCBhbmQgZ2V0c29ja29wdA0KICAgdG8gcGVyZm9ybSBh
ZGRpdGlvbmFsIHNvY2tldCBvcGVyYXRpb25zLg0KICAgSSBzdXNwZWN0IHRoZSBvcmlnaW5hbCBp
bXBsZW1lbnRhdGlvbiBkaWRuJ3Qgd2FudCB0bw0KICAgYWRkIG5ldyBzeXN0ZW0gY2FsbHMuDQoy
KSBTQ1RQIHRyZWF0cyBnZXRzb2Nrb3B0IGFzIFJNVyBvbiB0aGUgdXNlciBidWZmZXIuDQogICBN
b3N0bHkgaXQgb25seSBuZWVkcyA0IGJ5dGVzLCBidXQgaXQgY2FuIGluIGluY2x1ZGUNCiAgIGEg
c29ja2FkZHJfc3RvcmFnZS4NCjMpIFNDVFAgaGFzIG9uZSBnZXRzb2Nrb3B0IHRoYXQgaXMgcmVh
bGx5IGEgc2V0c29ja29wdA0KICAgKGllIGNoYW5nZXMgdGhpbmdzKSBidXQgaXMgaW1wbGVtZW50
ZWQgdXNpbmcgZ2V0c29ja29wdA0KICAgc28gdGhhdCBpdCBjYW4gcmV0dXJuIGEgdmFsdWUuDQo0
KSBPbmUgb2YgdGhlIFNDVFAgZ2V0c29ja29wdCBjYWxscyBoYXMgdG8gcmV0dXJuIHRoZQ0KICAg
J3dyb25nJyB2YWx1ZSB0byB1c2Vyc3BhY2UgKGllIG5vdCB0aGUgbGVuZ3RoIG9mIHRoZQ0KICAg
dHJhbnNmZXJyZWQgZGF0YSkgZm9yIGNvbXBhdGliaWxpdHkgd2l0aCB0aGUgb3JnaW5hbA0KICAg
YnJva2VuIGNvZGUuDQoNCkknbSB3b25kZXJpbmcgaWYgdGhlIFtzZ11ldHNvY2tvcHQgd3JhcHBl
ciBzaG91bGQgYWN0dWFsbHkNCnBhc3MgdGhyb3VnaCBhIHN0cnVjdHVyZSBjb250YWluaW5nOg0K
CUtlcm5lbCBidWZmZXIgYWRkcmVzcyAob24gc3RhY2sgaWYgc2hvcnQpDQoJVXNlciBidWZmZXIg
YWRkcmVzcyAobWF5IGJlIE5VTEwpDQoJTGVuZ3RoIG9mIGJ1ZmZlcg0KCWNvcHlfdG9fdXNlciBs
ZW5ndGggKG5vcm1hbGx5IHplcm8pDQoJZmxhZzogZW1iZWRkZWQgcG9pbnRlcnMgYXJlIHVzZXIv
a2VybmVsDQoNCk1vc3QgY29kZSB3aWxsIGp1c3QgdXNlIHRoZSBrZXJuZWwgYnVmZmVyIGFuZCBy
ZXR1cm4gbGVuZ3RoL2Vycm9yLg0KDQpDb2RlIHRoYXQga25vd3MgdGhlIHN1cHBsaWVkIGxlbmd0
aCBpcyBpbnZhbGlkIGNhbiB1c2UgdGhlDQp1c2VyIHBvaW50ZXIgLSBidXQgb25seSBzdXBwb3J0
IGRpcmVjdCB1c2VyIHJlcXVlc3RzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

