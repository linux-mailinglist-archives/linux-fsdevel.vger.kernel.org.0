Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890F23A117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 10:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgHCIcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 04:32:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42224 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgHCIcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:32:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-9fQDUxYuOgOUDRJWjNab7Q-1; Mon, 03 Aug 2020 09:32:20 +0100
X-MC-Unique: 9fQDUxYuOgOUDRJWjNab7Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 3 Aug 2020 09:32:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 3 Aug 2020 09:32:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Sistare' <steven.sistare@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "areber@redhat.com" <areber@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>
Subject: RE: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Topic: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Index: AQHWZ2PceK06OQMZZUSyBX/76a/FaakmEZEQ
Date:   Mon, 3 Aug 2020 08:32:19 +0000
Message-ID: <09ce47c0a97c482b95b8b521e9ee33d4@AcuMS.aculab.com>
References: <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
 <20200731165649.GG24045@ziepe.ca>
 <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
 <20200731174837.GH24045@ziepe.ca>
 <f4ce3f4a-bdee-ec43-986c-8e4d8b1d2ddc@oracle.com>
In-Reply-To: <f4ce3f4a-bdee-ec43-986c-8e4d8b1d2ddc@oracle.com>
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

PiBNYXliZS4gIFdlIHN0aWxsIG5lZWQgdG8gcHJlc2VydmUgYW4gYW5vbnltb3VzIHNlZ21lbnQs
IHRob3VnaC4gIE1BRFZfRE9FWEVDLCBvciBtc2hhcmUsDQo+IG9yIHNvbWV0aGluZyBlbHNlLiAg
QW5kIEkgdGhpbmsgdGhlIGFiaWxpdHkgdG8gcHJlc2VydmUgbWVtb3J5IGNvbnRhaW5pbmcgcG9p
bnRlcnMgdG8gaXRzZWxmDQo+IGlzIGFuIGludGVyZXN0aW5nIHVzZSBjYXNlLCB0aG91Z2ggbm90
IG91cnMuDQoNCldoeSBkb2VzIGFsbCB0aGlzIHJlbWluZCBtZSBvZiB0aGUgb2xkIHNlbmRtYWls
IGNvZGUuDQpBZnRlciBwYXJzaW5nIHRoZSBjb25maWcgZmlsZSBpdCB1c2VkIHRvIHdyaXRlIGl0
cyBlbnRpcmUgZGF0YQ0KYXJlYSBvdXQgdG8gYSBmaWxlLg0KT24gcmVzdGFydCwgaWYgdGhlIGNv
bmZpZyBmaWxlIGhhZG4ndCBjaGFuZ2VkIGl0IHdvdWxkIHJlYWQgaXQgYmFjayBpdC4NCg0KSXQg
c29ydCBvZiB3b3JrZWQgLSB1bnRpbCBzaGFyZWQgbGlicmFyaWVzIGNhbWUgYWxvbmcuDQpUaGVu
IGl0IGhhZCBhIGhhYml0IG9mIGdlbmVyYXRpbmcgcmFuZG9tIGNyYXNoZXMuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

