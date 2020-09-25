Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06E7278DBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIYQML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 12:12:11 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:57532 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgIYQML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:12:11 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0841B1D21;
        Fri, 25 Sep 2020 19:12:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1601050328;
        bh=FC5t8suzVZZJmgErK3qG2Jap3Va5qDoQI2aBJbDel/0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=bqS0kM2CYqFE85WU9tnpTzIVG1MH4gYl0nqAwcWCK+LvP0FvijEpLfYkkcEBCZ0KS
         Ue2Q2JwLXlZwCrXvuXhj4zojOTKTk+7/wCiDAzZd0ttXKsjNK8PevBgAGPjJz6t7F0
         L8kTXydMUIPbjk/lvE9rrKtyYzqMuf4k9tbJaVJg=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 25 Sep 2020 19:12:07 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 25 Sep 2020 19:12:07 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Mark Harmstone <mark@harmstone.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: RE: [PATCH v6 05/10] fs/ntfs3: Add attrib operations
Thread-Topic: [PATCH v6 05/10] fs/ntfs3: Add attrib operations
Thread-Index: AQHWjdglN/dStLJq+0+dmsar6G90RqluhMEAgAsLTpA=
Date:   Fri, 25 Sep 2020 16:12:06 +0000
Message-ID: <779cf3a270d2426b9da1bce6b1801ccc@paragon-software.com>
References: <20200918162204.3706029-1-almaz.alexandrovich@paragon-software.com>
 <20200918162204.3706029-6-almaz.alexandrovich@paragon-software.com>
 <fd0d9b84-8018-3f6d-0b3d-03c35b1db7f2@harmstone.com>
In-Reply-To: <fd0d9b84-8018-3f6d-0b3d-03c35b1db7f2@harmstone.com>
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

RnJvbTogTWFyayBIYXJtc3RvbmUgPG1hcmsuaGFybXN0b25lQGdtYWlsLmNvbT4gT24gQmVoYWxm
IE9mIE1hcmsgSGFybXN0b25lDQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxOCwgMjAyMCA5OjI4
IFBNDQo+IA0KPiBDb3VsZCBJIHN1Z2dlc3QgdGhhdCBzeXN0ZW0ubnRmc19zZWN1cml0eSBiZSBy
ZW5hbWVkIHRvIHNlY3VyaXR5Lk5UQUNMPyBUaGF0J3MNCj4gd2hhdCBXaW5CdHJmcyB1c2VzLCBh
bmQgaXQgbWVhbnMgeW91J2QgYmUgYWJsZSB0byBjcmVhdGUgYSB3b3JraW5nIEJ0cmZzIGNvcHkN
Cj4gb2YgYSBXaW5kb3dzIGluc3RhbGxhdGlvbiBqdXN0IGJ5IHVzaW5nIHJzeW5jLiBJSVJDIFNh
bWJhIGFsc28gdW5kZXJzdGFuZHMNCj4geGF0dHJzIGNhbGxlZCBzZWN1cml0eS5OVEFDTCwgd2hl
biB5b3UndmUgcHV0IGl0IGluIHRoZSByaWdodCBtb2RlLg0KPiANCj4gUXVpdGUgYXBhcnQgZnJv
bSBhbnl0aGluZyBlbHNlLCBpdCdzIGFuIE5UIHNlY3VyaXR5IGRlc2NyaXB0b3IsIG5vdCBzcGVj
aWZpY2FsbHkNCj4gTlRGUyAtIEknbSBmYWlybHkgc3VyZSBSZUZTIHVzZXMgdGhlIHNhbWUgZm9y
bWF0IChmb3Igd2hhdCBpdCdzIHdvcnRoKS4NCj4gDQoNCkhpIE1hcmshIFNlZW1zIHJlYXNvbmFi
bGUuIFdpbGwgYmUgY2hhbmdlZCBpbiBWOC4NCg0KPiBPbiAxOC85LzIwIDU6MjEgcG0sIEtvbnN0
YW50aW4gS29tYXJvdiB3cm90ZToNCj4gPiBUaGlzIGFkZHMgYXR0cmliIG9wZXJhdGlvbnMNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtvbnN0YW50aW4gS29tYXJvdiA8YWxtYXouYWxleGFuZHJv
dmljaEBwYXJhZ29uLXNvZnR3YXJlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvbnRmczMvYXR0cmli
LmMgICB8IDEzMTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBmcy9udGZzMy9hdHRybGlzdC5jIHwgIDQ2MiArKysrKysrKysrKysrKysNCj4gPiAgZnMv
bnRmczMveGF0dHIuYyAgICB8IDEwNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI4MTUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZnMvbnRmczMvYXR0cmliLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGZz
L250ZnMzL2F0dHJsaXN0LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGZzL250ZnMzL3hhdHRy
LmMNCltdDQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiArCQlnb3RvIG91dDE7DQo+ID4gKwlpZiAo
IWVycikgew0KPiA+ICsJCXBvc2l4X2FjbF9yZWxlYXNlKGFjbCk7DQo+ID4gKwkJYWNsID0gTlVM
TDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoIVNfSVNESVIoaW5vZGUtPmlfbW9kZSkpIHsN
Cj4gPiArCQlwb3NpeF9hY2xfcmVsZWFzZShkZWZhdWx0X2FjbCk7DQo+ID4gKwkJZGVmYXVsdF9h
Y2wgPSBOVUxMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChkZWZhdWx0X2FjbCkNCj4gPiAr
CQllcnIgPSBudGZzX3NldF9hY2xfZXgoaW5vZGUsIGRlZmF1bHRfYWNsLCBBQ0xfVFlQRV9ERUZB
VUxULCAxKTsNCj4gPiArDQo+ID4gKwlpZiAoIWFjbCkNCj4gPiArCQlpbm9kZS0+aV9hY2wgPSBO
VUxMOw0KPiA+ICsJZWxzZSBpZiAoIWVycikNCj4gPiArCQllcnIgPSBudGZzX3NldF9hY2xfZXgo
aW5vZGUsIGFjbCwgQUNMX1RZUEVfQUNDRVNTLCAxKTsNCj4gPiArDQo+ID4gKwlwb3NpeF9hY2xf
cmVsZWFzZShhY2wpOw0KPiA+ICtvdXQxOg0KPiA+ICsJcG9zaXhfYWNsX3JlbGVhc2UoZGVmYXVs
dF9hY2wpOw0KPiA+ICsNCj4gPiArb3V0Og0KPiA+ICsJcmV0dXJuIGVycjsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIGJvb2wgbnRmc194YXR0cl91c2VyX2xpc3Qoc3RydWN0IGRlbnRyeSAq
ZGVudHJ5KQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gMTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCB4YXR0cl9oYW5kbGVyIG50ZnNfeGF0dHJfaGFuZGxlciA9IHsNCj4g
PiArCS5wcmVmaXggPSAiIiwNCj4gPiArCS5nZXQgPSBudGZzX2dldHhhdHRyLA0KPiA+ICsJLnNl
dCA9IG50ZnNfc2V0eGF0dHIsDQo+ID4gKwkubGlzdCA9IG50ZnNfeGF0dHJfdXNlcl9saXN0LA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArY29uc3Qgc3RydWN0IHhhdHRyX2hhbmRsZXIgKm50ZnNfeGF0
dHJfaGFuZGxlcnNbXSA9IHsgJm50ZnNfeGF0dHJfaGFuZGxlciwNCj4gPiArCQkJCQkJICAgICAg
TlVMTCB9Ow0KPiANCg0KVGhhbmtzLg0K
