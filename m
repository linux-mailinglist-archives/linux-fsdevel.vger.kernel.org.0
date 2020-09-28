Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E427B009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1Og0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 10:36:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29887 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgI1OgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:36:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-94-MLV1u31VP7mjvYEQ13qqnA-1; Mon, 28 Sep 2020 15:36:22 +0100
X-MC-Unique: MLV1u31VP7mjvYEQ13qqnA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 28 Sep 2020 15:36:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 28 Sep 2020 15:36:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Kasatkin' <dmitry.kasatkin@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Mount options may be silently discarded
Thread-Topic: Mount options may be silently discarded
Thread-Index: AQHWlZ/5eWLTSDvNKUCiSiyDXsLcfql+HVKQ
Date:   Mon, 28 Sep 2020 14:36:21 +0000
Message-ID: <87bb66c2a7f94bd1ab768a8160e48e39@AcuMS.aculab.com>
References: <CACE9dm_eypZ4wn8PpYYCYNuM501_M-8pH7by=U-6hOmJCwuxig@mail.gmail.com>
In-Reply-To: <CACE9dm_eypZ4wn8PpYYCYNuM501_M-8pH7by=U-6hOmJCwuxig@mail.gmail.com>
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

RnJvbTogRG1pdHJ5IEthc2F0a2luDQo+IFNlbnQ6IDI4IFNlcHRlbWJlciAyMDIwIDE1OjAzDQo+
IA0KPiAiY29weV9tb3VudF9vcHRpb25zIiBmdW5jdGlvbiBjYW1lIHRvIG15IGV5ZXMuDQo+IEl0
IHNwbGl0cyBjb3B5IGludG8gMiBwaWVjZXMgLSBvdmVyIHBhZ2UgYm91bmRhcmllcy4NCj4gSSB3
b25kZXIgd2hhdCBpcyB0aGUgcmVhbCByZWFzb24gZm9yIGRvaW5nIHRoaXM/DQo+IE9yaWdpbmFs
IGNvbW1lbnQgd2FzIHRoYXQgd2UgbmVlZCBleGFjdCBieXRlcyBhbmQgc29tZSB1c2VyIG1lbWNw
eQ0KPiBmdW5jdGlvbnMgIGRvIG5vdCByZXR1cm4gY29ycmVjdCBudW1iZXIgb24gcGFnZSBmYXVs
dC4NCj4gDQo+IEJ1dCBob3cgd291bGQgYWxsIG90aGVyIGNhc2VzIHdvcms/DQo+IA0KPiBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2ZzL25hbWVzcGFjZS5j
I0wzMDc1DQo+IA0KPiBpZiAoc2l6ZSAhPSBQQUdFX1NJWkUpIHsNCj4gICAgICAgIGlmIChjb3B5
X2Zyb21fdXNlcihjb3B5ICsgc2l6ZSwgZGF0YSArIHNpemUsIFBBR0VfU0laRSAtIHNpemUpKQ0K
PiAgICAgICAgICAgICBtZW1zZXQoY29weSArIHNpemUsIDAsIFBBR0VfU0laRSAtIHNpemUpOw0K
PiB9DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2Ugc29tZSBvcHRpb25zIG1heSBiZSBqdXN0IGRpc2Nh
cmRlZD8NCj4gV2hhdCBpZiBpdCBpcyBhbiBpbXBvcnRhbnQgc2VjdXJpdHkgb3B0aW9uPw0KPiAN
Cj4gV2h5IGl0IGRvZXMgbm90IHJldHVybiBFRkFVTFQsIGJ1dCBqdXN0IG1lbXNldD8NCg0KVGhl
IHVzZXIgZG9lc24ndCBzdXBwbHkgdGhlIHRyYW5zZmVyIGxlbmd0aCwgdGhlIG1heCBzaXplDQpp
cyBhIHBhZ2UuDQpTaW5jZSB0aGUgY29weSBjYW4gb25seSBzdGFydCB0byBmYWlsIG9uIGEgcGFn
ZSBib3VuZGFyeQ0KcmVhZGluZyBpbiB0d28gcGllY2VzIGlzIGV4YWN0bHkgdGhlIHNhbWUgYXMg
a25vd2luZyB0aGUNCmFkZHJlc3MgYXQgd2hpY2ggdGhlIHRyYW5zZmVyIHN0YXJ0ZWQgdG8gZmFp
bC4NCg0KU2luY2UgdGhlIGFjdHVhbCBtb3VudCBvcHRpb25zIGNhbiBiZSBtdWNoIHNtYWxsZXIg
dGhhbg0KYSBwYWdlIChhbmQgdXN1YWxseSBhcmUpIHplcm8tZmlsbGluZyBpcyBiZXN0Lg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

