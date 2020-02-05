Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52B915247B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 02:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBEBgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 20:36:07 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8169 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgBEBgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580866567; x=1612402567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tUC/weLluA4zXkbVMM90kQ+DAn1nk78q9gJFp8I1CZo=;
  b=jq1UyprwC+8oohI/ZNkH3eK5dKBUl4kXeD5fL/iyX43BeGsMBxU6CXx+
   GBmNHZ4m/NAMHKVVvcb02/hiP+i69uv69axba/eL/MHKY7EFf79e0W1Y7
   2JSHFX8sChSk37eKwO3lUM3NOY6I8o5hMXQ18Tq7+2dSmA7VzLrNxnXbU
   c9ly8rx8187hPfVnRtWBUSEnspwOLUABCFbpqgRXTFNvIY0EWiYFqpZcT
   im3dlTdUFpZ+D1egmd37AgksKEHq3pgUVCbiRCU0tE0EUBE6IOn37ptjN
   6htAqLqXyKYLGUjg8jkmCAVnE2i71KUQUUxY2kjMuDfdmCbaoE/cDqKI6
   w==;
IronPort-SDR: gl/Lvve5G3/Q9R5ysR/YOXX+4gk86dvU64gLXguj1OIKqqXNbjKR8oeOrCzxIOn+jl2OELeGf4
 bWYzOyMtT+6FzjLM5KjBINGpePlKyUOcd0D1mCaw01Z2TKHcjSSvAT2OAmlXknrpiRNAYk4KE+
 jBLcdtgupdZ/ZpHZix2UV1fHEp+dBOrm3PmqwpbUbocbL3l5NXbPR6tfEyjEga18JoObSxvbHQ
 nTHzW+3HD/tID+45PRQf1gaCfaM8N7ZpQF0JLNVI/v+zV1ps2PYt2XwQUuvkhTDfI9hnszU8iy
 w5M=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; 
   d="scan'208";a="133465936"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 09:36:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMFmIXqKOaoKecaZVy2Rg59AXnIYfgG0rsKkT090zBirUmmhhJNBwPD/7c4MkUJ00h6OetePPb+rL1CTbxoK80T9yxFbz/PfhqZNc626IKli4i9VGvc7piQccJCun8CViVPkbQLn3JVPxQFQkGD3NV9waBUOauS08FIJj2MaV142gZ6Xg0TayTlSXN32Ccm1SJq+aEhK5kNKaJ9mRecDplxxeWSJg8RjLSmaAs/+wQRmTxaDacsQevARzNgkntytIuPl/LXLdvtPV3A+caONtWpshK+yC6u+pxjutvfXwy7W2rJOhPU7dbxcnYeeq/W4mAC4pDyRrZkrXtWPUzoylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUC/weLluA4zXkbVMM90kQ+DAn1nk78q9gJFp8I1CZo=;
 b=KRtJbPe4V2nQSbf+KoH4jDhkfvIPZ328uyLbLTegPdmIFb5f4Kam8+0mjdIJDxjJLGn9vUKQrFt6ztedNNxiwPejK93k8BcoN1rPvB7B9NpqMgdRGu5PrFYGKG7NtdxdlaTBSt8h4H7LzfEz85uOeROezf8jmbMRlcRZy9rsCcrzO3hki6ixgDDZCArmUxkX9EKqQj0khL3nkRF9JeTPWMpP6EqE0W8/+feAuTVWk0hgYOn7/B+7gbvzy0m4uMejtac3MeaQt4sLBolVSHEdyf7NGn2pdH/DWPkPIvqW0K9ReQiXX2lq8F48nmDiKPIRTQjs3nB3t4Zg169lvlocLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUC/weLluA4zXkbVMM90kQ+DAn1nk78q9gJFp8I1CZo=;
 b=r6gjIFdLSFiXK2ZbXtWqbkY8EA5OXhgai5jBe66rCUH8XM7IbD+NPxZ0QXQ9aBw3LzSxU0JoIf+m2MDGeUIkg0LB6GqH8dh8e3dnaq5eXtIeKYCd5Kjo2EIvOTN2VPvG6dAdYJwCqnFmTh1ZaTXcUpttorHBtUn87Zkz2/PFZec=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4677.namprd04.prod.outlook.com (52.135.240.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 01:35:59 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 01:35:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v10 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v10 1/2] fs: New zonefs file system
Thread-Index: AQHV20ADF3+Bss54OkKg7zGNiqEfb6gL0rsA
Date:   Wed, 5 Feb 2020 01:35:58 +0000
Message-ID: <cfb36fa5dcf97113198848874c0ca9ba215e26fa.camel@wdc.com>
References: <68ef8614-87f8-1b6e-7f55-f9d53a0f1e1c@web.de>
In-Reply-To: <68ef8614-87f8-1b6e-7f55-f9d53a0f1e1c@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 (3.34.3-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b146daf-3c4e-488d-f797-08d7a9dbc0ba
x-ms-traffictypediagnostic: BYAPR04MB4677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4677EC039B4C1DF503A2C46CE7020@BYAPR04MB4677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(2616005)(2906002)(66946007)(86362001)(26005)(91956017)(71200400001)(6506007)(4744005)(64756008)(66556008)(66476007)(66446008)(186003)(76116006)(5660300002)(36756003)(54906003)(110136005)(316002)(6486002)(81166006)(8936002)(81156014)(8676002)(478600001)(4326008)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4677;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9VAv2uQPzNVfj+4T5Hd+snEB/MiXOYQobuh+mWHSPpFFqVLgquvm1S5siO62JOedJlbnv8yJs6XQbSjaVZyoDfIFKXVOqIaVrmEeRYm445ZgskyPVIocHWpHoo4VHb7DoF28eVNS0gxr7e0K6jCdlbhUZstvJw7HUOUU2yxbaGh+T3T+DqD+eWVkptTX92tx9BNhhxtwUbsjfuEXvGtXJ7xRquQ7YWnEjDhM2soNQRWERzx44xQqtYutwk0rivQHf63B0ql/aYnyOUyY+v/EHJsLYO1K/dgOdY5tAwcAvWjPfgATSQoEabDFo/ODJYWHt3RUGqwJpoFQFXw6CGAHjCLHtx27VKlLjzcsUdpMhlfwxqIycirP+5UIby5QE7VnDo6QVcLLH78YiUXpT7GAKxdThKvV6jO43VQtVzB9IB9jHsL7KaE/rIR8suoavqsh
x-ms-exchange-antispam-messagedata: O4nrtYeU14SgElbRC4lalGR5k2t77hG7AyA3wKdKvq3fGu8mnS9wrUGmnK94WD3InqGkvgwfhl7mXgK5Hv7KldazABWFpn5B+4UxKEpBC0ywPtC5W0TuJ84Z2sxiY0/eZ8EuutboNsNCwwRNwi/aHg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <81DEECF8680B74498D7C673139051F4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b146daf-3c4e-488d-f797-08d7a9dbc0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 01:35:58.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxqawQQGdnwogqDULz6cKu8mf4g0orCFCLfbWmrOJDPF4R9O+zrABKundvf5ipealnd6xayQL2Nq2fx0fuQpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4677
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTA0IGF0IDEwOjQ2ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4g4oCmDQo+ID4gKysrIGIvZnMvem9uZWZzL3N1cGVyLmMNCj4g4oCmDQo+ID4gK3N0YXRpYyBj
b25zdCBjaGFyICp6Z3JvdXBzX25hbWVbWk9ORUZTX1pUWVBFX01BWF0gPSB7ICJjbnYiLCAic2Vx
IiB9Ow0KPiANCj4gQ2FuIHRoaXMgYXJyYXkgYmUgdHJlYXRlZCBhcyBpbW11dGFibGU/DQo+IEhv
dyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gdXNlIHRoZSBmb2xsb3dpbmcgY29kZSB2YXJpYW50Pw0K
PiANCj4gK3N0YXRpYyBjb25zdCBjaGFyIGNvbnN0ICp6Z3JvdXBzX25hbWVbWk9ORUZTX1pUWVBF
X01BWF0gPSB7ICJjbnYiLCAic2VxIiB9Ow0KDQpUaGF0IGRvZXMgbm90IGNvbXBpbGU6IGR1cGxp
Y2F0ZWQgY29uc3QuDQpJbiBhbnkgY2FzZSwgSSBhbSBub3Qgc3VyZSB3aGF0IHRoaXMgd291bGQg
YWNoaWV2ZSBzaW5jZSBzdHJpbmcNCmxpdGVyYWxzIGFyZSBjb25zdGFudHMgYnkgZGVmYXVsdCBh
bmQgdGhlIHBvaW50ZXIgdG8gdGhlIGFycmF5IGlzDQpkZWNsYXJlZCBhcyBhIGNvbnN0YW50IHRv
by4gVGhpcyBlbmRzIHVwIGNvbXBsZXRlbHkgd2l0aCByZWFkLW9ubHkgdGV4dA0Kc2VjdGlvbi4N
Cg0KRGVjbGFyaW5nIGl0IGFzDQoNCnN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qgemdyb3Vwc19u
YW1lW10gPSB7ICJjbnYiLCAic2VxIiB9Ow0KDQppcyBwcm9iYWJseSB3aGF0IHlvdSBhcmUgc3Vn
Z2VzdGluZywgYnV0IHNpbmNlIHRoZSBzdHJpbmcgbGl0ZXJhbHMgYXJlDQphbHJlYWR5IGNvbnN0
YW50cyBieSBkZWZhdWx0LCBJIGRvIG5vdCB0aGluayB0aGVyZSBpcyBhbnkgZGlmZmVyZW5jZS4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rl
cm4gRGlnaXRhbCBSZXNlYXJjaA0K
