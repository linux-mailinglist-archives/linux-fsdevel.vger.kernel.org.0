Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E452B5DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 12:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgKQLIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 06:08:09 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2373 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:08:08 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Cb37b53Yyz54V2;
        Tue, 17 Nov 2020 19:07:39 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 17 Nov 2020 19:07:57 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 17 Nov 2020 19:07:57 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 17 Nov 2020 19:07:57 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
Thread-Topic: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
Thread-Index: AQHWuaxO0H5megy+qEKBM1T+1aO5TKnMHhDQ//+HLICAAIXtUA==
Date:   Tue, 17 Nov 2020 11:07:57 +0000
Message-ID: <714ae7d701d446259ab269f14a030fe9@hisilicon.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <349168819c1249d4bceea26597760b0a@hisilicon.com>
 <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
In-Reply-To: <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.113]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTXVjaHVuIFNvbmcgW21h
aWx0bzpzb25nbXVjaHVuQGJ5dGVkYW5jZS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDE3LCAyMDIwIDExOjUwIFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25n
LmJhby5odWFAaGlzaWxpY29uLmNvbT4NCj4gQ2M6IGNvcmJldEBsd24ubmV0OyBtaWtlLmtyYXZl
dHpAb3JhY2xlLmNvbTsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBi
cEBhbGllbjguZGU7IHg4NkBrZXJuZWwub3JnOyBocGFAenl0b3IuY29tOw0KPiBkYXZlLmhhbnNl
bkBsaW51eC5pbnRlbC5jb207IGx1dG9Aa2VybmVsLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7
DQo+IHZpcm9AemVuaXYubGludXgub3JnLnVrOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBw
YXVsbWNrQGtlcm5lbC5vcmc7DQo+IG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc7IHBhd2FuLmt1
bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gcmR1bmxhcEBpbmZyYWRlYWQub3JnOyBvbmV1
a3VtQHN1c2UuY29tOyBhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tOw0KPiBqcm9lZGVsQHN1c2Uu
ZGU7IGFsbWFzcnltaW5hQGdvb2dsZS5jb207IHJpZW50amVzQGdvb2dsZS5jb207DQo+IHdpbGx5
QGluZnJhZGVhZC5vcmc7IG9zYWx2YWRvckBzdXNlLmRlOyBtaG9ja29Ac3VzZS5jb207DQo+IGR1
YW54aW9uZ2NodW5AYnl0ZWRhbmNlLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiBsaW51
eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0V4dGVybmFsXSBSRTog
W1BBVENIIHY0IDAwLzIxXSBGcmVlIHNvbWUgdm1lbW1hcCBwYWdlcyBvZg0KPiBodWdldGxiIHBh
Z2UNCj4gDQo+IE9uIFR1ZSwgTm92IDE3LCAyMDIwIGF0IDY6MTYgUE0gU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiA+DQo+
ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IG93
bmVyLWxpbnV4LW1tQGt2YWNrLm9yZyBbbWFpbHRvOm93bmVyLWxpbnV4LW1tQGt2YWNrLm9yZ10g
T24NCj4gPiA+IEJlaGFsZiBPZiBNdWNodW4gU29uZw0KPiA+ID4gU2VudDogU2F0dXJkYXksIE5v
dmVtYmVyIDE0LCAyMDIwIDEyOjAwIEFNDQo+ID4gPiBUbzogY29yYmV0QGx3bi5uZXQ7IG1pa2Uu
a3JhdmV0ekBvcmFjbGUuY29tOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+ID4gPiBtaW5nb0ByZWRo
YXQuY29tOyBicEBhbGllbjguZGU7IHg4NkBrZXJuZWwub3JnOyBocGFAenl0b3IuY29tOw0KPiA+
ID4gZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBsdXRvQGtlcm5lbC5vcmc7IHBldGVyekBp
bmZyYWRlYWQub3JnOw0KPiA+ID4gdmlyb0B6ZW5pdi5saW51eC5vcmcudWs7IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7IHBhdWxtY2tAa2VybmVsLm9yZzsNCj4gPiA+IG1jaGVoYWIraHVhd2Vp
QGtlcm5lbC5vcmc7IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gPiA+IHJk
dW5sYXBAaW5mcmFkZWFkLm9yZzsgb25ldWt1bUBzdXNlLmNvbTsNCj4gYW5zaHVtYW4ua2hhbmR1
YWxAYXJtLmNvbTsNCj4gPiA+IGpyb2VkZWxAc3VzZS5kZTsgYWxtYXNyeW1pbmFAZ29vZ2xlLmNv
bTsgcmllbnRqZXNAZ29vZ2xlLmNvbTsNCj4gPiA+IHdpbGx5QGluZnJhZGVhZC5vcmc7IG9zYWx2
YWRvckBzdXNlLmRlOyBtaG9ja29Ac3VzZS5jb20NCj4gPiA+IENjOiBkdWFueGlvbmdjaHVuQGJ5
dGVkYW5jZS5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+ID4gPiBsaW51eC1mc2Rl
dmVsQHZnZXIua2VybmVsLm9yZzsgTXVjaHVuIFNvbmcNCj4gPHNvbmdtdWNodW5AYnl0ZWRhbmNl
LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2NCAwMC8yMV0gRnJlZSBzb21lIHZtZW1tYXAg
cGFnZXMgb2YgaHVnZXRsYiBwYWdlDQo+ID4gPg0KPiA+ID4gSGkgYWxsLA0KPiA+ID4NCj4gPiA+
IFRoaXMgcGF0Y2ggc2VyaWVzIHdpbGwgZnJlZSBzb21lIHZtZW1tYXAgcGFnZXMoc3RydWN0IHBh
Z2Ugc3RydWN0dXJlcykNCj4gPiA+IGFzc29jaWF0ZWQgd2l0aCBlYWNoIGh1Z2V0bGJwYWdlIHdo
ZW4gcHJlYWxsb2NhdGVkIHRvIHNhdmUgbWVtb3J5Lg0KPiA+ID4NCj4gPiA+IE5vd2FkYXlzIHdl
IHRyYWNrIHRoZSBzdGF0dXMgb2YgcGh5c2ljYWwgcGFnZSBmcmFtZXMgdXNpbmcgc3RydWN0IHBh
Z2UNCj4gPiA+IHN0cnVjdHVyZXMgYXJyYW5nZWQgaW4gb25lIG9yIG1vcmUgYXJyYXlzLiBBbmQg
aGVyZSBleGlzdHMgb25lLXRvLW9uZQ0KPiA+ID4gbWFwcGluZyBiZXR3ZWVuIHRoZSBwaHlzaWNh
bCBwYWdlIGZyYW1lIGFuZCB0aGUgY29ycmVzcG9uZGluZyBzdHJ1Y3QNCj4gcGFnZQ0KPiA+ID4g
c3RydWN0dXJlLg0KPiA+ID4NCj4gPiA+IFRoZSBIdWdlVExCIHN1cHBvcnQgaXMgYnVpbHQgb24g
dG9wIG9mIG11bHRpcGxlIHBhZ2Ugc2l6ZSBzdXBwb3J0IHRoYXQNCj4gPiA+IGlzIHByb3ZpZGVk
IGJ5IG1vc3QgbW9kZXJuIGFyY2hpdGVjdHVyZXMuIEZvciBleGFtcGxlLCB4ODYgQ1BVcyBub3Jt
YWxseQ0KPiA+ID4gc3VwcG9ydCA0SyBhbmQgMk0gKDFHIGlmIGFyY2hpdGVjdHVyYWxseSBzdXBw
b3J0ZWQpIHBhZ2Ugc2l6ZXMuIEV2ZXJ5DQo+ID4gPiBIdWdlVExCIGhhcyBtb3JlIHRoYW4gb25l
IHN0cnVjdCBwYWdlIHN0cnVjdHVyZS4gVGhlIDJNIEh1Z2VUTEIgaGFzDQo+IDUxMg0KPiA+ID4g
c3RydWN0IHBhZ2Ugc3RydWN0dXJlIGFuZCAxRyBIdWdlVExCIGhhcyA0MDk2IHN0cnVjdCBwYWdl
IHN0cnVjdHVyZXMuIEJ1dA0KPiA+ID4gaW4gdGhlIGNvcmUgb2YgSHVnZVRMQiBvbmx5IHVzZXMg
dGhlIGZpcnN0IDQgKFVzZSBvZiBmaXJzdCA0IHN0cnVjdCBwYWdlDQo+ID4gPiBzdHJ1Y3R1cmVz
IGNvbWVzIGZyb20gSFVHRVRMQl9DR1JPVVBfTUlOX09SREVSLikgc3RydWN0IHBhZ2UNCj4gPiA+
IHN0cnVjdHVyZXMgdG8NCj4gPiA+IHN0b3JlIG1ldGFkYXRhIGFzc29jaWF0ZWQgd2l0aCBlYWNo
IEh1Z2VUTEIuIFRoZSByZXN0IG9mIHRoZSBzdHJ1Y3QgcGFnZQ0KPiA+ID4gc3RydWN0dXJlcyBh
cmUgdXN1YWxseSByZWFkIHRoZSBjb21wb3VuZF9oZWFkIGZpZWxkIHdoaWNoIGFyZSBhbGwgdGhl
IHNhbWUNCj4gPiA+IHZhbHVlLiBJZiB3ZSBjYW4gZnJlZSBzb21lIHN0cnVjdCBwYWdlIG1lbW9y
eSB0byBidWRkeSBzeXN0ZW0gc28gdGhhdCB3ZQ0KPiA+ID4gY2FuIHNhdmUgYSBsb3Qgb2YgbWVt
b3J5Lg0KPiA+ID4NCj4gPiA+IFdoZW4gdGhlIHN5c3RlbSBib290IHVwLCBldmVyeSAyTSBIdWdl
VExCIGhhcyA1MTIgc3RydWN0IHBhZ2UNCj4gc3RydWN0dXJlcw0KPiA+ID4gd2hpY2ggc2l6ZSBp
cyA4IHBhZ2VzKHNpemVvZihzdHJ1Y3QgcGFnZSkgKiA1MTIgLyBQQUdFX1NJWkUpLg0KPiA+ID4N
Cj4gPiA+ICAgIGh1Z2V0bGJwYWdlICAgICAgICAgICAgICAgICAgc3RydWN0IHBhZ2VzKDggcGFn
ZXMpICAgICAgICAgIHBhZ2UNCj4gPiA+IGZyYW1lKDggcGFnZXMpDQo+ID4gPiAgICstLS0tLS0t
LS0tLSsgLS0tdmlydF90b19wYWdlLS0tPiArLS0tLS0tLS0tLS0rICAgbWFwcGluZyB0byAgICst
LS0tLS0tLS0tLSsNCj4gPiA+ICAgfCAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwg
ICAgIDAgICAgIHwgLS0tLS0tLS0tLS0tLT4gfA0KPiAwDQo+ID4gPiB8DQo+ID4gPiAgIHwgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8ICAgICAxICAgICB8IC0tLS0tLS0tLS0tLS0+
IHwNCj4gMQ0KPiA+ID4gfA0KPiA+ID4gICB8ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgMiAgICAgfCAtLS0tLS0tLS0tLS0tPiB8DQo+IDINCj4gPiA+IHwNCj4gPiA+ICAg
fCAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwgICAgIDMgICAgIHwgLS0tLS0tLS0t
LS0tLT4gfA0KPiAzDQo+ID4gPiB8DQo+ID4gPiAgIHwgICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICB8ICAgICA0ICAgICB8IC0tLS0tLS0tLS0tLS0+IHwNCj4gNA0KPiA+ID4gfA0KPiA+
ID4gICB8ICAgICAyTSAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAgICAgNSAgICAgfCAtLS0t
LS0tLS0tLS0tPiB8DQo+ID4gPiA1ICAgICB8DQo+ID4gPiAgIHwgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICB8ICAgICA2ICAgICB8IC0tLS0tLS0tLS0tLS0+IHwNCj4gNg0KPiA+ID4g
fA0KPiA+ID4gICB8ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAgICAgNyAgICAg
fCAtLS0tLS0tLS0tLS0tPiB8DQo+IDcNCj4gPiA+IHwNCj4gPiA+ICAgfCAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLSsNCj4gPiA+ICstLS0tLS0tLS0tLSsNCj4g
PiA+ICAgfCAgICAgICAgICAgfA0KPiA+ID4gICB8ICAgICAgICAgICB8DQo+ID4gPiAgICstLS0t
LS0tLS0tLSsNCj4gPiA+DQo+ID4gPg0KPiA+ID4gV2hlbiBhIGh1Z2V0bGJwYWdlIGlzIHByZWFs
bG9jYXRlZCwgd2UgY2FuIGNoYW5nZSB0aGUgbWFwcGluZyBmcm9tDQo+IGFib3ZlDQo+ID4gPiB0
bw0KPiA+ID4gYmVsbG93Lg0KPiA+ID4NCj4gPiA+ICAgIGh1Z2V0bGJwYWdlICAgICAgICAgICAg
ICAgICAgc3RydWN0IHBhZ2VzKDggcGFnZXMpICAgICAgICAgIHBhZ2UNCj4gPiA+IGZyYW1lKDgg
cGFnZXMpDQo+ID4gPiAgICstLS0tLS0tLS0tLSsgLS0tdmlydF90b19wYWdlLS0tPiArLS0tLS0t
LS0tLS0rICAgbWFwcGluZyB0byAgICstLS0tLS0tLS0tLSsNCj4gPiA+ICAgfCAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgIHwgICAgIDAgICAgIHwgLS0tLS0tLS0tLS0tLT4gfA0KPiAw
DQo+ID4gPiB8DQo+ID4gPiAgIHwgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8ICAg
ICAxICAgICB8IC0tLS0tLS0tLS0tLS0+IHwNCj4gMQ0KPiA+ID4gfA0KPiA+ID4gICB8ICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAgICAgMiAgICAgfCAtLS0tLS0tLS0tLS0tPg0K
PiA+ID4gKy0tLS0tLS0tLS0tKw0KPiA+ID4gICB8ICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgMyAgICAgfCAtLS0tLS0tLS0tLS0tLS0tLV4gXg0KPiBeIF4NCj4gPiA+IF4N
Cj4gPiA+ICAgfCAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwgICAgIDQgICAgIHwg
LS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gfCB8DQo+ID4gPiB8DQo+ID4gPiAgIHwgICAgIDJNICAg
IHwgICAgICAgICAgICAgICAgICAgICB8ICAgICA1ICAgICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgfA0KPiA+ID4gfA0KPiA+ID4gICB8ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgNiAgICAgfA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgfA0KPiA+ID4gICB8
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAgICAgNyAgICAgfA0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ID4gICB8ICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgKy0tLS0tLS0tLS0tKw0KPiA+ID4gICB8ICAgICAgICAgICB8DQo+ID4gPiAgIHwgICAg
ICAgICAgIHwNCj4gPiA+ICAgKy0tLS0tLS0tLS0tKw0KPiA+ID4NCj4gPiA+IEZvciB0YWlsIHBh
Z2VzLCB0aGUgdmFsdWUgb2YgY29tcG91bmRfaGVhZCBpcyB0aGUgc2FtZS4gU28gd2UgY2FuIHJl
dXNlDQo+ID4gPiBmaXJzdCBwYWdlIG9mIHRhaWwgcGFnZSBzdHJ1Y3RzLiBXZSBtYXAgdGhlIHZp
cnR1YWwgYWRkcmVzc2VzIG9mIHRoZQ0KPiA+ID4gcmVtYWluaW5nIDYgcGFnZXMgb2YgdGFpbCBw
YWdlIHN0cnVjdHMgdG8gdGhlIGZpcnN0IHRhaWwgcGFnZSBzdHJ1Y3QsDQo+ID4gPiBhbmQgdGhl
biBmcmVlIHRoZXNlIDYgcGFnZXMuIFRoZXJlZm9yZSwgd2UgbmVlZCB0byByZXNlcnZlIGF0IGxl
YXN0IDINCj4gPiA+IHBhZ2VzIGFzIHZtZW1tYXAgYXJlYXMuDQo+ID4gPg0KPiA+ID4gV2hlbiBh
IGh1Z2V0bGJwYWdlIGlzIGZyZWVkIHRvIHRoZSBidWRkeSBzeXN0ZW0sIHdlIHNob3VsZCBhbGxv
Y2F0ZSBzaXgNCj4gPiA+IHBhZ2VzIGZvciB2bWVtbWFwIHBhZ2VzIGFuZCByZXN0b3JlIHRoZSBw
cmV2aW91cyBtYXBwaW5nIHJlbGF0aW9uc2hpcC4NCj4gPiA+DQo+ID4gPiBJZiB3ZSB1c2VzIHRo
ZSAxRyBodWdldGxicGFnZSwgd2UgY2FuIHNhdmUgNDA4OCBwYWdlcyhUaGVyZSBhcmUgNDA5Ng0K
PiBwYWdlcw0KPiA+ID4gZm9yDQo+ID4gPiBzdHJ1Y3QgcGFnZSBzdHJ1Y3R1cmVzLCB3ZSByZXNl
cnZlIDIgcGFnZXMgZm9yIHZtZW1tYXAgYW5kIDggcGFnZXMgZm9yDQo+IHBhZ2UNCj4gPiA+IHRh
Ymxlcy4gU28gd2UgY2FuIHNhdmUgNDA4OCBwYWdlcykuIFRoaXMgaXMgYSB2ZXJ5IHN1YnN0YW50
aWFsIGdhaW4uIE9uIG91cg0KPiA+ID4gc2VydmVyLCBydW4gc29tZSBTUERLL1FFTVUgYXBwbGlj
YXRpb25zIHdoaWNoIHdpbGwgdXNlIDEwMjRHQg0KPiBodWdldGxicGFnZS4NCj4gPiA+IFdpdGgg
dGhpcyBmZWF0dXJlIGVuYWJsZWQsIHdlIGNhbiBzYXZlIH4xNkdCKDFHIGh1Z2VwYWdlKS9+MTFH
QigyTUINCj4gPiA+IGh1Z2VwYWdlKQ0KPiA+DQo+ID4gSGkgTXVjaHVuLA0KPiA+DQo+ID4gRG8g
d2UgcmVhbGx5IHNhdmUgMTFHQiBmb3IgMk1CIGh1Z2VwYWdlPw0KPiA+IEhvdyBtdWNoIGRvIHdl
IHNhdmUgaWYgd2Ugb25seSBnZXQgb25lIDJNQiBodWdldGxiIGZyb20gb25lIDEyOE1CDQo+IG1l
bV9zZWN0aW9uPw0KPiA+IEl0IHNlZW1zIHdlIG5lZWQgdG8gZ2V0IGF0IGxlYXN0IG9uZSBwYWdl
IGZvciB0aGUgUFRFcyBzaW5jZSB3ZSBhcmUgc3BsaXR0aW5nDQo+IFBNRCBvZg0KPiA+IHZtZW1t
YXAgaW50byBQVEU/DQo+IA0KPiBUaGVyZSBhcmUgNTI0Mjg4KDEwMjRHQi8yTUIpIDJNQiBIdWdl
VExCIHBhZ2VzLiBXZSBjYW4gc2F2ZSA2IHBhZ2VzIGZvcg0KPiBlYWNoDQo+IDJNQiBIdWdlVExC
IHBhZ2UuIFNvIHdlIGNhbiBzYXZlIDMxNDU3MjggcGFnZXMuIEJ1dCB3ZSBuZWVkIHRvIHNwbGl0
IFBNRA0KPiBwYWdlDQo+IHRhYmxlIGZvciBldmVyeSBvbmUgMTI4TUIgbWVtX3NlY3Rpb24gYW5k
IGV2ZXJ5IHNlY3Rpb24gbmVlZCBvbmUgcGFnZQ0KPiBhcyBQVEUgcGFnZQ0KPiB0YWJsZS4gU28g
d2UgbmVlZCA4MTkyKDEwMjRHQi8xMjhNQikgcGFnZXMgYXMgUFRFIHBhZ2UgdGFibGVzLg0KPiBG
aW5hbGx5LCB3ZSBjYW4gc2F2ZQ0KPiAzMTM3NTM2KDMxNDU3MjgtODE5MikgcGFnZXMgd2hpY2gg
aXMgMTEuOTdHQi4NCg0KVGhlIHdvcnN0IGNhc2UgSSBjYW4gc2VlIGlzIHRoYXQ6DQppZiB3ZSBn
ZXQgMTAwIGh1Z2V0bGIgd2l0aCAyTUIgc2l6ZSwgYnV0IHRoZSAxMDAgaHVnZXRsYiBjb21lcyBm
cm9tIGRpZmZlcmVudA0KbWVtX3NlY3Rpb24sIHdlIHdvbid0IHNhdmUgMTEuOTdHQi4gd2Ugb25s
eSBzYXZlIDUvOCAqIDE2R0I9MTBHQi4NCg0KQW55d2F5LCBpdCBzZWVtcyAxMUdCIGlzIGluIHRo
ZSBtaWRkbGUgb2YgMTBHQiBhbmQgMTEuOTdHQiwNCnNvIHNvdW5kcyBzZW5zaWJsZSA6LSkNCg0K
aWRlYWxseSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gZnJlZSBQYWdlVGFpbCBpZiB3ZSBjaGFuZ2Ug
c3RydWN0IHBhZ2UgaW4gc29tZSB3YXkuDQpUaGVuIHdlIHdpbGwgc2F2ZSBtdWNoIG1vcmUgZm9y
IDJNQiBodWdldGxiLiBidXQgaXQgc2VlbXMgaXQgaXMgbm90IGVhc3kuDQoNClRoYW5rcw0KQmFy
cnkNCg==
