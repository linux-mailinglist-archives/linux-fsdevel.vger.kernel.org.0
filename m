Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC025E328
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgIDVBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 17:01:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27881 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbgIDVBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:01:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-259-YWysdasQNmmHPaKEedcGPw-1; Fri, 04 Sep 2020 22:01:07 +0100
X-MC-Unique: YWysdasQNmmHPaKEedcGPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 4 Sep 2020 22:01:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 4 Sep 2020 22:01:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Topic: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Index: AQHWguUCiBf1LDvZDEmt0ea9xeMo3alY9jkQ
Date:   Fri, 4 Sep 2020 21:01:06 +0000
Message-ID: <63f3c9342a784a0890b3b641a71a8aa1@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200904060024.GA2779810@gmail.com>
 <20200904175823.GA500051@localhost.localdomain>
In-Reply-To: <20200904175823.GA500051@localhost.localdomain>
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

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDA0IFNlcHRlbWJlciAyMDIwIDE4OjU4DQo+
IA0KPiBPbiBGcmksIFNlcCAwNCwgMjAyMCBhdCAwODowMDoyNEFNICswMjAwLCBJbmdvIE1vbG5h
ciB3cm90ZToNCj4gPiAqIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90ZToNCj4g
PiA+IHRoaXMgc2VyaWVzIHJlbW92ZXMgdGhlIGxhc3Qgc2V0X2ZzKCkgdXNlZCB0byBmb3JjZSBh
IGtlcm5lbCBhZGRyZXNzDQo+ID4gPiBzcGFjZSBmb3IgdGhlIHVhY2Nlc3MgY29kZSBpbiB0aGUg
a2VybmVsIHJlYWQvd3JpdGUvc3BsaWNlIGNvZGUsIGFuZCB0aGVuDQo+ID4gPiBzdG9wcyBpbXBs
ZW1lbnRpbmcgdGhlIGFkZHJlc3Mgc3BhY2Ugb3ZlcnJpZGVzIGVudGlyZWx5IGZvciB4ODYgYW5k
DQo+ID4gPiBwb3dlcnBjLg0KPiA+DQo+ID4gQ29vbCEgRm9yIHRoZSB4ODYgYml0czoNCj4gPg0K
PiA+ICAgQWNrZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiANCj4gc2V0
X2ZzKCkgaXMgb2xkZXIgdGhhbiBzb21lIGtlcm5lbCBoYWNrZXJzIQ0KPiANCj4gCSQgY2QgbGlu
dXgtMC4xMS8NCj4gCSQgZmluZCAuIC10eXBlIGYgLW5hbWUgJyouaCcgfCB4YXJncyBncmVwIC1l
IHNldF9mcyAtdyAtbiAtQTMNCj4gCS4vaW5jbHVkZS9hc20vc2VnbWVudC5oOjYxOmV4dGVybiBp
bmxpbmUgdm9pZCBzZXRfZnModW5zaWduZWQgbG9uZyB2YWwpDQo+IAkuL2luY2x1ZGUvYXNtL3Nl
Z21lbnQuaC02Mi17DQo+IAkuL2luY2x1ZGUvYXNtL3NlZ21lbnQuaC02My0gICAgIF9fYXNtX18o
Im1vdiAlMCwlJWZzIjo6ImEiICgodW5zaWduZWQgc2hvcnQpIHZhbCkpOw0KPiAJLi9pbmNsdWRl
L2FzbS9zZWdtZW50LmgtNjQtfQ0KDQpXaGF0IGlzIHRoaXMgc3RyYW5nZSAlZnMgcmVnaXN0ZXIg
eW91IGFyZSB0YWxraW5nIGFib3V0Lg0KRmlndXJlIDItNCBvbmx5IGhhcyBDUywgRFMsIFNTIGFu
ZCBFUy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

