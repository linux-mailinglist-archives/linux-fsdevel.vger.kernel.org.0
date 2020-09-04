Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95C25D909
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgIDMzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 08:55:39 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49574 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbgIDMzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:55:37 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 49A341B7;
        Fri,  4 Sep 2020 15:55:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599224134;
        bh=H8xMnD7JCVbbHVS0+itUPohVVc2Te/ty31v7I7Ungxw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=ZKczgM7oGTMVABveYNTHb+dVYtKzBpCdsTC71HZflxFdx9R5oMdXp1gHXxxzsw/+b
         HljdXqtogRhUiwq7lu8PEVZYHpKZwzr5KTKZGWktrXX1WGuQ8H6qXmzsBQ/aiGIH6z
         EwPqKFGrpkSexTa4Hz52KwW7PHs9GPYwR604wEjE=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 4 Sep 2020 15:55:33 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 4 Sep 2020 15:55:33 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>
Subject: RE: [PATCH v3 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Thread-Topic: [PATCH v3 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Thread-Index: AQHWfUkhnfa+JjUWaECKShg2PWgYh6lOwxGAgAm3bNA=
Date:   Fri, 4 Sep 2020 12:55:33 +0000
Message-ID: <0576878cc589449ebce9785322370c15@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <dcea3bfc-a082-8dfe-cbd0-c99333fe1b22@suse.com>
In-Reply-To: <dcea3bfc-a082-8dfe-cbd0-c99333fe1b22@suse.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTmlrb2xheSBCb3Jpc292IDxuYm9yaXNvdkBzdXNlLmNvbT4NClNlbnQ6IFNhdHVyZGF5
LCBBdWd1c3QgMjksIDIwMjAgMjozMiBQTQ0KPiBPbiAyOC4wOC4yMCDQsy4gMTc6Mzkg0YcuLCBL
b25zdGFudGluIEtvbWFyb3Ygd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIE5URlMgUmVhZC1X
cml0ZSBkcml2ZXIgdG8gZnMvbnRmczMuDQo+ID4NCj4gPiBIYXZpbmcgZGVjYWRlcyBvZiBleHBl
cnRpc2UgaW4gY29tbWVyY2lhbCBmaWxlIHN5c3RlbXMgZGV2ZWxvcG1lbnQgYW5kIGh1Z2UNCj4g
PiB0ZXN0IGNvdmVyYWdlLCB3ZSBhdCBQYXJhZ29uIFNvZnR3YXJlIEdtYkggd2FudCB0byBtYWtl
IG91ciBjb250cmlidXRpb24gdG8NCj4gPiB0aGUgT3BlbiBTb3VyY2UgQ29tbXVuaXR5IGJ5IHBy
b3ZpZGluZyBpbXBsZW1lbnRhdGlvbiBvZiBOVEZTIFJlYWQtV3JpdGUNCj4gPiBkcml2ZXIgZm9y
IHRoZSBMaW51eCBLZXJuZWwuDQo+ID4NCj4gPiBUaGlzIGlzIGZ1bGx5IGZ1bmN0aW9uYWwgTlRG
UyBSZWFkLVdyaXRlIGRyaXZlci4gQ3VycmVudCB2ZXJzaW9uIHdvcmtzIHdpdGgNCj4gPiBOVEZT
KGluY2x1ZGluZyB2My4xKSBhbmQgbm9ybWFsL2NvbXByZXNzZWQvc3BhcnNlIGZpbGVzIGFuZCBz
dXBwb3J0cyBqb3VybmFsIHJlcGxheWluZy4NCj4gPg0KPiA+IFdlIHBsYW4gdG8gc3VwcG9ydCB0
aGlzIHZlcnNpb24gYWZ0ZXIgdGhlIGNvZGViYXNlIG9uY2UgbWVyZ2VkLCBhbmQgYWRkIG5ldw0K
PiA+IGZlYXR1cmVzIGFuZCBmaXggYnVncy4gRm9yIGV4YW1wbGUsIGZ1bGwgam91cm5hbGluZyBz
dXBwb3J0IG92ZXIgSkJEIHdpbGwgYmUNCj4gPiBhZGRlZCBpbiBsYXRlciB1cGRhdGVzLg0KPiA+
DQo+ID4gdjI6DQo+ID4gIC0gcGF0Y2ggc3BsaXR0ZWQgdG8gY2h1bmtzIChmaWxlLXdpc2UpDQo+
ID4gIC0gYnVpbGQgaXNzdWVzIGZpeGVkDQo+ID4gIC0gc3BhcnNlIGFuZCBjaGVja3BhdGNoLnBs
IGVycm9ycyBmaXhlZA0KPiA+ICAtIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBvbiBta2ZzLm50
ZnMtZm9ybWF0dGVkIHZvbHVtZSBtb3VudCBmaXhlZA0KPiA+ICAtIGNvc21ldGljcyArIGNvZGUg
Y2xlYW51cA0KPiA+DQo+ID4gdjM6DQo+ID4gIC0gYWRkZWQgYWNsLCBub2F0aW1lLCBub19hY3Nf
cnVsZXMsIHByZWFsbG9jIG1vdW50IG9wdGlvbnMNCj4gPiAgLSBhZGRlZCBmaWVtYXAgc3VwcG9y
dA0KPiA+ICAtIGZpeGVkIGVuY29kaW5ncyBzdXBwb3J0DQo+ID4gIC0gcmVtb3ZlZCB0eXBlZGVm
cw0KPiA+ICAtIGFkYXB0ZWQgS2VybmVsLXdheSBsb2dnaW5nIG1lY2hhbmlzbXMNCj4gPiAgLSBm
aXhlZCB0eXBvcyBhbmQgY29ybmVyLWNhc2UgaXNzdWVzDQo+ID4NCj4gPiBLb25zdGFudGluIEtv
bWFyb3YgKDEwKToNCj4gPiAgIGZzL250ZnMzOiBBZGQgaGVhZGVycyBhbmQgbWlzYyBmaWxlcw0K
PiA+ICAgZnMvbnRmczM6IEFkZCBpbml0aWFsaXphdGlvbiBvZiBzdXBlciBibG9jaw0KPiANCj4g
VGhpcyBwYXRjaCBpcyBtaXNzaW5nDQo+IA0KPiA+ICAgZnMvbnRmczM6IEFkZCBiaXRtYXANCj4g
PiAgIGZzL250ZnMzOiBBZGQgZmlsZSBvcGVyYXRpb25zIGFuZCBpbXBsZW1lbnRhdGlvblRoaXMg
cGF0Y2ggaXMgbWlzc2luZw0KPiANCj4gPiAgIGZzL250ZnMzOiBBZGQgYXR0cmliIG9wZXJhdGlv
bnMNCj4gPiAgIGZzL250ZnMzOiBBZGQgY29tcHJlc3Npb24NCj4gPiAgIGZzL250ZnMzOiBBZGQg
TlRGUyBqb3VybmFsDQo+IFRoaXMgcGF0Y2ggaXMgbWlzc2luZw0KPiANCj4gPiAgIGZzL250ZnMz
OiBBZGQgS2NvbmZpZywgTWFrZWZpbGUgYW5kIGRvYw0KW10NCj4gPg0KSGkgTmlrb2xheSEgQXMg
ZmFyIGFzIEkgY2FuIHNlZSwgYWxsIHRoZSBtZXNzYWdlcyBhcmUgaW4NCnRoZSBsaW51eC1mc2Rl
dmVsIGxpc3QgYW5kIGhhdmUgY29ycmVjdCAiaW4tcmVwbHktdG8iIElEcy4NCkFyZSB0aG9zZSBw
YXRjaGVzIHN0aWxsIG1pc3Npbmcgb24geW91ciBzaWRlPw0K
