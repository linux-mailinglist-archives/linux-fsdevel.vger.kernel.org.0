Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BF2C4FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKZH5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:57:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2074 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgKZH5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:57:21 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ChVT31VWLzVfrm;
        Thu, 26 Nov 2020 15:56:39 +0800 (CST)
Received: from dggemi710-chm.china.huawei.com (10.3.20.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 15:57:16 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi710-chm.china.huawei.com (10.3.20.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 26 Nov 2020 15:57:16 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 26 Nov 2020 15:57:16 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Miles Chen <miles.chen@mediatek.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
Thread-Topic: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
Thread-Index: AQHWwWNz5MRhXZKR2UCNja39TEhHcanaA0sg//+FDQCAAIXFIA==
Date:   Thu, 26 Nov 2020 07:57:16 +0000
Message-ID: <1f3f2d387a144f10b5b51d2022a4aac8@hisilicon.com>
References: <20201123063835.18981-1-miles.chen@mediatek.com>
         <24d32889abb1412abcd4e868a36783f9@hisilicon.com>
 <1606376946.17565.6.camel@mtkswgap22>
In-Reply-To: <1606376946.17565.6.camel@mtkswgap22>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.201]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlsZXMgQ2hlbiBbbWFp
bHRvOm1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIg
MjYsIDIwMjAgODo0OSBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+IENjOiBBbGV4ZXkgRG9icml5YW4gPGFkb2JyaXlhbkBn
bWFpbC5jb20+OyBBbmRyZXcgTW9ydG9uDQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IHdzZF91cHN0cmVh
bUBtZWRpYXRlay5jb20NCj4gU3ViamVjdDogUkU6IFtSRVNFTkQgUEFUQ0ggdjFdIHByb2M6IHVz
ZSB1bnRhZ2dlZF9hZGRyKCkgZm9yIHBhZ2VtYXBfcmVhZA0KPiBhZGRyZXNzZXMNCj4gDQo+IE9u
IFRodSwgMjAyMC0xMS0yNiBhdCAwNzoxNiArMDAwMCwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25n
KSB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IE1pbGVzIENoZW4gW21haWx0bzptaWxlcy5jaGVuQG1lZGlhdGVrLmNvbV0NCj4gPiA+IFNl
bnQ6IE1vbmRheSwgTm92ZW1iZXIgMjMsIDIwMjAgNzozOSBQTQ0KPiA+ID4gVG86IEFsZXhleSBE
b2JyaXlhbiA8YWRvYnJpeWFuQGdtYWlsLmNvbT47IEFuZHJldyBNb3J0b24NCj4gPiA+IDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtbWVkaWF0
ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgd3NkX3Vwc3RyZWFtQG1lZGlhdGVrLmNvbTsgTWlsZXMN
Cj4gPiA+IENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gU3ViamVjdDogW1JF
U0VORCBQQVRDSCB2MV0gcHJvYzogdXNlIHVudGFnZ2VkX2FkZHIoKSBmb3IgcGFnZW1hcF9yZWFk
DQo+ID4gPiBhZGRyZXNzZXMNCj4gPiA+DQo+ID4gPiBXaGVuIHdlIHRyeSB0byB2aXNpdCB0aGUg
cGFnZW1hcCBvZiBhIHRhZ2dlZCB1c2Vyc3BhY2UgcG9pbnRlciwgd2UgZmluZA0KPiA+ID4gdGhh
dCB0aGUgc3RhcnRfdmFkZHIgaXMgbm90IGNvcnJlY3QgYmVjYXVzZSBvZiB0aGUgdGFnLg0KPiA+
ID4gVG8gZml4IGl0LCB3ZSBzaG91bGQgdW50YWcgdGhlIHVzZXNwYWNlIHBvaW50ZXJzIGluIHBh
Z2VtYXBfcmVhZCgpLg0KPiA+ID4NCj4gPiA+IEkgdGVzdGVkIHdpdGggNS4xMC1yYzQgYW5kIHRo
ZSBpc3N1ZSByZW1haW5zLg0KPiA+ID4NCj4gPiA+IE15IHRlc3QgY29kZSBpcyBiYWVkIG9uIFsx
XToNCj4gPiA+DQo+ID4gPiBBIHVzZXJzcGFjZSBwb2ludGVyIHdoaWNoIGhhcyBiZWVuIHRhZ2dl
ZCBieSAweGI0OiAweGI0MDAwMDc2NjJmNTQxYzgNCj4gPiA+DQo+ID4gPiA9PT0gdXNlcnNwYWNl
IHByb2dyYW0gPT09DQo+ID4gPg0KPiA+ID4gdWludDY0IE9zTGF5ZXI6OlZpcnR1YWxUb1BoeXNp
Y2FsKHZvaWQgKnZhZGRyKSB7DQo+ID4gPiAJdWludDY0IGZyYW1lLCBwYWRkciwgcGZubWFzaywg
cGFnZW1hc2s7DQo+ID4gPiAJaW50IHBhZ2VzaXplID0gc3lzY29uZihfU0NfUEFHRVNJWkUpOw0K
PiA+ID4gCW9mZjY0X3Qgb2ZmID0gKCh1aW50cHRyX3QpdmFkZHIpIC8gcGFnZXNpemUgKiA4OyAv
LyBvZmYgPQ0KPiA+ID4gMHhiNDAwMDA3NjYyZjU0MWM4IC8gcGFnZXNpemUgKiA4ID0gMHg1YTAw
MDAzYjMxN2FhMA0KPiA+ID4gCWludCBmZCA9IG9wZW4oa1BhZ2VtYXBQYXRoLCBPX1JET05MWSk7
DQo+ID4gPiAJLi4uDQo+ID4gPg0KPiA+ID4gCWlmIChsc2VlazY0KGZkLCBvZmYsIFNFRUtfU0VU
KSAhPSBvZmYgfHwgcmVhZChmZCwgJmZyYW1lLCA4KSAhPSA4KSB7DQo+ID4gPiAJCWludCBlcnIg
PSBlcnJubzsNCj4gPiA+IAkJc3RyaW5nIGVycnR4dCA9IEVycm9yU3RyaW5nKGVycik7DQo+ID4g
PiAJCWlmIChmZCA+PSAwKQ0KPiA+ID4gCQkJY2xvc2UoZmQpOw0KPiA+ID4gCQlyZXR1cm4gMDsN
Cj4gPiA+IAl9DQo+ID4gPiAuLi4NCj4gPiA+IH0NCj4gPiA+DQo+ID4gPiA9PT0ga2VybmVsIGZz
L3Byb2MvdGFza19tbXUuYyA9PT0NCj4gPiA+DQo+ID4gPiBzdGF0aWMgc3NpemVfdCBwYWdlbWFw
X3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsDQo+ID4gPiAJCXNpemVf
dCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiA+ID4gew0KPiA+ID4gCS4uLg0KPiA+ID4gCXNyYyA9
ICpwcG9zOw0KPiA+ID4gCXN2cGZuID0gc3JjIC8gUE1fRU5UUllfQllURVM7IC8vIHN2cGZuID09
IDB4YjQwMDAwNzY2MmY1NA0KPiA+ID4gCXN0YXJ0X3ZhZGRyID0gc3ZwZm4gPDwgUEFHRV9TSElG
VDsgLy8gc3RhcnRfdmFkZHIgPT0NCj4gPiA+IDB4YjQwMDAwNzY2MmY1NDAwMA0KPiA+ID4gCWVu
ZF92YWRkciA9IG1tLT50YXNrX3NpemU7DQo+ID4gPg0KPiA+ID4gCS8qIHdhdGNoIG91dCBmb3Ig
d3JhcGFyb3VuZCAqLw0KPiA+ID4gCS8vIHN2cGZuID09IDB4YjQwMDAwNzY2MmY1NA0KPiA+ID4g
CS8vIChtbS0+dGFza19zaXplID4+IFBBR0UpID09IDB4ODAwMDAwMA0KPiA+ID4gCWlmIChzdnBm
biA+IG1tLT50YXNrX3NpemUgPj4gUEFHRV9TSElGVCkgLy8gdGhlIGNvbmRpdGlvbiBpcyB0cnVl
IGJlY2F1c2UNCj4gPiA+IG9mIHRoZSB0YWcgMHhiNA0KPiA+ID4gCQlzdGFydF92YWRkciA9IGVu
ZF92YWRkcjsNCj4gPiA+DQo+ID4gPiAJcmV0ID0gMDsNCj4gPiA+IAl3aGlsZSAoY291bnQgJiYg
KHN0YXJ0X3ZhZGRyIDwgZW5kX3ZhZGRyKSkgeyAvLyB3ZSBjYW5ub3QgdmlzaXQgY29ycmVjdA0K
PiA+ID4gZW50cnkgYmVjYXVzZSBzdGFydF92YWRkciBpcyBzZXQgdG8gZW5kX3ZhZGRyDQo+ID4g
PiAJCWludCBsZW47DQo+ID4gPiAJCXVuc2lnbmVkIGxvbmcgZW5kOw0KPiA+ID4gCQkuLi4NCj4g
PiA+IAl9DQo+ID4gPiAJLi4uDQo+ID4gPiB9DQo+ID4gPg0KPiA+ID4gWzFdDQo+ID4gPg0KPiBo
dHRwczovL2dpdGh1Yi5jb20vc3RyZXNzYXBwdGVzdC9zdHJlc3NhcHB0ZXN0L2Jsb2IvbWFzdGVy
L3NyYy9vcy5jYyNMMTU4DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8
bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBmcy9wcm9jL3Rhc2tf
bW11LmMgfCA0ICsrLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9wcm9jL3Rhc2tfbW11
LmMgYi9mcy9wcm9jL3Rhc2tfbW11LmMNCj4gPiA+IGluZGV4IDIxN2FhMjcwNWQ1ZC4uZTlhNzBm
N2VlNTE1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gPiArKysg
Yi9mcy9wcm9jL3Rhc2tfbW11LmMNCj4gPiA+IEBAIC0xNTk5LDExICsxNTk5LDExIEBAIHN0YXRp
YyBzc2l6ZV90IHBhZ2VtYXBfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gY2hhcg0KPiA+ID4g
X191c2VyICpidWYsDQo+ID4gPg0KPiA+ID4gIAlzcmMgPSAqcHBvczsNCj4gPiA+ICAJc3ZwZm4g
PSBzcmMgLyBQTV9FTlRSWV9CWVRFUzsNCj4gPiA+IC0Jc3RhcnRfdmFkZHIgPSBzdnBmbiA8PCBQ
QUdFX1NISUZUOw0KPiA+ID4gKwlzdGFydF92YWRkciA9IHVudGFnZ2VkX2FkZHIoc3ZwZm4gPDwg
UEFHRV9TSElGVCk7DQo+ID4gPiAgCWVuZF92YWRkciA9IG1tLT50YXNrX3NpemU7DQo+ID4gPg0K
PiA+ID4gIAkvKiB3YXRjaCBvdXQgZm9yIHdyYXBhcm91bmQgKi8NCj4gPiA+IC0JaWYgKHN2cGZu
ID4gbW0tPnRhc2tfc2l6ZSA+PiBQQUdFX1NISUZUKQ0KPiA+ID4gKwlpZiAoc3RhcnRfdmFkZHIg
PiBtbS0+dGFza19zaXplKQ0KPiA+ID4gIAkJc3RhcnRfdmFkZHIgPSBlbmRfdmFkZHI7DQo+ID4N
Cj4gPiBXb3VsZG4ndCB0aGUgdW50YWcgYmUgZG9uZSBieSB0aGUgdXNlciByZWFkaW5nIHBhZ2Vt
YXAgZmlsZT8NCj4gPiBXaXRoIHRoaXMgcGF0Y2gsIGV2ZW4gdXNlcnMgcGFzcyBhbiBpbGxlZ2Fs
IGFkZHJlc3MsIGZvciBleGFtcGxlLA0KPiA+IHVzZXJzIHB1dCBhIHRhZyBvbiBhIHZpcnR1YWwg
YWRkcmVzcyB3aGljaCBoYXNuJ3QgcmVhbGx5IGEgdGFnLA0KPiA+IHRoZXkgd2lsbCBzdGlsbCBn
ZXQgdGhlIHJpZ2h0IHBhZ2VtYXAuDQo+ID4NCj4gDQo+IA0KPiBJIHJ1biBhcm02NCBkZXZpY2Vz
Lg0KPiBJZiB0aGUgdGFnZ2VkIHBvaW50ZXIgaXMgZW5hYmxlZCwgdGhlIEFSTSB0b3AtYnl0ZSBJ
Z25vcmUgaXMgYWxzbw0KPiBlbmFibGVkLiBJdCBtZWFucyB0aGUgdG9wLWJ5dGUgaXMgYWx3YXlz
IGJlIGlnbm9yZWQuDQo+IA0KPiBJIHRoaW5rIHRoZSBrZXJuZWwgc2hvdWxkIG5vdCBicmVhayBl
eGlzdGluZyB1c2Vyc3BhY2UgcHJvZ3JhbSwgc28gaXQncw0KPiBiZXR0ZXIgdG8gaGFuZGxlIHRo
ZSB0YWdnZWQgdXNlciBwb2ludGVyIGluIGtlcm5lbC4NCj4gDQo+IGdyZXAgJ3VudGFnJyBtbSAt
Um5IIHRvIHNlZSBleGlzdGluZyBleGFtcGxlcy4NCg0KSSBzZWUgeW91ciBwb2ludC4gQnV0IHRo
ZSBleGlzdGluZyBleGFtcGxlcyBzdWNoIGFzIGd1cCBldGMgYXJlIHJlY2VpdmluZw0KYW4gYWRk
cmVzcyBmcm9tIHVzZXJzcGFjZS4NCg0KcGFnZW1hcCBpc24ndCBnZXR0aW5nIGFuIGFkZHJlc3Ms
IGl0IGlzIGdldHRpbmcgYSBmaWxlIG9mZnNldCB3aGljaA0Kc2hvdWxkIGJlIGZpZ3VyZWQgb3V0
IGJ5IHVzZXJzcGFjZSBjb3JyZWN0bHkuIFdoaWxlIHdlIHJlYWQgYSBmaWxlLA0Kd2Ugc2hvdWxk
IG1ha2Ugc3VyZSB0aGUgb2Zmc2V0IGlzIGluIHRoZSByYW5nZSBvZiB0aGUgZmlsZSBsZW5ndGgu
DQoNCj4gDQo+IA0KPiB0aGFua3MsDQo+IE1pbGVzDQo+IA0KPiA+ID4NCj4gPiA+ICAJLyoNCj4g
PiA+IC0tDQo+ID4gPiAyLjE4LjANCj4gPg0KDQpUaGFua3MNCkJhcnJ5DQo=
