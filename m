Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7D2C5E9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 02:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392158AbgK0B4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 20:56:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38561 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392146AbgK0B4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 20:56:10 -0500
X-UUID: 0f62a53ab5004a49a1ee2d9318ed2892-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=w8vnzPmIF9GP6qq9n7qD+b4xYK8LSksy/BEZVgo8LGA=;
        b=lCtGEG1J6mQZdDPK9dH8MNUW8ZsiUsM+7eiY+F5nK91J/n0Wcwm+hEtdzLHW/DycWaIvbIZTAqhNX93MZWo/jQ8Sqg5YiHJ7YiXO4NyNU5NFvzr7LX9qeqZCwRu2uVQCmlnt/itC32z7hvJCZiBvJk2mELlmxaUH9Y4MV0kSb88=;
X-UUID: 0f62a53ab5004a49a1ee2d9318ed2892-20201127
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 194068124; Fri, 27 Nov 2020 09:55:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Nov 2020 09:55:28 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 09:55:30 +0800
Message-ID: <1606442130.8845.2.camel@mtkswgap22>
Subject: Re: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
From:   Miles Chen <miles.chen@mediatek.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 27 Nov 2020 09:55:30 +0800
In-Reply-To: <87lfeqsizr.fsf@x220.int.ebiederm.org>
References: <20201123063835.18981-1-miles.chen@mediatek.com>
         <87lfeqsizr.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDEyOjMyIC0wNjAwLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90
ZToNCj4gTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+IHdyaXRlczoNCj4gDQo+
ID4gV2hlbiB3ZSB0cnkgdG8gdmlzaXQgdGhlIHBhZ2VtYXAgb2YgYSB0YWdnZWQgdXNlcnNwYWNl
IHBvaW50ZXIsIHdlIGZpbmQNCj4gPiB0aGF0IHRoZSBzdGFydF92YWRkciBpcyBub3QgY29ycmVj
dCBiZWNhdXNlIG9mIHRoZSB0YWcuDQo+ID4gVG8gZml4IGl0LCB3ZSBzaG91bGQgdW50YWcgdGhl
IHVzZXNwYWNlIHBvaW50ZXJzIGluIHBhZ2VtYXBfcmVhZCgpLg0KPiA+DQo+ID4gSSB0ZXN0ZWQg
d2l0aCA1LjEwLXJjNCBhbmQgdGhlIGlzc3VlIHJlbWFpbnMuDQo+ID4NCj4gPiBNeSB0ZXN0IGNv
ZGUgaXMgYmFlZCBvbiBbMV06DQo+ID4NCj4gPiBBIHVzZXJzcGFjZSBwb2ludGVyIHdoaWNoIGhh
cyBiZWVuIHRhZ2dlZCBieSAweGI0OiAweGI0MDAwMDc2NjJmNTQxYzgNCj4gDQo+IA0KPiBTaWdo
IHRoaXMgcGF0Y2ggaXMgYnVnZ3kuDQo+IA0KPiA+ID09PSB1c2Vyc3BhY2UgcHJvZ3JhbSA9PT0N
Cj4gPg0KPiA+IHVpbnQ2NCBPc0xheWVyOjpWaXJ0dWFsVG9QaHlzaWNhbCh2b2lkICp2YWRkcikg
ew0KPiA+IAl1aW50NjQgZnJhbWUsIHBhZGRyLCBwZm5tYXNrLCBwYWdlbWFzazsNCj4gPiAJaW50
IHBhZ2VzaXplID0gc3lzY29uZihfU0NfUEFHRVNJWkUpOw0KPiA+IAlvZmY2NF90IG9mZiA9ICgo
dWludHB0cl90KXZhZGRyKSAvIHBhZ2VzaXplICogODsgLy8gb2ZmID0gMHhiNDAwMDA3NjYyZjU0
MWM4IC8gcGFnZXNpemUgKiA4ID0gMHg1YTAwMDAzYjMxN2FhMA0KPiA+IAlpbnQgZmQgPSBvcGVu
KGtQYWdlbWFwUGF0aCwgT19SRE9OTFkpOw0KPiA+IAkuLi4NCj4gPg0KPiA+IAlpZiAobHNlZWs2
NChmZCwgb2ZmLCBTRUVLX1NFVCkgIT0gb2ZmIHx8IHJlYWQoZmQsICZmcmFtZSwgOCkgIT0gOCkg
ew0KPiA+IAkJaW50IGVyciA9IGVycm5vOw0KPiA+IAkJc3RyaW5nIGVycnR4dCA9IEVycm9yU3Ry
aW5nKGVycik7DQo+ID4gCQlpZiAoZmQgPj0gMCkNCj4gPiAJCQljbG9zZShmZCk7DQo+ID4gCQly
ZXR1cm4gMDsNCj4gPiAJfQ0KPiA+IC4uLg0KPiA+IH0NCj4gPg0KPiA+ID09PSBrZXJuZWwgZnMv
cHJvYy90YXNrX21tdS5jID09PQ0KPiA+DQo+ID4gc3RhdGljIHNzaXplX3QgcGFnZW1hcF9yZWFk
KHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9fdXNlciAqYnVmLA0KPiA+IAkJc2l6ZV90IGNvdW50
LCBsb2ZmX3QgKnBwb3MpDQo+ID4gew0KPiA+IAkuLi4NCj4gPiAJc3JjID0gKnBwb3M7DQo+ID4g
CXN2cGZuID0gc3JjIC8gUE1fRU5UUllfQllURVM7IC8vIHN2cGZuID09IDB4YjQwMDAwNzY2MmY1
NA0KPiA+IAlzdGFydF92YWRkciA9IHN2cGZuIDw8IFBBR0VfU0hJRlQ7IC8vIHN0YXJ0X3ZhZGRy
ID09IDB4YjQwMDAwNzY2MmY1NDAwMA0KPiA+IAllbmRfdmFkZHIgPSBtbS0+dGFza19zaXplOw0K
PiA+DQo+ID4gCS8qIHdhdGNoIG91dCBmb3Igd3JhcGFyb3VuZCAqLw0KPiA+IAkvLyBzdnBmbiA9
PSAweGI0MDAwMDc2NjJmNTQNCj4gPiAJLy8gKG1tLT50YXNrX3NpemUgPj4gUEFHRSkgPT0gMHg4
MDAwMDAwDQo+ID4gCWlmIChzdnBmbiA+IG1tLT50YXNrX3NpemUgPj4gUEFHRV9TSElGVCkgLy8g
dGhlIGNvbmRpdGlvbiBpcyB0cnVlIGJlY2F1c2Ugb2YgdGhlIHRhZyAweGI0DQo+ID4gCQlzdGFy
dF92YWRkciA9IGVuZF92YWRkcjsNCj4gPg0KPiA+IAlyZXQgPSAwOw0KPiA+IAl3aGlsZSAoY291
bnQgJiYgKHN0YXJ0X3ZhZGRyIDwgZW5kX3ZhZGRyKSkgeyAvLyB3ZSBjYW5ub3QgdmlzaXQgY29y
cmVjdCBlbnRyeSBiZWNhdXNlIHN0YXJ0X3ZhZGRyIGlzIHNldCB0byBlbmRfdmFkZHINCj4gPiAJ
CWludCBsZW47DQo+ID4gCQl1bnNpZ25lZCBsb25nIGVuZDsNCj4gPiAJCS4uLg0KPiA+IAl9DQo+
ID4gCS4uLg0KPiA+IH0NCj4gPg0KPiA+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vc3RyZXNzYXBw
dGVzdC9zdHJlc3NhcHB0ZXN0L2Jsb2IvbWFzdGVyL3NyYy9vcy5jYyNMMTU4DQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZnMvcHJvYy90YXNrX21tdS5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gaW5kZXggMjE3YWEy
NzA1ZDVkLi5lOWE3MGY3ZWU1MTUgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvcHJvYy90YXNrX21tdS5j
DQo+ID4gKysrIGIvZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gQEAgLTE1OTksMTEgKzE1OTksMTEg
QEAgc3RhdGljIHNzaXplX3QgcGFnZW1hcF9yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9f
dXNlciAqYnVmLA0KPiA+ICANCj4gPiAgCXNyYyA9ICpwcG9zOw0KPiA+ICAJc3ZwZm4gPSBzcmMg
LyBQTV9FTlRSWV9CWVRFUzsNCj4gDQo+ID4gLQlzdGFydF92YWRkciA9IHN2cGZuIDw8IFBBR0Vf
U0hJRlQ7DQo+ID4gKwlzdGFydF92YWRkciA9IHVudGFnZ2VkX2FkZHIoc3ZwZm4gPDwgUEFHRV9T
SElGVCk7DQo+ICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXg0KPiANCj4gQXJndWFibHkgdGhlIGxpbmUgYWJvdmUgaXMgc2FmZSwgYnV0IHVu
Zm9ydHVuYXRlbHkgaXQgaGFzIHRoZQ0KPiBwb3NzaWJpbGl0eSBvZiBzdWZmZXJpbmcgZnJvbSBv
dmVyZmxvdy4NCj4gDQo+ID4gIAllbmRfdmFkZHIgPSBtbS0+dGFza19zaXplOw0KPiA+ICANCj4g
PiAgCS8qIHdhdGNoIG91dCBmb3Igd3JhcGFyb3VuZCAqLw0KPiA+IC0JaWYgKHN2cGZuID4gbW0t
PnRhc2tfc2l6ZSA+PiBQQUdFX1NISUZUKQ0KPiA+ICsJaWYgKHN0YXJ0X3ZhZGRyID4gbW0tPnRh
c2tfc2l6ZSkNCj4gPiAgCQlzdGFydF92YWRkciA9IGVuZF92YWRkcjsNCj4gDQo+IE92ZXJmbG93
IGhhbmRsaW5nIHlvdSBhcmUgcmVtb3ZpbmcgaGVyZS4NCj4gPiAgDQo+ID4gIAkvKg0KPiANCj4g
DQo+IEkgc3VzcGVjdCB0aGUgcHJvcGVyIHdheSB0byBoYW5kbGUgdGhpcyBpcyB0byBtb3ZlIHRo
ZSB0ZXN0IGZvcg0KPiBvdmVyZmxvdyBlYXJsaWVyIHNvIHRoZSBjb2RlIGxvb2tzIHNvbWV0aGlu
ZyBsaWtlOg0KPiANCj4gCWVuZF92YWRkciA9IG1tLT50YXNrX3NpemU7DQo+IA0KPiAJc3JjID0g
KnBwb3M7DQo+IAlzdnBmbiA9IHNyYyAvIFBNX0VOVFJZX0JZVEVTOw0KPiANCj4gCS8qIHdhdGNo
IG91dCBmb3Igd3JhcGFyb3VuZCAqLw0KPiAgICAgICAgIHN0YXJ0X3ZhZGRyID0gZW5kX3ZhZGRy
Ow0KPiAJaWYgKHN2cGZuIDwgKFVMT05HX01BWCA+PiBQQUdFX1NISUZUKSkNCj4gICAgICAgICAJ
c3RhcnRfdmFkZHIgPSB1bnRhZ2dlZF9hZGRyKHN2cGZuIDw8IFBBR0VfU0hJRlQpOw0KPiANCj4g
CS8qIEVuc3VyZSB0aGUgYWRkcmVzcyBpcyBpbnNpZGUgdGhlIHRhc2sgKi8NCj4gCWlmIChzdGFy
dF92YWRkciA+IG1tLT50YXNrX3NpemUpDQo+ICAgICAgICAgCXN0YXJ0X3ZhZGRyID0gZW5kX3Zh
ZGRyOw0KDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQsIEkgd2lsbCBmaXggdGhhdCBpbiBwYXRj
aCB2Mi4NCg0KTWlsZXMNCj4gDQo+IEVyaWMNCj4gDQoNCg==

