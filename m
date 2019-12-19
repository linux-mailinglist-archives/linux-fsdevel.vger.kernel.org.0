Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2FC126437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSOFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 09:05:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23442 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbfLSOFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:05:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-18-lkdE9QJxMPae3bT7pEoTqQ-1; Thu, 19 Dec 2019 14:05:05 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 19 Dec 2019 14:05:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 19 Dec 2019 14:05:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aleksa Sarai' <cyphar@cyphar.com>,
        Florian Weimer <fweimer@redhat.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
Thread-Topic: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
Thread-Index: AQHVtnKfNpps3AEjjUOZljxYP1VvUqfBfNKA
Date:   Thu, 19 Dec 2019 14:05:04 +0000
Message-ID: <845fc9e8b55e4868bb4d20655e674b50@AcuMS.aculab.com>
References: <20191219105533.12508-1-cyphar@cyphar.com>
 <20191219105533.12508-2-cyphar@cyphar.com>
 <87a77oy3oe.fsf@oldenburg2.str.redhat.com>
 <20191219134525.mgzmjbsp4wo5b2bw@yavin.dot.cyphar.com>
In-Reply-To: <20191219134525.mgzmjbsp4wo5b2bw@yavin.dot.cyphar.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: lkdE9QJxMPae3bT7pEoTqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQWxla3NhIFNhcmFpDQo+IFNlbnQ6IDE5IERlY2VtYmVyIDIwMTkgMTM6NDUNCj4gT24g
MjAxOS0xMi0xOSwgRmxvcmlhbiBXZWltZXIgPGZ3ZWltZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
ID4gKiBBbGVrc2EgU2FyYWk6DQo+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
bGludXgvb3BlbmF0Mi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L29wZW5hdDIuaA0KPiA+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTllZjc3NWU4ZTVl
DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvb3Bl
bmF0Mi5oDQo+ID4gPiBAQCAtMCwwICsxLDQxIEBADQo+ID4gPiArLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAgV0lUSCBMaW51eC1zeXNjYWxsLW5vdGUgKi8NCj4gPiA+ICsjaWZu
ZGVmIF9VQVBJX0xJTlVYX09QRU5BVDJfSA0KPiA+ID4gKyNkZWZpbmUgX1VBUElfTElOVVhfT1BF
TkFUMl9IDQo+ID4NCj4gPiBJIHRoaW5rIHlvdSBzaG91bGQgaW5jbHVkZSB0aGUgcmVsZXZhbnQg
aGVhZGVyIGZvciBfX2FsaWduX3U2NA0KPiA+IGV0Yy4gaGVyZS4NCj4gDQo+IFJpZ2h0IC0tIG5v
IGlkZWEgd2h5IEkgZm9yZ290IHRvIGluY2x1ZGUgdGhlbS4NCg0KSSdtIGd1ZXNzaW5nIHRoYXQg
aXMganVzdCA2NGJpdCBhbGlnbmVkIG9uIDMyYml0IGFyY2hzIGxpa2UgeDg2Pw0KDQpObyBuZWVk
IHRvIGVuZm9yY2UgaXQgcHJvdmlkZWQgdGhlIHN0cnVjdHVyZSB3aWxsIGhhdmUgbm8gcGFkZGlu
Zw0Kb24gYXJjaHMgd2hlcmUgdGhlIDY0Yml0IGZpZWxkcyBhcmUgNjRiaXQgYWxpZ25lZC4NCkEg
cGxhaW4gX191NjQgc2hvdWxkIGJlIGZpbmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

