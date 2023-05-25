Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD7710735
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbjEYIUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbjEYITx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:19:53 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1806E122;
        Thu, 25 May 2023 01:19:42 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.36])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 599F1B006CA0C;
        Thu, 25 May 2023 16:19:41 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-06.didichuxing.com (10.79.71.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 16:19:40 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Thu, 25 May 2023 16:19:40 +0800
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
Thread-Index: AQHZiG6QYuA8nkfOmkSWHm0JCEvXOa9dgyoAgACXf4D//3xFAIAApWQAgAAs0QCAARSZgIACJwoAgAFL/4CABPzogIACxMMA
Date:   Thu, 25 May 2023 08:19:40 +0000
Message-ID: <B438A058-7C4A-46B3-B6FB-4CF32BD7D294@didiglobal.com>
In-Reply-To: <CAJD7tkZwCreOS_XxDM_9mOTBo=Gatr12r1xtc64B_e5+HJhRqg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8544EAEE9FD53344A86FC09D81EAFF44@didichuxing.com>
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

QXQgMjAyMy0wNS0yNCAwNjowMjo1NSwgIllvc3J5IEFobWVkIiA8eW9zcnlhaG1lZEBnb29nbGUu
Y29tPiB3cm90ZToNCj5PbiBTYXQsIE1heSAyMCwgMjAyMyBhdCAyOjUy4oCvQU0g56iL5Z6y5rab
IENoZW5na2FpdGFvIENoZW5nDQo+PGNoZW5na2FpdGFvQGRpZGlnbG9iYWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBBdCAyMDIzLTA1LTIwIDA2OjA0OjI2LCAiWW9zcnkgQWhtZWQiIDx5b3NyeWFobWVk
QGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gPk9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDEwOjEy4oCv
UE0g56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5nDQo+PiA+PGNoZW5na2FpdGFvQGRpZGlnbG9i
YWwuY29tPiB3cm90ZToNCj4+ID4+DQo+PiA+PiBBdCAyMDIzLTA1LTE4IDA0OjQyOjEyLCAiWW9z
cnkgQWhtZWQiIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gPj4gPk9uIFdlZCwg
TWF5IDE3LCAyMDIzIGF0IDM6MDHigK9BTSDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8gQ2hlbmcNCj4+
ID4+ID48Y2hlbmdrYWl0YW9AZGlkaWdsb2JhbC5jb20+IHdyb3RlOg0KPj4gPj4gPj4NCj4+ID4+
ID4+IEF0IDIwMjMtMDUtMTcgMTY6MDk6NTAsICJZb3NyeSBBaG1lZCIgPHlvc3J5YWhtZWRAZ29v
Z2xlLmNvbT4gd3JvdGU6DQo+PiA+PiA+PiA+T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMTowMeKA
r0FNIOeoi+Wesua2myBDaGVuZ2thaXRhbyBDaGVuZw0KPj4gPj4gPj4gPjxjaGVuZ2thaXRhb0Bk
aWRpZ2xvYmFsLmNvbT4gd3JvdGU6DQo+PiA+PiA+PiA+Pg0KPj4gPj4gPj4NCj4+ID4+ID4+IEtp
bGxpbmcgcHJvY2Vzc2VzIGluIG9yZGVyIG9mIG1lbW9yeSB1c2FnZSBjYW5ub3QgZWZmZWN0aXZl
bHkgcHJvdGVjdA0KPj4gPj4gPj4gaW1wb3J0YW50IHByb2Nlc3Nlcy4gS2lsbGluZyBwcm9jZXNz
ZXMgaW4gYSB1c2VyLWRlZmluZWQgcHJpb3JpdHkgb3JkZXINCj4+ID4+ID4+IHdpbGwgcmVzdWx0
IGluIGEgbGFyZ2UgbnVtYmVyIG9mIE9PTSBldmVudHMgYW5kIHN0aWxsIG5vdCBiZWluZyBhYmxl
IHRvDQo+PiA+PiA+PiByZWxlYXNlIGVub3VnaCBtZW1vcnkuIEkgaGF2ZSBiZWVuIHNlYXJjaGlu
ZyBmb3IgYSBiYWxhbmNlIGJldHdlZW4NCj4+ID4+ID4+IHRoZSB0d28gbWV0aG9kcywgc28gdGhh
dCB0aGVpciBzaG9ydGNvbWluZ3MgYXJlIG5vdCB0b28gb2J2aW91cy4NCj4+ID4+ID4+IFRoZSBi
aWdnZXN0IGFkdmFudGFnZSBvZiBtZW1jZyBpcyBpdHMgdHJlZSB0b3BvbG9neSwgYW5kIEkgYWxz
byBob3BlDQo+PiA+PiA+PiB0byBtYWtlIGdvb2QgdXNlIG9mIGl0Lg0KPj4gPj4gPg0KPj4gPj4g
PkZvciB1cywga2lsbGluZyBwcm9jZXNzZXMgaW4gYSB1c2VyLWRlZmluZWQgcHJpb3JpdHkgb3Jk
ZXIgd29ya3Mgd2VsbC4NCj4+ID4+ID4NCj4+ID4+ID5JdCBzZWVtcyBsaWtlIHRvIHR1bmUgbWVt
b3J5Lm9vbS5wcm90ZWN0IHlvdSB1c2Ugb29tX2tpbGxfaW5oZXJpdCB0bw0KPj4gPj4gPm9ic2Vy
dmUgaG93IG1hbnkgdGltZXMgdGhpcyBtZW1jZyBoYXMgYmVlbiBraWxsZWQgZHVlIHRvIGEgbGlt
aXQgaW4gYW4NCj4+ID4+ID5hbmNlc3Rvci4gV291bGRuJ3QgaXQgYmUgbW9yZSBzdHJhaWdodGZv
cndhcmQgdG8gc3BlY2lmeSB0aGUgcHJpb3JpdHkNCj4+ID4+ID5vZiBwcm90ZWN0aW9ucyBhbW9u
ZyBtZW1jZ3M/DQo+PiA+PiA+DQo+PiA+PiA+Rm9yIGV4YW1wbGUsIGlmIHlvdSBvYnNlcnZlIG11
bHRpcGxlIG1lbWNncyBiZWluZyBPT00ga2lsbGVkIGR1ZSB0bw0KPj4gPj4gPmhpdHRpbmcgYW4g
YW5jZXN0b3IgbGltaXQsIHlvdSB3aWxsIG5lZWQgdG8gZGVjaWRlIHdoaWNoIG9mIHRoZW0gdG8N
Cj4+ID4+ID5pbmNyZWFzZSBtZW1vcnkub29tLnByb3RlY3QgZm9yIG1vcmUsIGJhc2VkIG9uIHRo
ZWlyIGltcG9ydGFuY2UuDQo+PiA+PiA+T3RoZXJ3aXNlLCBpZiB5b3UgaW5jcmVhc2UgYWxsIG9m
IHRoZW0sIHRoZW4gdGhlcmUgaXMgbm8gcG9pbnQgaWYgYWxsDQo+PiA+PiA+dGhlIG1lbW9yeSBp
cyBwcm90ZWN0ZWQsIHJpZ2h0Pw0KPj4gPj4NCj4+ID4+IElmIGFsbCBtZW1vcnkgaW4gbWVtY2cg
aXMgcHJvdGVjdGVkLCBpdHMgbWVhbmluZyBpcyBzaW1pbGFyIHRvIHRoYXQgb2YgdGhlDQo+PiA+
PiBoaWdoZXN0IHByaW9yaXR5IG1lbWNnIGluIHlvdXIgYXBwcm9hY2gsIHdoaWNoIGlzIHVsdGlt
YXRlbHkga2lsbGVkIG9yDQo+PiA+PiBuZXZlciBraWxsZWQuDQo+PiA+DQo+PiA+TWFrZXMgc2Vu
c2UuIEkgYmVsaWV2ZSBpdCBnZXRzIGEgYml0IHRyaWNraWVyIHdoZW4geW91IHdhbnQgdG8NCj4+
ID5kZXNjcmliZSByZWxhdGl2ZSBvcmRlcmluZyBiZXR3ZWVuIG1lbWNncyB1c2luZyBtZW1vcnku
b29tLnByb3RlY3QuDQo+Pg0KPj4gQWN0dWFsbHksIG15IG9yaWdpbmFsIGludGVudGlvbiB3YXMg
bm90IHRvIHVzZSBtZW1vcnkub29tLnByb3RlY3QgdG8NCj4+IGFjaGlldmUgcmVsYXRpdmUgb3Jk
ZXJpbmcgYmV0d2VlbiBtZW1jZ3MsIGl0IHdhcyBqdXN0IGEgZmVhdHVyZSB0aGF0DQo+PiBoYXBw
ZW5lZCB0byBiZSBhY2hpZXZhYmxlLiBNeSBpbml0aWFsIGlkZWEgd2FzIHRvIHByb3RlY3QgYSBj
ZXJ0YWluDQo+PiBwcm9wb3J0aW9uIG9mIG1lbW9yeSBpbiBtZW1jZyBmcm9tIGJlaW5nIGtpbGxl
ZCwgYW5kIHRocm91Z2ggdGhlDQo+PiBtZXRob2QsIHBoeXNpY2FsIG1lbW9yeSBjYW4gYmUgcmVh
c29uYWJseSBwbGFubmVkLiBCb3RoIHRoZSBwaHlzaWNhbA0KPj4gbWFjaGluZSBtYW5hZ2VyIGFu
ZCBjb250YWluZXIgbWFuYWdlciBjYW4gYWRkIHNvbWUgdW5pbXBvcnRhbnQNCj4+IGxvYWRzIGJl
eW9uZCB0aGUgb29tLnByb3RlY3QgbGltaXQsIGdyZWF0bHkgaW1wcm92aW5nIHRoZSBvdmVyc29s
ZA0KPj4gcmF0ZSBvZiBtZW1vcnkuIEluIHRoZSB3b3JzdCBjYXNlIHNjZW5hcmlvLCB0aGUgcGh5
c2ljYWwgbWFjaGluZSBjYW4NCj4+IGFsd2F5cyBwcm92aWRlIGFsbCB0aGUgbWVtb3J5IGxpbWl0
ZWQgYnkgbWVtb3J5Lm9vbS5wcm90ZWN0IGZvciBtZW1jZy4NCj4+DQo+PiBPbiB0aGUgb3RoZXIg
aGFuZCwgSSBhbHNvIHdhbnQgdG8gYWNoaWV2ZSByZWxhdGl2ZSBvcmRlcmluZyBvZiBpbnRlcm5h
bA0KPj4gcHJvY2Vzc2VzIGluIG1lbWNnLCBub3QganVzdCBhIHVuaWZpZWQgb3JkZXJpbmcgb2Yg
YWxsIG1lbWNncyBvbg0KPj4gcGh5c2ljYWwgbWFjaGluZXMuDQo+DQo+Rm9yIHVzLCBoYXZpbmcg
YSBzdHJpY3QgcHJpb3JpdHkgb3JkZXJpbmctYmFzZWQgc2VsZWN0aW9uIGlzDQo+ZXNzZW50aWFs
LiBXZSBoYXZlIGRpZmZlcmVudCB0aWVycyBvZiBqb2JzIG9mIGRpZmZlcmVudCBpbXBvcnRhbmNl
LA0KPmFuZCBhIGpvYiBvZiBoaWdoZXIgcHJpb3JpdHkgc2hvdWxkIG5vdCBiZSBraWxsZWQgYmVm
b3JlIGEgbG93ZXINCj5wcmlvcml0eSB0YXNrIGlmIHBvc3NpYmxlLCBubyBtYXR0ZXIgaG93IG11
Y2ggbWVtb3J5IGVpdGhlciBvZiB0aGVtIGlzDQo+dXNpbmcuIFByb3RlY3RpbmcgbWVtY2dzIHNv
bGVseSBiYXNlZCBvbiB0aGVpciB1c2FnZSBjYW4gYmUgdXNlZnVsIGluDQo+c29tZSBzY2VuYXJp
b3MsIGJ1dCBub3QgaW4gYSBzeXN0ZW0gd2hlcmUgeW91IGhhdmUgZGlmZmVyZW50IHRpZXJzIG9m
DQo+am9icyBydW5uaW5nIHdpdGggc3RyaWN0IHByaW9yaXR5IG9yZGVyaW5nLg0KDQpJZiB5b3Ug
d2FudCB0byBydW4gd2l0aCBzdHJpY3QgcHJpb3JpdHkgb3JkZXJpbmcsIGl0IGNhbiBhbHNvIGJl
IGFjaGlldmVkLCANCmJ1dCBpdCBtYXkgYmUgcXVpdGUgdHJvdWJsZXNvbWUuIFRoZSBkaXJlY3Rv
cnkgc3RydWN0dXJlIHNob3duIGJlbG93DQpjYW4gYWNoaWV2ZSB0aGUgZ29hbC4NCg0KICAgICAg
ICAgICAgIHJvb3QNCiAgICAgICAgICAgLyAgICAgIFwNCiAgIGNncm91cCBBICAgICAgIGNncm91
cCBCDQoocHJvdGVjdD1tYXgpICAgIChwcm90ZWN0PTApDQogICAgICAgICAgICAgICAgLyAgICAg
ICAgICBcDQogICAgICAgICAgIGNncm91cCBDICAgICAgY2dyb3VwIEQNCiAgICAgICAgKHByb3Rl
Y3Q9bWF4KSAgIChwcm90ZWN0PTApDQogICAgICAgICAgICAgICAgICAgICAgIC8gICAgICAgICAg
XA0KICAgICAgICAgICAgICAgICAgY2dyb3VwIEUgICAgICBjZ3JvdXAgRg0KICAgICAgICAgICAg
ICAgKHByb3RlY3Q9bWF4KSAgIChwcm90ZWN0PTApDQoNCk9vbSBraWxsIG9yZGVyOiBGID4gRSA+
IEMgPiBBDQoNCkFzIG1lbnRpb25lZCBlYXJsaWVyLCAicnVubmluZyB3aXRoIHN0cmljdCBwcmlv
cml0eSBvcmRlcmluZyIgbWF5IGJlIA0Kc29tZSBleHRyZW1lIGlzc3VlcywgdGhhdCByZXF1aXJl
cyB0aGUgbWFuYWdlciB0byBtYWtlIGEgY2hvaWNlLg0KDQo+Pg0KPj4gPj4gPkluIHRoaXMgY2Fz
ZSwgd291bGRuJ3QgaXQgYmUgZWFzaWVyIHRvIGp1c3QgdGVsbCB0aGUgT09NIGtpbGxlciB0aGUN
Cj4+ID4+ID5yZWxhdGl2ZSBwcmlvcml0eSBhbW9uZyB0aGUgbWVtY2dzPw0KPj4gPj4gPg0KPj4g
Pj4gPj4NCj4+ID4+ID4+ID5JZiB0aGlzIGFwcHJvYWNoIHdvcmtzIGZvciB5b3UgKG9yIGFueSBv
dGhlciBhdWRpZW5jZSksIHRoYXQncyBncmVhdCwNCj4+ID4+ID4+ID5JIGNhbiBzaGFyZSBtb3Jl
IGRldGFpbHMgYW5kIHBlcmhhcHMgd2UgY2FuIHJlYWNoIHNvbWV0aGluZyB0aGF0IHdlDQo+PiA+
PiA+PiA+Y2FuIGJvdGggdXNlIDopDQo+PiA+PiA+Pg0KPj4gPj4gPj4gSWYgeW91IGhhdmUgYSBn
b29kIGlkZWEsIHBsZWFzZSBzaGFyZSBtb3JlIGRldGFpbHMgb3Igc2hvdyBzb21lIGNvZGUuDQo+
PiA+PiA+PiBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBpdA0KPj4gPj4gPg0KPj4gPj4gPlRo
ZSBjb2RlIHdlIGhhdmUgbmVlZHMgdG8gYmUgcmViYXNlZCBvbnRvIGEgZGlmZmVyZW50IHZlcnNp
b24gYW5kDQo+PiA+PiA+Y2xlYW5lZCB1cCBiZWZvcmUgaXQgY2FuIGJlIHNoYXJlZCwgYnV0IGVz
c2VudGlhbGx5IGl0IGlzIGFzDQo+PiA+PiA+ZGVzY3JpYmVkLg0KPj4gPj4gPg0KPj4gPj4gPihh
KSBBbGwgcHJvY2Vzc2VzIGFuZCBtZW1jZ3Mgc3RhcnQgd2l0aCBhIGRlZmF1bHQgc2NvcmUuDQo+
PiA+PiA+KGIpIFVzZXJzcGFjZSBjYW4gc3BlY2lmeSBzY29yZXMgZm9yIG1lbWNncyBhbmQgcHJv
Y2Vzc2VzLiBBIGhpZ2hlcg0KPj4gPj4gPnNjb3JlIG1lYW5zIGhpZ2hlciBwcmlvcml0eSAoYWth
IGxlc3Mgc2NvcmUgZ2V0cyBraWxsZWQgZmlyc3QpLg0KPj4gPj4gPihjKSBUaGUgT09NIGtpbGxl
ciBlc3NlbnRpYWxseSBsb29rcyBmb3IgdGhlIG1lbWNnIHdpdGggdGhlIGxvd2VzdA0KPj4gPj4g
PnNjb3JlcyB0byBraWxsLCB0aGVuIGFtb25nIHRoaXMgbWVtY2csIGl0IGxvb2tzIGZvciB0aGUg
cHJvY2VzcyB3aXRoDQo+PiA+PiA+dGhlIGxvd2VzdCBzY29yZS4gVGllcyBhcmUgYnJva2VuIGJh
c2VkIG9uIHVzYWdlLCBzbyBlc3NlbnRpYWxseSBpZg0KPj4gPj4gPmFsbCBwcm9jZXNzZXMvbWVt
Y2dzIGhhdmUgdGhlIGRlZmF1bHQgc2NvcmUsIHdlIGZhbGxiYWNrIHRvIHRoZQ0KPj4gPj4gPmN1
cnJlbnQgT09NIGJlaGF2aW9yLg0KPj4gPj4NCj4+ID4+IElmIG1lbW9yeSBvdmVyc29sZCBpcyBz
ZXZlcmUsIGFsbCBwcm9jZXNzZXMgb2YgdGhlIGxvd2VzdCBwcmlvcml0eQ0KPj4gPj4gbWVtY2cg
bWF5IGJlIGtpbGxlZCBiZWZvcmUgc2VsZWN0aW5nIG90aGVyIG1lbWNnIHByb2Nlc3Nlcy4NCj4+
ID4+IElmIHRoZXJlIGFyZSAxMDAwIHByb2Nlc3NlcyB3aXRoIGFsbW9zdCB6ZXJvIG1lbW9yeSB1
c2FnZSBpbg0KPj4gPj4gdGhlIGxvd2VzdCBwcmlvcml0eSBtZW1jZywgMTAwMCBpbnZhbGlkIGtp
bGwgZXZlbnRzIG1heSBvY2N1ci4NCj4+ID4+IFRvIGF2b2lkIHRoaXMgc2l0dWF0aW9uLCBldmVu
IGZvciB0aGUgbG93ZXN0IHByaW9yaXR5IG1lbWNnLA0KPj4gPj4gSSB3aWxsIGxlYXZlIGhpbSBh
IHZlcnkgc21hbGwgb29tLnByb3RlY3QgcXVvdGEuDQo+PiA+DQo+PiA+SSBjaGVja2VkIGludGVy
bmFsbHksIGFuZCB0aGlzIGlzIGluZGVlZCBzb21ldGhpbmcgdGhhdCB3ZSBzZWUgZnJvbQ0KPj4g
PnRpbWUgdG8gdGltZS4gV2UgdHJ5IHRvIGF2b2lkIHRoYXQgd2l0aCB1c2Vyc3BhY2UgT09NIGtp
bGxpbmcsIGJ1dA0KPj4gPml0J3Mgbm90IDEwMCUgZWZmZWN0aXZlLg0KPj4gPg0KPj4gPj4NCj4+
ID4+IElmIGZhY2VkIHdpdGggdHdvIG1lbWNncyB3aXRoIHRoZSBzYW1lIHRvdGFsIG1lbW9yeSB1
c2FnZSBhbmQNCj4+ID4+IHByaW9yaXR5LCBtZW1jZyBBIGhhcyBtb3JlIHByb2Nlc3NlcyBidXQg
bGVzcyBtZW1vcnkgdXNhZ2UgcGVyDQo+PiA+PiBzaW5nbGUgcHJvY2VzcywgYW5kIG1lbWNnIEIg
aGFzIGZld2VyIHByb2Nlc3NlcyBidXQgbW9yZQ0KPj4gPj4gbWVtb3J5IHVzYWdlIHBlciBzaW5n
bGUgcHJvY2VzcywgdGhlbiB3aGVuIE9PTSBvY2N1cnMsIHRoZQ0KPj4gPj4gcHJvY2Vzc2VzIGlu
IG1lbWNnIEIgbWF5IGNvbnRpbnVlIHRvIGJlIGtpbGxlZCB1bnRpbCBhbGwgcHJvY2Vzc2VzDQo+
PiA+PiBpbiBtZW1jZyBCIGFyZSBraWxsZWQsIHdoaWNoIGlzIHVuZmFpciB0byBtZW1jZyBCIGJl
Y2F1c2UgbWVtY2cgQQ0KPj4gPj4gYWxzbyBvY2N1cGllcyBhIGxhcmdlIGFtb3VudCBvZiBtZW1v
cnkuDQo+PiA+DQo+PiA+SSBiZWxpZXZlIGluIHRoaXMgY2FzZSB3ZSB3aWxsIGtpbGwgb25lIHBy
b2Nlc3MgaW4gbWVtY2cgQiwgdGhlbiB0aGUNCj4+ID51c2FnZSBvZiBtZW1jZyBBIHdpbGwgYmVj
b21lIGhpZ2hlciwgc28gd2Ugd2lsbCBwaWNrIGEgcHJvY2VzcyBmcm9tDQo+PiA+bWVtY2cgQSBu
ZXh0Lg0KPj4NCj4+IElmIHRoZXJlIGlzIG9ubHkgb25lIHByb2Nlc3MgaW4gbWVtY2cgQSBhbmQg
aXRzIG1lbW9yeSB1c2FnZSBpcyBoaWdoZXINCj4+IHRoYW4gYW55IG90aGVyIHByb2Nlc3MgaW4g
bWVtY2cgQiwgYnV0IHRoZSB0b3RhbCBtZW1vcnkgdXNhZ2Ugb2YNCj4+IG1lbWNnIEEgaXMgbG93
ZXIgdGhhbiB0aGF0IG9mIG1lbWNnIEIuIEluIHRoaXMgY2FzZSwgaWYgdGhlIE9PTS1raWxsZXIN
Cj4+IHN0aWxsIGNob29zZXMgdGhlIHByb2Nlc3MgaW4gbWVtY2cgQS4gaXQgbWF5IGJlIHVuZmFp
ciB0byBtZW1jZyBBLg0KPj4NCj4+ID4+IERvc2UgeW91ciBhcHByb2FjaCBoYXZlIHRoZXNlIGlz
c3Vlcz8gS2lsbGluZyBwcm9jZXNzZXMgaW4gYQ0KPj4gPj4gdXNlci1kZWZpbmVkIHByaW9yaXR5
IGlzIGluZGVlZCBlYXNpZXIgYW5kIGNhbiB3b3JrIHdlbGwgaW4gbW9zdCBjYXNlcywNCj4+ID4+
IGJ1dCBJIGhhdmUgYmVlbiB0cnlpbmcgdG8gc29sdmUgdGhlIGNhc2VzIHRoYXQgaXQgY2Fubm90
IGNvdmVyLg0KPj4gPg0KPj4gPlRoZSBmaXJzdCBpc3N1ZSBpcyByZWxhdGFibGUgd2l0aCBvdXIg
YXBwcm9hY2guIExldCBtZSBkaWcgbW9yZSBpbmZvDQo+PiA+ZnJvbSBvdXIgaW50ZXJuYWwgdGVh
bXMgYW5kIGdldCBiYWNrIHRvIHlvdSB3aXRoIG1vcmUgZGV0YWlscy4NCg0KLS0NClRoYW5rcyBm
b3IgeW91ciBjb21tZW50IQ0KY2hlbmdrYWl0YW8NCg0KDQo=
