Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47836AA54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhDZBaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 21:30:46 -0400
Received: from mx21.baidu.com ([220.181.3.85]:37686 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231624AbhDZBap (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:30:45 -0400
Received: from BC-Mail-Ex17.internal.baidu.com (unknown [172.31.51.11])
        by Forcepoint Email with ESMTPS id 941BF715CEB3EB9F0CC5;
        Mon, 26 Apr 2021 09:29:59 +0800 (CST)
Received: from BC-Mail-Ex20.internal.baidu.com (172.31.51.14) by
 BC-Mail-Ex17.internal.baidu.com (172.31.51.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Mon, 26 Apr 2021 09:29:59 +0800
Received: from BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) by
 BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) with mapi id 15.01.2242.008;
 Mon, 26 Apr 2021 09:29:59 +0800
From:   "Chu,Kaiping" <chukaiping@baidu.com>
To:     David Rientjes <rientjes@google.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYzXSBtbS9jb21wYWN0aW9uOmxldCBwcm9hY3RpdmUg?=
 =?gb2312?Q?compaction_order_configurable?=
Thread-Topic: [PATCH v3] mm/compaction:let proactive compaction order
 configurable
Thread-Index: AQHXOjmoEYLrBaldBU+yjbigXZxebarGAdYw
Date:   Mon, 26 Apr 2021 01:29:59 +0000
Message-ID: <14f6897b3dfd4314b85c5865a2f2b5d0@baidu.com>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
 <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
In-Reply-To: <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.194.26]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgUmllbnRqZXMNCkkgYWxyZWFkeSBhbnN3ZXJlZCB5b3VyIHF1ZXN0aW9uIGluIDQuMTkuDQoi
IFdlIHR1cm4gb2ZmIHRoZSB0cmFuc3BhcmVudCBodWdlIHBhZ2UgaW4gb3VyIG1hY2hpbmVzLCBz
byB3ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBvcmRlciA5Lg0KVGhlcmUgYXJlIG1hbnkgdXNlciBz
cGFjZSBhcHBsaWNhdGlvbnMsIGRpZmZlcmVudCBhcHBsaWNhdGlvbiBtYXliZSBhbGxvY2F0ZSBk
aWZmZXJlbnQgb3JkZXIgb2YgbWVtb3J5LCB3ZSBjYW4ndCBrbm93IHRoZSAia25vd24gb3JkZXIg
b2YgaW50ZXJlc3QiIGluIGFkdmFuY2UuIE91ciBwdXJwb3NlIGlzIHRvIGtlZXAgdGhlIG92ZXJh
bGwgZnJhZ21lbnQgaW5kZXggYXMgbG93IGFzIHBvc3NpYmxlLCBub3QgY2FyZSBhYm91dCB0aGUg
c3BlY2lmaWMgb3JkZXIuIA0KQWx0aG91Z2ggY3VycmVudCBwcm9hY3RpdmUgY29tcGFjdGlvbiBt
ZWNoYW5pc20gb25seSBjaGVjayB0aGUgZnJhZ21lbnQgaW5kZXggb2Ygc3BlY2lmaWMgb3JkZXIs
IGJ1dCBpdCBjYW4gZG8gbWVtb3J5IGNvbXBhY3Rpb24gZm9yIGFsbCBvcmRlcigub3JkZXIgPSAt
MSBpbiBwcm9hY3RpdmVfY29tcGFjdF9ub2RlKSwgc28gaXQncyBzdGlsbCB1c2VmdWwgZm9yIHVz
LiANCldlIHNldCB0aGUgY29tcGFjdGlvbl9vcmRlciBhY2NvcmRpbmcgdG8gdGhlIGF2ZXJhZ2Ug
ZnJhZ21lbnQgaW5kZXggb2YgYWxsIG91ciBtYWNoaW5lcywgaXQncyBhbiBleHBlcmllbmNlIHZh
bHVlLCBpdCdzIGEgY29tcHJvbWlzZSBvZiBrZWVwIG1lbW9yeSBmcmFnbWVudCBpbmRleCBsb3cg
YW5kIG5vdCB0cmlnZ2VyIGJhY2tncm91bmQgY29tcGFjdGlvbiB0b28gbXVjaCwgdGhpcyB2YWx1
ZSBjYW4gYmUgY2hhbmdlZCBpbiBmdXR1cmUuDQpXZSBkaWQgcGVyaW9kaWNhbGx5IG1lbW9yeSBj
b21wYWN0aW9uIGJ5IGNvbW1hbmQgImVjaG8gMSA+IC9wcm9jL3N5cy92bS9jb21wYWN0X21lbW9y
eSAiIHByZXZpb3VzbHksIGJ1dCBpdCdzIG5vdCBnb29kIGVub3VnaCwgaXQncyB3aWxsIGNvbXBh
Y3QgYWxsIG1lbW9yeSBmb3JjaWJseSwgaXQgbWF5IGxlYWQgdG8gbG90cyBvZiBtZW1vcnkgbW92
ZSBpbiBzaG9ydCB0aW1lLCBhbmQgYWZmZWN0IHRoZSBwZXJmb3JtYW5jZSBvZiBhcHBsaWNhdGlv
bi4iDQoNCg0KQlIsDQpDaHUgS2FpcGluZw0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7Iyzog
RGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+IA0Kt6LLzcqxvOQ6IDIwMjHE6jTU
wjI2yNUgOToxNQ0KytW8/sjLOiBDaHUsS2FpcGluZyA8Y2h1a2FpcGluZ0BiYWlkdS5jb20+DQqz
rcvNOiBtY2dyb2ZAa2VybmVsLm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyB5emFpa2luQGdv
b2dsZS5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IHZiYWJrYUBzdXNlLmN6OyBuaWd1
cHRhQG52aWRpYS5jb207IGJoZUByZWRoYXQuY29tOyBraGFsaWQuYXppekBvcmFjbGUuY29tOyBp
YW1qb29uc29vLmtpbUBsZ2UuY29tOyBtYXRldXN6bm9zZWswQGdtYWlsLmNvbTsgc2hfZGVmQDE2
My5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWZzZGV2ZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmcNCtb3zOI6IFJlOiBbUEFUQ0ggdjNdIG1tL2Nv
bXBhY3Rpb246bGV0IHByb2FjdGl2ZSBjb21wYWN0aW9uIG9yZGVyIGNvbmZpZ3VyYWJsZQ0KDQpP
biBTdW4sIDI1IEFwciAyMDIxLCBjaHVrYWlwaW5nIHdyb3RlOg0KDQo+IEN1cnJlbnRseSB0aGUg
cHJvYWN0aXZlIGNvbXBhY3Rpb24gb3JkZXIgaXMgZml4ZWQgdG8gDQo+IENPTVBBQ1RJT05fSFBB
R0VfT1JERVIoOSksIGl0J3MgT0sgaW4gbW9zdCBtYWNoaW5lcyB3aXRoIGxvdHMgb2YgDQo+IG5v
cm1hbCA0S0IgbWVtb3J5LCBidXQgaXQncyB0b28gaGlnaCBmb3IgdGhlIG1hY2hpbmVzIHdpdGgg
c21hbGwgDQo+IG5vcm1hbCBtZW1vcnksIGZvciBleGFtcGxlIHRoZSBtYWNoaW5lcyB3aXRoIG1v
c3QgbWVtb3J5IGNvbmZpZ3VyZWQgYXMgDQo+IDFHQiBodWdldGxiZnMgaHVnZSBwYWdlcy4gSW4g
dGhlc2UgbWFjaGluZXMgdGhlIG1heCBvcmRlciBvZiBmcmVlIA0KPiBwYWdlcyBpcyBvZnRlbiBi
ZWxvdyA5LCBhbmQgaXQncyBhbHdheXMgYmVsb3cgOSBldmVuIHdpdGggaGFyZCANCj4gY29tcGFj
dGlvbi4gVGhpcyB3aWxsIGxlYWQgdG8gcHJvYWN0aXZlIGNvbXBhY3Rpb24gYmUgdHJpZ2dlcmVk
IHZlcnkgDQo+IGZyZXF1ZW50bHkuIEluIHRoZXNlIG1hY2hpbmVzIHdlIG9ubHkgY2FyZSBhYm91
dCBvcmRlciBvZiAzIG9yIDQuDQo+IFRoaXMgcGF0Y2ggZXhwb3J0IHRoZSBvZGVyIHRvIHByb2Mg
YW5kIGxldCBpdCBjb25maWd1cmFibGUgYnkgdXNlciwgDQo+IGFuZCB0aGUgZGVmYXVsdCB2YWx1
ZSBpcyBzdGlsbCBDT01QQUNUSU9OX0hQQUdFX09SREVSLg0KPiANCg0KQXMgYXNrZWQgaW4gdGhl
IHJldmlldyBvZiB0aGUgdjEgb2YgdGhlIHBhdGNoLCB3aHkgaXMgdGhpcyBub3QgYSB1c2Vyc3Bh
Y2UgcG9saWN5IGRlY2lzaW9uPyAgSWYgeW91IGFyZSBpbnRlcmVzdGVkIGluIG9yZGVyLTMgb3Ig
b3JkZXItNCBmcmFnbWVudGF0aW9uLCBmb3Igd2hhdGV2ZXIgcmVhc29uLCB5b3UgY291bGQgcGVy
aW9kaWNhbGx5IGNoZWNrIC9wcm9jL2J1ZGR5aW5mbyBhbmQgbWFudWFsbHkgaW52b2tlIGNvbXBh
Y3Rpb24gb24gdGhlIHN5c3RlbS4NCg0KSW4gb3RoZXIgd29yZHMsIHdoeSBkb2VzIHRoaXMgbmVl
ZCB0byBsaXZlIGluIHRoZSBrZXJuZWw/DQoNCj4gU2lnbmVkLW9mZi1ieTogY2h1a2FpcGluZyA8
Y2h1a2FpcGluZ0BiYWlkdS5jb20+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAgICAgLSBjaGFu
Z2UgdGhlIG1pbiB2YWx1ZSBvZiBjb21wYWN0aW9uX29yZGVyIHRvIDEgYmVjYXVzZSB0aGUgZnJh
Z21lbnRhdGlvbg0KPiAgICAgICBpbmRleCBvZiBvcmRlciAwIGlzIGFsd2F5cyAwDQo+ICAgICAt
IG1vdmUgdGhlIGRlZmluaXRpb24gb2YgbWF4X2J1ZGR5X3pvbmUgaW50byAjaWZkZWYgDQo+IENP
TkZJR19DT01QQUNUSU9ODQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgICAgLSBmaXggdGhlIGNv
bXBpbGUgZXJyb3IgaW4gaWE2NCBhbmQgcG93ZXJwYywgbW92ZSB0aGUgaW5pdGlhbGl6YXRpb24N
Cj4gICAgICAgb2Ygc3lzY3RsX2NvbXBhY3Rpb25fb3JkZXIgdG8ga2NvbXBhY3RkX2luaXQgYmVj
YXVzZSANCj4gICAgICAgQ09NUEFDVElPTl9IUEFHRV9PUkRFUiBpcyBhIHZhcmlhYmxlIGluIHRo
ZXNlIGFyY2hpdGVjdHVyZXMNCj4gICAgIC0gY2hhbmdlIHRoZSBoYXJkIGNvZGVkIG1heCBvcmRl
ciBudW1iZXIgZnJvbSAxMCB0byBNQVhfT1JERVIgLSAxDQo+IA0KPiAgaW5jbHVkZS9saW51eC9j
b21wYWN0aW9uLmggfCAgICAxICsNCj4gIGtlcm5lbC9zeXNjdGwuYyAgICAgICAgICAgIHwgICAx
MCArKysrKysrKysrDQo+ICBtbS9jb21wYWN0aW9uLmMgICAgICAgICAgICB8ICAgIDkgKysrKysr
LS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jb21wYWN0aW9uLmggYi9pbmNsdWRl
L2xpbnV4L2NvbXBhY3Rpb24uaCANCj4gaW5kZXggZWQ0MDcwZS4uMTUxY2NkMSAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9saW51eC9jb21wYWN0aW9uLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9j
b21wYWN0aW9uLmgNCj4gQEAgLTgzLDYgKzgzLDcgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBs
b25nIGNvbXBhY3RfZ2FwKHVuc2lnbmVkIGludCANCj4gb3JkZXIpICAjaWZkZWYgQ09ORklHX0NP
TVBBQ1RJT04gIGV4dGVybiBpbnQgc3lzY3RsX2NvbXBhY3RfbWVtb3J5OyAgDQo+IGV4dGVybiB1
bnNpZ25lZCBpbnQgc3lzY3RsX2NvbXBhY3Rpb25fcHJvYWN0aXZlbmVzczsNCj4gK2V4dGVybiB1
bnNpZ25lZCBpbnQgc3lzY3RsX2NvbXBhY3Rpb25fb3JkZXI7DQo+ICBleHRlcm4gaW50IHN5c2N0
bF9jb21wYWN0aW9uX2hhbmRsZXIoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwN
Cj4gIAkJCXZvaWQgKmJ1ZmZlciwgc2l6ZV90ICpsZW5ndGgsIGxvZmZfdCAqcHBvcyk7ICBleHRl
cm4gaW50IA0KPiBzeXNjdGxfZXh0ZnJhZ190aHJlc2hvbGQ7IGRpZmYgLS1naXQgYS9rZXJuZWwv
c3lzY3RsLmMgDQo+IGIva2VybmVsL3N5c2N0bC5jIGluZGV4IDYyZmJkMDkuLmU1MGY3ZDIgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9zeXNjdGwuYw0KPiArKysgYi9rZXJuZWwvc3lzY3RsLmMNCj4g
QEAgLTE5Niw2ICsxOTYsNyBAQCBlbnVtIHN5c2N0bF93cml0ZXNfbW9kZSB7ICAjZW5kaWYgLyog
DQo+IENPTkZJR19TQ0hFRF9ERUJVRyAqLw0KPiAgDQo+ICAjaWZkZWYgQ09ORklHX0NPTVBBQ1RJ
T04NCj4gK3N0YXRpYyBpbnQgbWF4X2J1ZGR5X3pvbmUgPSBNQVhfT1JERVIgLSAxOw0KPiAgc3Rh
dGljIGludCBtaW5fZXh0ZnJhZ190aHJlc2hvbGQ7DQo+ICBzdGF0aWMgaW50IG1heF9leHRmcmFn
X3RocmVzaG9sZCA9IDEwMDA7ICAjZW5kaWYgQEAgLTI4NzEsNiArMjg3MiwxNSANCj4gQEAgaW50
IHByb2NfZG9fc3RhdGljX2tleShzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLA0K
PiAgCQkuZXh0cmEyCQk9ICZvbmVfaHVuZHJlZCwNCj4gIAl9LA0KPiAgCXsNCj4gKwkJLnByb2Nu
YW1lICAgICAgID0gImNvbXBhY3Rpb25fb3JkZXIiLA0KPiArCQkuZGF0YSAgICAgICAgICAgPSAm
c3lzY3RsX2NvbXBhY3Rpb25fb3JkZXIsDQo+ICsJCS5tYXhsZW4gICAgICAgICA9IHNpemVvZihz
eXNjdGxfY29tcGFjdGlvbl9vcmRlciksDQo+ICsJCS5tb2RlICAgICAgICAgICA9IDA2NDQsDQo+
ICsJCS5wcm9jX2hhbmRsZXIgICA9IHByb2NfZG9pbnR2ZWNfbWlubWF4LA0KPiArCQkuZXh0cmEx
ICAgICAgICAgPSBTWVNDVExfT05FLA0KPiArCQkuZXh0cmEyICAgICAgICAgPSAmbWF4X2J1ZGR5
X3pvbmUsDQo+ICsJfSwNCj4gKwl7DQo+ICAJCS5wcm9jbmFtZQk9ICJleHRmcmFnX3RocmVzaG9s
ZCIsDQo+ICAJCS5kYXRhCQk9ICZzeXNjdGxfZXh0ZnJhZ190aHJlc2hvbGQsDQo+ICAJCS5tYXhs
ZW4JCT0gc2l6ZW9mKGludCksDQo+IGRpZmYgLS1naXQgYS9tbS9jb21wYWN0aW9uLmMgYi9tbS9j
b21wYWN0aW9uLmMgaW5kZXggZTA0ZjQ0Ny4uNzBjMGFjZCANCj4gMTAwNjQ0DQo+IC0tLSBhL21t
L2NvbXBhY3Rpb24uYw0KPiArKysgYi9tbS9jb21wYWN0aW9uLmMNCj4gQEAgLTE5MjUsMTYgKzE5
MjUsMTYgQEAgc3RhdGljIGJvb2wga3N3YXBkX2lzX3J1bm5pbmcocGdfZGF0YV90IA0KPiAqcGdk
YXQpDQo+ICANCj4gIC8qDQo+ICAgKiBBIHpvbmUncyBmcmFnbWVudGF0aW9uIHNjb3JlIGlzIHRo
ZSBleHRlcm5hbCBmcmFnbWVudGF0aW9uIHdydCB0byANCj4gdGhlDQo+IC0gKiBDT01QQUNUSU9O
X0hQQUdFX09SREVSLiBJdCByZXR1cm5zIGEgdmFsdWUgaW4gdGhlIHJhbmdlIFswLCAxMDBdLg0K
PiArICogc3lzY3RsX2NvbXBhY3Rpb25fb3JkZXIuIEl0IHJldHVybnMgYSB2YWx1ZSBpbiB0aGUg
cmFuZ2UgWzAsIDEwMF0uDQo+ICAgKi8NCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgZnJhZ21lbnRh
dGlvbl9zY29yZV96b25lKHN0cnVjdCB6b25lICp6b25lKSAgew0KPiAtCXJldHVybiBleHRmcmFn
X2Zvcl9vcmRlcih6b25lLCBDT01QQUNUSU9OX0hQQUdFX09SREVSKTsNCj4gKwlyZXR1cm4gZXh0
ZnJhZ19mb3Jfb3JkZXIoem9uZSwgc3lzY3RsX2NvbXBhY3Rpb25fb3JkZXIpOw0KPiAgfQ0KPiAg
DQo+ICAvKg0KPiAgICogQSB3ZWlnaHRlZCB6b25lJ3MgZnJhZ21lbnRhdGlvbiBzY29yZSBpcyB0
aGUgZXh0ZXJuYWwgDQo+IGZyYWdtZW50YXRpb24NCj4gLSAqIHdydCB0byB0aGUgQ09NUEFDVElP
Tl9IUEFHRV9PUkRFUiBzY2FsZWQgYnkgdGhlIHpvbmUncyBzaXplLiBJdA0KPiArICogd3J0IHRv
IHRoZSBzeXNjdGxfY29tcGFjdGlvbl9vcmRlciBzY2FsZWQgYnkgdGhlIHpvbmUncyBzaXplLiBJ
dA0KPiAgICogcmV0dXJucyBhIHZhbHVlIGluIHRoZSByYW5nZSBbMCwgMTAwXS4NCj4gICAqDQo+
ICAgKiBUaGUgc2NhbGluZyBmYWN0b3IgZW5zdXJlcyB0aGF0IHByb2FjdGl2ZSBjb21wYWN0aW9u
IGZvY3VzZXMgb24gDQo+IGxhcmdlciBAQCAtMjY2Niw2ICsyNjY2LDcgQEAgc3RhdGljIHZvaWQg
Y29tcGFjdF9ub2Rlcyh2b2lkKQ0KPiAgICogYmFja2dyb3VuZC4gSXQgdGFrZXMgdmFsdWVzIGlu
IHRoZSByYW5nZSBbMCwgMTAwXS4NCj4gICAqLw0KPiAgdW5zaWduZWQgaW50IF9fcmVhZF9tb3N0
bHkgc3lzY3RsX2NvbXBhY3Rpb25fcHJvYWN0aXZlbmVzcyA9IDIwOw0KPiArdW5zaWduZWQgaW50
IF9fcmVhZF9tb3N0bHkgc3lzY3RsX2NvbXBhY3Rpb25fb3JkZXI7DQo+ICANCj4gIC8qDQo+ICAg
KiBUaGlzIGlzIHRoZSBlbnRyeSBwb2ludCBmb3IgY29tcGFjdGluZyBhbGwgbm9kZXMgdmlhIEBA
IC0yOTU4LDYgDQo+ICsyOTU5LDggQEAgc3RhdGljIGludCBfX2luaXQga2NvbXBhY3RkX2luaXQo
dm9pZCkNCj4gIAlpbnQgbmlkOw0KPiAgCWludCByZXQ7DQo+ICANCj4gKwlzeXNjdGxfY29tcGFj
dGlvbl9vcmRlciA9IENPTVBBQ1RJT05fSFBBR0VfT1JERVI7DQo+ICsNCj4gIAlyZXQgPSBjcHVo
cF9zZXR1cF9zdGF0ZV9ub2NhbGxzKENQVUhQX0FQX09OTElORV9EWU4sDQo+ICAJCQkJCSJtbS9j
b21wYWN0aW9uOm9ubGluZSIsDQo+ICAJCQkJCWtjb21wYWN0ZF9jcHVfb25saW5lLCBOVUxMKTsN
Cj4gLS0NCj4gMS43LjENCj4gDQo+IA0K
