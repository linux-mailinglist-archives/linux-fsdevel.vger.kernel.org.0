Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2C254A1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH0QBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:01:43 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:46924 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgH0QBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:01:42 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id A62A682246;
        Thu, 27 Aug 2020 19:01:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598544099;
        bh=KV0VCdFLsvj5Argmz3nlfjvKM4uICmDC66jp2333TV4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=gVi1CCdvtmjals08pT60HSl7+TAJs/T2N8a3RMmCptPEjx0GWFRDa+OqaN61BoFNz
         mZSduFLmfs7+lA2WMWX8/9CoZlvi3ygE/vytNwkcYoaUyWRmKY2bbLOSy7Y34Gj8/Z
         yZIQRu9MZxFp6ZnFEcNXhIjgWmlDKD0FMOvUih2w=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:01:39 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:01:39 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: RE: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Topic: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Index: AdZ302F8VVG9og4hTA6+RhoU6EU4hv//5nIA//Z4EJA=
Date:   Thu, 27 Aug 2020 16:01:39 +0000
Message-ID: <8fc9d4a25f25472384d9de2b6d5e8111@paragon-software.com>
References: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
 <63ae69b5-ee05-053d-feb6-6c9b5ed04499@infradead.org>
In-Reply-To: <63ae69b5-ee05-053d-feb6-6c9b5ed04499@infradead.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQpTZW50OiBGcmlkYXks
IEF1Z3VzdCAyMSwgMjAyMCA4OjIzIFBNDQo+IA0KPiBPbiA4LzIxLzIwIDk6MjUgQU0sIEtvbnN0
YW50aW4gS29tYXJvdiB3cm90ZToNCj4gPiBUaGlzIGFkZHMgZnMvbnRmczMgS2NvbmZpZywgTWFr
ZWZpbGUgYW5kIERvY3VtZW50YXRpb24gZmlsZQ0KW10NCj4gPiArDQo+ID4gKy0gVGhpcyBkcml2
ZXIgaW1wbGVtZW50cyBOVEZTIHJlYWQvd3JpdGUgc3VwcG9ydCBmb3Igbm9ybWFsLCBzcGFyc2Vk
IGFuZA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNwYXJzZQ0KPiANCj4gPiArICBjb21wcmVzc2VkIGZpbGVzLg0K
PiA+ICsgIE5PVEU6IE9wZXJhdGlvbnMgd2l0aCBjb21wcmVzc2VkIGZpbGVzIHJlcXVpcmUgaW5j
cmVhc2VkIG1lbW9yeSBjb25zdW1wdGlvbjsNCj4gPiArLSBTdXBwb3J0cyBuYXRpdmUgam91cm5h
bCByZXBsYXlpbmc7DQo+ID4gKy0gU3VwcG9ydHMgZXh0ZW5kZWQgYXR0cmlidXRlczsNCj4gPiAr
LSBTdXBwb3J0cyBORlMgZXhwb3J0IG9mIG1vdW50ZWQgTlRGUyB2b2x1bWVzLg0KPiA+ICsNCj4g
PiArTW91bnQgT3B0aW9ucw0KPiA+ICs9PT09PT09PT09PT09DQo+ID4gKw0KPiA+ICtUaGUgbGlz
dCBiZWxvdyBkZXNjcmliZXMgbW91bnQgb3B0aW9ucyBzdXBwb3J0ZWQgYnkgTlRGUzMgZHJpdmVy
IGluIGFkZHRpb24gdG8NCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkaXRpb24NCj4gDQo+ID4gK2dl
bmVyaWMgb25lcy4NCg0KVGhhbmtzISBXaWxsIGJlIGZpeGVkIGluIHYzLg0KDQo+ID4gKz09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCltdDQo+ID4gKw0KPiA+ICtub2hpZGRlbgkJRmlsZXMgd2l0aCB0
aGUgV2luZG93cy1zcGVjaWZpYyBISURERU4gKEZJTEVfQVRUUklCVVRFX0hJRERFTikNCj4gPiAr
CQkJYXR0cmlidXRlIHdpbGwgbm90IGJlIHNob3duIHVuZGVyIExpbnV4Lg0KPiANCj4gV2l0aG91
dCB0aGlzIG1vdW50IG9wdGlvbiwgd2lsbCBISURERU4gZmlsZXMgYmUgc2hvd24gYnkgZGVmYXVs
dD8NCg0KWWVzLCBjb3JyZWN0LCB3aXRob3V0ICJub2hpZGRlbiIgbW91bnQgb3B0aW9uIGZpbGVz
IHdpdGggRklMRV9BVFRSSUJVVEVfSElEREVOIHNldCB3aWxsIGJlIHNob3duIGFzIHJlZ3VsYXIg
ZmlsZXMuDQoNCj4gPiArDQo+ID4gK3N5c19pbW11dGFibGUJCUZpbGVzIHdpdGggdGhlIFdpbmRv
d3Mtc3BlY2lmaWMgU1lTVEVNDQpbXQ0KPiA+ICsNCj4gPiArLSBGdWxsIGpvdXJuYWxpbmcgc3Vw
cG9ydCAoY3VycmVudGx5IGpvdXJuYWwgcmVwbGF5aW5nIGlzIHN1cHBvcnRlZCkgb3ZlciBKQkQu
DQo+IA0KPiAgICAgICAgICAgam91cm5hbGxpbmcNCj4gc2VlbXMgdG8gYmUgcHJlZmVycmVkLg0K
PiANCg0KSGF2ZSB0byBkaXNhZ3JlZSBvbiB0aGlzLiBBY2NvcmRpbmcgdG8gImpvdXJuYWxpbmci
IHRlcm0gdXNhZ2UgaW4gZGlmZmVyZW50IHNvdXJjZXMsIHRoZSBzaW5nbGUtTCBzZWVtcyB0byBi
ZSB0aGUgc3RhbmRhcmQuDQoNCj4gPiArDQo+ID4gKw0KPiA+ICtSZWZlcmVuY2VzDQo+ID4gKz09
PT09PT09PT0NCj4gPiAraHR0cHM6Ly93d3cucGFyYWdvbi1zb2Z0d2FyZS5jb20vaG9tZS9udGZz
LWxpbnV4LXByb2Zlc3Npb25hbC8NCj4gPiArCS0gQ29tbWVyY2lhbCB2ZXJzaW9uIG9mIHRoZSBO
VEZTIGRyaXZlciBmb3IgTGludXguDQo+ID4gKw0KPiA+ICthbG1hei5hbGV4YW5kcm92aWNoQHBh
cmFnb24tc29mdHdhcmUuY29tDQo+ID4gKwktIERpcmVjdCBlLW1haWwgYWRkcmVzcyBmb3IgZmVl
ZGJhY2sgYW5kIHJlcXVlc3RzIG9uIHRoZSBOVEZTMyBpbXBsZW1lbnRhdGlvbi4NCj4gPiArDQo+
ID4gKw0KPiANCj4gdGhhbmtzLg0KPiAtLQ0KPiB+UmFuZHkNCg==
