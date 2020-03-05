Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2F17A216
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 10:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEJQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 04:16:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11935 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbgCEJQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:16:31 -0500
X-UUID: 672c733cef6941dea7ba533c344ee0be-20200305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kpiqrfWIacgjKLiLWLGT9gO7LZYPAEBqZuMrrpG6/+0=;
        b=e1uR1eXr/oH/WxQrsS/6G19c8yvMVUCDaMDEyGsSElteJVeSs1Mp+D+YloSO9vEIw9cEUPyGKw3h++cngUajTi7KYLgEahxNcAJTO/gIJj+o0aR1X9clAcCG7/qgisHx9vk6lSOQgg6Dtm5SMjoVA3YuK2N11SN1cY94xfgFxlI=;
X-UUID: 672c733cef6941dea7ba533c344ee0be-20200305
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2088496652; Thu, 05 Mar 2020 17:16:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 5 Mar
 2020 17:15:40 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Mar 2020 17:15:37 +0800
Message-ID: <1583399782.17146.14.camel@mtksdccf07>
Subject: Re: mmotm 2020-03-03-22-28 uploaded (warning: objtool:)
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Randy Dunlap <rdunlap@infradead.org>, <akpm@linux-foundation.org>,
        <broonie@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mhocko@suse.cz>,
        <mm-commits@vger.kernel.org>, <sfr@canb.auug.org.au>,
        Josh Poimboeuf <jpoimboe@redhat.com>, <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu, 5 Mar 2020 17:16:22 +0800
In-Reply-To: <20200305081842.GB2619@hirez.programming.kicks-ass.net>
References: <20200304062843.9yA6NunM5%akpm@linux-foundation.org>
         <cd1c6bd2-3db3-0058-f3b4-36b2221544a0@infradead.org>
         <20200305081717.GT2596@hirez.programming.kicks-ass.net>
         <20200305081842.GB2619@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDA5OjE4ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBNYXIgMDUsIDIwMjAgYXQgMDk6MTc6MTdBTSArMDEwMCwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6DQo+ID4gT24gV2VkLCBNYXIgMDQsIDIwMjAgYXQgMDk6MzQ6NDlBTSAtMDgwMCwg
UmFuZHkgRHVubGFwIHdyb3RlOg0KPiANCj4gPiA+IG1tL2thc2FuL2NvbW1vbi5vOiB3YXJuaW5n
OiBvYmp0b29sOiBrYXNhbl9yZXBvcnQoKSsweDEzOiBjYWxsIHRvIHJlcG9ydF9lbmFibGVkKCkg
d2l0aCBVQUNDRVNTIGVuYWJsZWQNCj4gPiANCj4gPiBJIHVzZWQgbmV4dC9tYXN0ZXIgaW5zdGVh
ZCwgYW5kIGZvdW5kIHRoZSBiZWxvdyBicm9rZW4gY29tbWl0DQo+ID4gcmVzcG9uc2libGUgZm9y
IHRoaXMuDQo+IA0KPiA+IEBAIC02MzQsMTIgKzYzNywyMCBAQCB2b2lkIGthc2FuX2ZyZWVfc2hh
ZG93KGNvbnN0IHN0cnVjdCB2bV9zdHJ1Y3QgKnZtKQ0KPiA+ICAjZW5kaWYNCj4gPiAgDQo+ID4g
IGV4dGVybiB2b2lkIF9fa2FzYW5fcmVwb3J0KHVuc2lnbmVkIGxvbmcgYWRkciwgc2l6ZV90IHNp
emUsIGJvb2wgaXNfd3JpdGUsIHVuc2lnbmVkIGxvbmcgaXApOw0KPiA+ICtleHRlcm4gYm9vbCBy
ZXBvcnRfZW5hYmxlZCh2b2lkKTsNCj4gPiAgDQo+ID4gLXZvaWQga2FzYW5fcmVwb3J0KHVuc2ln
bmVkIGxvbmcgYWRkciwgc2l6ZV90IHNpemUsIGJvb2wgaXNfd3JpdGUsIHVuc2lnbmVkIGxvbmcg
aXApDQo+ID4gK2Jvb2wga2FzYW5fcmVwb3J0KHVuc2lnbmVkIGxvbmcgYWRkciwgc2l6ZV90IHNp
emUsIGJvb2wgaXNfd3JpdGUsIHVuc2lnbmVkIGxvbmcgaXApDQo+ID4gIHsNCj4gPiAtCXVuc2ln
bmVkIGxvbmcgZmxhZ3MgPSB1c2VyX2FjY2Vzc19zYXZlKCk7DQo+ID4gKwl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPiA+ICsNCj4gPiArCWlmIChsaWtlbHkoIXJlcG9ydF9lbmFibGVkKCkpKQ0KPiA+
ICsJCXJldHVybiBmYWxzZTsNCj4gDQo+IFRoaXMgYWRkcyBhbiBleHBsaWNpdCBjYWxsIGJlZm9y
ZSB0aGUgdXNlcl9hY2Nlc3Nfc2F2ZSgpIGFuZCB0aGF0IGlzIGENCj4gc3RyYWlnaHQgb24gYnVn
Lg0KPiANCkhpIFBldGVyLA0KDQpUaGFua3MgZm9yIHlvdXIgaGVscC4gVW5mb3J0dW5hdGVseSwg
SSBkb24ndCByZXByb2R1Y2UgaXQgaW4gb3VyDQplbnZpcm9ubWVudCwgc28gSSBoYXZlIGFza2Vk
IFN0ZXBoZW4sIGlmIEkgY2FuIHJlcHJvZHVjZSBpdCwgdGhlbiB3ZQ0Kd2lsbCBzZW5kIG5ldyBw
YXRjaC4NCg0KDQpUaGFua3MuDQoNCldhbHRlcg0KDQo+ID4gKw0KPiA+ICsJZmxhZ3MgPSB1c2Vy
X2FjY2Vzc19zYXZlKCk7DQo+ID4gIAlfX2thc2FuX3JlcG9ydChhZGRyLCBzaXplLCBpc193cml0
ZSwgaXApOw0KPiA+ICAJdXNlcl9hY2Nlc3NfcmVzdG9yZShmbGFncyk7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIHRydWU7DQo+ID4gIH0NCg0K

