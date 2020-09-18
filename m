Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454C427025A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIRQjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:39:32 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53956 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgIRQjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:39:32 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 91FBC82192;
        Fri, 18 Sep 2020 19:39:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1600447169;
        bh=m14gjCCQLH9EXfAEbwVbGekFycA8B5NcXL5HPj0oYDE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=iYJmtdRBd6ryQa09568rl9nqHAqp8x6SQ5ATopkFC//dyF/9k+X9qhjxZYShgJL2J
         bjO96wyPp2a+QYAztWRlaKWWqYUi5l+l9DrlyidQBaFljR3fAjiEENyZ129WgnjKOU
         1xkNKIQY1YKlSqll1S3cotlrwMkvjCw3rzV/fo1M=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 19:39:29 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 18 Sep 2020 19:39:29 +0300
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
Thread-Index: AQHWiEVL7N48ZH2GnEynjuLUaLiYualja56AgAs3UpA=
Date:   Fri, 18 Sep 2020 16:39:28 +0000
Message-ID: <34c16477b199483089586d86a0e9edd9@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-3-almaz.alexandrovich@paragon-software.com>
 <c819ee72-6bb0-416d-dfc4-0bc2ad6d0ccd@harmstone.com>
In-Reply-To: <c819ee72-6bb0-416d-dfc4-0bc2ad6d0ccd@harmstone.com>
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
IE9mIE1hcmsgSGFybXN0b25lDQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMSwgMjAyMCA3OjE5
IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDIvMTBdIGZzL250ZnMzOiBBZGQgaW5pdGlh
bGl6YXRpb24gb2Ygc3VwZXIgYmxvY2sNCj4gDQo+IEFtIEkgcmlnaHQgaW4gdGhhdCBpbm9kZXMg
d2lsbCBvbmx5IGV2ZXIgYmUgY3JlYXRlZCB3aXRoIG9uZSBvZiB0d28gc2VjdXJpdHkNCj4gZGVz
Y3JpcHRvcnM/IFRoaXMgc2VlbXMgbGlrZSBhIHNpZ25pZmljYW50IHNob3J0Y29taW5nIC0gV2lu
ZG93cyBkb2Vzbid0IGhhdmUNCj4gdHJhdmVyc2UgY2hlY2tpbmcgdHVybmVkIG9uIGJ5IGRlZmF1
bHQsIHdoaWNoIG1lYW5zIGEgZmlsZSBjcmVhdGVkIGJ5IExpbnV4DQo+IHdpbGwgYmUgYWNjZXNz
aWJsZSB0byBhbnkgdXNlciBvbiBXaW5kb3dzLCBwcm92aWRlZCB0aGV5IGtub3cgaXRzIG5hbWUu
DQo+IA0KPiBUaGVyZSdzIGRvY3VtZW50YXRpb24gb24gaG93IHRvIGNvbXB1dGUgYSBTRCBvbiBN
U0ROLCBidXQgaXQncyBub3QgdHJpdmlhbDoNCj4gaHR0cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20v
ZW4tdXMvb3BlbnNwZWNzL3dpbmRvd3NfcHJvdG9jb2xzL21zLWR0eXAvOTgyNjdhZDYtNjZkYi00
YTJjLTk3MmUtZWZiN2Q0NjAzZGExDQo+IA0KDQpIaSBNYXJrISBZb3UgYXJlIHJpZ2h0LiBBbHNv
LCBpbiBWNiB0aGUgc2luZ2xlIGRlZmF1bHQgdmFsdWUgd2lsbCBiZSB1c2VkLg0KVGhpcyBpbXBs
ZW1lbnRhdGlvbiBpcyBub3QgcG9zaXRpb25lZCBhcyBmdWxsIHNwZWNzIGltcGxlbWV0YXRpb24s
IGhvd2V2ZXIuDQpQbGVhc2UgY2hlY2sgb3V0IG91ciBWNiwgaXQgaGFzIHNldmVyYWwgYWRqdXN0
bWVudHMgb24gU0RzIGluc3BpcmVkDQpieSB5b3VyIGZlZWRiYWNrLg0KDQo+IE9uIDExLzkvMjAg
MzoxMCBwbSwgS29uc3RhbnRpbiBLb21hcm92IHdyb3RlOg0KPiA+IFRoaXMgYWRkcyBpbml0aWFs
aXphdGlvbiBvZiBzdXBlciBibG9jaw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRp
biBLb21hcm92IDxhbG1hei5hbGV4YW5kcm92aWNoQHBhcmFnb24tc29mdHdhcmUuY29tPg0KPiA+
IC0tLQ0KPiA+ICBmcy9udGZzMy9mc250ZnMuYyB8IDIyMTAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICBmcy9udGZzMy9pbmRleC5jICB8IDI2MzkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGZzL250ZnMzL2lub2Rl
LmMgIHwgMjAwNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGZzL250
ZnMzL3N1cGVyLmMgIHwgMTQzMCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgNCBmaWxl
cyBjaGFuZ2VkLCA4MjgzIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGZz
L250ZnMzL2ZzbnRmcy5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9udGZzMy9pbmRleC5j
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9udGZzMy9pbm9kZS5jDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBmcy9udGZzMy9zdXBlci5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbnRm
czMvZnNudGZzLmMgYi9mcy9udGZzMy9mc250ZnMuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zODE0YjYyMzMxZGINCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvZnMvbnRmczMvZnNudGZzLmMNCj4gPiBAQCAtMCwwICsxLDIyMTAgQEANCj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICog
IGxpbnV4L2ZzL250ZnMzL2ZzbnRmcy5jDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoQykg
MjAxOS0yMDIwIFBhcmFnb24gU29mdHdhcmUgR21iSCwgQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4g
PiArICoNCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvYmxrZGV2Lmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9idWZmZXJfaGVhZC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
ZnMuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L25scy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
c2NoZWQvc2lnbmFsLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiZGVidWcuaCINCltdDQo+ID4g
KwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBfX2V4aXQgZXhp
dF9udGZzX2ZzKHZvaWQpDQo+ID4gK3sNCj4gPiArCWlmIChudGZzX2lub2RlX2NhY2hlcCkgew0K
PiA+ICsJCXJjdV9iYXJyaWVyKCk7DQo+ID4gKwkJa21lbV9jYWNoZV9kZXN0cm95KG50ZnNfaW5v
ZGVfY2FjaGVwKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwl1bnJlZ2lzdGVyX2ZpbGVzeXN0ZW0o
Jm50ZnNfZnNfdHlwZSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwi
KTsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJudGZzMyBmaWxlc3lzdGVtIik7DQo+ID4gK01P
RFVMRV9BVVRIT1IoIktvbnN0YW50aW4gS29tYXJvdiIpOw0KPiA+ICtNT0RVTEVfQUxJQVNfRlMo
Im50ZnMzIik7DQo+ID4gKw0KPiA+ICttb2R1bGVfaW5pdChpbml0X250ZnNfZnMpIG1vZHVsZV9l
eGl0KGV4aXRfbnRmc19mcykNCj4gDQoNClRoYW5rcy4NCg==
