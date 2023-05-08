Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBAF6FA2F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 11:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjEHJId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjEHJIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 05:08:32 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3E20F6583;
        Mon,  8 May 2023 02:08:29 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.36])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id B97C1110052C16;
        Mon,  8 May 2023 17:08:25 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-06.didichuxing.com (10.79.71.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 17:08:25 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Mon, 8 May 2023 17:08:25 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.36
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
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Thread-Topic: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Thread-Index: AQHZgBDkVfbL1Z6yKEKz1c3DJxWsna9OEngAgAIGrwA=
Date:   Mon, 8 May 2023 09:08:25 +0000
Message-ID: <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
In-Reply-To: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DABA74779717A4397036B76658557EB@didichuxing.com>
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

QXQgMjAyMy0wNS0wNyAxODoxMTo1OCwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gU2F0IDA2LTA1LTIzIDE5OjQ5OjQ2LCBjaGVuZ2thaXRhbyB3cm90ZToNCj4+
IEVzdGFibGlzaCBhIG5ldyBPT00gc2NvcmUgYWxnb3JpdGhtLCBzdXBwb3J0cyB0aGUgY2dyb3Vw
IGxldmVsIE9PTQ0KPj4gcHJvdGVjdGlvbiBtZWNoYW5pc20uIFdoZW4gYW4gZ2xvYmFsL21lbWNn
IG9vbSBldmVudCBvY2N1cnMsIHdlIHRyZWF0DQo+PiBhbGwgcHJvY2Vzc2VzIGluIHRoZSBjZ3Jv
dXAgYXMgYSB3aG9sZSwgYW5kIE9PTSBraWxsZXJzIG5lZWQgdG8gc2VsZWN0DQo+PiB0aGUgcHJv
Y2VzcyB0byBraWxsIGJhc2VkIG9uIHRoZSBwcm90ZWN0aW9uIHF1b3RhIG9mIHRoZSBjZ3JvdXAN
Cj4NCj5BbHRob3VnaCB5b3VyIHBhdGNoIDEgYnJpZWZseSB0b3VjaGVzIG9uIHNvbWUgYWR2YW50
YWdlcyBvZiB0aGlzDQo+aW50ZXJmYWNlIHRoZXJlIGlzIGEgbGFjayBvZiBhY3R1YWwgdXNlY2Fz
ZS4gQXJndWluZyB0aGF0IG9vbV9zY29yZV9hZGoNCj5pcyBoYXJkIGJlY2F1c2UgaXQgbmVlZHMg
YSBwYXJlbnQgcHJvY2VzcyBpcyByYXRoZXIgd2VhayB0byBiZSBob25lc3QuDQo+SXQgaXMganVz
dCB0cml2aWFsIHRvIGNyZWF0ZSBhIHRoaW4gd3JhcHBlciwgdXNlIHN5c3RlbWQgdG8gbGF1bmNo
DQo+aW1wb3J0YW50IHNlcnZpY2VzIG9yIHNpbXBseSB1cGRhdGUgdGhlIHZhbHVlIGFmdGVyIHRo
ZSBmYWN0LiBOb3cNCj5vb21fc2NvcmVfYWRqIGhhcyBpdHMgb3duIGRvd25zaWRlcyBvZiBjb3Vy
c2UgKG1vc3Qgbm90YWJseSBhDQo+Z3JhbnVsYXJpdHkgYW5kIGEgbGFjayBvZiBncm91cCBwcm90
ZWN0aW9uLg0KPg0KPlRoYXQgYmVpbmcgc2FpZCwgbWFrZSBzdXJlIHlvdSBkZXNjcmliZSB5b3Vy
IHVzZWNhc2UgbW9yZSB0aG9yb3VnaGx5Lg0KPlBsZWFzZSBhbHNvIG1ha2Ugc3VyZSB5b3UgZGVz
Y3JpYmUgdGhlIGludGVuZGVkIGhldXJpc3RpYyBvZiB0aGUga25vYi4NCj5JdCBpcyBub3QgcmVh
bGx5IGNsZWFyIGZyb20gdGhlIGRlc2NyaXB0aW9uIGhvdyB0aGlzIGZpdHMgaGllcmFyY2hpY2Fs
DQo+YmVoYXZpb3Igb2YgY2dyb3Vwcy4gSSB3b3VsZCBiZSBlc3BlY2lhbGx5IGludGVyZXN0ZWQg
aW4gdGhlIHNlbWFudGljcw0KPm9mIG5vbi1sZWFmIG1lbWNncyBwcm90ZWN0aW9uIGFzIHRoZXkg
ZG8gbm90IGhhdmUgYW55IGFjdHVhbCBwcm9jZXNzZXMNCj50byBwcm90ZWN0Lg0KPg0KPkFsc28g
dGhlcmUgaGF2ZSBiZWVuIGNvbmNlcm5zIG1lbnRpb25lZCBpbiB2MiBkaXNjdXNzaW9uIGFuZCBp
dCB3b3VsZCBiZQ0KPnJlYWxseSBhcHByZWNpYXRlZCB0byBzdW1tYXJpemUgaG93IHlvdSBoYXZl
IGRlYWx0IHdpdGggdGhlbS4NCj4NCj5QbGVhc2UgYWxzbyBub3RlIHRoYXQgbWFueSBwZW9wbGUg
YXJlIGdvaW5nIHRvIGJlIHNsb3cgaW4gcmVzcG9uZGluZw0KPnRoaXMgd2VlayBiZWNhdXNlIG9m
IExTRk1NIGNvbmZlcmVuY2UNCj4oaHR0cHM6Ly9ldmVudHMubGludXhmb3VuZGF0aW9uLm9yZy9s
c2ZtbS8pDQoNCkhlcmUgaXMgYSBtb3JlIGRldGFpbGVkIGNvbXBhcmlzb24gYW5kIGludHJvZHVj
dGlvbiBvZiB0aGUgb2xkIG9vbV9zY29yZV9hZGoNCm1lY2hhbmlzbSBhbmQgdGhlIG5ldyBvb21f
cHJvdGVjdCBtZWNoYW5pc20sDQoxLiBUaGUgcmVndWxhdGluZyBncmFudWxhcml0eSBvZiBvb21f
cHJvdGVjdCBpcyBzbWFsbGVyIHRoYW4gdGhhdCBvZiBvb21fc2NvcmVfYWRqLg0KT24gYSA1MTJH
IHBoeXNpY2FsIG1hY2hpbmUsIHRoZSBtaW5pbXVtIGdyYW51bGFyaXR5IGFkanVzdGVkIGJ5IG9v
bV9zY29yZV9hZGoNCmlzIDUxMk0sIGFuZCB0aGUgbWluaW11bSBncmFudWxhcml0eSBhZGp1c3Rl
ZCBieSBvb21fcHJvdGVjdCBpcyBvbmUgcGFnZSAoNEspLg0KMi4gSXQgbWF5IGJlIHNpbXBsZSB0
byBjcmVhdGUgYSBsaWdodHdlaWdodCBwYXJlbnQgcHJvY2VzcyBhbmQgdW5pZm9ybWx5IHNldCB0
aGUgDQpvb21fc2NvcmVfYWRqIG9mIHNvbWUgaW1wb3J0YW50IHByb2Nlc3NlcywgYnV0IGl0IGlz
IG5vdCBhIHNpbXBsZSBtYXR0ZXIgdG8gbWFrZSANCm11bHRpLWxldmVsIHNldHRpbmdzIGZvciB0
ZW5zIG9mIHRob3VzYW5kcyBvZiBwcm9jZXNzZXMgb24gdGhlIHBoeXNpY2FsIG1hY2hpbmUgDQp0
aHJvdWdoIHRoZSBsaWdodHdlaWdodCBwYXJlbnQgcHJvY2Vzc2VzLiBXZSBtYXkgbmVlZCBhIGh1
Z2UgdGFibGUgdG8gcmVjb3JkIHRoZSANCnZhbHVlIG9mIG9vbV9zY29yZV9hZGogbWFpbnRhaW5l
ZCBieSBhbGwgbGlnaHR3ZWlnaHQgcGFyZW50IHByb2Nlc3NlcywgYW5kIHRoZSANCnVzZXIgcHJv
Y2VzcyBsaW1pdGVkIGJ5IHRoZSBwYXJlbnQgcHJvY2VzcyBoYXMgbm8gYWJpbGl0eSB0byBjaGFu
Z2UgaXRzIG93biANCm9vbV9zY29yZV9hZGosIGJlY2F1c2UgaXQgZG9lcyBub3Qga25vdyB0aGUg
ZGV0YWlscyBvZiB0aGUgaHVnZSB0YWJsZS4gVGhlIG5ldyANCnBhdGNoIGFkb3B0cyB0aGUgY2dy
b3VwIG1lY2hhbmlzbS4gSXQgZG9lcyBub3QgbmVlZCBhbnkgcGFyZW50IHByb2Nlc3MgdG8gbWFu
YWdlIA0Kb29tX3Njb3JlX2Fkai4gdGhlIHNldHRpbmdzIGJldHdlZW4gZWFjaCBtZW1jZyBhcmUg
aW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciwgDQptYWtpbmcgaXQgZWFzaWVyIHRvIHBsYW4gdGhl
IE9PTSBvcmRlciBvZiBhbGwgcHJvY2Vzc2VzLiBEdWUgdG8gdGhlIHVuaXF1ZSBuYXR1cmUgDQpv
ZiBtZW1vcnkgcmVzb3VyY2VzLCBjdXJyZW50IFNlcnZpY2UgY2xvdWQgdmVuZG9ycyBhcmUgbm90
IG92ZXJzb2xkIGluIG1lbW9yeSANCnBsYW5uaW5nLiBJIHdvdWxkIGxpa2UgdG8gdXNlIHRoZSBu
ZXcgcGF0Y2ggdG8gdHJ5IHRvIGFjaGlldmUgdGhlIHBvc3NpYmlsaXR5IG9mIA0Kb3ZlcnNvbGQg
bWVtb3J5IHJlc291cmNlcy4NCjMuIEkgY29uZHVjdGVkIGEgdGVzdCBhbmQgZGVwbG95ZWQgYW4g
ZXhjZXNzaXZlIG51bWJlciBvZiBjb250YWluZXJzIG9uIGEgcGh5c2ljYWwgDQptYWNoaW5lLCBC
eSBzZXR0aW5nIHRoZSBvb21fc2NvcmVfYWRqIHZhbHVlIG9mIGFsbCBwcm9jZXNzZXMgaW4gdGhl
IGNvbnRhaW5lciB0byANCmEgcG9zaXRpdmUgbnVtYmVyIHRocm91Z2ggZG9ja2VyaW5pdCwgZXZl
biBwcm9jZXNzZXMgdGhhdCBvY2N1cHkgdmVyeSBsaXR0bGUgbWVtb3J5IA0KaW4gdGhlIGNvbnRh
aW5lciBhcmUgZWFzaWx5IGtpbGxlZCwgcmVzdWx0aW5nIGluIGEgbGFyZ2UgbnVtYmVyIG9mIGlu
dmFsaWQga2lsbCBiZWhhdmlvcnMuIA0KSWYgZG9ja2VyaW5pdCBpcyBhbHNvIGtpbGxlZCB1bmZv
cnR1bmF0ZWx5LCBpdCB3aWxsIHRyaWdnZXIgY29udGFpbmVyIHNlbGYtaGVhbGluZywgYW5kIHRo
ZSANCmNvbnRhaW5lciB3aWxsIHJlYnVpbGQsIHJlc3VsdGluZyBpbiBtb3JlIHNldmVyZSBtZW1v
cnkgb3NjaWxsYXRpb25zLiBUaGUgbmV3IHBhdGNoIA0KYWJhbmRvbnMgdGhlIGJlaGF2aW9yIG9m
IGFkZGluZyBhbiBlcXVhbCBhbW91bnQgb2Ygb29tX3Njb3JlX2FkaiB0byBlYWNoIHByb2Nlc3Mg
DQppbiB0aGUgY29udGFpbmVyIGFuZCBhZG9wdHMgYSBzaGFyZWQgb29tX3Byb3RlY3QgcXVvdGEg
Zm9yIGFsbCBwcm9jZXNzZXMgaW4gdGhlIGNvbnRhaW5lci4gDQpJZiBhIHByb2Nlc3MgaW4gdGhl
IGNvbnRhaW5lciBpcyBraWxsZWQsIHRoZSByZW1haW5pbmcgb3RoZXIgcHJvY2Vzc2VzIHdpbGwg
cmVjZWl2ZSBtb3JlIA0Kb29tX3Byb3RlY3QgcXVvdGEsIG1ha2luZyBpdCBtb3JlIGRpZmZpY3Vs
dCBmb3IgdGhlIHJlbWFpbmluZyBwcm9jZXNzZXMgdG8gYmUga2lsbGVkLg0KSW4gbXkgdGVzdCBj
YXNlLCB0aGUgbmV3IHBhdGNoIHJlZHVjZWQgdGhlIG51bWJlciBvZiBpbnZhbGlkIGtpbGwgYmVo
YXZpb3JzIGJ5IDcwJS4NCjQuIG9vbV9zY29yZV9hZGogaXMgYSBnbG9iYWwgY29uZmlndXJhdGlv
biB0aGF0IGNhbm5vdCBhY2hpZXZlIGEga2lsbCBvcmRlciB0aGF0IG9ubHkgDQphZmZlY3RzIGEg
Y2VydGFpbiBtZW1jZy1vb20ta2lsbGVyLiBIb3dldmVyLCB0aGUgb29tX3Byb3RlY3QgbWVjaGFu
aXNtIGluaGVyaXRzIA0KZG93bndhcmRzLCBhbmQgdXNlciBjYW4gb25seSBjaGFuZ2UgdGhlIGtp
bGwgb3JkZXIgb2YgaXRzIG93biBtZW1jZyBvb20sIGJ1dCB0aGUgDQpraWxsIG9yZGVyIG9mIHRo
ZWlyIHBhcmVudCBtZW1jZy1vb20ta2lsbGVyIG9yIGdsb2JhbC1vb20ta2lsbGVyIHdpbGwgbm90
IGJlIGFmZmVjdGVkDQoNCkluIHRoZSBmaW5hbCBkaXNjdXNzaW9uIG9mIHBhdGNoIHYyLCB3ZSBk
aXNjdXNzZWQgdGhhdCBhbHRob3VnaCB0aGUgYWRqdXN0bWVudCByYW5nZSANCm9mIG9vbV9zY29y
ZV9hZGogaXMgWy0xMDAwLDEwMDBdLCBidXQgZXNzZW50aWFsbHkgaXQgb25seSBhbGxvd3MgdHdv
IHVzZWNhc2VzDQooT09NX1NDT1JFX0FESl9NSU4sIE9PTV9TQ09SRV9BREpfTUFYKSByZWxpYWJs
eS4gRXZlcnl0aGluZyBpbiBiZXR3ZWVuIGlzIA0KY2x1bXN5IGF0IGJlc3QuIEluIG9yZGVyIHRv
IHNvbHZlIHRoaXMgcHJvYmxlbSBpbiB0aGUgbmV3IHBhdGNoLCBJIGludHJvZHVjZWQgYSBuZXcg
DQppbmRpY2F0b3Igb29tX2tpbGxfaW5oZXJpdCwgd2hpY2ggY291bnRzIHRoZSBudW1iZXIgb2Yg
dGltZXMgdGhlIGxvY2FsIGFuZCBjaGlsZCANCmNncm91cHMgaGF2ZSBiZWVuIHNlbGVjdGVkIGJ5
IHRoZSBPT00ga2lsbGVyIG9mIHRoZSBhbmNlc3RvciBjZ3JvdXAuIEJ5IG9ic2VydmluZyANCnRo
ZSBwcm9wb3J0aW9uIG9mIG9vbV9raWxsX2luaGVyaXQgaW4gdGhlIHBhcmVudCBjZ3JvdXAsIEkg
Y2FuIGVmZmVjdGl2ZWx5IGFkanVzdCB0aGUgDQp2YWx1ZSBvZiBvb21fcHJvdGVjdCB0byBhY2hp
ZXZlIHRoZSBiZXN0Lg0KDQphYm91dCB0aGUgc2VtYW50aWNzIG9mIG5vbi1sZWFmIG1lbWNncyBw
cm90ZWN0aW9uLA0KSWYgYSBub24tbGVhZiBtZW1jZydzIG9vbV9wcm90ZWN0IHF1b3RhIGlzIHNl
dCwgaXRzIGxlYWYgbWVtY2cgd2lsbCBwcm9wb3J0aW9uYWxseSANCmNhbGN1bGF0ZSB0aGUgbmV3
IGVmZmVjdGl2ZSBvb21fcHJvdGVjdCBxdW90YSBiYXNlZCBvbiBub24tbGVhZiBtZW1jZydzIHF1
b3RhLg0KDQotLSANClRoYW5rcyBmb3IgeW91ciBjb21tZW50IQ0KY2hlbmdrYWl0YW8NCg0K
