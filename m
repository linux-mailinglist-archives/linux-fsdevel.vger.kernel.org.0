Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47D42C5EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392318AbgK0DQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 22:16:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388759AbgK0DQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:16:59 -0500
X-UUID: 606221480a8f4f7f8517c9082c7167df-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7mGvXBf1oDk/sMWGysxsG6Qx0eXvEJgGpJ68T2MY34w=;
        b=UFEq9wBdUNIKj8Y/irFAvy44mpxdMh0TjJmSuCi6w2UhKAekaeV/9a5Io6qMJy5OUryUOOVV4k9qsAE3lqjVzSDEm7RStDmPP+HP92fqZo6OtyU3hjiF5epz1eAX/khmw52WTCJx/x5oLPPt/ScUph2AJb91RPEdL3FMH+qVH5U=;
X-UUID: 606221480a8f4f7f8517c9082c7167df-20201127
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1976057886; Fri, 27 Nov 2020 11:16:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Nov 2020 11:16:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 11:16:52 +0800
Message-ID: <1606447013.8845.5.camel@mtkswgap22>
Subject: Re: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <andreyknvl@google.com>
Date:   Fri, 27 Nov 2020 11:16:53 +0800
In-Reply-To: <CAHkRjk7xGoU=KBeFE4gy=yxkLhvHqz2A1JyCBKF8dhjJNDD=zA@mail.gmail.com>
References: <20201123063835.18981-1-miles.chen@mediatek.com>
         <CAHkRjk7xGoU=KBeFE4gy=yxkLhvHqz2A1JyCBKF8dhjJNDD=zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDExOjEwICswMDAwLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6
DQo+IEhpIE1pbGVzLA0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBjYyBtZSBhbmQgQW5kcmV5IEtv
bm92YWxvdiBvbiBmdXR1cmUgdmVyc2lvbnMgb2YgdGhpcw0KPiBwYXRjaCAoaWYgYW55KT8NCj4g
DQo+IE9uIE1vbiwgMjMgTm92IDIwMjAgYXQgMDg6NDcsIE1pbGVzIENoZW4gPG1pbGVzLmNoZW5A
bWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiBXaGVuIHdlIHRyeSB0byB2aXNpdCB0aGUgcGFnZW1h
cCBvZiBhIHRhZ2dlZCB1c2Vyc3BhY2UgcG9pbnRlciwgd2UgZmluZA0KPiA+IHRoYXQgdGhlIHN0
YXJ0X3ZhZGRyIGlzIG5vdCBjb3JyZWN0IGJlY2F1c2Ugb2YgdGhlIHRhZy4NCj4gPiBUbyBmaXgg
aXQsIHdlIHNob3VsZCB1bnRhZyB0aGUgdXNlc3BhY2UgcG9pbnRlcnMgaW4gcGFnZW1hcF9yZWFk
KCkuDQo+ID4NCj4gPiBJIHRlc3RlZCB3aXRoIDUuMTAtcmM0IGFuZCB0aGUgaXNzdWUgcmVtYWlu
cy4NCj4gPg0KPiA+IE15IHRlc3QgY29kZSBpcyBiYWVkIG9uIFsxXToNCj4gPg0KPiA+IEEgdXNl
cnNwYWNlIHBvaW50ZXIgd2hpY2ggaGFzIGJlZW4gdGFnZ2VkIGJ5IDB4YjQ6IDB4YjQwMDAwNzY2
MmY1NDFjOA0KPiA+DQo+ID4gPT09IHVzZXJzcGFjZSBwcm9ncmFtID09PQ0KPiA+DQo+ID4gdWlu
dDY0IE9zTGF5ZXI6OlZpcnR1YWxUb1BoeXNpY2FsKHZvaWQgKnZhZGRyKSB7DQo+ID4gICAgICAg
ICB1aW50NjQgZnJhbWUsIHBhZGRyLCBwZm5tYXNrLCBwYWdlbWFzazsNCj4gPiAgICAgICAgIGlu
dCBwYWdlc2l6ZSA9IHN5c2NvbmYoX1NDX1BBR0VTSVpFKTsNCj4gPiAgICAgICAgIG9mZjY0X3Qg
b2ZmID0gKCh1aW50cHRyX3QpdmFkZHIpIC8gcGFnZXNpemUgKiA4OyAvLyBvZmYgPSAweGI0MDAw
MDc2NjJmNTQxYzggLyBwYWdlc2l6ZSAqIDggPSAweDVhMDAwMDNiMzE3YWEwDQo+IA0KPiBBcmd1
YWJseSwgdGhhdCdzIGEgdXNlci1zcGFjZSBidWcgc2luY2UgdGFnZ2VkIGZpbGUgb2Zmc2V0cyB3
ZXJlIG5ldmVyDQo+IHN1cHBvcnRlZC4gSW4gdGhpcyBjYXNlIGl0J3Mgbm90IGV2ZW4gYSB0YWcg
YXQgYml0IDU2IGFzIHBlciB0aGUgYXJtNjQNCj4gdGFnZ2VkIGFkZHJlc3MgQUJJIGJ1dCByYXRo
ZXIgZG93biB0byBiaXQgNDcuIFlvdSBjb3VsZCBzYXkgdGhhdCB0aGUNCj4gcHJvYmxlbSBpcyBj
YXVzZWQgYnkgdGhlIEMgbGlicmFyeSAobWFsbG9jKCkpIG9yIHdob2V2ZXIgY3JlYXRlZCB0aGUN
Cj4gdGFnZ2VkIHZhZGRyIGFuZCBwYXNzZWQgaXQgdG8gdGhpcyBmdW5jdGlvbi4gSXQncyBub3Qg
YSBrZXJuZWwNCj4gcmVncmVzc2lvbiBhcyB3ZSd2ZSBuZXZlciBzdXBwb3J0ZWQgaXQuDQoNCnRo
YW5rcyBmb3IgdGhlIGV4cGxhaW5hdGlvbi4NCj4gDQo+IE5vdywgcGFnZW1hcCBpcyBhIHNwZWNp
YWwgY2FzZSB3aGVyZSB0aGUgb2Zmc2V0IGlzIHVzdWFsbHkgbm90DQo+IGdlbmVyYXRlZCBhcyBh
IGNsYXNzaWMgZmlsZSBvZmZzZXQgYnV0IHJhdGhlciBkZXJpdmVkIGJ5IHNoaWZ0aW5nIGENCj4g
dXNlciB2aXJ0dWFsIGFkZHJlc3MuIEkgZ3Vlc3Mgd2UgY2FuIG1ha2UgYSBjb25jZXNzaW9uIGZv
ciBwYWdlbWFwDQo+IChvbmx5KSBhbmQgYWxsb3cgc3VjaCBvZmZzZXQgd2l0aCB0aGUgdGFnIGF0
IGJpdCAoNTYgLSBQQUdFX1NISUZUICsNCj4gMykuDQo+IA0KPiBQbGVhc2UgZml4IHRoZSBwYXRj
aCBhcyBwZXIgRXJpYydzIHN1Z2dlc3Rpb24gb24gYXZvaWRpbmcgdGhlDQo+IG92ZXJmbG93LiBZ
b3Ugc2hvdWxkIGFsc28gYWRkIGEgQ2M6IHN0YWJsZSB2NS40LSBhcyB0aGF0J3Mgd2hlbiB3ZQ0K
PiBlbmFibGVkIHRoZSB0YWdnZWQgYWRkcmVzcyBBQkkgb24gYXJtNjQgYW5kIHdoZW4gaXQncyBt
b3JlIGxpa2VseSBmb3INCj4gdGhlIEMgbGlicmFyeS9tYWxsb2MoKSB0byBzdGFydCBnZW5lcmF0
aW5nIHN1Y2ggcG9pbnRlcnMuDQoNCkdvdCBpdCwgdGhhbmtzIGZvciB5b3VyIHJldmlld2luZyBh
bmQgc3VnZ2VzdGlvbi4gSSB3aWxsIGZvbGxvdyBFcmljJ3MNCnN1Z2dlc3Rpb24gYW5kIHN1Ym1p
dCBwYXRjaCB2MiBhbmQgY2Mgc3RhYmxlIHY1LjQtDQoNCk1pbGVzDQo+IA0KPiBJZiB0aGUgcHJv
YmxlbSBpcyBvbmx5IGxpbWl0ZWQgdG8gdGhpcyB0ZXN0LCBJJ2QgcmF0aGVyIGZpeCB0aGUgdXNl
cg0KPiBidXQgSSBjYW4ndCB0ZWxsIGhvdyB3aWRlc3ByZWFkIHRoZSAvcHJvYy9waWQvcGFnZW1h
cCB1c2FnZSBpcy4NCj4gDQo+IFRoYW5rcy4NCj4gDQoNCg==

