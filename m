Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B41CF930
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 17:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgELPbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 11:31:05 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgELPbE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 11:31:04 -0400
Received: from lhreml720-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 875C7694F362539982F7;
        Tue, 12 May 2020 16:31:02 +0100 (IST)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml720-chm.china.huawei.com (10.201.108.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 12 May 2020 16:31:02 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 17:31:01 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 12 May 2020 17:31:01 +0200
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
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IIAAb0AAgAApg3CAADIngIAAzgGAgACHqACABHSroIAAjWsAgAC7FtCAAFxigIAAJvQA
Date:   Tue, 12 May 2020 15:31:01 +0000
Message-ID: <d3f4a53e386d4bb1b8c608ac8b6bec1f@huawei.com>
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
In-Reply-To: <1589293025.5098.53.camel@linux.ibm.com>
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

PiBGcm9tOiBvd25lci1saW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnIFttYWls
dG86b3duZXItbGludXgtDQo+IHNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmddIE9uIEJl
aGFsZiBPZiBNaW1pIFpvaGFyDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxMiwgMjAyMCA0OjE3IFBN
DQo+IE9uIFR1ZSwgMjAyMC0wNS0xMiBhdCAwNzo1NCArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90
ZToNCj4gPiA+ID4gPiBSb2JlcnRvLCBFVk0gaXMgb25seSB0cmlnZ2VyZWQgYnkgSU1BLCB1bmxl
c3MgeW91J3ZlIG1vZGlmaWVkIHRoZQ0KPiA+ID4gPiA+IGtlcm5lbCB0byBkbyBvdGhlcndpc2Uu
DQo+ID4gPiA+DQo+ID4gPiA+IEVWTSB3b3VsZCBkZW55IHhhdHRyL2F0dHIgb3BlcmF0aW9ucyBl
dmVuIGlmIElNQSBpcyBkaXNhYmxlZCBpbiB0aGUNCj4gPiA+ID4ga2VybmVsIGNvbmZpZ3VyYXRp
b24uIEZvciBleGFtcGxlLCBldm1fc2V0eGF0dHIoKSByZXR1cm5zIHRoZSB2YWx1ZQ0KPiA+ID4g
PiBmcm9tIGV2bV9wcm90ZWN0X3hhdHRyKCkuIElNQSBpcyBub3QgaW52b2x2ZWQgdGhlcmUuDQo+
ID4gPg0KPiA+ID4gQ29tbWl0wqBhZTFiYTE2NzZiODggKCJFVk06IEFsbG93IHVzZXJsYW5kIHRv
IHBlcm1pdCBtb2RpZmljYXRpb24gb2YNCj4gPiA+IEVWTS1wcm90ZWN0ZWQgbWV0YWRhdGEiKQ0K
PiBpbnRyb2R1Y2VkwqBFVk1fQUxMT1dfTUVUQURBVEFfV1JJVEVTDQo+ID4gPiB0byBhbGxvdyB3
cml0aW5nIHRoZSBFVk0gcG9ydGFibGUgYW5kIGltbXV0YWJsZSBmaWxlIHNpZ25hdHVyZXMuDQo+
ID4NCj4gPiBBY2NvcmRpbmcgdG8gRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9ldm06DQo+ID4N
Cj4gPiBOb3RlIHRoYXQgb25jZSBhIGtleSBoYXMgYmVlbiBsb2FkZWQsIGl0IHdpbGwgbm8gbG9u
Z2VyIGJlDQo+ID4gcG9zc2libGUgdG8gZW5hYmxlIG1ldGFkYXRhIG1vZGlmaWNhdGlvbi4NCj4g
DQo+IE5vdCBhbnkga2V5LCBidXQgdGhlIEhNQUMga2V5Lg0KPiANCj4gMsKgwqDCoMKgwqDCoMKg
wqDCoFBlcm1pdCBtb2RpZmljYXRpb24gb2YgRVZNLXByb3RlY3RlZCBtZXRhZGF0YSBhdA0KPiDC
oCDCoCDCoCDCoCDCoCBydW50aW1lLiBOb3Qgc3VwcG9ydGVkIGlmIEhNQUMgdmFsaWRhdGlvbiBh
bmQNCj4gwqAgwqAgwqAgwqAgwqAgY3JlYXRpb24gaXMgZW5hYmxlZC4NCg0KI2lmZGVmIENPTkZJ
R19FVk1fTE9BRF9YNTA5DQp2b2lkIF9faW5pdCBldm1fbG9hZF94NTA5KHZvaWQpDQp7DQpbLi4u
XQ0KICAgICAgICByYyA9IGludGVncml0eV9sb2FkX3g1MDkoSU5URUdSSVRZX0tFWVJJTkdfRVZN
LCBDT05GSUdfRVZNX1g1MDlfUEFUSCk7DQogICAgICAgIGlmICghcmMpDQogICAgICAgICAgICAg
ICAgZXZtX2luaXRpYWxpemVkIHw9IEVWTV9JTklUX1g1MDk7DQoNCg0Kc3RhdGljIHNzaXplX3Qg
ZXZtX3dyaXRlX2tleShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3Mp
DQp7DQpbLi4uXQ0KICAgICAgICAvKiBEb24ndCBhbGxvdyBhIHJlcXVlc3QgdG8gZnJlc2hseSBl
bmFibGUgbWV0YWRhdGEgd3JpdGVzIGlmDQogICAgICAgICAqIGtleXMgYXJlIGxvYWRlZC4NCiAg
ICAgICAgICovDQogICAgICAgIGlmICgoaSAmIEVWTV9BTExPV19NRVRBREFUQV9XUklURVMpICYm
DQogICAgICAgICAgICAoKGV2bV9pbml0aWFsaXplZCAmIEVWTV9LRVlfTUFTSykgIT0gMCkgJiYN
CiAgICAgICAgICAgICEoZXZtX2luaXRpYWxpemVkICYgRVZNX0FMTE9XX01FVEFEQVRBX1dSSVRF
UykpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCg0KU2hvdWxkIGhhdmUgYmVlbjoN
Cg0KICAgICAgICBpZiAoKGkgJiBFVk1fQUxMT1dfTUVUQURBVEFfV1JJVEVTKSAmJg0KICAgICAg
ICAgICAgKChldm1faW5pdGlhbGl6ZWQgJiBFVk1fSU5JVF9ITUFDKSAhPSAwKSAmJg0KICAgICAg
ICAgICAgIShldm1faW5pdGlhbGl6ZWQgJiBFVk1fQUxMT1dfTUVUQURBVEFfV1JJVEVTKSkNCiAg
ICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0KDQo+IEVhY2ggdGltZSB0aGUgRVZNIHByb3Rl
Y3RlZCBmaWxlIG1ldGFkYXRhIGlzIHVwZGF0ZWQsIHRoZSBFVk0gSE1BQyBpcw0KPiB1cGRhdGVk
LCBhc3N1bWluZyB0aGUgZXhpc3RpbmcgRVZNIEhNQUMgaXMgdmFsaWQuIMKgVXNlcnNwYWNlIHNo
b3VsZA0KPiBub3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIEhNQUMga2V5LCBzbyB3ZSBvbmx5IGFsbG93
IHdyaXRpbmcgRVZNDQo+IHNpZ25hdHVyZXMuDQo+IA0KPiBUaGUgb25seSBkaWZmZXJlbmNlIGJl
dHdlZW4gd3JpdGluZyB0aGUgb3JpZ2luYWwgRVZNIHNpZ25hdHVyZSBhbmQgdGhlDQo+IG5ldyBw
b3J0YWJsZSBhbmQgaW1tdXRhYmxlIHNpZ25hdHVyZSBpcyB0aGUgc2VjdXJpdHkuaW1hIHhhdHRy
DQo+IHJlcXVpcmVtZW50LiDCoFNpbmNlIHRoZSBuZXcgRVZNIHNpZ25hdHVyZSBkb2VzIG5vdCBp
bmNsdWRlIHRoZQ0KPiBmaWxlc3lzdGVtIHNwZWNpZmljIGRhdGEsIHNvbWV0aGluZyBlbHNlIG5l
ZWRzIHRvIGJpbmQgdGhlIGZpbGUNCj4gbWV0YWRhdGEgdG8gdGhlIGZpbGUgZGF0YS4gwqBUaHVz
IHRoZSBJTUEgeGF0dHIgcmVxdWlyZW1lbnQuDQo+IA0KPiBBc3N1bWluZyB0aGF0IHRoZSBuZXcg
RVZNIHNpZ25hdHVyZSBpcyB3cml0dGVuIGxhc3QsIGFzIGxvbmcgYXMgdGhlcmUNCj4gaXMgYW4g
SU1BIHhhdHRyLCB0aGVyZSBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtIHdyaXRpbmcgdGhlIG5ldyBF
Vk0NCj4gc2lnbmF0dXJlLg0KDQogICAgICAgIC8qIGZpcnN0IG5lZWQgdG8ga25vdyB0aGUgc2ln
IHR5cGUgKi8NCiAgICAgICAgcmMgPSB2ZnNfZ2V0eGF0dHJfYWxsb2MoZGVudHJ5LCBYQVRUUl9O
QU1FX0VWTSwgKGNoYXIgKiopJnhhdHRyX2RhdGEsIDAsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEdGUF9OT0ZTKTsNCiAgICAgICAgaWYgKHJjIDw9IDApIHsNCiAgICAgICAgICAg
ICAgICBldm1fc3RhdHVzID0gSU5URUdSSVRZX0ZBSUw7DQogICAgICAgICAgICAgICAgaWYgKHJj
ID09IC1FTk9EQVRBKSB7DQogICAgICAgICAgICAgICAgICAgICAgICByYyA9IGV2bV9maW5kX3By
b3RlY3RlZF94YXR0cnMoZGVudHJ5KTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyYyA+
IDApDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2bV9zdGF0dXMgPSBJTlRFR1JJ
VFlfTk9MQUJFTDsNCiAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKHJjID09IDApDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2bV9zdGF0dXMgPSBJTlRFR1JJVFlfTk9Y
QVRUUlM7IC8qIG5ldyBmaWxlICovDQoNCklmIEVWTV9BTExPV19NRVRBREFUQV9XUklURVMgaXMg
Y2xlYXJlZCwgb25seSB0aGUgZmlyc3QgeGF0dHINCmNhbiBiZSB3cml0dGVuIChzdGF0dXMgSU5U
RUdSSVRZX05PWEFUVFJTIGlzIG9rKS4gQWZ0ZXIsDQpldm1fZmluZF9wcm90ZWN0ZWRfeGF0dHJz
KCkgcmV0dXJucyByYyA+IDAsIHNvIHRoZSBzdGF0dXMgaXMNCklOVEVHUklUWV9OT0xBQkVMLCB3
aGljaCBpcyBub3QgaWdub3JlZCBieSBldm1fcHJvdGVjdF94YXR0cigpLg0KDQpSb2JlcnRvDQoN
CkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3NlbGRvcmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2lu
ZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlhbiwgU2hpIFlhbmxpDQo=
