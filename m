Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006683AAD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 09:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFQHMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 03:12:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3258 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhFQHME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:12:04 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5CXF1GJCz6K6J6;
        Thu, 17 Jun 2021 14:56:45 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:09:54 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Thu, 17 Jun 2021 09:09:54 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
Thread-Topic: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
Thread-Index: AQHXYrKvlTGLZUZH2kigEMb4WxB9T6sWlCeAgAExqRA=
Date:   Thu, 17 Jun 2021 07:09:54 +0000
Message-ID: <9cb676de40714d0288f85292c1f1a430@huawei.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
 <20210616132227.999256-1-roberto.sassu@huawei.com>
 <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
In-Reply-To: <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBTdGVmYW4gQmVyZ2VyIFttYWlsdG86c3RlZmFuYkBsaW51eC5pYm0uY29tXQ0KPiBT
ZW50OiBXZWRuZXNkYXksIEp1bmUgMTYsIDIwMjEgNDo0MCBQTQ0KPiBPbiA2LzE2LzIxIDk6MjIg
QU0sIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gdmZzX2dldHhhdHRyKCkgZGlmZmVycyBmcm9t
IHZmc19zZXR4YXR0cigpIGluIHRoZSB3YXkgaXQgb2J0YWlucyB0aGUgeGF0dHINCj4gPiB2YWx1
ZS4gVGhlIGZvcm1lciBnaXZlcyBwcmVjZWRlbmNlIHRvIHRoZSBMU01zLCBhbmQgaWYgdGhlIExT
TXMgZG9uJ3QNCj4gPiBwcm92aWRlIGEgdmFsdWUsIG9idGFpbnMgaXQgZnJvbSB0aGUgZmlsZXN5
c3RlbSBoYW5kbGVyLiBUaGUgbGF0dGVyIGRvZXMNCj4gPiB0aGUgb3Bwb3NpdGUsIGZpcnN0IGlu
dm9rZXMgdGhlIGZpbGVzeXN0ZW0gaGFuZGxlciwgYW5kIGlmIHRoZSBmaWxlc3lzdGVtDQo+ID4g
ZG9lcyBub3Qgc3VwcG9ydCB4YXR0cnMsIHBhc3NlcyB0aGUgeGF0dHIgdmFsdWUgdG8gdGhlIExT
TXMuDQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IG5vdCBuZWNlc3NhcmlseSB0aGUgdXNl
ciBnZXRzIHRoZSBzYW1lIHhhdHRyIHZhbHVlIHRoYXQNCj4gPiBoZSBzZXQuIEZvciBleGFtcGxl
LCBpZiBoZSBzZXRzIHNlY3VyaXR5LnNlbGludXggd2l0aCBhIHZhbHVlIG5vdA0KPiA+IHRlcm1p
bmF0ZWQgd2l0aCAnXDAnLCBoZSBnZXRzIGEgdmFsdWUgdGVybWluYXRlZCB3aXRoICdcMCcgYmVj
YXVzZSBTRUxpbnV4DQo+ID4gYWRkcyBpdCBkdXJpbmcgdGhlIHRyYW5zbGF0aW9uIGZyb20geGF0
dHIgdG8gaW50ZXJuYWwgcmVwcmVzZW50YXRpb24NCj4gPiAodmZzX3NldHhhdHRyKCkpIGFuZCBm
cm9tIGludGVybmFsIHJlcHJlc2VudGF0aW9uIHRvIHhhdHRyDQo+ID4gKHZmc19nZXR4YXR0cigp
KS4NCj4gPg0KPiA+IE5vcm1hbGx5LCB0aGlzIGRvZXMgbm90IGhhdmUgYW4gaW1wYWN0IHVubGVz
cyB0aGUgaW50ZWdyaXR5IG9mIHhhdHRycyBpcw0KPiA+IHZlcmlmaWVkIHdpdGggRVZNLiBUaGUg
a2VybmVsIGFuZCB0aGUgdXNlciBzZWUgZGlmZmVyZW50IHZhbHVlcyBkdWUgdG8gdGhlDQo+ID4g
ZGlmZmVyZW50IGZ1bmN0aW9ucyB1c2VkIHRvIG9idGFpbiB0aGVtOg0KPiA+DQo+ID4ga2VybmVs
IChFVk0pOiB1c2VzIHZmc19nZXR4YXR0cl9hbGxvYygpIHdoaWNoIG9idGFpbnMgdGhlIHhhdHRy
IHZhbHVlIGZyb20NCj4gPiAgICAgICAgICAgICAgICB0aGUgZmlsZXN5c3RlbSBoYW5kbGVyIChy
YXcgdmFsdWUpOw0KPiA+DQo+ID4gdXNlciAoaW1hLWV2bS11dGlscyk6IHVzZXMgdmZzX2dldHhh
dHRyKCkgd2hpY2ggb2J0YWlucyB0aGUgeGF0dHIgdmFsdWUNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgIGZyb20gdGhlIExTTXMgKG5vcm1hbGl6ZWQgdmFsdWUpLg0KPiANCj4gTWF5YmUgdGhl
cmUgc2hvdWxkIGJlIGFub3RoZXIgaW1wbGVtZW50YXRpb24gc2ltaWxhciB0bw0KPiB2ZnNfZ2V0
eGF0dHJfYWxsb2MoKSAob3IgbW9kaWZ5IGl0KSB0byBiZWhhdmUgbGlrZSB2ZnNfZ2V0eGF0dHIo
KSBidXQgZG8NCj4gdGhlIG1lbW9yeSBhbGxvY2F0aW9uIHBhcnQgc28gdGhhdCB0aGUga2VybmVs
IHNlZXMgd2hhdCB1c2VyIHNwYWNlIHNlZQ0KPiByYXRoZXIgdGhhbiBtb2RpZnlpbmcgaXQgd2l0
aCB5b3VyIHBhdGNoIHNvIHRoYXQgdXNlciBzcGFjZSBub3cgc2Vlcw0KPiBzb21ldGhpbmcgZGlm
ZmVyZW50IHRoYW4gd2hhdCBpdCBoYXMgYmVlbiBmb3IgeWVhcnMgKHByZXZpb3VzDQo+IE5VTC10
ZXJtaW5hdGVkIFNFTGludXggeGF0dHIgbWF5IG5vdCBiZSBOVUwtdGVybWluYXRlZCBhbnltb3Jl
KT8NCg0KSSdtIGNvbmNlcm5lZCB0aGF0IHRoaXMgd291bGQgYnJlYWsgSE1BQ3MvZGlnaXRhbCBz
aWduYXR1cmVzDQpjYWxjdWxhdGVkIHdpdGggcmF3IHZhbHVlcy4NCg0KQW4gYWx0ZXJuYXRpdmUg
d291bGQgYmUgdG8gZG8gdGhlIEVWTSB2ZXJpZmljYXRpb24gdHdpY2UgaWYgdGhlDQpmaXJzdCB0
aW1lIGRpZG4ndCBzdWNjZWVkICh3aXRoIHZmc19nZXR4YXR0cl9hbGxvYygpIGFuZCB3aXRoIHRo
ZQ0KbmV3IGZ1bmN0aW9uIHRoYXQgYmVoYXZlcyBsaWtlIHZmc19nZXR4YXR0cigpKS4NCg0KUm9i
ZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0K
TWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0KDQo+ICDCoMKg
wqAgU3RlZmFuDQo+IA0KPiANCj4gDQo+IA0KPiA+DQo+ID4gR2l2ZW4gdGhhdCB0aGUgZGlmZmVy
ZW5jZSBiZXR3ZWVuIHRoZSByYXcgdmFsdWUgYW5kIHRoZSBub3JtYWxpemVkIHZhbHVlDQo+ID4g
c2hvdWxkIGJlIGp1c3QgdGhlIGFkZGl0aW9uYWwgJ1wwJyBub3QgdGhlIHJlc3Qgb2YgdGhlIGNv
bnRlbnQsIHRoaXMgcGF0Y2gNCj4gPiBtb2RpZmllcyB2ZnNfZ2V0eGF0dHIoKSB0byBjb21wYXJl
IHRoZSBzaXplIG9mIHRoZSB4YXR0ciB2YWx1ZSBvYnRhaW5lZA0KPiA+IGZyb20gdGhlIExTTXMg
dG8gdGhlIHNpemUgb2YgdGhlIHJhdyB4YXR0ciB2YWx1ZS4gSWYgdGhlcmUgaXMgYSBtaXNtYXRj
aA0KPiA+IGFuZCB0aGUgZmlsZXN5c3RlbSBoYW5kbGVyIGRvZXMgbm90IHJldHVybiBhbiBlcnJv
ciwgdmZzX2dldHhhdHRyKCkgcmV0dXJucw0KPiA+IHRoZSByYXcgdmFsdWUuDQo+ID4NCj4gPiBU
aGlzIHBhdGNoIHNob3VsZCBoYXZlIGEgbWluaW1hbCBpbXBhY3Qgb24gZXhpc3Rpbmcgc3lzdGVt
cywgYmVjYXVzZSBpZiB0aGUNCj4gPiBTRUxpbnV4IGxhYmVsIGlzIHdyaXR0ZW4gd2l0aCB0aGUg
YXBwcm9wcmlhdGUgdG9vbHMgc3VjaCBhcyBzZXRmaWxlcyBvcg0KPiA+IHJlc3RvcmVjb24sIHRo
ZXJlIHdpbGwgbm90IGJlIGEgbWlzbWF0Y2ggKGJlY2F1c2UgdGhlIHJhdyB2YWx1ZSBhbHNvIGhh
cw0KPiA+ICdcMCcpLg0KPiA+DQo+ID4gSW4gdGhlIGNhc2Ugd2hlcmUgdGhlIFNFTGludXggbGFi
ZWwgaXMgd3JpdHRlbiBkaXJlY3RseSB3aXRoIHNldGZhdHRyIGFuZA0KPiA+IHdpdGhvdXQgJ1ww
JywgdGhpcyBwYXRjaCBoZWxwcyB0byBhbGlnbiBFVk0gYW5kIGltYS1ldm0tdXRpbHMgaW4gdGVy
bXMgb2YNCj4gPiByZXN1bHQgcHJvdmlkZWQgKGR1ZSB0byB0aGUgZmFjdCB0aGF0IHRoZXkgYm90
aCB2ZXJpZnkgdGhlIGludGVncml0eSBvZg0KPiA+IHhhdHRycyBmcm9tIHJhdyB2YWx1ZXMpLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3
ZWkuY29tPg0KPiA+IFRlc3RlZC1ieTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGZzL3hhdHRyLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMv
eGF0dHIuYyBiL2ZzL3hhdHRyLmMNCj4gPiBpbmRleCA1YzhjNTE3NWIzODUuLjQxMmVjODc1YWEw
NyAxMDA2NDQNCj4gPiAtLS0gYS9mcy94YXR0ci5jDQo+ID4gKysrIGIvZnMveGF0dHIuYw0KPiA+
IEBAIC00MjAsMTIgKzQyMCwyNyBAQCB2ZnNfZ2V0eGF0dHIoc3RydWN0IHVzZXJfbmFtZXNwYWNl
ICptbnRfdXNlcm5zLA0KPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+ID4gICAJCWNvbnN0IGNo
YXIgKnN1ZmZpeCA9IG5hbWUgKyBYQVRUUl9TRUNVUklUWV9QUkVGSVhfTEVOOw0KPiA+ICAgCQlp
bnQgcmV0ID0geGF0dHJfZ2V0c2VjdXJpdHkobW50X3VzZXJucywgaW5vZGUsIHN1ZmZpeCwgdmFs
dWUsDQo+ID4gICAJCQkJCSAgICBzaXplKTsNCj4gPiArCQlpbnQgcmV0X3JhdzsNCj4gPiArDQo+
ID4gICAJCS8qDQo+ID4gICAJCSAqIE9ubHkgb3ZlcndyaXRlIHRoZSByZXR1cm4gdmFsdWUgaWYg
YSBzZWN1cml0eSBtb2R1bGUNCj4gPiAgIAkJICogaXMgYWN0dWFsbHkgYWN0aXZlLg0KPiA+ICAg
CQkgKi8NCj4gPiAgIAkJaWYgKHJldCA9PSAtRU9QTk9UU1VQUCkNCj4gPiAgIAkJCWdvdG8gbm9s
c207DQo+ID4gKw0KPiA+ICsJCWlmIChyZXQgPCAwKQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+
ICsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFJlYWQgcmF3IHhhdHRyIGlmIHRoZSBzaXplIGZyb20g
dGhlIGZpbGVzeXN0ZW0gaGFuZGxlcg0KPiA+ICsJCSAqIGRpZmZlcnMgZnJvbSB0aGF0IHJldHVy
bmVkIGJ5IHhhdHRyX2dldHNlY3VyaXR5KCkgYW5kIGlzDQo+ID4gKwkJICogZXF1YWwgb3IgZ3Jl
YXRlciB0aGFuIHplcm8uDQo+ID4gKwkJICovDQo+ID4gKwkJcmV0X3JhdyA9IF9fdmZzX2dldHhh
dHRyKGRlbnRyeSwgaW5vZGUsIG5hbWUsIE5VTEwsIDApOw0KPiA+ICsJCWlmIChyZXRfcmF3ID49
IDAgJiYgcmV0X3JhdyAhPSByZXQpDQo+ID4gKwkJCWdvdG8gbm9sc207DQo+ID4gKw0KPiA+ICAg
CQlyZXR1cm4gcmV0Ow0KPiA+ICAgCX0NCj4gPiAgIG5vbHNtOg0K
