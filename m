Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB641697F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 14:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBWNrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 08:47:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26358 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBWNrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:47:51 -0500
X-UUID: 83b3ac7c022647e98daa2ff3fabae555-20200223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xzX/UQmBaKzzXeW3wSmoU95INRraG2xqKdLhcRv0zw0=;
        b=cC8U13tnRxQzVl2x9qp4ks0D6qUzZqJU0gCf60mIaIrwGbkhE4J1IohyRR7jGBfGws6Jyw8Anbu2asvCqM8yomejgHOU6zwf1gnaSZPj8PA7gSK7tmBytKH3H1qWkyqIg6BWiyhyLuS+5gTBywl6XtWAVbhtMeXY9ePvg/A3G1A=;
X-UUID: 83b3ac7c022647e98daa2ff3fabae555-20200223
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1594138836; Sun, 23 Feb 2020 21:47:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 23 Feb 2020 21:45:04 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 23 Feb 2020 21:47:56 +0800
Message-ID: <1582465656.26304.69.camel@mtksdccf07>
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
Date:   Sun, 23 Feb 2020 21:47:36 +0800
In-Reply-To: <20200221181109.GB925@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
         <20200221115050.238976-7-satyat@google.com>
         <20200221172244.GC438@infradead.org> <20200221181109.GB925@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 994E6A33E05B8928D3F2EC1C5ED8840CD9FEC231CBD3D196C64A17554069603C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIA0KDQpPbiBGcmksIDIwMjAtMDItMjEgYXQgMTA6MTEgLTA4MDAsIEVyaWMgQmlnZ2VycyB3
cm90ZToNCj4gT24gRnJpLCBGZWIgMjEsIDIwMjAgYXQgMDk6MjI6NDRBTSAtMDgwMCwgQ2hyaXN0
b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gT24gRnJpLCBGZWIgMjEsIDIwMjAgYXQgMDM6NTA6NDdB
TSAtMDgwMCwgU2F0eWEgVGFuZ2lyYWxhIHdyb3RlOg0KPiA+ID4gV2lyZSB1cCB1ZnNoY2QuYyB3
aXRoIHRoZSBVRlMgQ3J5cHRvIEFQSSwgdGhlIGJsb2NrIGxheWVyIGlubGluZQ0KPiA+ID4gZW5j
cnlwdGlvbiBhZGRpdGlvbnMgYW5kIHRoZSBrZXlzbG90IG1hbmFnZXIuDQo+ID4gPiANCj4gPiA+
IEFsc28sIGludHJvZHVjZSBVRlNIQ0RfUVVJUktfQlJPS0VOX0NSWVBUTyB0aGF0IGNlcnRhaW4g
VUZTIGRyaXZlcnMNCj4gPiA+IHRoYXQgZG9uJ3QgeWV0IHN1cHBvcnQgaW5saW5lIGVuY3J5cHRp
b24gbmVlZCB0byB1c2UgLSB0YWtlbiBmcm9tDQo+ID4gPiBwYXRjaGVzIGJ5IEpvaG4gU3R1bHR6
IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPg0KPiA+ID4gKGh0dHBzOi8vYW5kcm9pZC1yZXZpZXcu
Z29vZ2xlc291cmNlLmNvbS9jL2tlcm5lbC9jb21tb24vKy8xMTYyMjI0LzUpDQo+ID4gPiAoaHR0
cHM6Ly9hbmRyb2lkLXJldmlldy5nb29nbGVzb3VyY2UuY29tL2Mva2VybmVsL2NvbW1vbi8rLzEx
NjIyMjUvNSkNCj4gPiA+IChodHRwczovL2FuZHJvaWQtcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20v
Yy9rZXJuZWwvY29tbW9uLysvMTE2NDUwNi8xKQ0KPiA+IA0KPiA+IEJldHdlZW4gYWxsIHRoZXNl
IHF1aXJrcywgd2l0aCB3aGF0IHVwc3RyZWFtIFNPQyBkb2VzIHRoaXMgZmVhdHVyZQ0KPiA+IGFj
dHVhbGx5IHdvcms/DQo+IA0KPiBJdCB3aWxsIHdvcmsgb24gRHJhZ29uQm9hcmQgODQ1YywgaS5l
LiBRdWFsY29tbSdzIFNuYXBkcmFnb24gODQ1IFNvQywgaWYgd2UNCj4gYXBwbHkgbXkgcGF0Y2hz
ZXQNCj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyMDAxMTAwNjE2MzQu
NDY3NDItMS1lYmlnZ2Vyc0BrZXJuZWwub3JnLy4NCj4gSXQncyBjdXJyZW50bHkgYmFzZWQgb24g
U2F0eWEncyB2NiBwYXRjaHNldCwgYnV0IEknbGwgYmUgcmViYXNpbmcgaXQgb250byB2NyBhbmQN
Cj4gcmVzZW5kaW5nLiAgSXQgdXNlcyBhbGwgdGhlIFVGUyBzdGFuZGFyZCBjcnlwdG8gY29kZSB0
aGF0IFNhdHlhIGlzIGFkZGluZyBleGNlcHQNCj4gZm9yIHVmc2hjZF9wcm9ncmFtX2tleSgpLCB3
aGljaCBoYXMgdG8gYmUgcmVwbGFjZWQgd2l0aCBhIHZlbmRvci1zcGVjaWZpYw0KPiBvcGVyYXRp
b24uICBJdCBkb2VzIGFsc28gYWRkIHZlbmRvci1zcGVjaWZpYyBjb2RlIHRvIHVmcy1xY29tIHRv
IGluaXRpYWxpemUgdGhlDQo+IGNyeXB0byBoYXJkd2FyZSwgYnV0IHRoYXQncyBpbiBhZGRpdGlv
biB0byB0aGUgc3RhbmRhcmQgY29kZSwgbm90IHJlcGxhY2luZyBpdC4NCj4gDQo+IERyYWdvbkJv
YXJkIDg0NWMgaXMgYSBjb21tZXJjaWFsbHkgYXZhaWxhYmxlIGRldmVsb3BtZW50IGJvYXJkIHRo
YXQgYm9vdHMgdGhlDQo+IG1haW5saW5lIGtlcm5lbCAobW9kdWxvIHR3byBhcm0tc21tdSBJT01N
VSBwYXRjaGVzIHRoYXQgTGluYXJvIGlzIHdvcmtpbmcgb24pLA0KPiBzbyBJIHRoaW5rIGl0IGNv
dW50cyBhcyBhbiAidXBzdHJlYW0gU29DIi4NCj4gDQo+IFRoYXQncyBhbGwgdGhhdCB3ZSBjdXJy
ZW50bHkgaGF2ZSB0aGUgaGFyZHdhcmUgdG8gdmVyaWZ5IG91cnNlbHZlcywgdGhvdWdoDQo+IE1l
ZGlhdGVrIHNheXMgdGhhdCBTYXR5YSdzIHBhdGNoZXMgYXJlIHdvcmtpbmcgb24gdGhlaXIgaGFy
ZHdhcmUgdG9vLiAgQW5kIHRoZQ0KPiBVRlMgY29udHJvbGxlciBvbiBNZWRpYXRlayBTb0NzIGlz
IHN1cHBvcnRlZCBieSB0aGUgdXBzdHJlYW0ga2VybmVsIHZpYQ0KPiB1ZnMtbWVkaWF0ZWsuICBC
dXQgSSBkb24ndCBrbm93IHdoZXRoZXIgaXQganVzdCB3b3JrcyBleGFjdGx5IGFzLWlzIG9yIHdo
ZXRoZXINCj4gdGhleSBuZWVkZWQgdG8gcGF0Y2ggdWZzLW1lZGlhdGVrIHRvby4gIFN0YW5sZXkg
b3IgS3VvaG9uZywgY2FuIHlvdSBjb25maXJtPw0KDQpZZXMsIE1lZGlhVGVrIGlzIGtlZXBpbmcg
d29yayBjbG9zZWx5IHdpdGggaW5saW5lIGVuY3J5cHRpb24gcGF0Y2ggc2V0cy4NCkN1cnJlbnRs
eSB0aGUgdjYgdmVyc2lvbiBjYW4gd29yayB3ZWxsICh3aXRob3V0DQpVRlNIQ0RfUVVJUktfQlJP
S0VOX0NSWVBUTyBxdWlyaykgYXQgbGVhc3QgaW4gb3VyIE1UNjc3OSBTb0MgcGxhdGZvcm0NCndo
aWNoIGJhc2ljIFNvQyBzdXBwb3J0IGFuZCBzb21lIG90aGVyIHBlcmlwaGVyYWwgZHJpdmVycyBh
cmUgdW5kZXINCnVwc3RyZWFtaW5nIGFzIGJlbG93IGxpbmssDQoNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zdGF0ZT0lDQoyQSZxPTY3
Nzkmc2VyaWVzPSZzdWJtaXR0ZXI9JmRlbGVnYXRlPSZhcmNoaXZlPWJvdGgNCg0KVGhlIGludGVn
cmF0aW9uIHdpdGggaW5saW5lIGVuY3J5cHRpb24gcGF0Y2ggc2V0IG5lZWRzIHRvIHBhdGNoDQp1
ZnMtbWVkaWF0ZWsgYW5kIHBhdGNoZXMgYXJlIHJlYWR5IGluIGRvd25zdHJlYW0uIFdlIHBsYW4g
dG8gdXBzdHJlYW0NCnRoZW0gc29vbiBhZnRlciBpbmxpbmUgZW5jcnlwdGlvbiBwYXRjaCBzZXRz
IGdldCBtZXJnZWQuDQoNCj4gDQo+IFdlJ3JlIGFsc28gaG9waW5nIHRoYXQgdGhlIHBhdGNoZXMg
YXJlIHVzYWJsZSB3aXRoIHRoZSBVRlMgY29udHJvbGxlcnMgZnJvbQ0KPiBDYWRlbmNlIERlc2ln
biBTeXN0ZW1zIGFuZCBTeW5vcHN5cywgd2hpY2ggaGF2ZSB1cHN0cmVhbSBrZXJuZWwgc3VwcG9y
dCBpbg0KPiBkcml2ZXJzL3Njc2kvdWZzL2NkbnMtcGx0ZnJtLmMgYW5kIGRyaXZlcnMvc2NzaS91
ZnMvdWZzaGNkLWR3Yy5jLiAgQnV0IHdlIGRvbid0DQo+IGN1cnJlbnRseSBoYXZlIGEgd2F5IHRv
IHZlcmlmeSB0aGlzLiAgQnV0IGluIDIwMTgsIGJvdGggY29tcGFuaWVzIGhhZCB0cmllZCB0bw0K
PiBnZXQgdGhlIFVGUyB2Mi4xIHN0YW5kYXJkIGNyeXB0byBzdXBwb3J0IHVwc3RyZWFtLCBzbyBw
cmVzdW1hYmx5IHRoZXkgbXVzdCBoYXZlDQo+IGltcGxlbWVudGVkIGl0IGluIHRoZWlyIGhhcmR3
YXJlLiAgK0NjIHRoZSBwZW9wbGUgd2hvIHdlcmUgd29ya2luZyBvbiB0aGF0Lg0KPiANCj4gLSBF
cmljDQoNClRoYW5rcywNClN0YW5sZXkgQ2h1DQo=

