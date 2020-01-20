Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DE143022
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgATQnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 11:43:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:29384 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbgATQnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:43:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-247-W8g1vLVvOyGkIi9z1W8g3w-1; Mon, 20 Jan 2020 16:43:21 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 16:43:21 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jan 2020 16:43:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali.rohar@gmail.com>
CC:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>
Subject: RE: vfat: Broken case-insensitive support for UTF-8
Thread-Topic: vfat: Broken case-insensitive support for UTF-8
Thread-Index: AQHVz4FsiOVqsS4Qp0SucuDN4afIhKfzph4wgAAFE4CAAADOMIAAEeCAgAAB5zA=
Date:   Mon, 20 Jan 2020 16:43:21 +0000
Message-ID: <b42888a01c8847e48116873ebbbbb261@AcuMS.aculab.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp> <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
 <20200120152009.5vbemgmvhke4qupq@pali>
 <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
 <20200120162701.guxcrmqysejaqw6y@pali>
In-Reply-To: <20200120162701.guxcrmqysejaqw6y@pali>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: W8g1vLVvOyGkIi9z1W8g3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogUGFsaSBSb2jDoXINCj4gU2VudDogMjAgSmFudWFyeSAyMDIwIDE2OjI3DQouLi4NCj4g
PiBVbmZvcnR1bmF0ZWx5IHRoZXJlIGlzIG5laXRoZXIgYSAxOjEgbWFwcGluZyBvZiBhbGwgcG9z
c2libGUgYnl0ZSBzZXF1ZW5jZXMNCj4gPiB0byB3Y2hhcl90IChvciB1bmljb2RlIGNvZGUgcG9p
bnRzKSwNCj4gDQo+IEkgd2FzIHRhbGtpbmcgYWJvdXQgdmFsaWQgVVRGLTggc2VxdWVuY2UgKGlu
dmFsaWQsIGlsbGZvcm1lZCBpcyBvdXQgb2YNCj4gZ2FtZSBhbmQgZm9yIHN1cmUgd291bGQgYWx3
YXlzIGNhdXNlIHByb2JsZW1zKS4NCg0KRXhjZXB0IHRoYXQgdGhleSBhcmUgYWx3YXlzIGxpa2Vs
eSB0byBoYXBwZW4uDQpJJ3ZlIGJlZW4gcGlzc2VkIG9mZiBieSBwcm9ncmFtcyBjcmFzaGluZyBi
ZWNhdXNlIHRoZXkgYXNzdW1lIHRoYXQNCmEgaW5wdXQgc3RyaW5nIChlZyBhbiBlbWFpbCkgaXMg
VVRGLTggYnV0IGhhcHBlbnMgdG8gY29udGFpbiBhIHNpbmdsZQ0KMHhhMyBieXRlIGluIHRoZSBv
dGhlcndpc2UgNy1iaXQgZGF0YS4NCg0KVGhlIHN0YW5kYXJkIG91Z2h0IHRvIGhhdmUgZGVmaW5l
ZCBhIHRyYW5zbGF0aW9uIGZvciBzdWNoIHNlcXVlbmNlcw0KYW5kIGp1c3QgYSAnd2FybmluZycg
ZnJvbSB0aGUgZnVuY3Rpb24ocykgdGhhdCB1bmV4cGVjdGVkIGJ5dGVzIHdlcmUNCnByb2Nlc3Nl
ZC4NCg0KPiA+IG5vciBhIDE6MSBtYXBwaW5nIG9mIGFsbCBwb3NzaWJsZSB3Y2hhcl90IHZhbHVl
cyB0byBVVEYtOC4NCj4gDQo+IFRoaXMgaXMgbm90IHRydXRoLiBUaGVyZSBpcyBleGFjdGx5IG9u
bHkgb25lIHdheSBob3cgdG8gY29udmVydCBzZXF1ZW5jZQ0KPiBvZiBVbmljb2RlIGNvZGUgcG9p
bnRzIHRvIFVURi04LiBVVEYgaXMgVW5pY29kZSBUcmFuc2Zvcm1hdGlvbiBGb3JtYXQNCj4gYW5k
IGhhcyBleGFjdCBkZWZpbml0aW9uIGhvdyBpcyBVbmljb2RlIFRyYW5zZm9ybWVkLg0KDQpCdXQg
YSB3Y2hhcl90IGNhbiBob2xkIGxvdHMgb2YgdmFsdWVzIHRoYXQgYXJlbid0IFVuaWNvZGUgY29k
ZSBwb2ludHMuDQpQcmlvciB0byB0aGUgMjAwMyBjaGFuZ2VzIGhhbGYgb2YgdGhlIDJeMzIgdmFs
dWVzIGNvdWxkIGJlIGNvbnZlcnRlZC4NCkFmdGVyd2FyZHMgb25seSBhIHNtYWxsIGZyYWN0aW9u
Lg0KDQo+IElmIHlvdSBoYXZlIHZhbGlkIFVURi04IHNlcXVlbmNlIHRoZW4gaXQgZGVzY3JpYmUg
b25lIGV4YWN0IHNlcXVlbmNlIG9mDQo+IFVuaWNvZGUgY29kZSBwb2ludHMuIEFuZCBpZiB5b3Ug
aGF2ZSBzZXF1ZW5jZSAob3JkaW5hbHMpIG9mIFVuaWNvZGUgY29kZQ0KPiBwb2ludHMgdGhlcmUg
aXMgZXhhY3RseSBvbmUgYW5kIG9ubHkgb25lIGl0cyByZXByZXNlbnRhdGlvbiBpbiBVVEYtOC4N
Cj4gDQo+IEkgd291bGQgc3VnZ2VzdCB5b3UgdG8gcmVhZCBVbmljb2RlIHN0YW5kYXJkLCBzZWN0
aW9uIDIuNSBFbmNvZGluZyBGb3Jtcy4NCg0KVGhhdCBhbGwgYXNzdW1lcyBldmVyeW9uZSBpcyBw
bGF5aW5nIHRoZSBjb3JyZWN0IGdhbWUNCg0KPiA+IFJlYWxseSBib3RoIG5lZWQgdG8gYmUgZGVm
aW5lZCAtIGV2ZW4gZm9yIG90aGVyd2lzZSAnaW52YWxpZCcgc2VxdWVuY2VzLg0KPiA+DQo+ID4g
RXZlbiB0aGUgMTYtYml0IHZhbHVlcyBhYm92ZSAweGQwMDAgY2FuIGFwcGVhciBvbiB0aGVpciBv
d24gaW4NCj4gPiB3aW5kb3dzIGZpbGVzeXN0ZW1zIChhY2NvcmRpbmcgdG8gd2lraXBlZGlhKS4N
Cj4gDQo+IElmIHlvdSBhcmUgdGFsa2luZyBhYm91dCBVVEYtMTYgKHdoaWNoIGlzIF9ub3RfIDE2
LWJpdCBhcyB5b3Ugd3JvdGUpLA0KPiBsb29rIGF0IG15IHByZXZpb3VzIGVtYWlsOg0KDQpVRlQt
MTYgaXMgYSBzZXF1ZW5jZSBvZiAxNi1iaXQgdmFsdWVzLi4uLg0KSXQgY2FuIGNvbnRhaW4gMHhk
MDAwIHRvIDB4ZmZmZiAodXN1YWxseSBpbiBwYWlycykgYnV0IHRoZXkgYXJlbid0IFVURi04IGNv
ZGVwb2ludHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

