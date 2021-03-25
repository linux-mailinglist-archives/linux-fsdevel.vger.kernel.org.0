Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78481348837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 06:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhCYFF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 01:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCYFFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:05:19 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA0A9C06174A;
        Wed, 24 Mar 2021 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=Zmxu5mXYLbKAJYF01aL8kRMb6lIz4CewMqsk
        cpMGitY=; b=C62VsWKyXF+/cRtF5FYiAt+ePDmBBCPbIXoMjhksUwUhaDf+4cuv
        PtnunBtcLk74zF1PnGZoGEPi773SAghEXxghMOKu4ThcVvXUFGu6Cn3HIsfaEQ9X
        osMZUsBklF1v1MylWGtQta+QQwoZH78/1rdF3q88QU3fKT1gcY0akhA=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 25 Mar
 2021 13:04:54 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Thu, 25 Mar 2021 13:04:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Vivek Goyal" <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] fuse: Fix a potential double free in
 virtio_fs_get_tree
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <20210323171003.GC483930@redhat.com>
References: <20210323051831.13575-1-lyl2019@mail.ustc.edu.cn>
 <20210323171003.GC483930@redhat.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <769a5512.127aa.17867c56a27.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygDX3U32GVxgVTk9AA--.1W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsKBlQhn5ZgeQACsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlZpdmVrIEdveWFs
IiA8dmdveWFsQHJlZGhhdC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyMS0wMy0yNCAwMToxMDow
MyAo5pif5pyf5LiJKQ0KPiDmlLbku7bkuro6ICJMdiBZdW5sb25nIiA8bHlsMjAxOUBtYWlsLnVz
dGMuZWR1LmNuPg0KPiDmioTpgIE6IHN0ZWZhbmhhQHJlZGhhdC5jb20sIG1pa2xvc0BzemVyZWRp
Lmh1LCB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZywgbGludXgtZnNk
ZXZlbEB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li7
6aKYOiBSZTogW1BBVENIXSBmdXNlOiBGaXggYSBwb3RlbnRpYWwgZG91YmxlIGZyZWUgaW4gdmly
dGlvX2ZzX2dldF90cmVlDQo+IA0KPiBPbiBNb24sIE1hciAyMiwgMjAyMSBhdCAxMDoxODozMVBN
IC0wNzAwLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+IEluIHZpcnRpb19mc19nZXRfdHJlZSwgZm0g
aXMgYWxsb2NhdGVkIGJ5IGt6YWxsb2MoKSBhbmQNCj4gPiBhc3NpZ25lZCB0byBmc2MtPnNfZnNf
aW5mbyBieSBmc2MtPnNfZnNfaW5mbz1mbSBzdGF0ZW1lbnQuDQo+ID4gSWYgdGhlIGt6YWxsb2Mo
KSBmYWlsZWQsIGl0IHdpbGwgZ290byBlcnIgZGlyZWN0bHksIHNvIHRoYXQNCj4gPiBmc2MtPnNf
ZnNfaW5mbyBtdXN0IGJlIG5vbi1OVUxMIGFuZCBmbSB3aWxsIGJlIGZyZWVkLg0KPiANCj4gc2dl
dF9mYygpIHdpbGwgZWl0aGVyIGNvbnN1bWUgZnNjLT5zX2ZzX2luZm8gaW4gY2FzZSBhIG5ldyBz
dXBlcg0KPiBibG9jayBpcyBhbGxvY2F0ZWQgYW5kIHNldCBmc2MtPnNfZnNfaW5mby4gSW4gdGhh
dCBjYXNlIHdlIGRvbid0DQo+IGZyZWUgZmMgb3IgZm0uDQo+IA0KPiBPciwgc2dldF9mYygpIHdp
bGwgcmV0dXJuIHdpdGggZnNjLT5zX2ZzX2luZm8gc2V0IGluIGNhc2Ugd2UgYWxyZWFkeQ0KPiBm
b3VuZCBhIHN1cGVyIGJsb2NrLiBJbiB0aGF0IGNhc2Ugd2UgbmVlZCB0byBmcmVlIGZjIGFuZCBm
bS4NCj4gDQo+IEluIGNhc2Ugb2YgZXJyb3IgZnJvbSBzZ2V0X2ZjKCksIGZjL2ZtIG5lZWQgdG8g
YmUgZnJlZWQgZmlyc3QgYW5kDQo+IHRoZW4gZXJyb3IgbmVlZHMgdG8gYmUgcmV0dXJuZWQgdG8g
Y2FsbGVyLg0KPiANCj4gICAgICAgICBpZiAoSVNfRVJSKHNiKSkNCj4gICAgICAgICAgICAgICAg
IHJldHVybiBQVFJfRVJSKHNiKTsNCj4gDQo+IA0KPiBJZiB3ZSBhbGxvY2F0ZWQgYSBuZXcgc3Vw
ZXIgYmxvY2sgaW4gc2dldF9mYygpLCB0aGVuIG5leHQgc3RlcCBpcw0KPiB0byBpbml0aWFsaXpl
IGl0Lg0KPiANCj4gICAgICAgICBpZiAoIXNiLT5zX3Jvb3QpIHsNCj4gICAgICAgICAgICAgICAg
IGVyciA9IHZpcnRpb19mc19maWxsX3N1cGVyKHNiLCBmc2MpOw0KPiAJfQ0KPiANCj4gSWYgd2Ug
cnVuIGludG8gZXJyb3JzIGhlcmUsIHRoZW4gZmMvZm0gbmVlZCB0byBiZSBmcmVlZC4NCj4gDQo+
IFNvIGN1cnJlbnQgY29kZSBsb29rcyBmaW5lIHRvIG1lLg0KPiANCj4gVml2ZWsNCj4gDQo+ID4g
DQo+ID4gQnV0IGxhdGVyIGZtIGlzIGZyZWVkIGFnYWluIHdoZW4gdmlydGlvX2ZzX2ZpbGxfc3Vw
ZXIoKSBmaWFsZWQuDQo+ID4gSSB0aGluayB0aGUgc3RhdGVtZW50IGlmIChmc2MtPnNfZnNfaW5m
bykge2tmcmVlKGZtKTt9IGlzDQo+ID4gbWlzcGxhY2VkLg0KPiA+IA0KPiA+IE15IHBhdGNoIHB1
dHMgdGhpcyBzdGF0ZW1lbnQgaW4gdGhlIGNvcnJlY3QgcGFsY2UgdG8gYXZvaWQNCj4gPiBkb3Vi
bGUgZnJlZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdiBZdW5sb25nIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+ID4gLS0tDQo+ID4gIGZzL2Z1c2UvdmlydGlvX2ZzLmMgfCAxMCAr
KysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvdmlydGlvX2ZzLmMgYi9mcy9m
dXNlL3ZpcnRpb19mcy5jDQo+ID4gaW5kZXggODg2OGFjMzFhM2MwLi43MjdjZjQzNjgyOGYgMTAw
NjQ0DQo+ID4gLS0tIGEvZnMvZnVzZS92aXJ0aW9fZnMuYw0KPiA+ICsrKyBiL2ZzL2Z1c2Uvdmly
dGlvX2ZzLmMNCj4gPiBAQCAtMTQzNywxMCArMTQzNyw3IEBAIHN0YXRpYyBpbnQgdmlydGlvX2Zz
X2dldF90cmVlKHN0cnVjdCBmc19jb250ZXh0ICpmc2MpDQo+ID4gIA0KPiA+ICAJZnNjLT5zX2Zz
X2luZm8gPSBmbTsNCj4gPiAgCXNiID0gc2dldF9mYyhmc2MsIHZpcnRpb19mc190ZXN0X3N1cGVy
LCBzZXRfYW5vbl9zdXBlcl9mYyk7DQo+ID4gLQlpZiAoZnNjLT5zX2ZzX2luZm8pIHsNCj4gPiAt
CQlmdXNlX2Nvbm5fcHV0KGZjKTsNCj4gPiAtCQlrZnJlZShmbSk7DQo+ID4gLQl9DQo+ID4gKw0K
PiA+ICAJaWYgKElTX0VSUihzYikpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoc2IpOw0KPiA+ICAN
Cj4gPiBAQCAtMTQ1Nyw2ICsxNDU0LDExIEBAIHN0YXRpYyBpbnQgdmlydGlvX2ZzX2dldF90cmVl
KHN0cnVjdCBmc19jb250ZXh0ICpmc2MpDQo+ID4gIAkJc2ItPnNfZmxhZ3MgfD0gU0JfQUNUSVZF
Ow0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWlmIChmc2MtPnNfZnNfaW5mbykgew0KPiA+ICsJCWZ1
c2VfY29ubl9wdXQoZmMpOw0KPiA+ICsJCWtmcmVlKGZtKTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
IAlXQVJOX09OKGZzYy0+cm9vdCk7DQo+ID4gIAlmc2MtPnJvb3QgPSBkZ2V0KHNiLT5zX3Jvb3Qp
Ow0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gLS0gDQo+ID4gMi4yNS4xDQo+ID4gDQo+ID4gDQo+IA0K
DQoNCk9rLCB0aGFua3MuDQpJdCBzaG91bGQgYmUgYSBmYWxzZSBwb3NpdGl2ZS4=
