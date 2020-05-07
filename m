Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAC1C96D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEGQsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 12:48:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgEGQsB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 12:48:01 -0400
Received: from lhreml741-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F1CB7F4FD0BDC45C14F0;
        Thu,  7 May 2020 17:47:58 +0100 (IST)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 7 May 2020 17:47:58 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 7 May 2020 18:47:58 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Thu, 7 May 2020 18:47:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "John Johansen" <john.johansen@canonical.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Topic: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IIAAb0AAgAApg3A=
Date:   Thu, 7 May 2020 16:47:58 +0000
Message-ID: <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
 <1588864628.5685.78.camel@linux.ibm.com>
In-Reply-To: <1588864628.5685.78.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.65.97]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gT24gVGh1LCAyMDIwLTA1LTA3IGF0IDA3OjUzICswMDAw
LCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IE1pbWkgWm9oYXIgW21haWx0bzp6b2hhckBsaW51eC5pYm0uY29tXQ0KPiA+
ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgNiwgMjAyMCAxMToxMCBQTQ0KPiA+ID4gVG86IFJvYmVy
dG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47DQo+IGRhdmlkLnNhZmZvcmRAZ21h
aWwuY29tOw0KPiA+ID4gdmlyb0B6ZW5pdi5saW51eC5vcmcudWs7IGptb3JyaXNAbmFtZWkub3Jn
OyBKb2huIEpvaGFuc2VuDQo+ID4gPiA8am9obi5qb2hhbnNlbkBjYW5vbmljYWwuY29tPg0KPiA+
ID4gQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnRlZ3JpdHlAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC0NCj4gPiA+IHNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbHZpdQ0KPiA+ID4gVmxhc2Nl
YW51IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1JG
Q11bUEFUQ0ggMS8zXSBldm06IE1vdmUgaG9va3Mgb3V0c2lkZSBMU00NCj4gaW5mcmFzdHJ1Y3R1
cmUNCj4gDQo+IFJvYmVydG8sIHBsZWFzZSBmaXggeW91ciBtYWlsZXIgb3IgYXQgbGVhc3QgbWFu
dWFsbHkgcmVtb3ZlIHRoaXMgc29ydA0KPiBvZiBpbmZvIGZyb20gdGhlIGVtYWlsLg0KPiANCj4g
PiA+DQo+ID4gPiBPbiBXZWQsIDIwMjAtMDUtMDYgYXQgMTU6NDQgLTA0MDAsIE1pbWkgWm9oYXIg
d3JvdGU6DQo+ID4gPiA+IFNpbmNlIGNvcHlpbmcgdGhlIEVWTSBITUFDIG9yIG9yaWdpbmFsIHNp
Z25hdHVyZSBpc24ndCBhcHBsaWNhYmxlLCBJDQo+ID4gPiA+IHdvdWxkIHByZWZlciBleHBsb3Jp
bmcgYW4gRVZNIHBvcnRhYmxlIGFuZCBpbW11dGFibGUgc2lnbmF0dXJlIG9ubHkNCj4gPiA+ID4g
c29sdXRpb24uDQo+ID4gPg0KPiA+ID4gVG8gcHJldmVudCBjb3B5aW5nIHRoZSBFVk0geGF0dHIs
IHdlIGFkZGVkICJzZWN1cml0eS5ldm0iIHRvDQo+ID4gPiAvZXRjL3hhdHRyLmNvbmYuIMKgVG8g
c3VwcG9ydCBjb3B5aW5nIGp1c3QgdGhlIEVWTSBwb3J0YWJsZSBhbmQNCj4gPiA+IGltbXV0YWJs
ZSBzaWduYXR1cmVzIHdpbGwgcmVxdWlyZSBhIGRpZmZlcmVudCBzb2x1dGlvbi4NCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggc2V0IHJlbW92ZXMgdGhlIG5lZWQgZm9yIGlnbm9yaW5nIHNlY3VyaXR5LmV2
bS4gSXQgY2FuIGJlDQo+IGFsd2F5cw0KPiA+IGNvcGllZCwgZXZlbiBpZiBpdCBpcyBhbiBITUFD
LiBFVk0gd2lsbCB1cGRhdGUgaXQgb25seSB3aGVuIHZlcmlmaWNhdGlvbiBpbg0KPiA+IHRoZSBw
cmUgaG9vayBpcyBzdWNjZXNzZnVsLiBDb21iaW5lZCB3aXRoIHRoZSBhYmlsaXR5IG9mIHByb3Rl
Y3RpbmcgYQ0KPiBzdWJzZXQNCj4gPiBvZiBmaWxlcyB3aXRob3V0IGludHJvZHVjaW5nIGFuIEVW
TSBwb2xpY3ksIHRoZXNlIGFkdmFudGFnZXMgc2VlbSB0bw0KPiA+IG91dHdlaWdoIHRoZSBlZmZv
cnQgbmVjZXNzYXJ5IHRvIG1ha2UgdGhlIHN3aXRjaC4NCj4gDQo+IEFzIHRoZSBFVk0gZmlsZSBI
TUFDIGFuZCBvcmlnaW5hbCBzaWduYXR1cmUgY29udGFpbiBpbm9kZSBzcGVjaWZpYw0KPiBpbmZv
cm1hdGlvbiAoZWcuIGlfdmVyc2lvbiwgaV9nZW5lcmF0aW9uKSwgdGhlc2UgeGF0dHJzIGNhbm5v
dCBldmVyIGJlDQo+IGNvcGllZC4gwqBUaGUgcHJvcG9zZWQgY2hhbmdlIGlzIGluIG9yZGVyIHRv
IHN1cHBvcnQganVzdCB0aGUgbmV3IEVWTQ0KPiBzaWduYXR1cmVzLg0KDQpSaWdodCwgSSBkaWRu
J3QgY29uc2lkZXIgaXQuDQoNCldvdWxkIGl0IG1ha2Ugc2Vuc2UgaW5zdGVhZCB0byBpbnRyb2R1
Y2UgYW4gYWxpYXMgbGlrZSBzZWN1cml0eS5ldm1faW1tdXRhYmxlDQpzbyB0aGF0IHRoaXMgeGF0
dHIgY2FuIGJlIGNvcGllZD8NCg0KPiBBdCBsZWFzdCBJTUEgZmlsZSBoYXNoZXMgc2hvdWxkIGFs
d2F5cyBiZSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGgNCj4gRVZNLiDCoEVWTSB4YXR0cnMgc2hv
dWxkIGFsd2F5cyByZXF1aXJlIGEgc2VjdXJpdHkuaW1hIHhhdHRyIHRvIGJpbmQNCg0KSSBwcm9w
b3NlZCB0byBlbmZvcmNlIHRoaXMgcmVzdHJpY3Rpb24gc29tZSB0aW1lIGFnbzoNCg0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDk3OTM1MS8NCg0KSXMgaXQgb2sgdG8gZW5m
b3JjZSBpdCBnbG9iYWxseT8NCg0KPiB0aGUgZmlsZSBtZXRhZGF0YSB0byB0aGUgZmlsZSBkYXRh
LiDCoFRoZSBJTUEgYW5kIEVWTSBwb2xpY2llcyByZWFsbHkNCj4gbmVlZCB0byBiZSBpbiBzeW5j
Lg0KDQpJdCB3b3VsZCBiZSBuaWNlLCBidXQgYXQgdGhlIG1vbWVudCBFVk0gY29uc2lkZXJzIGFs
c28gZmlsZXMgdGhhdCBhcmUNCm5vdCBzZWxlY3RlZCBieSB0aGUgSU1BIHBvbGljeS4gQW4gZXhh
bXBsZSBvZiB3aHkgdGhpcyBpcyBhIHByb2JsZW0gaXMNCnRoZSBhdWRpdCBzZXJ2aWNlIHRoYXQg
ZmFpbHMgdG8gc3RhcnQgd2hlbiBpdCB0cmllcyB0byBhZGp1c3QgdGhlIHBlcm1pc3Npb25zDQpv
ZiB0aGUgbG9nIGZpbGVzLiBUaG9zZSBmaWxlcyBkb24ndCBoYXZlIHNlY3VyaXR5LmV2bSBiZWNh
dXNlIHRoZXkgYXJlDQpub3QgYXBwcmFpc2VkIGJ5IElNQSwgYnV0IEVWTSBkZW5pZXMgdGhlIG9w
ZXJhdGlvbi4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdt
YkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZ
YW5saQ0K
