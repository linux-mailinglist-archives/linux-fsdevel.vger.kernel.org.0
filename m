Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DFC374CB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhEFBJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 21:09:21 -0400
Received: from mx21.baidu.com ([220.181.3.85]:40406 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229768AbhEFBJT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 21:09:19 -0400
Received: from BC-Mail-Ex17.internal.baidu.com (unknown [172.31.51.11])
        by Forcepoint Email with ESMTPS id 702F2C581018852B74DE;
        Thu,  6 May 2021 09:08:14 +0800 (CST)
Received: from BC-Mail-Ex20.internal.baidu.com (172.31.51.14) by
 BC-Mail-Ex17.internal.baidu.com (172.31.51.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Thu, 6 May 2021 09:08:14 +0800
Received: from BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) by
 BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) with mapi id 15.01.2242.008;
 Thu, 6 May 2021 09:08:13 +0800
From:   "Chu,Kaiping" <chukaiping@baidu.com>
To:     Rafael Aquini <aquini@redhat.com>
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
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2M10gbW0vY29tcGFjdGlvbjpsZXQg?=
 =?utf-8?Q?proactive_compaction_order_configurable?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjNdIG1tL2NvbXBhY3Rpb246bGV0IHByb2FjdGl2?=
 =?utf-8?Q?e_compaction_order_configurable?=
Thread-Index: AQHXOjvUEYLrBaldBU+yjbigXZxebarJI3/QgAJCYICACk14IA==
Date:   Thu, 6 May 2021 01:08:13 +0000
Message-ID: <3040239c32144c5caf44e0c96afa4c49@baidu.com>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
 <YIYX22JLVHN1PhGs@t490s.aquini.net>
 <f355248969f14e5897ad6dcfe3834297@baidu.com> <YIsM4UtV9UqKhsNB@optiplex-fbsd>
In-Reply-To: <YIsM4UtV9UqKhsNB@optiplex-fbsd>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.194.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUmFmYWVsIEFxdWluaSA8YXF1
aW5pQHJlZGhhdC5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDIx5bm0NOaciDMw5pelIDM6NDYNCuaU
tuS7tuS6ujogQ2h1LEthaXBpbmcgPGNodWthaXBpbmdAYmFpZHUuY29tPg0K5oqE6YCBOiBtY2dy
b2ZAa2VybmVsLm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyB5emFpa2luQGdvb2dsZS5jb207
IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IHZiYWJrYUBzdXNlLmN6OyBuaWd1cHRhQG52aWRp
YS5jb207IGJoZUByZWRoYXQuY29tOyBraGFsaWQuYXppekBvcmFjbGUuY29tOyBpYW1qb29uc29v
LmtpbUBsZ2UuY29tOyBtYXRldXN6bm9zZWswQGdtYWlsLmNvbTsgc2hfZGVmQDE2My5jb207IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1tbUBrdmFjay5vcmcNCuS4u+mimDogUmU6IOetlOWkjTogW1BBVENIIHYzXSBtbS9j
b21wYWN0aW9uOmxldCBwcm9hY3RpdmUgY29tcGFjdGlvbiBvcmRlciBjb25maWd1cmFibGUNCg0K
T24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMDE6MTc6NDBBTSArMDAwMCwgQ2h1LEthaXBpbmcgd3Jv
dGU6DQo+IFBsZWFzZSBzZWUgbXkgYW5zd2VyIGlubGluZS4NCj4gDQo+IC0tLS0t6YKu5Lu25Y6f
5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBSYWZhZWwgQXF1aW5pIDxhcXVpbmlAcmVkaGF0LmNvbT4N
Cj4g5Y+R6YCB5pe26Ze0OiAyMDIx5bm0NOaciDI25pelIDk6MzENCj4g5pS25Lu25Lq6OiBDaHUs
S2FpcGluZyA8Y2h1a2FpcGluZ0BiYWlkdS5jb20+DQo+IOaKhOmAgTogbWNncm9mQGtlcm5lbC5v
cmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgeXphaWtpbkBnb29nbGUuY29tOyANCj4gYWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZzsgdmJhYmthQHN1c2UuY3o7IG5pZ3VwdGFAbnZpZGlhLmNvbTsg
DQo+IGJoZUByZWRoYXQuY29tOyBraGFsaWQuYXppekBvcmFjbGUuY29tOyBpYW1qb29uc29vLmtp
bUBsZ2UuY29tOyANCj4gbWF0ZXVzem5vc2VrMEBnbWFpbC5jb207IHNoX2RlZkAxNjMuY29tOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjNdIG1tL2Nv
bXBhY3Rpb246bGV0IHByb2FjdGl2ZSBjb21wYWN0aW9uIG9yZGVyIA0KPiBjb25maWd1cmFibGUN
Cj4gDQo+IE9uIFN1biwgQXByIDI1LCAyMDIxIGF0IDA5OjIxOjAyQU0gKzA4MDAsIGNodWthaXBp
bmcgd3JvdGU6DQo+ID4gQ3VycmVudGx5IHRoZSBwcm9hY3RpdmUgY29tcGFjdGlvbiBvcmRlciBp
cyBmaXhlZCB0byANCj4gPiBDT01QQUNUSU9OX0hQQUdFX09SREVSKDkpLCBpdCdzIE9LIGluIG1v
c3QgbWFjaGluZXMgd2l0aCBsb3RzIG9mIA0KPiA+IG5vcm1hbCA0S0IgbWVtb3J5LCBidXQgaXQn
cyB0b28gaGlnaCBmb3IgdGhlIG1hY2hpbmVzIHdpdGggc21hbGwgDQo+ID4gbm9ybWFsIG1lbW9y
eSwgZm9yIGV4YW1wbGUgdGhlIG1hY2hpbmVzIHdpdGggbW9zdCBtZW1vcnkgY29uZmlndXJlZCAN
Cj4gPiBhcyAxR0IgaHVnZXRsYmZzIGh1Z2UgcGFnZXMuIEluIHRoZXNlIG1hY2hpbmVzIHRoZSBt
YXggb3JkZXIgb2YgZnJlZSANCj4gPiBwYWdlcyBpcyBvZnRlbiBiZWxvdyA5LCBhbmQgaXQncyBh
bHdheXMgYmVsb3cgOSBldmVuIHdpdGggaGFyZCANCj4gPiBjb21wYWN0aW9uLiBUaGlzIHdpbGwg
bGVhZCB0byBwcm9hY3RpdmUgY29tcGFjdGlvbiBiZSB0cmlnZ2VyZWQgdmVyeSANCj4gPiBmcmVx
dWVudGx5LiBJbiB0aGVzZSBtYWNoaW5lcyB3ZSBvbmx5IGNhcmUgYWJvdXQgb3JkZXIgb2YgMyBv
ciA0Lg0KPiA+IFRoaXMgcGF0Y2ggZXhwb3J0IHRoZSBvZGVyIHRvIHByb2MgYW5kIGxldCBpdCBj
b25maWd1cmFibGUgYnkgdXNlciwgDQo+ID4gYW5kIHRoZSBkZWZhdWx0IHZhbHVlIGlzIHN0aWxs
IENPTVBBQ1RJT05fSFBBR0VfT1JERVIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogY2h1a2Fp
cGluZyA8Y2h1a2FpcGluZ0BiYWlkdS5jb20+DQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gVHdvIG1pbm9yIG5pdHMgb24gdGhlIGNvbW1p
dCBsb2cgbWVzc2FnZTogDQo+ICogdGhlcmUgc2VlbXMgdG8gYmUgYSB3aGl0ZXNwYWdlIG1pc3Np
bmcgaW4geW91ciBzaG9ydCBsb2c6IA0KPiAgICIuLi4gbW0vY29tcGFjdGlvbjpsZXQgLi4uIg0K
PiAtLT4gSSB3aWxsIGZpeCBpdCBpbiBuZXh0IHBhdGNoLg0KPiANCj4gKiBoYXMgdGhlIHBhdGgg
cmVhbGx5IGJlZW4gcmVwb3J0ZWQgYnkgYSB0ZXN0IHJvYm90Pw0KPiAtLT4gWWVzLiBUaGVyZSBp
cyBhIGNvbXBpbGUgZXJyb3IgaW4gdjEsIEkgZml4ZWQgaXQgaW4gdjIuDQo+DQoNCj4gU28sIG5v
Li4uIHRoZSB0ZXN0IHJvYm90IHNob3VsZCBub3QgYmUgbGlzdGVkIGFzIFJlcG9ydGVkLWJ5LiAN
CkkgZGlkIGl0IGFzIGJlbG93IHN1Z2dlc3Rpb24gaW4gdGhlIGJ1aWxkIGVycm9yIG5vdGlmaWNh
dGlvbiBlbWFpbCBzZW50IGJ5IGtlcm5lbCB0ZXN0IHJvYm90Lg0KIiBJZiB5b3UgZml4IHRoZSBp
c3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQpSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Ig0KDQo=
