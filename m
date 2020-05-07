Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2A1C841F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGIB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 04:01:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57950 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgEGIB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 04:01:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-86-phOmLZBGMRWXoRhUhxSFxQ-1; Thu, 07 May 2020 09:01:52 +0100
X-MC-Unique: phOmLZBGMRWXoRhUhxSFxQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 7 May 2020 09:01:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 May 2020 09:01:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Linux FS-devel Mailing List" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
Thread-Topic: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
Thread-Index: AQHWIu3yH4vXlI/Pe06688jiYmguf6icRU4w
Date:   Thu, 7 May 2020 08:01:51 +0000
Message-ID: <af2c5bdf0c4e4e00bef96b5c6b4e1da7@AcuMS.aculab.com>
References: <20200505143028.1290686-1-arnd@arndb.de>
 <b287bb2f-28e2-7a41-e015-aa5a0cb3b5d7@embeddedor.com>
 <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com>
In-Reply-To: <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwNSBNYXkgMjAyMCAxNjowMA0KLi4uDQo+IFll
cywgd2UgdXN1YWxseSBiYWNrcG9ydCB0cml2aWFsIHdhcm5pbmcgZml4ZXMgdG8gc3RhYmxlIGtl
cm5lbHMgdG8gYWxsb3cNCj4gYnVpbGRpbmcgdGhvc2Ugd2l0aCBhbnkgbW9kZXJuIGNvbXBpbGVy
IHZlcnNpb24uDQoNCkluIHRoaXMgY2FzZSB3b3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gYmFja3Bv
cnQgYSBjaGFuZ2UgdGhhdCBkaXNhYmxlcw0KdGhlIHNwZWNpZmljIGNvbXBpbGVyIHdhcm5pbmc/
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

