Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07570B9AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjEVKMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjEVKMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 06:12:45 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 89BE0BB;
        Mon, 22 May 2023 03:12:41 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.64.19])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id C101411008C201;
        Mon, 22 May 2023 18:12:38 +0800 (CST)
Received: from ZJY01-ACTMBX-06.didichuxing.com (10.79.64.19) by
 ZJY01-ACTMBX-06.didichuxing.com (10.79.64.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 18:12:38 +0800
Received: from ZJY01-ACTMBX-06.didichuxing.com ([10.79.64.19]) by
 ZJY01-ACTMBX-06.didichuxing.com ([10.79.64.19]) with mapi id 15.01.2507.021;
 Mon, 22 May 2023 18:12:38 +0800
X-MD-Sfrom: houweitao@didiglobal.com
X-MD-SrcIP: 10.79.64.19
From:   =?gb2312?B?uu7OsMzSIFZpbmNlbnQgSG91?= <houweitao@didiglobal.com>
To:     "syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com" 
        <syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "glider@google.com" <glider@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr
Thread-Topic: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr
Thread-Index: AdmMiHc/bUH/K2PcSNK2Ykgm8L30yA==
Date:   Mon, 22 May 2023 10:12:38 +0000
Message-ID: <a2f03e2ab9c34dcaabcf9fb11c0a1f45@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.102]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2UgdGhlIHN0cmJ1ZiBpbiBoZnNwbHVzX2xpc3R4YXR0ciB3YXMgYWxsb2NhdGVkIHdpdGgg
a21hbGxvYyBhbmQgZmlsbGVkIHdpdGggaGZzcGx1c191bmkyYXNjLA0Kd2hpY2ggZGlkIG5vdCBm
aWxsICJcMCIgaW4gbGFzdCBieXRlLCAgaW4gc29tZSBjYXNlcywgIHRoZSB1bmluaXRlZCBieXRl
IG1heSBiZSBhY2Nlc3NlZCB3aGVuDQpjb21wYXJlIHRoZSBzdHJidWYgd2l0aCBrbm93biBuYW1l
c3BhY2UuICBCdXQgSSBzdGlsbCBuZWVkIGNoZWNrIHRoZSB2YWx1ZSBvZiB4YXR0ciBpbiBzdHJi
dWYNCnRvIGNvbmZpcm0gdGhlIHJvb3QgY2F1c2UuICBQbGVhc2UgaGVscCB0ZXN0IHdpdGggYmVs
b3cgZGVidWcgcGF0Y2guDQoNCiNzeXogdGVzdDogaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS9r
bXNhbi5naXQgODAzODMyNzNmN2EwDQoNCi0tLSBhL2ZzL2hmc3BsdXMveGF0dHIuYw0KKysrIGIv
ZnMvaGZzcGx1cy94YXR0ci5jDQpAQCAtNjcxLDYgKzY3MSw3IEBAIHN0YXRpYyBzc2l6ZV90IGhm
c3BsdXNfbGlzdHhhdHRyX2ZpbmRlcl9pbmZvKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiAJcmV0
dXJuIHJlczsNCiB9DQogDQorZXh0ZXJuIGJvb2wga21zYW5fZW5hYmxlZDsNCiBzc2l6ZV90IGhm
c3BsdXNfbGlzdHhhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY2hhciAqYnVmZmVyLCBzaXpl
X3Qgc2l6ZSkNCiB7DQogCXNzaXplX3QgZXJyOw0KQEAgLTY4MSw2ICs2ODIsOCBAQCBzc2l6ZV90
IGhmc3BsdXNfbGlzdHhhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY2hhciAqYnVmZmVyLCBz
aXplX3Qgc2l6ZSkNCiAJc3RydWN0IGhmc3BsdXNfYXR0cl9rZXkgYXR0cl9rZXk7DQogCWNoYXIg
KnN0cmJ1ZjsNCiAJaW50IHhhdHRyX25hbWVfbGVuOw0KKwlpbnQgb2ZmID0gMDsNCisJY2hhciAq
ZHVtcGluZm87DQogDQogCWlmICgoIVNfSVNSRUcoaW5vZGUtPmlfbW9kZSkgJiYNCiAJCQkhU19J
U0RJUihpbm9kZS0+aV9tb2RlKSkgfHwNCkBAIC03MDUsNiArNzA4LDEyIEBAIHNzaXplX3QgaGZz
cGx1c19saXN0eGF0dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjaGFyICpidWZmZXIsIHNpemVf
dCBzaXplKQ0KIAkJcmVzID0gLUVOT01FTTsNCiAJCWdvdG8gb3V0Ow0KIAl9DQorCWR1bXBpbmZv
ID0ga3phbGxvYygyMDAsIEdGUF9LRVJORUwpOw0KKwlpZiAoIWR1bXBpbmZvKSB7DQorCQlrZnJl
ZShzdHJidWYpOw0KKwkJcmVzID0gLUVOT01FTTsNCisJCWdvdG8gb3V0Ow0KKwl9DQogDQogCWVy
ciA9IGhmc3BsdXNfZmluZF9hdHRyKGlub2RlLT5pX3NiLCBpbm9kZS0+aV9pbm8sIE5VTEwsICZm
ZCk7DQogCWlmIChlcnIpIHsNCkBAIC03NDEsNiArNzUwLDE1IEBAIHNzaXplX3QgaGZzcGx1c19s
aXN0eGF0dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjaGFyICpidWZmZXIsIHNpemVfdCBzaXpl
KQ0KIAkJCWdvdG8gZW5kX2xpc3R4YXR0cjsNCiAJCX0NCiANCisJCXByX2luZm8oImZpbmQgeGF0
dHIgc2l6ZTolbGQgYW5kIGR1bXAgc3RyYnVmIHByZSAyMCBieXRlczpcbiIsIHNpemUpOw0KKwkJ
V1JJVEVfT05DRShrbXNhbl9lbmFibGVkLCBmYWxzZSk7DQorCQlpZiAoa21zYW5fZW5hYmxlZCA9
PSBmYWxzZSkgew0KKwkJCWZvciAob2ZmID0gMDsgb2ZmIDwgMjA7IG9mZisrKSB7DQorCQkJCXNw
cmludGYoZHVtcGluZm8gKyBvZmYgKiA1LCAiIDB4JTAyeCIsIHN0cmJ1ZltvZmZdKTsNCisJCQl9
DQorCQkJcHJfaW5mbygiJXNcbiIsIGR1bXBpbmZvKTsNCisJCX0NCisJCVdSSVRFX09OQ0Uoa21z
YW5fZW5hYmxlZCwgdHJ1ZSk7DQogCQlpZiAoIWJ1ZmZlciB8fCAhc2l6ZSkgew0KIAkJCWlmIChj
YW5fbGlzdChzdHJidWYpKQ0KIAkJCQlyZXMgKz0gbmFtZV9sZW4oc3RyYnVmLCB4YXR0cl9uYW1l
X2xlbik7DQpAQCAtNzU5LDYgKzc3Nyw3IEBAIHNzaXplX3QgaGZzcGx1c19saXN0eGF0dHIoc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LCBjaGFyICpidWZmZXIsIHNpemVfdCBzaXplKQ0KIA0KIGVuZF9s
aXN0eGF0dHI6DQogCWtmcmVlKHN0cmJ1Zik7DQorCWtmcmVlKGR1bXBpbmZvKTsNCiBvdXQ6DQog
CWhmc19maW5kX2V4aXQoJmZkKTsNCiAJcmV0dXJuIHJlczsNCg==
