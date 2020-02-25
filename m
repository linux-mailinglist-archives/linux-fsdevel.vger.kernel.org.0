Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96D316BA87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 08:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgBYHVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 02:21:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44357 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727114AbgBYHVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:21:32 -0500
X-UUID: c48abae84cc14d3a9f6612981b2feae3-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PlAFoeZLv3yl1DNrLtJ5lhwXHfBU7bpENIh3MZoxiYA=;
        b=hDN9ebhS0qLFNFnIpNSWd+pVCu3tZtv8DLG1dzuO+lunq8we8otu7OCMl4ArxSpNat/j5KOOiwfRiL/dhoC43DIh4hDUzhThq3qRXyTnY8B0NjsEfL+dJ71lSLooFXET1z+hykUK6Ybc+GQVMLtMKms0AYJ4G23qqbbmvdk6FCI=;
X-UUID: c48abae84cc14d3a9f6612981b2feae3-20200225
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 215015611; Tue, 25 Feb 2020 15:21:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Feb 2020 15:19:33 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 15:21:12 +0800
Message-ID: <1582615285.26304.93.camel@mtksdccf07>
Subject: Re: [PATCH v7 6/9] scsi: ufs: Add inline encryption support to UFS
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>,
        "Barani Muthukumaran" <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        "Ladvine D Almeida" <Ladvine.DAlmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Date:   Tue, 25 Feb 2020 15:21:25 +0800
In-Reply-To: <20200224233759.GC30288@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
         <20200221115050.238976-7-satyat@google.com>
         <20200221172244.GC438@infradead.org> <20200221181109.GB925@sol.localdomain>
         <1582465656.26304.69.camel@mtksdccf07>
         <20200224233759.GC30288@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiBNb24sIDIwMjAtMDItMjQgYXQgMTU6MzcgLTA4MDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBTdW4sIEZlYiAyMywgMjAyMCBhdCAwOTo0NzozNlBN
ICswODAwLCBTdGFubGV5IENodSB3cm90ZToNCj4gPiBZZXMsIE1lZGlhVGVrIGlzIGtlZXBpbmcg
d29yayBjbG9zZWx5IHdpdGggaW5saW5lIGVuY3J5cHRpb24gcGF0Y2ggc2V0cy4NCj4gPiBDdXJy
ZW50bHkgdGhlIHY2IHZlcnNpb24gY2FuIHdvcmsgd2VsbCAod2l0aG91dA0KPiA+IFVGU0hDRF9R
VUlSS19CUk9LRU5fQ1JZUFRPIHF1aXJrKSBhdCBsZWFzdCBpbiBvdXIgTVQ2Nzc5IFNvQyBwbGF0
Zm9ybQ0KPiA+IHdoaWNoIGJhc2ljIFNvQyBzdXBwb3J0IGFuZCBzb21lIG90aGVyIHBlcmlwaGVy
YWwgZHJpdmVycyBhcmUgdW5kZXINCj4gPiB1cHN0cmVhbWluZyBhcyBiZWxvdyBsaW5rLA0KPiA+
IA0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRl
ay9saXN0Lz9zdGF0ZT0lDQo+ID4gMkEmcT02Nzc5JnNlcmllcz0mc3VibWl0dGVyPSZkZWxlZ2F0
ZT0mYXJjaGl2ZT1ib3RoDQo+ID4gDQo+ID4gVGhlIGludGVncmF0aW9uIHdpdGggaW5saW5lIGVu
Y3J5cHRpb24gcGF0Y2ggc2V0IG5lZWRzIHRvIHBhdGNoDQo+ID4gdWZzLW1lZGlhdGVrIGFuZCBw
YXRjaGVzIGFyZSByZWFkeSBpbiBkb3duc3RyZWFtLiBXZSBwbGFuIHRvIHVwc3RyZWFtDQo+ID4g
dGhlbSBzb29uIGFmdGVyIGlubGluZSBlbmNyeXB0aW9uIHBhdGNoIHNldHMgZ2V0IG1lcmdlZC4N
Cj4gDQo+IFdoYXQgYW1vdW50IG9mIHN1cHBvcnQgZG8geW91IG5lZWQgaW4gdWZzLW1lZGlhdGVr
PyAgSXQgc2VlbXMgbGlrZQ0KPiBwcmV0dHkgbXVjaCBldmVyeSB1ZnMgbG93LWxldmVsIGRyaXZl
ciBuZWVkcyBzb21lIGtpbmQgb2Ygc3BlY2lmaWMNCj4gc3VwcG9ydCBub3csIHJpZ2h0PyAgSSB3
b25kZXIgaWYgd2Ugc2hvdWxkIGluc3RlYWQgb3B0IGludG8gdGhlIHN1cHBvcnQNCj4gaW5zdGVh
ZCBvZiBhbGwgdGhlIHF1aXJraW5nIGhlcmUuDQoNClRoZSBwYXRjaCBpbiB1ZnMtbWVkaWF0ZWsg
aXMgYWltZWQgdG8gaXNzdWUgdmVuZG9yLXNwZWNpZmljIFNNQyBjYWxscw0KZm9yIGhvc3QgaW5p
dGlhbGl6YXRpb24gYW5kIGNvbmZpZ3VyYXRpb24uIFRoaXMgaXMgYmVjYXVzZSBNZWRpYVRlayBV
RlMNCmhvc3QgaGFzIHNvbWUgInNlY3VyZS1wcm90ZWN0ZWQiIHJlZ2lzdGVycy9mZWF0dXJlcyB3
aGljaCBuZWVkIHRvIGJlDQphY2Nlc3NlZC9zd2l0Y2hlZCBpbiBzZWN1cmUgd29ybGQuIA0KDQpT
dWNoIHByb3RlY3Rpb24gaXMgbm90IG1lbnRpb25lZCBieSBVRlNIQ0kgc3BlY2lmaWNhdGlvbnMg
dGh1cyBpbmxpbmUNCmVuY3J5cHRpb24gcGF0Y2ggc2V0IGFzc3VtZXMgdGhhdCBldmVyeSByZWdp
c3RlcnMgaW4gVUZTSENJIGNhbiBiZQ0KYWNjZXNzZWQgbm9ybWFsbHkgaW4ga2VybmVsLiBUaGlz
IG1ha2VzIHNlbnNlIGFuZCBzdXJlbHkgdGhlIHBhdGNoc2V0DQpjYW4gd29yayBmaW5lIGluIGFu
eSAic3RhbmRhcmQiIFVGUyBob3N0LiBIb3dldmVyIGlmIGhvc3QgaGFzIHNwZWNpYWwNCmRlc2ln
biB0aGVuIGl0IGNhbiB3b3JrIG5vcm1hbGx5IG9ubHkgaWYgc29tZSB2ZW5kb3Itc3BlY2lmaWMg
dHJlYXRtZW50DQppcyBhcHBsaWVkLg0KDQpJIHRoaW5rIG9uZSBvZiB0aGUgcmVhc29uIHRvIGFw
cGx5IFVGU0hDRF9RVUlSS19CUk9LRU5fQ1JZUFRPIHF1aXJrIGluDQp1ZnMtcWNvbSBob3N0IGlz
IHNpbWlsYXIgdG8gYWJvdmUgY2FzZS4NCg0KVGhhbmtzLA0KU3RhbmxleSBDaHUNCg0K

