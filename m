Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D287721582
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjFDIGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDIGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:06:00 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2BE43C1;
        Sun,  4 Jun 2023 01:05:56 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id D65FB11001AE00;
        Sun,  4 Jun 2023 16:05:53 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 4 Jun 2023 16:05:53 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::7d7d:d727:7a02:e909%7]) with mapi
 id 15.01.2507.021; Sun, 4 Jun 2023 16:05:53 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
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
Thread-Index: AQHZgBDkVfbL1Z6yKEKz1c3DJxWsna9OEngAgAIGrwD//9B5AIABm3eAgBRQXwCABOFqAIAGL2CAgAmQYAA=
Date:   Sun, 4 Jun 2023 08:05:53 +0000
Message-ID: <C5E5137F-8754-40CC-9F0C-0EB3D8AC1EC2@didiglobal.com>
In-Reply-To: <ZHSwhyGnPteiLKs/@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <53CFA6917DA8D6419DBF6114AC5F3BE4@didichuxing.com>
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

QXQgMjAyMy0wNS0yOSAyMjowMjo0NywgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDI1LTA1LTIzIDA3OjM1OjQxLCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIzLTA1LTIyIDIxOjAzOjUwLCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj5bLi4uXQ0KPj4gPj4gSSBoYXZlIGNyZWF0ZWQgYSBu
ZXcgaW5kaWNhdG9yIG9vbV9raWxsX2luaGVyaXQgdGhhdCBtYWludGFpbnMgYSBuZWdhdGl2ZSBj
b3JyZWxhdGlvbiANCj4+ID4+IHdpdGggbWVtb3J5Lm9vbS5wcm90ZWN0LCBzbyB3ZSBoYXZlIGEg
cnVsZXIgdG8gbWVhc3VyZSB0aGUgb3B0aW1hbCB2YWx1ZSBvZiANCj4+ID4+IG1lbW9yeS5vb20u
cHJvdGVjdC4NCj4+ID4NCj4+ID5BbiBleGFtcGxlIG1pZ2h0IGhlbHAgaGVyZS4NCj4+IA0KPj4g
SW4gbXkgdGVzdGluZyBjYXNlLCBieSBhZGp1c3RpbmcgbWVtb3J5Lm9vbS5wcm90ZWN0LCBJIHdh
cyBhYmxlIHRvIHNpZ25pZmljYW50bHkgDQo+PiByZWR1Y2UgdGhlIG9vbV9raWxsX2luaGVyaXQg
b2YgdGhlIGNvcnJlc3BvbmRpbmcgY2dyb3VwLiBJbiBhIHBoeXNpY2FsIG1hY2hpbmUgDQo+PiB3
aXRoIHNldmVyZWx5IG92ZXJzb2xkIG1lbW9yeSwgSSBkaXZpZGVkIGFsbCBjZ3JvdXBzIGludG8g
dGhyZWUgY2F0ZWdvcmllcyBhbmQgDQo+PiBjb250cm9sbGVkIHRoZWlyIHByb2JhYmlsaXR5IG9m
IGJlaW5nIHNlbGVjdGVkIGJ5IHRoZSBvb20ta2lsbGVyIHRvIDAlLCUgMjAsIA0KPj4gYW5kIDgw
JSwgcmVzcGVjdGl2ZWx5Lg0KPg0KPkkgbWlnaHQgYmUganVzdCBkZW5zZSBidXQgSSBhbSBsb3N0
LiBDYW4gd2UgZm9jdXMgb24gdGhlIGJhcmVib25lDQo+c2VtYW50aWMgb2YgdGhlIGdyb3VwIG9v
bSBzZWxlY3Rpb24gYW5kIGtpbGxpbmcgZmlyc3QuIE5vIG1hZ2ljDQo+YXV0by10dW5pbmcgYXQg
dGhpcyBzdGFnZSBwbGVhc2UuDQo+DQo+PiA+PiA+PiBhYm91dCB0aGUgc2VtYW50aWNzIG9mIG5v
bi1sZWFmIG1lbWNncyBwcm90ZWN0aW9uLA0KPj4gPj4gPj4gSWYgYSBub24tbGVhZiBtZW1jZydz
IG9vbV9wcm90ZWN0IHF1b3RhIGlzIHNldCwgaXRzIGxlYWYgbWVtY2cgd2lsbCBwcm9wb3J0aW9u
YWxseSANCj4+ID4+ID4+IGNhbGN1bGF0ZSB0aGUgbmV3IGVmZmVjdGl2ZSBvb21fcHJvdGVjdCBx
dW90YSBiYXNlZCBvbiBub24tbGVhZiBtZW1jZydzIHF1b3RhLg0KPj4gPj4gPg0KPj4gPj4gPlNv
IHRoZSBub24tbGVhZiBtZW1jZyBpcyBuZXZlciB1c2VkIGFzIGEgdGFyZ2V0PyBXaGF0IGlmIHRo
ZSB3b3JrbG9hZCBpcw0KPj4gPj4gPmRpc3RyaWJ1dGVkIG92ZXIgc2V2ZXJhbCBzdWItZ3JvdXBz
PyBPdXIgY3VycmVudCBvb20uZ3JvdXANCj4+ID4+ID5pbXBsZW1lbnRhdGlvbiB0cmF2ZXJzZXMg
dGhlIHRyZWUgdG8gZmluZCBhIGNvbW1vbiBhbmNlc3RvciBpbiB0aGUgb29tDQo+PiA+PiA+ZG9t
YWluIHdpdGggdGhlIG9vbS5ncm91cC4NCj4+ID4+IA0KPj4gPj4gSWYgdGhlIG9vbV9wcm90ZWN0
IHF1b3RhIG9mIHRoZSBwYXJlbnQgbm9uLWxlYWYgbWVtY2cgaXMgbGVzcyB0aGFuIHRoZSBzdW0g
b2YgDQo+PiA+PiBzdWItZ3JvdXBzIG9vbV9wcm90ZWN0IHF1b3RhLCB0aGUgb29tX3Byb3RlY3Qg
cXVvdGEgb2YgZWFjaCBzdWItZ3JvdXAgd2lsbCANCj4+ID4+IGJlIHByb3BvcnRpb25hbGx5IHJl
ZHVjZWQNCj4+ID4+IElmIHRoZSBvb21fcHJvdGVjdCBxdW90YSBvZiB0aGUgcGFyZW50IG5vbi1s
ZWFmIG1lbWNnIGlzIGdyZWF0ZXIgdGhhbiB0aGUgc3VtIA0KPj4gPj4gb2Ygc3ViLWdyb3VwcyBv
b21fcHJvdGVjdCBxdW90YSwgdGhlIG9vbV9wcm90ZWN0IHF1b3RhIG9mIGVhY2ggc3ViLWdyb3Vw
IA0KPj4gPj4gd2lsbCBiZSBwcm9wb3J0aW9uYWxseSBpbmNyZWFzZWQNCj4+ID4+IFRoZSBwdXJw
b3NlIG9mIGRvaW5nIHNvIGlzIHRoYXQgdXNlcnMgY2FuIHNldCBvb21fcHJvdGVjdCBxdW90YSBh
Y2NvcmRpbmcgdG8gDQo+PiA+PiB0aGVpciBvd24gbmVlZHMsIGFuZCB0aGUgc3lzdGVtIG1hbmFn
ZW1lbnQgcHJvY2VzcyBjYW4gc2V0IGFwcHJvcHJpYXRlIA0KPj4gPj4gb29tX3Byb3RlY3QgcXVv
dGEgb24gdGhlIHBhcmVudCBub24tbGVhZiBtZW1jZyBhcyB0aGUgZmluYWwgY292ZXIsIHNvIHRo
YXQgDQo+PiA+PiB0aGUgc3lzdGVtIG1hbmFnZW1lbnQgcHJvY2VzcyBjYW4gaW5kaXJlY3RseSBt
YW5hZ2UgYWxsIHVzZXIgcHJvY2Vzc2VzLg0KPj4gPg0KPj4gPkkgZ3Vlc3MgdGhhdCB5b3UgYXJl
IHRyeWluZyB0byBzYXkgdGhhdCB0aGUgb29tIHByb3RlY3Rpb24gaGFzIGENCj4+ID5zdGFuZGFy
ZCBoaWVyYXJjaGljYWwgYmVoYXZpb3IuIEFuZCB0aGF0IGlzIGZpbmUsIHdlbGwsIGluIGZhY3Qg
aXQgaXMNCj4+ID5tYW5kYXRvcnkgZm9yIGFueSBjb250cm9sIGtub2IgdG8gaGF2ZSBhIHNhbmUg
aGllcmFyY2hpY2FsIHByb3BlcnRpZXMuDQo+PiA+QnV0IHRoYXQgZG9lc24ndCBhZGRyZXNzIG15
IGFib3ZlIHF1ZXN0aW9uLiBMZXQgbWUgdHJ5IGFnYWluLiBXaGVuIGlzIGENCj4+ID5ub24tbGVh
ZiBtZW1jZyBwb3RlbnRpYWxseSBzZWxlY3RlZCBhcyB0aGUgb29tIHZpY3RpbT8gSXQgZG9lc24n
dCBoYXZlDQo+PiA+YW55IHRhc2tzIGRpcmVjdGx5IGJ1dCBpdCBtaWdodCBiZSBhIHN1aXRhYmxl
IHRhcmdldCB0byBraWxsIGEgbXVsdGkNCj4+ID5tZW1jZyBiYXNlZCB3b3JrbG9hZCAoZS5nLiBh
IGZ1bGwgY29udGFpbmVyKS4NCj4+IA0KPj4gSWYgbm9ubGVhZiBtZW1jZyBoYXZlIHRoZSBoaWdo
ZXIgbWVtb3J5IHVzYWdlIGFuZCB0aGUgc21hbGxlciANCj4+IG1lbW9yeS5vb20ucHJvdGVjdCwg
aXQgd2lsbCBoYXZlIHRoZSBoaWdoZXIgdGhlIHByb2JhYmlsaXR5IGJlaW5nIA0KPj4gc2VsZWN0
ZWQgYnkgdGhlIGtpbGxlci4gSWYgdGhlIG5vbi1sZWFmIG1lbWNnIGlzIHNlbGVjdGVkIGFzIHRo
ZSBvb20gDQo+PiB2aWN0aW0sIE9PTS1raWxsZXIgd2lsbCBjb250aW51ZSB0byBzZWxlY3QgdGhl
IGFwcHJvcHJpYXRlIGNoaWxkIA0KPj4gbWVtY2cgZG93bndhcmRzIHVudGlsIHRoZSBsZWFmIG1l
bWNnIGlzIHNlbGVjdGVkLg0KPg0KPlBhcmVudCBtZW1jZyBoYXMgbW9yZSBvciBlcXVhbCBtZW1v
cnkgY2hhcmdlZCB0aGFuIGl0cyBjaGlsZChyZW4pIGJ5DQo+ZGVmaW5pdGlvbi4gTGV0IG1lIHRy
eSB0byBhc2sgZGlmZmVyZW50bHkuIFNheSB5b3UgaGF2ZSB0aGUgZm9sbG93aW5nDQo+aGllcmFy
Y2h5DQo+DQo+CQkgIHJvb3QNCj4JCS8gICAgIFwNCj4gICAgICAgY29udGFpbmVyX0EgICAgIGNv
bnRhaW5lcl9CDQo+ICAgICAob29tLnByb3Q9MTAwTSkgICAob29tLnByb3Q9MjAwTSkNCj4gICAg
ICh1c2FnZT0xMjBNKSAgICAgICh1c2FnZT0xODBNKQ0KPiAgICAgLyAgICAgfCAgICAgXA0KPiAg
ICBBICAgICAgQiAgICAgIEMNCj4gICAgICAgICAgICAgICAgIC8gXA0KPgkJQzEgIEMyDQo+DQo+
DQo+Y29udGFpbmVyX0IgaXMgcHJvdGVjdGVkIHNvIGl0IHNob3VsZCBiZSBleGNsdWRlZC4gQ29y
cmVjdD8gU28gd2UgYXJlIGF0DQo+Y29udGFpbmVyX0EgdG8gY2hvc2UgZnJvbS4gVGhlcmUgYXJl
IG11bHRpcGxlIHdheXMgdGhlIHN5c3RlbSBhbmQNCj5jb250aW5lciBhZG1pbiBtaWdodCB3YW50
IHRvIGFjaGlldmUuDQo+MSkgc3lzdGVtIGFkbWluIG1pZ2h0IHdhbnQgdG8gc2h1dCBkb3duIHRo
ZSB3aG9sZSBjb250YWluZXIuDQo+MikgY29udGluZXIgYWRtaW4gbWlnaHQgd2FudCB0byBzaHV0
IHRoZSB3aG9sZSBjb250YWluZXIgZG93bg0KPjMpIGNvbnQuIGFkbWluIG1pZ2h0IHdhbnQgdG8g
c2h1dCBkb3duIGEgd2hvbGUgc3ViIGdyb3VwIChlLmcuIEMgYXMgaXQNCj4gICBpcyBhIHNlbGYg
Y29udGFpbmVkIHdvcmtsb2FkIGFuZCBraWxsaW5nIHBvcnRpb24gb2YgaXQgd2lsbCBwdXQgaXQg
aW50bw0KPiAgIGluY29uc2lzdGVudCBzdGF0ZSkuDQo+NCkgY29udC4gYWRtaW4gbWlnaHQgd2Fu
dCB0byBraWxsIHRoZSBtb3N0IGV4Y2VzcyBjZ3JvdXAgd2l0aCB0YXNrcyAoaS5lLiBhDQo+ICAg
bGVhZiBtZW1jZykuDQo+NSkgYWRtaW4gbWlnaHQgd2FudCB0byBraWxsIGEgcHJvY2VzcyBpbiB0
aGUgbW9zdCBleGNlc3MgbWVtY2cuDQo+DQo+Tm93IHdlIGFscmVhZHkgaGF2ZSBvb20uZ3JvdXAg
dGhpbmd5IHRoYXQgY2FuIGRyaXZlIHRoZSBncm91cCBraWxsaW5nDQo+cG9saWN5IGJ1dCBpdCBp
cyBub3QgcmVhbGx5IGNsZWFyIGhvdyB5b3Ugd2FudCB0byBpbmNvcnBvcmF0ZSB0aGF0IHRvDQo+
dGhlIHByb3RlY3Rpb24uDQo+DQo+QWdhaW4sIEkgdGhpbmsgdGhhdCBhbiBvb20ucHJvdGVjdGlv
biBtYWtlcyBzZW5zZSBidXQgdGhlIHNlbWFudGljIGhhcw0KPnRvIGJlIHZlcnkgY2FyZWZ1bGx5
IHRob3VnaHQgdGhyb3VnaCBiZWNhdXNlIGl0IGlzIHF1aXRlIGVhc3kgdG8gY3JlYXRlDQo+Y29y
bmVyIGNhc2VzIGFuZCB3ZWlyZCBiZWhhdmlvci4gSSBhbHNvIHRoaW5rIHRoYXQgb29tLmdyb3Vw
IGhhcyB0byBiZQ0KPmNvbnNpc3RlbnQgd2l0aCB0aGUgcHJvdGVjdGlvbi4NCg0KVGhlIGJhcmVi
b25lIHNlbWFudGljIG9mIHRoZSBmdW5jdGlvbiBpbXBsZW1lbnRlZCBieSBteSBwYXRjaCBhcmUg
DQpzdW1tYXJpemVkIGFzIGZvbGxvd3M6DQpNZW1jZyBvbmx5IGFsbG93cyBwcm9jZXNzZXMgaW4g
dGhlIG1lbWNnIHRvIGJlIHNlbGVjdGVkIGJ5IHRoZWlyIA0KYW5jZXN0b3IncyBPT00ga2lsbGVy
IHdoZW4gdGhlIG1lbW9yeSB1c2FnZSBleGNlZWRzICJvb20ucHJvdGVjdCINCg0KSXQgc2hvdWxk
IGJlIG5vdGVkIHRoYXQgIm9vbS5wcm90ZWN0IiBhbmQgIm9vbS5ncm91cCIgYXJlIGNvbXBsZXRl
bHkgDQpkaWZmZXJlbnQgdGhpbmdzLCBhbmQga25lYWRpbmcgdGhlbSB0b2dldGhlciBtYXkgbWFr
ZSB0aGUgZXhwbGFuYXRpb24gDQptb3JlIGNvbmZ1c2luZy4NCg0KPj4gPj4gPkFsbCB0aGF0IGJl
aW5nIHNhaWQgYW5kIHdpdGggdGhlIHVzZWNhc2UgZGVzY3JpYmVkIG1vcmUgc3BlY2lmaWNhbGx5
LiBJDQo+PiA+PiA+Y2FuIHNlZSB0aGF0IG1lbWNnIGJhc2VkIG9vbSB2aWN0aW0gc2VsZWN0aW9u
IG1ha2VzIHNvbWUgc2Vuc2UuIFRoYXQNCj4+ID4+ID5tZW5hcyB0aGF0IGl0IGlzIGFsd2F5cyBh
IG1lbWNnIHNlbGVjdGVkIGFuZCBhbGwgdGFza3Mgd2l0aGluZyBraWxsZWQuDQo+PiA+PiA+TWVt
Y2cgYmFzZWQgcHJvdGVjdGlvbiBjYW4gYmUgdXNlZCB0byBldmFsdWF0ZSB3aGljaCBtZW1jZyB0
byBjaG9vc2UgYW5kDQo+PiA+PiA+dGhlIG92ZXJhbGwgc2NoZW1lIHNob3VsZCBiZSBzdGlsbCBt
YW5hZ2VhYmxlLiBJdCB3b3VsZCBpbmRlZWQgcmVzZW1ibGUNCj4+ID4+ID5tZW1vcnkgcHJvdGVj
dGlvbiBmb3IgdGhlIHJlZ3VsYXIgcmVjbGFpbS4NCj4+ID4+ID4NCj4+ID4+ID5PbmUgdGhpbmcg
dGhhdCBpcyBzdGlsbCBub3QgcmVhbGx5IGNsZWFyIHRvIG1lIGlzIHRvIGhvdyBncm91cCB2cy4N
Cj4+ID4+ID5ub24tZ3JvdXAgb29tcyBjb3VsZCBiZSBoYW5kbGVkIGdyYWNlZnVsbHkuIFJpZ2h0
IG5vdyB3ZSBjYW4gaGFuZGxlIHRoYXQNCj4+ID4+ID5iZWNhdXNlIHRoZSBvb20gc2VsZWN0aW9u
IGlzIHN0aWxsIHByb2Nlc3MgYmFzZWQgYnV0IHdpdGggdGhlIHByb3RlY3Rpb24NCj4+ID4+ID50
aGlzIHdpbGwgYmVjb21lIG1vcmUgcHJvYmxlbWF0aWMgYXMgZXhwbGFpbmVkIHByZXZpb3VzbHku
IEVzc2VudGlhbGx5DQo+PiA+PiA+d2Ugd291bGQgbmVlZCB0byBlbmZvcmNlIHRoZSBvb20gc2Vs
ZWN0aW9uIHRvIGJlIG1lbWNnIGJhc2VkIGZvciBhbGwNCj4+ID4+ID5tZW1jZ3MuIE1heWJlIGEg
bW91bnQga25vYj8gV2hhdCBkbyB5b3UgdGhpbms/DQo+PiA+PiANCj4+ID4+IFRoZXJlIGlzIGEg
ZnVuY3Rpb24gaW4gdGhlIHBhdGNoIHRvIGRldGVybWluZSB3aGV0aGVyIHRoZSBvb21fcHJvdGVj
dCANCj4+ID4+IG1lY2hhbmlzbSBpcyBlbmFibGVkLiBBbGwgbWVtb3J5Lm9vbS5wcm90ZWN0IG5v
ZGVzIGRlZmF1bHQgdG8gMCwgc28gdGhlIGZ1bmN0aW9uIA0KPj4gPj4gPGlzX3Jvb3Rfb29tX3By
b3RlY3Q+IHJldHVybnMgMCBieSBkZWZhdWx0Lg0KPj4gPg0KPj4gPkhvdyBjYW4gYW4gYWRtaW4g
ZGV0ZXJtaW5lIHdoYXQgaXMgdGhlIGN1cnJlbnQgb29tIGRldGVjdGlvbiBsb2dpYz8NCj4+IA0K
Pj4gVGhlIG1lbW9yeS5vb20ucHJvdGVjdCBhcmUgc2V0IGJ5IHRoZSBhZG1pbmlzdHJhdG9yIHRo
ZW1zZWx2ZXMsIGFuZCB0aGV5IA0KPj4gbXVzdCBrbm93IHdoYXQgdGhlIGN1cnJlbnQgT09NIHBv
bGljeSBpcy4gUmVhZGluZyB0aGUgbWVtb3J5Lm9vbS5wcm90ZWN0IA0KPj4gb2YgdGhlIGZpcnN0
IGxldmVsIGNncm91cCBkaXJlY3RvcnkgYW5kIG9ic2VydmluZyB3aGV0aGVyIGl0IGlzIDAgY2Fu
IGFsc28gDQo+PiBkZXRlcm1pbmUgd2hldGhlciB0aGUgb29tLnByb3RlY3QgcG9saWN5IGlzIGVu
YWJsZWQuDQo+DQo+SG93IGRvIHlvdSBhY2hpZXZlIHRoYXQgZnJvbSB3aXRoaW5nIGEgY29udGFp
bmVyIHdoaWNoIGRvZXNuJ3QgaGF2ZSBhDQo+ZnVsbCB2aXNpYmlsaXR5IHRvIHRoZSBjZ3JvdXAg
dHJlZT8NCg0KVGhlIGNvbnRhaW5lciBkb2VzIG5vdCBuZWVkIHRvIGhhdmUgZnVsbCB2aXNpYmls
aXR5IHRvIHRoZSBjZ3JvdXAgdHJlZSwgZnVuY3Rpb24gDQoib29tLnByb3RlY3QiIHJlcXVpcmVz
IGl0IHRvIG9ubHkgZm9jdXMgb24gbG9jYWwgY2dyb3VwIGFuZCBzdWJncm91cCB0cmVlcy4NCg0K
LS0NClRoYW5rcyBmb3IgeW91ciBjb21tZW50IQ0KY2hlbmdrYWl0YW8NCg0K
