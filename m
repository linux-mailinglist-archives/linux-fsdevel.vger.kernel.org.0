Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06A032068F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBTSDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 13:03:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51239 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229808AbhBTSDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:03:39 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-246-SoJwM6GlPY20W1KbkIBHGQ-1; Sat, 20 Feb 2021 18:01:58 +0000
X-MC-Unique: SoJwM6GlPY20W1KbkIBHGQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 20 Feb 2021 18:01:57 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 20 Feb 2021 18:01:57 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'SelvaKumar S' <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [RFC PATCH v5 0/4] add simple copy support
Thread-Topic: [RFC PATCH v5 0/4] add simple copy support
Thread-Index: AQHXByyi0XMTfmzR3kSGd6ttkW2CGaphVhLg
Date:   Sat, 20 Feb 2021 18:01:56 +0000
Message-ID: <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
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

RnJvbTogU2VsdmFLdW1hciBTDQo+IFNlbnQ6IDE5IEZlYnJ1YXJ5IDIwMjEgMTI6NDUNCj4gDQo+
IFRoaXMgcGF0Y2hzZXQgdHJpZXMgdG8gYWRkIHN1cHBvcnQgZm9yIFRQNDA2NWEgKCJTaW1wbGUg
Q29weSBDb21tYW5kIiksDQo+IHYyMDIwLjA1LjA0ICgiUmF0aWZpZWQiKQ0KPiANCj4gVGhlIFNw
ZWNpZmljYXRpb24gY2FuIGJlIGZvdW5kIGluIGZvbGxvd2luZyBsaW5rLg0KPiBodHRwczovL252
bWV4cHJlc3Mub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9OVk0tRXhwcmVzcy0xLjQtUmF0aWZpZWQt
VFBzLTEuemlwDQo+IA0KPiBTaW1wbGUgY29weSBjb21tYW5kIGlzIGEgY29weSBvZmZsb2FkaW5n
IG9wZXJhdGlvbiBhbmQgaXMgIHVzZWQgdG8gY29weQ0KPiBtdWx0aXBsZSBjb250aWd1b3VzIHJh
bmdlcyAoc291cmNlX3Jhbmdlcykgb2YgTEJBJ3MgdG8gYSBzaW5nbGUgZGVzdGluYXRpb24NCj4g
TEJBIHdpdGhpbiB0aGUgZGV2aWNlIHJlZHVjaW5nIHRyYWZmaWMgYmV0d2VlbiBob3N0IGFuZCBk
ZXZpY2UuDQoNClNvdW5kcyB0byBtZSBsaWtlIHRoZSByZWFsIHJlYXNvbiBpcyB0aGF0IHRoZSBj
b3B5IGp1c3QgZW5kcyB1cCBjaGFuZ2luZw0Kc29tZSBpbmRpcmVjdCBibG9jayBwb2ludGVycyBy
YXRoZXIgdGhhbiBoYXZpbmcgdG8gYWN0dWFsbHkgY29weSB0aGUgZGF0YS4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

