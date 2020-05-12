Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C9D1CEE95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgELHyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 03:54:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgELHyq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 03:54:46 -0400
Received: from lhreml707-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 22CA67EF6883194331E5;
        Tue, 12 May 2020 08:54:43 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 08:54:42 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 09:54:42 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 12 May 2020 09:54:42 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "John Johansen" <john.johansen@canonical.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Topic: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IIAAb0AAgAApg3CAADIngIAAzgGAgACHqACABHSroIAAjWsAgAC7FtA=
Date:   Tue, 12 May 2020 07:54:42 +0000
Message-ID: <09ee169cfd70492cb526bcb30f99d693@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
         <1588864628.5685.78.camel@linux.ibm.com>
         <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
         <1588884313.5685.110.camel@linux.ibm.com>
         <84e6acad739a415aa3e2457b5c37979f@huawei.com>
         <1588957684.5146.70.camel@linux.ibm.com>
         <414644a0be9e4af880452f4b5079aba1@huawei.com>
 <1589233010.5091.49.camel@linux.ibm.com>
In-Reply-To: <1589233010.5091.49.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.12.77]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDog
TW9uZGF5LCBNYXkgMTEsIDIwMjAgMTE6MzcgUE0NCj4gT24gTW9uLCAyMDIwLTA1LTExIGF0IDE0
OjEzICswMDAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+ID4gRnJvbTogTWltaSBab2hhciBb
bWFpbHRvOnpvaGFyQGxpbnV4LmlibS5jb21dDQo+ID4gPiBTZW50OiBGcmlkYXksIE1heSA4LCAy
MDIwIDc6MDggUE0NCj4gPiA+IE9uIEZyaSwgMjAyMC0wNS0wOCBhdCAxMDoyMCArMDAwMCwgUm9i
ZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9o
YXJAbGludXguaWJtLmNvbV0NCj4gPiA+ID4gPiBPbiBUaHUsIDIwMjAtMDUtMDcgYXQgMTY6NDcg
KzAwMDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gPg0KPiA+ID4gPHNuaXA+DQo+ID4gPg0K
PiA+ID4gPiA+ID4gPiB0aGUgZmlsZSBtZXRhZGF0YSB0byB0aGUgZmlsZSBkYXRhLiDCoFRoZSBJ
TUEgYW5kIEVWTSBwb2xpY2llcw0KPiByZWFsbHkNCj4gPiA+ID4gPiA+ID4gbmVlZCB0byBiZSBp
biBzeW5jLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEl0IHdvdWxkIGJlIG5pY2UsIGJ1dCBh
dCB0aGUgbW9tZW50IEVWTSBjb25zaWRlcnMgYWxzbyBmaWxlcyB0aGF0DQo+IGFyZQ0KPiA+ID4g
PiA+ID4gbm90IHNlbGVjdGVkIGJ5IHRoZSBJTUEgcG9saWN5LiBBbiBleGFtcGxlIG9mIHdoeSB0
aGlzIGlzIGENCj4gcHJvYmxlbSBpcw0KPiA+ID4gPiA+ID4gdGhlIGF1ZGl0IHNlcnZpY2UgdGhh
dCBmYWlscyB0byBzdGFydCB3aGVuIGl0IHRyaWVzIHRvIGFkanVzdCB0aGUNCj4gPiA+IHBlcm1p
c3Npb25zDQo+ID4gPiA+ID4gPiBvZiB0aGUgbG9nIGZpbGVzLiBUaG9zZSBmaWxlcyBkb24ndCBo
YXZlIHNlY3VyaXR5LmV2bSBiZWNhdXNlIHRoZXkNCj4gYXJlDQo+ID4gPiA+ID4gPiBub3QgYXBw
cmFpc2VkIGJ5IElNQSwgYnV0IEVWTSBkZW5pZXMgdGhlIG9wZXJhdGlvbi4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IE5vLCB0aGlzIGlzIGEgdGltaW5nIGlzc3VlIGFzIHRvIHdoZXRoZXIgb3Igbm90
IHRoZSBidWlsdGluIHBvbGljeSBvcg0KPiA+ID4gPiA+IGEgY3VzdG9tIHBvbGljeSBoYXMgYmVl
biBsb2FkZWQuIMKgQSBjdXN0b20gcG9saWN5IGNvdWxkIGV4Y2x1ZGUgdGhlDQo+ID4gPiA+ID4g
bG9nIGZpbGVzIGJhc2VkIG9uIExTTSBsYWJlbHMsIGJ1dCB0aGV5IGFyZSBpbmNsdWRlZCBpbiB0
aGUgYnVpbHRpbg0KPiA+ID4gPiA+IHBvbGljeS4NCj4gPiA+ID4NCj4gPiA+ID4gWWVzLCBJIHdh
cyByZWZlcnJpbmcgdG8gYSBjdXN0b20gcG9saWN5LiBJbiB0aGlzIGNhc2UsIEVWTSB3aWxsIG5v
dCBhZGFwdA0KPiA+ID4gPiB0byB0aGUgY3VzdG9tIHBvbGljeSBidXQgc3RpbGwgdmVyaWZpZXMg
YWxsIGZpbGVzLiBJZiBhY2Nlc3MgY29udHJvbCBpcyBkb25lDQo+ID4gPiA+IGV4Y2x1c2l2ZWx5
IGJ5IElNQSBhdCB0aGUgdGltZSBldm1fdmVyaWZ5eGF0dHIoKSBpcyBjYWxsZWQsIHdlIHdvdWxk
bid0DQo+ID4gPiA+IG5lZWQgdG8gYWRkIHNlY3VyaXR5LmV2bSB0byBhbGwgZmlsZXMuDQo+ID4g
Pg0KPiA+ID4gUm9iZXJ0bywgRVZNIGlzIG9ubHkgdHJpZ2dlcmVkIGJ5IElNQSwgdW5sZXNzIHlv
dSd2ZSBtb2RpZmllZCB0aGUNCj4gPiA+IGtlcm5lbCB0byBkbyBvdGhlcndpc2UuDQo+ID4NCj4g
PiBFVk0gd291bGQgZGVueSB4YXR0ci9hdHRyIG9wZXJhdGlvbnMgZXZlbiBpZiBJTUEgaXMgZGlz
YWJsZWQgaW4gdGhlDQo+ID4ga2VybmVsIGNvbmZpZ3VyYXRpb24uIEZvciBleGFtcGxlLCBldm1f
c2V0eGF0dHIoKSByZXR1cm5zIHRoZSB2YWx1ZQ0KPiA+IGZyb20gZXZtX3Byb3RlY3RfeGF0dHIo
KS4gSU1BIGlzIG5vdCBpbnZvbHZlZCB0aGVyZS4NCj4gDQo+IENvbW1pdMKgYWUxYmExNjc2Yjg4
ICgiRVZNOiBBbGxvdyB1c2VybGFuZCB0byBwZXJtaXQgbW9kaWZpY2F0aW9uIG9mDQo+IEVWTS1w
cm90ZWN0ZWQgbWV0YWRhdGEiKSBpbnRyb2R1Y2VkwqBFVk1fQUxMT1dfTUVUQURBVEFfV1JJVEVT
DQo+IHRvIGFsbG93DQo+IHdyaXRpbmcgdGhlIEVWTSBwb3J0YWJsZSBhbmQgaW1tdXRhYmxlIGZp
bGUgc2lnbmF0dXJlcy4NCg0KQWNjb3JkaW5nIHRvIERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
ZXZtOg0KDQpOb3RlIHRoYXQgb25jZSBhIGtleSBoYXMgYmVlbiBsb2FkZWQsIGl0IHdpbGwgbm8g
bG9uZ2VyIGJlDQpwb3NzaWJsZSB0byBlbmFibGUgbWV0YWRhdGEgbW9kaWZpY2F0aW9uLg0KDQpX
ZSBsb2FkIHRoZSBFVk0ga2V5IGZyb20gL2V0Yy9rZXlzL3g1MDlfZXZtLmRlciwgZHVyaW5nIGtl
cm5lbA0KaW5pdGlhbGl6YXRpb24sIHdoaWNoIGV4Y2x1ZGVzIHRoZSBwb3NzaWJpbGl0eSBvZiB1
c2luZyB0aGF0IGZsYWcuIERlZmVycmluZw0KdGhlIGxvYWRpbmcgb2YgdGhlIGtleSBpcyBub3Qg
cG9zc2libGUgaWYgdGhhdCBrZXkgaXMgdXNlZCBmb3IgYXBwcmFpc2FsIGFuZA0KZW5mb3JjZW1l
bnQgaXMgZW5hYmxlZCBmcm9tIHRoZSBiZWdpbm5pbmcuDQoNCkFsc28sIG9uY2UgdGhlIGZsYWcg
aXMgY2xlYXJlZCBwb3J0YWJsZSBzaWduYXR1cmVzIGNhbm5vdCBiZSBpbnN0YWxsZWQNCnVudGls
IHJlYm9vdC4gVGhpcyBzZWVtcyBhIGJpZyBsaW1pdGF0aW9uIGVzcGVjaWFsbHkgd2hlbiBzb2Z0
d2FyZQ0KdXBkYXRlcyBhcmUgaW5zdGFsbGVkIG9uIGEgcnVubmluZyBzeXN0ZW0uDQoNCj4gPiA+
IEknbSBub3QgaW50ZXJlc3RlZCBpbiBhIGNvbXBsaWNhdGVkIHNvbHV0aW9uLCBqdXN0IG9uZSB0
aGF0IGFkZHJlc3Nlcw0KPiA+ID4gdGhlIG5ldyBFVk0gaW1tdXRhYmxlIGFuZCBwb3J0YWJsZSBz
aWduYXR1cmUuIMKgSXQgbWlnaHQgcmVxdWlyZSBFVk0NCj4gPiA+IEhNQUMsIElNQSBkaWZmZXJl
bnRpYXRpbmcgYmV0d2VlbiBhIG5ldyBmaWxlIGFuZCBhbiBleGlzdGluZyBmaWxlLCBvcjpxDQo+
IA0KPiA+ID4gaXQgbWlnaHQgcmVxdWlyZSB3cml0aW5nIHRoZSBuZXcgRVZNIHNpZ25hdHVyZSBs
YXN0LCBhZnRlciBhbGwgdGhlDQo+ID4gPiBvdGhlciB4YXR0cnMgb3IgbWV0YWRhdGEgYXJlIHVw
ZGF0ZWQuIMKgUGxlYXNlIG5vdGhpbmcgdGhhdCBjaGFuZ2VzDQo+ID4gPiBleGlzdGluZyBleHBl
Y3RhdGlvbnMuDQo+ID4NCj4gPiBPay4gSW50cm9kdWNpbmcgdGhlIG5ldyBzdGF0dXMgSU5URUdS
SVRZX0ZBSUxfSU1NVVRBQkxFLCBhcyBJDQo+ID4gbWVudGlvbmVkIGluICdbUEFUQ0hdIGltYTog
QWxsb3cgaW1hc2lnIHJlcXVpcmVtZW50IHRvIGJlIHNhdGlzZmllZCBieQ0KPiA+IEVWTSBwb3J0
YWJsZSBzaWduYXR1cmVzJyBzZWVtcyB0byBoYXZlIGFuIGFkZGl0aW9uYWwgYmVuZWZpdC4gV2UN
Cj4gPiBjb3VsZCBpbnRyb2R1Y2UgYW4gYWRkaXRpb25hbCBleGNlcHRpb24gaW4gZXZtX3Byb3Rl
Y3RfeGF0dHIoKSwgb3RoZXINCj4gPiB0aGFuIElOVEVHUklUWV9OT1hBVFRSUywgYXMgd2Uga25v
dyB0aGF0IHhhdHRyL2F0dHIgdXBkYXRlIHdvbid0DQo+ID4gY2F1c2UgSE1BQyB1cGRhdGUuDQo+
IA0KPiBSZWZlciB0byBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL2V2bSBkZXNjcmliZXMgb24g
aG93IHRvIHBlcm1pdA0KPiB3cml0aW5nIHRoZSBzZWN1cml0eS5ldm0gc2lnbmF0dXJlcy4NCg0K
SXQgZG9lc24ndCBzZWVtIHRoZXJlIGlzIGEgc29sdXRpb24gZm9yIGFkZGluZyBwb3J0YWJsZSBz
aWduYXR1cmVzIGF0DQpydW4tdGltZS4NCg0KPiA+IEhvd2V2ZXIsIGl0IHdvbid0IHdvcmsgdW5s
ZXNzIHRoZSBJTUEgcG9saWN5IHNheXMgdGhhdCB0aGUgZmlsZSBzaG91bGQNCj4gPiBiZSBhcHBy
YWlzZWQgd2hlbiB0aGUgbWtub2QoKSBzeXN0ZW0gY2FsbCBpcyBleGVjdXRlZC4gT3RoZXJ3aXNl
LA0KPiA+IGludGVncml0eV9paW50X2NhY2hlIGlzIG5vdCBjcmVhdGVkIGZvciB0aGUgZmlsZSBh
bmQgdGhlIElNQV9ORVdfRklMRQ0KPiA+IGZsYWcgaXMgbm90IHNldC4NCj4gPg0KPiA+IEdyYW50
aW5nIGFuIGV4Y2VwdGlvbiBmb3IgSU5URUdSSVRZX0ZBSUxfSU1NVVRBQkxFIHNvbHZlcyB0aGUg
Y2FzZQ0KPiA+IHdoZXJlIHNlY3VyaXR5LmV2bSBpcyB0aGUgZmlyc3QgeGF0dHIgc2V0LiBJZiBh
IHByb3RlY3RlZCB4YXR0ciBpcyB0aGUgZmlyc3QgdG8NCj4gPiBiZSBhZGRlZCwgdGhlbiB3ZSBh
bHNvIGhhdmUgdG8gaGFuZGxlIHRoZSBJTlRFR1JJVFlfTk9MQUJFTCBlcnJvci4NCj4gPiBJdCBz
aG91bGQgYmUgZmluZSB0byBhZGQgYW4gZXhjZXB0aW9uIGZvciB0aGlzIGVycm9yIGlmIHRoZSBI
TUFDIGtleSBpcyBub3QNCj4gPiBsb2FkZWQuDQo+ID4NCj4gPiBUaGlzIHN0aWxsIGRvZXMgbm90
IHNvbHZlIGFsbCBwcm9ibGVtcy4gSU5URUdSSVRZX05PTEFCRUwgY2Fubm90IGJlDQo+ID4gaWdu
b3JlZCBpZiB0aGUgSE1BQyBrZXkgaXMgbG9hZGVkLCB3aGljaCBtZWFucyB0aGF0IGFsbCBmaWxl
cyBuZWVkIHRvIGJlDQo+ID4gcHJvdGVjdGVkIGJ5IEVWTSB0byBhdm9pZCBpc3N1ZXMgbGlrZSB0
aGUgb25lIEkgZGVzY3JpYmVkIChhdWRpdGQpLg0KPiANCj4gVGhlIGFwcGxpY2F0aW9uIHN0aWxs
IG5lZWRzIHRvIGRlZmVyIHdyaXRpbmcgdGhlIEVWTSBwb3J0YWJsZSBhbmQNCj4gaW1tdXRhYmxl
IGZpbGUgc2lnbmF0dXJlcyB1bnRpbCBhZnRlciBhbGwgdGhlIG90aGVyIHhhdHRycyBhcmUgd3Jp
dHRlbg0KPiBvdGhlcndpc2UgaXQgd29uJ3QgdmFsaWRhdGUuDQoNCkVWTSB3b24ndCBhbGxvdyB0
aGF0IGJlY2F1c2UgYXQgdGhlIHNlY29uZCBzZXR4YXR0cigpIGl0IHdpbGwgZmluZCB0aGF0DQpz
ZWN1cml0eS5ldm0gaXMgbWlzc2luZy4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVT
IER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcs
IExpIEppYW4sIFNoaSBZYW5saQ0K
