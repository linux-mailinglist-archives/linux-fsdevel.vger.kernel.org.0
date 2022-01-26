Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2590749D02D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiAZQ76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 11:59:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30888 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243333AbiAZQ76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:59:58 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-129-QMbyePlyM1eBDjptTIuy9g-1; Wed, 26 Jan 2022 16:59:55 +0000
X-MC-Unique: QMbyePlyM1eBDjptTIuy9g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 26 Jan 2022 16:59:53 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 26 Jan 2022 16:59:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Ariadne Conill <ariadne@dereferenced.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Eric Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Thread-Topic: [PATCH] fs/exec: require argv[0] presence in
 do_execveat_common()
Thread-Index: AQHYEoZGG+gndwPty0OW8qRUEed8Eax1hgpA
Date:   Wed, 26 Jan 2022 16:59:53 +0000
Message-ID: <a33e8f5318e94e01ac4126bc4870b59a@AcuMS.aculab.com>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
 <202201252241.7309AE568F@keescook>
 <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
In-Reply-To: <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
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

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDI2IEphbnVhcnkgMjAyMiAwNzoyOA0KLi4uDQo+ID4N
Cj4gPlRoZXJlIHNob3VsZG4ndCBiZSBhbnl0aGluZyBsZWdpdGltYXRlIGFjdHVhbGx5IGRvaW5n
IHRoaXMgaW4gdXNlcnNwYWNlLg0KPiANCj4gSSBzcG9rZSB0b28gc29vbi4NCj4gDQo+IFVuZm9y
dHVuYXRlbHksIHRoaXMgaXMgbm90IHRoZSBjYXNlOg0KPiBodHRwczovL2NvZGVzZWFyY2guZGVi
aWFuLm5ldC9zZWFyY2g/cT1leGVjdmUlNUMrKiU1QyUyOCU1QiU1RSUyQyU1RCUyQiUyQysqTlVM
TCZsaXRlcmFsPTANCj4gDQo+IExvdHMgb2Ygc3R1ZmYgbGlrZXMgdG8gZG86DQo+IGV4ZWN2ZShw
YXRoLCBOVUxMLCBOVUxMKTsNCj4gDQo+IERvIHRoZXNlIHRoaW5ncyBkZXBlbmQgb24gYXJnYz09
MCB3b3VsZCBiZSBteSBuZXh0IHF1ZXN0aW9uLi4uDQoNCldoYXQgYWJvdXQgZW5zdXJpbmcgdGhh
dCBhcmd2WzBdIGFuZCBhcmd2WzFdIGFyZSBhbHdheXMgcHJlc2VudA0KYW5kIGJvdGggTlVMTCB3
aGVuIGFyZ2MgaXMgMD8NCg0KVGhlbiBwcm9ncmFtcyB0aGF0IGp1c3Qgc2NhbiBmcm9tIGFyZ3Zb
MV0gdW50aWwgdGhleSBnZXQgYSBOVUxMDQp3aWxsIGFsd2F5cyBiZSBmaW5lLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

