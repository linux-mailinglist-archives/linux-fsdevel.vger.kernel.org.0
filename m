Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6785A16F821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 07:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZGnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 01:43:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:6047 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbgBZGnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:43:20 -0500
X-UUID: 66ab466f211b4c578793ed09b5fa2993-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=apvx+VLcaGZjP80PbFYAB+4q9C0nw1KkpiRc7G/OTT0=;
        b=LQPK7eVtpWBPw8xiPHS9jB8i5vXbWpu1Tc+wAzon0iiqZYlkRoxGvNRk5L9f8fEIPVDuPfebLxbLMQ/hXl++0DzkdCCeKRpCARCKaWXWljYLlekfmNiRaFM7gwqHhecoxY5/6rmXURdQ9QAlqtXooKHkDYmChmpNE8D59xI6Z38=;
X-UUID: 66ab466f211b4c578793ed09b5fa2993-20200226
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 675364193; Wed, 26 Feb 2020 14:43:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 14:41:21 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 14:43:23 +0800
Message-ID: <1582699394.26304.96.camel@mtksdccf07>
Subject: Re: [PATCH v7 6/9] scsi: ufs: Add inline encryption support to UFS
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        "Kim Boojin" <boojin.kim@samsung.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Date:   Wed, 26 Feb 2020 14:43:14 +0800
In-Reply-To: <20200226011206.GD114977@gmail.com>
References: <20200221115050.238976-1-satyat@google.com>
         <20200221115050.238976-7-satyat@google.com>
         <20200221172244.GC438@infradead.org> <20200221181109.GB925@sol.localdomain>
         <1582465656.26304.69.camel@mtksdccf07>
         <20200224233759.GC30288@infradead.org>
         <1582615285.26304.93.camel@mtksdccf07> <20200226011206.GD114977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRXJpYywNCg0KT24gVHVlLCAyMDIwLTAyLTI1IGF0IDE3OjEyIC0wODAwLCBFcmljIEJpZ2dl
cnMgd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDI1LCAyMDIwIGF0IDAzOjIxOjI1UE0gKzA4MDAsIFN0
YW5sZXkgQ2h1IHdyb3RlOg0KPiA+IEhpIENocmlzdG9waCwNCj4gPiANCj4gPiBPbiBNb24sIDIw
MjAtMDItMjQgYXQgMTU6MzcgLTA4MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+ID4g
T24gU3VuLCBGZWIgMjMsIDIwMjAgYXQgMDk6NDc6MzZQTSArMDgwMCwgU3RhbmxleSBDaHUgd3Jv
dGU6DQo+ID4gPiA+IFllcywgTWVkaWFUZWsgaXMga2VlcGluZyB3b3JrIGNsb3NlbHkgd2l0aCBp
bmxpbmUgZW5jcnlwdGlvbiBwYXRjaCBzZXRzLg0KPiA+ID4gPiBDdXJyZW50bHkgdGhlIHY2IHZl
cnNpb24gY2FuIHdvcmsgd2VsbCAod2l0aG91dA0KPiA+ID4gPiBVRlNIQ0RfUVVJUktfQlJPS0VO
X0NSWVBUTyBxdWlyaykgYXQgbGVhc3QgaW4gb3VyIE1UNjc3OSBTb0MgcGxhdGZvcm0NCj4gPiA+
ID4gd2hpY2ggYmFzaWMgU29DIHN1cHBvcnQgYW5kIHNvbWUgb3RoZXIgcGVyaXBoZXJhbCBkcml2
ZXJzIGFyZSB1bmRlcg0KPiA+ID4gPiB1cHN0cmVhbWluZyBhcyBiZWxvdyBsaW5rLA0KPiA+ID4g
PiANCj4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1l
ZGlhdGVrL2xpc3QvP3N0YXRlPSUNCj4gPiA+ID4gMkEmcT02Nzc5JnNlcmllcz0mc3VibWl0dGVy
PSZkZWxlZ2F0ZT0mYXJjaGl2ZT1ib3RoDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgaW50ZWdyYXRp
b24gd2l0aCBpbmxpbmUgZW5jcnlwdGlvbiBwYXRjaCBzZXQgbmVlZHMgdG8gcGF0Y2gNCj4gPiA+
ID4gdWZzLW1lZGlhdGVrIGFuZCBwYXRjaGVzIGFyZSByZWFkeSBpbiBkb3duc3RyZWFtLiBXZSBw
bGFuIHRvIHVwc3RyZWFtDQo+ID4gPiA+IHRoZW0gc29vbiBhZnRlciBpbmxpbmUgZW5jcnlwdGlv
biBwYXRjaCBzZXRzIGdldCBtZXJnZWQuDQo+ID4gPiANCj4gPiA+IFdoYXQgYW1vdW50IG9mIHN1
cHBvcnQgZG8geW91IG5lZWQgaW4gdWZzLW1lZGlhdGVrPyAgSXQgc2VlbXMgbGlrZQ0KPiA+ID4g
cHJldHR5IG11Y2ggZXZlcnkgdWZzIGxvdy1sZXZlbCBkcml2ZXIgbmVlZHMgc29tZSBraW5kIG9m
IHNwZWNpZmljDQo+ID4gPiBzdXBwb3J0IG5vdywgcmlnaHQ/ICBJIHdvbmRlciBpZiB3ZSBzaG91
bGQgaW5zdGVhZCBvcHQgaW50byB0aGUgc3VwcG9ydA0KPiA+ID4gaW5zdGVhZCBvZiBhbGwgdGhl
IHF1aXJraW5nIGhlcmUuDQo+ID4gDQo+ID4gVGhlIHBhdGNoIGluIHVmcy1tZWRpYXRlayBpcyBh
aW1lZCB0byBpc3N1ZSB2ZW5kb3Itc3BlY2lmaWMgU01DIGNhbGxzDQo+ID4gZm9yIGhvc3QgaW5p
dGlhbGl6YXRpb24gYW5kIGNvbmZpZ3VyYXRpb24uIFRoaXMgaXMgYmVjYXVzZSBNZWRpYVRlayBV
RlMNCj4gPiBob3N0IGhhcyBzb21lICJzZWN1cmUtcHJvdGVjdGVkIiByZWdpc3RlcnMvZmVhdHVy
ZXMgd2hpY2ggbmVlZCB0byBiZQ0KPiA+IGFjY2Vzc2VkL3N3aXRjaGVkIGluIHNlY3VyZSB3b3Js
ZC4gDQo+ID4gDQo+ID4gU3VjaCBwcm90ZWN0aW9uIGlzIG5vdCBtZW50aW9uZWQgYnkgVUZTSENJ
IHNwZWNpZmljYXRpb25zIHRodXMgaW5saW5lDQo+ID4gZW5jcnlwdGlvbiBwYXRjaCBzZXQgYXNz
dW1lcyB0aGF0IGV2ZXJ5IHJlZ2lzdGVycyBpbiBVRlNIQ0kgY2FuIGJlDQo+ID4gYWNjZXNzZWQg
bm9ybWFsbHkgaW4ga2VybmVsLiBUaGlzIG1ha2VzIHNlbnNlIGFuZCBzdXJlbHkgdGhlIHBhdGNo
c2V0DQo+ID4gY2FuIHdvcmsgZmluZSBpbiBhbnkgInN0YW5kYXJkIiBVRlMgaG9zdC4gSG93ZXZl
ciBpZiBob3N0IGhhcyBzcGVjaWFsDQo+ID4gZGVzaWduIHRoZW4gaXQgY2FuIHdvcmsgbm9ybWFs
bHkgb25seSBpZiBzb21lIHZlbmRvci1zcGVjaWZpYyB0cmVhdG1lbnQNCj4gPiBpcyBhcHBsaWVk
Lg0KPiA+IA0KPiA+IEkgdGhpbmsgb25lIG9mIHRoZSByZWFzb24gdG8gYXBwbHkgVUZTSENEX1FV
SVJLX0JST0tFTl9DUllQVE8gcXVpcmsgaW4NCj4gPiB1ZnMtcWNvbSBob3N0IGlzIHNpbWlsYXIg
dG8gYWJvdmUgY2FzZS4NCj4gDQo+IFNvLCBJIGhhZCBvcmlnaW5hbGx5IGFzc3VtZWQgdGhhdCBt
b3N0IGtlcm5lbCBkZXZlbG9wZXJzIHdvdWxkIHByZWZlciB0byBtYWtlDQo+IHRoZSBVRlMgY3J5
cHRvIHN1cHBvcnQgb3B0LW91dCByYXRoZXIgdGhhbiBvcHQtaW4sIHNpbmNlIHRoYXQgbWF0Y2hl
cyB0aGUgbm9ybWFsDQo+IExpbnV4IHdheSBvZiBkb2luZyB0aGluZ3MuICBJLmUuIG5vcm1hbGx5
IHRoZSBrZXJuZWwncyBkZWZhdWx0IGFzc3VtcHRpb24gaXMNCj4gdGhhdCBkZXZpY2VzIGltcGxl
bWVudCB0aGUgcmVsZXZhbnQgc3RhbmRhcmQsIGFuZCBvbmx5IHdoZW4gYSBkZXZpY2UgaXMga25v
d24gdG8NCj4gZGV2aWF0ZSBmcm9tIHRoZSBzdGFuZGFyZCBkb2VzIHRoZSBkcml2ZXIgYXBwbHkg
cXVpcmtzLg0KPiANCj4gQnV0IGluZGVlZCwgYXMgd2UndmUgaW52ZXN0aWdhdGVkIG1vcmUgdmVu
ZG9ycycgVUZTIGhhcmR3YXJlLCBpdCBzZWVtcyB0aGF0DQo+IGV2ZXJ5b25lIGhhcyBzb21lIHF1
aXJrIHRoYXQgbmVlZHMgdG8gYmUgaGFuZGxlZCBpbiB0aGUgcGxhdGZvcm0gZHJpdmVyOg0KPiAN
Cj4gICAtIHVmcy1xY29tICh0ZXN0ZWQgb24gRHJhZ29uQm9hcmQgODQ1YyB3aXRoIHVwc3RyZWFt
IGtlcm5lbCkgbmVlZHMNCj4gICAgIHZlbmRvci1zcGVjaWZpYyBjcnlwdG8gaW5pdGlhbGl6YXRp
b24gbG9naWMgYW5kIFNNQyBjYWxscyB0byBzZXQga2V5cw0KPiANCj4gICAtIHVmcy1tZWRpYXRl
ayBuZWVkcyB0aGUgcXVpcmtzIHRoYXQgU3RhbmxleSBtZW50aW9uZWQgYWJvdmUNCj4gDQo+ICAg
LSB1ZnMtaGlzaSAodGVzdGVkIG9uIEhpa2V5OTYwIHdpdGggdXBzdHJlYW0ga2VybmVsKSBuZWVk
cyB0byB3cml0ZSBhDQo+ICAgICB2ZW5kb3Itc3BlY2lmaWMgcmVnaXN0ZXIgdG8gdXNlIGhpZ2gg
a2V5c2xvdHMsIGJ1dCBldmVuIHRoZW4gSSBzdGlsbA0KPiAgICAgY291bGRuJ3QgZ2V0IHRoZSBj
cnlwdG8gc3VwcG9ydCB3b3JraW5nIGNvcnJlY3RseS4NCj4gDQo+IEknbSBub3Qgc3VyZSBhYm91
dCB0aGUgVUZTIGNvbnRyb2xsZXJzIGZyb20gU3lub3BzeXMsIENhZGVuY2UsIG9yIFNhbXN1bmcs
IGFsbA0KPiBvZiB3aGljaCBhcHBhcmVudGx5IGhhdmUgaW1wbGVtZW50ZWQgc29tZSBmb3JtIG9m
IHRoZSBjcnlwdG8gc3VwcG9ydCB0b28uICBCdXQgSQ0KPiB3b3VsZG4ndCBnZXQgbXkgaG9wZXMg
dXAgdGhhdCBldmVyeW9uZSBmb2xsb3dlZCB0aGUgVUZTIHN0YW5kYXJkIHByZWNpc2VseS4NCj4g
DQo+IFNvIGlmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zLCBJTU8gd2Ugc2hvdWxkIG1ha2UgdGhl
IGNyeXB0byBzdXBwb3J0IG9wdC1pbi4NCj4gDQo+IFRoYXQgbWFrZXMgaXQgZXZlbiBtb3JlIGlt
cG9ydGFudCB0byB1cHN0cmVhbSB0aGUgY3J5cHRvIHN1cHBvcnQgZm9yIHNwZWNpZmljDQo+IGhh
cmR3YXJlIGxpa2UgdWZzLXFjb20gYW5kIHVmcy1tZWRpYXRlaywgc2luY2Ugb3RoZXJ3aXNlIHRo
ZSB1ZnNoY2QtY3J5cHRvIGNvZGUNCj4gd291bGQgYmUgdW51c2FibGUgZXZlbiB0aGVvcmV0aWNh
bGx5LiAgSSdtIHZvbHVudGVlcmluZyB0byBoYW5kbGUgdWZzLXFjb20gd2l0aA0KPiBodHRwczov
L2xrbWwua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDIwMDExMDA2MTYzNC40Njc0Mi0xLWViaWdn
ZXJzQGtlcm5lbC5vcmcvLg0KPiBTdGFubGV5LCBjb3VsZCB5b3Ugc2VuZCBvdXQgdWZzLW1lZGlh
dGVrIHN1cHBvcnQgYXMgYW4gUkZDIHNvIHBlb3BsZSBjYW4gc2VlDQo+IGJldHRlciB3aGF0IGl0
IGludm9sdmVzPw0KDQpTdXJlLCBJIHdpbGwgc2VuZCBvdXQgb3VyIFJGQyBwYXRjaGVzLiBQbGVh
c2UgYWxsb3cgbWUgc29tZSB0aW1lIGZvcg0Kc3VibWlzc2lvbi4NCg0KVGhhbmtzLA0KU3Rhbmxl
eSBDaHUNCj4gLSBFcmljDQoNCg==

