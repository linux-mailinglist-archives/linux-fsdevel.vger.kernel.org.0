Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB082484654
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 18:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiADRA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 12:00:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:3496 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbiADRA7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641315659; x=1672851659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X6xbl59nYo7TcjzEql3Y63Xhgv2KDDu7I5UBZu7/Nvc=;
  b=SiID7IuhFhdXHez/6cpCW4OVhyr4sSVe8qxxyqtlalIfp0kjRIXyXpT6
   E3vJowgYDuavgTV/20l115/yT5bPve9oHI0TuSzN8TOINVdqz0Y0adrRG
   oO2wGHGRTggnjked7Hi/+JXyKUX9h3LFO0u67UytORsiwA2D9D5YTpdBU
   qIE58R+LN0yLS2NTLsK82Vizti9Gh5DXANWrBSwGRofCATh12oEKqvK1A
   xrlksXDrrLllAshsWclW14pMDycN6AO8OeRgS4tS1dZcNg8jKLQNqCmSU
   NHMo0tXG/+/lujOva2R0l3OoxNqCsmMzr5fV5Wi7qL4bHvpJM7FEUjirR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242215552"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242215552"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 09:00:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="620710371"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2022 09:00:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 09:00:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 09:00:57 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Tue, 4 Jan 2022 09:00:57 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: RE: pstore/ramoops - why only collect a partial dmesg?
Thread-Topic: pstore/ramoops - why only collect a partial dmesg?
Thread-Index: AQHX/MKP8AekIclEL0GvU4ZDFIVyq6xR+V6AgAFdcoD//8ds4A==
Date:   Tue, 4 Jan 2022 17:00:57 +0000
Message-ID: <a361c64213e7474ea39c97f7f7bd26ec@intel.com>
References: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
 <2d1e9afa38474de6a8b1efc14925d095@intel.com>
 <0ca4c27a-a707-4d36-9689-b09ef715ac67@igalia.com>
In-Reply-To: <0ca4c27a-a707-4d36-9689-b09ef715ac67@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBIaSBUb255LCB0aGFua3MgYSBsb3QgZm9yIHlvdXIgcmVzcG9uc2UhIEl0IG1ha2VzIHNlbnNl
IGluZGVlZCwgYnV0IGluDQo+IG15IGNhc2UsIGZvciBleGFtcGxlLCBJIGhhdmUgYSAibG9nX2J1
Zl9sZW49NE0iLCBidXQgY2Fubm90IGFsbG9jYXRlIGENCj4gNE0gcmVjb3JkX3NpemUgLSB3aGVu
IEkgdHJ5IHRoYXQsIEkgY2FuIG9ubHkgc2VlIHBhZ2VfYWxsb2Mgc3Bld3MgYW5kDQo+IHBzdG9y
ZS9yYW1vb3BzIGRvZXNuJ3Qgd29yay4gU28sIEkgY291bGQgYWxsb2NhdGUgMk0gYW5kIHRoYXQg
d29ya3MNCj4gZmluZSwgYnV0IEkgdGhlbiBsb3NlIGhhbGYgb2YgbXkgZG1lc2cgaGVoDQo+IEhl
bmNlIG15IHF1ZXN0aW9uLg0KPg0KPiBJZiB0aGVyZSdzIG5vIHNwZWNpYWwgcmVhc29uLCBJIGd1
ZXNzIHdvdWxkIG1ha2Ugc2Vuc2UgdG8gYWxsb3cgcmFtb29wcw0KPiB0byBzcGxpdCB0aGUgZG1l
c2csIHdoYXQgZG8geW91IHRoaW5rPw0KDQpHdWlsaGVybWUsDQoNCkxpbnV4IGlzIGluZGVlZCBz
b21ld2hhdCByZWx1Y3RhbnQgdG8gaGFuZCBvdXQgYWxsb2NhdGlvbnMgPiAyTUIuIDotKA0KDQpE
byB5b3UgcmVhbGx5IG5lZWQgdGhlIHdob2xlIGRtZXNnIGluIHRoZSBwc3RvcmUgZHVtcD8gIFRo
ZSBleHBlY3RhdGlvbg0KaXMgdGhhdCBzeXN0ZW1zIHJ1biBub3JtYWxseSBmb3IgYSB3aGlsZS4g
RHVyaW5nIHRoYXQgdGltZSBjb25zb2xlIGxvZ3MgYXJlDQpzYXZlZCBvZmYgdG8gL3Zhci9sb2cv
bWVzc2FnZXMuDQoNCldoZW4gdGhlIHN5c3RlbSBjcmFzaGVzLCB0aGUgbGFzdCBwYXJ0ICh0aGUg
aW50ZXJlc3RpbmcgYml0ISkgb2YgdGhlIGNvbnNvbGUNCmxvZyBpcyBsb3N0LiAgVGhlIHB1cnBv
c2Ugb2YgcHN0b3JlIGlzIHRvIHNhdmUgdGhhdCBsYXN0IGJpdC4NCg0KU28gd2hpbGUgeW91IGNv
dWxkIGFkZCBjb2RlIHRvIHJhbW9vcHMgdG8gc2F2ZSBtdWx0aXBsZSAyTUIgY2h1bmtzLCBpdA0K
ZG9lc24ndCBzZWVtICh0byBtZSkgdGhhdCBpdCB3b3VsZCBhZGQgbXVjaCB2YWx1ZS4NCg0KLVRv
bnkNCg==
