Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5F710686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjEYHhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjEYHgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 03:36:21 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8D1A410D0;
        Thu, 25 May 2023 00:35:45 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.64.19])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id AAD48B0038414;
        Thu, 25 May 2023 15:35:41 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY01-ACTMBX-06.didichuxing.com (10.79.64.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 15:35:41 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Thu, 25 May 2023 15:35:41 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.64.19
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Thread-Topic: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Thread-Index: AQHZgBDkVfbL1Z6yKEKz1c3DJxWsna9OEngAgAIGrwD//9B5AIABm3eAgBRQXwCABOFqAA==
Date:   Thu, 25 May 2023 07:35:41 +0000
Message-ID: <96BFCF52-A5F6-4B73-ACAE-ACF11798E374@didiglobal.com>
In-Reply-To: <ZGtoNu7zIRRy7qK0@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A45DBD4EA83F3A4FA7A07FD31A22BB90@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMy0wNS0yMiAyMTowMzo1MCwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+W1NvcnJ5IGZvciBhIGxhdGUgcmVwbHkgYnV0IEkgd2FzIG1vc3RseSBvZmZsaW5l
IGxhc3QgMiB3ZWVrc10NCj4NCj5PbiBUdWUgMDktMDUtMjMgMDY6NTA6NTksIOeoi+Wesua2myBD
aGVuZ2thaXRhbyBDaGVuZyB3cm90ZToNCj4+IEF0IDIwMjMtMDUtMDggMjI6MTg6MTgsICJNaWNo
YWwgSG9ja28iIDxtaG9ja29Ac3VzZS5jb20+IHdyb3RlOg0KPlsuLi5dDQo+PiA+WW91ciBjb3Zl
ciBsZXR0ZXIgbWVudGlvbnMgdGhhdCB0aGVuICJhbGwgcHJvY2Vzc2VzIGluIHRoZSBjZ3JvdXAg
YXMgYQ0KPj4gPndob2xlIi4gVGhhdCB0byBtZSByZWFkcyBhcyBvb20uZ3JvdXAgb29tIGtpbGxl
ciBwb2xpY3kuIEJ1dCBhIGJyaWVmDQo+PiA+bG9vayBpbnRvIHRoZSBwYXRjaCBzdWdnZXN0cyB5
b3UgYXJlIHN0aWxsIGxvb2tpbmcgYXQgc3BlY2lmaWMgdGFza3MgYW5kDQo+PiA+dGhpcyBoYXMg
YmVlbiBhIGNvbmNlcm4gaW4gdGhlIHByZXZpb3VzIHZlcnNpb24gb2YgdGhlIHBhdGNoIGJlY2F1
c2UNCj4+ID5tZW1jZyBhY2NvdW50aW5nIGFuZCBwZXItcHJvY2VzcyBhY2NvdW50aW5nIGFyZSBk
ZXRhY2hlZC4NCj4+IA0KPj4gSSB0aGluayB0aGUgbWVtY2cgYWNjb3VudGluZyBtYXkgYmUgbW9y
ZSByZWFzb25hYmxlLCBhcyBpdHMgbWVtb3J5IA0KPj4gc3RhdGlzdGljcyBhcmUgbW9yZSBjb21w
cmVoZW5zaXZlLCBzaW1pbGFyIHRvIGFjdGl2ZSBwYWdlIGNhY2hlLCB3aGljaCANCj4+IGFsc28g
aW5jcmVhc2VzIHRoZSBwcm9iYWJpbGl0eSBvZiBPT00ta2lsbC4gSW4gdGhlIG5ldyBwYXRjaCwg
YWxsIHRoZSANCj4+IHNoYXJlZCBtZW1vcnkgd2lsbCBhbHNvIGNvbnN1bWUgdGhlIG9vbV9wcm90
ZWN0IHF1b3RhIG9mIHRoZSBtZW1jZywgDQo+PiBhbmQgdGhlIHByb2Nlc3MncyBvb21fcHJvdGVj
dCBxdW90YSBvZiB0aGUgbWVtY2cgd2lsbCBkZWNyZWFzZS4NCj4NCj5JIGFtIHNvcnJ5IGJ1dCBJ
IGRvIG5vdCBmb2xsb3cuIENvdWxkIHlvdSBlbGFib3JhdGUgcGxlYXNlPyBBcmUgeW91DQo+YXJn
dWluZyBmb3IgcGVyIG1lbWNnIG9yIHBlciBwcm9jZXNzIG1ldHJpY3M/DQoNCllvdSBtZW50aW9u
ZWQgZWFybGllciB0aGF0ICdtZW1jZyBhY2NvdW50aW5nIGFuZCBwZXIgcHJvY2VzcyBhY2NvdW50
aW5nDQphcmUgZGV0YWNoZWQnLCBhbmQgSSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29kIHlvdXIgcXVl
c3Rpb24uIEkgd2FudCB0byANCmV4cHJlc3MgYWJvdmUgdGhhdCBtZW1jZyBhY2NvdW50aW5nIGlz
IG1vcmUgY29tcHJlaGVuc2l2ZSB0aGFuIHBlciBwcm9jZXNzIA0KYWNjb3VudGluZywgYW5kIHVz
aW5nIG1lbWNnIGFjY291bnRpbmcgaW4gdGhlIE9PTS1raWxsZXIgbWVjaGFuaXNtIHdvdWxkIA0K
YmUgbW9yZSByZWFzb25hYmxlLg0KDQo+Wy4uLl0NCj4NCj4+ID4+IEluIHRoZSBmaW5hbCBkaXNj
dXNzaW9uIG9mIHBhdGNoIHYyLCB3ZSBkaXNjdXNzZWQgdGhhdCBhbHRob3VnaCB0aGUgYWRqdXN0
bWVudCByYW5nZSANCj4+ID4+IG9mIG9vbV9zY29yZV9hZGogaXMgWy0xMDAwLDEwMDBdLCBidXQg
ZXNzZW50aWFsbHkgaXQgb25seSBhbGxvd3MgdHdvIHVzZWNhc2VzDQo+PiA+PiAoT09NX1NDT1JF
X0FESl9NSU4sIE9PTV9TQ09SRV9BREpfTUFYKSByZWxpYWJseS4gRXZlcnl0aGluZyBpbiBiZXR3
ZWVuIGlzIA0KPj4gPj4gY2x1bXN5IGF0IGJlc3QuIEluIG9yZGVyIHRvIHNvbHZlIHRoaXMgcHJv
YmxlbSBpbiB0aGUgbmV3IHBhdGNoLCBJIGludHJvZHVjZWQgYSBuZXcgDQo+PiA+PiBpbmRpY2F0
b3Igb29tX2tpbGxfaW5oZXJpdCwgd2hpY2ggY291bnRzIHRoZSBudW1iZXIgb2YgdGltZXMgdGhl
IGxvY2FsIGFuZCBjaGlsZCANCj4+ID4+IGNncm91cHMgaGF2ZSBiZWVuIHNlbGVjdGVkIGJ5IHRo
ZSBPT00ga2lsbGVyIG9mIHRoZSBhbmNlc3RvciBjZ3JvdXAuIEJ5IG9ic2VydmluZyANCj4+ID4+
IHRoZSBwcm9wb3J0aW9uIG9mIG9vbV9raWxsX2luaGVyaXQgaW4gdGhlIHBhcmVudCBjZ3JvdXAs
IEkgY2FuIGVmZmVjdGl2ZWx5IGFkanVzdCB0aGUgDQo+PiA+PiB2YWx1ZSBvZiBvb21fcHJvdGVj
dCB0byBhY2hpZXZlIHRoZSBiZXN0Lg0KPj4gPg0KPj4gPldoYXQgZG9lcyB0aGUgYmVzdCBtZWFu
IGluIHRoaXMgY29udGV4dD8NCj4+IA0KPj4gSSBoYXZlIGNyZWF0ZWQgYSBuZXcgaW5kaWNhdG9y
IG9vbV9raWxsX2luaGVyaXQgdGhhdCBtYWludGFpbnMgYSBuZWdhdGl2ZSBjb3JyZWxhdGlvbiAN
Cj4+IHdpdGggbWVtb3J5Lm9vbS5wcm90ZWN0LCBzbyB3ZSBoYXZlIGEgcnVsZXIgdG8gbWVhc3Vy
ZSB0aGUgb3B0aW1hbCB2YWx1ZSBvZiANCj4+IG1lbW9yeS5vb20ucHJvdGVjdC4NCj4NCj5BbiBl
eGFtcGxlIG1pZ2h0IGhlbHAgaGVyZS4NCg0KSW4gbXkgdGVzdGluZyBjYXNlLCBieSBhZGp1c3Rp
bmcgbWVtb3J5Lm9vbS5wcm90ZWN0LCBJIHdhcyBhYmxlIHRvIHNpZ25pZmljYW50bHkgDQpyZWR1
Y2UgdGhlIG9vbV9raWxsX2luaGVyaXQgb2YgdGhlIGNvcnJlc3BvbmRpbmcgY2dyb3VwLiBJbiBh
IHBoeXNpY2FsIG1hY2hpbmUgDQp3aXRoIHNldmVyZWx5IG92ZXJzb2xkIG1lbW9yeSwgSSBkaXZp
ZGVkIGFsbCBjZ3JvdXBzIGludG8gdGhyZWUgY2F0ZWdvcmllcyBhbmQgDQpjb250cm9sbGVkIHRo
ZWlyIHByb2JhYmlsaXR5IG9mIGJlaW5nIHNlbGVjdGVkIGJ5IHRoZSBvb20ta2lsbGVyIHRvIDAl
LCUgMjAsIA0KYW5kIDgwJSwgcmVzcGVjdGl2ZWx5Lg0KDQo+PiA+PiBhYm91dCB0aGUgc2VtYW50
aWNzIG9mIG5vbi1sZWFmIG1lbWNncyBwcm90ZWN0aW9uLA0KPj4gPj4gSWYgYSBub24tbGVhZiBt
ZW1jZydzIG9vbV9wcm90ZWN0IHF1b3RhIGlzIHNldCwgaXRzIGxlYWYgbWVtY2cgd2lsbCBwcm9w
b3J0aW9uYWxseSANCj4+ID4+IGNhbGN1bGF0ZSB0aGUgbmV3IGVmZmVjdGl2ZSBvb21fcHJvdGVj
dCBxdW90YSBiYXNlZCBvbiBub24tbGVhZiBtZW1jZydzIHF1b3RhLg0KPj4gPg0KPj4gPlNvIHRo
ZSBub24tbGVhZiBtZW1jZyBpcyBuZXZlciB1c2VkIGFzIGEgdGFyZ2V0PyBXaGF0IGlmIHRoZSB3
b3JrbG9hZCBpcw0KPj4gPmRpc3RyaWJ1dGVkIG92ZXIgc2V2ZXJhbCBzdWItZ3JvdXBzPyBPdXIg
Y3VycmVudCBvb20uZ3JvdXANCj4+ID5pbXBsZW1lbnRhdGlvbiB0cmF2ZXJzZXMgdGhlIHRyZWUg
dG8gZmluZCBhIGNvbW1vbiBhbmNlc3RvciBpbiB0aGUgb29tDQo+PiA+ZG9tYWluIHdpdGggdGhl
IG9vbS5ncm91cC4NCj4+IA0KPj4gSWYgdGhlIG9vbV9wcm90ZWN0IHF1b3RhIG9mIHRoZSBwYXJl
bnQgbm9uLWxlYWYgbWVtY2cgaXMgbGVzcyB0aGFuIHRoZSBzdW0gb2YgDQo+PiBzdWItZ3JvdXBz
IG9vbV9wcm90ZWN0IHF1b3RhLCB0aGUgb29tX3Byb3RlY3QgcXVvdGEgb2YgZWFjaCBzdWItZ3Jv
dXAgd2lsbCANCj4+IGJlIHByb3BvcnRpb25hbGx5IHJlZHVjZWQNCj4+IElmIHRoZSBvb21fcHJv
dGVjdCBxdW90YSBvZiB0aGUgcGFyZW50IG5vbi1sZWFmIG1lbWNnIGlzIGdyZWF0ZXIgdGhhbiB0
aGUgc3VtIA0KPj4gb2Ygc3ViLWdyb3VwcyBvb21fcHJvdGVjdCBxdW90YSwgdGhlIG9vbV9wcm90
ZWN0IHF1b3RhIG9mIGVhY2ggc3ViLWdyb3VwIA0KPj4gd2lsbCBiZSBwcm9wb3J0aW9uYWxseSBp
bmNyZWFzZWQNCj4+IFRoZSBwdXJwb3NlIG9mIGRvaW5nIHNvIGlzIHRoYXQgdXNlcnMgY2FuIHNl
dCBvb21fcHJvdGVjdCBxdW90YSBhY2NvcmRpbmcgdG8gDQo+PiB0aGVpciBvd24gbmVlZHMsIGFu
ZCB0aGUgc3lzdGVtIG1hbmFnZW1lbnQgcHJvY2VzcyBjYW4gc2V0IGFwcHJvcHJpYXRlIA0KPj4g
b29tX3Byb3RlY3QgcXVvdGEgb24gdGhlIHBhcmVudCBub24tbGVhZiBtZW1jZyBhcyB0aGUgZmlu
YWwgY292ZXIsIHNvIHRoYXQgDQo+PiB0aGUgc3lzdGVtIG1hbmFnZW1lbnQgcHJvY2VzcyBjYW4g
aW5kaXJlY3RseSBtYW5hZ2UgYWxsIHVzZXIgcHJvY2Vzc2VzLg0KPg0KPkkgZ3Vlc3MgdGhhdCB5
b3UgYXJlIHRyeWluZyB0byBzYXkgdGhhdCB0aGUgb29tIHByb3RlY3Rpb24gaGFzIGENCj5zdGFu
ZGFyZCBoaWVyYXJjaGljYWwgYmVoYXZpb3IuIEFuZCB0aGF0IGlzIGZpbmUsIHdlbGwsIGluIGZh
Y3QgaXQgaXMNCj5tYW5kYXRvcnkgZm9yIGFueSBjb250cm9sIGtub2IgdG8gaGF2ZSBhIHNhbmUg
aGllcmFyY2hpY2FsIHByb3BlcnRpZXMuDQo+QnV0IHRoYXQgZG9lc24ndCBhZGRyZXNzIG15IGFi
b3ZlIHF1ZXN0aW9uLiBMZXQgbWUgdHJ5IGFnYWluLiBXaGVuIGlzIGENCj5ub24tbGVhZiBtZW1j
ZyBwb3RlbnRpYWxseSBzZWxlY3RlZCBhcyB0aGUgb29tIHZpY3RpbT8gSXQgZG9lc24ndCBoYXZl
DQo+YW55IHRhc2tzIGRpcmVjdGx5IGJ1dCBpdCBtaWdodCBiZSBhIHN1aXRhYmxlIHRhcmdldCB0
byBraWxsIGEgbXVsdGkNCj5tZW1jZyBiYXNlZCB3b3JrbG9hZCAoZS5nLiBhIGZ1bGwgY29udGFp
bmVyKS4NCg0KSWYgbm9ubGVhZiBtZW1jZyBoYXZlIHRoZSBoaWdoZXIgbWVtb3J5IHVzYWdlIGFu
ZCB0aGUgc21hbGxlciANCm1lbW9yeS5vb20ucHJvdGVjdCwgaXQgd2lsbCBoYXZlIHRoZSBoaWdo
ZXIgdGhlIHByb2JhYmlsaXR5IGJlaW5nIA0Kc2VsZWN0ZWQgYnkgdGhlIGtpbGxlci4gSWYgdGhl
IG5vbi1sZWFmIG1lbWNnIGlzIHNlbGVjdGVkIGFzIHRoZSBvb20gDQp2aWN0aW0sIE9PTS1raWxs
ZXIgd2lsbCBjb250aW51ZSB0byBzZWxlY3QgdGhlIGFwcHJvcHJpYXRlIGNoaWxkIA0KbWVtY2cg
ZG93bndhcmRzIHVudGlsIHRoZSBsZWFmIG1lbWNnIGlzIHNlbGVjdGVkLg0KDQo+PiA+QWxsIHRo
YXQgYmVpbmcgc2FpZCBhbmQgd2l0aCB0aGUgdXNlY2FzZSBkZXNjcmliZWQgbW9yZSBzcGVjaWZp
Y2FsbHkuIEkNCj4+ID5jYW4gc2VlIHRoYXQgbWVtY2cgYmFzZWQgb29tIHZpY3RpbSBzZWxlY3Rp
b24gbWFrZXMgc29tZSBzZW5zZS4gVGhhdA0KPj4gPm1lbmFzIHRoYXQgaXQgaXMgYWx3YXlzIGEg
bWVtY2cgc2VsZWN0ZWQgYW5kIGFsbCB0YXNrcyB3aXRoaW5nIGtpbGxlZC4NCj4+ID5NZW1jZyBi
YXNlZCBwcm90ZWN0aW9uIGNhbiBiZSB1c2VkIHRvIGV2YWx1YXRlIHdoaWNoIG1lbWNnIHRvIGNo
b29zZSBhbmQNCj4+ID50aGUgb3ZlcmFsbCBzY2hlbWUgc2hvdWxkIGJlIHN0aWxsIG1hbmFnZWFi
bGUuIEl0IHdvdWxkIGluZGVlZCByZXNlbWJsZQ0KPj4gPm1lbW9yeSBwcm90ZWN0aW9uIGZvciB0
aGUgcmVndWxhciByZWNsYWltLg0KPj4gPg0KPj4gPk9uZSB0aGluZyB0aGF0IGlzIHN0aWxsIG5v
dCByZWFsbHkgY2xlYXIgdG8gbWUgaXMgdG8gaG93IGdyb3VwIHZzLg0KPj4gPm5vbi1ncm91cCBv
b21zIGNvdWxkIGJlIGhhbmRsZWQgZ3JhY2VmdWxseS4gUmlnaHQgbm93IHdlIGNhbiBoYW5kbGUg
dGhhdA0KPj4gPmJlY2F1c2UgdGhlIG9vbSBzZWxlY3Rpb24gaXMgc3RpbGwgcHJvY2VzcyBiYXNl
ZCBidXQgd2l0aCB0aGUgcHJvdGVjdGlvbg0KPj4gPnRoaXMgd2lsbCBiZWNvbWUgbW9yZSBwcm9i
bGVtYXRpYyBhcyBleHBsYWluZWQgcHJldmlvdXNseS4gRXNzZW50aWFsbHkNCj4+ID53ZSB3b3Vs
ZCBuZWVkIHRvIGVuZm9yY2UgdGhlIG9vbSBzZWxlY3Rpb24gdG8gYmUgbWVtY2cgYmFzZWQgZm9y
IGFsbA0KPj4gPm1lbWNncy4gTWF5YmUgYSBtb3VudCBrbm9iPyBXaGF0IGRvIHlvdSB0aGluaz8N
Cj4+IA0KPj4gVGhlcmUgaXMgYSBmdW5jdGlvbiBpbiB0aGUgcGF0Y2ggdG8gZGV0ZXJtaW5lIHdo
ZXRoZXIgdGhlIG9vbV9wcm90ZWN0IA0KPj4gbWVjaGFuaXNtIGlzIGVuYWJsZWQuIEFsbCBtZW1v
cnkub29tLnByb3RlY3Qgbm9kZXMgZGVmYXVsdCB0byAwLCBzbyB0aGUgZnVuY3Rpb24gDQo+PiA8
aXNfcm9vdF9vb21fcHJvdGVjdD4gcmV0dXJucyAwIGJ5IGRlZmF1bHQuDQo+DQo+SG93IGNhbiBh
biBhZG1pbiBkZXRlcm1pbmUgd2hhdCBpcyB0aGUgY3VycmVudCBvb20gZGV0ZWN0aW9uIGxvZ2lj
Pw0KDQpUaGUgbWVtb3J5Lm9vbS5wcm90ZWN0IGFyZSBzZXQgYnkgdGhlIGFkbWluaXN0cmF0b3Ig
dGhlbXNlbHZlcywgYW5kIHRoZXkgDQptdXN0IGtub3cgd2hhdCB0aGUgY3VycmVudCBPT00gcG9s
aWN5IGlzLiBSZWFkaW5nIHRoZSBtZW1vcnkub29tLnByb3RlY3QgDQpvZiB0aGUgZmlyc3QgbGV2
ZWwgY2dyb3VwIGRpcmVjdG9yeSBhbmQgb2JzZXJ2aW5nIHdoZXRoZXIgaXQgaXMgMCBjYW4gYWxz
byANCmRldGVybWluZSB3aGV0aGVyIHRoZSBvb20ucHJvdGVjdCBwb2xpY3kgaXMgZW5hYmxlZC4N
Cg0KRm9yIGEgcHJvY2VzcywgdGhlIHBoeXNpY2FsIG1hY2hpbmUgYWRtaW5pc3RyYXRvciwgazhz
IGFkbWluaXN0cmF0b3IsIA0KYWdlbnQgYWRtaW5pc3RyYXRvciwgYW5kIGNvbnRhaW5lciBhZG1p
bmlzdHJhdG9yIHNlZSBkaWZmZXJlbnQgZWZmZWN0aXZlIA0KbWVtb3J5Lm9vbS5wcm90ZWN0IGZv
ciB0aGUgcHJvY2Vzcywgc28gdGhleSBvbmx5IG5lZWQgdG8gcGF5IGF0dGVudGlvbiANCnRvIHRo
ZSBtZW1vcnkub29tLnByb3RlY3Qgb2YgdGhlIGxvY2FsIGNncm91cCBkaXJlY3RvcnkuIElmIGFu
IGFkbWluaXN0cmF0b3IgDQp3YW50cyB0byBrbm93IHRoZSBPT00gZGV0ZWN0aW9uIGxvZ2ljIG9m
IGFsbCBhZG1pbmlzdHJhdG9ycywgSSBkb24ndCB0aGluayANCnRoZXJlIGlzIHN1Y2ggYSBidXNp
bmVzcyByZXF1aXJlbWVudC4NCg0KLS0gDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCENCkNoZW5n
a2FpdGFvDQoNCg0K
