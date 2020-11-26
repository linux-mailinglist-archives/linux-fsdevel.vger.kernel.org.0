Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5112C4FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgKZHtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:49:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730206AbgKZHtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:49:14 -0500
X-UUID: b1a84e8f7f9d4d01a426ffe35c212c20-20201126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TvfCgI01pTRpVVGjtW+F66wwpBJPrTQJILPgC/5kpgU=;
        b=s2XTWUkO+059dPW/cJpgM0MHAX5kYGqnwlq47Bcdppf7tWgRnBCRGR5OOJwpZNA6A/vwmuo7odeDdF+M/Qq3P8q8YxnD9o1oMV1Led2eGZDNRW+mUI84q4OWm9Slegf3QROQwyJecqFNTQOufsWYiSVH4Mq+l4y6CqxDk73JTrs=;
X-UUID: b1a84e8f7f9d4d01a426ffe35c212c20-20201126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1648478386; Thu, 26 Nov 2020 15:49:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Nov 2020 15:49:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 Nov 2020 15:49:06 +0800
Message-ID: <1606376946.17565.6.camel@mtkswgap22>
Subject: RE: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
From:   Miles Chen <miles.chen@mediatek.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Date:   Thu, 26 Nov 2020 15:49:06 +0800
In-Reply-To: <24d32889abb1412abcd4e868a36783f9@hisilicon.com>
References: <20201123063835.18981-1-miles.chen@mediatek.com>
         <24d32889abb1412abcd4e868a36783f9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 81E83192E13862002142DEB72FECB66C2F007FF6FF26CBB6A2E8207C46CF8A942000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDA3OjE2ICswMDAwLCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNv
bmcpIHdyb3RlOg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IE1pbGVzIENoZW4gW21haWx0bzptaWxlcy5jaGVuQG1lZGlhdGVrLmNvbV0NCj4gPiBTZW50OiBN
b25kYXksIE5vdmVtYmVyIDIzLCAyMDIwIDc6MzkgUE0NCj4gPiBUbzogQWxleGV5IERvYnJpeWFu
IDxhZG9icml5YW5AZ21haWwuY29tPjsgQW5kcmV3IE1vcnRvbg0KPiA+IDxha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnPg0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZy
YWRlYWQub3JnOyB3c2RfdXBzdHJlYW1AbWVkaWF0ZWsuY29tOyBNaWxlcw0KPiA+IENoZW4gPG1p
bGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFN1YmplY3Q6IFtSRVNFTkQgUEFUQ0ggdjFdIHBy
b2M6IHVzZSB1bnRhZ2dlZF9hZGRyKCkgZm9yIHBhZ2VtYXBfcmVhZA0KPiA+IGFkZHJlc3Nlcw0K
PiA+IA0KPiA+IFdoZW4gd2UgdHJ5IHRvIHZpc2l0IHRoZSBwYWdlbWFwIG9mIGEgdGFnZ2VkIHVz
ZXJzcGFjZSBwb2ludGVyLCB3ZSBmaW5kDQo+ID4gdGhhdCB0aGUgc3RhcnRfdmFkZHIgaXMgbm90
IGNvcnJlY3QgYmVjYXVzZSBvZiB0aGUgdGFnLg0KPiA+IFRvIGZpeCBpdCwgd2Ugc2hvdWxkIHVu
dGFnIHRoZSB1c2VzcGFjZSBwb2ludGVycyBpbiBwYWdlbWFwX3JlYWQoKS4NCj4gPiANCj4gPiBJ
IHRlc3RlZCB3aXRoIDUuMTAtcmM0IGFuZCB0aGUgaXNzdWUgcmVtYWlucy4NCj4gPiANCj4gPiBN
eSB0ZXN0IGNvZGUgaXMgYmFlZCBvbiBbMV06DQo+ID4gDQo+ID4gQSB1c2Vyc3BhY2UgcG9pbnRl
ciB3aGljaCBoYXMgYmVlbiB0YWdnZWQgYnkgMHhiNDogMHhiNDAwMDA3NjYyZjU0MWM4DQo+ID4g
DQo+ID4gPT09IHVzZXJzcGFjZSBwcm9ncmFtID09PQ0KPiA+IA0KPiA+IHVpbnQ2NCBPc0xheWVy
OjpWaXJ0dWFsVG9QaHlzaWNhbCh2b2lkICp2YWRkcikgew0KPiA+IAl1aW50NjQgZnJhbWUsIHBh
ZGRyLCBwZm5tYXNrLCBwYWdlbWFzazsNCj4gPiAJaW50IHBhZ2VzaXplID0gc3lzY29uZihfU0Nf
UEFHRVNJWkUpOw0KPiA+IAlvZmY2NF90IG9mZiA9ICgodWludHB0cl90KXZhZGRyKSAvIHBhZ2Vz
aXplICogODsgLy8gb2ZmID0NCj4gPiAweGI0MDAwMDc2NjJmNTQxYzggLyBwYWdlc2l6ZSAqIDgg
PSAweDVhMDAwMDNiMzE3YWEwDQo+ID4gCWludCBmZCA9IG9wZW4oa1BhZ2VtYXBQYXRoLCBPX1JE
T05MWSk7DQo+ID4gCS4uLg0KPiA+IA0KPiA+IAlpZiAobHNlZWs2NChmZCwgb2ZmLCBTRUVLX1NF
VCkgIT0gb2ZmIHx8IHJlYWQoZmQsICZmcmFtZSwgOCkgIT0gOCkgew0KPiA+IAkJaW50IGVyciA9
IGVycm5vOw0KPiA+IAkJc3RyaW5nIGVycnR4dCA9IEVycm9yU3RyaW5nKGVycik7DQo+ID4gCQlp
ZiAoZmQgPj0gMCkNCj4gPiAJCQljbG9zZShmZCk7DQo+ID4gCQlyZXR1cm4gMDsNCj4gPiAJfQ0K
PiA+IC4uLg0KPiA+IH0NCj4gPiANCj4gPiA9PT0ga2VybmVsIGZzL3Byb2MvdGFza19tbXUuYyA9
PT0NCj4gPiANCj4gPiBzdGF0aWMgc3NpemVfdCBwYWdlbWFwX3JlYWQoc3RydWN0IGZpbGUgKmZp
bGUsIGNoYXIgX191c2VyICpidWYsDQo+ID4gCQlzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykN
Cj4gPiB7DQo+ID4gCS4uLg0KPiA+IAlzcmMgPSAqcHBvczsNCj4gPiAJc3ZwZm4gPSBzcmMgLyBQ
TV9FTlRSWV9CWVRFUzsgLy8gc3ZwZm4gPT0gMHhiNDAwMDA3NjYyZjU0DQo+ID4gCXN0YXJ0X3Zh
ZGRyID0gc3ZwZm4gPDwgUEFHRV9TSElGVDsgLy8gc3RhcnRfdmFkZHIgPT0NCj4gPiAweGI0MDAw
MDc2NjJmNTQwMDANCj4gPiAJZW5kX3ZhZGRyID0gbW0tPnRhc2tfc2l6ZTsNCj4gPiANCj4gPiAJ
Lyogd2F0Y2ggb3V0IGZvciB3cmFwYXJvdW5kICovDQo+ID4gCS8vIHN2cGZuID09IDB4YjQwMDAw
NzY2MmY1NA0KPiA+IAkvLyAobW0tPnRhc2tfc2l6ZSA+PiBQQUdFKSA9PSAweDgwMDAwMDANCj4g
PiAJaWYgKHN2cGZuID4gbW0tPnRhc2tfc2l6ZSA+PiBQQUdFX1NISUZUKSAvLyB0aGUgY29uZGl0
aW9uIGlzIHRydWUgYmVjYXVzZQ0KPiA+IG9mIHRoZSB0YWcgMHhiNA0KPiA+IAkJc3RhcnRfdmFk
ZHIgPSBlbmRfdmFkZHI7DQo+ID4gDQo+ID4gCXJldCA9IDA7DQo+ID4gCXdoaWxlIChjb3VudCAm
JiAoc3RhcnRfdmFkZHIgPCBlbmRfdmFkZHIpKSB7IC8vIHdlIGNhbm5vdCB2aXNpdCBjb3JyZWN0
DQo+ID4gZW50cnkgYmVjYXVzZSBzdGFydF92YWRkciBpcyBzZXQgdG8gZW5kX3ZhZGRyDQo+ID4g
CQlpbnQgbGVuOw0KPiA+IAkJdW5zaWduZWQgbG9uZyBlbmQ7DQo+ID4gCQkuLi4NCj4gPiAJfQ0K
PiA+IAkuLi4NCj4gPiB9DQo+ID4gDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3N0
cmVzc2FwcHRlc3Qvc3RyZXNzYXBwdGVzdC9ibG9iL21hc3Rlci9zcmMvb3MuY2MjTDE1OA0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBmcy9wcm9jL3Rhc2tfbW11LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gaW5k
ZXggMjE3YWEyNzA1ZDVkLi5lOWE3MGY3ZWU1MTUgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvcHJvYy90
YXNrX21tdS5jDQo+ID4gKysrIGIvZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gQEAgLTE1OTksMTEg
KzE1OTksMTEgQEAgc3RhdGljIHNzaXplX3QgcGFnZW1hcF9yZWFkKHN0cnVjdCBmaWxlICpmaWxl
LCBjaGFyDQo+ID4gX191c2VyICpidWYsDQo+ID4gDQo+ID4gIAlzcmMgPSAqcHBvczsNCj4gPiAg
CXN2cGZuID0gc3JjIC8gUE1fRU5UUllfQllURVM7DQo+ID4gLQlzdGFydF92YWRkciA9IHN2cGZu
IDw8IFBBR0VfU0hJRlQ7DQo+ID4gKwlzdGFydF92YWRkciA9IHVudGFnZ2VkX2FkZHIoc3ZwZm4g
PDwgUEFHRV9TSElGVCk7DQo+ID4gIAllbmRfdmFkZHIgPSBtbS0+dGFza19zaXplOw0KPiA+IA0K
PiA+ICAJLyogd2F0Y2ggb3V0IGZvciB3cmFwYXJvdW5kICovDQo+ID4gLQlpZiAoc3ZwZm4gPiBt
bS0+dGFza19zaXplID4+IFBBR0VfU0hJRlQpDQo+ID4gKwlpZiAoc3RhcnRfdmFkZHIgPiBtbS0+
dGFza19zaXplKQ0KPiA+ICAJCXN0YXJ0X3ZhZGRyID0gZW5kX3ZhZGRyOw0KPiANCj4gV291bGRu
J3QgdGhlIHVudGFnIGJlIGRvbmUgYnkgdGhlIHVzZXIgcmVhZGluZyBwYWdlbWFwIGZpbGU/DQo+
IFdpdGggdGhpcyBwYXRjaCwgZXZlbiB1c2VycyBwYXNzIGFuIGlsbGVnYWwgYWRkcmVzcywgZm9y
IGV4YW1wbGUsDQo+IHVzZXJzIHB1dCBhIHRhZyBvbiBhIHZpcnR1YWwgYWRkcmVzcyB3aGljaCBo
YXNuJ3QgcmVhbGx5IGEgdGFnLA0KPiB0aGV5IHdpbGwgc3RpbGwgZ2V0IHRoZSByaWdodCBwYWdl
bWFwLg0KPiANCg0KDQpJIHJ1biBhcm02NCBkZXZpY2VzLg0KSWYgdGhlIHRhZ2dlZCBwb2ludGVy
IGlzIGVuYWJsZWQsIHRoZSBBUk0gdG9wLWJ5dGUgSWdub3JlIGlzIGFsc28NCmVuYWJsZWQuIEl0
IG1lYW5zIHRoZSB0b3AtYnl0ZSBpcyBhbHdheXMgYmUgaWdub3JlZC4NCg0KSSB0aGluayB0aGUg
a2VybmVsIHNob3VsZCBub3QgYnJlYWsgZXhpc3RpbmcgdXNlcnNwYWNlIHByb2dyYW0sIHNvIGl0
J3MNCmJldHRlciB0byBoYW5kbGUgdGhlIHRhZ2dlZCB1c2VyIHBvaW50ZXIgaW4ga2VybmVsLg0K
DQpncmVwICd1bnRhZycgbW0gLVJuSCB0byBzZWUgZXhpc3RpbmcgZXhhbXBsZXMuDQoNCg0KdGhh
bmtzLA0KTWlsZXMNCg0KPiA+IA0KPiA+ICAJLyoNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiANCj4g
VGhhbmtzDQo+IEJhcnJ5DQo+IA0KDQoNCg==

