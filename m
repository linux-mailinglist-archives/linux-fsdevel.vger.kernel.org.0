Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7B7064D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEQKCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEQKBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 06:01:54 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B57BE30C8;
        Wed, 17 May 2023 03:01:51 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.18])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 36B38B025264C;
        Wed, 17 May 2023 18:01:49 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY02-ACTMBX-06.didichuxing.com (10.79.65.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 18:01:48 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Wed, 17 May 2023 18:01:48 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.65.18
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "pilgrimtao@gmail.com" <pilgrimtao@gmail.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 0/2] memcontrol: support cgroup level OOM protection
Thread-Topic: [PATCH v4 0/2] memcontrol: support cgroup level OOM protection
Thread-Index: AQHZiG6QYuA8nkfOmkSWHm0JCEvXOa9dgyoAgACXf4D//3xFAIAApWQA
Date:   Wed, 17 May 2023 10:01:48 +0000
Message-ID: <6AB7FF12-F855-4D5B-9F75-9F7D64823144@didiglobal.com>
In-Reply-To: <CAJD7tkbHKQBoz7kn6ZjMTMoxLKYs7x9w4uRGWLvuyOogmBkZ_g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <370AA8CD74597143B46B0A36D41DF0C7@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMy0wNS0xNyAxNjowOTo1MCwgIllvc3J5IEFobWVkIiA8eW9zcnlhaG1lZEBnb29nbGUu
Y29tPiB3cm90ZToNCj5PbiBXZWQsIE1heSAxNywgMjAyMyBhdCAxOjAx4oCvQU0g56iL5Z6y5rab
IENoZW5na2FpdGFvIENoZW5nDQo+PGNoZW5na2FpdGFvQGRpZGlnbG9iYWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBBdCAyMDIzLTA1LTE3IDE0OjU5OjA2LCAiWW9zcnkgQWhtZWQiIDx5b3NyeWFobWVk
QGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gPitEYXZpZCBSaWVudGplcw0KPj4gPg0KPj4gPk9uIFR1
ZSwgTWF5IDE2LCAyMDIzIGF0IDg6MjDigK9QTSBjaGVuZ2thaXRhbyA8Y2hlbmdrYWl0YW9AZGlk
aWdsb2JhbC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+IEVzdGFibGlzaCBhIG5ldyBPT00gc2Nv
cmUgYWxnb3JpdGhtLCBzdXBwb3J0cyB0aGUgY2dyb3VwIGxldmVsIE9PTQ0KPj4gPj4gcHJvdGVj
dGlvbiBtZWNoYW5pc20uIFdoZW4gYW4gZ2xvYmFsL21lbWNnIG9vbSBldmVudCBvY2N1cnMsIHdl
IHRyZWF0DQo+PiA+PiBhbGwgcHJvY2Vzc2VzIGluIHRoZSBjZ3JvdXAgYXMgYSB3aG9sZSwgYW5k
IE9PTSBraWxsZXJzIG5lZWQgdG8gc2VsZWN0DQo+PiA+PiB0aGUgcHJvY2VzcyB0byBraWxsIGJh
c2VkIG9uIHRoZSBwcm90ZWN0aW9uIHF1b3RhIG9mIHRoZSBjZ3JvdXAuDQo+PiA+Pg0KPj4gPg0K
Pj4gPlBlcmhhcHMgdGhpcyBpcyBvbmx5IHNsaWdodGx5IHJlbGV2YW50LCBidXQgYXQgR29vZ2xl
IHdlIGRvIGhhdmUgYQ0KPj4gPmRpZmZlcmVudCBwZXItbWVtY2cgYXBwcm9hY2ggdG8gcHJvdGVj
dCBmcm9tIE9PTSBraWxscywgb3IgbW9yZQ0KPj4gPnNwZWNpZmljYWxseSB0ZWxsIHRoZSBrZXJu
ZWwgaG93IHdlIHdvdWxkIGxpa2UgdGhlIE9PTSBraWxsZXIgdG8NCj4+ID5iZWhhdmUuDQo+PiA+
DQo+PiA+V2UgZGVmaW5lIGFuIGludGVyZmFjZSBjYWxsZWQgbWVtb3J5Lm9vbV9zY29yZV9iYWRu
ZXNzLCBhbmQgd2UgYWxzbw0KPj4gPmFsbG93IGl0IHRvIGJlIHNwZWNpZmllZCBwZXItcHJvY2Vz
cyB0aHJvdWdoIGEgcHJvY2ZzIGludGVyZmFjZSwNCj4+ID5zaW1pbGFyIHRvIG9vbV9zY29yZV9h
ZGouDQo+PiA+DQo+PiA+VGhlc2Ugc2NvcmVzIGVzc2VudGlhbGx5IHRlbGwgdGhlIE9PTSBraWxs
ZXIgdGhlIG9yZGVyIGluIHdoaWNoIHdlDQo+PiA+cHJlZmVyIG1lbWNncyB0byBiZSBPT00nZCwg
YW5kIHRoZSBvcmRlciBpbiB3aGljaCB3ZSB3YW50IHByb2Nlc3NlcyBpbg0KPj4gPnRoZSBtZW1j
ZyB0byBiZSBPT00nZC4gQnkgZGVmYXVsdCwgYWxsIHByb2Nlc3NlcyBhbmQgbWVtY2dzIHN0YXJ0
IHdpdGgNCj4+ID50aGUgc2FtZSBzY29yZS4gVGllcyBhcmUgYnJva2VuIGJhc2VkIG9uIHRoZSBy
c3Mgb2YgdGhlIHByb2Nlc3Mgb3IgdGhlDQo+PiA+dXNhZ2Ugb2YgdGhlIG1lbWNnIChwcmVmZXIg
dG8ga2lsbCB0aGUgcHJvY2Vzcy9tZW1jZyB0aGF0IHdpbGwgZnJlZQ0KPj4gPm1vcmUgbWVtb3J5
KSAtLSBzaW1pbGFyIHRvIHRoZSBjdXJyZW50IE9PTSBraWxsZXIuDQo+Pg0KPj4gVGhhbmsgeW91
IGZvciBwcm92aWRpbmcgYSBuZXcgYXBwbGljYXRpb24gc2NlbmFyaW8uIFlvdSBoYXZlIGRlc2Ny
aWJlZCBhDQo+PiBuZXcgcGVyLW1lbWNnIGFwcHJvYWNoLCBidXQgYSBzaW1wbGUgaW50cm9kdWN0
aW9uIGNhbm5vdCBleHBsYWluIHRoZQ0KPj4gZGV0YWlscyBvZiB5b3VyIGFwcHJvYWNoIGNsZWFy
bHkuIElmIHlvdSBjb3VsZCBjb21wYXJlIGFuZCBhbmFseXplIG15DQo+PiBwYXRjaGVzIGZvciBw
b3NzaWJsZSBkZWZlY3RzLCBvciBpZiB5b3VyIG5ldyBhcHByb2FjaCBoYXMgYWR2YW50YWdlcw0K
Pj4gdGhhdCBteSBwYXRjaGVzIGRvIG5vdCBoYXZlLCBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0
ZSBpdC4NCj4NCj5Tb3JyeSBpZiBJIHdhcyBub3QgY2xlYXIsIEkgYW0gbm90IGltcGx5aW5nIGlu
IGFueSB3YXkgdGhhdCB0aGUNCj5hcHByb2FjaCBJIGFtIGRlc2NyaWJpbmcgaXMgYmV0dGVyIHRo
YW4geW91ciBwYXRjaGVzLiBJIGFtIGd1aWx0eSBvZg0KPm5vdCBjb25kdWN0aW5nIHRoZSBwcm9w
ZXIgYW5hbHlzaXMgeW91IGFyZSByZXF1ZXN0aW5nLg0KDQpUaGVyZSBpcyBubyBwZXJmZWN0IGFw
cHJvYWNoIGluIHRoZSB3b3JsZCwgYW5kIEkgYWxzbyBzZWVrIHlvdXIgYWR2aWNlIHdpdGgNCmEg
bGVhcm5pbmcgYXR0aXR1ZGUuIFlvdSBkb24ndCBuZWVkIHRvIHNheSBzb3JyeSwgSSBzaG91bGQg
c2F5IHRoYW5rIHlvdS4NCg0KPkkganVzdCBzYXcgdGhlIHRocmVhZCBhbmQgdGhvdWdodCBpdCBt
aWdodCBiZSBpbnRlcmVzdGluZyB0byB5b3Ugb3INCj5vdGhlcnMgdG8ga25vdyB0aGUgYXBwcm9h
Y2ggdGhhdCB3ZSBoYXZlIGJlZW4gdXNpbmcgZm9yIHllYXJzIGluIG91cg0KPnByb2R1Y3Rpb24u
IEkgZ3Vlc3MgdGhlIHRhcmdldCBpcyB0aGUgc2FtZSwgYmUgYWJsZSB0byB0ZWxsIHRoZSBPT00N
Cj5raWxsZXIgd2hpY2ggbWVtY2dzL3Byb2Nlc3NlcyBhcmUgbW9yZSBpbXBvcnRhbnQgdG8gcHJv
dGVjdC4gVGhlDQo+ZnVuZGFtZW50YWwgZGlmZmVyZW5jZSBpcyB0aGF0IGluc3RlYWQgb2YgdHVu
aW5nIHRoaXMgYmFzZWQgb24gdGhlDQo+bWVtb3J5IHVzYWdlIG9mIHRoZSBtZW1jZyAoeW91ciBh
cHByb2FjaCksIHdlIGVzc2VudGlhbGx5IGdpdmUgdGhlIE9PTQ0KPmtpbGxlciB0aGUgb3JkZXJp
bmcgaW4gd2hpY2ggd2Ugd2FudCBtZW1jZ3MvcHJvY2Vzc2VzIHRvIGJlIE9PTQ0KPmtpbGxlZC4g
VGhpcyBtYXBzIHRvIGpvYnMgcHJpb3JpdGllcyBlc3NlbnRpYWxseS4NCg0KS2lsbGluZyBwcm9j
ZXNzZXMgaW4gb3JkZXIgb2YgbWVtb3J5IHVzYWdlIGNhbm5vdCBlZmZlY3RpdmVseSBwcm90ZWN0
DQppbXBvcnRhbnQgcHJvY2Vzc2VzLiBLaWxsaW5nIHByb2Nlc3NlcyBpbiBhIHVzZXItZGVmaW5l
ZCBwcmlvcml0eSBvcmRlcg0Kd2lsbCByZXN1bHQgaW4gYSBsYXJnZSBudW1iZXIgb2YgT09NIGV2
ZW50cyBhbmQgc3RpbGwgbm90IGJlaW5nIGFibGUgdG8NCnJlbGVhc2UgZW5vdWdoIG1lbW9yeS4g
SSBoYXZlIGJlZW4gc2VhcmNoaW5nIGZvciBhIGJhbGFuY2UgYmV0d2Vlbg0KdGhlIHR3byBtZXRo
b2RzLCBzbyB0aGF0IHRoZWlyIHNob3J0Y29taW5ncyBhcmUgbm90IHRvbyBvYnZpb3VzLg0KVGhl
IGJpZ2dlc3QgYWR2YW50YWdlIG9mIG1lbWNnIGlzIGl0cyB0cmVlIHRvcG9sb2d5LCBhbmQgSSBh
bHNvIGhvcGUNCnRvIG1ha2UgZ29vZCB1c2Ugb2YgaXQuDQoNCj5JZiB0aGlzIGFwcHJvYWNoIHdv
cmtzIGZvciB5b3UgKG9yIGFueSBvdGhlciBhdWRpZW5jZSksIHRoYXQncyBncmVhdCwNCj5JIGNh
biBzaGFyZSBtb3JlIGRldGFpbHMgYW5kIHBlcmhhcHMgd2UgY2FuIHJlYWNoIHNvbWV0aGluZyB0
aGF0IHdlDQo+Y2FuIGJvdGggdXNlIDopDQoNCklmIHlvdSBoYXZlIGEgZ29vZCBpZGVhLCBwbGVh
c2Ugc2hhcmUgbW9yZSBkZXRhaWxzIG9yIHNob3cgc29tZSBjb2RlLg0KSSB3b3VsZCBncmVhdGx5
IGFwcHJlY2lhdGUgaXQNCg0KPj4NCj4+ID5UaGlzIGhhcyBiZWVuIGJyb3VnaHQgdXAgYmVmb3Jl
IGluIG90aGVyIGRpc2N1c3Npb25zIHdpdGhvdXQgbXVjaA0KPj4gPmludGVyZXN0IFsxXSwgYnV0
IGp1c3QgdGhvdWdodCBpdCBtYXkgYmUgcmVsZXZhbnQgaGVyZS4NCj4+ID4NCj4+ID5bMV1odHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBSFM4aXpOM2VqMW1xVXBuTlE4Yy0xQng1RWVPN3E1
Tk9raDBxcllfNFBMcWM4cmtIQUBtYWlsLmdtYWlsLmNvbS8jdA0KDQotLQ0KVGhhbmtzIGZvciB5
b3VyIGNvbW1lbnQhDQpjaGVuZ2thaXRhbw0KDQo=
