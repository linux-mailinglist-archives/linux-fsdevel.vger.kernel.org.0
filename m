Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2227022E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIRQ3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:29:54 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53499 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgIRQ3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:29:38 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 12:29:36 EDT
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 13FFE822EC;
        Fri, 18 Sep 2020 19:29:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1600446575;
        bh=3JQT+w9/Hsgc+km87u8z17muCt7VlyH5lVmvIBMEwMk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=qusXzOEfnkBwmhOqSMWKkUHHm5C0fhsnDuHsMi0emaW72b662oBL2sXTF1dhnC/0+
         NM3zIDsfH91GwrXZCXkfrsPVniCMl4R/rt5TyZNh7szKLmyCq4NQhrmDK9Am0jO9te
         0/+Tbsb1TgDTrCmott5VLLoHHEqS7MEK3pa6jJe8=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 19:29:34 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 18 Sep 2020 19:29:34 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Joe Perches <joe@perches.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: RE: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Thread-Topic: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Thread-Index: AQHWiEVLqTuLvbWOTEKMmELjfZa26KlmuM8AgAfn8LA=
Date:   Fri, 18 Sep 2020 16:29:34 +0000
Message-ID: <5b2fbfee0a9d4ee59c0e624844560413@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
         <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
 <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
In-Reply-To: <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
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

RnJvbTogSm9lIFBlcmNoZXMgPGpvZUBwZXJjaGVzLmNvbT4NClNlbnQ6IFN1bmRheSwgU2VwdGVt
YmVyIDEzLCAyMDIwIDk6NDQgUE0NCj4gDQo+IE9uIEZyaSwgMjAyMC0wOS0xMSBhdCAxNzoxMCAr
MDMwMCwgS29uc3RhbnRpbiBLb21hcm92IHdyb3RlOg0KPiA+IFRoaXMgYWRkcyBiaXRtYXANCj4g
DQo+ICQgbWFrZSBmcy9udGZzMy8NCj4gICBTWU5DICAgIGluY2x1ZGUvY29uZmlnL2F1dG8uY29u
Zi5jbWQNCj4gICBDQUxMICAgIHNjcmlwdHMvY2hlY2tzeXNjYWxscy5zaA0KPiAgIENBTEwgICAg
c2NyaXB0cy9hdG9taWMvY2hlY2stYXRvbWljcy5zaA0KPiAgIERFU0NFTkQgIG9ianRvb2wNCj4g
ICBDQyAgICAgIGZzL250ZnMzL2JpdGZ1bmMubw0KPiAgIENDICAgICAgZnMvbnRmczMvYml0bWFw
Lm8NCj4gZnMvbnRmczMvYml0bWFwLmM6IEluIGZ1bmN0aW9uIOKAmHduZF9yZXNjYW7igJk6DQo+
IGZzL250ZnMzL2JpdG1hcC5jOjU1Njo0OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2Yg
ZnVuY3Rpb24g4oCYcGFnZV9jYWNoZV9yZWFkYWhlYWRfdW5ib3VuZGVk4oCZOyBkaWQgeW91IG1l
YW4NCj4g4oCYcGFnZV9jYWNoZV9yYV91bmJvdW5kZWTigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgIDU1NiB8ICAgIHBhZ2VfY2FjaGVfcmVhZGFoZWFkX3Vu
Ym91bmRlZCgNCj4gICAgICAgfCAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4g
ICAgICAgfCAgICBwYWdlX2NhY2hlX3JhX3VuYm91bmRlZA0KPiBjYzE6IHNvbWUgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkOjI4MzogZnMvbnRmczMvYml0bWFwLm9dIEVycm9yIDENCj4gbWFrZVsxXTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUwMDogZnMvbnRmczNdIEVycm9yIDINCj4gbWFrZTogKioq
IFtNYWtlZmlsZToxNzkyOiBmc10gRXJyb3IgMg0KPiANCkhpIEpvZSEgRG9lc24ndCBzZWVtIHRv
IGJlIGFuIGlzc3VlIGZvciA1LjlfcmM1LiBXaGljaCByZXBvIHNob3VsZCd2ZQ0KYmVlbiB1c2Vk
IHRvIHJlcHJvZHVjZT8NCg0KVGhhbmtzLg0K
