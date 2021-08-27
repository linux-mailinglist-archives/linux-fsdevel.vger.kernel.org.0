Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1D3F95F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbhH0IXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 04:23:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33647 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233157AbhH0IXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:23:02 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-9-YAcLez3-PIu1MFGqx63a2w-1;
 Fri, 27 Aug 2021 09:22:11 +0100
X-MC-Unique: YAcLez3-PIu1MFGqx63a2w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 27 Aug 2021 09:22:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 27 Aug 2021 09:22:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: RE: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Thread-Topic: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Thread-Index: AQHXmsfEnhLiH4wkgUCh4gMa99+VE6uHAcKg
Date:   Fri, 27 Aug 2021 08:22:07 +0000
Message-ID: <04e61e79ebad4a5d872d0a2b5be4c23d@AcuMS.aculab.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
        <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
        <87lf56bllc.fsf@disp2133>
        <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
        <87eeay8pqx.fsf@disp2133>       <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
        <87h7ft2j68.fsf@disp2133>
        <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
        <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
        <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
        <b60e9bd1-7232-472d-9c9c-1d6593e9e85e@www.fastmail.com>
        <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com> <87mtp3g8gv.fsf@disp2133>
In-Reply-To: <87mtp3g8gv.fsf@disp2133>
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

RnJvbTogRXJpYyBXLiBCaWVkZXJtYW4NCj4gU2VudDogMjYgQXVndXN0IDIwMjEgMjM6MTQNCi4u
Lg0KPiBJIGFsc28gcmFuIGludG8gdGhpcyBpc3N1ZSBub3QgdG9vIGxvbmcgYWdvIHdoZW4gSSBy
ZWZhY3RvcmVkIHRoZQ0KPiB1c2VybW9kZV9kcml2ZXIgY29kZS4gIE15IGNoYWxsZW5nZSB3YXMg
bm90IGJlaW5nIGluIHVzZXJzcGFjZQ0KPiB0aGUgZGVsYXllZCBmcHV0IHdhcyBub3QgaGFwcGVu
aW5nIGluIG15IGtlcm5lbCB0aHJlYWQuICBXaGljaCBtZWFudA0KPiB0aGF0IHdyaXRpbmcgdGhl
IGZpbGUsIHRoZW4gY2xvc2luZyB0aGUgZmlsZSwgdGhlbiBleGVjaW5nIHRoZSBmaWxlDQo+IGNv
bnNpc3RlbnRseSByZXBvcnRlZCAtRVRYVEJTWS4NCj4gDQo+IFRoZSBrZXJuZWwgY29kZSB3b3Vu
ZCB1cCBkb2luZzoNCj4gCS8qIEZsdXNoIGRlbGF5ZWQgZnB1dCBzbyBleGVjIGNhbiBvcGVuIHRo
ZSBmaWxlIHJlYWQtb25seSAqLw0KPiAJZmx1c2hfZGVsYXllZF9mcHV0KCk7DQo+IAl0YXNrX3dv
cmtfcnVuKCk7DQo+IA0KPiBBcyBJIHJlYWQgdGhlIGNvZGUgdGhlIGRlbGF5IGZvciB1c2Vyc3Bh
Y2UgZmlsZSBkZXNjcmlwdG9ycyBpcw0KPiBhbHdheXMgZG9uZSB3aXRoIHRhc2tfd29ya19hZGQs
IHNvIHVzZXJzcGFjZSBzaG91bGQgbm90IGhpdA0KPiB0aGF0IGtpbmQgb2Ygc2lsbGluZXNzLCBh
bmQgc2hvdWxkIGJlIGFibGUgdG8gYWN0dWFsbHkgY2xvc2UNCj4gdGhlIGZpbGUgZGVzY3JpcHRv
ciBiZWZvcmUgdGhlIGV4ZWMuDQoNCklmIHRhc2tfd29ya19hZGQgZW5kcyB1cCBhZGRpbmcgaXQg
dG8gYSB0YXNrIHRoYXQgaXMgYWxyZWFkeQ0KcnVubmluZyBvbiBhIGRpZmZlcmVudCBjcHUsIGFu
ZCB0aGF0IGNwdSB0YWtlcyBhIGhhcmR3YXJlDQppbnRlcnJ1cHQgdGhhdCB0YWtlcyBzb21lIHRp
bWUgYW5kL29yIHNjaGVkdWxlcyB0aGUgc29mdGludA0KY29kZSB0byBydW4gaW1tZWRpYXRlbHkg
dGhlIGhhcmR3YXJlIGludGVycnVwdCBjb21wbGV0ZXMNCnRoZW4gaXQgbWF5IHdlbGwgYmUgcG9z
c2libGUgZm9yIHVzZXJzcGFjZSB0byBoYXZlICdpc3N1ZXMnLg0KDQpBbnkgZmxhZ3MgYXNzb2Np
YXRlZCB3aXRoIE9fREVOWV9XUklURSB3b3VsZCBuZWVkIHRvIGJlIGNsZWFyZWQNCnN5bmNocm9u
b3VzbHkgaW4gdGhlIGNsb3NlKCkgcmF0aGVyIHRoZW4gaW4gYW55IGRlbGF5ZWQgZnB1dCgpLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

