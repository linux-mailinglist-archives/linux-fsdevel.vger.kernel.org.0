Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F276C143D30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAUMn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:43:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53116 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbgAUMn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:43:57 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-kQ6x5fBGN4GK5w_8SJObUg-1; Tue, 21 Jan 2020 12:43:54 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 21 Jan 2020 12:43:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 21 Jan 2020 12:43:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali.rohar@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>
Subject: RE: vfat: Broken case-insensitive support for UTF-8
Thread-Topic: vfat: Broken case-insensitive support for UTF-8
Thread-Index: AQHVz+1oiOVqsS4Qp0SucuDN4afIhKf1D3Ng
Date:   Tue, 21 Jan 2020 12:43:53 +0000
Message-ID: <2f8f667b149d4a3e97a924ecbb102875@AcuMS.aculab.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp> <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp> <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
 <20200120235745.hzza3fkehlmw5s45@pali>
In-Reply-To: <20200120235745.hzza3fkehlmw5s45@pali>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: kQ6x5fBGN4GK5w_8SJObUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogUGFsaSBSb2jDoXINCj4gU2VudDogMjAgSmFudWFyeSAyMDIwIDIzOjU4DQouLi4NCj4g
SXQgaXMgT0ssIGJ1dCB0b28gY29tcGxpY2F0ZWQuIFRoYXQgZnVuY3Rpb24gaXMgaW4gbnQga2Vy
bmVsLiBTbyB5b3UNCj4gbmVlZCB0byBidWlsZCBhIG5ldyBrZXJuZWwgbW9kdWxlIGFuZCBhbHNv
IGRlY2lkZSB3aGVyZSB0byBwdXQgb3V0cHV0IG9mDQo+IHRoYXQgZnVuY3Rpb24uIEl0IGlzIGEg
bG9uZyB0aW1lIHNpbmNlIEkgZGlkIHNvbWUgbnQga2VybmVsIGhhY2tpbmcgYW5kDQo+IG5vd2Fk
YXlzIHlvdSBuZWVkIHRvIGRvd25sb2FkIDEwR0IrIG9mIFZpc3VhbCBTdHVkaW8gY29kZSwgdGhl
biBhZGRvbnMNCj4gZm9yIGJ1aWxkaW5nIGtlcm5lbCBtb2R1bGVzLCBmaWd1cmUgb3V0IGhvdyB0
byB3cml0ZSBhbmQgY29tcGlsZSBzaW1wbGUNCj4ga2VybmVsIG1vZHVsZSB2aWEgVmlzdWFsIFN0
dWRpbywgd3JpdGUgaW5pIGluc3RhbGwgZmlsZSwgdHJ5IHRvIGxvYWQgaXQNCj4gYW5kIHRoZW4g
eW91IGV2ZW4gZmFpbCBhcyByZWNlbnQgV2luZG93cyBrZXJuZWxzIHJlZnVzZSB0byBsb2FkIGtl
cm5lbA0KPiBtb2R1bGVzIHdoaWNoIGFyZSBub3Qgc2lnbmVkLi4uDQoNCkFjdHVhbGx5IGl0IGlz
bid0IHF1aXRlIHRoYXQgaGFyZC4NCllvdSBjYW4gZG93bmxvYWQgV2luZGJnLmV4ZSAod2l0aG91
dCB0b28gbXVjaCBvdGhlciBqdW5rIGlmIHlvdSBmaW5kIHRoZSByaWdodCBwbGFjZSkuDQpVc2Ug
YmNkZWRpdCB0byBsZXQgaXQgbG9vayBhdCB0aGUgY3VycmVudCBrZXJuZWwgKGFuZCByZWJvb3Qp
Lg0KVGhlbiB5b3UgY2FuIGdyb3ZlbCB0aHJvdWdoIHRoZSBsaXZlIHN5c3RlbSBrZXJuZWwgd2l0
aCBhbG1vc3Qgbm8gcmVzdHJpY3Rpb24uDQpQb2ludCBpdCBhdCB0aGUgJ3N5bWJvbCBzZXJ2ZXIn
IGFuZCBpdCBrbm93cyB0aGUgbGF5b3V0cyBvZiBhIGxvdCBvZiBrZXJuZWwgc3RydWN0dXJlcy4N
Ck9UT0ggaXQncyBjb21tYW5kIHN5bnRheCBpcyBzcGVjdGFjdWxhcmx5IGhvcnJpZC4NCg0KVGhl
cmUgaXMgYWxzbyBhIGJvb3QgZmxhZyB0byBsZXQgeW91IGxvYWQgJ3Rlc3Qgc2lnbmVkJyBkcml2
ZXJzLg0KT1RPSCBzaWduaW5nIGRyaXZlcnMgZm9yIGEgcmVsZWFzZSBpcyBub3cgYSByZWFsIFBJ
VEEuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

