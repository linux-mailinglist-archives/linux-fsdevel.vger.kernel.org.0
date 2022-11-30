Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD563D732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiK3NvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 08:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiK3NvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:51:23 -0500
X-Greylist: delayed 1084 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 05:51:19 PST
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 33EB332BA8;
        Wed, 30 Nov 2022 05:51:18 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 4D2E0B00DB009;
        Wed, 30 Nov 2022 21:25:07 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 30 Nov 2022 21:25:06 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Wed, 30 Nov 2022 21:25:06 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Tao pilgrim <pilgrimtao@gmail.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "ran.xiaokai@zte.com.cn" <ran.xiaokai@zte.com.cn>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Topic: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5W40KAgACRsQA=
Date:   Wed, 30 Nov 2022 13:25:06 +0000
Message-ID: <9F11BDDA-D9B6-4F61-9EAA-9B959BD4AE0A@didiglobal.com>
In-Reply-To: <Y4dP+3VEYl/YUfK1@debian.me>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB81BB2AA69C24198FC73EC4273842D@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjAyMi8xMS8zMCAyMDo0M++8jOKAnEJhZ2FzIFNhbmpheWHigJ08YmFnYXNkb3RtZUBnbWFp
bC5jb20+IHdyb3RlOg0KPiBPbiBXZWQsIE5vdiAzMCwgMjAyMiBhdCAwNzozMzowMVBNICswODAw
LCBUYW8gcGlsZ3JpbSB3cm90ZToNCj4gPiBPbiBXZWQsIE5vdiAzMCwgMjAyMiBhdCA0OjQxIFBN
IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4g
PiBPbiAxMS8zMC8yMiAxNDowMSwgY2hlbmdrYWl0YW8gd3JvdGU6DQo+ID4gPiA+IEZyb206IGNo
ZW5na2FpdGFvIDxwaWxncmltdGFvQGdtYWlsLmNvbT4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBZ
aWtlcyEgQW5vdGhlciBwYXRjaCBmcm9tIFpURSBndXlzLg0KPiA+ID4NCj4gPiA+IEknbSBzdXNw
aWNpb3VzIHRvIHBhdGNoZXMgc2VudCBmcm9tIHRoZW0gZHVlIHRvIGJhZCByZXB1dGF0aW9uIHdp
dGgNCj4gPiA+IGtlcm5lbCBkZXZlbG9wbWVudCBjb21tdW5pdHkuIEZpcnN0LCB0aGV5IHNlbnQg
YWxsIHBhdGNoZXMgdmlhDQo+ID4gPiBjZ2VsLnp0ZUBnbWFpbC5jb20gKGxpc3RlZCBpbiBDYykg
YnV0IEdyZWcgY2FuJ3Qgc3VyZSB0aGVzZSBhcmUgcmVhbGx5DQo+ID4gPiBzZW50IGZyb20gdGhl
bSAoWzFdICYgWzJdKS4gVGhlbiB0aGV5IHRyaWVkIHRvIHdvcmthcm91bmQgYnkgc2VuZGluZw0K
PiA+ID4gZnJvbSB0aGVpciBwZXJzb25hbCBHbWFpbCBhY2NvdW50cywgYWdhaW4gd2l0aCBzYW1l
IHJlc3BvbnNlIGZyb20gaGltDQo+ID4gPiBbM10uIEFuZCBmaW5hbGx5IHRoZXkgc2VudCBzcG9v
ZmVkIGVtYWlscyAoYXMgaGUgcG9pbnRlZCBvdXQgaW4gWzRdKSAtDQo+ID4gPiB0aGV5IHByZXRl
bmQgdG8gc2VuZCBmcm9tIFpURSBkb21haW4gYnV0IGFjdHVhbGx5IHNlbnQgZnJvbSB0aGVpcg0K
PiA+ID4gZGlmZmVyZW50IGRvbWFpbiAoc2VlIHJhdyBtZXNzYWdlIGFuZCBsb29rIGZvciBYLUdv
b2dsZS1PcmlnaW5hbC1Gcm9tOg0KPiA+ID4gaGVhZGVyLg0KPiA+DQo+ID4gSGkgQmFnYXMgU2Fu
amF5YSwNCj4gPg0KPiA+IEknbSBub3QgYW4gZW1wbG95ZWUgb2YgWlRFLCBqdXN0IGFuIG9yZGlu
YXJ5IGRldmVsb3Blci4gSSByZWFsbHkgZG9uJ3Qga25vdw0KPiA+IGFsbCB0aGUgZGV0YWlscyBh
Ym91dCBjb21tdW5pdHkgYW5kIFpURSwgVGhlIHJlYXNvbiB3aHkgSSBjYyBjZ2VsLnp0ZUBnbWFp
bC5jb20NCj4gPiBpcyBiZWNhdXNlIHRoZSBvdXRwdXQgb2YgdGhlIHNjcmlwdCA8Z2V0X21haW50
YWluZXIucGw+IGhhcyB0aGUNCj4gPiBhZGRyZXNzIDxjZ2VsLnp0ZUBnbWFpbC5jb20+Lg0KPiA+
DQo+ID4gSWYgdGhlcmUgaXMgYW55IGVycm9yIGluIHRoZSBmb3JtYXQgb2YgdGhlIGVtYWlsLCBJ
IHdpbGwgdHJ5IG15IGJlc3QNCj4gPiB0byBjb3JyZWN0IGl0Lg0KPiA+DQo+DQo+IE9LLCB0aGFu
a3MgZm9yIGNsYXJpZmljYXRpb24uIEF0IGZpcnN0IEkgdGhvdWdodCB5b3Ugd2VyZSBaVEUgZ3V5
cy4NCj4gU29ycnkgZm9yIGluY29udmVuaWVuY2UuDQo+IA0KPiBOb3cgSSBhc2s6IHdoeSBkbyB5
b3VyIGVtYWlsIHNlZW0gc3Bvb2ZlZCAoc2VuZGluZyBmcm9tIHlvdXIgZ21haWwNCj4gYWNjb3Vu
dCBidXQgdGhlcmUgaXMgZXh0cmEgZ21haWwtc3BlY2lmaWMgaGVhZGVyIHRoYXQgbWFrZXMgeW91
IGxpa2UNCj4gInNlbmRpbmciIGZyb20geW91ciBjb3Jwb3JhdGUgZW1haWwgYWRkcmVzcz8gV291
bGRuJ3QgaXQgYmUgbmljZSAoYW5kDQo+IGFwcHJvcHJpYXRlKSBpZiB5b3UgY2FuIHNlbmQgYW5k
IHJlY2VpdmUgZW1haWwgd2l0aCB0aGUgbGF0dGVyIGFkZHJlc3MNCj4gaW5zdGVhZD8NCj4NCkl0
IG1heSBiZSBjYXVzZWQgYnkgbXkgcHJldmlvdXMgaGFiaXRzLg0KVGhhbmtzIGZvciB5b3VyIGFk
dmljZS4gSSdsbCBkbyBpdC4NCg0KVGhhbmtzLg0KLS0gDQo+IEFuIG9sZCBtYW4gZG9sbC4uLiBq
dXN0IHdoYXQgSSBhbHdheXMgd2FudGVkISAtIENsYXJhDQoNCg==
