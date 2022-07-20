Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22357B5E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiGTLwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTLwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:52:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B227157268;
        Wed, 20 Jul 2022 04:52:03 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lnv9H1bNxz6J6Mk;
        Wed, 20 Jul 2022 19:48:35 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Jul 2022 13:52:01 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 20 Jul 2022 13:52:01 +0200
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
Thread-Index: AQHYe+tsPH1HC/8x8Uq7oovD5MPpKK1G5r2QgAG+ywCAACILEIAHUz4AgDRUxQCAACKFgP//9y0AgAD3swCAADE5AIAAIobAgAAFq4CAAYjhkA==
Date:   Wed, 20 Jul 2022 11:52:00 +0000
Message-ID: <0b9971555f6b4a319614570aae8bcdf3@huawei.com>
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
        <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
 <3d77db23-51da-be5e-b40d-a92aeb568833@landley.net>
In-Reply-To: <3d77db23-51da-be5e-b40d-a92aeb568833@landley.net>
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
c2RheSwgSnVseSAxOSwgMjAyMiA0OjE1IFBNDQo+IE9uIDcvMTkvMjIgMDc6MjYsIFJvYmVydG8g
U2Fzc3Ugd3JvdGU6DQo+ID4+IFAuUC5TLiBJZiB5b3Ugd2FudCB0byBydW4gYSBjb21tYW5kIG90
aGVyIHRoYW4gL2luaXQgb3V0IG9mIGluaXRyYW1mcyBvciBpbml0cmQsDQo+ID4+IHVzZSB0aGUg
cmRpbml0PS9ydW4vdGhpcyBvcHRpb24uIE5vdGUgdGhlIHJvb3Q9IG92ZXJtb3VudCBtZWNoYW5p
c20gaXMNCj4gPj4gY29tcGxldGVseSBkaWZmZXJlbnQgY29kZSBhbmQgdXNlcyB0aGUgaW5pdD0v
cnVuL3RoaXMgYXJndW1lbnQgaW5zdGVhZCwNCj4gd2hpY2gNCj4gPj4gbWVhbnMgbm90aGluZyB0
byBpbml0cmFtZnMuIEFnYWluLCBzcGVjaWZ5aW5nIHJvb3Q9IHNheXMgd2UgYXJlIE5PVCBzdGF5
aW5nDQo+IGluDQo+ID4+IGluaXRyYW1mcy4NCj4gPg0KPiA+IFNvcnJ5LCBpdCB3YXMgc29tZSB0
aW1lIGFnby4gSSBoYXZlIHRvIGdvIGJhY2sgYW5kIHNlZSB3aHkgd2UgbmVlZGVkDQo+ID4gYSBz
ZXBhcmF0ZSBvcHRpb24uDQo+IA0KPiBEaWQgSSBtZW50aW9uIHRoYXQgaW5pdC9kb19tb3VudHMu
YyBhbHJlYWR5IGhhczoNCj4gDQo+IF9fc2V0dXAoInJvb3Rmc3R5cGU9IiwgZnNfbmFtZXNfc2V0
dXApOw0KDQpJdCBpcyBjb25zdW1lZCBieSBkcmFjdXQgdG9vLCBmb3IgdGhlIHJlYWwgcm9vdCBm
aWxlc3lzdGVtLg0KDQpbLi4uXQ0KDQo+IExvdHMgb2Ygc3lzdGVtcyBydW5uaW5nIGZyb20gaW5p
dHJhbWZzIGFscmVhZHkgRE9OJ1QgaGF2ZSBhIHJvb3Q9LCBzbyB5b3UncmUNCj4gc2F5aW5nIGRy
YWN1dCBiZWluZyBicm9rZW4gd2hlbiB0aGVyZSBpcyBubyByb290PSBpcyBzb21ldGhpbmcgdG8g
d29yayBhcm91bmQNCj4gcmF0aGVyIHRoYW4gZml4IGluIGRyYWN1dCwgZXZlbiB0aG91Z2ggaXQn
cyBiZWVuIGVhc3kgdG8gY3JlYXRlIGEgc3lzdGVtIHdpdGhvdXQNCj4gYSByb290PSBmb3IgYSBk
ZWNhZGUgYW5kIGEgaGFsZiBhbHJlYWR5Li4uDQoNCklmIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkg
dGhhdCByb290PSBvciByb290ZnN0eXBlPSBhcmUgdXNlZCBieQ0Kc29tZW9uZSBlbHNlLCBJIHdv
dWxkIG5vdCBjb3VudCBvbiB0aG9zZSB0byBtYWtlIGEgc2VsZWN0aW9uDQpvZiB0aGUgZmlsZXN5
c3RlbSBmb3Igcm9vdGZzLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgd2hhdCBjYW4gZ28gd3Jvbmcg
aW4gaGF2aW5nIGEgZGVkaWNhdGVkLA0Kbm90IHVzZWQgYnkgYW55b25lIG9wdGlvbiB0byBkbyB0
aGlzIGpvYj8NCg0KVGhhbmtzDQoNClJvYmVydG8NCg==
