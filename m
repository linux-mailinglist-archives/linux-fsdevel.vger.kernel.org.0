Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732523E276
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHFTo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 15:44:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:12094 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgHFToz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:44:55 -0400
IronPort-SDR: wg6dMaRWx4I+UnjiMDDjN1x991CKzAUgpckcCIkN5/uDgpko69ZNORAACN/TtHkubNh/fv2ssb
 2NLKY18bl3Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140507789"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140507789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:44:55 -0700
IronPort-SDR: nycQsiqLFmbGL0LtGtGFYgb+gTscrpr/0xgzIYgwxbr49DUCUbwZL9hBeN1k9fG89L9bEYw1DC
 JtW7ybZiE1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="323540390"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 12:44:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 12:44:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 12:44:54 -0700
Received: from orsmsx612.amr.corp.intel.com ([10.22.229.25]) by
 ORSMSX612.amr.corp.intel.com ([10.22.229.25]) with mapi id 15.01.1713.004;
 Thu, 6 Aug 2020 12:44:54 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 0/4] Remove nrexceptional tracking
Thread-Topic: [PATCH 0/4] Remove nrexceptional tracking
Thread-Index: AQHWanrcgiyE+gZ1T06GDixOiuOZv6kr8b+A
Date:   Thu, 6 Aug 2020 19:44:54 +0000
Message-ID: <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
References: <20200804161755.10100-1-willy@infradead.org>
In-Reply-To: <20200804161755.10100-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.254.22.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DAC71C4E387FB48878F27E18F96C0B8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTA0IGF0IDE3OjE3ICswMTAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gV2UgYWN0dWFsbHkgdXNlIG5yZXhjZXB0aW9uYWwgZm9yIHZlcnkgbGl0dGxl
IHRoZXNlIGRheXMuICBJdCdzIGENCj4gY29uc3RhbnQNCj4gc291cmNlIG9mIHBhaW4gd2l0aCB0
aGUgVEhQIHBhdGNoZXMgYmVjYXVzZSB3ZSBkb24ndCBrbm93IGhvdyBsYXJnZSBhDQo+IHNoYWRv
dyBlbnRyeSBpcywgc28gZWl0aGVyIHdlIGhhdmUgdG8gYXNrIHRoZSB4YXJyYXkgaG93IG1hbnkg
aW5kaWNlcw0KPiBpdCBjb3ZlcnMsIG9yIHN0b3JlIHRoYXQgaW5mb3JtYXRpb24gaW4gdGhlIHNo
YWRvdyBlbnRyeSAoYW5kIHJlZHVjZQ0KPiB0aGUgYW1vdW50IG9mIG90aGVyIGluZm9ybWF0aW9u
IGluIHRoZSBzaGFkb3cgZW50cnkgcHJvcG9ydGlvbmFsbHkpLg0KPiBXaGlsZSB0cmFja2luZyBk
b3duIHRoZSBtb3N0IHJlY2VudCBjYXNlIG9mICJldmljdCB0ZWxscyBtZSBJJ3ZlIGdvdA0KPiB0
aGUgYWNjb3VudGluZyB3cm9uZyBhZ2FpbiIsIEkgd29uZGVyZWQgaWYgaXQgbWlnaHQgbm90IGJl
IHNpbXBsZXIgdG8NCj4ganVzdCByZW1vdmUgaXQuICBTbyBoZXJlJ3MgYSBwYXRjaCBzZXQgdG8g
ZG8ganVzdCB0aGF0LiAgSSB0aGluayBlYWNoDQo+IG9mIHRoZXNlIHBhdGNoZXMgaXMgYW4gaW1w
cm92ZW1lbnQgaW4gaXNvbGF0aW9uLCBidXQgdGhlIGNvbWJpbmF0aW9uDQo+IG9mDQo+IGFsbCBm
b3VyIGlzIGxhcmdlciB0aGFuIHRoZSBzdW0gb2YgaXRzIHBhcnRzLg0KPiANCj4gSSdtIHJ1bm5p
bmcgeGZzdGVzdHMgb24gdGhpcyBwYXRjaHNldCByaWdodCBub3cuICBJZiBvbmUgb2YgdGhlIERB
WA0KPiBwZW9wbGUgY291bGQgdHJ5IGl0IG91dCwgdGhhdCdkIGJlIGZhbnRhc3RpYy4NCj4gDQo+
IE1hdHRoZXcgV2lsY294IChPcmFjbGUpICg0KToNCj4gICBtbTogSW50cm9kdWNlIGFuZCB1c2Ug
cGFnZV9jYWNoZV9lbXB0eQ0KPiAgIG1tOiBTdG9wIGFjY291bnRpbmcgc2hhZG93IGVudHJpZXMN
Cj4gICBkYXg6IEFjY291bnQgREFYIGVudHJpZXMgYXMgbnJwYWdlcw0KPiAgIG1tOiBSZW1vdmUg
bnJleGNlcHRpb25hbCBmcm9tIGlub2RlDQoNCkhpIE1hdHRoZXcsDQoNCkkgYXBwbGllZCB0aGVz
ZSBvbiB0b3Agb2YgNS44IGFuZCByYW4gdGhlbSB0aHJvdWdoIHRoZSBudmRpbW0gdW5pdCB0ZXN0
DQpzdWl0ZSwgYW5kIHNhdyBzb21lIHRlc3QgZmFpbHVyZXMuIFRoZSBmaXJzdCBmYWlsaW5nIHRl
c3Qgc2lnbmF0dXJlIGlzOg0KDQogICsgdW1vdW50IHRlc3RfZGF4X21udA0KICAuL2RheC1leHQ0
LnNoOiBsaW5lIDYyOiAxNTc0OSBTZWdtZW50YXRpb24gZmF1bHQgICAgICB1bW91bnQgJE1OVA0K
ICBGQUlMIGRheC1leHQ0LnNoIChleGl0IHN0YXR1czogMTM5KQ0KDQpUaGUgbGluZSBpczogaHR0
cHM6Ly9naXRodWIuY29tL3BtZW0vbmRjdGwvYmxvYi9tYXN0ZXIvdGVzdC9kYXguc2gjTDc5DQpB
bmQgdGhlIGZhaWxpbmcgdW1vdW50IGhhcHBlbnMgcmlnaHQgYWZ0ZXIgJ3J1bl90ZXN0Jywgd2hp
Y2ggY2FsbHMgdGhpczoNCmh0dHBzOi8vZ2l0aHViLmNvbS9wbWVtL25kY3RsL2Jsb2IvbWFzdGVy
L3Rlc3QvZGF4LXBtZC5jDQoNCg0KPiANCj4gIGZzL2Jsb2NrX2Rldi5jICAgICAgICAgIHwgIDIg
Ky0NCj4gIGZzL2RheC5jICAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0NCj4gIGZzL2lub2Rl
LmMgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGluY2x1ZGUvbGludXgvZnMuaCAgICAgIHwgIDIg
LS0NCj4gIGluY2x1ZGUvbGludXgvcGFnZW1hcC5oIHwgIDUgKysrKysNCj4gIG1tL2ZpbGVtYXAu
YyAgICAgICAgICAgIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ICBtbS90cnVuY2F0ZS5jICAgICAg
ICAgICB8IDE5ICsrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIG1tL3dvcmtpbmdzZXQuYyAgICAgICAg
IHwgIDEgLQ0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlv
bnMoLSkNCj4gDQo=
