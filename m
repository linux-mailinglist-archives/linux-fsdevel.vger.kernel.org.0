Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49371D09D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 09:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgEMHVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 03:21:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729793AbgEMHVj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 03:21:39 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7E0816D919ACC1985133;
        Wed, 13 May 2020 08:21:34 +0100 (IST)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 13 May 2020 08:21:34 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 13 May 2020 09:21:33 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Wed, 13 May 2020 09:21:33 +0200
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
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IIAAb0AAgAApg3CAADIngIAAzgGAgACHqACABHSroIAAjWsAgAC7FtCAAFxigIAAJvQA///zHACAACsKoIAAFJCAgADcpfA=
Date:   Wed, 13 May 2020 07:21:33 +0000
Message-ID: <4fb6c8457ac44af3b464fab712a10a37@huawei.com>
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
         <09ee169cfd70492cb526bcb30f99d693@huawei.com>
         <1589293025.5098.53.camel@linux.ibm.com>
         <d3f4a53e386d4bb1b8c608ac8b6bec1f@huawei.com>
         <1589298622.5098.67.camel@linux.ibm.com>
         <fcdb168d27214b5e85c3b741f184cde9@huawei.com>
 <1589312281.5098.91.camel@linux.ibm.com>
In-Reply-To: <1589312281.5098.91.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.21.67]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDog
VHVlc2RheSwgTWF5IDEyLCAyMDIwIDk6MzggUE0NCj4gT24gVHVlLCAyMDIwLTA1LTEyIGF0IDE2
OjMxICswMDAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+ID4gRnJvbTogTWltaSBab2hhciBb
bWFpbHRvOnpvaGFyQGxpbnV4LmlibS5jb21dDQo+IA0KPiA+ID4gPiA+IEVhY2ggdGltZSB0aGUg
RVZNIHByb3RlY3RlZCBmaWxlIG1ldGFkYXRhIGlzIHVwZGF0ZWQsIHRoZSBFVk0NCj4gSE1BQw0K
PiA+ID4gaXMNCj4gPiA+ID4gPiB1cGRhdGVkLCBhc3N1bWluZyB0aGUgZXhpc3RpbmcgRVZNIEhN
QUMgaXMgdmFsaWQuIMKgVXNlcnNwYWNlDQo+IHNob3VsZA0KPiA+ID4gPiA+IG5vdCBoYXZlIGFj
Y2VzcyB0byB0aGUgSE1BQyBrZXksIHNvIHdlIG9ubHkgYWxsb3cgd3JpdGluZyBFVk0NCj4gPiA+
ID4gPiBzaWduYXR1cmVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIG9ubHkgZGlmZmVyZW5j
ZSBiZXR3ZWVuIHdyaXRpbmcgdGhlIG9yaWdpbmFsIEVWTSBzaWduYXR1cmUgYW5kDQo+IHRoZQ0K
PiA+ID4gPiA+IG5ldyBwb3J0YWJsZSBhbmQgaW1tdXRhYmxlIHNpZ25hdHVyZSBpcyB0aGUgc2Vj
dXJpdHkuaW1hIHhhdHRyDQo+ID4gPiA+ID4gcmVxdWlyZW1lbnQuIMKgU2luY2UgdGhlIG5ldyBF
Vk0gc2lnbmF0dXJlIGRvZXMgbm90IGluY2x1ZGUgdGhlDQo+ID4gPiA+ID4gZmlsZXN5c3RlbSBz
cGVjaWZpYyBkYXRhLCBzb21ldGhpbmcgZWxzZSBuZWVkcyB0byBiaW5kIHRoZSBmaWxlDQo+ID4g
PiA+ID4gbWV0YWRhdGEgdG8gdGhlIGZpbGUgZGF0YS4gwqBUaHVzIHRoZSBJTUEgeGF0dHIgcmVx
dWlyZW1lbnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBc3N1bWluZyB0aGF0IHRoZSBuZXcgRVZN
IHNpZ25hdHVyZSBpcyB3cml0dGVuIGxhc3QsIGFzIGxvbmcgYXMgdGhlcmUNCj4gPiA+ID4gPiBp
cyBhbiBJTUEgeGF0dHIsIHRoZXJlIHNob3VsZG4ndCBiZSBhIHByb2JsZW0gd3JpdGluZyB0aGUg
bmV3IEVWTQ0KPiA+ID4gPiA+IHNpZ25hdHVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAv
KiBmaXJzdCBuZWVkIHRvIGtub3cgdGhlIHNpZyB0eXBlICovDQo+ID4gPiA+ICAgICAgICAgcmMg
PSB2ZnNfZ2V0eGF0dHJfYWxsb2MoZGVudHJ5LCBYQVRUUl9OQU1FX0VWTSwgKGNoYXINCj4gPiA+
ICoqKSZ4YXR0cl9kYXRhLCAwLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEdGUF9OT0ZTKTsNCj4gPiA+ID4gICAgICAgICBpZiAocmMgPD0gMCkgew0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgZXZtX3N0YXR1cyA9IElOVEVHUklUWV9GQUlMOw0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgaWYgKHJjID09IC1FTk9EQVRBKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHJjID0gZXZtX2ZpbmRfcHJvdGVjdGVkX3hhdHRycyhkZW50cnkpOw0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmMgPiAwKQ0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGV2bV9zdGF0dXMgPSBJTlRFR1JJVFlfTk9MQUJFTDsNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAocmMgPT0gMCkNCj4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldm1fc3RhdHVzID0gSU5URUdSSVRZX05P
WEFUVFJTOyAvKiBuZXcgZmlsZSAqLw0KPiA+ID4gPg0KPiA+ID4gPiBJZiBFVk1fQUxMT1dfTUVU
QURBVEFfV1JJVEVTIGlzIGNsZWFyZWQsIG9ubHkgdGhlIGZpcnN0IHhhdHRyDQo+ID4gPiA+IGNh
biBiZSB3cml0dGVuIChzdGF0dXMgSU5URUdSSVRZX05PWEFUVFJTIGlzIG9rKS4gQWZ0ZXIsDQo+
ID4gPiA+IGV2bV9maW5kX3Byb3RlY3RlZF94YXR0cnMoKSByZXR1cm5zIHJjID4gMCwgc28gdGhl
IHN0YXR1cyBpcw0KPiA+ID4gPiBJTlRFR1JJVFlfTk9MQUJFTCwgd2hpY2ggaXMgbm90IGlnbm9y
ZWQgYnkgZXZtX3Byb3RlY3RfeGF0dHIoKS4NCj4gPiA+DQo+ID4gPiBXaXRoIEVWTSBITUFDIGVu
YWJsZWQsIGFzIGEgcmVzdWx0IG9mIHdyaXRpbmcgdGhlIGZpcnN0IHByb3RlY3RlZA0KPiA+ID4g
eGF0dHIsIGFuIEVWTSBITUFDIHNob3VsZCBiZSBjYWxjdWxhdGVkIGFuZCB3cml0dGVuIGluDQo+
ID4gPiBldm1faW5vZGVfcG9zdF9zZXR4YXR0cigpLg0KPiA+DQo+ID4gVG8gc29sdmUgdGhlIG9y
ZGVyaW5nIGlzc3VlLCB3b3VsZG4ndCBhbGxvd2luZyBzZXR4YXR0cigpIG9uIGEgZmlsZQ0KPiA+
IHdpdGggcG9ydGFibGUgc2lnbmF0dXJlIHRoYXQgZG9lcyBub3QgeWV0IHBhc3MgdmVyaWZpY2F0
aW9uIGJlIHNhZmU/DQo+ID4gZXZtX3VwZGF0ZV9ldm14YXR0cigpIGNoZWNrcyBpZiB0aGUgc2ln
bmF0dXJlIGlzIHBvcnRhYmxlIGFuZA0KPiA+IGlmIHllcywgZG9lcyBub3QgY2FsY3VsYXRlIHRo
ZSBITUFDLg0KPiANCj4gQmVmb3JlIGFncmVlaW5nIHRvIGFsbG93aW5nIHRoZSBwcm90ZWN0ZWQg
eGF0dHJzIHRvIGJlIHdyaXR0ZW4gb24gYQ0KPiBmaWxlIHdpdGggYSBwb3J0YWJsZSBzaWduYXR1
cmUgdGhhdCBkb2VzIG5vdCB5ZXQgcGFzcyB2ZXJpZmljYXRpb24gYXJlDQo+IHNhZmUsIHdvdWxk
IHdlIGJlIGludHJvZHVjaW5nIGFueSBuZXcgdHlwZXMgb2YgYXR0YWNrcz8NCg0KQWxsb3dpbmcg
eGF0dHIvYXR0ciB1cGRhdGUgbWVhbnMgdGhhdCBzb21lb25lIGNhbiBkbzoNCg0Kc2V0eGF0dHIo
cGF0aCwgInNlY3VyaXR5LmV2bSIsIC4uLik7CXdpdGggdHlwZT01DQoNCmFsbCBzdWJzZXF1ZW50
IHNldHhhdHRyKCkvc2V0YXR0cigpIHN1Y2NlZWQgdW50aWwgdGhlIGNvcnJlY3QNCmNvbWJpbmF0
aW9uIGlzIHNldC4NCg0KQXQgdGhhdCBwb2ludCwgYW55IHhhdHRyL2F0dHIgb3BlcmF0aW9uIGZh
aWxzLCBldmVuIGlmIG9uZSB0cmllcyB0byBzZXQNCmFuIHhhdHRyIHdpdGggdGhlIHNhbWUgdmFs
dWUuIElmIHdlIHN0aWxsIGRlbnkgdGhlIG9wZXJhdGlvbiB3aGVuIHRoZQ0KdmVyaWZpY2F0aW9u
IHN1Y2NlZWRzLCB3ZSBoYXZlIHRvIGZpeCB0aGF0Lg0KDQpJdCBpcyBjb21tb24gdGhhdCB0aGUg
c2lnbmF0dXJlIHBhc3NlcyB2ZXJpZmljYXRpb24gYmVmb3JlIHVzZXIgc3BhY2UNCnRvb2xzIGZp
bmlzaCB0byBzZXQgeGF0dHJzL2F0dHJzLiBGb3IgZXhhbXBsZSwgaWYgYSBmaWxlIGlzIGNyZWF0
ZWQgd2l0aA0KbW9kZSA2NDQgYW5kIHRoaXMgd2FzIHRoZSBtb2RlIGF0IHRoZSB0aW1lIG9mIHNp
Z25pbmcsIGFueSBhdHRlbXB0DQpieSB0YXIgZm9yIGV4YW1wbGUgdG8gc2V0IGFnYWluIHRoZSBz
YW1lIG1vZGUgZmFpbHMuDQoNCklmIGFsbG93aW5nIGEgY2hhbmdlIG9mIHhhdHRycy9hdHRycyBm
b3IgcG9ydGFibGUgc2lnbmF0dXJlcyBpcyBzYWZlIG9yDQpub3QsIEkgd291bGQgc2F5IHllcy4g
UG9ydGFibGUgc2lnbmF0dXJlcyBjYW5ub3QgYmUgbW9kaWZpZWQgZXZlbg0KaWYgX192ZnNfc2V0
eGF0dHJfbm9wZXJtKCkgaXMgY2FsbGVkIGRpcmVjdGx5Lg0KDQo+IEZvciBleGFtcGxlLCB3b3Vs
ZCB3ZSBkaWZmZXJlbnRpYXRlIGJldHdlZW4gcG9ydGFibGUgc2lnbmF0dXJlcyB0aGF0DQo+IGRv
bid0IHBhc3MgdmVyaWZpY2F0aW9uIGFuZCBvbmVzIHRoYXQgZG8/IMKgSWYgd2UgZG9uJ3QgZGlm
ZmVyZW50aWF0ZSwNCj4gY291bGQgaXQgYmUgdXNlZCBmb3IgRG9TPyDCoFNob3VsZCBpdCBiZSBs
aW1pdGVkIHRvIG5ldyBmaWxlcz8NCg0KSSB3b3VsZCBwcmVmZXIgdG8gbG9jayBmaWxlcyB3aGVu
IHNpZ25hdHVyZXMgcGFzcyB0aGUgdmVyaWZpY2F0aW9uIHRvDQphdm9pZCBhY2NpZGVudGFsIGNo
YW5nZXMuDQoNClVubGVzcyB3ZSBmaW5kIGEgYmV0dGVyIHdheSB0byBpZGVudGlmeSBuZXcgZmls
ZSwgd2l0aG91dCBkZXBlbmRpbmcNCm9uIHRoZSBhcHByYWlzYWwgcG9saWN5LCBJIHdvdWxkIGFs
bG93IHRoZSBvcGVyYXRpb24gZXZlbiBmb3IgZXhpc3RpbmcNCmZpbGVzLg0KDQpSb2JlcnRvDQoN
CkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3NlbGRvcmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2lu
ZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlhbiwgU2hpIFlhbmxpDQo=
