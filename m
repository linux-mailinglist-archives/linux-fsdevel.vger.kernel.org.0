Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A46579E9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 15:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbiGSNDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiGSNBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:01:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42309C242;
        Tue, 19 Jul 2022 05:26:06 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnJ103Zbcz6HJf3;
        Tue, 19 Jul 2022 20:24:20 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 19 Jul 2022 14:26:02 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 19 Jul 2022 14:26:02 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Rob Landley <rob@landley.net>, Jim Baxter <jim_baxter@mentor.com>,
        "Eugeniu Rosca" <erosca@de.adit-jv.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bug-cpio@gnu.org" <bug-cpio@gnu.org>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "takondra@cisco.com" <takondra@cisco.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "james.w.mcmechan@gmail.com" <james.w.mcmechan@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Thread-Topic: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Thread-Index: AQHYe+tsPH1HC/8x8Uq7oovD5MPpKK1G5r2QgAG+ywCAACILEIAHUz4AgDRUxQCAACKFgP//9y0AgAD3swCAADE5AIAAIobA
Date:   Tue, 19 Jul 2022 12:26:02 +0000
Message-ID: <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
        <1561909199.3985.33.camel@linux.ibm.com>
        <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
        <1561991485.4067.14.camel@linux.ibm.com>
        <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
        <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
        <20220609102627.GA3922@lxhi-065>
        <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
        <20220610153336.GA8881@lxhi-065>
        <4bc349a59e4042f7831b1190914851fe@huawei.com>
        <20220615092712.GA4068@lxhi-065>
        <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
        <f82d4961986547b28b6de066219ad08b@huawei.com>
        <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
        <8e6a723874644449be99fcebb0905058@huawei.com>
 <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
In-Reply-To: <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBSb2IgTGFuZGxleSBbbWFpbHRvOnJvYkBsYW5kbGV5Lm5ldF0NCj4gU2VudDogVHVl
c2RheSwgSnVseSAxOSwgMjAyMiAxOjUxIFBNDQo+IE9uIDcvMTkvMjIgMDE6NTUsIFJvYmVydG8g
U2Fzc3Ugd3JvdGU6DQo+ID4+IFRoYW5rIHlvdSwgSSBoYXZlIHRlc3RlZCB0aGF0IHBhdGNoIGJ1
dCB0aGUgcHJvYmxlbSByZW1haW5lZC4gSGVyZSBpcyBteQ0KPiA+PiBjb21tYW5kIGxpbmUsIEkg
d29uZGVyIGlmIHRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZy4NCj4gPj4NCj4gPj4gS2VybmVsIGNv
bW1hbmQgbGluZTogcncgcm9vdGZzdHlwZT1pbml0cmFtdG1wZnMgcm9vdD0vZGV2L3JhbTANCj4g
Pj4gaW5pdHJkPTB4NTAwMDAwMDAwIHJvb3R3YWl0DQo+ID4NCj4gPiBJdCBpcyBqdXN0IGluaXRy
YW10bXBmcywgd2l0aG91dCByb290ZnN0eXBlPS4NCj4gDQo+IFdob2V2ZXIgd3JvdGUgdGhhdCBw
YXRjaCByZWFsbHkgZG9lc24ndCB1bmRlcnN0YW5kIGhvdyB0aGlzIHN0dWZmIHdvcmtzLiBJIGNh
bg0KPiB0ZWxsIGZyb20gdGhlIG5hbWUuDQoNCkhpIFJvYg0KDQpzdXJlbHksIEkgc2hvdWxkIGhh
dmUgYmVlbiBtb3JlIGNhcmVmdWwgaW4gY2hvb3NpbmcgdGhlIG5hbWUgb2YNCnRoZSBvcHRpb24u
DQoNCj4gVGVjaG5pY2FsbHksIGluaXRyYW1mcyBpcyB0aGUgbG9hZGVyLCBJLkUuICJpbml0IHJh
bWZzIi4gVGhlIGZpbGVzeXN0ZW0gaW5zdGFuY2UNCj4gaXMgY2FsbGVkICJyb290ZnMiIChoZW5j
ZSB0aGUgbmFtZSBpbiAvcHJvYy9tb3VudHMgd2hlbiB0aGUgaW5zYW5lIHNwZWNpYWwgY2FzZQ0K
PiB0aGUga2VybmVsIGFkZGVkIGRvZXNuJ3QgaGlkZSBpbmZvcm1hdGlvbiBmcm9tIHBlb3BsZSwg
bWFraW5nIGFsbCB0aGlzIGhhcmRlciB0bw0KPiB1bmRlcnN0YW5kIGZvciBubyBvYnZpb3VzIHJl
YXNvbikuDQoNCk9rLCB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4NCg0KPiByYW1mcyBhbmQg
dG1wZnMgYXJlIHR3byBkaWZmZXJlbnQgZmlsZXN5c3RlbXMgdGhhdCBDT1VMRCBiZSB1c2VkIHRv
IGltcGxlbWVudA0KPiByb290ZnMuIChMYXN0IEkgY2hlY2tlZCB0aGV5IHdlcmUgdGhlIG9ubHkg
cmFtIGJhY2tlZCBmaWxlc3lzdGVtcyBpbiBMaW51eC4pDQoNClllcywgdGhhdCBwYXJ0IEkgZ290
IGl0Lg0KDQo+IElmIGEgc3lzdGVtIGFkbWluaXN0cmF0b3Igc2F5cyB0aGV5J3JlIGdvaW5nIHRv
IGluc3RhbGwgeW91ciBzZXJ2ZXIncyByb290DQo+IHBhcnRpdGlvbiB1c2luZyB0aGUgInJlaXNl
cnhmcyIgZmlsZXN5c3RlbSwgSSB3b3VsZCBub3QgYmUgcmVhc3N1cmVkLg0KDQpEZWZpbml0ZWx5
Lg0KDQpbLi4uXQ0KDQo+IFAuUC5TLiBJZiB5b3Ugd2FudCB0byBydW4gYSBjb21tYW5kIG90aGVy
IHRoYW4gL2luaXQgb3V0IG9mIGluaXRyYW1mcyBvciBpbml0cmQsDQo+IHVzZSB0aGUgcmRpbml0
PS9ydW4vdGhpcyBvcHRpb24uIE5vdGUgdGhlIHJvb3Q9IG92ZXJtb3VudCBtZWNoYW5pc20gaXMN
Cj4gY29tcGxldGVseSBkaWZmZXJlbnQgY29kZSBhbmQgdXNlcyB0aGUgaW5pdD0vcnVuL3RoaXMg
YXJndW1lbnQgaW5zdGVhZCwgd2hpY2gNCj4gbWVhbnMgbm90aGluZyB0byBpbml0cmFtZnMuIEFn
YWluLCBzcGVjaWZ5aW5nIHJvb3Q9IHNheXMgd2UgYXJlIE5PVCBzdGF5aW5nIGluDQo+IGluaXRy
YW1mcy4NCg0KU29ycnksIGl0IHdhcyBzb21lIHRpbWUgYWdvLiBJIGhhdmUgdG8gZ28gYmFjayBh
bmQgc2VlIHdoeSB3ZSBuZWVkZWQNCmEgc2VwYXJhdGUgb3B0aW9uLiBNYXliZSBvbWl0dGluZyBy
b290PSB3YXMgaW1wYWN0aW5nIG9uIG1vdW50aW5nDQp0aGUgcmVhbCByb290IGZpbGVzeXN0ZW0u
IFdpbGwgZ2V0IHRoYXQgaW5mb3JtYXRpb24uDQoNCkludHVpdGl2ZWx5LCBnaXZlbiB0aGF0IHJv
b3Q9IGlzIGNvbnN1bWVkIGZvciBleGFtcGxlIGJ5IGRyYWN1dCwgaXQgc2VlbXMNCmEgc2FmZXIg
Y2hvaWNlIHRvIGhhdmUgYW4gb3B0aW9uIHRvIGV4cGxpY2l0bHkgY2hvb3NlIHRoZSBkZXNpcmVk
IGZpbGVzeXN0ZW0uDQoNClJvYmVydG8NCg==
