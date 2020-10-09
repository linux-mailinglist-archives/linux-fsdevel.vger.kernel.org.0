Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC7289C02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbgJIXE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 19:04:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:7820 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbgJIXE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 19:04:28 -0400
IronPort-SDR: rIkDMm/uL9FybKzn4lMQPXSNYHu3c3GES3JMa5kmYfgcx6oujPoWyJw53rL2wO6Kx+gtpA5r1u
 KdDL+Wx4rrzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="152466753"
X-IronPort-AV: E=Sophos;i="5.77,356,1596524400"; 
   d="scan'208";a="152466753"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 16:04:26 -0700
IronPort-SDR: YbViz0Rje3d3kiB9PonF9i5zJYNg+KbWFqhiwc8eGIUpUn03tf2pIlrixLoRNYftuc9AU5arqW
 FM5VB82tUAJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,356,1596524400"; 
   d="scan'208";a="344034052"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2020 16:04:25 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Oct 2020 16:04:25 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Oct 2020 16:04:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 9 Oct 2020 16:04:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 9 Oct 2020 16:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWQLhIYXwimuofiPwvDg00g9157/mKcguewSiDDwCPnlyoAFpwsuvj3jTuFH2/y3W0WvAcZFtUC6BzBsWRTALBjZr1sJGNrOG/QiXOb/9OMr1Ytbn+QsjyMbuYtw0p55NyZRFCB/iLYvKWbr/gkrH4vMZZez32YgiXFfgkIQKZMZ9VDXhndFaedCjacJO6v5kpKgpjny0RwqKxkaEO9EHE/k42kyTiexmIbh4haL2LzHdGvE9Aaa5Ap5FbTMNqSHLk3zl+WbN2+uXCksAf4F/iN5dy8EBq1nSEBiHP15KKKz+sBoWK+x17mTRv3Su++Nr58EVrYRFl6K3icGfNml5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjPOHc07o0iRFEhlOZ60lNAPJsUy75JPpsZucZMNz8o=;
 b=Z7Q8UXYBTD3Z9w2heFfsRoKWZINq5vYp4c6cwi3ZRghuTKc4Gq7vfsHgoAKLGJkZNkCMvDaxBIaBw857GGLZVcwP1BW/ifLmjiTK/DUTvGGNvWsI00KS2oqcb9xO6lAFnZiv/KO9u0SbhNUmhHpphGfsnFv7GlTrr0couAy/QTHscvuPhWbidOgmDpjAJltCt27Iv9xRC7i3vbx5pLLdLTLrrjt922PPZVX50B8NXLxWpl7XkAqQG6a5a4CqxU3LnjK+44Ne/RxFc/zCyk6S6Wl96jEN+wjVwFOpYKptVAd4HiGH2meFbG20mcYgIRrr0TEEKWqcmILgiensscGbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjPOHc07o0iRFEhlOZ60lNAPJsUy75JPpsZucZMNz8o=;
 b=lcFP6HW9TBrrRMhk+zYUKFaSHlf02OfC+f7xudQFjptACYyYi+2d4JD6h3ZQB5eqeBc9qnWsRweCUYrGaD2Cz82MO4Nc+BTE67PlmftDgmXvpfi82waG3rGUQNobaHN4sw1pjIZ8rZsFAGFW3pvYf19+R+aRhqXPmywcqsdRN1Y=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BY5PR11MB3910.namprd11.prod.outlook.com (2603:10b6:a03:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Fri, 9 Oct
 2020 23:04:22 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d%7]) with mapi id 15.20.3455.028; Fri, 9 Oct 2020
 23:04:22 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Remove nrexceptional tracking
Thread-Topic: [PATCH 0/4] Remove nrexceptional tracking
Thread-Index: AQHWanrcgiyE+gZ1T06GDixOiuOZv6kr8b+AgAALYACAYoGWgIABzPEA
Date:   Fri, 9 Oct 2020 23:04:22 +0000
Message-ID: <e583f9cd35c8475da691bd667a083969a242d955.camel@intel.com>
References: <20200804161755.10100-1-willy@infradead.org>
         <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
         <ee26fdf05127b7aea69db9d025d6ba5e677479bb.camel@intel.com>
         <20201008193301.GN20115@casper.infradead.org>
In-Reply-To: <20201008193301.GN20115@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14fbba86-2c66-4d60-07d1-08d86ca7a93b
x-ms-traffictypediagnostic: BY5PR11MB3910:
x-microsoft-antispam-prvs: <BY5PR11MB3910C1583864ACA29CE391C4C7080@BY5PR11MB3910.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: riVmwcMfP9n6zT7akDWmsXci/WYtfu/lEosNZ8couF/IjZjuUAwSvczh8K0g1cJfuPnMz9p2ZuBvx2XJi2lFb8HEIxKO2zlRQ3oJL03yLcAIFWTPO8c27OVUfZYqcStx8PACcmJc5vNI+ZpIe++iDN3U+HLaDwVLOtlHTVSY0JyQIVoQ31NoMVUgeKNywldJu+uvb6wSZnyYAeZosnZ9ug8mCIL0wIAMd8h88uyS0mQCj+44uzzD/XmHkGp4T3F7isRdz4qvQUWuMMoajl5rcgMPoEjYckvlLLmp+8P8t5Pc3ykGOSU+T76wW4YlwTfj2dC1RI3SKADc+6UIj3fBL5E6uKTG3QvqzjZcaGBnxgdP74rWuuZaixAaID0/TE57KheaCrC+PpTDVHuLVFWa/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(76116006)(6916009)(4326008)(2616005)(186003)(966005)(8676002)(83380400001)(478600001)(6486002)(316002)(26005)(54906003)(8936002)(71200400001)(66446008)(66946007)(86362001)(66476007)(64756008)(6506007)(36756003)(2906002)(66556008)(83080400001)(5660300002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rgiTHAZIMEjzYRJGQYdodU+CWLuaV6odbDcDrGHKeG+P11MvCBM8JEoKm376TJE6n80dUZ4L4ddqw6E+5GtCsPVkIUrEv1fmRAU+FnJecGSmU0uNaXXnGt7/1oI+ZqCdk4K+HKjGV+sbBV/x3F0TZMI0jd89Rj8r+FKZuDJCOz3EkgHSAzVPVSmcaqHs3A1Lmq9igg70nrNy3KGgbkAeZh4N0xCSXF/9r56oF5M7QqkcZQK9A3GLhJFAXVCetY32rbJSlkmIOeWTAcDYFyMJGObb35UGT0Yrq8ajWWYEazkEqtEha/Cx6qHbVxpkC2Df54jO6128we2Rfxrtxy8EOUUuWpEkVO/gMZOffZfNDhNh8Epwi3Enk/DWT7J+bveg9xqpbUX75ot6JafJ9/B1BwxwPlEjX7/k/aY6wNIn6f3ru42LttemWHGrgIjrPwyCQeIGwef3bBgL8DJwjb8ipPKepx3wGsY3M+WX6IcFvAAGC+a6Bj4/IAgGFZW/4dxK86lZBsLE8maNDAV/G43nrrUtlE/CLRLUyuzfYjSr21flbI1Z7PU9qzBhnWOX66BjRwNfqh8SFqWSSynwDvMez6wpBxRYfutbx09pViDfrER8gnCrybxLcfZGLTmzbAIXUEJFeuCS7vcyWjNJTA/x4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8C2E985693BEA4BB12163290A9FDBB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fbba86-2c66-4d60-07d1-08d86ca7a93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 23:04:22.5992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyO1wJ5WjwXHUOwdbAUUvRSLXjlM0q6hykuin4pibwRMjPRfpsFpsD6T0c8Md51XK5E29dU8av5Fg4a8j/jGuhPbgop5rxe2hPLlLuqCZLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3910
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTA4IGF0IDIwOjMzICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMDg6MTY6MDJQTSArMDAwMCwgVmVybWEsIFZpc2hh
bCBMIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0wOC0wNiBhdCAxOTo0NCArMDAwMCwgVmVybWEs
IFZpc2hhbCBMIHdyb3RlOg0KPiA+ID4gPiBJJ20gcnVubmluZyB4ZnN0ZXN0cyBvbiB0aGlzIHBh
dGNoc2V0IHJpZ2h0IG5vdy4gIElmIG9uZSBvZiB0aGUgREFYDQo+ID4gPiA+IHBlb3BsZSBjb3Vs
ZCB0cnkgaXQgb3V0LCB0aGF0J2QgYmUgZmFudGFzdGljLg0KPiA+ID4gPiANCj4gPiA+ID4gTWF0
dGhldyBXaWxjb3ggKE9yYWNsZSkgKDQpOg0KPiA+ID4gPiAgIG1tOiBJbnRyb2R1Y2UgYW5kIHVz
ZSBwYWdlX2NhY2hlX2VtcHR5DQo+ID4gPiA+ICAgbW06IFN0b3AgYWNjb3VudGluZyBzaGFkb3cg
ZW50cmllcw0KPiA+ID4gPiAgIGRheDogQWNjb3VudCBEQVggZW50cmllcyBhcyBucnBhZ2VzDQo+
ID4gPiA+ICAgbW06IFJlbW92ZSBucmV4Y2VwdGlvbmFsIGZyb20gaW5vZGUNCj4gPiA+IA0KPiA+
ID4gSGkgTWF0dGhldywNCj4gPiA+IA0KPiA+ID4gSSBhcHBsaWVkIHRoZXNlIG9uIHRvcCBvZiA1
LjggYW5kIHJhbiB0aGVtIHRocm91Z2ggdGhlIG52ZGltbSB1bml0IHRlc3QNCj4gPiA+IHN1aXRl
LCBhbmQgc2F3IHNvbWUgdGVzdCBmYWlsdXJlcy4gVGhlIGZpcnN0IGZhaWxpbmcgdGVzdCBzaWdu
YXR1cmUgaXM6DQo+ID4gPiANCj4gPiA+ICAgKyB1bW91bnQgdGVzdF9kYXhfbW50DQo+ID4gPiAg
IC4vZGF4LWV4dDQuc2g6IGxpbmUgNjI6IDE1NzQ5IFNlZ21lbnRhdGlvbiBmYXVsdCAgICAgIHVt
b3VudCAkTU5UDQo+ID4gPiAgIEZBSUwgZGF4LWV4dDQuc2ggKGV4aXQgc3RhdHVzOiAxMzkpDQo+
IA0KPiBUaGFua3MuICBGaXhlZDoNCj4gDQo+ICsrKyBiL2ZzL2RheC5jDQo+IEBAIC02NDQsNyAr
NjQ0LDcgQEAgc3RhdGljIGludCBfX2RheF9pbnZhbGlkYXRlX2VudHJ5KHN0cnVjdCBhZGRyZXNz
X3NwYWNlICptYXBwaW5nLA0KPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgICAg
ZGF4X2Rpc2Fzc29jaWF0ZV9lbnRyeShlbnRyeSwgbWFwcGluZywgdHJ1bmMpOw0KPiAgICAgICAg
IHhhc19zdG9yZSgmeGFzLCBOVUxMKTsNCj4gLSAgICAgICBtYXBwaW5nLT5ucnBhZ2VzIC09IGRh
eF9lbnRyeV9vcmRlcihlbnRyeSk7DQo+ICsgICAgICAgbWFwcGluZy0+bnJwYWdlcyAtPSAxVUwg
PDwgZGF4X2VudHJ5X29yZGVyKGVudHJ5KTsNCj4gICAgICAgICByZXQgPSAxOw0KPiAgb3V0Og0K
PiAgICAgICAgIHB1dF91bmxvY2tlZF9lbnRyeSgmeGFzLCBlbnRyeSk7DQo+IA0KPiBVcGRhdGVk
IGdpdCB0cmVlIGF0DQo+IGh0dHBzOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvd2lsbHkvcGFn
ZWNhY2hlLmdpdC8NCg0KSSByYW4gdGhpcyB0cmVlIHRocm91Z2ggdGhlIHVuaXQgdGVzdHMsIGFu
ZCBldmVyeXRoaW5nIHBhc3Nlcy4NCihXZWxsLCB3aGlsZSB0aGUgdGVzdHMgcGFzc2VkLCB0aGlz
IHRyZWUgYXMtaXMgZGlkIGhhdmUgYW4gUkNVIHdhcm5pbmcNCnNwbGF0LiBJIHJlYmFzZWQgdG8g
djUuOS1yYzggYW5kIHRoYXQgd2FzIGZpbmUpLg0KDQpGZWVsIGZyZWUgdG8gYWRkOg0KDQpUZXN0
ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo=
