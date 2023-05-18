Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98B707971
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 07:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjERFMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 01:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERFMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 01:12:16 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2195E1981;
        Wed, 17 May 2023 22:12:13 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.36])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 20503110078005;
        Thu, 18 May 2023 13:12:12 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-06.didichuxing.com (10.79.71.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 13:12:11 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Thu, 18 May 2023 13:12:11 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.36
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
Thread-Index: AQHZiG6QYuA8nkfOmkSWHm0JCEvXOa9dgyoAgACXf4D//3xFAIAApWQAgAAs0QCAARSZgA==
Date:   Thu, 18 May 2023 05:12:11 +0000
Message-ID: <B66FDA24-50C6-444D-BD84-124E68A2AEEE@didiglobal.com>
In-Reply-To: <CAJD7tkaOMeeGNqm6nFyHgPhd9VpnCVqCAYCY725NoTohTMAnmw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <979D7504BF289D4BA11C323B85EB0DF5@didichuxing.com>
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

QXQgMjAyMy0wNS0xOCAwNDo0MjoxMiwgIllvc3J5IEFobWVkIiA8eW9zcnlhaG1lZEBnb29nbGUu
Y29tPiB3cm90ZToNCj5PbiBXZWQsIE1heSAxNywgMjAyMyBhdCAzOjAx4oCvQU0g56iL5Z6y5rab
IENoZW5na2FpdGFvIENoZW5nDQo+PGNoZW5na2FpdGFvQGRpZGlnbG9iYWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBBdCAyMDIzLTA1LTE3IDE2OjA5OjUwLCAiWW9zcnkgQWhtZWQiIDx5b3NyeWFobWVk
QGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gPk9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDE6MDHigK9B
TSDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8gQ2hlbmcNCj4+ID48Y2hlbmdrYWl0YW9AZGlkaWdsb2Jh
bC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+IEF0IDIwMjMtMDUtMTcgMTQ6NTk6MDYsICJZb3Ny
eSBBaG1lZCIgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+PiA+PiA+K0RhdmlkIFJp
ZW50amVzDQo+PiA+PiA+DQo+PiA+PiA+T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgODoyMOKAr1BN
IGNoZW5na2FpdGFvIDxjaGVuZ2thaXRhb0BkaWRpZ2xvYmFsLmNvbT4gd3JvdGU6DQo+PiA+PiA+
Pg0KPj4gPj4gVGhhbmsgeW91IGZvciBwcm92aWRpbmcgYSBuZXcgYXBwbGljYXRpb24gc2NlbmFy
aW8uIFlvdSBoYXZlIGRlc2NyaWJlZCBhDQo+PiA+PiBuZXcgcGVyLW1lbWNnIGFwcHJvYWNoLCBi
dXQgYSBzaW1wbGUgaW50cm9kdWN0aW9uIGNhbm5vdCBleHBsYWluIHRoZQ0KPj4gPj4gZGV0YWls
cyBvZiB5b3VyIGFwcHJvYWNoIGNsZWFybHkuIElmIHlvdSBjb3VsZCBjb21wYXJlIGFuZCBhbmFs
eXplIG15DQo+PiA+PiBwYXRjaGVzIGZvciBwb3NzaWJsZSBkZWZlY3RzLCBvciBpZiB5b3VyIG5l
dyBhcHByb2FjaCBoYXMgYWR2YW50YWdlcw0KPj4gPj4gdGhhdCBteSBwYXRjaGVzIGRvIG5vdCBo
YXZlLCBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBpdC4NCj4+ID4NCj4+ID5Tb3JyeSBpZiBJ
IHdhcyBub3QgY2xlYXIsIEkgYW0gbm90IGltcGx5aW5nIGluIGFueSB3YXkgdGhhdCB0aGUNCj4+
ID5hcHByb2FjaCBJIGFtIGRlc2NyaWJpbmcgaXMgYmV0dGVyIHRoYW4geW91ciBwYXRjaGVzLiBJ
IGFtIGd1aWx0eSBvZg0KPj4gPm5vdCBjb25kdWN0aW5nIHRoZSBwcm9wZXIgYW5hbHlzaXMgeW91
IGFyZSByZXF1ZXN0aW5nLg0KPj4NCj4+IFRoZXJlIGlzIG5vIHBlcmZlY3QgYXBwcm9hY2ggaW4g
dGhlIHdvcmxkLCBhbmQgSSBhbHNvIHNlZWsgeW91ciBhZHZpY2Ugd2l0aA0KPj4gYSBsZWFybmlu
ZyBhdHRpdHVkZS4gWW91IGRvbid0IG5lZWQgdG8gc2F5IHNvcnJ5LCBJIHNob3VsZCBzYXkgdGhh
bmsgeW91Lg0KPj4NCj4+ID5JIGp1c3Qgc2F3IHRoZSB0aHJlYWQgYW5kIHRob3VnaHQgaXQgbWln
aHQgYmUgaW50ZXJlc3RpbmcgdG8geW91IG9yDQo+PiA+b3RoZXJzIHRvIGtub3cgdGhlIGFwcHJv
YWNoIHRoYXQgd2UgaGF2ZSBiZWVuIHVzaW5nIGZvciB5ZWFycyBpbiBvdXINCj4+ID5wcm9kdWN0
aW9uLiBJIGd1ZXNzIHRoZSB0YXJnZXQgaXMgdGhlIHNhbWUsIGJlIGFibGUgdG8gdGVsbCB0aGUg
T09NDQo+PiA+a2lsbGVyIHdoaWNoIG1lbWNncy9wcm9jZXNzZXMgYXJlIG1vcmUgaW1wb3J0YW50
IHRvIHByb3RlY3QuIFRoZQ0KPj4gPmZ1bmRhbWVudGFsIGRpZmZlcmVuY2UgaXMgdGhhdCBpbnN0
ZWFkIG9mIHR1bmluZyB0aGlzIGJhc2VkIG9uIHRoZQ0KPj4gPm1lbW9yeSB1c2FnZSBvZiB0aGUg
bWVtY2cgKHlvdXIgYXBwcm9hY2gpLCB3ZSBlc3NlbnRpYWxseSBnaXZlIHRoZSBPT00NCj4+ID5r
aWxsZXIgdGhlIG9yZGVyaW5nIGluIHdoaWNoIHdlIHdhbnQgbWVtY2dzL3Byb2Nlc3NlcyB0byBi
ZSBPT00NCj4+ID5raWxsZWQuIFRoaXMgbWFwcyB0byBqb2JzIHByaW9yaXRpZXMgZXNzZW50aWFs
bHkuDQo+Pg0KPj4gS2lsbGluZyBwcm9jZXNzZXMgaW4gb3JkZXIgb2YgbWVtb3J5IHVzYWdlIGNh
bm5vdCBlZmZlY3RpdmVseSBwcm90ZWN0DQo+PiBpbXBvcnRhbnQgcHJvY2Vzc2VzLiBLaWxsaW5n
IHByb2Nlc3NlcyBpbiBhIHVzZXItZGVmaW5lZCBwcmlvcml0eSBvcmRlcg0KPj4gd2lsbCByZXN1
bHQgaW4gYSBsYXJnZSBudW1iZXIgb2YgT09NIGV2ZW50cyBhbmQgc3RpbGwgbm90IGJlaW5nIGFi
bGUgdG8NCj4+IHJlbGVhc2UgZW5vdWdoIG1lbW9yeS4gSSBoYXZlIGJlZW4gc2VhcmNoaW5nIGZv
ciBhIGJhbGFuY2UgYmV0d2Vlbg0KPj4gdGhlIHR3byBtZXRob2RzLCBzbyB0aGF0IHRoZWlyIHNo
b3J0Y29taW5ncyBhcmUgbm90IHRvbyBvYnZpb3VzLg0KPj4gVGhlIGJpZ2dlc3QgYWR2YW50YWdl
IG9mIG1lbWNnIGlzIGl0cyB0cmVlIHRvcG9sb2d5LCBhbmQgSSBhbHNvIGhvcGUNCj4+IHRvIG1h
a2UgZ29vZCB1c2Ugb2YgaXQuDQo+DQo+Rm9yIHVzLCBraWxsaW5nIHByb2Nlc3NlcyBpbiBhIHVz
ZXItZGVmaW5lZCBwcmlvcml0eSBvcmRlciB3b3JrcyB3ZWxsLg0KPg0KPkl0IHNlZW1zIGxpa2Ug
dG8gdHVuZSBtZW1vcnkub29tLnByb3RlY3QgeW91IHVzZSBvb21fa2lsbF9pbmhlcml0IHRvDQo+
b2JzZXJ2ZSBob3cgbWFueSB0aW1lcyB0aGlzIG1lbWNnIGhhcyBiZWVuIGtpbGxlZCBkdWUgdG8g
YSBsaW1pdCBpbiBhbg0KPmFuY2VzdG9yLiBXb3VsZG4ndCBpdCBiZSBtb3JlIHN0cmFpZ2h0Zm9y
d2FyZCB0byBzcGVjaWZ5IHRoZSBwcmlvcml0eQ0KPm9mIHByb3RlY3Rpb25zIGFtb25nIG1lbWNn
cz8NCj4NCj5Gb3IgZXhhbXBsZSwgaWYgeW91IG9ic2VydmUgbXVsdGlwbGUgbWVtY2dzIGJlaW5n
IE9PTSBraWxsZWQgZHVlIHRvDQo+aGl0dGluZyBhbiBhbmNlc3RvciBsaW1pdCwgeW91IHdpbGwg
bmVlZCB0byBkZWNpZGUgd2hpY2ggb2YgdGhlbSB0bw0KPmluY3JlYXNlIG1lbW9yeS5vb20ucHJv
dGVjdCBmb3IgbW9yZSwgYmFzZWQgb24gdGhlaXIgaW1wb3J0YW5jZS4NCj5PdGhlcndpc2UsIGlm
IHlvdSBpbmNyZWFzZSBhbGwgb2YgdGhlbSwgdGhlbiB0aGVyZSBpcyBubyBwb2ludCBpZiBhbGwN
Cj50aGUgbWVtb3J5IGlzIHByb3RlY3RlZCwgcmlnaHQ/DQoNCklmIGFsbCBtZW1vcnkgaW4gbWVt
Y2cgaXMgcHJvdGVjdGVkLCBpdHMgbWVhbmluZyBpcyBzaW1pbGFyIHRvIHRoYXQgb2YgdGhlDQpo
aWdoZXN0IHByaW9yaXR5IG1lbWNnIGluIHlvdXIgYXBwcm9hY2gsIHdoaWNoIGlzIHVsdGltYXRl
bHkga2lsbGVkIG9yDQpuZXZlciBraWxsZWQuDQoNCj5JbiB0aGlzIGNhc2UsIHdvdWxkbid0IGl0
IGJlIGVhc2llciB0byBqdXN0IHRlbGwgdGhlIE9PTSBraWxsZXIgdGhlDQo+cmVsYXRpdmUgcHJp
b3JpdHkgYW1vbmcgdGhlIG1lbWNncz8NCj4NCj4+DQo+PiA+SWYgdGhpcyBhcHByb2FjaCB3b3Jr
cyBmb3IgeW91IChvciBhbnkgb3RoZXIgYXVkaWVuY2UpLCB0aGF0J3MgZ3JlYXQsDQo+PiA+SSBj
YW4gc2hhcmUgbW9yZSBkZXRhaWxzIGFuZCBwZXJoYXBzIHdlIGNhbiByZWFjaCBzb21ldGhpbmcg
dGhhdCB3ZQ0KPj4gPmNhbiBib3RoIHVzZSA6KQ0KPj4NCj4+IElmIHlvdSBoYXZlIGEgZ29vZCBp
ZGVhLCBwbGVhc2Ugc2hhcmUgbW9yZSBkZXRhaWxzIG9yIHNob3cgc29tZSBjb2RlLg0KPj4gSSB3
b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgaXQNCj4NCj5UaGUgY29kZSB3ZSBoYXZlIG5lZWRzIHRv
IGJlIHJlYmFzZWQgb250byBhIGRpZmZlcmVudCB2ZXJzaW9uIGFuZA0KPmNsZWFuZWQgdXAgYmVm
b3JlIGl0IGNhbiBiZSBzaGFyZWQsIGJ1dCBlc3NlbnRpYWxseSBpdCBpcyBhcw0KPmRlc2NyaWJl
ZC4NCj4NCj4oYSkgQWxsIHByb2Nlc3NlcyBhbmQgbWVtY2dzIHN0YXJ0IHdpdGggYSBkZWZhdWx0
IHNjb3JlLg0KPihiKSBVc2Vyc3BhY2UgY2FuIHNwZWNpZnkgc2NvcmVzIGZvciBtZW1jZ3MgYW5k
IHByb2Nlc3Nlcy4gQSBoaWdoZXINCj5zY29yZSBtZWFucyBoaWdoZXIgcHJpb3JpdHkgKGFrYSBs
ZXNzIHNjb3JlIGdldHMga2lsbGVkIGZpcnN0KS4NCj4oYykgVGhlIE9PTSBraWxsZXIgZXNzZW50
aWFsbHkgbG9va3MgZm9yIHRoZSBtZW1jZyB3aXRoIHRoZSBsb3dlc3QNCj5zY29yZXMgdG8ga2ls
bCwgdGhlbiBhbW9uZyB0aGlzIG1lbWNnLCBpdCBsb29rcyBmb3IgdGhlIHByb2Nlc3Mgd2l0aA0K
PnRoZSBsb3dlc3Qgc2NvcmUuIFRpZXMgYXJlIGJyb2tlbiBiYXNlZCBvbiB1c2FnZSwgc28gZXNz
ZW50aWFsbHkgaWYNCj5hbGwgcHJvY2Vzc2VzL21lbWNncyBoYXZlIHRoZSBkZWZhdWx0IHNjb3Jl
LCB3ZSBmYWxsYmFjayB0byB0aGUNCj5jdXJyZW50IE9PTSBiZWhhdmlvci4NCg0KSWYgbWVtb3J5
IG92ZXJzb2xkIGlzIHNldmVyZSwgYWxsIHByb2Nlc3NlcyBvZiB0aGUgbG93ZXN0IHByaW9yaXR5
DQptZW1jZyBtYXkgYmUga2lsbGVkIGJlZm9yZSBzZWxlY3Rpbmcgb3RoZXIgbWVtY2cgcHJvY2Vz
c2VzLg0KSWYgdGhlcmUgYXJlIDEwMDAgcHJvY2Vzc2VzIHdpdGggYWxtb3N0IHplcm8gbWVtb3J5
IHVzYWdlIGluDQp0aGUgbG93ZXN0IHByaW9yaXR5IG1lbWNnLCAxMDAwIGludmFsaWQga2lsbCBl
dmVudHMgbWF5IG9jY3VyLg0KVG8gYXZvaWQgdGhpcyBzaXR1YXRpb24sIGV2ZW4gZm9yIHRoZSBs
b3dlc3QgcHJpb3JpdHkgbWVtY2csDQpJIHdpbGwgbGVhdmUgaGltIGEgdmVyeSBzbWFsbCBvb20u
cHJvdGVjdCBxdW90YS4NCg0KSWYgZmFjZWQgd2l0aCB0d28gbWVtY2dzIHdpdGggdGhlIHNhbWUg
dG90YWwgbWVtb3J5IHVzYWdlIGFuZA0KcHJpb3JpdHksIG1lbWNnIEEgaGFzIG1vcmUgcHJvY2Vz
c2VzIGJ1dCBsZXNzIG1lbW9yeSB1c2FnZSBwZXINCnNpbmdsZSBwcm9jZXNzLCBhbmQgbWVtY2cg
QiBoYXMgZmV3ZXIgcHJvY2Vzc2VzIGJ1dCBtb3JlDQptZW1vcnkgdXNhZ2UgcGVyIHNpbmdsZSBw
cm9jZXNzLCB0aGVuIHdoZW4gT09NIG9jY3VycywgdGhlDQpwcm9jZXNzZXMgaW4gbWVtY2cgQiBt
YXkgY29udGludWUgdG8gYmUga2lsbGVkIHVudGlsIGFsbCBwcm9jZXNzZXMNCmluIG1lbWNnIEIg
YXJlIGtpbGxlZCwgd2hpY2ggaXMgdW5mYWlyIHRvIG1lbWNnIEIgYmVjYXVzZSBtZW1jZyBBDQph
bHNvIG9jY3VwaWVzIGEgbGFyZ2UgYW1vdW50IG9mIG1lbW9yeS4NCg0KRG9zZSB5b3VyIGFwcHJv
YWNoIGhhdmUgdGhlc2UgaXNzdWVzPyBLaWxsaW5nIHByb2Nlc3NlcyBpbiBhDQp1c2VyLWRlZmlu
ZWQgcHJpb3JpdHkgaXMgaW5kZWVkIGVhc2llciBhbmQgY2FuIHdvcmsgd2VsbCBpbiBtb3N0IGNh
c2VzLA0KYnV0IEkgaGF2ZSBiZWVuIHRyeWluZyB0byBzb2x2ZSB0aGUgY2FzZXMgdGhhdCBpdCBj
YW5ub3QgY292ZXIuDQoNCi0tDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCENCmNoZW5na2FpdGFv
DQoNCg0K
