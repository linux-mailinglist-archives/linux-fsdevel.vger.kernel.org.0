Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF80C340912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhCRPl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:41:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45981 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhCRPk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:40:57 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-Z0U13KzUNJW_NStgkqAmDA-1; Thu, 18 Mar 2021 15:40:54 +0000
X-MC-Unique: Z0U13KzUNJW_NStgkqAmDA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 18 Mar 2021 15:40:53 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 18 Mar 2021 15:40:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shreeya Patel' <shreeya.patel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "drosen@google.com" <drosen@google.com>,
        "ebiggers@google.com" <ebiggers@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "andre.almeida@collabora.com" <andre.almeida@collabora.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2 3/4] fs: unicode: Use strscpy() instead of strncpy()
Thread-Topic: [PATCH v2 3/4] fs: unicode: Use strscpy() instead of strncpy()
Thread-Index: AQHXHADvVX9HQXwArESTX+RVn+Pn1qqJ39Rg
Date:   Thu, 18 Mar 2021 15:40:53 +0000
Message-ID: <609a9c29b91b4c9486f37c7ed74f0717@AcuMS.aculab.com>
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
 <20210318133305.316564-4-shreeya.patel@collabora.com>
 <f6bb5ec3-da94-ae9a-4ac4-e39038b42cb3@collabora.com>
In-Reply-To: <f6bb5ec3-da94-ae9a-4ac4-e39038b42cb3@collabora.com>
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

RnJvbTogU2hyZWV5YSBQYXRlbA0KPiBTZW50OiAxOCBNYXJjaCAyMDIxIDE0OjEzDQo+IA0KPiBP
biAxOC8wMy8yMSA3OjAzIHBtLCBTaHJlZXlhIFBhdGVsIHdyb3RlOg0KPiA+IEZvbGxvd2luZyB3
YXJuaW5nIHdhcyByZXBvcnRlZCBieSBLZXJuZWwgVGVzdCBSb2JvdC4NCj4gPg0KPiA+IEluIGZ1
bmN0aW9uICd1dGY4X3BhcnNlX3ZlcnNpb24nLA0KPiA+IGlubGluZWQgZnJvbSAndXRmOF9sb2Fk
JyBhdCBmcy91bmljb2RlL3V0Zjhtb2QuYzoxOTU6NzoNCj4gPj4+IGZzL3VuaWNvZGUvdXRmOG1v
ZC5jOjE3NToyOiB3YXJuaW5nOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDEyIGVxdWFscw0K
PiA+IGRlc3RpbmF0aW9uIHNpemUgWy1Xc3RyaW5nb3AtdHJ1bmNhdGlvbl0NCj4gPiAxNzUgfCAg
c3RybmNweSh2ZXJzaW9uX3N0cmluZywgdmVyc2lvbiwgc2l6ZW9mKHZlcnNpb25fc3RyaW5nKSk7
DQo+ID4gICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gVGhlIC1Xc3RyaW5nb3AtdHJ1bmNhdGlvbiB3YXJuaW5n
IGhpZ2hsaWdodHMgdGhlIHVuaW50ZW5kZWQNCj4gPiB1c2VzIG9mIHRoZSBzdHJuY3B5IGZ1bmN0
aW9uIHRoYXQgdHJ1bmNhdGUgdGhlIHRlcm1pbmF0aW5nIE5VTEwNCj4gPiBjaGFyYWN0ZXIgZnJv
bSB0aGUgc291cmNlIHN0cmluZy4NCj4gPiBVbmxpa2Ugc3RybmNweSgpLCBzdHJzY3B5KCkgYWx3
YXlzIG51bGwtdGVybWluYXRlcyB0aGUgZGVzdGluYXRpb24gc3RyaW5nLA0KPiA+IGhlbmNlIHVz
ZSBzdHJzY3B5KCkgaW5zdGVhZCBvZiBzdHJuY3B5KCkuDQo+IA0KPiANCj4gTm90IHN1cmUgaWYg
c3Ryc2NweSBpcyBwcmVmZXJhYmxlLiBKdXN0IGZvdW5kIHRoaXMgYXJ0aWNsZQ0KPiBodHRwczov
L2x3bi5uZXQvQXJ0aWNsZXMvNjU5MjE0Lw0KPiBTaG91bGQgSSBnbyBmb3IgbWVtY3B5IGluc3Rl
YWQ/DQoNCldoaWNoIGxlbmd0aCB3b3VsZCB5b3UgZ2l2ZSBtZW1jcHkoKSA/DQpUaGUgY29tcGls
ZXIgd2lsbCBtb2FuIGlmIHlvdSB0cnkgdG8gcmVhZCBiZXlvbmQgdGhlIGVuZCBvZiB0aGUNCmlu
cHV0IHN0cmluZy4NCg0Kc3Ryc2NweSgpIGlzIGFib3V0IHRoZSBiZXN0IG9mIGEgYmFkIGxvdC4N
Cg0KSSB0aGluayAoSSdtIG5vdCBzdXJlISkgdGhhdCBhIGdvb2Qgc3RyaW5nIGNvcHkgZnVuY3Rp
b24gc2hvdWxkDQpyZXR1cm4gdGhlIG51bWJlciBvZiBieXRlcyBjb3BpZXMgb3IgdGhlIGJ1ZmZl
ciBsZW5ndGggaXMgdHJ1bmNhdGVkLg0KVGhlbiB5b3UgY2FuIGRvIHJlcGVhdGVkOg0KCW9mZiAr
PSB4eHhjcHkoYnVmICsgb2ZmLCBidWZsZW4gLSBvZmYsIHh4eHh4KTsNCndpdGhvdXQgYW55IGRh
bmdlciBvZiB3cml0aW5nIGJleW9uZCB0aGUgYnVmZmVyIGVuZCwgYWx3YXlzDQpnZXR0aW5nIGEg
J1wwJyB0ZXJtaW5hdGVkIHN0cmluZywgYW5kIGJlaW5nIGFibGUgdG8gZGV0ZWN0IG92ZXJmbG93
DQpyaWdodCBhdCB0aGUgZW5kLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

