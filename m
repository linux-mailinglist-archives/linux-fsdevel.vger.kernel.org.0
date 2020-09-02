Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897025AA15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBLOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 07:14:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57093 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgIBLNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:13:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-264-vYAVe1aDPQ2U4EAg7n6GQg-1; Wed, 02 Sep 2020 12:13:39 +0100
X-MC-Unique: vYAVe1aDPQ2U4EAg7n6GQg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Sep 2020 12:13:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Sep 2020 12:13:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Colin Ian King' <colin.king@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: sysfs: copy ACPI data using io memory copying
Thread-Topic: [PATCH] ACPI: sysfs: copy ACPI data using io memory copying
Thread-Index: AQHWgROr7agM3y/cj06L4ZPs9JoiwalVMaYA
Date:   Wed, 2 Sep 2020 11:13:38 +0000
Message-ID: <e94b289c3dfb4ac0b05a7134f9ae8bb3@AcuMS.aculab.com>
References: <20200312111345.1057569-1-colin.king@canonical.com>
 <2440284.4js2fAD822@kreacher>
 <65817d75-7272-2ef3-33a5-f390b5b0ec30@canonical.com>
In-Reply-To: <65817d75-7272-2ef3-33a5-f390b5b0ec30@canonical.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQ29saW4gSWFuIEtpbmcNCj4gU2VudDogMDIgU2VwdGVtYmVyIDIwMjAgMTE6MjcNCj4g
DQo+IE9uIDE0LzAzLzIwMjAgMTA6MjMsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+IE9u
IFRodXJzZGF5LCBNYXJjaCAxMiwgMjAyMCAxMjoxMzo0NSBQTSBDRVQgQ29saW4gS2luZyB3cm90
ZToNCj4gPj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4N
Cj4gPj4NCj4gPj4gUmVhZGluZyBBQ1BJIGRhdGEgb24gQVJNNjQgYXQgYSBub24tYWxpZ25lZCBv
ZmZzZXQgZnJvbQ0KPiA+PiAvc3lzL2Zpcm13YXJlL2FjcGkvdGFibGVzL2RhdGEvQkVSVCB3aWxs
IGNhdXNlIGEgc3BsYXQgYmVjYXVzZQ0KPiA+PiB0aGUgZGF0YSBpcyBJL08gbWVtb3J5IG1hcHBl
ZCBhbmQgYmVpbmcgcmVhZCB3aXRoIGp1c3QgYSBtZW1jcHkuDQo+ID4+IEZpeCB0aGlzIGJ5IGlu
dHJvZHVjaW5nIGFuIEkvTyB2YXJpYW50IG9mIG1lbW9yeV9yZWFkX2Zyb21fYnVmZmVyDQo+ID4+
IGFuZCB1c2luZyBJL08gbWVtb3J5IG1hcHBlZCBjb3BpZXMgaW5zdGVhZC4NCi4uDQo+ID4+ICsv
KioNCj4gPj4gKyAqIG1lbW9yeV9yZWFkX2Zyb21faW9fYnVmZmVyIC0gY29weSBkYXRhIGZyb20g
YSBpbyBtZW1vcnkgbWFwcGVkIGJ1ZmZlcg0KPiA+PiArICogQHRvOiB0aGUga2VybmVsIHNwYWNl
IGJ1ZmZlciB0byByZWFkIHRvDQo+ID4+ICsgKiBAY291bnQ6IHRoZSBtYXhpbXVtIG51bWJlciBv
ZiBieXRlcyB0byByZWFkDQo+ID4+ICsgKiBAcHBvczogdGhlIGN1cnJlbnQgcG9zaXRpb24gaW4g
dGhlIGJ1ZmZlcg0KPiA+PiArICogQGZyb206IHRoZSBidWZmZXIgdG8gcmVhZCBmcm9tDQo+ID4+
ICsgKiBAYXZhaWxhYmxlOiB0aGUgc2l6ZSBvZiB0aGUgYnVmZmVyDQo+ID4+ICsgKg0KPiA+PiAr
ICogVGhlIG1lbW9yeV9yZWFkX2Zyb21fYnVmZmVyKCkgZnVuY3Rpb24gcmVhZHMgdXAgdG8gQGNv
dW50IGJ5dGVzIGZyb20gdGhlDQo+ID4+ICsgKiBpbyBtZW1vcnkgbWFwcHkgYnVmZmVyIEBmcm9t
IGF0IG9mZnNldCBAcHBvcyBpbnRvIHRoZSBrZXJuZWwgc3BhY2UgYWRkcmVzcw0KPiA+PiArICog
c3RhcnRpbmcgYXQgQHRvLg0KPiA+PiArICoNCj4gPj4gKyAqIE9uIHN1Y2Nlc3MsIHRoZSBudW1i
ZXIgb2YgYnl0ZXMgcmVhZCBpcyByZXR1cm5lZCBhbmQgdGhlIG9mZnNldCBAcHBvcyBpcw0KPiA+
PiArICogYWR2YW5jZWQgYnkgdGhpcyBudW1iZXIsIG9yIG5lZ2F0aXZlIHZhbHVlIGlzIHJldHVy
bmVkIG9uIGVycm9yLg0KPiA+PiArICoqLw0KDQpBcGFydCBmcm9tIHRoZSByZXR1cm4gdmFsdWUg
aG93IGlzIHRoaXMgZGlmZmVyZW50IGZyb20gdGhlIGdlbmVyaWMNCm1lbWNweV9mcm9tX2lvKCkg
Pw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

