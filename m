Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BEE64025B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 09:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiLBIj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 03:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiLBIix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:38:53 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1982A1CFD3;
        Fri,  2 Dec 2022 00:37:56 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 5360AB055B002;
        Fri,  2 Dec 2022 16:37:53 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 2 Dec 2022 16:37:53 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Fri, 2 Dec 2022 16:37:52 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Tao pilgrim <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Topic: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA//+FgwCAAVYiAP//vByAgACohID//5lJgAAA0fUAABOecID//4cygIABqLMA
Date:   Fri, 2 Dec 2022 08:37:52 +0000
Message-ID: <771CC621-A19E-4174-B3D0-F451B1D7D69A@didiglobal.com>
In-Reply-To: <Y4jFnY7kMdB8ReSW@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B5BD234FEA1914B8C9C78E8E2953F58@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wMSAyMzoxNzo0OSwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDAxLTEyLTIyIDE0OjMwOjExLCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIyLTEyLTAxIDIxOjA4OjI2LCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj4+ID5PbiBUaHUgMDEtMTItMjIgMTM6NDQ6NTgsIE1p
Y2hhbCBIb2NrbyB3cm90ZToNCj4+ID4+IE9uIFRodSAwMS0xMi0yMiAxMDo1MjozNSwg56iL5Z6y
5rabIENoZW5na2FpdGFvIENoZW5nIHdyb3RlOg0KPj4gPj4gPiBBdCAyMDIyLTEyLTAxIDE2OjQ5
OjI3LCAiTWljaGFsIEhvY2tvIiA8bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj4+ID5bLi4uXQ0K
Pj4gPj4gVGhlcmUgaXMgYSBtaXN1bmRlcnN0YW5kaW5nLCBvb20ucHJvdGVjdCBkb2VzIG5vdCBy
ZXBsYWNlIHRoZSB1c2VyJ3MgDQo+PiA+PiB0YWlsZWQgcG9saWNpZXMsIEl0cyBwdXJwb3NlIGlz
IHRvIG1ha2UgaXQgZWFzaWVyIGFuZCBtb3JlIGVmZmljaWVudCBmb3IgDQo+PiA+PiB1c2VycyB0
byBjdXN0b21pemUgcG9saWNpZXMsIG9yIHRyeSB0byBhdm9pZCB1c2VycyBjb21wbGV0ZWx5IGFi
YW5kb25pbmcgDQo+PiA+PiB0aGUgb29tIHNjb3JlIHRvIGZvcm11bGF0ZSBuZXcgcG9saWNpZXMu
DQo+PiA+DQo+PiA+IFRoZW4geW91IHNob3VsZCBmb2N1cyBvbiBleHBsYWluaW5nIG9uIGhvdyB0
aGlzIG1ha2VzIHRob3NlIHBvbGljaWVzIGFuZA0KPj4gPiBlYXNpZXIgYW5kIG1vZSBlZmZpY2ll
bnQuIEkgZG8gbm90IHNlZSBpdC4NCj4+IA0KPj4gSW4gZmFjdCwgdGhlcmUgYXJlIHNvbWUgcmVs
ZXZhbnQgY29udGVudHMgaW4gdGhlIHByZXZpb3VzIGNoYXQgcmVjb3Jkcy4gDQo+PiBJZiBvb20u
cHJvdGVjdCBpcyBhcHBsaWVkLCBpdCB3aWxsIGhhdmUgdGhlIGZvbGxvd2luZyBiZW5lZml0cw0K
Pj4gMS4gVXNlcnMgb25seSBuZWVkIHRvIGZvY3VzIG9uIHRoZSBtYW5hZ2VtZW50IG9mIHRoZSBs
b2NhbCBjZ3JvdXAsIG5vdCB0aGUgDQo+PiBpbXBhY3Qgb24gb3RoZXIgdXNlcnMnIGNncm91cHMu
DQo+DQo+UHJvdGVjdGlvbiBiYXNlZCBiYWxhbmNpbmcgY2Fubm90IHJlYWxseSB3b3JrIGluIGFu
IGlzb2xhdGlvbi4NCg0KSSB0aGluayB0aGF0IGEgY2dyb3VwIG9ubHkgbmVlZHMgdG8gY29uY2Vy
biB0aGUgcHJvdGVjdGlvbiB2YWx1ZSBvZiB0aGUgY2hpbGQgDQpjZ3JvdXAsIHdoaWNoIGlzIGlu
ZGVwZW5kZW50IGluIGEgY2VydGFpbiBzZW5zZS4NCg0KPj4gMi4gVXNlcnMgYW5kIHN5c3RlbSBk
byBub3QgbmVlZCB0byBzcGVuZCBleHRyYSB0aW1lIG9uIGNvbXBsaWNhdGVkIGFuZCANCj4+IHJl
cGVhdGVkIHNjYW5uaW5nIGFuZCBjb25maWd1cmF0aW9uLiBUaGV5IGp1c3QgbmVlZCB0byBjb25m
aWd1cmUgdGhlIA0KPj4gb29tLnByb3RlY3Qgb2Ygc3BlY2lmaWMgY2dyb3Vwcywgd2hpY2ggaXMg
YSBvbmUtdGltZSB0YXNrDQo+DQo+VGhpcyB3aWxsIG5vdCB3b3JrIHNhbWUgd2F5IGFzIHRoZSBt
ZW1vcnkgcmVjbGFpbSBwcm90ZWN0aW9uIGNhbm5vdCB3b3JrDQo+aW4gYW4gaXNvbGF0aW9uIG9u
IHRoZSBtZW1jZyBsZXZlbC4NCg0KVGhlIHBhcmVudCBjZ3JvdXAncyBvb20ucHJvdGVjdCBjYW4g
Y2hhbmdlIHRoZSBhY3R1YWwgcHJvdGVjdGVkIG1lbW9yeSBzaXplIA0Kb2YgdGhlIGNoaWxkIGNn
cm91cCwgd2hpY2ggaXMgZXhhY3RseSB3aGF0IHdlIG5lZWQuIEJlY2F1c2Ugb2YgaXQsIHRoZSBj
aGlsZCBjZ3JvdXAgDQpjYW4gc2V0IGl0cyBvd24gb29tLnByb3RlY3QgYXQgd2lsbC4NCg0KPj4g
Pj4gPiA+V2h5IGNhbm5vdCB5b3Ugc2ltcGx5IGRpc2NvdW50IHRoZSBwcm90ZWN0aW9uIGZyb20g
YWxsIHByb2Nlc3Nlcw0KPj4gPj4gPiA+ZXF1YWxseT8gSSBkbyBub3QgZm9sbG93IHdoeSB0aGUg
dGFza191c2FnZSBoYXMgdG8gcGxheSBhbnkgcm9sZSBpbg0KPj4gPj4gPiA+dGhhdC4NCj4+ID4+
ID4gDQo+PiA+PiA+IElmIGFsbCBwcm9jZXNzZXMgYXJlIHByb3RlY3RlZCBlcXVhbGx5LCB0aGUg
b29tIHByb3RlY3Rpb24gb2YgY2dyb3VwIGlzIA0KPj4gPj4gPiBtZWFuaW5nbGVzcy4gRm9yIGV4
YW1wbGUsIGlmIHRoZXJlIGFyZSBtb3JlIHByb2Nlc3NlcyBpbiB0aGUgY2dyb3VwLCANCj4+ID4+
ID4gdGhlIGNncm91cCBjYW4gcHJvdGVjdCBtb3JlIG1lbXMsIGl0IGlzIHVuZmFpciB0byBjZ3Jv
dXBzIHdpdGggZmV3ZXIgDQo+PiA+PiA+IHByb2Nlc3Nlcy4gU28gd2UgbmVlZCB0byBrZWVwIHRo
ZSB0b3RhbCBhbW91bnQgb2YgbWVtb3J5IHRoYXQgYWxsIA0KPj4gPj4gPiBwcm9jZXNzZXMgaW4g
dGhlIGNncm91cCBuZWVkIHRvIHByb3RlY3QgY29uc2lzdGVudCB3aXRoIHRoZSB2YWx1ZSBvZiAN
Cj4+ID4+ID4gZW9vbS5wcm90ZWN0Lg0KPj4gPj4gDQo+PiA+PiBZb3UgYXJlIG1peGluZyB0d28g
ZGlmZmVyZW50IGNvbmNlcHRzIHRvZ2V0aGVyIEkgYW0gYWZyYWlkLiBUaGUgcGVyDQo+PiA+PiBt
ZW1jZyBwcm90ZWN0aW9uIHNob3VsZCBwcm90ZWN0IHRoZSBjZ3JvdXAgKGkuZS4gYWxsIHByb2Nl
c3NlcyBpbiB0aGF0DQo+PiA+PiBjZ3JvdXApIHdoaWxlIHlvdSB3YW50IGl0IHRvIGJlIGFsc28g
cHJvY2VzcyBhd2FyZS4gVGhpcyByZXN1bHRzIGluIGENCj4+ID4+IHZlcnkgdW5jbGVhciBydW50
aW1lIGJlaGF2aW9yIHdoZW4gYSBwcm9jZXNzIGZyb20gYSBtb3JlIHByb3RlY3RlZCBtZW1jZw0K
Pj4gPj4gaXMgc2VsZWN0ZWQgYmFzZWQgb24gaXRzIGluZGl2aWR1YWwgbWVtb3J5IHVzYWdlLg0K
Pj4gPg0KPj4gVGhlIGNvcnJlY3Qgc3RhdGVtZW50IGhlcmUgc2hvdWxkIGJlIHRoYXQgZWFjaCBt
ZW1jZyBwcm90ZWN0aW9uIHNob3VsZCANCj4+IHByb3RlY3QgdGhlIG51bWJlciBvZiBtZW1zIHNw
ZWNpZmllZCBieSB0aGUgb29tLnByb3RlY3QuIEZvciBleGFtcGxlLCANCj4+IGEgY2dyb3VwJ3Mg
dXNhZ2UgaXMgNkcsIGFuZCBpdCdzIG9vbS5wcm90ZWN0IGlzIDJHLCB3aGVuIGFuIG9vbSBraWxs
ZXIgb2NjdXJzLCANCj4+IEluIHRoZSB3b3JzdCBjYXNlLCB3ZSB3aWxsIG9ubHkgcmVkdWNlIHRo
ZSBtZW1vcnkgdXNlZCBieSB0aGlzIGNncm91cCB0byAyRyANCj4+IHRocm91Z2ggdGhlIG9tIGtp
bGxlci4NCj4NCj5JIGRvIG5vdCBzZWUgaG93IHRoYXQgY291bGQgYmUgZ3VhcmFudGVlZC4gUGxl
YXNlIGtlZXAgaW4gbWluZCB0aGF0IGENCj5ub24tdHJpdmlhbCBhbW91bnQgb2YgbWVtb3J5IHJl
c291cmNlcyBjb3VsZCBiZSBjb21wbGV0ZWx5IGluZGVwZW5kZW50DQo+b24gYW55IHByb2Nlc3Mg
bGlmZSB0aW1lIChqdXN0IGNvbnNpZGVyIHRtcGZzIGFzIGEgdHJpdmlhbCBleGFtcGxlKS4NCj4N
Cj4+ID5MZXQgbWUgYmUgbW9yZSBzcGVjaWZpYyBoZXJlLiBBbHRob3VnaCBpdCBpcyBwcmltYXJp
bHkgcHJvY2Vzc2VzIHdoaWNoDQo+PiA+YXJlIHRoZSBwcmltYXJ5IHNvdXJjZSBvZiBtZW1jZyBj
aGFyZ2VzIHRoZSBtZW1vcnkgYWNjb3VudGVkIGZvciB0aGUgb29tDQo+PiA+YmFkbmVzcyBwdXJw
b3NlcyBpcyBub3QgcmVhbGx5IGNvbXBhcmFibGUgdG8gdGhlIG92ZXJhbCBtZW1jZyBjaGFyZ2Vk
DQo+PiA+bWVtb3J5LiBLZXJuZWwgbWVtb3J5LCBub24tbWFwcGVkIG1lbW9yeSBhbGwgdGhhdCBj
YW4gZ2VuZXJhdGUgcmF0aGVyDQo+PiA+aW50ZXJlc3RpbmcgY29ybmVyY2FzZXMuDQo+PiANCj4+
IFNvcnJ5LCBJJ20gdGhvdWdodGxlc3MgZW5vdWdoIGFib3V0IHNvbWUgc3BlY2lhbCBtZW1vcnkg
c3RhdGlzdGljcy4gSSB3aWxsIGZpeCANCj4+IGl0IGluIHRoZSBuZXh0IHZlcnNpb24NCj4NCj5M
ZXQgbWUganVzdCBlbXBoYXNpc2UgdGhhdCB3ZSBhcmUgdGFsa2luZyBhYm91dCBmdW5kYW1lbnRh
bCBkaXNjb25uZWN0Lg0KPlJzcyBiYXNlZCBhY2NvdW50aW5nIGhhcyBiZWVuIHVzZWQgZm9yIHRo
ZSBPT00ga2lsbGVyIHNlbGVjdGlvbiBiZWNhdXNlDQo+dGhlIG1lbW9yeSBnZXRzIHVubWFwcGVk
IGFuZCBfcG90ZW50aWFsbHlfIGZyZWVkIHdoZW4gdGhlIHByb2Nlc3MgZ29lcw0KPmF3YXkuIE1l
bWNnIGNoYW5nZXMgYXJlIGJvdW5kIHRvIHRoZSBvYmplY3QgbGlmZSB0aW1lIGFuZCBhcyBzYWlk
IGluDQo+bWFueSBjYXNlcyB0aGVyZSBpcyBubyBkaXJlY3QgcmVsYXRpb24gd2l0aCBhbnkgcHJv
Y2VzcyBsaWZlIHRpbWUuDQoNCkJhc2VkIG9uIHlvdXIgcXVlc3Rpb24sIEkgd2FudCB0byByZXZp
c2UgdGhlIGZvcm11bGEgYXMgZm9sbG93cywNCnNjb3JlID0gdGFza191c2FnZSArIHNjb3JlX2Fk
aiAqIHRvdGFscGFnZSAtIGVvb20ucHJvdGVjdCAqICh0YXNrX3VzYWdlIC0gdGFza19yc3NzaGFy
ZSkgLyANCihsb2NhbF9tZW1jZ191c2FnZSArIGxvY2FsX21lbWNnX3N3YXBjYWNoZSkNCg0KQWZ0
ZXIgdGhlIHByb2Nlc3MgaXMga2lsbGVkLCB0aGUgdW5tYXBwZWQgY2FjaGUgYW5kIHNoYXJlbWVt
IHdpbGwgbm90IGJlIA0KcmVsZWFzZWQgaW1tZWRpYXRlbHksIHNvIHRoZXkgc2hvdWxkIG5vdCBh
cHBseSB0byBjZ3JvdXAgZm9yIHByb3RlY3Rpb24gcXVvdGEuIA0KSW4gZXh0cmVtZSBlbnZpcm9u
bWVudHMsIHRoZSBtZW1vcnkgdGhhdCBjYW5ub3QgYmUgcmVsZWFzZWQgYnkgdGhlIG9vbSBraWxs
ZXIgDQooaS5lLiBzb21lIG1lbXMgdGhhdCBoYXZlIG5vdCBiZWVuIGNoYXJnZWQgdG8gdGhlIHBy
b2Nlc3MpIG1heSBvY2N1cHkgYSBsYXJnZSANCnNoYXJlIG9mIHByb3RlY3Rpb24gcXVvdGEsIGJ1
dCBpdCBpcyBleHBlY3RlZC4gT2YgY291cnNlLCB0aGUgaWRlYSBtYXkgaGF2ZSBzb21lIA0KcHJv
YmxlbXMgdGhhdCBJIGhhdmVuJ3QgY29uc2lkZXJlZC4NCg0KPg0KPkhvcGUgdGhhdCBjbGFyaWZp
ZXMuDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50IQ0KY2hlbmdrYWl0YW8NCg0K
