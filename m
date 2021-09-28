Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03541ADBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbhI1LX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 07:23:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:60553 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240172AbhI1LX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:23:28 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-15--0vqw5XpP2eZpR0q1rGoTw-1; Tue, 28 Sep 2021 12:21:41 +0100
X-MC-Unique: -0vqw5XpP2eZpR0q1rGoTw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 12:21:34 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 28 Sep 2021 12:21:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: RE: Struct page proposal
Thread-Topic: Struct page proposal
Thread-Index: AQHXs9LpTZJKxz8WW0W8bJ9gHUBVtau5TKIA
Date:   Tue, 28 Sep 2021 11:21:34 +0000
Message-ID: <5426849ba4c4424791729cdbdec29bfe@AcuMS.aculab.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org> <YVII7eM7P42riwoI@moria.home.lan>
 <751358b2-aec2-43a3-cbbe-1f8c4469b6d3@suse.cz>
In-Reply-To: <751358b2-aec2-43a3-cbbe-1f8c4469b6d3@suse.cz>
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

Li4uDQo+IEJ5ICJtYWpvciByZWRlc2lnbiIgSSBtZWFudCBlLmcuIHNvbWV0aGluZyBhbG9uZyAt
IGJpdG1hcHMgb2YgZnJlZSBwYWdlcyBwZXINCj4gZWFjaCBvcmRlcj8gKGluc3RlYWQgb2YgdGhl
IGZyZWUgbGlzdHMpIEhtIGJ1dCBJIGd1ZXNzIG5vLCB0aGUgd29yc3QgY2FzZSB0aW1lcw0KPiBz
ZWFyY2hpbmcgZm9yIGZyZWUgcGFnZXMgd291bGQganVzdCBzdWNrLi4uDQoNCkFycmF5cyBvZiBw
b2ludGVycyBhcmUgbW9yZSBjYWNoZS1mcmllbmRseSB0aGFuIGxpbmtlZCBsaXN0cy4NCkJ1dCB5
b3UgbWF5IG5lZWQgdGhlICdhcnJheSBvZiBwb2ludGVycycgdG8gYWN0dWFsbHkgYmUgYQ0KbGlu
a2VkIGxpc3QhDQpXaGlsZSB5b3UgbWlnaHQgbmVlZCB0byBleHRlbmQgdGhlIGxpc3QgZm9yIGEg
J2ZyZWUnLCBpZiBpdCBpcw0KYSBsaXN0IG9mIHBhZ2VzIHlvdSd2ZSBhbHdheXMgZ290IG9uZSB0
byBoYW5kLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

