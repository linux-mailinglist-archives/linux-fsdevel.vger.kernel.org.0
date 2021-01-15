Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78182F888F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbhAOWl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:41:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:34195 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbhAOWl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:41:27 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-8-lXDDyAc-MTCPOuhWUXC4Tg-1;
 Fri, 15 Jan 2021 22:39:47 +0000
X-MC-Unique: lXDDyAc-MTCPOuhWUXC4Tg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 15 Jan 2021 22:39:44 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 15 Jan 2021 22:39:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>
CC:     "sonicadvance1@gmail.com" <sonicadvance1@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Rientjes <rientjes@google.com>,
        "Willem de Bruijn" <willemb@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Oleg Nesterov" <oleg@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jan Kara <jack@suse.cz>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Thread-Topic: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Thread-Index: AQHW6wzXd1V6Thk8U0iiUgMFo8hTJqopEBwAgAAyHoCAAARq4A==
Date:   Fri, 15 Jan 2021 22:39:44 +0000
Message-ID: <313c380c4b1b477fbd09aac66eed4505@AcuMS.aculab.com>
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <20210115070326.294332-1-Sonicadvance1@gmail.com>
 <b15672b1caec4cf980f2753d06b03596@AcuMS.aculab.com>
 <CAK8P3a1gqt-gBCPTdNeY+8SaG8eUGN4zkCrNKSjA=aEL-TkaUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1gqt-gBCPTdNeY+8SaG8eUGN4zkCrNKSjA=aEL-TkaUQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Li4uDQo+IEhlJ3MgYWxyZWFkeSBkb2luZyB0aGUgc3lzdGVtIGNhbGwgZW11bGF0aW9uIGZvciBh
bGwgdGhlIHN5c3RlbQ0KPiBjYWxscyBvdGhlciB0aGFuIGlvY3RsIGluIHVzZXIgc3BhY2UgdGhv
dWdoLiBJbiBteSBleHBlcmllbmNlLA0KPiB0aGVyZSBhcmUgYWN0dWFsbHkgZmFpcmx5IGZldyBp
b2N0bCBjb21tYW5kcyB0aGF0IGFyZSBkaWZmZXJlbnQNCj4gYmV0d2VlbiBhcmNoaXRlY3R1cmVz
IC0tIG1vc3Qgb2YgdGhlbSBoYXZlIG5vIG1pc2FsaWduZWQNCj4gb3IgYXJjaGl0ZWN0dXJlLWRl
ZmluZWQgc3RydWN0IG1lbWJlcnMgYXQgYWxsLg0KDQpBcmVuJ3QgdGhlcmUgYWxzbyBzb21lIGlu
dHJhY3RhYmxlIGlzc3VlcyB3aXRoIHNvY2tldCBvcHRpb25zPw0KSUlSQyB0aGUga2VybmVsIGNv
ZGUgdGhhdCB0cmllZCB0byBjaGFuZ2UgdGhlbSB0byA2NGJpdCB3YXMNCmhvcnJpYmx5IGJyb2tl
biBpbiBzb21lIG9ic2N1cmUgY2FzZXMuDQoNClB1c2hpbmcgdGhlIGNvbnZlcnNpb24gZG93biB0
aGUgc3RhY2sgbm90IG9ubHkgaWRlbnRpZmllZCB0aGUNCmlzc3VlcywgaXQgYWxzbyBtYWRlIHRo
ZW0gZWFzaWVyIHRvIGZpeC4NCg0KSWYgeW91IGNoYW5nZSB0aGUga2VybmVsIHNvIGEgNjRiaXQg
cHJvY2VzcyBjYW4gZXhlY3V0ZSAzMmJpdA0Kc3lzdGVtIGNhbGxzIHRoZW4gYSBsb3Qgb2YgdGhl
IHByb2JsZW1zIGRvIGdvIGF3YXkuDQpUaGlzIGlzIHByb2JhYmx5IGVhc2llc3QgZG9uZSBieSBz
ZXR0aW5nIGEgaGlnaCBiaXQgb24gdGhlDQpzeXN0ZW0gY2FsbCBudW1iZXIgLSBhcyB4ODZfNjQg
ZG9lcyBmb3IgeDMyIGNhbGxzLg0KDQpZb3Ugc3RpbGwgaGF2ZSB0byBzb2x2ZSB0aGUgZGlmZmVy
ZW50IGFsaWdubWVudCBvZiA2NGJpdCBkYXRhDQpvbiBpMzg2Lg0KDQpPZiBjb3Vyc2UgdGhlIHN5
c3RlbSBjYWxsIG51bWJlcnMgYXJlIGRpZmZlcmVudCAtIGJ1dCB0aGF0IGlzDQpqdXN0IGEgbG9v
a3VwLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

