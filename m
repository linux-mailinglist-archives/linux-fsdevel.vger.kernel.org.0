Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4812870621C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEQIBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjEQIBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 04:01:31 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 08AD4E6D;
        Wed, 17 May 2023 01:01:23 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.64.15])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 05997B005E613;
        Wed, 17 May 2023 16:01:21 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY01-ACTMBX-05.didichuxing.com (10.79.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 16:01:20 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Wed, 17 May 2023 16:01:20 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.64.15
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
Thread-Index: AQHZiG6QYuA8nkfOmkSWHm0JCEvXOa9dgyoAgACXf4A=
Date:   Wed, 17 May 2023 08:01:20 +0000
Message-ID: <09A746CC-E38D-4ECA-B0F4-862EC6229A0F@didiglobal.com>
In-Reply-To: <CAJD7tkYPGwAFo0mrhq5twsVquwFwkhOyPwsZJtECw-5HAXtQrg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <13CC8B0707FBE64DB87317BF1BE42440@didichuxing.com>
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

QXQgMjAyMy0wNS0xNyAxNDo1OTowNiwgIllvc3J5IEFobWVkIiA8eW9zcnlhaG1lZEBnb29nbGUu
Y29tPiB3cm90ZToNCj4rRGF2aWQgUmllbnRqZXMNCj4NCj5PbiBUdWUsIE1heSAxNiwgMjAyMyBh
dCA4OjIw4oCvUE0gY2hlbmdrYWl0YW8gPGNoZW5na2FpdGFvQGRpZGlnbG9iYWwuY29tPiB3cm90
ZToNCj4+DQo+PiBFc3RhYmxpc2ggYSBuZXcgT09NIHNjb3JlIGFsZ29yaXRobSwgc3VwcG9ydHMg
dGhlIGNncm91cCBsZXZlbCBPT00NCj4+IHByb3RlY3Rpb24gbWVjaGFuaXNtLiBXaGVuIGFuIGds
b2JhbC9tZW1jZyBvb20gZXZlbnQgb2NjdXJzLCB3ZSB0cmVhdA0KPj4gYWxsIHByb2Nlc3NlcyBp
biB0aGUgY2dyb3VwIGFzIGEgd2hvbGUsIGFuZCBPT00ga2lsbGVycyBuZWVkIHRvIHNlbGVjdA0K
Pj4gdGhlIHByb2Nlc3MgdG8ga2lsbCBiYXNlZCBvbiB0aGUgcHJvdGVjdGlvbiBxdW90YSBvZiB0
aGUgY2dyb3VwLg0KPj4NCj4NCj5QZXJoYXBzIHRoaXMgaXMgb25seSBzbGlnaHRseSByZWxldmFu
dCwgYnV0IGF0IEdvb2dsZSB3ZSBkbyBoYXZlIGENCj5kaWZmZXJlbnQgcGVyLW1lbWNnIGFwcHJv
YWNoIHRvIHByb3RlY3QgZnJvbSBPT00ga2lsbHMsIG9yIG1vcmUNCj5zcGVjaWZpY2FsbHkgdGVs
bCB0aGUga2VybmVsIGhvdyB3ZSB3b3VsZCBsaWtlIHRoZSBPT00ga2lsbGVyIHRvDQo+YmVoYXZl
Lg0KPg0KPldlIGRlZmluZSBhbiBpbnRlcmZhY2UgY2FsbGVkIG1lbW9yeS5vb21fc2NvcmVfYmFk
bmVzcywgYW5kIHdlIGFsc28NCj5hbGxvdyBpdCB0byBiZSBzcGVjaWZpZWQgcGVyLXByb2Nlc3Mg
dGhyb3VnaCBhIHByb2NmcyBpbnRlcmZhY2UsDQo+c2ltaWxhciB0byBvb21fc2NvcmVfYWRqLg0K
Pg0KPlRoZXNlIHNjb3JlcyBlc3NlbnRpYWxseSB0ZWxsIHRoZSBPT00ga2lsbGVyIHRoZSBvcmRl
ciBpbiB3aGljaCB3ZQ0KPnByZWZlciBtZW1jZ3MgdG8gYmUgT09NJ2QsIGFuZCB0aGUgb3JkZXIg
aW4gd2hpY2ggd2Ugd2FudCBwcm9jZXNzZXMgaW4NCj50aGUgbWVtY2cgdG8gYmUgT09NJ2QuIEJ5
IGRlZmF1bHQsIGFsbCBwcm9jZXNzZXMgYW5kIG1lbWNncyBzdGFydCB3aXRoDQo+dGhlIHNhbWUg
c2NvcmUuIFRpZXMgYXJlIGJyb2tlbiBiYXNlZCBvbiB0aGUgcnNzIG9mIHRoZSBwcm9jZXNzIG9y
IHRoZQ0KPnVzYWdlIG9mIHRoZSBtZW1jZyAocHJlZmVyIHRvIGtpbGwgdGhlIHByb2Nlc3MvbWVt
Y2cgdGhhdCB3aWxsIGZyZWUNCj5tb3JlIG1lbW9yeSkgLS0gc2ltaWxhciB0byB0aGUgY3VycmVu
dCBPT00ga2lsbGVyLg0KDQpUaGFuayB5b3UgZm9yIHByb3ZpZGluZyBhIG5ldyBhcHBsaWNhdGlv
biBzY2VuYXJpby4gWW91IGhhdmUgZGVzY3JpYmVkIGENCm5ldyBwZXItbWVtY2cgYXBwcm9hY2gs
IGJ1dCBhIHNpbXBsZSBpbnRyb2R1Y3Rpb24gY2Fubm90IGV4cGxhaW4gdGhlDQpkZXRhaWxzIG9m
IHlvdXIgYXBwcm9hY2ggY2xlYXJseS4gSWYgeW91IGNvdWxkIGNvbXBhcmUgYW5kIGFuYWx5emUg
bXkNCnBhdGNoZXMgZm9yIHBvc3NpYmxlIGRlZmVjdHMsIG9yIGlmIHlvdXIgbmV3IGFwcHJvYWNo
IGhhcyBhZHZhbnRhZ2VzDQp0aGF0IG15IHBhdGNoZXMgZG8gbm90IGhhdmUsIEkgd291bGQgZ3Jl
YXRseSBhcHByZWNpYXRlIGl0Lg0KDQo+VGhpcyBoYXMgYmVlbiBicm91Z2h0IHVwIGJlZm9yZSBp
biBvdGhlciBkaXNjdXNzaW9ucyB3aXRob3V0IG11Y2gNCj5pbnRlcmVzdCBbMV0sIGJ1dCBqdXN0
IHRob3VnaHQgaXQgbWF5IGJlIHJlbGV2YW50IGhlcmUuDQo+DQo+WzFdaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9DQUhTOGl6TjNlajFtcVVwbk5ROGMtMUJ4NUVlTzdxNU5Pa2gwcXJZXzRQ
THFjOHJrSEFAbWFpbC5nbWFpbC5jb20vI3QNCg0KLS0gDQpUaGFua3MgZm9yIHlvdXIgY29tbWVu
dCENCmNoZW5na2FpdGFvDQoNCg==
