Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE127D78F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgI2UGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 16:06:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:4388 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgI2UGH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:06:07 -0400
IronPort-SDR: VmGH5dnZMvoRyATdORBV96AQaIMOabn4olAuxyRWDZ3XqVzCdVPIGWlt1Iq+DD6PKiYmCeaKjz
 5D2PdBSu8n2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159617205"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="159617205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:06:06 -0700
IronPort-SDR: VcVE3O2n5Laha4XZ2A4FlwBt8xsol1geTPl7q03FLZby9R3+H0dkJnEwfGRq375qodYFs/VDc6
 V65VQdzWegvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="345390630"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2020 13:06:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Sep 2020 13:06:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Sep 2020 13:06:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 29 Sep 2020 13:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENBop0ePI1rc/FcjS4xrNJ5ze0x4uONCgvsY15Kdra+HLv4X8mV95PPh9WVB7Zq48WY9aBJzDwWsFGQBwQpc13Wn2FaDAjDaGXeXHv3kLGGQ1yjand+YatKmmUsa2W8DRKkcWXrfeYVs977SRDOY15cs5BymbfNEooqM7PGffA4IWg/IKbz34RKQ87bXDVnMF1P5buh9LHm2KrcrW+VCwe8ncxJyqk1X9RuRA4+/TkNY+1tsDgmvaA8HeciqUWdfEcKhxZbw57+sDaLkRmtAR5raNPLdR8Wue4pG2nrPXq7NGmpeZfTE2pLxtaB5o8sitzMXUD2lMnOOr2LCnn0ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koed3BpYmv9VUEcOHyz7SbD00fGiUDop4Xo8houxLng=;
 b=TCZjiQndK5Klfp29RtPXYXD02CnWq2x2mue3odH14NZ3uYjgwLkrIJLi2uppDIZ0Sq7FXX85FoyC8nKWJivW8roYcnbgSjezYmJRloXpBqaslHFuqn7cMGV7+p8vrKKkjeAKypvgzPQV26JDogX53NNkpeK2Vp7YJjVArFUzTbudM8+X0Dk9YpaFMMXObmOqrxIdz/u1KJHOQm8aRMFPU6Z8gHbTXVIgBE+RLTZPsfcvypSreRSU7sFqxuHf8hb/O16ZSzcRtoKDJ26Pq4q073wGHOhyxZP53dn5uWl0rZlGZ0sg9RNElSJdWnofNq9uL4RgF7U7/mJMzlR0b6ywBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koed3BpYmv9VUEcOHyz7SbD00fGiUDop4Xo8houxLng=;
 b=r7t5HExWv1hdNBBWOZviTL67lHH62+oW5lfxWEVnr35DwJwJpaB4HxrGXx+907KoXS4ZbzLQBusxTdZzyLvG/9tis6zLPK7Lcu61TmZtieKoyA7z9NpFlOok6wToWP9PtDnwowoF/QC7lqZokJPXw3mTMuNqpEb86jIkMcE6jy4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 20:06:03 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 20:06:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "idan.yaniv@ibm.com" <idan.yaniv@ibm.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Topic: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Index: AQHWlh00WOVRjW6Kw0OmwswTJieWmql/llUAgAB1WIA=
Date:   Tue, 29 Sep 2020 20:06:03 +0000
Message-ID: <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
References: <20200924132904.1391-1-rppt@kernel.org>
         <20200924132904.1391-4-rppt@kernel.org>
         <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
         <20200929130602.GF2142832@kernel.org>
In-Reply-To: <20200929130602.GF2142832@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a3e0c7-0d63-4378-d126-08d864b317f4
x-ms-traffictypediagnostic: SA0PR11MB4557:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB455769A7B059D65FD6CF3BBDC9320@SA0PR11MB4557.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33zyXaXOtIT2Gi6nr8USAnRyrrn0ahQhan39d2fVcuqUpjheqX2wOEBfsGkshaAnBD8C+LiKJciUW4iy1SdsHEEdJGqcH+YOd96umFEfPIdZYMx795MNHD/ekCw+ulBuSRVE2bP+ZzIR8Jkj7vpiKK6zo8ec2ii6atpRKf+LBxUwnqelX0a3SuaEO/fKyP7hWe0l8Q+11aO7RjHG8RffDHlX6+UE1oPlmcXMS4OXhT2s3iFusUZ01JrHbCdQrPDeqAdY1/gXmfWCBqQOxjjzRj8wNWNZqmNzJrbaq+qSlTIpd5zP+mRjcDhCQAwr65ro9zQMgGHVY1+Yjcyz22i1B4cq3tO12CznA0n4ipHudFzdpJpBiLY/JgqtWdsM654nwhUSrJOHTemXnO95/hdHp16/10eIOY3fZXaDsiomYcM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(6506007)(186003)(6512007)(26005)(66946007)(76116006)(91956017)(5660300002)(2906002)(83380400001)(71200400001)(316002)(4326008)(478600001)(54906003)(2616005)(36756003)(8676002)(7406005)(7416002)(6916009)(6486002)(8936002)(86362001)(66556008)(66476007)(64756008)(66446008)(219293001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b3FzD7aP75Zl8mMBqptRH9cBlwAPaDH9PtSbG7uTP32Lo77BSEjkA5V2t37LjO4DdIwqylDeGfnE/GCLHYP/Moig8i4NM43+Pem7wMG3ud2i0cpRXLH0oeVuZDA7YJ9ifILxuircngxIpJ59vMY7qPJq7O3KqB7VF1jLJwYONIgXMjICRPQgpIjGVy1fgTTAt/5QaZhsxcLWbnDIfW8E2e/7AmSEc6C7+s2Al2SJ9GACDOExH/h42FFVaoBUgP8lZ19PU6ZTWi3BElU9y9rOwfMoYVyOwCgjnELR3cdiW/+Uip+TqppGoLxx1wVgBUorEIg71XIeRwq4BiOdvGPwwm6byZagwx2YIQExlI1AhsIzqdDC1kjyI1trkthfaELjLKfDerz9ZdD553MasndxCIfdH9AUUt2tNnbEAjUXJQhNkSKuvaBR4NTi4skpQoCEo2W9gbogV0Kq8nNCRDUz1OnKfFGcMc/Aq4M2FpLJLdx/KUB55mJbCS5DW43rT/KKcFTiFkPOzAAnKnuYcV0UD9Pde+d1tY2NsNFmN+lWatkE6tMkj5idLtMZCmQ7jF3J/aUzGYunGz/niaMOx8XDJg+iZRhHguTwpZ3J8g+FEVVlR9PjAPzUwvUfNaliZfOZsYJPyUY3CTpNzTeVQO3p7g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2263CE22901AC047BEFEFC460E5A3197@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3e0c7-0d63-4378-d126-08d864b317f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 20:06:03.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qerPx6uvSfiDlNkAn28LFar8dqkVT0D7PYtTQX37E+jOeHFUu4i91ljcPYyoeqKxGuWJQtakG92lFFpNSzrUBDA8Y8loSYskpx9SPDS4p1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTI5IGF0IDE2OjA2ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAwNDo1ODo0NEFNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDktMjQgYXQgMTY6MjkgKzAzMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiBJbnRyb2R1Y2UgIm1lbWZkX3NlY3JldCIgc3lzdGVtIGNh
bGwgd2l0aCB0aGUgYWJpbGl0eSB0byBjcmVhdGUNCj4gPiA+IG1lbW9yeQ0KPiA+ID4gYXJlYXMg
dmlzaWJsZSBvbmx5IGluIHRoZSBjb250ZXh0IG9mIHRoZSBvd25pbmcgcHJvY2VzcyBhbmQgbm90
DQo+ID4gPiBtYXBwZWQgbm90DQo+ID4gPiBvbmx5IHRvIG90aGVyIHByb2Nlc3NlcyBidXQgaW4g
dGhlIGtlcm5lbCBwYWdlIHRhYmxlcyBhcyB3ZWxsLg0KPiA+ID4gDQo+ID4gPiBUaGUgdXNlciB3
aWxsIGNyZWF0ZSBhIGZpbGUgZGVzY3JpcHRvciB1c2luZyB0aGUgbWVtZmRfc2VjcmV0KCkNCj4g
PiA+IHN5c3RlbSBjYWxsDQo+ID4gPiB3aGVyZSBmbGFncyBzdXBwbGllZCBhcyBhIHBhcmFtZXRl
ciB0byB0aGlzIHN5c3RlbSBjYWxsIHdpbGwNCj4gPiA+IGRlZmluZQ0KPiA+ID4gdGhlDQo+ID4g
PiBkZXNpcmVkIHByb3RlY3Rpb24gbW9kZSBmb3IgdGhlIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGgg
dGhhdCBmaWxlDQo+ID4gPiBkZXNjcmlwdG9yLg0KPiA+ID4gDQo+ID4gPiAgIEN1cnJlbnRseSB0
aGVyZSBhcmUgdHdvIHByb3RlY3Rpb24gbW9kZXM6DQo+ID4gPiANCj4gPiA+ICogZXhjbHVzaXZl
IC0gdGhlIG1lbW9yeSBhcmVhIGlzIHVubWFwcGVkIGZyb20gdGhlIGtlcm5lbCBkaXJlY3QNCj4g
PiA+IG1hcA0KPiA+ID4gYW5kIGl0DQo+ID4gPiAgICAgICAgICAgICAgICBpcyBwcmVzZW50IG9u
bHkgaW4gdGhlIHBhZ2UgdGFibGVzIG9mIHRoZSBvd25pbmcNCj4gPiA+IG1tLg0KPiA+IA0KPiA+
IFNlZW1zIGxpa2UgdGhlcmUgd2VyZSBzb21lIGNvbmNlcm5zIHJhaXNlZCBhcm91bmQgZGlyZWN0
IG1hcA0KPiA+IGVmZmljaWVuY3ksIGJ1dCBpbiBjYXNlIHlvdSBhcmUgZ29pbmcgdG8gcmV3b3Jr
IHRoaXMuLi5ob3cgZG9lcw0KPiA+IHRoaXMNCj4gPiBtZW1vcnkgd29yayBmb3IgdGhlIGV4aXN0
aW5nIGtlcm5lbCBmdW5jdGlvbmFsaXR5IHRoYXQgZG9lcyB0aGluZ3MNCj4gPiBsaWtlDQo+ID4g
dGhpcz8NCj4gPiANCj4gPiBnZXRfdXNlcl9wYWdlcygsICZwYWdlKTsNCj4gPiBwdHIgPSBrbWFw
KHBhZ2UpOw0KPiA+IGZvbyA9ICpwdHI7DQo+ID4gDQo+ID4gTm90IHN1cmUgaWYgSSdtIG1pc3Np
bmcgc29tZXRoaW5nLCBidXQgSSB0aGluayBhcHBzIGNvdWxkIGNhdXNlIHRoZQ0KPiA+IGtlcm5l
bCB0byBhY2Nlc3MgYSBub3QtcHJlc2VudCBwYWdlIGFuZCBvb3BzLg0KPiANCj4gVGhlIGlkZWEg
aXMgdGhhdCB0aGlzIG1lbW9yeSBzaG91bGQgbm90IGJlIGFjY2Vzc2libGUgYnkgdGhlIGtlcm5l
bCwNCj4gc28NCj4gdGhlIHNlcXVlbmNlIHlvdSBkZXNjcmliZSBzaG91bGQgaW5kZWVkIGZhaWwu
DQo+IA0KPiBQcm9iYWJseSBvb3BzIHdvdWxkIGJlIHRvIG5vaXN5IGFuZCBpbiB0aGlzIGNhc2Ug
dGhlIHJlcG9ydCBuZWVkcyB0bw0KPiBiZQ0KPiBsZXNzIHZlcmJvc2UuDQoNCkkgd2FzIG1vcmUg
Y29uY2VybmVkIHRoYXQgaXQgY291bGQgY2F1c2Uga2VybmVsIGluc3RhYmlsaXRpZXMuDQoNCkkg
c2VlLCBzbyBpdCBzaG91bGQgbm90IGJlIGFjY2Vzc2VkIGV2ZW4gYXQgdGhlIHVzZXJzcGFjZSBh
ZGRyZXNzPyBJDQp3b25kZXIgaWYgaXQgc2hvdWxkIGJlIHByZXZlbnRlZCBzb21laG93IHRoZW4u
IEF0IGxlYXN0DQpnZXRfdXNlcl9wYWdlcygpIHNob3VsZCBiZSBwcmV2ZW50ZWQgSSB0aGluay4g
QmxvY2tpbmcgY29weV8qX3VzZXIoKQ0KYWNjZXNzIG1pZ2h0IG5vdCBiZSBzaW1wbGUuDQoNCkkn
bSBhbHNvIG5vdCBzbyBzdXJlIHRoYXQgYSB1c2VyIHdvdWxkIG5ldmVyIGhhdmUgYW55IHBvc3Np
YmxlIHJlYXNvbg0KdG8gY29weSBkYXRhIGZyb20gdGhpcyBtZW1vcnkgaW50byB0aGUga2VybmVs
LCBldmVuIGlmIGl0J3MganVzdA0KY29udmVuaWVuY2UuIEluIHdoaWNoIGNhc2UgYSB1c2VyIHNl
dHVwIGNvdWxkIGJyZWFrIGlmIGEgc3BlY2lmaWMNCmtlcm5lbCBpbXBsZW1lbnRhdGlvbiBzd2l0
Y2hlZCB0byBnZXRfdXNlcl9wYWdlcygpL2ttYXAoKSBmcm9tIHVzaW5nDQpjb3B5XypfdXNlcigp
LiBTbyBzZWVtcyBtYXliZSBhIGJpdCB0aG9ybnkgd2l0aG91dCBmdWxseSBibG9ja2luZw0KYWNj
ZXNzIGZyb20gdGhlIGtlcm5lbCwgb3IgZGVwcmVjYXRpbmcgdGhhdCBwYXR0ZXJuLg0KDQpZb3Ug
c2hvdWxkIHByb2JhYmx5IGNhbGwgb3V0IHRoZXNlICJubyBwYXNzaW5nIGRhdGEgdG8vZnJvbSB0
aGUga2VybmVsIg0KZXhwZWN0YXRpb25zLCB1bmxlc3MgSSBtaXNzZWQgdGhlbSBzb21ld2hlcmUu
DQo=
