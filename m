Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390DD1C8607
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGJoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 05:44:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26453 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbgEGJoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 05:44:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-224-NnifUXbxOzWpb5XrCVK4yA-1; Thu, 07 May 2020 10:44:19 +0100
X-MC-Unique: NnifUXbxOzWpb5XrCVK4yA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 7 May 2020 10:44:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 May 2020 10:44:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J01pY2thw6tsIFNhbGHDvG4n?= <mic@digikod.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "Christian Heimes" <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Deven Bowers" <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Lakshmi Ramasubramanian" <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?utf-8?B?UGhpbGlwcGUgVHLDqWJ1Y2hldA==?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v5 0/6] Add support for O_MAYEXEC
Thread-Topic: [PATCH v5 0/6] Add support for O_MAYEXEC
Thread-Index: AQHWIvJxeV/0BLZ+8kuLT1dTVkm+SqicRhNg///4h4CAABSTQP//+lUAgAAR6XA=
Date:   Thu, 7 May 2020 09:44:18 +0000
Message-ID: <635df0655b644408ac4822def8900383@AcuMS.aculab.com>
References: <20200505153156.925111-1-mic@digikod.net>
 <20b24b9ca0a64afb9389722845738ec8@AcuMS.aculab.com>
 <907109c8-9b19-528a-726f-92c3f61c1563@digikod.net>
 <ad28ab5fe7854b41a575656e95b4da17@AcuMS.aculab.com>
 <64426377-7fc4-6f37-7371-2e2a584e3032@digikod.net>
In-Reply-To: <64426377-7fc4-6f37-7371-2e2a584e3032@digikod.net>
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

RnJvbTogTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lrb2QubmV0Pg0KPiBTZW50OiAwNyBNYXkg
MjAyMCAxMDozMA0KPiBPbiAwNy8wNS8yMDIwIDExOjAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
ID4gRnJvbTogTWlja2HDq2wgU2FsYcO8bg0KPiA+PiBTZW50OiAwNyBNYXkgMjAyMCAwOTozNw0K
PiA+IC4uLg0KPiA+Pj4gTm9uZSBvZiB0aGF0IGRlc2NyaXB0aW9uIGFjdHVhbGx5IHNheXMgd2hh
dCB0aGUgcGF0Y2ggYWN0dWFsbHkgZG9lcy4NCj4gPj4NCj4gPj4gIkFkZCBzdXBwb3J0IGZvciBP
X01BWUVYRUMiICJ0byBlbmFibGUgdG8gY29udHJvbCBzY3JpcHQgZXhlY3V0aW9uIi4NCj4gPj4g
V2hhdCBpcyBub3QgY2xlYXIgaGVyZT8gVGhpcyBzZWVtcyB3ZWxsIHVuZGVyc3Rvb2QgYnkgb3Ro
ZXIgY29tbWVudGVycy4NCj4gPj4gVGhlIGRvY3VtZW50YXRpb24gcGF0Y2ggYW5kIHRoZSB0YWxr
cyBjYW4gYWxzbyBoZWxwLg0KPiA+DQo+ID4gSSdtIGd1ZXNzaW5nIHRoYXQgcGFzc2luZyBPX01B
WUVYRUMgdG8gb3BlbigpIHJlcXVlc3RzIHRoZSBrZXJuZWwNCj4gPiBjaGVjayBmb3IgZXhlY3V0
ZSAneCcgcGVybWlzc2lvbnMgKGFzIHdlbGwgYXMgcmVhZCkuDQo+IA0KPiBZZXMsIGJ1dCBvbmx5
IHdpdGggb3BlbmF0MigpLg0KDQpJdCBjYW4ndCBtYXR0ZXIgaWYgdGhlIGZsYWcgaXMgaWdub3Jl
ZC4NCkl0IGp1c3QgbWVhbnMgdGhlIGtlcm5lbCBpc24ndCBlbmZvcmNpbmcgdGhlIHBvbGljeS4N
CklmIG9wZW5hdDIoKSBmYWlsIGJlY2F1c2UgdGhlIGZsYWcgaXMgdW5zdXBwb3J0ZWQgdGhlbg0K
dGhlIGFwcGxpY2F0aW9uIHdpbGwgbmVlZCB0byByZXRyeSB3aXRob3V0IHRoZSBmbGFnLg0KDQpT
byBpZiB0aGUgdXNlciBoYXMgYW55IGFiaWxpdHkgY3JlYXRlIGV4ZWN1dGFibGUgZmlsZXMgdGhp
cw0KaXMgYWxsIHBvaW50bGVzcyAoZnJvbSBhIHNlY3VyaXR5IHBvaW50IG9mIHZpZXcpLg0KVGhl
IHVzZXIgY2FuIGVpdGhlciBjb3B5IHRoZSBmaWxlIG9yIGNvcHkgaW4gYW4gaW50ZXJwcmV0ZXIN
CnRoYXQgZG9lc24ndCByZXF1ZXN0IE9fTUFZRVhFQy4NCg0KSXQgbWlnaHQgc3RvcCBhY2NpZGVu
dGFsIGlzc3VlcywgYnV0IG5vdGhpbmcgbWFsaWNpb3VzLg0KDQo+ID4gVGhlbiBrZXJuZWwgcG9s
aWN5IGRldGVybWluZXMgd2hldGhlciAncmVhZCcgYWNjZXNzIGlzIGFjdHVhbGx5IGVub3VnaCwN
Cj4gPiBvciB3aGV0aGVyICd4JyBhY2Nlc3MgKHBvc3NpYmx5IG1hc2tlZCBieSBtb3VudCBwZXJt
aXNzaW9ucykgaXMgbmVlZGVkLg0KPiA+DQo+ID4gSWYgdGhhdCBpcyB0cnVlLCB0d28gbGluZXMg
c2F5IHdoYXQgaXMgZG9lcy4NCj4gDQo+IFRoZSAiQSBzaW1wbGUgc3lzdGVtLXdpZGUgc2VjdXJp
dHkgcG9saWN5IiBwYXJhZ3JhcGggaW50cm9kdWNlIHRoYXQsIGJ1dA0KPiBJJ2xsIGhpZ2hsaWdo
dCBpdCBpbiB0aGUgbmV4dCBjb3ZlciBsZXR0ZXIuDQoNCk5vIGl0IGRvZXNuJ3QuDQpJdCBqdXN0
IHNheXMgdGhlcmUgaXMgc29tZSBraW5kIG9mIHBvbGljeSB0aGF0IHNvbWUgZmxhZ3MgY2hhbmdl
Lg0KSXQgZG9lc24ndCBzYXkgd2hhdCBpcyBiZWluZyBjaGVja2VkIGZvci4NCg0KPiBUaGUgbW9z
dCBpbXBvcnRhbnQgcG9pbnQgaXMNCj4gdG8gdW5kZXJzdGFuZCB3aHkgaXQgaXMgcmVxdWlyZWQs
IGJlZm9yZSBnZXR0aW5nIHRvIGhvdyBpdCB3aWxsIGJlDQo+IGltcGxlbWVudGVkLg0KDQpCdXQg
eW91IGRvbid0IHNheSB3aGF0IGlzIHJlcXVpcmVkLg0KSnVzdCBhIGxvYWQgb2YgYnV6endvcmQg
cmFtYmxpbmdzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

