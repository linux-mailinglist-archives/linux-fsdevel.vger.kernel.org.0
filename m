Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283706506B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 04:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiLSDQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 22:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSDQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 22:16:39 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 414E15FDF;
        Sun, 18 Dec 2022 19:16:36 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 2247AB0128817;
        Mon, 19 Dec 2022 11:16:34 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 19 Dec 2022 11:16:33 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Mon, 19 Dec 2022 11:16:33 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     chengkaitao <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Thread-Topic: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Thread-Index: AQHZCrfAdhr5zYTMtke9YS08C4BFfq5jExWAgACNdAD//34EAIAA6LeA//9+mQCAAXznAP//sVGAAEToU4ABt/oBgA==
Date:   Mon, 19 Dec 2022 03:16:33 +0000
Message-ID: <BE56B09A-7C70-4152-B4D4-B8433A37465D@didiglobal.com>
In-Reply-To: <395B1998-38A9-4A68-96F8-6EDF44686231@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5521E1617DBDF49ADF15A25DA43BFDA@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTWljaGFsIEhvY2tvLA0KTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkuDQoNCu+7v09u
IDIwMjIvMTIvMTAgMTc6MTjvvIzigJznqIvlnrLmtpsgQ2hlbmdrYWl0YW8gQ2hlbmfigJ08Y2hl
bmdrYWl0YW9AZGlkaWdsb2JhbC5jb20gPG1haWx0bzpjaGVuZ2thaXRhb0BkaWRpZ2xvYmFsLmNv
bT4+IHdyb3RlOg0KQXQgMjAyMi0xMi0wOSAxNjoyNTozNywgIk1pY2hhbCBIb2NrbyIgPG1ob2Nr
b0BzdXNlLmNvbSA8bWFpbHRvOm1ob2Nrb0BzdXNlLmNvbT4+IHdyb3RlOg0KPk9uIEZyaSAwOS0x
Mi0yMiAwNTowNzoxNSwg56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5nIHdyb3RlOg0KPj4gQXQg
MjAyMi0xMi0wOCAyMjoyMzo1NiwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbSA8bWFp
bHRvOm1ob2Nrb0BzdXNlLmNvbT4+IHdyb3RlOg0KPlsuLi5dDQo+PiA+b29tIGtpbGxlciBpcyBh
IG1lbW9yeSByZWNsYWltIG9mIHRoZSBsYXN0IHJlc29ydC4gU28geWVzLCB0aGVyZSBpcyBzb21l
DQo+PiA+ZGlmZmVyZW5jZSBidXQgZnVuZGFtZW50YWxseSBpdCBpcyBhYm91dCByZWxlYXNpbmcg
c29tZSBtZW1vcnkuIEFuZCBsb25nDQo+PiA+dGVybSB3ZSBoYXZlIGxlYXJuZWQgdGhhdCB0aGUg
bW9yZSBjbGV2ZXIgaXQgdHJpZXMgdG8gYmUgdGhlIG1vcmUgbGlrZWx5DQo+PiA+Y29ybmVyIGNh
c2VzIGNhbiBoYXBwZW4uIEl0IGlzIHNpbXBseSBpbXBvc3NpYmxlIHRvIGtub3cgdGhlIGJlc3QN
Cj4+ID5jYW5kaWRhdGUgc28gdGhpcyBpcyBhIGp1c3QgYSBiZXN0IGVmZm9ydC4gV2UgdHJ5IHRv
IGFpbSBmb3INCj4+ID5wcmVkaWN0YWJpbGl0eSBhdCBsZWFzdC4NCj4+IA0KPj4gSXMgdGhlIGN1
cnJlbnQgb29tX3Njb3JlIHN0cmF0ZWd5IHByZWRpY3RhYmxlPyBJIGRvbid0IHRoaW5rIHNvLiBU
aGUgc2NvcmVfYWRqIA0KPj4gaGFzIGJyb2tlbiB0aGUgcHJlZGljdGFiaWxpdHkgb2Ygb29tX3Nj
b3JlIChpdCBpcyBubyBsb25nZXIgc2ltcGx5IGtpbGxpbmcgdGhlIA0KPj4gcHJvY2VzcyB0aGF0
IHVzZXMgdGhlIG1vc3QgbWVtcykuDQo+DQo+b29tX3Njb3JlIGFzIHJlcG9ydGVkIHRvIHRoZSB1
c2Vyc3BhY2UgYWxyZWFkeSBjb25zaWRlcnMgb29tX3Njb3JlX2Fkag0KPndoaWNoIG1lYW5zIHRo
YXQgeW91IGNhbiBjb21wYXJlIHByb2Nlc3NlcyBhbmQgZ2V0IGEgcmVhc29uYWJsZSBndWVzcw0K
PndoYXQgd291bGQgYmUgdGhlIGN1cnJlbnQgb29tX3ZpY3RpbS4gVGhlcmUgaXMgYSBjZXJ0YWlu
IGZ1enogbGV2ZWwNCj5iZWNhdXNlIHRoaXMgaXMgbm90IGF0b21pYyBhbmQgYWxzbyB0aGVyZSBp
cyBubyBjbGVhciBjYW5kaWRhdGUgd2hlbg0KPm11bHRpcGxlIHByb2Nlc3NlcyBoYXZlIGVxdWFs
IHNjb3JlLiANCg0KTXVsdGlwbGUgcHJvY2Vzc2VzIGhhdmUgdGhlIHNhbWUgc2NvcmUsIHdoaWNo
IG1lYW5zIGl0IGlzIHJlYXNvbmFibGUgdG8ga2lsbCANCmFueSBvbmUuIFdoeSBtdXN0IHdlIGRl
dGVybWluZSB3aGljaCBvbmUgaXM/DQoNCj4gU28geWVzLCBpdCBpcyBub3QgMTAwJSBwcmVkaWN0
YWJsZS4NCj5tZW1vcnkucmVjbGFpbSBhcyB5b3UgcHJvcG9zZSBkb2Vzbid0IGNoYW5nZSB0aGF0
IHRob3VnaC4NCj4NClRoaXMgc2NoZW1lIGlzIHRvIGdpdmUgdGhlIGRlY2lzaW9uIHBvd2VyIG9m
IHRoZSBjYW5kaWRhdGUgdG8gdGhlIHVzZXIuIA0KVGhlIHVzZXIncyBiZWhhdmlvciBpcyByYW5k
b20uIEkgdGhpbmsgaXQgaXMgaW1wb3NzaWJsZSB0byAxMDAlIHByZWRpY3QgDQphIHJhbmRvbSBl
dmVudC4NCg0KSXMgaXQgcmVhbGx5IG5lY2Vzc2FyeSB0byBtYWtlIGV2ZXJ5dGhpbmcgMTAwJSBw
cmVkaWN0YWJsZT8gSnVzdCBhcyB3ZSBjYW4ndCANCmFjY3VyYXRlbHkgcHJlZGljdCB3aGljaCBj
Z3JvdXAgd2lsbCBhY2Nlc3MgdGhlIHBhZ2UgY2FjaGUgZnJlcXVlbnRseSwgDQp3ZSBjYW4ndCBh
Y2N1cmF0ZWx5IHByZWRpY3Qgd2hldGhlciB0aGUgbWVtb3J5IGlzIGhvdCBvciBjb2xkLiBUaGVz
ZSANCnN0cmF0ZWdpZXMgYXJlIGZ1enp5LCBidXQgd2UgY2FuJ3QgZGVueSB0aGVpciByYXRpb25h
bGl0eS4NCg0KPklzIG9vbV9zY29yZV9hZGogYSBnb29kIGludGVyZmFjZT8gTm8sIG5vdCByZWFs
bHkuIElmIEkgY291bGQgZ28gYmFjayBpbg0KPnRpbWUgSSB3b3VsZCBuYWNrIGl0IGJ1dCBoZXJl
IHdlIGFyZS4gV2UgaGF2ZSBhbiBpbnRlcmZhY2UgdGhhdA0KPnByb21pc2VzIHF1aXRlIG11Y2gg
YnV0IGVzc2VudGlhbGx5IGl0IG9ubHkgYWxsb3dzIHR3byB1c2VjYXNlcw0KPihPT01fU0NPUkVf
QURKX01JTiwgT09NX1NDT1JFX0FESl9NQVgpIHJlbGlhYmx5LiBFdmVyeXRoaW5nIGluIGJldHdl
ZW4NCj5pcyBjbHVtc3kgYXQgYmVzdCBiZWNhdXNlIGEgcmVhbCB1c2VyIHNwYWNlIG9vbSBwb2xp
Y3kgd291bGQgcmVxdWlyZSB0bw0KPnJlLWV2YWx1YXRlIHRoZSB3aG9sZSBvb20gZG9tYWluIChi
ZSBpdCBnbG9iYWwgb3IgbWVtY2cgb29tKSBhcyB0aGUNCj5tZW1vcnkgY29uc3VtcHRpb24gZXZv
bHZlcyBvdmVyIHRpbWUuIEkgYW0gcmVhbGx5IHdvcnJpZWQgdGhhdCB5b3VyDQo+bWVtb3J5Lm9v
bS5wcm90ZWN0aW9uIGRpcmVjdHMgYSB2ZXJ5IHNpbWlsYXIgdHJhamVjdG9yeSBiZWNhdXNlDQo+
cHJvdGVjdGlvbiByZWFsbHkgbmVlZHMgdG8gY29uc2lkZXIgb3RoZXIgbWVtY2dzIHRvIGJhbGFu
Y2UgcHJvcGVybHkuDQo+DQpUaGUgc2NvcmVfYWRqIGlzIGFuIGludGVyZmFjZSB0aGF0IHByb21p
c2VzIHF1aXRlIG11Y2guIEkgdGhpbmsgdGhlIHJlYXNvbiANCndoeSBvbmx5IHR3byB1c2VjYXNl
cyAoT09NX1NDT1JFX0FESl9NSU4sIE9PTV9TQ09SRV9BREpfTUFYKSANCmFyZSByZWxpYWJsZSBp
cyB0aGF0IHVzZXIgY2Fubm90IGV2YWx1YXRlIHRoZSBwcmlvcml0eSBsZXZlbCBvZiBhbGwgcHJv
Y2Vzc2VzIGluIA0KdGhlIHBoeXNpY2FsIG1hY2hpbmUuIElmIHRoZXJlIGlzIGEgYWdlbnQgcHJv
Y2VzcyBpbiB0aGUgcGh5c2ljYWwgbWFjaGluZSwgDQp3aGljaCBjYW4gYWNjdXJhdGVseSBkaXZp
ZGUgYWxsIHRoZSB1c2VyIHByb2Nlc3NlcyBvZiB0aGUgcGh5c2ljYWwgbWFjaGluZSANCmludG8g
ZGlmZmVyZW50IGxldmVscywgb3RoZXIgdXNlY2FzZXMgb2YgdGhlIHNjb3JlX2FkaiB3aWxsIGJl
IHdlbGwgYXBwbGllZCwgDQpidXQgaXQgaXMgYWxtb3N0IGltcG9zc2libGUgdG8gYWNoaWV2ZSBp
biByZWFsIGxpZmUuDQoNClRoZXJlIGlzIGFuIGV4YW1wbGUgb2YgdGhlIHByYWN0aWNhbCBhcHBs
aWNhdGlvbg0KS3ViZWxldCB3aWxsIHNldCB0aGUgc2NvcmVfYWRqIG9mIGRvY2tlcmluaXQgcHJv
Y2VzcyBvZiBhbGwgYnVyc3RhYmxlciBjb250YWluZXJzLCANCnRoZSBzZXR0aW5nIHNwZWNpZmlj
YXRpb24gZm9sbG93cyB0aGUgZm9sbG93aW5nIGZvcm11bGEsDQoNCnNjb3JlX2FkaiA9IDEwMDAg
LSByZXF1ZXN0ICogMTAwMCAvIHRvdGFscGFnZXMNCihyZXF1ZXN0ID0gIkZpeGVkIGNvZWZmaWNp
ZW50IiAqICJtZW1vcnkubWF4IikNCg0KQmVjYXVzZSBrdWJlbGV0IGhhcyBhIGNsZWFyIHVuZGVy
c3RhbmRpbmcgb2YgYWxsIHRoZSBjb250YWluZXIgbWVtb3J5IGJlaGF2aW9yIA0KYXR0cmlidXRl
cyBpbiB0aGUgcGh5c2ljYWwgbWFjaGluZSwgaXQgY2FuIHVzZSBtb3JlIHNjb3JlX2FkaiB1c2Vj
YXNlcy4gVGhlIA0KYWR2YW50YWdlIG9mIHRoZSBvb20ucHJvdHJjdCBpcyB0aGF0IHVzZXJzIGRv
IG5vdCBuZWVkIHRvIGhhdmUgYSBjbGVhciB1bmRlcnN0YW5kaW5nIA0Kb2YgYWxsIHRoZSBwcm9j
ZXNzZXMgaW4gdGhlIHBoeXNpY2FsIG1hY2hpbmUsIHRoZXkgb25seSBuZWVkIHRvIGhhdmUgYSBj
bGVhciANCnVuZGVyc3RhbmRpbmcgb2YgYWxsIHRoZSBwcm9jZXNzZXMgaW50IGxvY2FsIGNncm91
cC4gSSB0aGluayB0aGUgcmVxdWlyZW1lbnQgaXMgdmVyeSANCmVhc3kgdG8gYWNoaWV2ZS4NCg0K
PlsuLi5dDQo+DQo+PiA+IEJ1dCBJIGFtIHJlYWxseSBvcGVuDQo+PiA+dG8gYmUgY29udmluY2Vk
IG90aGVyd2lzZSBhbmQgdGhpcyBpcyBpbiBmYWN0IHdoYXQgSSBoYXZlIGJlZW4gYXNraW5nDQo+
PiA+Zm9yIHNpbmNlIHRoZSBiZWdpbm5pbmcuIEkgd291bGQgbG92ZSB0byBzZWUgc29tZSBleGFt
cGxlcyBvbiB0aGUNCj4+ID5yZWFzb25hYmxlIGNvbmZpZ3VyYXRpb24gZm9yIGEgcHJhY3RpY2Fs
IHVzZWNhc2UuDQo+PiANCj4+IEhlcmUgaXMgYSBzaW1wbGUgZXhhbXBsZS4gSW4gYSBkb2NrZXIg
Y29udGFpbmVyLCB1c2VycyBjYW4gZGl2aWRlIGFsbCBwcm9jZXNzZXMgDQo+PiBpbnRvIHR3byBj
YXRlZ29yaWVzIChpbXBvcnRhbnQgYW5kIG5vcm1hbCksIGFuZCBwdXQgdGhlbSBpbiBkaWZmZXJl
bnQgY2dyb3Vwcy4gDQo+PiBPbmUgY2dyb3VwJ3Mgb29tLnByb3RlY3QgaXMgc2V0IHRvICJtYXgi
LCB0aGUgb3RoZXIgaXMgc2V0IHRvICIwIi4gSW4gdGhpcyB3YXksIA0KPj4gaW1wb3J0YW50IHBy
b2Nlc3NlcyBpbiB0aGUgY29udGFpbmVyIGNhbiBiZSBwcm90ZWN0ZWQuDQo+DQo+VGhhdCBpcyBl
ZmZlY3RpdmVsbHkgb29tX3Njb3JlX2FkaiA9IE9PTV9TQ09SRV9BREpfTUlOIC0gMSB0byBhbGwN
Cj5wcm9jZXNzZXMgaW4gdGhlIGltcG9ydGFudCBncm91cC4gSSB3b3VsZCBhcmd1ZSB5b3UgY2Fu
IGFjaGlldmUgYSB2ZXJ5DQo+c2ltaWxhciByZXN1bHQgYnkgdGhlIHByb2Nlc3MgbGF1bmNoZXIg
dG8gc2V0IHRoZSBvb21fc2NvcmVfYWRqIGFuZA0KPmluaGVyaXQgaXQgdG8gYWxsIHByb2Nlc3Nl
cyBpbiB0aGF0IGltcG9ydGFudCBjb250YWluZXIuIFlvdSBkbyBub3QgbmVlZA0KPmFueSBtZW1j
ZyB0dW5hYmxlIGZvciB0aGF0LiANCg0KWW91ciBtZXRob2QgaXMgbm90IGZlYXNpYmxlLiBQbGVh
c2UgcmVmZXIgdG8gdGhlIHByZXZpb3VzIGVtYWlsDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1tbS9FNUE1QkNDMy00NjBFLTRFODEtOEREMy04OEI0QTI4NjgyODVAZGlkaWdsb2JhbC5j
b20gPG1haWx0bzpFNUE1QkNDMy00NjBFLTRFODEtOEREMy04OEI0QTI4NjgyODVAZGlkaWdsb2Jh
bC5jb20+Lw0KKiB1c2VjYXNlcyAxOiB1c2VycyBzYXkgdGhhdCB0aGV5IHdhbnQgdG8gcHJvdGVj
dCBhbiBpbXBvcnRhbnQgcHJvY2VzcyANCiogd2l0aCBoaWdoIG1lbW9yeSBjb25zdW1wdGlvbiBm
cm9tIGJlaW5nIGtpbGxlZCBieSB0aGUgb29tIGluIGNhc2UgDQoqIG9mIGRvY2tlciBjb250YWlu
ZXIgZmFpbHVyZSwgc28gYXMgdG8gcmV0YWluIG1vcmUgY3JpdGljYWwgb24tc2l0ZSANCiogaW5m
b3JtYXRpb24gb3IgYSBzZWxmIHJlY292ZXJ5IG1lY2hhbmlzbS4gQXQgdGhpcyB0aW1lLCB0aGV5
IHN1Z2dlc3QgDQoqIHNldHRpbmcgdGhlIHNjb3JlX2FkaiBvZiB0aGlzIHByb2Nlc3MgdG8gLTEw
MDAsIGJ1dCBJIGRvbid0IGFncmVlIHdpdGggDQoqIGl0LCBiZWNhdXNlIHRoZSBkb2NrZXIgY29u
dGFpbmVyIGlzIG5vdCBpbXBvcnRhbnQgdG8gb3RoZXIgZG9ja2VyIA0KKiBjb250YWluZXJzIG9m
IHRoZSBzYW1lIHBoeXNpY2FsIG1hY2hpbmUuIElmIHNjb3JlX2FkaiBvZiB0aGUgcHJvY2VzcyAN
CiogaXMgc2V0IHRvIC0xMDAwLCB0aGUgcHJvYmFiaWxpdHkgb2Ygb29tIGluIG90aGVyIGNvbnRh
aW5lciBwcm9jZXNzZXMgd2lsbCANCiogaW5jcmVhc2UuDQoNCj5JIGFtIHJlYWxseSBtdWNoIG1v
cmUgaW50ZXJlc3RlZCBpbiBleGFtcGxlcw0KPndoZW4gdGhlIHByb3RlY3Rpb24gaXMgdG8gYmUg
ZmluZSB0dW5lZC4NCi0tIA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQhDQpjaGVuZ2thaXRhbw0K
DQoNCg0KDQoNCg0KDQo=
