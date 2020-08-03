Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25523AB0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHCQ5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:57:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:50758 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgHCQ5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:57:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-167-AfxWu5hnN66AhufCIfqZ2Q-1; Mon, 03 Aug 2020 17:57:48 +0100
X-MC-Unique: AfxWu5hnN66AhufCIfqZ2Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 3 Aug 2020 17:57:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 3 Aug 2020 17:57:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Madhavan T. Venkataraman'" <madvenka@linux.microsoft.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "LSM List" <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Subject: RE: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Topic: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Index: AQHWZ2jYT+e4gDrzGEmP/30MMvDTCqkmD9qggABvyICAAB4gEA==
Date:   Mon, 3 Aug 2020 16:57:47 +0000
Message-ID: <f87f84e466a041fbabd2bba84f4592a5@AcuMS.aculab.com>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
 <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
 <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
 <20200731183146.GD67415@C02TD0UTHF1T.local>
 <a3068e3126a942c7a3e7ac115499deb1@AcuMS.aculab.com>
 <7fdc102e-75ea-6d91-d2a3-7fe8c91802ce@linux.microsoft.com>
In-Reply-To: <7fdc102e-75ea-6d91-d2a3-7fe8c91802ce@linux.microsoft.com>
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

RnJvbTogTWFkaGF2YW4gVC4gVmVua2F0YXJhbWFuDQo+IFNlbnQ6IDAzIEF1Z3VzdCAyMDIwIDE3
OjAzDQo+IA0KPiBPbiA4LzMvMjAgMzoyNyBBTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZy
b206IE1hcmsgUnV0bGFuZA0KPiA+PiBTZW50OiAzMSBKdWx5IDIwMjAgMTk6MzINCj4gPiAuLi4N
Cj4gPj4+IEl0IHJlcXVpcmVzIFBDLXJlbGF0aXZlIGRhdGEgcmVmZXJlbmNlcy4gSSBoYXZlIG5v
dCB3b3JrZWQgb24gYWxsIGFyY2hpdGVjdHVyZXMuDQo+ID4+PiBTbywgSSBuZWVkIHRvIHN0dWR5
IHRoaXMuIEJ1dCBkbyBhbGwgSVNBcyBzdXBwb3J0IFBDLXJlbGF0aXZlIGRhdGEgcmVmZXJlbmNl
cz8NCj4gPj4gTm90IGFsbCBkbywgYnV0IHByZXR0eSBtdWNoIGFueSByZWNlbnQgSVNBIHdpbGwg
YXMgaXQncyBhIHByYWN0aWNhbA0KPiA+PiBuZWNlc3NpdHkgZm9yIGZhc3QgcG9zaXRpb24taW5k
ZXBlbmRlbnQgY29kZS4NCj4gPiBpMzg2IGhhcyBuZWl0aGVyIFBDLXJlbGF0aXZlIGFkZHJlc3Np
bmcgbm9yIG1vdmVzIGZyb20gJXBjLg0KPiA+IFRoZSBjcHUgYXJjaGl0ZWN0dXJlIGtub3dzIHRo
YXQgdGhlIHNlcXVlbmNlOg0KPiA+IAljYWxsCTFmDQo+ID4gMToJcG9wCSVyZWcNCj4gPiBpcyB1
c2VkIHRvIGdldCB0aGUgJXBjIHZhbHVlIHNvIGlzIHRyZWF0ZWQgc3BlY2lhbGx5IHNvIHRoYXQN
Cj4gPiBpdCBkb2Vzbid0ICd0cmFzaCcgdGhlIHJldHVybiBzdGFjay4NCj4gPg0KPiA+IFNvIFBJ
QyBjb2RlIGlzbid0IHRvbyBiYWQsIGJ1dCB5b3UgaGF2ZSB0byB1c2UgdGhlIGNvcnJlY3QNCj4g
PiBzZXF1ZW5jZS4NCj4gDQo+IElzIHRoYXQgdHJ1ZSBvbmx5IGZvciAzMi1iaXQgc3lzdGVtcyBv
bmx5PyBJIHRob3VnaHQgUklQLXJlbGF0aXZlIGFkZHJlc3Npbmcgd2FzDQo+IGludHJvZHVjZWQg
aW4gNjQtYml0IG1vZGUuIFBsZWFzZSBjb25maXJtLg0KDQpJIHNhaWQgaTM4NiBub3QgYW1kNjQg
b3IgeDg2LTY0Lg0KDQpTbyB5ZXMsIDY0Yml0IGNvZGUgaGFzIFBDLXJlbGF0aXZlIGFkZHJlc3Np
bmcuDQpCdXQgSSdtIHByZXR0eSBzdXJlIGl0IGhhcyBubyBvdGhlciB3YXkgdG8gZ2V0IHRoZSBQ
QyBpdHNlbGYNCmV4Y2VwdCB1c2luZyBjYWxsIC0gY2VydGFpbmx5IG5vdGhpbmcgaW4gdGhlICd1
c3VhbCcgaW5zdHJ1Y3Rpb25zLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

