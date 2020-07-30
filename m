Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB02332B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgG3NJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:09:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:43216 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728328AbgG3NJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:09:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-237-OWiDeMRKNgyfXRUgU29ZSg-1; Thu, 30 Jul 2020 14:09:25 +0100
X-MC-Unique: OWiDeMRKNgyfXRUgU29ZSg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Jul 2020 14:09:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Jul 2020 14:09:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>
CC:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "LSM List" <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Subject: RE: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Topic: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Index: AQHWZQT/T+e4gDrzGEmP/30MMvDTCqkgFteg
Date:   Thu, 30 Jul 2020 13:09:24 +0000
Message-ID: <b9879beef3e740c0aeb1af73485069a8@AcuMS.aculab.com>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
In-Reply-To: <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
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

PiBUaGlzIGlzIHF1aXRlIGNsZXZlciwgYnV0IG5vdyBJ4oCZbSB3b25kZXJpbmcganVzdCBob3cg
bXVjaCBrZXJuZWwgaGVscA0KPiBpcyByZWFsbHkgbmVlZGVkLiBJbiB5b3VyIHNlcmllcywgdGhl
IHRyYW1wb2xpbmUgaXMgYW4gbm9uLWV4ZWN1dGFibGUNCj4gcGFnZS4gIEkgY2FuIHRoaW5rIG9m
IGF0IGxlYXN0IHR3byBhbHRlcm5hdGl2ZSBhcHByb2FjaGVzLCBhbmQgSSdkDQo+IGxpa2UgdG8g
a25vdyB0aGUgcHJvcyBhbmQgY29ucy4NCj4gDQo+IDEuIEVudGlyZWx5IHVzZXJzcGFjZTogYSBy
ZXR1cm4gdHJhbXBvbGluZSB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZToNCj4gDQo+IDE6DQo+IHB1
c2hxICVyYXgNCj4gcHVzaHEgJXJiYw0KPiBwdXNocSAlcmN4DQo+IC4uLg0KPiBwdXNocSAlcjE1
DQo+IG1vdnEgJXJzcCwgJXJkaSAjIHBvaW50ZXIgdG8gc2F2ZWQgcmVncw0KPiBsZWFxIDFiKCVy
aXApLCAlcnNpICMgcG9pbnRlciB0byB0aGUgdHJhbXBvbGluZSBpdHNlbGYNCj4gY2FsbHEgdHJh
bXBvbGluZV9oYW5kbGVyICMgc2VlIGJlbG93DQoNCkZvciBuZXN0ZWQgY2FsbHMgKHdoZXJlIHRo
ZSB0cmFtcG9saW5lIG5lZWRzIHRvIHBhc3MgdGhlDQpvcmlnaW5hbCBzdGFjayBmcmFtZSB0byB0
aGUgbmVzdGVkIGZ1bmN0aW9uKSBJIHRoaW5rIHlvdQ0KanVzdCBuZWVkIGEgcGFnZSBmdWxsIG9m
Og0KCW1vdgkkMCwgc2NyYXRjaF9yZWc7IGptcCB0cmFtcG9saW5lX2hhbmRsZXINCgltb3YJJDEs
IHNjcmF0Y2hfcmVnOyBqbXAgdHJhbXBvbGluZV9oYW5kbGVyDQpZb3UgbmVlZCBhbiB1bnVzZWQg
cmVnaXN0ZXIsIG9uIHg4Ni02NCBJIHRoaW5rIGJvdGgNCnIxMCBhbmQgcjExIGFyZSBhdmFpbGFi
bGUuDQpPbiBpMzg2IEkgdGhpbmsgZWF4IGNhbiBiZSB1c2VkLg0KSXQgbWlnaHQgZXZlbiBiZSB0
aGF0IHRoZSBmaXJzdCBhcmd1bWVudCByZWdpc3RlciBpcw0KYXZhaWxhYmxlIC0gaWYgdGhhdCBp
cyB1c2VkIHRvIHBhc3MgaW4gdGhlIHN0YWNrIGZyYW1lLg0KDQpUaGUgdHJhbXBvbGluZV9oYW5k
bGVyIHRoZW4gdXNlcyB0aGUgcGFzc2VkIGluIHZhbHVlDQp0byBpbmRleCBhbiBhcnJheSBvZiBz
dGFjayBmcmFtZSBhbmQgZnVuY3Rpb24gcG9pbnRlcnMNCmFuZCBqdW1wcyB0byB0aGUgcmVhbCBm
dW5jdGlvbi4NCllvdSBuZWVkIHRvIGhvbGQgZXZlcnl0aGluZyBpbiBfX3RocmVhZCBkYXRhLg0K
QW5kIG1heWJlIGJlIGFibGUgdG8gYWxsb2NhdGUgYW4gZXh0cmEgcGFnZSBmb3IgZGVlcGx5DQpu
ZXN0ZWQgY29kZSBwYXRocyAoZWcgcmVjdXJzaXZlIG5lc3RlZCBmdW5jdGlvbnMpLg0KDQpZb3Ug
bWlnaHQgdGhlbiBuZWVkIGEgZHJpdmVyIHRvIGNyZWF0ZSB5b3UgYSBzdWl0YWJsZQ0KZXhlY3V0
YWJsZSBwYWdlLiBTb21laG93IHlvdSBuZWVkIHRvIHBhc3MgaW4gdGhlIGFkZHJlc3MNCm9mIHRo
ZSB0cmFtcG9saW5lX2hhbmRsZXIgYW5kIHRoZSBudW1iZXIgZm9yIHRoZSBmaXJzdCBmYXVsdC4N
Ckl0IG5lZWQgdG8gcGFzcyBiYWNrIHRoZSAnc3RyaWRlJyBvZiB0aGUgYXJyYXkgYW5kIG51bWJl
cg0Kb2YgZWxlbWVudHMgY3JlYXRlZC4NCg0KQnV0IGlmIHlvdSBjYW4gdGFrZSB0aGUgY29zdCBv
ZiB0aGUgcGFnZSBmYXVsdCwgdGhlbg0KeW91IGNhbiBpbnRlcnByZXQgdGhlIGV4aXN0aW5nIHRy
YW1wb2xpbmUgaW4gdXNlcnNwYWNlDQp3aXRoaW4gdGhlIHNpZ25hbCBoYW5kbGVyLg0KVGhpcyBp
cyB0d28ga2VybmVsIGVudHJ5L2V4aXRzLg0KDQpBcmJpdHJhcnkgSklUIGlzIGEgZGlmZmVyZW50
IHByb2JsZW0gZW50aXJlbHkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

