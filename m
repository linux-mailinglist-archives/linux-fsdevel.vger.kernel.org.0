Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A768F3F286C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHTIbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:31:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:47591 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbhHTIbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:31:21 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-274-2Q2jLTjjOQuEz4g5fh9Tsg-1; Fri, 20 Aug 2021 09:30:42 +0100
X-MC-Unique: 2Q2jLTjjOQuEz4g5fh9Tsg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 09:30:39 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 20 Aug 2021 09:30:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Hildenbrand <david@redhat.com>,
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
        Huang Ying <ying.huang@intel.com>,
        "Jann Horn" <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
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
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: RE: Removing Mandatory Locks
Thread-Topic: Removing Mandatory Locks
Thread-Index: AQHXlUolKQrpfCPkWUimXalbi9gnr6t8D3Ag
Date:   Fri, 20 Aug 2021 08:30:39 +0000
Message-ID: <ec075ee5764f4c7f9dd630090fb01f70@AcuMS.aculab.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <YRcyqbpVqwwq3P6n@casper.infradead.org> <87k0kkxbjn.fsf_-_@disp2133>
 <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
 <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
 <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
 <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
 <639d90212662cf5cdf80c71bbfec95907c70114a.camel@kernel.org>
 <CAHk-=wgHbYmUZvFkthGJ6zZx+ofTiiTRxPai5mPkmbtE=6JbaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgHbYmUZvFkthGJ6zZx+ofTiiTRxPai5mPkmbtE=6JbaQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgQXVndXN0IDIwMjEgMjM6MzMNCj4gDQo+
IE9uIFRodSwgQXVnIDE5LCAyMDIxIGF0IDI6NDMgUE0gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBXaGF0IHNvcnQgb2YgYmlnLCB1Z2x5IHdhcm5pbmcg
ZGlkIHlvdSBoYXZlIGluIG1pbmQ/DQo+IA0KPiBJIG9yaWdpbmFsbHkgdGhvdWdodCBXQVJOX09O
X09OQ0UoKSBqdXN0IHRvIGdldCB0aGUgZGlzdHJvIGF1dG9tYXRpYw0KPiBlcnJvciBoYW5kbGlu
ZyBpbnZvbHZlZCwgYnV0IGl0IHdvdWxkIHByb2JhYmx5IGJlIGEgYmlnIHByb2JsZW0gZm9yDQo+
IHRoZSBwZW9wbGUgd2hvIGVuZCB1cCBoYXZpbmcgcGFuaWMtb24td2FybiBvciBzb21ldGhpbmcu
DQoNCkV2ZW4gcGFuaWMtb24tb29wcyBpcyBhIFBJVEEuDQpUb29rIHVzIHdlZWtzIHRvIHJlYWxp
c2UgdGhhdCBhIGN1c3RvbWVyIHN5c3RlbSB0aGF0IHdhcyByYW5kb21seQ0KcmVib290aW5nIHdh
cyAnanVzdCcgaGF2aW5nIGEgYm9yaW5nIE5VTEwgcG9pbnRlciBhY2Nlc3MuDQogDQo+IFNvIHBy
b2JhYmx5IGp1c3QgYSAibWFrZSBpdCBhIGJpZyBib3giIHRoaW5nIHRoYXQgc3RhbmRzIG91dCwg
a2luZCBvZg0KPiB3aGF0IGxvY2tkZXAgZXRjIGRvZXMgd2l0aA0KPiANCj4gICAgICAgICBwcl93
YXJuKCI9PT09PT0uLi49PT09XG4iKTsNCj4gDQo+IGFyb3VuZCB0aGUgbWVzc2FnZXMuLg0KPiAN
Cj4gSSBkb24ndCBrbm93IGlmIGRpc3Ryb3MgaGF2ZSBzb21lIHBhdHRlcm4gd2UgY291bGQgdXNl
IHRoYXQgd291bGQgZW5kDQo+IHVwIGJlaW5nIHNvbWV0aGluZyB0aGF0IGdldHMgcmVwb3J0ZWQg
dG8gdGhlIHVzZXI/DQoNCldpbGwgdXNlcnMgZXZlbiBzZWUgaXQ/DQpBIGxvdCBvZiByZWNlbnQg
ZGlzdHJvIGluc3RhbGxzIHRyeSB2ZXJ5IGhhcmQgdG8gaGlkZSBhbGwgdGhlIGtlcm5lbA0KbWVz
c2FnZXMuDQpPVE9IIEkgZ3Vlc3MgJy1vIG1hbmQnIGlzIHVubGlrZWx5IHRvIGJlIHNldCBvbiBh
bnkgb2YgdGhvc2Ugc3lzdGVtcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

