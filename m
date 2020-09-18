Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D392327026B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIRQnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:43:12 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:48158 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgIRQnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:43:11 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2751C1EBC;
        Fri, 18 Sep 2020 19:43:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1600447389;
        bh=zq4p8PFtXbU0e2VdNB8JbzfwLEWp0E+KlnB2hEMOgds=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=JCVAVrO+kllqXzhjYJ/x1g8f5wA8TKZzGCCB0SJ7UEm7bt7kDF1jg1AVi80aojMlK
         /eMw2ZdvMWoq9Tf8G5YwjI94woGfxV+zCQh6IfadixHpQjS7LXqH0zUE+YQO2SZUge
         MZHJt3N9WbzBEYUoA+ZZ+bZ/GQweXkDkjGLWMS+s=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 19:43:08 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 18 Sep 2020 19:43:08 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Mark Harmstone <mark@harmstone.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: RE: [PATCH v5 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v5 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AQHWiEVL7N48ZH2GnEynjuLUaLiYualjdFUAgAsvsbA=
Date:   Fri, 18 Sep 2020 16:43:08 +0000
Message-ID: <57419fb6b3764ed3bc7b0c3d284e9407@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-3-almaz.alexandrovich@paragon-software.com>
 <2011cd8c-7dc4-b2e7-114b-d5647336ec92@harmstone.com>
In-Reply-To: <2011cd8c-7dc4-b2e7-114b-d5647336ec92@harmstone.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTWFyayBIYXJtc3RvbmUgPG1hcmsuaGFybXN0b25lQGdtYWlsLmNvbT4gT24gQmVoYWxm
IE9mIE1hcmsgSGFybXN0b25lDQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMSwgMjAyMCA3OjUw
IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDIvMTBdIGZzL250ZnMzOiBBZGQgaW5pdGlh
bGl6YXRpb24gb2Ygc3VwZXIgYmxvY2sNCj4gDQo+IEFsc28sIEkgdGhpbmsgaXQgd291bGQgYmUg
YSBnb29kIGlkZWEgaWYgeW91ICphcmUqIGdvaW5nIHRvIGhhdmUgc3RhdGljIFNEcywgdG8NCj4g
YWxsb2NhdGUgdGhlbSBkeW5hbWljYWxseSByYXRoZXIgdGhhbiB1c2luZyBhIGJsb2IuIFRoZSBi
bG9icycgY29udGVudHMgZG9uJ3QNCj4gbWF0Y2ggeW91ciBjb21tZW50cywNCg0KSGkgTWFyayEg
Rml4ZWQgdGhlIGNvbW1lbnQgdGhpbmcuIENoZWNrIG91dCB0aGUgVjYuDQpWNiBhbHNvIGludHJv
ZHVjZXMgdGhlIHN5c3RlbS5udGZzX3NlY3VyaXR5IHhhdHRyLg0KDQo+YW5kIGl0J2QgaGF2ZSBi
ZWVuIHBpY2tlZCB1cCBpZiB5b3UnZCBkb25lIHRoYXQhDQo+IA0KPiBzX2Rpcl9zZWN1cml0eSB0
cmFuc2xhdGVzIHRvOg0KPiBvd25lciBTLTEtNS0zMi01NDQgKEFkbWluaXN0cmF0b3JzKQ0KPiBn
cm91cCBTLTEtNS0zMi01NDQgKEFkbWluaXN0cmF0b3JzKQ0KPiBBQ0U6IGFsbG93IFMtMS0xLTAg
KEV2ZXJ5b25lKSB3aXRoIEZJTEVfQUxMX0FDQ0VTUw0KPiANCj4gc19maWxlX3NlY3VyaXR5IHRy
YW5zbGF0ZXMgdG86DQo+IG93bmVyIFMtMS0xLTAgKEV2ZXJ5b25lKQ0KPiBncm91cCBTLTEtNS0y
MS0xOTg3OTMyMTg3LTQxNTU1NDA2MzctMzk0NDQ5Nzc4NS01MTMgKHlvdXIgcGVyc29uYWwgU0lE
PyEpDQo+IEFDRTogYWxsb3cgUy0xLTEtMCAoRXZlcnlvbmUpIHdpdGggRklMRV9BTExfQUNDRVNT
DQo+IA0KPiANCj4gT24gMTEvOS8yMCAzOjEwIHBtLCBLb25zdGFudGluIEtvbWFyb3Ygd3JvdGU6
DQo+ID4gVGhpcyBhZGRzIGluaXRpYWxpemF0aW9uIG9mIHN1cGVyIGJsb2NrDQo+ID4NCltdDQo+
ID4gK30NCj4gPiArDQo+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiArTU9EVUxFX0RF
U0NSSVBUSU9OKCJudGZzMyBmaWxlc3lzdGVtIik7DQo+ID4gK01PRFVMRV9BVVRIT1IoIktvbnN0
YW50aW4gS29tYXJvdiIpOw0KPiA+ICtNT0RVTEVfQUxJQVNfRlMoIm50ZnMzIik7DQo+ID4gKw0K
PiA+ICttb2R1bGVfaW5pdChpbml0X250ZnNfZnMpIG1vZHVsZV9leGl0KGV4aXRfbnRmc19mcykN
Cj4gDQoNClRoYW5rcw0K
