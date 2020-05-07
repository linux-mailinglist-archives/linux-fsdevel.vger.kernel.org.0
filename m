Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736411C8446
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgEGIFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 04:05:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25015 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725964AbgEGIFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 04:05:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-222-zMK3yQ5kPIe6BMT91EbWpA-1; Thu, 07 May 2020 09:05:05 +0100
X-MC-Unique: zMK3yQ5kPIe6BMT91EbWpA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 7 May 2020 09:05:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 May 2020 09:05:04 +0100
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
Thread-Index: AQHWIvJxeV/0BLZ+8kuLT1dTVkm+SqicRhNg
Date:   Thu, 7 May 2020 08:05:04 +0000
Message-ID: <20b24b9ca0a64afb9389722845738ec8@AcuMS.aculab.com>
References: <20200505153156.925111-1-mic@digikod.net>
In-Reply-To: <20200505153156.925111-1-mic@digikod.net>
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

RnJvbTogTWlja2HDq2wgU2FsYcO8bg0KPiBTZW50OiAwNSBNYXkgMjAyMCAxNjozMg0KPiANCj4g
VGhpcyBmaWZ0aCBwYXRjaCBzZXJpZXMgYWRkIG5ldyBrZXJuZWwgY29uZmlndXJhdGlvbnMgKE9N
QVlFWEVDX1NUQVRJQywNCj4gT01BWUVYRUNfRU5GT1JDRV9NT1VOVCwgYW5kIE9NQVlFWEVDX0VO
Rk9SQ0VfRklMRSkgdG8gZW5hYmxlIHRvDQo+IGNvbmZpZ3VyZSB0aGUgc2VjdXJpdHkgcG9saWN5
IGF0IGtlcm5lbCBidWlsZCB0aW1lLiAgQXMgcmVxdWVzdGVkIGJ5DQo+IE1pbWkgWm9oYXIsIEkg
Y29tcGxldGVkIHRoZSBzZXJpZXMgd2l0aCBvbmUgb2YgaGVyIHBhdGNoZXMgZm9yIElNQS4NCj4g
DQo+IFRoZSBnb2FsIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIGlzIHRvIGVuYWJsZSB0byBjb250cm9s
IHNjcmlwdCBleGVjdXRpb24NCj4gd2l0aCBpbnRlcnByZXRlcnMgaGVscC4gIEEgbmV3IE9fTUFZ
RVhFQyBmbGFnLCB1c2FibGUgdGhyb3VnaA0KPiBvcGVuYXQyKDIpLCBpcyBhZGRlZCB0byBlbmFi
bGUgdXNlcnNwYWNlIHNjcmlwdCBpbnRlcnByZXRlciB0byBkZWxlZ2F0ZQ0KPiB0byB0aGUga2Vy
bmVsIChhbmQgdGh1cyB0aGUgc3lzdGVtIHNlY3VyaXR5IHBvbGljeSkgdGhlIHBlcm1pc3Npb24g
dG8NCj4gaW50ZXJwcmV0L2V4ZWN1dGUgc2NyaXB0cyBvciBvdGhlciBmaWxlcyBjb250YWluaW5n
IHdoYXQgY2FuIGJlIHNlZW4gYXMNCj4gY29tbWFuZHMuDQo+IA0KPiBBIHNpbXBsZSBzeXN0ZW0t
d2lkZSBzZWN1cml0eSBwb2xpY3kgY2FuIGJlIGVuZm9yY2VkIGJ5IHRoZSBzeXN0ZW0NCj4gYWRt
aW5pc3RyYXRvciB0aHJvdWdoIGEgc3lzY3RsIGNvbmZpZ3VyYXRpb24gY29uc2lzdGVudCB3aXRo
IHRoZSBtb3VudA0KPiBwb2ludHMgb3IgdGhlIGZpbGUgYWNjZXNzIHJpZ2h0cy4gIFRoZSBkb2N1
bWVudGF0aW9uIHBhdGNoIGV4cGxhaW5zIHRoZQ0KPiBwcmVyZXF1aXNpdGVzLg0KPiANCj4gRnVy
dGhlcm1vcmUsIHRoZSBzZWN1cml0eSBwb2xpY3kgY2FuIGFsc28gYmUgZGVsZWdhdGVkIHRvIGFu
IExTTSwgZWl0aGVyDQo+IGEgTUFDIHN5c3RlbSBvciBhbiBpbnRlZ3JpdHkgc3lzdGVtLiAgRm9y
IGluc3RhbmNlLCB0aGUgbmV3IGtlcm5lbA0KPiBNQVlfT1BFTkVYRUMgZmxhZyBjbG9zZXMgYSBt
YWpvciBJTUEgbWVhc3VyZW1lbnQvYXBwcmFpc2FsIGludGVycHJldGVyDQo+IGludGVncml0eSBn
YXAgYnkgYnJpbmdpbmcgdGhlIGFiaWxpdHkgdG8gY2hlY2sgdGhlIHVzZSBvZiBzY3JpcHRzIFsx
XS4NCj4gT3RoZXIgdXNlcyBhcmUgZXhwZWN0ZWQsIHN1Y2ggYXMgZm9yIG9wZW5hdDIoMikgWzJd
LCBTR1ggaW50ZWdyYXRpb24NCj4gWzNdLCBicGZmcyBbNF0gb3IgSVBFIFs1XS4NCj4gDQo+IFVz
ZXJzcGFjZSBuZWVkcyB0byBhZGFwdCB0byB0YWtlIGFkdmFudGFnZSBvZiB0aGlzIG5ldyBmZWF0
dXJlLiAgRm9yDQo+IGV4YW1wbGUsIHRoZSBQRVAgNTc4IFs2XSAoUnVudGltZSBBdWRpdCBIb29r
cykgZW5hYmxlcyBQeXRob24gMy44IHRvIGJlDQo+IGV4dGVuZGVkIHdpdGggcG9saWN5IGVuZm9y
Y2VtZW50IHBvaW50cyByZWxhdGVkIHRvIGNvZGUgaW50ZXJwcmV0YXRpb24sDQo+IHdoaWNoIGNh
biBiZSB1c2VkIHRvIGFsaWduIHdpdGggdGhlIFBvd2VyU2hlbGwgYXVkaXQgZmVhdHVyZXMuDQo+
IEFkZGl0aW9uYWwgUHl0aG9uIHNlY3VyaXR5IGltcHJvdmVtZW50cyAoZS5nLiBhIGxpbWl0ZWQg
aW50ZXJwcmV0ZXINCj4gd2l0aG91IC1jLCBzdGRpbiBwaXBpbmcgb2YgY29kZSkgYXJlIG9uIHRo
ZWlyIHdheS4NCj4gDQo+IFRoZSBpbml0aWFsIGlkZWEgY29tZSBmcm9tIENMSVAgT1MgNCBhbmQg
dGhlIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIGhhcw0KPiBiZWVuIHVzZWQgZm9yIG1vcmUgdGhh
biAxMiB5ZWFyczoNCj4gaHR0cHM6Ly9naXRodWIuY29tL2NsaXBvcy1hcmNoaXZlL2NsaXBvczRf
ZG9jDQo+IA0KPiBBbiBpbnRyb2R1Y3Rpb24gdG8gT19NQVlFWEVDIHdhcyBnaXZlbiBhdCB0aGUg
TGludXggU2VjdXJpdHkgU3VtbWl0DQo+IEV1cm9wZSAyMDE4IC0gTGludXggS2VybmVsIFNlY3Vy
aXR5IENvbnRyaWJ1dGlvbnMgYnkgQU5TU0k6DQo+IGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dh
dGNoP3Y9Y2hOakNSdFBLUVkmdD0xN20xNXMNCj4gVGhlICJ3cml0ZSB4b3IgZXhlY3V0ZSIgcHJp
bmNpcGxlIHdhcyBleHBsYWluZWQgYXQgS2VybmVsIFJlY2lwZXMgMjAxOCAtDQo+IENMSVAgT1M6
IGEgZGVmZW5zZS1pbi1kZXB0aCBPUzoNCj4gaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/
dj1QalJFMHVCdGtIVSZ0PTExbTE0cw0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgY2FuIGJlIGFw
cGxpZWQgb24gdG9wIG9mIHY1LjctcmM0LiAgVGhpcyBjYW4gYmUgdGVzdGVkDQo+IHdpdGggQ09O
RklHX1NZU0NUTC4gIEkgd291bGQgcmVhbGx5IGFwcHJlY2lhdGUgY29uc3RydWN0aXZlIGNvbW1l
bnRzIG9uDQo+IHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpOb25lIG9mIHRoYXQgZGVzY3JpcHRpb24g
YWN0dWFsbHkgc2F5cyB3aGF0IHRoZSBwYXRjaCBhY3R1YWxseSBkb2VzLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

