Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F875700160
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbjELHX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbjELHXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 03:23:55 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 37C0794;
        Fri, 12 May 2023 00:23:51 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.15])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id C970DB0057605;
        Fri, 12 May 2023 15:23:49 +0800 (CST)
Received: from ZJY01-ACTMBX-06.didichuxing.com (10.79.64.19) by
 ZJY02-ACTMBX-05.didichuxing.com (10.79.65.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 15:23:49 +0800
Received: from ZJY01-ACTMBX-06.didichuxing.com ([10.79.64.19]) by
 ZJY01-ACTMBX-06.didichuxing.com ([10.79.64.19]) with mapi id 15.01.2507.021;
 Fri, 12 May 2023 15:23:49 +0800
X-MD-Sfrom: houweitao@didiglobal.com
X-MD-SrcIP: 10.79.65.15
From:   =?gb2312?B?uu7OsMzSIFZpbmNlbnQgSG91?= <houweitao@didiglobal.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     "akpm@linux-foudation.org" <akpm@linux-foudation.org>,
        "xupengfei@nfschina.com" <xupengfei@nfschina.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?wO6raOL5IFJveSBMaQ==?= <royliyueyi@didiglobal.com>
Subject: RE: [PATCH] fs: hfsplus: fix uninit-value bug in hfsplus_listxattr
Thread-Topic: [PATCH] fs: hfsplus: fix uninit-value bug in hfsplus_listxattr
Thread-Index: AQHZguapG/YHtD2mm0OuOOYj9kHN5a9T+EQAgAJF/cA=
Date:   Fri, 12 May 2023 07:23:49 +0000
Message-ID: <556689d43bf8472697d26fe8c801649b@didiglobal.com>
In-Reply-To: <20230511043602.GG3390869@ZenIV>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.102]
Content-Type: text/plain; charset="gb2312"
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

U29ycnksIEkgd2lsbCB1cGRhdGUgcGF0Y2ggVjIgd2l0aCBuZXcgY29tbWVudCBsYXRlci4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsIFZpcm8gPHZpcm9AZnRwLmxpbnV4
Lm9yZy51az4gT24gQmVoYWxmIE9mIEFsIFZpcm8NClNlbnQ6IFRodXJzZGF5LCBNYXkgMTEsIDIw
MjMgMTI6MzYgUE0NClRvOiC67s6wzNIgVmluY2VudCBIb3UgPGhvdXdlaXRhb0BkaWRpZ2xvYmFs
LmNvbT4NCkNjOiBha3BtQGxpbnV4LWZvdWRhdGlvbi5vcmc7IHh1cGVuZ2ZlaUBuZnNjaGluYS5j
b207IGJyYXVuZXJAa2VybmVsLm9yZzsgZGNoaW5uZXJAcmVkaGF0LmNvbTsgbGludXgtZnNkZXZl
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IMDuq2ji+SBS
b3kgTGkgPHJveWxpeXVleWlAZGlkaWdsb2JhbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBm
czogaGZzcGx1czogZml4IHVuaW5pdC12YWx1ZSBidWcgaW4gaGZzcGx1c19saXN0eGF0dHINCg0K
T24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTA6MjU6MTVBTSArMDgwMCwgaG91d2VpdGFvIHdyb3Rl
Og0KPiBCVUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gc3RybmNtcCsweDExZS8weDE4MCBsaWIv
c3RyaW5nLmM6MzA3DQo+ICBzdHJuY21wKzB4MTFlLzB4MTgwIGxpYi9zdHJpbmcuYzozMDcNCj4g
IGlzX2tub3duX25hbWVzcGFjZSBmcy9oZnNwbHVzL3hhdHRyLmM6NDUgW2lubGluZV0gIG5hbWVf
bGVuIA0KPiBmcy9oZnNwbHVzL3hhdHRyLmM6Mzk3IFtpbmxpbmVdDQo+ICBoZnNwbHVzX2xpc3R4
YXR0cisweGU2MS8weDFhYTAgZnMvaGZzcGx1cy94YXR0ci5jOjc0NiAgdmZzX2xpc3R4YXR0ciAN
Cj4gZnMveGF0dHIuYzo0NzMgW2lubGluZV0NCj4gIGxpc3R4YXR0cisweDcwMC8weDc4MCBmcy94
YXR0ci5jOjgyMA0KPiAgcGF0aF9saXN0eGF0dHIgZnMveGF0dHIuYzo4NDQgW2lubGluZV0gIF9f
ZG9fc3lzX2xsaXN0eGF0dHIgDQo+IGZzL3hhdHRyLmM6ODYyIFtpbmxpbmVdICBfX3NlX3N5c19s
bGlzdHhhdHRyIGZzL3hhdHRyLmM6ODU5IFtpbmxpbmVdDQo+ICBfX2lhMzJfc3lzX2xsaXN0eGF0
dHIrMHgxNzEvMHgzMDAgZnMveGF0dHIuYzo4NTkgIA0KPiBkb19zeXNjYWxsXzMyX2lycXNfb24g
YXJjaC94ODYvZW50cnkvY29tbW9uLmM6MTEyIFtpbmxpbmVdDQo+ICBfX2RvX2Zhc3Rfc3lzY2Fs
bF8zMisweGEyLzB4MTAwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjE3OA0KPiAgZG9fZmFzdF9z
eXNjYWxsXzMyKzB4MzcvMHg4MCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzoyMDMNCj4gIGRvX1NZ
U0VOVEVSXzMyKzB4MWYvMHgzMCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzoyNDYNCj4gIGVudHJ5
X1NZU0VOVEVSX2NvbXBhdF9hZnRlcl9od2ZyYW1lKzB4NzAvMHg4Mg0KPiANCj4gUmVwb3J0ZWQt
Ynk6IHN5emJvdCANCj4gPHN5emJvdCs5MmVmOWVlNDE5ODAzODcxMDIwZUBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tPg0KPiBMaW5rOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/
ZXh0aWQ9OTJlZjllZTQxOTgwMzg3MTAyMGUNCj4gU2lnbmVkLW9mZi1ieTogaG91d2VpdGFvIDxo
b3V3ZWl0YW9AZGlkaWdsb2JhbC5jb20+DQoNCldoeSBkb2VzIGl0IGFjdHVhbGx5IGZpeCBhbnl0
aGluZz8gIE90aGVyIHRoYW4gbWFraW5nIEtNU0FOIFNURlUsIHRoYXQgaXMuLi4NCg0KIkZpbGwg
aXQgd2l0aCB6ZXJvZXMiIG1pZ2h0IG9yIG1pZ2h0IG5vdCBiZSBhIGZpeCBpbiB0aGlzIHBhcnRp
Y3VsYXIgY2FzZSwgYnV0IGl0IHJlYWxseSBuZWVkcyBtb3JlIGRldGFpbGVkIHByb29mLg0KDQpZ
b3UgbWlnaHQgaGF2ZSBmaWd1cmVkIGl0IG91dCwgYnV0IGhvdyBkbyBJIChvciBhbnlib2R5IGVs
c2UpIGV2ZW4gYmVnaW4gdG8gcmVhc29uIGFib3V0IHRoZSBjb3JyZWN0bmVzcyBvZiB0aGF0IGZp
eD8gIEJ5IHJlZG9pbmcgdGhlIGFuYWx5c2lzIGZyb20gc2NyYXRjaCwgc3RhcnRpbmcgd2l0aCAi
aW4gc29tZSBjb25kaXRpb25zIHRoaXMgc3RhY2sgdHJhY2UgbWlnaHQgZW5kIHVwIHJlYWRpbmcg
dW5pbml0aWFsaXplZCBkYXRhIGluIHN0cmJ1ZiI/DQoNCk5BSy4gICpJRiogeW91IGhhdmUgYW4g
ZXhwbGFuYXRpb24gb2Ygd2hhdCdzIGdvaW5nIG9uIGFuZCB3aHkgdGhpcyBjaGFuZ2UgcmVhbGx5
IGZpeGVzIHRoaW5ncywgcGxlYXNlIHJlcG9zdCB3aXRoIHVzZWZ1bCBjb21taXQgbWVzc2FnZS4N
Cg==
