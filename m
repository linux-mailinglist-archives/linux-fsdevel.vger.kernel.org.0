Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29AA142F05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATPst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 10:48:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53635 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATPst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:48:49 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-14-pqMPwcNKP2ew_zdGmZYihw-1; Mon, 20 Jan 2020 15:48:46 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 15:47:22 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jan 2020 15:47:22 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali.rohar@gmail.com>
CC:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>
Subject: RE: vfat: Broken case-insensitive support for UTF-8
Thread-Topic: vfat: Broken case-insensitive support for UTF-8
Thread-Index: AQHVz4FsiOVqsS4Qp0SucuDN4afIhKfzph4wgAAFE4CAAADOMA==
Date:   Mon, 20 Jan 2020 15:47:22 +0000
Message-ID: <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp> <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
 <20200120152009.5vbemgmvhke4qupq@pali>
In-Reply-To: <20200120152009.5vbemgmvhke4qupq@pali>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: pqMPwcNKP2ew_zdGmZYihw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogUGFsaSBSb2jDoXINCj4gU2VudDogMjAgSmFudWFyeSAyMDIwIDE1OjIwDQouLi4NCj4g
VGhpcyBpcyBub3QgcG9zc2libGUuIFRoZXJlIGlzIDE6MSBtYXBwaW5nIGJldHdlZW4gVVRGLTgg
c2VxdWVuY2UgYW5kDQo+IFVuaWNvZGUgY29kZSBwb2ludC4gd2NoYXJfdCBpbiBrZXJuZWwgcmVw
cmVzZW50IGVpdGhlciBvbmUgVW5pY29kZSBjb2RlDQo+IHBvaW50IChsaW1pdGVkIHVwIHRvIFUr
RkZGRiBpbiBOTFMgZnJhbWV3b3JrIGZ1bmN0aW9ucykgb3IgMmJ5dGVzIGluDQo+IFVURi0xNiBz
ZXF1ZW5jZSAob25seSBpbiB1dGY4c190b191dGYxNnMoKSBhbmQgdXRmMTZzX3RvX3V0ZjhzKCkN
Cj4gZnVuY3Rpb25zKS4NCg0KVW5mb3J0dW5hdGVseSB0aGVyZSBpcyBuZWl0aGVyIGEgMToxIG1h
cHBpbmcgb2YgYWxsIHBvc3NpYmxlIGJ5dGUgc2VxdWVuY2VzDQp0byB3Y2hhcl90IChvciB1bmlj
b2RlIGNvZGUgcG9pbnRzKSwgbm9yIGEgMToxIG1hcHBpbmcgb2YgYWxsIHBvc3NpYmxlDQp3Y2hh
cl90IHZhbHVlcyB0byBVVEYtOC4NClJlYWxseSBib3RoIG5lZWQgdG8gYmUgZGVmaW5lZCAtIGV2
ZW4gZm9yIG90aGVyd2lzZSAnaW52YWxpZCcgc2VxdWVuY2VzLg0KDQpFdmVuIHRoZSAxNi1iaXQg
dmFsdWVzIGFib3ZlIDB4ZDAwMCBjYW4gYXBwZWFyIG9uIHRoZWlyIG93biBpbg0Kd2luZG93cyBm
aWxlc3lzdGVtcyAoYWNjb3JkaW5nIHRvIHdpa2lwZWRpYSkuDQoNCkl0IGlzIGFsbCB0byBlYXN5
IHRvIGdldCBzZXF1ZW5jZXMgb2YgdmFsdWVzIHRoYXQgY2Fubm90IGJlIGNvbnZlcnRlZA0KdG8v
ZnJvbSBVVEYtOC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

