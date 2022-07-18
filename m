Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED95787C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiGRQtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRQtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:49:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8C336;
        Mon, 18 Jul 2022 09:49:31 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LmnvT21FCz6HJbV;
        Tue, 19 Jul 2022 00:47:49 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 18 Jul 2022 18:49:29 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Mon, 18 Jul 2022 18:49:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Jim Baxter <jim_baxter@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
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
Thread-Index: AQHYe+tsPH1HC/8x8Uq7oovD5MPpKK1G5r2QgAG+ywCAACILEIAHUz4AgDRUxQCAACKFgA==
Date:   Mon, 18 Jul 2022 16:49:28 +0000
Message-ID: <f82d4961986547b28b6de066219ad08b@huawei.com>
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
In-Reply-To: <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
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

PiBGcm9tOiBKaW0gQmF4dGVyIFttYWlsdG86amltX2JheHRlckBtZW50b3IuY29tXQ0KPiBTZW50
OiBNb25kYXksIEp1bHkgMTgsIDIwMjIgNjozNiBQTQ0KPiBPbiAxNS8wNi8yMDIyIDEwOjI3LCBF
dWdlbml1IFJvc2NhIHdyb3RlOg0KPiA+IEhlbGxvIFJvYmVydG8sDQo+ID4NCj4gPiBPbiBGciwg
SnVuIDEwLCAyMDIyIGF0IDAzOjM4OjI0ICswMDAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+
PiBJIHdvdWxkIGJlIGhhcHB5IHRvIGFkZHJlc3MgdGhlIHJlbWFpbmluZyBjb25jZXJucywgb3Ig
dGFrZSBtb3JlDQo+ID4+IHN1Z2dlc3Rpb25zLCBhbmQgdGhlbiBkZXZlbG9wIGEgbmV3IHZlcnNp
b24gb2YgdGhlIHBhdGNoIHNldC4NCj4gPiBJIGZhY2UgYSBudW1iZXIgb2YgY29uZmxpY3RzIHdo
ZW4gSSB0cnkgdG8gcmViYXNlIHRoZSBsYXRlc3Qgb3BlbkV1bGVyDQo+ID4gY29tbWl0cyBhZ2Fp
bnN0IHZhbmlsbGEgbWFzdGVyICh2NS4xOS1yYzIpLiBEbyB5b3UgdGhpbmsgaXQgaXMgcG9zc2li
bGUNCj4gPiB0byBzdWJtaXQgdGhlIHJlYmFzZWQgdmVyc2lvbiB0byBNTD8NCj4gPg0KPiA+IElu
IGFkZGl0aW9uLCBJIGNhbiBhbHNvIHNlZSBzb21lIG9wZW4vdW5yZXNvbHZlZCBwb2ludHMgZnJv
bSBNaW1pIFsqXS4NCj4gPiBEaWQgeW91IGJ5IGNoYW5jZSBmaW5kIHNvbWUgbXV0dWFsIGFncmVl
bWVudCBvZmZsaW5lIG9yIGRvIHlvdSB0aGluaw0KPiA+IHRoZXkgd291bGQgc3RpbGwgcG90ZW50
aWFsbHkgbmVlZCBzb21lIGF0dGVudGlvbj8NCj4gPg0KPiA+IE1heWJlIHdlIGNhbiByZXN1bWUg
dGhlIGRpc2N1c3Npb24gb25jZSB5b3Ugc3VibWl0IHRoZSByZWJhc2VkIHNlcmllcz8NCj4gPg0K
PiA+IE1hbnkgdGhhbmtzIGFuZCBsb29raW5nIGZvcndhcmQgdG8gaXQuDQo+ID4NCj4gPiBbKl0g
UG90ZW50aWFsbHkgY29tbWVudHMgd2hpY2ggZGVzZXJ2ZSBhIHJlcGx5L2NsYXJpZmljYXRpb24v
cmVzb2x1dGlvbg0KPiA+DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNTYxOTg1
NjUyLjQwNDkuMjQuY2FtZWxAbGludXguaWJtLmNvbS8jdA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMTU2MTkwODQ1Ni4zOTg1LjIzLmNhbWVsQGxpbnV4LmlibS5jb20vDQo+ID4N
Cj4gPiBCUiwgRXVnZW5pdS4NCj4gPg0KPiANCj4gDQo+IEhlbGxvLA0KPiANCj4gSSBoYXZlIGJl
ZW4gdGVzdGluZyB0aGVzZSBwYXRjaGVzIGFuZCBkbyBub3Qgc2VlIHRoZSB4YXR0ciBpbmZvcm1h
dGlvbiB3aGVuDQo+IHRyeWluZyB0byByZXRyaWV2ZSBpdCB3aXRoaW4gdGhlIGluaXRyYW1mcywg
ZG8geW91IGhhdmUgYW4gZXhhbXBsZSBvZiBob3cNCj4geW91IHRlc3RlZCB0aGlzIG9yaWdpbmFs
bHk/DQoNCkhpIEppbSwgYWxsDQoNCmFwb2xvZ2llcywgSSBkaWRuJ3QgZmluZCB5ZXQgdGhlIHRp
bWUgdG8gbG9vayBhdCB0aGlzLg0KDQpVaG0sIEkgZ3Vlc3MgdGhpcyBjb3VsZCBiZSBzb2x2ZWQg
d2l0aDoNCg0KaHR0cHM6Ly9naXRodWIuY29tL29wZW5ldWxlci1taXJyb3Iva2VybmVsL2NvbW1p
dC8xOGE1MDJmN2UzYjFkZTdiOWJhMGM3MDg5NmNlMDhlZTEzZDA1MmRhDQoNCmFuZCBhZGRpbmcg
aW5pdHJhbXRtcGZzIHRvIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLiBZb3UgYXJlDQpwcm9iYWJs
eSB1c2luZyByYW1mcywgd2hpY2ggZG9lcyBub3QgaGF2ZSB4YXR0ciBzdXBwb3J0Lg0KDQo+IFNv
IGZhciBJIGhhdmUgc2V0IHRoZSB4YXR0ciBpbiB0aGUgcm9vdGZzIGJlZm9yZSBjcmVhdGluZyB0
aGUgY3BpbyBmaWxlIGxpa2UgdGhpczoNCj4gJCBzZXRmYXR0ciAtbiB1c2VyLmNvbW1lbnQgLXYg
InRoaXMgaXMgYSBjb21tZW50IiB0ZXN0LnR4dA0KPiBJZiBJIGFjY2VzcyB0aGUgZGF0YSBoZXJl
IGl0IHdvcmtzOg0KPiAkIGdldGZhdHRyIHRlc3QudHh0DQo+ICMgZmlsZTogdGVzdC50eHQNCj4g
dXNlci5jb21tZW50DQo+IA0KPiANCj4gVGhlbiBJIHBhY2thZ2UgaXQgYW5kIHRyeSB0byB2ZXJp
ZnkgaXQgd2l0aCB0aGlzIGNvbW1hbmQ6DQo+ICRnZXRmYXR0ciAvdGVzdC50eHQNCg0KSSBhc3N1
bWUgeW91IHRyeSB0byBwYWNrL3VucGFjaywgcmlnaHQ/IElmIEkgcmVtZW1iZXIgY29ycmVjdGx5
DQpJIG9ubHkgaW1wbGVtZW50ZWQgdGhlIHBhY2sgcGFydC4gVW5wYWNraW5nIGlzIGRvbmUgYnkg
dGhlIGtlcm5lbA0KKGJ1dCB5b3UgYXJlIHJpZ2h0LCBpdCBzaG91bGQgYmUgZG9uZSBieSB1c2Vy
IHNwYWNlIHRvbykuDQoNCj4gV2hpY2ggcmV0dXJucyB0byB0aGUgY29tbWFuZCBsaW5lIHdpdGhv
dXQgdGhlIGRhdGEuDQo+IA0KPiANCj4gDQo+IEkgYmVsaWV2ZSB0aGUgY3BpbyBpcyB3b3JraW5n
IGJlY2F1c2UgSSBzZWUgdGhlIGZpbGUgL01FVEFEQVRBXCFcIVwhIGluDQo+IHRoZSB0YXJnZXQg
cm9vdCBmaWxlc3lzdGVtLCB3aGljaCBzaG93cyB0aGUgZm9sbG93aW5nIHdoZW4gdmlld2VkIHdp
dGggY2F0IC1lOg0KPiAwMDAwMDAyOF5BXkF1c2VyLmNvbW1lbnReQHRoaXMgaXMgYSBjb21tZW50
DQo+IA0KPiBUaGlzIG1hdGNoZXMgdGhlIGRhdGEgSSBmZWQgaW4gYXQgdGhlIHN0YXJ0LCBzbyBJ
IGJlbGlldmUgdGhlIGRhdGEgaXMgYmVpbmcNCj4gdHJhbnNmZXJyZWQgY29ycmVjdGx5IGJ1dCBJ
IGFtIGFjY2Vzc2lvbmluZyBpdCB3aXRoIHRoZSB3cm9uZyB0b29scy4NCg0KWWVzLCB4YXR0cnMg
YXJlIG1hcnNoYWxsZWQgaW4gdGhlIE1FVEFEQVRBISEhIGZpbGUsIG9uZSBwZXIgcmVndWxhciBm
aWxlDQp4YXR0cnMgYXJlIGFwcGxpZWQgdG8uIFhhdHRycyBhcmUgYXBwbGllZCB0byB0aGUgcHJl
dmlvdXMgcmVndWxhciBmaWxlLg0KVGhhdCBmaWxlIG5hbWUgd2FzIHByZWZlcnJlZCB0byBhZGRp
bmcgYSBzdWZmaXggdG8gdGhlIGZpbGUsIHRvIGF2b2lkDQpyZWFjaGluZyB0aGUgZmlsZW5hbWUg
c2l6ZSBsaW1pdC4NCg0KUm9iZXJ0bw0K
