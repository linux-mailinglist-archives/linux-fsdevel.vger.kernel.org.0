Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7437A123
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEKHtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 03:49:31 -0400
Received: from mx21.baidu.com ([220.181.3.85]:38108 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229892AbhEKHtb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 03:49:31 -0400
Received: from BJHW-Mail-Ex10.internal.baidu.com (unknown [10.127.64.33])
        by Forcepoint Email with ESMTPS id 1BB22810BB5693CB83C4;
        Tue, 11 May 2021 15:48:08 +0800 (CST)
Received: from BJHW-MAIL-EX20.internal.baidu.com (10.127.64.22) by
 BJHW-Mail-Ex10.internal.baidu.com (10.127.64.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Tue, 11 May 2021 15:48:07 +0800
Received: from BC-Mail-Ex20.internal.baidu.com (172.31.51.14) by
 BJHW-MAIL-EX20.internal.baidu.com (10.127.64.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Tue, 11 May 2021 15:48:07 +0800
Received: from BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) by
 BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) with mapi id 15.01.2242.008;
 Tue, 11 May 2021 15:48:07 +0800
From:   "Chu,Kaiping" <chukaiping@baidu.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        David Rientjes <rientjes@google.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjNdIG1tL2NvbXBhY3Rpb246bGV0IHByb2FjdGl2?=
 =?utf-8?Q?e_compaction_order_configurable?=
Thread-Topic: [PATCH v3] mm/compaction:let proactive compaction order
 configurable
Thread-Index: AQHXOjmoEYLrBaldBU+yjbigXZxebarWgqKAgAd6AiA=
Date:   Tue, 11 May 2021 07:48:07 +0000
Message-ID: <d15e063bc7b84155b7da5c2929010e7c@baidu.com>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
 <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
 <2f21dec9-065f-e234-f531-c6643965c0cb@oracle.com>
In-Reply-To: <2f21dec9-065f-e234-f531-c6643965c0cb@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.194.39]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex10_2021-05-11 15:48:08:080
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtoYWxpZCBBeml6IDxr
aGFsaWQuYXppekBvcmFjbGUuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjHlubQ15pyIN+aXpSA1
OjI3DQo+IOaUtuS7tuS6ujogRGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+OyBD
aHUsS2FpcGluZw0KPiA8Y2h1a2FpcGluZ0BiYWlkdS5jb20+DQo+IOaKhOmAgTogbWNncm9mQGtl
cm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgeXphaWtpbkBnb29nbGUuY29tOw0KPiBh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyB2YmFia2FAc3VzZS5jejsgbmlndXB0YUBudmlkaWEu
Y29tOw0KPiBiaGVAcmVkaGF0LmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsgbWF0ZXVzem5v
c2VrMEBnbWFpbC5jb207DQo+IHNoX2RlZkAxNjMuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtbW1Aa3ZhY2su
b3JnDQo+IOS4u+mimDogUmU6IFtQQVRDSCB2M10gbW0vY29tcGFjdGlvbjpsZXQgcHJvYWN0aXZl
IGNvbXBhY3Rpb24gb3JkZXINCj4gY29uZmlndXJhYmxlDQo+IA0KPiBPbiA0LzI1LzIxIDk6MTUg
UE0sIERhdmlkIFJpZW50amVzIHdyb3RlOg0KPiA+IE9uIFN1biwgMjUgQXByIDIwMjEsIGNodWth
aXBpbmcgd3JvdGU6DQo+ID4NCj4gPj4gQ3VycmVudGx5IHRoZSBwcm9hY3RpdmUgY29tcGFjdGlv
biBvcmRlciBpcyBmaXhlZCB0bw0KPiA+PiBDT01QQUNUSU9OX0hQQUdFX09SREVSKDkpLCBpdCdz
IE9LIGluIG1vc3QgbWFjaGluZXMgd2l0aCBsb3RzIG9mDQo+ID4+IG5vcm1hbCA0S0IgbWVtb3J5
LCBidXQgaXQncyB0b28gaGlnaCBmb3IgdGhlIG1hY2hpbmVzIHdpdGggc21hbGwNCj4gPj4gbm9y
bWFsIG1lbW9yeSwgZm9yIGV4YW1wbGUgdGhlIG1hY2hpbmVzIHdpdGggbW9zdCBtZW1vcnkgY29u
ZmlndXJlZA0KPiA+PiBhcyAxR0IgaHVnZXRsYmZzIGh1Z2UgcGFnZXMuIEluIHRoZXNlIG1hY2hp
bmVzIHRoZSBtYXggb3JkZXIgb2YgZnJlZQ0KPiA+PiBwYWdlcyBpcyBvZnRlbiBiZWxvdyA5LCBh
bmQgaXQncyBhbHdheXMgYmVsb3cgOSBldmVuIHdpdGggaGFyZA0KPiA+PiBjb21wYWN0aW9uLiBU
aGlzIHdpbGwgbGVhZCB0byBwcm9hY3RpdmUgY29tcGFjdGlvbiBiZSB0cmlnZ2VyZWQgdmVyeQ0K
PiA+PiBmcmVxdWVudGx5LiBJbiB0aGVzZSBtYWNoaW5lcyB3ZSBvbmx5IGNhcmUgYWJvdXQgb3Jk
ZXIgb2YgMyBvciA0Lg0KPiA+PiBUaGlzIHBhdGNoIGV4cG9ydCB0aGUgb2RlciB0byBwcm9jIGFu
ZCBsZXQgaXQgY29uZmlndXJhYmxlIGJ5IHVzZXIsDQo+ID4+IGFuZCB0aGUgZGVmYXVsdCB2YWx1
ZSBpcyBzdGlsbCBDT01QQUNUSU9OX0hQQUdFX09SREVSLg0KPiA+Pg0KPiA+DQo+ID4gQXMgYXNr
ZWQgaW4gdGhlIHJldmlldyBvZiB0aGUgdjEgb2YgdGhlIHBhdGNoLCB3aHkgaXMgdGhpcyBub3Qg
YQ0KPiA+IHVzZXJzcGFjZSBwb2xpY3kgZGVjaXNpb24/ICBJZiB5b3UgYXJlIGludGVyZXN0ZWQg
aW4gb3JkZXItMyBvcg0KPiA+IG9yZGVyLTQgZnJhZ21lbnRhdGlvbiwgZm9yIHdoYXRldmVyIHJl
YXNvbiwgeW91IGNvdWxkIHBlcmlvZGljYWxseQ0KPiA+IGNoZWNrIC9wcm9jL2J1ZGR5aW5mbyBh
bmQgbWFudWFsbHkgaW52b2tlIGNvbXBhY3Rpb24gb24gdGhlIHN5c3RlbS4NCj4gPg0KPiA+IElu
IG90aGVyIHdvcmRzLCB3aHkgZG9lcyB0aGlzIG5lZWQgdG8gbGl2ZSBpbiB0aGUga2VybmVsPw0K
PiA+DQo+IA0KPiBJIGhhdmUgc3RydWdnbGVkIHdpdGggdGhpcyBxdWVzdGlvbi4gRnJhZ21lbnRh
dGlvbiBhbmQgYWxsb2NhdGlvbiBzdGFsbHMgYXJlDQo+IHNpZ25pZmljYW50IGlzc3VlcyBvbiBs
YXJnZSBkYXRhYmFzZSBzeXN0ZW1zIHdoaWNoIGFsc28gaGFwcGVuIHRvIHVzZSBtZW1vcnkNCj4g
aW4gc2ltaWxhciB3YXlzICg5MCslIG9mIG1lbW9yeSBpcyBhbGxvY2F0ZWQgYXMgaHVnZXBhZ2Vz
KSBsZWF2aW5nIGp1c3QNCj4gZW5vdWdoIG1lbW9yeSB0byBydW4gcmVzdCBvZiB0aGUgdXNlcnNw
YWNlIHByb2Nlc3Nlcy4gSSBoYWQgb3JpZ2luYWxseQ0KPiBwcm9wb3NlZCBhIGtlcm5lbCBwYXRj
aCB0byBtb25pdG9yLCBkbyBhIHRyZW5kIGFuYWx5c2lzIG9mIG1lbW9yeSB1c2FnZSBhbmQNCj4g
dGFrZSBwcm9hY3RpdmUgYWN0aW9uIC0NCj4gPGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAxOTA4MTMwMTQwMTIuMzAyMzItMS1raGFsaWQuYXppekBvcmFjbGUuYw0KPiBvbS8+LiBCYXNl
ZCB1cG9uIGZlZWRiYWNrLCBJIG1vdmVkIHRoZSBpbXBsZW1lbnRhdGlvbiB0byB1c2Vyc3BhY2Ug
LQ0KPiA8aHR0cHM6Ly9naXRodWIuY29tL29yYWNsZS9tZW1vcHRpbWl6ZXI+LiBUZXN0IHJlc3Vs
dHMgYWNyb3NzIG11bHRpcGxlDQo+IHdvcmtsb2FkcyBoYXZlIGJlZW4gdmVyeSBnb29kLiBSZXN1
bHRzIGZyb20gb25lIG9mIHRoZSB3b3JrbG9hZHMgYXJlIGluIHRoaXMNCj4gYmxvZyAtIDxodHRw
czovL2Jsb2dzLm9yYWNsZS5jb20vbGludXgvYW50aWNpcGF0aW5nLXlvdXItbWVtb3J5LW5lZWRz
Pi4gSXQNCj4gd29ya3Mgd2VsbCBmcm9tIHVzZXJzcGFjZSBidXQgaXQgaGFzIGxpbWl0ZWQgd2F5
cyB0byBpbmZsdWVuY2UgcmVjbGFtYXRpb24gYW5kDQo+IGNvbXBhY3Rpb24uIEl0IHVzZXMgd2F0
ZXJtYXJrX3NjYWxlX2ZhY3RvciB0byBib29zdCB3YXRlcm1hcmtzIGFuZCBjYXVzZQ0KPiByZWNs
YW1hdGlvbiB0byBraWNrIGluIGVhcmxpZXIgYW5kIHJ1biBsb25nZXIuIEl0IHVzZXMNCj4gL3N5
cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUlZC9jb21wYWN0IHRvIGZvcmNlIGNvbXBhY3Rpb24g
b24gdGhlIG5vZGUNCj4gZXhwZWN0ZWQgdG8gcmVhY2ggaGlnaCBsZXZlbCBvZiBmcmFnbWVudGF0
aW9uIHNvb24uIE5laXRoZXIgb2YgdGhlc2UgaXMgdmVyeQ0KPiBlZmZpY2llbnQgZnJvbSB1c2Vy
c3BhY2UgZXZlbiB0aG91Z2ggdGhleSBnZXQgdGhlIGpvYiBkb25lLiBTY2FsaW5nIHdhdGVybWFy
aw0KPiBoYXMgbG9uZ2VyIGxhc3RpbmcgaW1wYWN0IHRoYW4gcmFpc2luZyBzY2FubmluZyBwcmlv
cml0eSBpbiBiYWxhbmNlX3BnZGF0KCkNCj4gdGVtcG9yYXJpbHkuIEkgcGxhbiB0byBleHBlcmlt
ZW50IHdpdGggd2F0ZXJtYXJrX2Jvb3N0X2ZhY3RvciB0byBzZWUgaWYgSSBjYW4NCj4gdXNlIGl0
IGluIHBsYWNlIG9mIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlJWQvY29tcGFjdCBhbmQg
Z2V0IHRoZQ0KPiBzYW1lIHJlc3VsdHMuIERvaW5nIGFsbCBvZiB0aGlzIGluIHRoZSBrZXJuZWwg
Y2FuIGJlIG1vcmUgZWZmaWNpZW50IGFuZCBsZXNzZW4NCj4gcG90ZW50aWFsIG5lZ2F0aXZlIGlt
cGFjdCBvbiB0aGUgc3lzdGVtLiBPbiB0aGUgb3RoZXIgaGFuZCwgaXQgaXMgZWFzaWVyIHRvIGZp
eA0KPiBhbmQgdXBkYXRlIHN1Y2ggcG9saWNpZXMgaW4gdXNlcnNwYWNlIGFsdGhvdWdoIGF0IHRo
ZSBjb3N0IG9mIGhhdmluZyBhDQo+IHBlcmZvcm1hbmNlIGNyaXRpY2FsIGNvbXBvbmVudCBsaXZl
IG91dHNpZGUgdGhlIGtlcm5lbCBhbmQgdGh1cyBub3QgYmUgYWN0aXZlDQo+IG9uIHRoZSBzeXN0
ZW0gYnkgZGVmYXVsdC4NCj4NCkkgc3R1ZGllZCB5b3VyIG1lbW9wdGltaXplciB0aGVzZSBkYXlz
LCBJIGFsc28gYWdyZWUgdG8gbW92ZSB0aGUgaW1wbGVtZW50YXRpb24gaW50byBrZXJuZWwgdG8g
Y28td29yayB3aXRoIGN1cnJlbnQgcHJvYWN0aXZlIGNvbXBhY3Rpb24gbWVjaGFuaXNtIHRvIGdl
dCBoaWdoZXIgZWZmaWNpZW5jeS4NCkJ5IHRoZSB3YXkgSSBhbSBpbnRlcmVzdGVkIGFib3V0IHRo
ZSBtZW1vcHRpbWl6ZXIsIEkgd2FudCB0byBoYXZlIGEgdGVzdCBvZiBpdCwgYnV0IGhvdyB0byBl
dmFsdWF0ZSBpdHMgZWZmZWN0aXZlbmVzcz8NCg0KDQo=
