Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A4255F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgH1QwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 12:52:13 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:59314 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgH1QwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:52:10 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 88B4C27E;
        Fri, 28 Aug 2020 19:52:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598633524;
        bh=m1pKKjpioRBYOjQrwP54PuAQvD3YzDlEBypI9yp7+XU=;
        h=From:To:CC:Subject:Date;
        b=Gow0qbIeJthwM9mEjyHtp2nBwuCuL608qz0bgafuaCQ7HvRuMNQYutmE2sLVaZrTD
         JdPFLS5NvjTNiP3XzNpJ1U0AdckqWCeBwabSUYBdVsi+KrQgwcAijn1gOMG3nxnoo0
         mOqPu2I1G5KF13R5C/v5lw4He2iNwuORCrsXwGkg=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 28 Aug 2020 19:52:03 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 28 Aug 2020 19:52:03 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Mark Harmstone <mark@harmstone.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: Re: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
Thread-Topic: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
Thread-Index: AdZ9WYtoNhpifd4wR/GdSqVgVwVwlw==
Date:   Fri, 28 Aug 2020 16:52:03 +0000
Message-ID: <e2decd9632cd4d218fb83e96c0c37174@paragon-software.com>
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

RnJvbTogTWFyayBIYXJtc3RvbmUgPG1hcmsuaGFybXN0b25lQGdtYWlsLmNvbT4gT24gQmVoYWxm
IE9mIE1hcmsgSGFybXN0b25lDQpTZW50OiBNb25kYXksIEF1Z3VzdCAyNCwgMjAyMCA3OjE0IFBN
DQo+IA0KPiBIaSBLb25zdGFudGluLA0KPiANCj4gSSBoYXZlIGFuIGludGVyZXN0IGluIHRoaXMg
LSBJIHdyb3RlIHRoZSBCdHJmcyBkcml2ZXIgZm9yIFdpbmRvd3MsIHdoaWNoIGFsc28gaGFkIHRv
IGRlYWwgd2l0aCB0aGUgaXNzdWUgb2YgaG93IHRvIG1hcCBOVEZTIGNvbmNlcHQgdG8NCj4gTGlu
dXggeGF0dHJzLiBVbmxlc3MgdGhlcmUncyBhIGdvb2QgcmVhc29uLCBJIHRoaW5rIGl0J2QgYmUg
aW4gZXZlcnlvbmUncyBpbnRlcmVzdHMgaWYgd2UgdXNlZCB0aGUgc2FtZSBjb252ZW50aW9ucy4N
Cj4gDQo+IFlvdSBoYXZlIGZvdXIoISkgZGlmZmVyZW50IHdheXMgb2YgcmVmZXJyaW5nIHRvIHRo
ZSBhdHRyaWJ1dGVzIHZhbHVlLCB3aGljaCBzZWVtcyBhIGJpdCBleGNlc3NpdmUuIEkgc3VnZ2Vz
dCB5b3UganVzdCB1c2UNCj4gdXNlci5ET1NBVFRSSUIgLSB0aGlzIHNob3VsZCBiZSBpbiB0aGUg
dXNlciBuYW1lc3BhY2UgYXMgdXNlcnMgY2FuIHNldCBlLmcuIHRoZSBoaWRkZW4gZmxhZyBvbiBm
aWxlcyBhdCB3aWxsLiBUaGlzIGFsc28gbWF0Y2hlcyB3aGF0IG15DQo+IGRyaXZlciBkb2VzLCBh
bmQgd2hhdCBTYW1iYSBkb2VzLg0KPiANCg0KSGkgTWFyayEgVGhhbmtzIGZvciB0aGUgZmVlZGJh
Y2suIEl0J3MgcmVhc29uYWJsZSBjb25jZXJuLCBidXQgdGhlIG9wZW4gDQpxdWVzdGlvbiBpcyBo
b3cgdG8gYWNjZXNzIHRob3NlIE5URlMgYXR0cmlidXRlcyB3aGljaCBleHRlbmQgdGhlIERPUyAN
CmF0dHJpYnV0ZXMuIHVzZXIuRE9TQVRUUklCIG1heSBiZSBnb29kIGZvciBGQVQzMiBhcyBET1Mg
YXR0cmlidXRlcyBhcmUgc3RvcmVkIGluIDhiaXQuDQpIb3dldmVyLCB0aGlzIGRvZXMgbm90IGFw
cGx5IHRvIE5URlMgKDMyYml0IGF0dHJpYnV0ZXMpLg0KDQo+IEkgYWxzbyB0aGluayBpdCdzIGEg
bWlzdGFrZSB0byBvbmx5IGV4cG9zZSB1c2VyLkRPU0FUVFJJQiB0byBTYW1iYSAtIHRoZXJlJ3Mg
cGF0Y2hlcyBpbiBXaW5lIHN0YWdpbmcgd2hpY2ggd291bGQgYWxzbyBiZW5lZml0IGZyb20NCj4g
dGhpcy4NCj4gDQoNCkFncmVlZC4gV2lsbCBmaXggdGhpcyBpbiB2NC4gV2UgdGhpbmsgaGlzdG9y
aWNhbGx5IHRoaXMgY2FtZSBmcm9tIHdyb25nIHJlYWRpbmcgb2YNCiJUaGlzIGV4dGVuZGVkIGF0
dHJpYnV0ZSBpcyBleHBsaWNpdGx5IGhpZGRlbiBmcm9tIHNtYmQgY2xpZW50cyByZXF1ZXN0aW5n
IGFuIEVBIGxpc3QuIg0KDQo+IEFsc28sIHVubGVzcyBJJ20gbWlzc2luZyBzb21ldGhpbmcgdGhl
cmUncyBhIGJ1ZyBpbiBudGZzX3NldHhhdHRyIC0gdGhlIHVzZXIgc2hvdWxkbid0IGJlIGFibGUg
dG8gY2xlYXIgdGhlIEZJTEVfQVRUUklCVVRFX0RJUkVDVE9SWQ0KPiBmbGFnIG9uIGRpcmVjdG9y
aWVzIG5vciBzZXQgaXQgb24gZmlsZXMuDQo+IA0KDQpUaGFua3MhIEZpeGVkIGluIHYzLg0KDQo+
IFRoYW5rcw0KPiANCj4gTWFyaw0KPiANCg0K
