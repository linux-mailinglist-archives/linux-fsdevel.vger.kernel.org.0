Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B33EB9D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhHMQLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 12:11:40 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:55736 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhHMQLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:11:40 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 0BE3D8219E;
        Fri, 13 Aug 2021 19:11:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1628871071;
        bh=S7U7RzlCWxWHeqcFklpXbvxk+/So5UbE0PlinKA7/VA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=FJbXsQ7AvkHk2tSb30GF8OeGlgXNCorhgtL+0Tac7gtGuZEiAFmBOvv5qqhL9Rr79
         6AOtp/RXq01i9U9nmzLdXI/zyOEW0LlhUiqcxQPENDoR4Qjr7gRM0M3S6cASJvyE/k
         mRz9blp1EARYBAbp9MuvfhN/+yeBw6narc8kMETQ=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 19:11:10 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.2176.009; Fri, 13 Aug 2021 19:11:10 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox" <willy@infradead.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
Subject: RE: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
Thread-Topic: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
Thread-Index: AQHXhWe5WstdeQuygUujQulzI6K7d6txqg+w
Date:   Fri, 13 Aug 2021 16:11:10 +0000
Message-ID: <a9114805f777461eac6fbb0e8e5c46f6@paragon-software.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com>
 <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IFNlbnQ6IEZyaWRheSwgSnVseSAzMCwgMjAyMSA4OjI0IFBNDQo+IFRvOiBLb25zdGFudGluIEtv
bWFyb3YgPGFsbWF6LmFsZXhhbmRyb3ZpY2hAcGFyYWdvbi1zb2Z0d2FyZS5jb20+OyBTdGVwaGVu
IFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4gQ2M6IExlb25pZGFzIFAuIFBhcGFk
YWtvcyA8cGFwYWRha29zcGFuQGdtYWlsLmNvbT47IHphamVjNUBnbWFpbC5jb207IERhcnJpY2sg
Si4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLQ0KPiBIYXJ0bWFuIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5j
b20+OyBsaW51eC1mc2RldmVsIDxsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZz47DQo+IExp
bnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBB
bCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47IE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPg0KPiBTdWJqZWN0OiBQYXJhZ29uIE5URlN2MyAod2FzIFJlOiBbR0lUIFBV
TExdIHZib3hzZiBmaXhlcyBmb3IgNS4xNC0xKQ0KPiANCj4gT24gRnJpLCBKdWwgMzAsIDIwMjEg
YXQgODo1NSBBTSBLb25zdGFudGluIEtvbWFyb3YNCj4gPGFsbWF6LmFsZXhhbmRyb3ZpY2hAcGFy
YWdvbi1zb2Z0d2FyZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gV2UndmUganVzdCBzZW50IHRoZSAy
N3RoIHBhdGNoIHNlcmllcyB3aGljaCBmaXhlcyB0byB0aGUgYnVpbGRhYmlsaXR5IGFnYWluc3QN
Cj4gPiBjdXJyZW50IGxpbnV4LW5leHQuIEFuZCB3ZSdsbCBuZWVkIHNldmVyYWwgZGF5cyB0byBw
cmVwYXJlIGEgcHJvcGVyIHB1bGwgcmVxdWVzdA0KPiA+IGJlZm9yZSBzZW5kaW5nIGl0IHRvIHlv
dS4NCj4gDQo+IFdlbGwsIEkgd29uJ3QgcHVsbCB1bnRpbCB0aGUgbmV4dCBtZXJnZSB3aW5kb3cg
b3BlbnMgYW55d2F5IChhYm91dCBhDQo+IG1vbnRoIGF3YXkpLiBCdXQgaXQgd291bGQgYmUgZ29v
ZCB0byBoYXZlIHlvdXIgdHJlZSBpbiBsaW51eC1uZXh0IGZvcg0KPiBhdCBsZWFzdCBhIGNvdXBs
ZSBvZiB3ZWVrcyBiZWZvcmUgdGhhdCBoYXBwZW5zLg0KPiANCj4gQWRkZWQgU3RlcGhlbiB0byB0
aGUgcGFydGljaXBhbnRzIGxpc3QgYXMgYSBoZWFkcy11cCBmb3IgaGltIC0gbGV0dGluZw0KPiBo
aW0ga25vdyB3aGVyZSB0byBmZXRjaCB0aGUgZ2l0IHRyZWUgZnJvbSB3aWxsIGFsbG93IHRoYXQg
dG8gaGFwcGVuIGlmDQo+IHlvdSBoYXZlbid0IGRvbmUgc28gYWxyZWFkeS4NCj4gDQoNClRoYW5r
cyBmb3IgdGhpcyBjbGFyaWZpY2F0aW9uLCBMaW51cyENClN0ZXBoZW4sIHBsZWFzZSBmaW5kIHRo
ZSB0cmVlIGhlcmU6DQpodHRwczovL2dpdGh1Yi5jb20vUGFyYWdvbi1Tb2Z0d2FyZS1Hcm91cC9s
aW51eC1udGZzMy5naXQNCkl0IGlzIHRoZSBmb3JrIGZyb20gNS4xNC1yYzUgdGFnIHdpdGggbnRm
czMgcGF0Y2hlcyBhcHBsaWVkLg0KQWxzbywgdGhlIGxhdGVzdCBjaGFuZ2VzDQotIGZpeCBzb21l
IGdlbmVyaWMvWFlaIHhmc3Rlc3RzLCB3aGljaCB3ZXJlIGRpc2N1c3NlZA0Kd2l0aCBUaGVvZG9y
ZSwgRGFycmljayBhbmQgb3RoZXJzDQotIHVwZGF0ZXMgdGhlIE1BSU5UQUlORVJTIHdpdGggbWFp
bGluZyBsaXN0IChhbHNvIGFkZGVkIHRvIENDIGhlcmUpIGFuZCBzY20gdHJlZSBsaW5rLg0KDQpQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgYWRkaXRpb25hbCBjaGFuZ2VzIHJlcXVyZWQgdG8gZ2V0IGZl
dGNoZWQgaW50byBsaW51eC1uZXh0Lg0KDQo+IFRoZSBvbmUgb3RoZXIgdGhpbmcgSSBkbyB3YW50
IHdoZW4gdGhlcmUncyBiaWcgbmV3IHBpZWNlcyBsaWtlIHRoaXMNCj4gYmVpbmcgYWRkZWQgaXMg
dG8gYXNrIHlvdSB0byBtYWtlIHN1cmUgdGhhdCBldmVyeXRoaW5nIGlzIHNpZ25lZC1vZmYNCj4g
cHJvcGVybHksIGFuZCB0aGF0IHRoZXJlIGlzIG5vIGludGVybmFsIGNvbmZ1c2lvbiBhYm91dCB0
aGUgR1BMdjINCj4gaW5zaWRlIFBhcmFnb24sIGFuZCB0aGF0IGFueSBsZWdhbCBwZW9wbGUgZXRj
IGFyZSBhbGwgYXdhcmUgb2YgdGhpcw0KPiBhbGwgYW5kIGFyZSBvbiBib2FyZC4gVGhlIGxhc3Qg
dGhpbmcgd2Ugd2FudCB0byBzZWUgaXMgc29tZSAib29wcywgd2UNCj4gZGlkbid0IG1lYW4gdG8g
ZG8gdGhpcyIgYnJvdWhhaGEgc2l4IG1vbnRocyBsYXRlci4NCj4gDQo+IEkgZG91YnQgdGhhdCdz
IGFuIGlzc3VlLCBjb25zaWRlcmluZyBob3cgcHVibGljIHRoaXMgYWxsIGhhcyBiZWVuLCBidXQN
Cj4gSSBqdXN0IHdhbnRlZCB0byBtZW50aW9uIGl0IGp1c3QgdG8gYmUgdmVyeSBvYnZpb3VzIGFi
b3V0IGl0Lg0KPiANCj4gICAgICAgICAgICAgICAgICAgTGludXMNCkluZGVlZCwgdGhlcmUgaXMg
bm8gaW50ZXJuYWwgY29uZnVzaW9uIGFib3V0IHRoZSBHUEx2MiBhbmQgd2UgbWVhbiB0byBtYWtl
IHRoaXMgY29udHJpYnV0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpLb25zdGFudGluLg0K
