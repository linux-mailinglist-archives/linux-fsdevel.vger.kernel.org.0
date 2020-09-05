Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9612F25E6E7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgIEKOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 06:14:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:41947 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgIEKOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 06:14:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-1wY7cX1qPuWY8qP59j56kw-1; Sat, 05 Sep 2020 11:13:52 +0100
X-MC-Unique: 1wY7cX1qPuWY8qP59j56kw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 5 Sep 2020 11:13:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 5 Sep 2020 11:13:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Alexey Dobriyan' <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Topic: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Index: AQHWguUCiBf1LDvZDEmt0ea9xeMo3alY9jkQgACcEACAAEEf8A==
Date:   Sat, 5 Sep 2020 10:13:51 +0000
Message-ID: <b9c82e868b7b4dbb97d2bb11de825887@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200904060024.GA2779810@gmail.com>
 <20200904175823.GA500051@localhost.localdomain>
 <63f3c9342a784a0890b3b641a71a8aa1@AcuMS.aculab.com>
 <4500d8d9-7318-4505-6086-2d2dc41f3866@csgroup.eu>
In-Reply-To: <4500d8d9-7318-4505-6086-2d2dc41f3866@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwNSBTZXB0ZW1iZXIgMjAyMCAwODoxNg0K
PiANCj4gTGUgMDQvMDkvMjAyMCDDoCAyMzowMSwgRGF2aWQgTGFpZ2h0IGEgw6ljcml0wqA6DQo+
ID4gRnJvbTogQWxleGV5IERvYnJpeWFuDQo+ID4+IFNlbnQ6IDA0IFNlcHRlbWJlciAyMDIwIDE4
OjU4DQouLi4NCj4gPiBXaGF0IGlzIHRoaXMgc3RyYW5nZSAlZnMgcmVnaXN0ZXIgeW91IGFyZSB0
YWxraW5nIGFib3V0Lg0KPiA+IEZpZ3VyZSAyLTQgb25seSBoYXMgQ1MsIERTLCBTUyBhbmQgRVMu
DQo+ID4NCj4gDQo+IEludGVsIGFkZGVkIHJlZ2lzdGVycyBGUyBhbmQgR1MgaW4gdGhlIGkzODYN
Cg0KSSBrbm93LCBJJ3ZlIGdvdCBib3RoIHRoZSAnaUFQWCAyODYgUHJvZ3JhbW1lcidzIFJlZmVy
ZW5jZSBNYW51YWwnDQphbmQgdGhlICc4MDM4NiBQcm9ncmFtbWVyJ3MgUmVmZXJlbmNlIE1hbnVh
bCcgb24gbXkgc2hlbGYuDQoNCkkgZG9uJ3QgaGF2ZSB0aGUgODA4OCBib29rIHRob3VnaCAtIHdo
aWNoIEkgdXNlZCBpbiAxOTgyLg0KDQpUaGUgb2xkIGJvb2tzIGFyZSBhIGxvdCBlYXNpZXIgdG8g
cmVhZCBpZiwgZm9yIGluc3RhbmNlLA0KeW91IGFyZSB0cnlpbmcgdG8gd29yayBvdXQgaG93IHRv
IGJhY2sgYW5kIGZvcnRoIHRvIHJlYWwgbW9kZQ0KdG8gZG8gYmlvcyBjYWxscy4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

