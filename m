Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6283DBCA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhG3Pzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 11:55:44 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:47724 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhG3Pzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:55:43 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B0AE31D06;
        Fri, 30 Jul 2021 18:55:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1627660536;
        bh=S6yDimCl0JzOJgCA69pI1TglSsb5QIW2EhV1j5+xXKE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=TPzAiWXISwa/P2JnoETYrOgYhffkae0R61nto0kSu8jUx4WZoDj5guS8eMB+h/vLV
         Tm47pV2h3Sdy3E2/asLaDPn02iALTjevY0NHUOCQ1iMFzdxy7xZmMpXNZliV8T+t1u
         1QLmM2tuWW0TaKyh3xmL1g9dYxD1nc2ZTumarnAc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 18:55:36 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.2176.009; Fri, 30 Jul 2021 18:55:36 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>
CC:     "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [GIT PULL] vboxsf fixes for 5.14-1
Thread-Topic: [GIT PULL] vboxsf fixes for 5.14-1
Thread-Index: AQHXd9Q0d6WirG0Ih0y0eIuA7j/DOatBFNyAgAAQcQCAAPTFAIAAQ2AAgAATA4CAAAGlAIAAA7AAgALYuICAAGpsgIAWDY+g
Date:   Fri, 30 Jul 2021 15:55:36 +0000
Message-ID: <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
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
IFNlbnQ6IEZyaWRheSwgSnVseSAxNiwgMjAyMSA5OjA3IFBNDQo+IA0KPiA+IFRoaXMgZHJpdmVy
IGlzIGFscmVhZHkgaW4gYSBtdWNoIGJldHRlciBmZWF0dXJlIHN0YXRlIHRoYW4gdGhlIG9sZCBu
dGZzIGRyaXZlciBmcm9tIDIwMDEuDQo+IA0KPiBJZiB0aGUgbmV3IG50ZnMgY29kZSBoYXMgYWNr
cyBmcm9tIHBlb3BsZSAtIGFuZCBpdCBzb3VuZHMgbGlrZSBpdCBkaWQNCj4gZ2V0IHRoZW0gLSBh
bmQgUGFyYWdvbiBpcyBleHBlY3RlZCB0byBiZSB0aGUgbWFpbnRhaW5lciBvZiBpdCwgdGhlbiBJ
DQo+IHRoaW5rIFBhcmFnb24gc2hvdWxkIGp1c3QgbWFrZSBhIGdpdCBwdWxsIHJlcXVlc3QgZm9y
IGl0Lg0KPiANCj4gVGhhdCdzIGFzc3VtaW5nIHRoYXQgaXQgY29udGludWVzIHRvIGJlIGFsbCBp
biBqdXN0IGZzL250ZnMzLyAocGx1cw0KPiBmcy9LY29uZmlnLCBmcy9NYWtlZmlsZSBhbmQgTUFJ
TlRBSU5FUlMgZW50cmllcyBhbmQgd2hhdGV2ZXINCj4gZG9jdW1lbnRhdGlvbikgYW5kIHRoZXJl
IGFyZSBubyBvdGhlciBzeXN0ZW0td2lkZSBjaGFuZ2VzLiBXaGljaCBJDQo+IGRvbid0IHRoaW5r
IGl0IGhhZC4NCj4NCkhpIExpbnVzISBHcmVhdCB0byBoZWFyIHlvdXIgZmVlZGJhY2sgYW5kIGNs
YXJpZmljYXRpb25zIG9uIG91ciBudGZzMyBjb2RlLg0KR3JlYXRseSBhcHByZWNpYXRlZC4NCkZy
b20gb3VyIHNpZGUsIHdlIGNhbiBjb25maXJtIHRoYXQgd2Ugd2lsbCBiZSBtYWludGFpbmluZyB0
aGlzIGltcGxlbWVudGF0aW9uLg0KQWxzbywgdGhpcyBpcyBwbGFubmVkIHRvIGJlIGluIGZzL250
ZnMzIGF0IHRoaXMgcG9pbnQsIGF0IGxlYXN0IGZvciBub3cgLSB1bnRpbCB0aGUgY29kZQ0KYW5k
IGltcGxlbWVudGF0aW9uIGJlY29tZXMga25vd24gYW5kIHRydXN0ZWQgd2l0aGluIGNvbW11bml0
eS4gQW5kIHRoZW4NCndlIGNhbiBkaXNjdXNzIGlmIGl0IHNob3VsZCByZXBsYWNlIHRoZSBmcy9u
dGZzIGFuZCB3aGVuIGl0J3MgY29udmVuaWVudCB0byBkby4NCj4NCj4gV2Ugc2ltcGx5IGRvbid0
IGhhdmUgYW55Ym9keSB0byBmdW5uZWwgbmV3IGZpbGVzeXN0ZW1zIC0gdGhlIGZzZGV2ZWwNCj4g
bWFpbGluZyBsaXN0IGlzIGdvb2QgZm9yIGNvbW1lbnRzIGFuZCBnZXQgZmVlZGJhY2ssIGJ1dCBh
dCBzb21lIHBvaW50DQo+IHNvbWVib2R5IGp1c3QgbmVlZHMgdG8gYWN0dWFsbHkgc3VibWl0IGl0
LCBhbmQgdGhhdCdzIG5vdCB3aGF0IGZzZGV2ZWwNCj4gZW5kcyB1cCBkb2luZy4NCj4NClRoYW5r
cyBmb3IgdGhpcyBjbGFyaWZpY2F0aW9uIGFzIHdlbGwuIFRoaXMgcGllY2Ugb2YgaW5mcm9tYXRp
b24gaGFzIG5vdCBiZWVuIHJlYWxseSANCmNsZWFyIGZvciB1cyB1bnRpbCBub3cuDQpXZSd2ZSBq
dXN0IHNlbnQgdGhlIDI3dGggcGF0Y2ggc2VyaWVzIHdoaWNoIGZpeGVzIHRvIHRoZSBidWlsZGFi
aWxpdHkgYWdhaW5zdA0KY3VycmVudCBsaW51eC1uZXh0LiBBbmQgd2UnbGwgbmVlZCBzZXZlcmFs
IGRheXMgdG8gcHJlcGFyZSBhIHByb3BlciBwdWxsIHJlcXVlc3QNCmJlZm9yZSBzZW5kaW5nIGl0
IHRvIHlvdS4NCiANCj4gVGhlIGFyZ3VtZW50IHRoYXQgIml0J3MgYWxyZWFkeSBpbiBhIG11Y2gg
YmV0dGVyIHN0YXRlIHRoYW4gdGhlIG9sZA0KPiBudGZzIGRyaXZlciIgbWF5IG5vdCBiZSBhIHZl
cnkgc3Ryb25nIHRlY2huaWNhbCBhcmd1bWVudCAobm90IGJlY2F1c2UNCj4gb2YgYW55IFBhcmFn
b24gcHJvYmxlbXMgLSBqdXN0IGJlY2F1c2UgdGhlIG9sZCBudGZzIGRyaXZlciBpcyBub3QNCj4g
Z3JlYXQpLCBidXQgaXQgX2lzXyBhIGZhaXJseSBzdHJvbmcgYXJndW1lbnQgZm9yIG1lcmdpbmcg
dGhlIG5ldyBvbmUNCj4gZnJvbSBQYXJhZ29uLg0KPiANCj4gQW5kIEkgZG9uJ3QgdGhpbmsgdGhl
cmUgaGFzIGJlZW4gYW55IGh1Z2UgX2NvbXBsYWludHNfIGFib3V0IHRoZSBjb2RlLA0KPiBhbmQg
SSBkb24ndCB0aGluayB0aGVyZSdzIGJlZW4gYW55IHNpZ24gdGhhdCBiZWluZyBvdXRzaWRlIHRo
ZSBrZXJuZWwNCj4gaGVscHMuDQo+IA0KPiAgICAgICAgICAgICAgICBMaW51cw0K
