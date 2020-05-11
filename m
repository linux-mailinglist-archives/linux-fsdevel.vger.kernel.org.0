Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6337C1CDCCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgEKONz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 10:13:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730227AbgEKONz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 10:13:55 -0400
Received: from lhreml719-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 71607F49943FEEF7C06D;
        Mon, 11 May 2020 15:13:53 +0100 (IST)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml719-chm.china.huawei.com (10.201.108.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Mon, 11 May 2020 15:13:53 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 11 May 2020 16:13:52 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Mon, 11 May 2020 16:13:52 +0200
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
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IIAAb0AAgAApg3CAADIngIAAzgGAgACHqACABHSroA==
Date:   Mon, 11 May 2020 14:13:52 +0000
Message-ID: <414644a0be9e4af880452f4b5079aba1@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
         <1588864628.5685.78.camel@linux.ibm.com>
         <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
         <1588884313.5685.110.camel@linux.ibm.com>
         <84e6acad739a415aa3e2457b5c37979f@huawei.com>
 <1588957684.5146.70.camel@linux.ibm.com>
In-Reply-To: <1588957684.5146.70.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.12.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDog
RnJpZGF5LCBNYXkgOCwgMjAyMCA3OjA4IFBNDQo+IE9uIEZyaSwgMjAyMC0wNS0wOCBhdCAxMDoy
MCArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IEZyb206IE1pbWkgWm9oYXIgW21h
aWx0bzp6b2hhckBsaW51eC5pYm0uY29tXQ0KPiA+ID4gT24gVGh1LCAyMDIwLTA1LTA3IGF0IDE2
OjQ3ICswMDAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiANCj4gPHNuaXA+DQo+IA0KPiA+ID4g
PiA+IHRoZSBmaWxlIG1ldGFkYXRhIHRvIHRoZSBmaWxlIGRhdGEuIMKgVGhlIElNQSBhbmQgRVZN
IHBvbGljaWVzIHJlYWxseQ0KPiA+ID4gPiA+IG5lZWQgdG8gYmUgaW4gc3luYy4NCj4gPiA+ID4N
Cj4gPiA+ID4gSXQgd291bGQgYmUgbmljZSwgYnV0IGF0IHRoZSBtb21lbnQgRVZNIGNvbnNpZGVy
cyBhbHNvIGZpbGVzIHRoYXQgYXJlDQo+ID4gPiA+IG5vdCBzZWxlY3RlZCBieSB0aGUgSU1BIHBv
bGljeS4gQW4gZXhhbXBsZSBvZiB3aHkgdGhpcyBpcyBhIHByb2JsZW0gaXMNCj4gPiA+ID4gdGhl
IGF1ZGl0IHNlcnZpY2UgdGhhdCBmYWlscyB0byBzdGFydCB3aGVuIGl0IHRyaWVzIHRvIGFkanVz
dCB0aGUNCj4gcGVybWlzc2lvbnMNCj4gPiA+ID4gb2YgdGhlIGxvZyBmaWxlcy4gVGhvc2UgZmls
ZXMgZG9uJ3QgaGF2ZSBzZWN1cml0eS5ldm0gYmVjYXVzZSB0aGV5IGFyZQ0KPiA+ID4gPiBub3Qg
YXBwcmFpc2VkIGJ5IElNQSwgYnV0IEVWTSBkZW5pZXMgdGhlIG9wZXJhdGlvbi4NCj4gPiA+DQo+
ID4gPiBObywgdGhpcyBpcyBhIHRpbWluZyBpc3N1ZSBhcyB0byB3aGV0aGVyIG9yIG5vdCB0aGUg
YnVpbHRpbiBwb2xpY3kgb3INCj4gPiA+IGEgY3VzdG9tIHBvbGljeSBoYXMgYmVlbiBsb2FkZWQu
IMKgQSBjdXN0b20gcG9saWN5IGNvdWxkIGV4Y2x1ZGUgdGhlDQo+ID4gPiBsb2cgZmlsZXMgYmFz
ZWQgb24gTFNNIGxhYmVscywgYnV0IHRoZXkgYXJlIGluY2x1ZGVkIGluIHRoZSBidWlsdGluDQo+
ID4gPiBwb2xpY3kuDQo+ID4NCj4gPiBZZXMsIEkgd2FzIHJlZmVycmluZyB0byBhIGN1c3RvbSBw
b2xpY3kuIEluIHRoaXMgY2FzZSwgRVZNIHdpbGwgbm90IGFkYXB0DQo+ID4gdG8gdGhlIGN1c3Rv
bSBwb2xpY3kgYnV0IHN0aWxsIHZlcmlmaWVzIGFsbCBmaWxlcy4gSWYgYWNjZXNzIGNvbnRyb2wg
aXMgZG9uZQ0KPiA+IGV4Y2x1c2l2ZWx5IGJ5IElNQSBhdCB0aGUgdGltZSBldm1fdmVyaWZ5eGF0
dHIoKSBpcyBjYWxsZWQsIHdlIHdvdWxkbid0DQo+ID4gbmVlZCB0byBhZGQgc2VjdXJpdHkuZXZt
IHRvIGFsbCBmaWxlcy4NCj4gDQo+IFJvYmVydG8sIEVWTSBpcyBvbmx5IHRyaWdnZXJlZCBieSBJ
TUEsIHVubGVzcyB5b3UndmUgbW9kaWZpZWQgdGhlDQo+IGtlcm5lbCB0byBkbyBvdGhlcndpc2Uu
DQoNCkVWTSB3b3VsZCBkZW55IHhhdHRyL2F0dHIgb3BlcmF0aW9ucyBldmVuIGlmIElNQSBpcyBk
aXNhYmxlZCBpbiB0aGUNCmtlcm5lbCBjb25maWd1cmF0aW9uLiBGb3IgZXhhbXBsZSwgZXZtX3Nl
dHhhdHRyKCkgcmV0dXJucyB0aGUgdmFsdWUNCmZyb20gZXZtX3Byb3RlY3RfeGF0dHIoKS4gSU1B
IGlzIG5vdCBpbnZvbHZlZCB0aGVyZS4NCg0KPiBJJ20gbm90IGludGVyZXN0ZWQgaW4gYSBjb21w
bGljYXRlZCBzb2x1dGlvbiwganVzdCBvbmUgdGhhdCBhZGRyZXNzZXMNCj4gdGhlIG5ldyBFVk0g
aW1tdXRhYmxlIGFuZCBwb3J0YWJsZSBzaWduYXR1cmUuIMKgSXQgbWlnaHQgcmVxdWlyZSBFVk0N
Cj4gSE1BQywgSU1BIGRpZmZlcmVudGlhdGluZyBiZXR3ZWVuIGEgbmV3IGZpbGUgYW5kIGFuIGV4
aXN0aW5nIGZpbGUsIG9yDQo+IGl0IG1pZ2h0IHJlcXVpcmUgd3JpdGluZyB0aGUgbmV3IEVWTSBz
aWduYXR1cmUgbGFzdCwgYWZ0ZXIgYWxsIHRoZQ0KPiBvdGhlciB4YXR0cnMgb3IgbWV0YWRhdGEg
YXJlIHVwZGF0ZWQuIMKgUGxlYXNlIG5vdGhpbmcgdGhhdCBjaGFuZ2VzDQo+IGV4aXN0aW5nIGV4
cGVjdGF0aW9ucy4NCg0KT2suIEludHJvZHVjaW5nIHRoZSBuZXcgc3RhdHVzIElOVEVHUklUWV9G
QUlMX0lNTVVUQUJMRSwgYXMgSQ0KbWVudGlvbmVkIGluICdbUEFUQ0hdIGltYTogQWxsb3cgaW1h
c2lnIHJlcXVpcmVtZW50IHRvIGJlIHNhdGlzZmllZCBieQ0KRVZNIHBvcnRhYmxlIHNpZ25hdHVy
ZXMnIHNlZW1zIHRvIGhhdmUgYW4gYWRkaXRpb25hbCBiZW5lZml0LiBXZQ0KY291bGQgaW50cm9k
dWNlIGFuIGFkZGl0aW9uYWwgZXhjZXB0aW9uIGluIGV2bV9wcm90ZWN0X3hhdHRyKCksIG90aGVy
DQp0aGFuIElOVEVHUklUWV9OT1hBVFRSUywgYXMgd2Uga25vdyB0aGF0IHhhdHRyL2F0dHIgdXBk
YXRlIHdvbid0DQpjYXVzZSBITUFDIHVwZGF0ZS4NCg0KSG93ZXZlciwgaXQgd29uJ3Qgd29yayB1
bmxlc3MgdGhlIElNQSBwb2xpY3kgc2F5cyB0aGF0IHRoZSBmaWxlIHNob3VsZA0KYmUgYXBwcmFp
c2VkIHdoZW4gdGhlIG1rbm9kKCkgc3lzdGVtIGNhbGwgaXMgZXhlY3V0ZWQuIE90aGVyd2lzZSwN
CmludGVncml0eV9paW50X2NhY2hlIGlzIG5vdCBjcmVhdGVkIGZvciB0aGUgZmlsZSBhbmQgdGhl
IElNQV9ORVdfRklMRQ0KZmxhZyBpcyBub3Qgc2V0Lg0KDQpHcmFudGluZyBhbiBleGNlcHRpb24g
Zm9yIElOVEVHUklUWV9GQUlMX0lNTVVUQUJMRSBzb2x2ZXMgdGhlIGNhc2UNCndoZXJlIHNlY3Vy
aXR5LmV2bSBpcyB0aGUgZmlyc3QgeGF0dHIgc2V0LiBJZiBhIHByb3RlY3RlZCB4YXR0ciBpcyB0
aGUgZmlyc3QgdG8NCmJlIGFkZGVkLCB0aGVuIHdlIGFsc28gaGF2ZSB0byBoYW5kbGUgdGhlIElO
VEVHUklUWV9OT0xBQkVMIGVycm9yLg0KSXQgc2hvdWxkIGJlIGZpbmUgdG8gYWRkIGFuIGV4Y2Vw
dGlvbiBmb3IgdGhpcyBlcnJvciBpZiB0aGUgSE1BQyBrZXkgaXMgbm90DQpsb2FkZWQuDQoNClRo
aXMgc3RpbGwgZG9lcyBub3Qgc29sdmUgYWxsIHByb2JsZW1zLiBJTlRFR1JJVFlfTk9MQUJFTCBj
YW5ub3QgYmUNCmlnbm9yZWQgaWYgdGhlIEhNQUMga2V5IGlzIGxvYWRlZCwgd2hpY2ggbWVhbnMg
dGhhdCBhbGwgZmlsZXMgbmVlZCB0byBiZQ0KcHJvdGVjdGVkIGJ5IEVWTSB0byBhdm9pZCBpc3N1
ZXMgbGlrZSB0aGUgb25lIEkgZGVzY3JpYmVkIChhdWRpdGQpLg0KDQpSb2JlcnRvDQoNCkhVQVdF
SSBURUNITk9MT0dJRVMgRHVlc3NlbGRvcmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2luZyBEaXJl
Y3RvcjogTGkgUGVuZywgTGkgSmlhbiwgU2hpIFlhbmxpDQo=
