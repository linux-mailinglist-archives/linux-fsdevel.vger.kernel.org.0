Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55D1F0B1A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgFGMdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 08:33:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:46126 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbgFGMdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 08:33:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-129-3Cl2H1hMMBuZpucqT7Oo-w-1; Sun, 07 Jun 2020 13:31:21 +0100
X-MC-Unique: 3Cl2H1hMMBuZpucqT7Oo-w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 7 Jun 2020 13:31:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 7 Jun 2020 13:31:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Brauner' <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: RE: [PATCH v5 0/3] close_range()
Thread-Topic: [PATCH v5 0/3] close_range()
Thread-Index: AQHWOf4cmi7hnqDoI0SqM7chxviKbqjNGYBw
Date:   Sun, 7 Jun 2020 12:31:19 +0000
Message-ID: <23e3a52d52934ce2b5e640513f9f0562@AcuMS.aculab.com>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
 <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
 <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
 <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
In-Reply-To: <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
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

RnJvbTogQ2hyaXN0aWFuIEJyYXVuZXINCj4gU2VudDogMDQgSnVuZSAyMDIwIDAwOjI0DQouLg0K
PiAtc3RydWN0IGZpbGVzX3N0cnVjdCAqZHVwX2ZkKHN0cnVjdCBmaWxlc19zdHJ1Y3QgKm9sZGYs
IGludCAqZXJyb3JwKQ0KPiArc3RydWN0IGZpbGVzX3N0cnVjdCAqZHVwX2ZkKHN0cnVjdCBmaWxl
c19zdHJ1Y3QgKm9sZGYsIHVuc2lnbmVkIGludCBtYXhfZmRzLCBpbnQgKmVycm9ycCkNCg0KU2hv
dWxkbid0IHRoaXMgZ2V0IGNoYW5nZWQgdG8gdXNlIEVSUl9QVFIoKSBldGM/DQoNCi4uDQo+IC1p
bnQgX19jbG9zZV9yYW5nZShzdHJ1Y3QgZmlsZXNfc3RydWN0ICpmaWxlcywgdW5zaWduZWQgZmQs
IHVuc2lnbmVkIG1heF9mZCkNCj4gK2ludCBfX2Nsb3NlX3JhbmdlKHVuc2lnbmVkIGZkLCB1bnNp
Z25lZCBtYXhfZmQsIHVuc2lnbmVkIGludCBmbGFncykNCg0KSWYgdGhlIGxvd2VzdCBmZCB0aGF0
IGhhZCBldmVyIGhhcyBDTE9FWEVDIChvciBDTE9GT1JLKSBzZXQgd2VyZQ0KcmVtZW1iZXJlZCBh
IGZsYWcgY291bGQgYmUgcGFzc2VkIGluIHRvIHNheSAnb25seSBjbG9zZSB0aGUgZmQNCndpdGgg
Q0xPRVhFQyBzZXQnLg0KDQpHaXZlbiB0aGF0IENMT0VYRUMgaXMgYWxtb3N0IG5ldmVyIGNsZWFy
ZWQsIGFuZCBpcyB0eXBpY2FsbHkgc2V0DQpvbiBhbGwgYnV0IGEgZmV3IGZkIHRoZSAnb3B0aW1p
c2F0aW9uJyBvZiB0aGUgYml0bWFwIGlzDQpwcm9iYWJseSBhIHBlc3NpbWlzYXRpb24uDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

