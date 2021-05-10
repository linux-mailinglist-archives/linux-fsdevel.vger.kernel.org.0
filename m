Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48C377A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEJCLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 22:11:55 -0400
Received: from mx21.baidu.com ([220.181.3.85]:44568 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230038AbhEJCLy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 22:11:54 -0400
Received: from BC-Mail-Ex17.internal.baidu.com (unknown [172.31.51.11])
        by Forcepoint Email with ESMTPS id 1744F628EFBC60E9B34A;
        Mon, 10 May 2021 10:10:47 +0800 (CST)
Received: from BC-Mail-Ex20.internal.baidu.com (172.31.51.14) by
 BC-Mail-Ex17.internal.baidu.com (172.31.51.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Mon, 10 May 2021 10:10:46 +0800
Received: from BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) by
 BC-Mail-Ex20.internal.baidu.com ([172.31.51.14]) with mapi id 15.01.2242.008;
 Mon, 10 May 2021 10:10:46 +0800
From:   "Chu,Kaiping" <chukaiping@baidu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY0XSBtbS9jb21wYWN0aW9uOiBsZXQgcHJvYWN0aXZl?=
 =?gb2312?Q?_compaction_order_configurable?=
Thread-Topic: [PATCH v4] mm/compaction: let proactive compaction order
 configurable
Thread-Index: AQHXRTHruGTRst2hN0Oxvb824V5mK6rb8xeQ
Date:   Mon, 10 May 2021 02:10:46 +0000
Message-ID: <da67b078c3bb4d67852a34794f7b5646@baidu.com>
References: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
 <20210509171748.8dbc70ceccc5cc1ae61fe41c@linux-foundation.org>
In-Reply-To: <20210509171748.8dbc70ceccc5cc1ae61fe41c@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.194.39]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnPiANCreiy83KsbzkOiAyMDIxxOo11MIxMMjVIDg6MTgNCsrVvP7Iyzog
Q2h1LEthaXBpbmcgPGNodWthaXBpbmdAYmFpZHUuY29tPg0Ks63LzTogbWNncm9mQGtlcm5lbC5v
cmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgeXphaWtpbkBnb29nbGUuY29tOyB2YmFia2FAc3Vz
ZS5jejsgbmlndXB0YUBudmlkaWEuY29tOyBiaGVAcmVkaGF0LmNvbTsga2hhbGlkLmF6aXpAb3Jh
Y2xlLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsgbWF0ZXVzem5vc2VrMEBnbWFpbC5jb207
IHNoX2RlZkAxNjMuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1mc2Rl
dmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBNZWwgR29ybWFuIDxtZ29y
bWFuQHRlY2hzaW5ndWxhcml0eS5uZXQ+OyBEYXZpZCBSaWVudGplcyA8cmllbnRqZXNAZ29vZ2xl
LmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0ggdjRdIG1tL2NvbXBhY3Rpb246IGxldCBwcm9hY3RpdmUg
Y29tcGFjdGlvbiBvcmRlciBjb25maWd1cmFibGUNCg0KT24gV2VkLCAyOCBBcHIgMjAyMSAxMDoy
ODoyMSArMDgwMCBjaHVrYWlwaW5nIDxjaHVrYWlwaW5nQGJhaWR1LmNvbT4gd3JvdGU6DQoNCj4g
PiBDdXJyZW50bHkgdGhlIHByb2FjdGl2ZSBjb21wYWN0aW9uIG9yZGVyIGlzIGZpeGVkIHRvIA0K
PiA+IENPTVBBQ1RJT05fSFBBR0VfT1JERVIoOSksIGl0J3MgT0sgaW4gbW9zdCBtYWNoaW5lcyB3
aXRoIGxvdHMgb2YgDQo+ID4gbm9ybWFsIDRLQiBtZW1vcnksIGJ1dCBpdCdzIHRvbyBoaWdoIGZv
ciB0aGUgbWFjaGluZXMgd2l0aCBzbWFsbCANCj4gPiBub3JtYWwgbWVtb3J5LCBmb3IgZXhhbXBs
ZSB0aGUgbWFjaGluZXMgd2l0aCBtb3N0IG1lbW9yeSBjb25maWd1cmVkIGFzIA0KPiA+IDFHQiBo
dWdldGxiZnMgaHVnZSBwYWdlcy4gSW4gdGhlc2UgbWFjaGluZXMgdGhlIG1heCBvcmRlciBvZiBm
cmVlIA0KPiA+IHBhZ2VzIGlzIG9mdGVuIGJlbG93IDksIGFuZCBpdCdzIGFsd2F5cyBiZWxvdyA5
IGV2ZW4gd2l0aCBoYXJkIA0KPiA+IGNvbXBhY3Rpb24uIFRoaXMgd2lsbCBsZWFkIHRvIHByb2Fj
dGl2ZSBjb21wYWN0aW9uIGJlIHRyaWdnZXJlZCB2ZXJ5IA0KPiA+IGZyZXF1ZW50bHkuIEluIHRo
ZXNlIG1hY2hpbmVzIHdlIG9ubHkgY2FyZSBhYm91dCBvcmRlciBvZiAzIG9yIDQuDQo+ID4gVGhp
cyBwYXRjaCBleHBvcnQgdGhlIG9kZXIgdG8gcHJvYyBhbmQgbGV0IGl0IGNvbmZpZ3VyYWJsZSBi
eSB1c2VyLCANCj4gPiBhbmQgdGhlIGRlZmF1bHQgdmFsdWUgaXMgc3RpbGwgQ09NUEFDVElPTl9I
UEFHRV9PUkRFUi4NCg0KPiBJdCB3b3VsZCBiZSBncmVhdCB0byBkbyB0aGlzIGF1dG9tYXRpY2Fs
bHk/ICBJdCdzIHF1aXRlIHNpbXBsZSB0byBzZWUgd2hlbiBtZW1vcnkgaXMgYmVpbmcgaGFuZGVk
IG91dCB0byBodWdldGxiZnMgLSBzbyBjYW4gd2UgdHVuZSBwcm9hY3RpdmVfY29tcGFjdGlvbl9v
cmRlciBpbiByZXNwb25zZSB0byB0aGlzPyAgVGhhdCB3b3VsZCBiZSBmYXIgYmV0dGVyIHRoYW4g
YWRkaW5nIGEgbWFudWFsIHR1bmFibGUuDQoNCj4gQnV0IGZyb20gaGF2aW5nIHJlYWQgS2hhbGlk
J3MgY29tbWVudHMsIHRoYXQgZG9lcyBzb3VuZCBxdWl0ZSBpbnZvbHZlZC4NCj4gSXMgdGhlcmUg
c29tZSBwYXJ0aWFsIHNvbHV0aW9uIHRoYXQgd2UgY2FuIGNvbWUgdXAgd2l0aCB0aGF0IHdpbGwg
Z2V0IG1vc3QgcGVvcGxlIG91dCBvZiB0cm91YmxlPw0KDQo+IFRoYXQgYmVpbmcgc2FpZCwgdGhp
cyBwYXRjaCBpcyBzdXBlci1zdXBlci1zaW1wbGUgc28gcGVyaGFwcyB3ZSBzaG91bGQganVzdCBt
ZXJnZSBpdCBqdXN0IHRvIGdldCBvbmUgcGVyc29uIChhbmQgaG9wZWZ1bGx5IGEgZmV3IG1vcmUp
IG91dCBvZiB0cm91YmxlLiAgQnV0IG9uIHRoZSBvdGhlciBoYW5kLCBvbmNlIHdlIGFkZCBhIC9w
cm9jIHR1bmFibGUgd2UgbXVzdCBtYWludGFpbiB0aGF0IHR1bmFibGUgZm9yIGV2ZXIgKG9yIGF0
IGxlYXN0IGEgdmVyeSBsb25nIHRpbWUpIGV2ZW4gaWYgdGhlIGludGVybmFsIGltcGxlbWVudGF0
aW9ucyBjaGFuZ2UgYSBsb3QuDQoNCkN1cnJlbnRseSB0aGUgZnJhZ21lbnQgaW5kZXggb2YgZWFj
aCB6b25lIGlzIHBlciBvcmRlciwgdGhlcmUgaXMgbm8gc2luZ2xlIGZyYWdtZW50IGluZGV4IGZv
ciB0aGUgd2hvbGUgc3lzdGVtLCBzbyB3ZSBjYW4gb25seSB1c2UgYSB1c2VyIGRlZmluZWQgb3Jk
ZXIgZm9yIHByb2FjdGl2ZSBjb21wYWN0aW9uLiBJIGFtIGtlZXAgdGhpbmtpbmcgb2YgdGhlIHdh
eSB0byBjYWxjdWxhdGluZyB0aGUgYXZlcmFnZSBmcmFnbWVudCBpbmRleCBvZiB0aGUgc3lzdGVt
LCBidXQgdGlsbCBub3cgSSBkb2Vzbid0IHRoaW5rIG91dCBpdC4gSSB0aGluayB0aGF0IHdlIGNh
biBqdXN0IHVzZSB0aGUgcHJvYyBmaWxlIHRvIGNvbmZpZ3VyZSB0aGUgb3JkZXIgbWFudWFsbHks
IGlmIHdlIHRoaW5rIG91dCBiZXR0ZXIgc29sdXRpb24gaW4gZnV0dXJlLCB3ZSBjYW4ga2VlcCB0
aGUgcHJvYyBmaWxlIGJ1dCByZW1vdmUgdGhlIGltcGxlbWVudGF0aW9uIGludGVybmFsbHkuDQo=
