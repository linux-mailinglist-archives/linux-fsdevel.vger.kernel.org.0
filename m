Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0130D11580F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 20:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFT6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 14:58:12 -0500
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:63809
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfLFT6M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:58:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6h6PzoYrb/E67tuZYwCPTuYkf3sURTdlLtkftgP2da7VsL+mDNduYvJ+wRBt/d8jvqh5gZa1OM9mpEddSla46gNGzopxasI8ZZl2P4aPZosofCf5/Hv4OHOCYfJLoIz+W4ir1czyWc6R/8tibU2mrBu9Lwv/7KvOCGBWgwwmWyeizIcoS8a2Jr4pAdQMco5EM49XSuh/XUOSWdSl3bTCuxR4CWhng2HojrLdxZuKVN/tkPGuYQG/rlHI6gSfptVGnOKmB/eEUjGuCAJZdWoLce7D+AB5dowRCOFQw040wJJcGaCsdY0FQ84aGtGN5Vem5QEzdq7veRRRLsRyETOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+krA8MBJohXYSDvmgXbTo/8z+U6Th3ahj1P7JVoUnI=;
 b=ebfNFSC6zqV7lLz/TDTXHGMA3LDqwf2AuNerTYDhwIl8PEXA6Vd9M99VNTeQvsCV6VzluDKWzxekpxQNCzXjtNHKjNzBSrqWNes6emXIjIx0P6J+NmHe22jARKwuD5S+z3othkzC/OEM/eehQ/t1SBdS6Rua1mRkPTzC6WCxmmpExA6onMPr5Z5xHwCNGRv8u0T7MtzXFQiYufsjWv8h/d5fnmd0dC6nLOD4UOCmY+TWpo7O0mvzd11SdQP3QdWWuuPQmJFqZd+ltzf2jpI03Wn4jO0PwvEHVM/uthzy4OVOdlGXbZ5ygGUfCWJxcRWlyj2zdV7De5srYl8tV49T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+krA8MBJohXYSDvmgXbTo/8z+U6Th3ahj1P7JVoUnI=;
 b=KQZ0SqL0kaw7pSE36AIxvbTImRWmZFveLO93mBKlWhY6VgwnZszXSHclkK2ii3s17K9OU7x09o3vi5p2JbRN8+YGk+m1/2nzVQ6dceAxFUgTEBtC+0xQXxgHSOOUY3RYnmxSdaCLql4hRUDhhcSq4ClCR2Sd6piCfXfAdXerI84=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB5009.namprd06.prod.outlook.com (10.167.234.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 6 Dec 2019 19:58:06 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 19:58:06 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH v5 00/27] nfs: Mount API conversion
Thread-Topic: [PATCH v5 00/27] nfs: Mount API conversion
Thread-Index: AQHVn7ce11HKivELG02muu4tla+T5aetRpWAgABY7oA=
Date:   Fri, 6 Dec 2019 19:58:06 +0000
Message-ID: <e9ec119bff91eb7a7ac40f269487ddea8b7bade2.camel@netapp.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
         <20191206143947.GV4276@coeurl.usersys.redhat.com>
In-Reply-To: <20191206143947.GV4276@coeurl.usersys.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [2600:1702:260:c260:aa6d:aaff:fe2e:8a6a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6c93081-3278-4348-f8f3-08d77a869c74
x-ms-traffictypediagnostic: BL0PR06MB5009:
x-microsoft-antispam-prvs: <BL0PR06MB5009716E3D996D874BD3BFB9F85F0@BL0PR06MB5009.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(2616005)(66946007)(66476007)(6486002)(86362001)(66446008)(66556008)(64756008)(4326008)(76176011)(36756003)(186003)(5660300002)(71200400001)(6512007)(71190400001)(91956017)(76116006)(54906003)(81156014)(81166006)(8676002)(478600001)(316002)(305945005)(58126008)(110136005)(118296001)(229853002)(6506007)(102836004)(2906002)(8936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB5009;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BPMcAAktJ83666FE2qLHqoBxPAbe1Issl3i36lbwhvri9pwKeYr60yznPjZvFHlckV5jcXp7jHxo4GxuJW5skfDM0n3m6r6u8e0VMfLxok5q2F3CyeEIvKg7RQq8QKACSPOvi7PKrnZBVKycLs0kS/M1wnnQ1/hV0BEvIdKdYxsO3Jyt90Cm8IeFVH/Q3QlQ/TIPO+8IyaqiTgU7GhuX6BlnQv8RiT74tvBZOYDb4c5ewZGCqFc5QfMPm/mYQ8enT+cfGzg+QKZ/VR+p99XlCn6HG316RMIGp6LznroYvIvBJYI2UvhlpwPCW9nfhpaPSZXeGI0Sz7arSis6/lhcxnJ7tIk8UWPkNnXwme15EVYQ6aRpKy2xeiBHR6k24w4B+HtJ7ulfC8VsuVCaOQDW6cokhO+UlqmRVfpumIaPr8+HrMCMJloPhiW7pVLBkrr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <78383F9ED9D8184292C1859AE3E0BE4F@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c93081-3278-4348-f8f3-08d77a869c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 19:58:06.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPsKwvASxPTM/D/kujRedPa26Up5dr113be4bEZdAoxKESGo9AM7WO41WB3NnZP0BVnrWS+8HZkbvp9HmQqUIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB5009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgU2NvdHQsDQoNCk9uIEZyaSwgMjAxOS0xMi0wNiBhdCAwOTozOSAtMDUwMCwgU2NvdHQgTWF5
aGV3IHdyb3RlOg0KPiBIaSBBbm5hLCBUcm9uZCwNCj4gDQo+IEhhdmUgeW91IGhhZCBhIGNoYW5j
ZSB0byBsb29rIGF0IHRoZXNlPyAgRG8geW91IGhhdmUgYW55IGNvbW1lbnRzPyAgSSBkbw0KPiBo
YXZlIGEgc21hbGwgZml4IHRvIG1ha2UgdG8gbmZzNF92YWxpZGF0ZV9mc3BhdGgoKSBmb3IgYW4g
aXNzdWUgdGhhdCBEYW4NCj4gQ2FycGVudGVyIHJlcG9ydGVkLCBidXQgSSB3YXMgd2FpdGluZyB0
byBzZWUgaWYgdGhlcmUgd2FzIGFueXRoaW5nIGVsc2UuDQoNCkkgYWN0dWFsbHkganVzdCBmaW5p
c2hlZCBnb2luZyB0aHJvdWdoIHRoZXNlISBGb3IgdGhlIG1vc3QgcGFydCB0aGV5IGxvb2tlZA0K
ZmluZSwgYnV0IHRoZXJlIHdlcmUgYSBmZXcgbWVyZ2UgaXNzdWVzIHdpdGggb3RoZXIgcGF0Y2hl
cyAoZXNwZWNpYWxseSB0aGUgb25lcw0KZm9yIG1pbm9yIGNsZWFudXBzIGxpa2UgdW5uZWNlc3Nh
cnkgc2VtaWNvbG9ucykuIENhbiB5b3UgcmViYXNlIHRoZW0gb24gcmMxIGFuZA0KcmVzZW5kPyBJ
J2xsIHRyeSB0byBnZXQgdGhlbSBmaXJzdCBvbiBteSA1LjYgYnJhbmNoLg0KDQpUaGFua3MsDQpB
bm5hDQoNCj4gDQo+IC1TY290dA0KPiANCj4gT24gV2VkLCAyMCBOb3YgMjAxOSwgU2NvdHQgTWF5
aGV3IHdyb3RlOg0KPiANCj4gPiBIaSBUcm9uZCwgQW5uYSwNCj4gPiANCj4gPiBIZXJlJ3MgYSBz
ZXQgb2YgcGF0Y2hlcyB0aGF0IGNvbnZlcnRzIE5GUyB0byB1c2UgdGhlIG1vdW50IEFQSS4gIE5v
dGUgdGhhdA0KPiA+IHRoZXJlIGFyZSBhIGxvdCBvZiBwcmVsaW1pbmFyeSBwYXRjaGVzLCBzb21l
IGZyb20gRGF2aWQgYW5kIHNvbWUgZnJvbSBBbC4NCj4gPiBUaGUgZmluYWwgcGF0Y2ggKHRoZSBv
bmUgdGhhdCBkb2VzIHRoZSBhY3R1YWwgY29udmVyc2lvbikgZnJvbSB0aGUgRGF2aWQncw0KPiA+
IGluaXRpYWwgcG9zdGluZyBoYXMgYmVlbiBzcGxpdCBpbnRvIDUgc2VwYXJhdGUgcGF0Y2hlcywg
YW5kIHRoZSBlbnRpcmUgc2V0DQo+ID4gaGFzIGJlZW4gcmViYXNlZCBvbiB0b3Agb2YgNS40LXJj
OC4NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHY0Og0KPiA+IC0gZnVydGhlciBzcGxpdCB0aGUg
b3JpZ2luYWwgIk5GUzogQWRkIGZzX2NvbnRleHQgc3VwcG9ydCIgcGF0Y2ggKG5ldw0KPiA+ICAg
cGF0Y2ggaXMgYWJvdXQgMjUlIHNtYWxsZXIgdGhhbiB0aGUgdjQgcGF0Y2gpDQo+ID4gLSBmaXhl
ZCBORlN2NCByZWZlcnJhbCBtb3VudHMgKGJyb2tlbiBpbiB0aGUgb3JpZ2luYWwgcGF0Y2gpDQo+
ID4gLSBmaXhlZCBsZWFrIG9mIG5mc19mYXR0ciB3aGVuIGZzX2NvbnRleHQgaXMgZnJlZWQNCj4g
PiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+IC0gY2hhbmdlZCBsaWNlbnNlIGFuZCBjb3B5cmlnaHQg
dGV4dCBpbiBmcy9uZnMvZnNfY29udGV4dC5jDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gPiAt
IGZpeGVkIHRoZSBjb252ZXJzaW9uIG9mIHRoZSBuY29ubmVjdD0gb3B0aW9uDQo+ID4gLSBhZGRl
ZCAnI2lmIElTX0VOQUJMRUQoQ09ORklHX05GU19WNCknIGFyb3VuZCBuZnM0X3BhcnNlX21vbm9s
aXRoaWMoKQ0KPiA+ICAgdG8gYXZvaWQgdW51c2VkLWZ1bmN0aW9uIHdhcm5pbmcgd2hlbiBjb21w
aWxpbmcgd2l0aCB2NCBkaXNhYmxlZA0KPiA+IENoYWduZXMgc2luY2UgdjE6DQo+ID4gLSBzcGxp
dCB1cCBwYXRjaCAyMyBpbnRvIDQgc2VwYXJhdGUgcGF0Y2hlcw0KPiA+IA0KPiA+IC1TY290dA0K
PiA+IA0KPiA+IEFsIFZpcm8gKDE1KToNCj4gPiAgIHNhbmVyIGNhbGxpbmcgY29udmVudGlvbnMg
Zm9yIG5mc19mc19tb3VudF9jb21tb24oKQ0KPiA+ICAgbmZzOiBzdGFzaCBzZXJ2ZXIgaW50byBz
dHJ1Y3QgbmZzX21vdW50X2luZm8NCj4gPiAgIG5mczogbGlmdCBzZXR0aW5nIG1vdW50X2luZm8g
ZnJvbSBuZnM0X3JlbW90ZXssX3JlZmVycmFsfV9tb3VudA0KPiA+ICAgbmZzOiBmb2xkIG5mczRf
cmVtb3RlX2ZzX3R5cGUgYW5kIG5mczRfcmVtb3RlX3JlZmVycmFsX2ZzX3R5cGUNCj4gPiAgIG5m
czogZG9uJ3QgYm90aGVyIHNldHRpbmcvcmVzdG9yaW5nIGV4cG9ydF9wYXRoIGFyb3VuZA0KPiA+
ICAgICBkb19uZnNfcm9vdF9tb3VudCgpDQo+ID4gICBuZnM0OiBmb2xkIG5mc19kb19yb290X21v
dW50L25mc19mb2xsb3dfcmVtb3RlX3BhdGgNCj4gPiAgIG5mczogbGlmdCBzZXR0aW5nIG1vdW50
X2luZm8gZnJvbSBuZnNfeGRldl9tb3VudCgpDQo+ID4gICBuZnM6IHN0YXNoIG5mc19zdWJ2ZXJz
aW9uIHJlZmVyZW5jZSBpbnRvIG5mc19tb3VudF9pbmZvDQo+ID4gICBuZnM6IGRvbid0IGJvdGhl
ciBwYXNzaW5nIG5mc19zdWJ2ZXJzaW9uIHRvIC0+dHJ5X21vdW50KCkgYW5kDQo+ID4gICAgIG5m
c19mc19tb3VudF9jb21tb24oKQ0KPiA+ICAgbmZzOiBtZXJnZSB4ZGV2IGFuZCByZW1vdGUgZmls
ZV9zeXN0ZW1fdHlwZQ0KPiA+ICAgbmZzOiB1bmV4cG9ydCBuZnNfZnNfbW91bnRfY29tbW9uKCkN
Cj4gPiAgIG5mczogZG9uJ3QgcGFzcyBuZnNfc3VidmVyc2lvbiB0byAtPmNyZWF0ZV9zZXJ2ZXIo
KQ0KPiA+ICAgbmZzOiBnZXQgcmlkIG9mIG1vdW50X2luZm8gLT5maWxsX3N1cGVyKCkNCj4gPiAg
IG5mc19jbG9uZV9zYl9zZWN1cml0eSgpOiBzaW1wbGlmeSB0aGUgY2hlY2sgZm9yIHNlcnZlciBi
b2dvc2l0eQ0KPiA+ICAgbmZzOiBnZXQgcmlkIG9mIC0+c2V0X3NlY3VyaXR5KCkNCj4gPiANCj4g
PiBEYXZpZCBIb3dlbGxzICg4KToNCj4gPiAgIE5GUzogTW92ZSBtb3VudCBwYXJhbWV0ZXJpc2F0
aW9uIGJpdHMgaW50byB0aGVpciBvd24gZmlsZQ0KPiA+ICAgTkZTOiBDb25zdGlmeSBtb3VudCBh
cmd1bWVudCBtYXRjaCB0YWJsZXMNCj4gPiAgIE5GUzogUmVuYW1lIHN0cnVjdCBuZnNfcGFyc2Vk
X21vdW50X2RhdGEgdG8gc3RydWN0IG5mc19mc19jb250ZXh0DQo+ID4gICBORlM6IFNwbGl0IG5m
c19wYXJzZV9tb3VudF9vcHRpb25zKCkNCj4gPiAgIE5GUzogRGVpbmRlbnQgbmZzX2ZzX2NvbnRl
eHRfcGFyc2Vfb3B0aW9uKCkNCj4gPiAgIE5GUzogQWRkIGEgc21hbGwgYnVmZmVyIGluIG5mc19m
c19jb250ZXh0IHRvIGF2b2lkIHN0cmluZyBkdXANCj4gPiAgIE5GUzogRG8gc29tZSB0aWR5aW5n
IG9mIHRoZSBwYXJzaW5nIGNvZGUNCj4gPiAgIE5GUzogQWRkIGZzX2NvbnRleHQgc3VwcG9ydC4N
Cj4gPiANCj4gPiBTY290dCBNYXloZXcgKDQpOg0KPiA+ICAgTkZTOiByZW5hbWUgbmZzX2ZzX2Nv
bnRleHQgcG9pbnRlciBhcmcgaW4gYSBmZXcgZnVuY3Rpb25zDQo+ID4gICBORlM6IENvbnZlcnQg
bW91bnQgb3B0aW9uIHBhcnNpbmcgdG8gdXNlIGZ1bmN0aW9uYWxpdHkgZnJvbQ0KPiA+ICAgICBm
c19wYXJzZXIuaA0KPiA+ICAgTkZTOiBBZGRpdGlvbmFsIHJlZmFjdG9yaW5nIGZvciBmc19jb250
ZXh0IGNvbnZlcnNpb24NCj4gPiAgIE5GUzogQXR0YWNoIHN1cHBsZW1lbnRhcnkgZXJyb3IgaW5m
b3JtYXRpb24gdG8gZnNfY29udGV4dC4NCj4gPiANCj4gPiAgZnMvbmZzL01ha2VmaWxlICAgICAg
ICAgfCAgICAyICstDQo+ID4gIGZzL25mcy9jbGllbnQuYyAgICAgICAgIHwgICA4MCArLQ0KPiA+
ICBmcy9uZnMvZnNfY29udGV4dC5jICAgICB8IDE0MjQgKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICBmcy9uZnMvZnNjYWNoZS5jICAgICAgICB8ICAgIDIgKy0NCj4gPiAgZnMvbmZzL2dl
dHJvb3QuYyAgICAgICAgfCAgIDczICstDQo+ID4gIGZzL25mcy9pbnRlcm5hbC5oICAgICAgIHwg
IDEzMiArLS0NCj4gPiAgZnMvbmZzL25hbWVzcGFjZS5jICAgICAgfCAgMTQ0ICsrLQ0KPiA+ICBm
cy9uZnMvbmZzM19mcy5oICAgICAgICB8ICAgIDIgKy0NCj4gPiAgZnMvbmZzL25mczNjbGllbnQu
YyAgICAgfCAgICA2ICstDQo+ID4gIGZzL25mcy9uZnMzcHJvYy5jICAgICAgIHwgICAgMiArLQ0K
PiA+ICBmcy9uZnMvbmZzNF9mcy5oICAgICAgICB8ICAgIDkgKy0NCj4gPiAgZnMvbmZzL25mczRj
bGllbnQuYyAgICAgfCAgIDk5ICstDQo+ID4gIGZzL25mcy9uZnM0bmFtZXNwYWNlLmMgIHwgIDI5
MSArKy0tLQ0KPiA+ICBmcy9uZnMvbmZzNHByb2MuYyAgICAgICB8ICAgIDIgKy0NCj4gPiAgZnMv
bmZzL25mczRzdXBlci5jICAgICAgfCAgMjU3ICsrLS0tDQo+ID4gIGZzL25mcy9wcm9jLmMgICAg
ICAgICAgIHwgICAgMiArLQ0KPiA+ICBmcy9uZnMvc3VwZXIuYyAgICAgICAgICB8IDIyMTkgKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgv
bmZzX3hkci5oIHwgICAgOSArLQ0KPiA+ICAxOCBmaWxlcyBjaGFuZ2VkLCAyMjgzIGluc2VydGlv
bnMoKyksIDI0NzIgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9uZnMv
ZnNfY29udGV4dC5jDQo+ID4gDQo+ID4gLS0gDQo+ID4gMi4xNy4yDQo+ID4gDQo=
