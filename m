Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56D51CFABF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgELQbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 12:31:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbgELQbj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 12:31:39 -0400
Received: from lhreml731-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6A6C8B1834534D466D91;
        Tue, 12 May 2020 17:31:32 +0100 (IST)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml731-chm.china.huawei.com (10.201.108.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 12 May 2020 17:31:32 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 18:31:31 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 12 May 2020 18:31:31 +0200
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
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IIAAb0AAgAApg3CAADIngIAAzgGAgACHqACABHSroIAAjWsAgAC7FtCAAFxigIAAJvQA///zHACAACsKoA==
Date:   Tue, 12 May 2020 16:31:31 +0000
Message-ID: <fcdb168d27214b5e85c3b741f184cde9@huawei.com>
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
In-Reply-To: <1589298622.5098.67.camel@linux.ibm.com>
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
VHVlc2RheSwgTWF5IDEyLCAyMDIwIDU6NTAgUE0NCj4gT24gVHVlLCAyMDIwLTA1LTEyIGF0IDE1
OjMxICswMDAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+ID4gRnJvbTogb3duZXItbGludXgt
c2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOm93bmVyLQ0KPiBsaW51eC0N
Cj4gPiA+IHNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBNaW1p
IFpvaGFyDQo+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXkgMTIsIDIwMjAgNDoxNyBQTQ0KPiA+ID4g
T24gVHVlLCAyMDIwLTA1LTEyIGF0IDA3OjU0ICswMDAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0K
PiA+ID4gPiA+ID4gPiBSb2JlcnRvLCBFVk0gaXMgb25seSB0cmlnZ2VyZWQgYnkgSU1BLCB1bmxl
c3MgeW91J3ZlIG1vZGlmaWVkDQo+IHRoZQ0KPiA+ID4gPiA+ID4gPiBrZXJuZWwgdG8gZG8gb3Ro
ZXJ3aXNlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEVWTSB3b3VsZCBkZW55IHhhdHRyL2F0
dHIgb3BlcmF0aW9ucyBldmVuIGlmIElNQSBpcyBkaXNhYmxlZCBpbg0KPiB0aGUNCj4gPiA+ID4g
PiA+IGtlcm5lbCBjb25maWd1cmF0aW9uLiBGb3IgZXhhbXBsZSwgZXZtX3NldHhhdHRyKCkgcmV0
dXJucyB0aGUNCj4gdmFsdWUNCj4gPiA+ID4gPiA+IGZyb20gZXZtX3Byb3RlY3RfeGF0dHIoKS4g
SU1BIGlzIG5vdCBpbnZvbHZlZCB0aGVyZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENvbW1pdMKg
YWUxYmExNjc2Yjg4ICgiRVZNOiBBbGxvdyB1c2VybGFuZCB0byBwZXJtaXQgbW9kaWZpY2F0aW9u
DQo+IG9mDQo+ID4gPiA+ID4gRVZNLXByb3RlY3RlZCBtZXRhZGF0YSIpDQo+ID4gPiBpbnRyb2R1
Y2VkwqBFVk1fQUxMT1dfTUVUQURBVEFfV1JJVEVTDQo+ID4gPiA+ID4gdG8gYWxsb3cgd3JpdGlu
ZyB0aGUgRVZNIHBvcnRhYmxlIGFuZCBpbW11dGFibGUgZmlsZSBzaWduYXR1cmVzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBBY2NvcmRpbmcgdG8gRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9ldm06DQo+
ID4gPiA+DQo+ID4gPiA+IE5vdGUgdGhhdCBvbmNlIGEga2V5IGhhcyBiZWVuIGxvYWRlZCwgaXQg
d2lsbCBubyBsb25nZXIgYmUNCj4gPiA+ID4gcG9zc2libGUgdG8gZW5hYmxlIG1ldGFkYXRhIG1v
ZGlmaWNhdGlvbi4NCj4gPiA+DQo+ID4gPiBOb3QgYW55IGtleSwgYnV0IHRoZSBITUFDIGtleS4N
Cj4gPiA+DQo+ID4gPiAywqDCoMKgwqDCoMKgwqDCoMKgUGVybWl0IG1vZGlmaWNhdGlvbiBvZiBF
Vk0tcHJvdGVjdGVkIG1ldGFkYXRhIGF0DQo+ID4gPiDCoCDCoCDCoCDCoCDCoCBydW50aW1lLiBO
b3Qgc3VwcG9ydGVkIGlmIEhNQUMgdmFsaWRhdGlvbiBhbmQNCj4gPiA+IMKgIMKgIMKgIMKgIMKg
IGNyZWF0aW9uIGlzIGVuYWJsZWQuDQo+ID4NCj4gPiAjaWZkZWYgQ09ORklHX0VWTV9MT0FEX1g1
MDkNCj4gPiB2b2lkIF9faW5pdCBldm1fbG9hZF94NTA5KHZvaWQpDQo+ID4gew0KPiA+IFsuLi5d
DQo+ID4gICAgICAgICByYyA9IGludGVncml0eV9sb2FkX3g1MDkoSU5URUdSSVRZX0tFWVJJTkdf
RVZNLA0KPiBDT05GSUdfRVZNX1g1MDlfUEFUSCk7DQo+ID4gICAgICAgICBpZiAoIXJjKQ0KPiA+
ICAgICAgICAgICAgICAgICBldm1faW5pdGlhbGl6ZWQgfD0gRVZNX0lOSVRfWDUwOTsNCj4gPg0K
PiA+DQo+ID4gc3RhdGljIHNzaXplX3QgZXZtX3dyaXRlX2tleShzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiA+IHsNCj4gPiBbLi4uXQ0KPiA+ICAgICAg
ICAgLyogRG9uJ3QgYWxsb3cgYSByZXF1ZXN0IHRvIGZyZXNobHkgZW5hYmxlIG1ldGFkYXRhIHdy
aXRlcyBpZg0KPiA+ICAgICAgICAgICoga2V5cyBhcmUgbG9hZGVkLg0KPiA+ICAgICAgICAgICov
DQo+ID4gICAgICAgICBpZiAoKGkgJiBFVk1fQUxMT1dfTUVUQURBVEFfV1JJVEVTKSAmJg0KPiA+
ICAgICAgICAgICAgICgoZXZtX2luaXRpYWxpemVkICYgRVZNX0tFWV9NQVNLKSAhPSAwKSAmJg0K
PiA+ICAgICAgICAgICAgICEoZXZtX2luaXRpYWxpemVkICYgRVZNX0FMTE9XX01FVEFEQVRBX1dS
SVRFUykpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRVBFUk07DQo+ID4NCj4gPiBTaG91
bGQgaGF2ZSBiZWVuOg0KPiA+DQo+ID4gICAgICAgICBpZiAoKGkgJiBFVk1fQUxMT1dfTUVUQURB
VEFfV1JJVEVTKSAmJg0KPiA+ICAgICAgICAgICAgICgoZXZtX2luaXRpYWxpemVkICYgRVZNX0lO
SVRfSE1BQykgIT0gMCkgJiYNCj4gPiAgICAgICAgICAgICAhKGV2bV9pbml0aWFsaXplZCAmIEVW
TV9BTExPV19NRVRBREFUQV9XUklURVMpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVQ
RVJNOw0KPiANCj4gT2sNCj4gDQo+ID4NCj4gPiA+IEVhY2ggdGltZSB0aGUgRVZNIHByb3RlY3Rl
ZCBmaWxlIG1ldGFkYXRhIGlzIHVwZGF0ZWQsIHRoZSBFVk0gSE1BQw0KPiBpcw0KPiA+ID4gdXBk
YXRlZCwgYXNzdW1pbmcgdGhlIGV4aXN0aW5nIEVWTSBITUFDIGlzIHZhbGlkLiDCoFVzZXJzcGFj
ZSBzaG91bGQNCj4gPiA+IG5vdCBoYXZlIGFjY2VzcyB0byB0aGUgSE1BQyBrZXksIHNvIHdlIG9u
bHkgYWxsb3cgd3JpdGluZyBFVk0NCj4gPiA+IHNpZ25hdHVyZXMuDQo+ID4gPg0KPiA+ID4gVGhl
IG9ubHkgZGlmZmVyZW5jZSBiZXR3ZWVuIHdyaXRpbmcgdGhlIG9yaWdpbmFsIEVWTSBzaWduYXR1
cmUgYW5kIHRoZQ0KPiA+ID4gbmV3IHBvcnRhYmxlIGFuZCBpbW11dGFibGUgc2lnbmF0dXJlIGlz
IHRoZSBzZWN1cml0eS5pbWEgeGF0dHINCj4gPiA+IHJlcXVpcmVtZW50LiDCoFNpbmNlIHRoZSBu
ZXcgRVZNIHNpZ25hdHVyZSBkb2VzIG5vdCBpbmNsdWRlIHRoZQ0KPiA+ID4gZmlsZXN5c3RlbSBz
cGVjaWZpYyBkYXRhLCBzb21ldGhpbmcgZWxzZSBuZWVkcyB0byBiaW5kIHRoZSBmaWxlDQo+ID4g
PiBtZXRhZGF0YSB0byB0aGUgZmlsZSBkYXRhLiDCoFRodXMgdGhlIElNQSB4YXR0ciByZXF1aXJl
bWVudC4NCj4gPiA+DQo+ID4gPiBBc3N1bWluZyB0aGF0IHRoZSBuZXcgRVZNIHNpZ25hdHVyZSBp
cyB3cml0dGVuIGxhc3QsIGFzIGxvbmcgYXMgdGhlcmUNCj4gPiA+IGlzIGFuIElNQSB4YXR0ciwg
dGhlcmUgc2hvdWxkbid0IGJlIGEgcHJvYmxlbSB3cml0aW5nIHRoZSBuZXcgRVZNDQo+ID4gPiBz
aWduYXR1cmUuDQo+ID4NCj4gPiAgICAgICAgIC8qIGZpcnN0IG5lZWQgdG8ga25vdyB0aGUgc2ln
IHR5cGUgKi8NCj4gPiAgICAgICAgIHJjID0gdmZzX2dldHhhdHRyX2FsbG9jKGRlbnRyeSwgWEFU
VFJfTkFNRV9FVk0sIChjaGFyDQo+ICoqKSZ4YXR0cl9kYXRhLCAwLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgR0ZQX05PRlMpOw0KPiA+ICAgICAgICAgaWYgKHJjIDw9IDAp
IHsNCj4gPiAgICAgICAgICAgICAgICAgZXZtX3N0YXR1cyA9IElOVEVHUklUWV9GQUlMOw0KPiA+
ICAgICAgICAgICAgICAgICBpZiAocmMgPT0gLUVOT0RBVEEpIHsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICByYyA9IGV2bV9maW5kX3Byb3RlY3RlZF94YXR0cnMoZGVudHJ5KTsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAocmMgPiAwKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZXZtX3N0YXR1cyA9IElOVEVHUklUWV9OT0xBQkVMOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKHJjID09IDApDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBldm1fc3RhdHVzID0gSU5URUdSSVRZX05PWEFUVFJTOyAvKiBuZXcg
ZmlsZSAqLw0KPiA+DQo+ID4gSWYgRVZNX0FMTE9XX01FVEFEQVRBX1dSSVRFUyBpcyBjbGVhcmVk
LCBvbmx5IHRoZSBmaXJzdCB4YXR0cg0KPiA+IGNhbiBiZSB3cml0dGVuIChzdGF0dXMgSU5URUdS
SVRZX05PWEFUVFJTIGlzIG9rKS4gQWZ0ZXIsDQo+ID4gZXZtX2ZpbmRfcHJvdGVjdGVkX3hhdHRy
cygpIHJldHVybnMgcmMgPiAwLCBzbyB0aGUgc3RhdHVzIGlzDQo+ID4gSU5URUdSSVRZX05PTEFC
RUwsIHdoaWNoIGlzIG5vdCBpZ25vcmVkIGJ5IGV2bV9wcm90ZWN0X3hhdHRyKCkuDQo+IA0KPiBX
aXRoIEVWTSBITUFDIGVuYWJsZWQsIGFzIGEgcmVzdWx0IG9mIHdyaXRpbmcgdGhlIGZpcnN0IHBy
b3RlY3RlZA0KPiB4YXR0ciwgYW4gRVZNIEhNQUMgc2hvdWxkIGJlIGNhbGN1bGF0ZWQgYW5kIHdy
aXR0ZW4gaW4NCj4gZXZtX2lub2RlX3Bvc3Rfc2V0eGF0dHIoKS4NCg0KVG8gc29sdmUgdGhlIG9y
ZGVyaW5nIGlzc3VlLCB3b3VsZG4ndCBhbGxvd2luZyBzZXR4YXR0cigpIG9uIGEgZmlsZQ0Kd2l0
aCBwb3J0YWJsZSBzaWduYXR1cmUgdGhhdCBkb2VzIG5vdCB5ZXQgcGFzcyB2ZXJpZmljYXRpb24g
YmUgc2FmZT8NCmV2bV91cGRhdGVfZXZteGF0dHIoKSBjaGVja3MgaWYgdGhlIHNpZ25hdHVyZSBp
cyBwb3J0YWJsZSBhbmQNCmlmIHllcywgZG9lcyBub3QgY2FsY3VsYXRlIHRoZSBITUFDLg0KDQpS
b2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3NlbGRvcmYgR21iSCwgSFJCIDU2MDYz
DQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlhbiwgU2hpIFlhbmxpDQo=
