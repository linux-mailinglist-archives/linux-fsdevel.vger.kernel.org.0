Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A91270251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIRQfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:35:16 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53751 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbgIRQfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:35:15 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 68CEC82192;
        Fri, 18 Sep 2020 19:35:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1600446912;
        bh=lWBbZqYIit7sNYXKehI1WhpFX7nqzWRcU5+vculWpsc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=RfRZdpEXVkL9Kyfwa7xl3yuSSQQI2KeA2HYZS3VWKyRNvnvJ3qzGloY8pWf9fKuzq
         mNj+Nc57Y4sz1sJTJVuDom9iSebMhqShvv9BvghZim4ZN7PNefsrihSe3bj7XNr4QU
         cxc8pasjqYxooN4k6jBu6Di/MtA6rGvzEOUw1eUc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 19:35:11 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 18 Sep 2020 19:35:11 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Matthew Wilcox <willy@infradead.org>, Joe Perches <joe@perches.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: RE: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Thread-Topic: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Thread-Index: AQHWiEVLqTuLvbWOTEKMmELjfZa26KlmuM8AgACEsICAB2PZsA==
Date:   Fri, 18 Sep 2020 16:35:11 +0000
Message-ID: <1cb55e79c5a54feb82cf4850486890df@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
 <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
 <20200914023845.GJ6583@casper.infradead.org>
In-Reply-To: <20200914023845.GJ6583@casper.infradead.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQpTZW50OiBNb25kYXks
IFNlcHRlbWJlciAxNCwgMjAyMCA1OjM5IEFNDQo+IA0KPiBPbiBTdW4sIFNlcCAxMywgMjAyMCBh
dCAxMTo0Mzo1MEFNIC0wNzAwLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjAt
MDktMTEgYXQgMTc6MTAgKzAzMDAsIEtvbnN0YW50aW4gS29tYXJvdiB3cm90ZToNCj4gPiA+IFRo
aXMgYWRkcyBiaXRtYXANCj4gPg0KPiA+ICQgbWFrZSBmcy9udGZzMy8NCj4gPiAgIFNZTkMgICAg
aW5jbHVkZS9jb25maWcvYXV0by5jb25mLmNtZA0KPiA+ICAgQ0FMTCAgICBzY3JpcHRzL2NoZWNr
c3lzY2FsbHMuc2gNCj4gPiAgIENBTEwgICAgc2NyaXB0cy9hdG9taWMvY2hlY2stYXRvbWljcy5z
aA0KPiA+ICAgREVTQ0VORCAgb2JqdG9vbA0KPiA+ICAgQ0MgICAgICBmcy9udGZzMy9iaXRmdW5j
Lm8NCj4gPiAgIENDICAgICAgZnMvbnRmczMvYml0bWFwLm8NCj4gPiBmcy9udGZzMy9iaXRtYXAu
YzogSW4gZnVuY3Rpb24g4oCYd25kX3Jlc2NhbuKAmToNCj4gPiBmcy9udGZzMy9iaXRtYXAuYzo1
NTY6NDogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHBhZ2VfY2Fj
aGVfcmVhZGFoZWFkX3VuYm91bmRlZOKAmTsgZGlkIHlvdSBtZWFuDQo+IOKAmHBhZ2VfY2FjaGVf
cmFfdW5ib3VuZGVk4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0N
Cj4gPiAgIDU1NiB8ICAgIHBhZ2VfY2FjaGVfcmVhZGFoZWFkX3VuYm91bmRlZCgNCj4gPiAgICAg
ICB8ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+ICAgICAgIHwgICAgcGFn
ZV9jYWNoZV9yYV91bmJvdW5kZWQNCj4gPiBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMNCj4gPiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6Mjgz
OiBmcy9udGZzMy9iaXRtYXAub10gRXJyb3IgMQ0KPiA+IG1ha2VbMV06ICoqKiBbc2NyaXB0cy9N
YWtlZmlsZS5idWlsZDo1MDA6IGZzL250ZnMzXSBFcnJvciAyDQo+ID4gbWFrZTogKioqIFtNYWtl
ZmlsZToxNzkyOiBmc10gRXJyb3IgMg0KPiANCj4gVGhhdCB3YXMgb25seSBqdXN0IHJlbmFtZWQu
ICBNb3JlIGNvbmNlcm5pbmdseSwgdGhlIGRvY3VtZW50YXRpb24gaXMNCj4gcXVpdGUgdW5hbWJp
Z3VvdXM6DQo+IA0KPiAgKiBUaGlzIGZ1bmN0aW9uIGlzIGZvciBmaWxlc3lzdGVtcyB0byBjYWxs
IHdoZW4gdGhleSB3YW50IHRvIHN0YXJ0DQo+ICAqIHJlYWRhaGVhZCBiZXlvbmQgYSBmaWxlJ3Mg
c3RhdGVkIGlfc2l6ZS4gIFRoaXMgaXMgYWxtb3N0IGNlcnRhaW5seQ0KPiAgKiBub3QgdGhlIGZ1
bmN0aW9uIHlvdSB3YW50IHRvIGNhbGwuICBVc2UgcGFnZV9jYWNoZV9hc3luY19yZWFkYWhlYWQo
KQ0KPiAgKiBvciBwYWdlX2NhY2hlX3N5bmNfcmVhZGFoZWFkKCkgaW5zdGVhZC4NCg0KSGkgTWF0
dGhldyEgaXQncyBub3Qgc28gY2xlYXIgZm9yIHVzIGJ5IHNldmVyYWwgcmVhc29ucyAocGxlYXNl
IGNvcnJlY3QNCmlmIHRoaXMgaXMgd3JvbmcpOg0KcGFnZV9jYWNoZV9zeW5jX3JlYWRhaGVhZCgp
IHNlZW1zIGFwcGxpY2FibGUgYXMgYSByZXBsYWNlbWVudCwgYnV0DQppdCBkb2Vzbid0IHNlZW0g
dG8gYmUgcmVhc29uYWJsZSBhcyByZWFkYWhlYWQgaW4gdGhpcyBjYXNlIGdpdmVzIHBlcmYNCmlt
cHJvdmVtZW50IGJlY2F1c2Ugb2YgaXQncyBhc3luYyBuYXR1cmUuIFRoZSAnYXN5bmMnIGZ1bmN0
aW9uIGlzIGluY29tcGF0aWJsZQ0KcmVwbGFjZW1lbnQgYmFzZWQgb24gdGhlIGFyZ3VtZW50cyBs
aXN0Lg0KDQpUaGFua3MuDQo=
