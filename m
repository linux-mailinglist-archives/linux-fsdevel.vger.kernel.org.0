Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5B283A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfEWQ3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:29:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55853 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731037AbfEWQ3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:29:47 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-124-k_tmI2M6OK6o6fWSJ4SZFw-1; Thu, 23 May 2019 17:29:45 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 May 2019 17:29:44 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 May 2019 17:29:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Konstantin Khlebnikov' <khlebnikov@yandex-team.ru>,
        Christian Brauner <christian@brauner.io>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v1 1/2] open: add close_range()
Thread-Topic: [PATCH v1 1/2] open: add close_range()
Thread-Index: AQHVEYO6ZYKDwRYmH0ewnJkZ6B6UzqZ45dMA
Date:   Thu, 23 May 2019 16:29:44 +0000
Message-ID: <5e57c26cb7044b69acd3846ac474b5d5@AcuMS.aculab.com>
References: <20190522155259.11174-1-christian@brauner.io>
 <67e4458a-9cc4-d1aa-608c-73ebe9e2f7a3@yandex-team.ru>
In-Reply-To: <67e4458a-9cc4-d1aa-608c-73ebe9e2f7a3@yandex-team.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: k_tmI2M6OK6o6fWSJ4SZFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogIEtvbnN0YW50aW4gS2hsZWJuaWtvdg0KPiBTZW50OiAyMyBNYXkgMjAxOSAxNzoyMg0K
Li4uLg0KPiAgPiBJbiBhZGRpdGlvbiwgdGhlIHN5c2NhbGwgd2lsbCBhbHNvIHdvcmsgZm9yIHRh
c2tzIHRoYXQgZG8gbm90IGhhdmUgcHJvY2ZzDQo+ICA+IG1vdW50ZWQgYW5kIG9uIGtlcm5lbHMg
dGhhdCBkbyBub3QgaGF2ZSBwcm9jZnMgc3VwcG9ydCBjb21waWxlZCBpbi4gSW4gc3VjaA0KPiAg
PiBzaXR1YXRpb25zIHRoZSBvbmx5IHdheSB0byBtYWtlIHN1cmUgdGhhdCBhbGwgZmlsZSBkZXNj
cmlwdG9ycyBhcmUgY2xvc2VkDQo+ICA+IGlzIHRvIGNhbGwgY2xvc2UoKSBvbiBlYWNoIGZpbGUg
ZGVzY3JpcHRvciB1cCB0byBVSU5UX01BWCBvciBSTElNSVRfTk9GSUxFLA0KPiAgPiBPUEVOX01B
WCB0cmlja2VyeSAoY2YuIGNvbW1lbnQgWzhdIG9uIFJ1c3QpLg0KDQpDb2RlIHVzaW5nIFJMSU1J
VF9OT0ZJTEUgaXMgYnJva2VuLg0KSXQgaXMgZWFzeSB0byByZWR1Y2UgdGhlIGhhcmQgbGltaXQg
YmVsb3cgdGhhdCBvZiBhbiBvcGVuIGZkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

