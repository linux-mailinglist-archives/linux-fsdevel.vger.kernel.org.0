Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04A27F30B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 22:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgI3ULo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 16:11:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:36054 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgI3ULm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:11:42 -0400
IronPort-SDR: lFtgBlccY4NFmtsc8q71Ukw6hp8c2cnxlvhfKvlDz8nzWMLj4izAm51qXsodvg6pOi+ZXmZXJQ
 XWL5n6u3CQ2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="163396849"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="163396849"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 13:11:38 -0700
IronPort-SDR: OJSa4+XxYXqfUPAK9UUbHzPZlmbUVAr1l1Q7Q8Ff2mvdDL7ST+20CxK0HPtAM5hIy0Wg79vzmN
 jKUQqXDMt8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="385246649"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2020 13:11:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 13:11:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Sep 2020 13:11:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 30 Sep 2020 13:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPD52p86GubJjejQnpUrUsQEjbbPBsOKtNdNr/Kj7JumQfMr2uLoT3ZAchSmbpODHFPm3O0V37cfA6qvuAyPjQViCGVQhjKcLqclpBb0deTVhLvYeHH/mv3mWZM46u8ruoJOIsCeyJrDFvh1K1BRe5t5po+InBAarG82ppAFEh3U1R5/UywOy+zZGuCJYeW2Zq2ix9rT8iAlImL0j7GYKeAY9008i2d0s+hY38Pe2m8X7if32+BaJ4ISd6of3v8c/YKyn9CeGi285hezU1snMcLfskzaEIcxvB8b0EEpD/weqgQpOGOQvq0MRo72k7LZ463V+zW/VwUoJnZg+YHySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND/Wbb60HAu47zwB0FSd1hJ1RUJu3tYttZkk7WEv8II=;
 b=EGW05nX7ZVhuojLaVEQodMtYWWii1dffKSStvwm2OI25KDGEn5heD4MX7uiZ1a+ZLr0Mb/LAOqH7of/pCItzVRjKQ9GjQLB2vycI82h0pgCnQc8YYb8+r5eEl2e5PUMbOy7TiW3psGRm/eF1qqg0Tb6NsbpIYH/9YEwplY/cE8Wgm8sZQIXB/4MGTlIbVIwIiHsv6Aocmuivd5/A2ND2RFzXboAxKP3SL4/flGQ8ubrhLScVeFSsmL4yo3tlkl5ZR2xz85a5rnWpq3M23O7/UX6FyI9GsTxh7WjcYvIHJuurcfwVuXznVimHrwV1M6DlciqSy8HiCrbETAvCXhV0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND/Wbb60HAu47zwB0FSd1hJ1RUJu3tYttZkk7WEv8II=;
 b=sGXvtV3AC69ro8aXHNQoO0YLWM1Cp7Ded6vUHq6/Rh3+MO34HVHGOxOkV9VO5xUrEWggVHX7R/w9xfS5MVe/ibKxt6PCw5Mn/Tmju3tMd1SKQtsW8SSYqcuz7CV0pFzu/Y0bowElBRlPizvOfPo38/9zCNV6/ckUguh9dOwh1d0=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB2798.namprd11.prod.outlook.com (2603:10b6:805:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 20:11:29 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 20:11:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Topic: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Index: AQHWlh00WOVRjW6Kw0OmwswTJieWmql/llUAgAB1WICAAPLTgIAAoQaA
Date:   Wed, 30 Sep 2020 20:11:28 +0000
Message-ID: <b5d8e90c5366a42e7ad0a337fba5f2b1bcfe52c2.camel@intel.com>
References: <20200924132904.1391-1-rppt@kernel.org>
         <20200924132904.1391-4-rppt@kernel.org>
         <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
         <20200929130602.GF2142832@kernel.org>
         <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
         <20200930103507.GK2142832@kernel.org>
In-Reply-To: <20200930103507.GK2142832@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44700f8a-7bf0-4121-7e3d-08d8657d043e
x-ms-traffictypediagnostic: SN6PR11MB2798:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2798B89C06725545A0CF0991C9330@SN6PR11MB2798.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h46gdzy0CUu0LhcH9RRgqwg/GTdIxbPkgIO2VnchHlNke5hWKc6OXra30/ROjuWE0cbgHaXtjb3OP7/a4+iymukQ3PfVMEZxzvVvrH8Fa50ghEdGXYjqFNelylnBxjBpLv1X1VF9LELvkJdHrr4C748wtNCEoXMUVuw7XzUq7JZROM/m6Vy9YcheHTBO+UZ73BoC2WRLTT9Ew0Tu8rp5QpjAjeYqJ791RGwHZh2rlEhH5Da+aWRjD2Fga137DKI25M782EjhvISoIIDFlH8lo4bDCzrPn0EjtZs5EnkWZMtv166oD/unQlj99/IYNNCkSsgRUd6v8BjWgwu1CuAjdmS5dKyWlQ5hGsCNuweQGTwg6cESQSwpaUmQMpTkFpShAm5h6c4zKg/fey4HZqPx2c0PmiBXz+f1mK0qMustQ6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(7416002)(7406005)(5660300002)(2616005)(478600001)(71200400001)(6506007)(83380400001)(64756008)(6916009)(54906003)(66446008)(6512007)(6486002)(76116006)(66946007)(26005)(66476007)(66556008)(91956017)(2906002)(86362001)(8676002)(36756003)(186003)(8936002)(316002)(4326008)(219293001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vl8tXrLpYvx0Tm4BwsdR2gSzzSOklwI5dCufHzcD6i6c5x9Tc1RJCDRtv68JI6TvOxrN0DUNSqlav4esL1JvpyK0+XR4R6PkwBzQKwooPBLuG4fmS9W1myttV8dIySIN8j2mBHOhHePzg/cdjgwdqRimtPDkbU4dTFnz9YF6HCSLq0nx1vqQ70KALYwfYEEP2/bcUH3vB2ZVN+GD9Xx9K7fhtK2xJP1be0cM5VUz6gBGqDf+D2J1ktL46aCXwGt5K0RT5pgz/1wl001q6NF32X4+3ftZMxvu0h/Bpx+yaQh/7N4qgdHuiC8w+XR8wWhCV48+0kfCGzVXvtd4sSk3fLx2T5/cpiLNpKc6NZG+qjJSIAvmCt+TMDMxVLpg8AXCp/PGnXrlnuPwTVoP2HFiECh/C7pO8lV2mZ3OfY/jzCy6Px2jOEn+GXi5uWtEoywSYqCUeCkqB+dP5J+h7o34P5gwyHyl3dVRQoC+8jeV3eEyGmH7yqHyl5a9gs8K6aZSXg8oUh29u+iWY1LMO11q5whzoDtquooAWx7Sq/kbT//f2Nk4IMD0bfhcW1PRPgqwXks1+k9nv+7xrxFfSqqaq3ZvqlXBleBJaEsdCBNHnMlDUwVSUr2iT8s8nbfLeaWddN/PsrQaoIQz1RCMdsj2Kg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <82FEBE7E3064664F8F5914ACC287F131@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44700f8a-7bf0-4121-7e3d-08d8657d043e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 20:11:28.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXw7HGJz588Qxw7T8ltw2WwSJM7B+Ggfo3k2w3vqhxaQ9Uzcad+V/nTKBJ0KbdMoThaKEoQao3vEAhTa2euENw/09bfj2sNX6g0N6hfw5T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2798
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTMwIGF0IDEzOjM1ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAwODowNjowM1BNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAtMDktMjkgYXQgMTY6MDYgKzAzMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAwNDo1ODo0NEFN
ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUA0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwg
MjAyMC0wOS0yNCBhdCAxNjoyOSArMDMwMCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4gPiA+ID4g
PiBJbnRyb2R1Y2UgIm1lbWZkX3NlY3JldCIgc3lzdGVtIGNhbGwgd2l0aCB0aGUgYWJpbGl0eSB0
bw0KPiA+ID4gPiA+IGNyZWF0ZQ0KPiA+ID4gPiA+IG1lbW9yeQ0KPiA+ID4gPiA+IGFyZWFzIHZp
c2libGUgb25seSBpbiB0aGUgY29udGV4dCBvZiB0aGUgb3duaW5nIHByb2Nlc3MgYW5kDQo+ID4g
PiA+ID4gbm90DQo+ID4gPiA+ID4gbWFwcGVkIG5vdA0KPiA+ID4gPiA+IG9ubHkgdG8gb3RoZXIg
cHJvY2Vzc2VzIGJ1dCBpbiB0aGUga2VybmVsIHBhZ2UgdGFibGVzIGFzDQo+ID4gPiA+ID4gd2Vs
bC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgdXNlciB3aWxsIGNyZWF0ZSBhIGZpbGUgZGVz
Y3JpcHRvciB1c2luZyB0aGUNCj4gPiA+ID4gPiBtZW1mZF9zZWNyZXQoKQ0KPiA+ID4gPiA+IHN5
c3RlbSBjYWxsDQo+ID4gPiA+ID4gd2hlcmUgZmxhZ3Mgc3VwcGxpZWQgYXMgYSBwYXJhbWV0ZXIg
dG8gdGhpcyBzeXN0ZW0gY2FsbCB3aWxsDQo+ID4gPiA+ID4gZGVmaW5lDQo+ID4gPiA+ID4gdGhl
DQo+ID4gPiA+ID4gZGVzaXJlZCBwcm90ZWN0aW9uIG1vZGUgZm9yIHRoZSBtZW1vcnkgYXNzb2Np
YXRlZCB3aXRoIHRoYXQNCj4gPiA+ID4gPiBmaWxlDQo+ID4gPiA+ID4gZGVzY3JpcHRvci4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiAgIEN1cnJlbnRseSB0aGVyZSBhcmUgdHdvIHByb3RlY3Rpb24g
bW9kZXM6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gKiBleGNsdXNpdmUgLSB0aGUgbWVtb3J5IGFy
ZWEgaXMgdW5tYXBwZWQgZnJvbSB0aGUga2VybmVsDQo+ID4gPiA+ID4gZGlyZWN0DQo+ID4gPiA+
ID4gbWFwDQo+ID4gPiA+ID4gYW5kIGl0DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgaXMgcHJl
c2VudCBvbmx5IGluIHRoZSBwYWdlIHRhYmxlcyBvZiB0aGUNCj4gPiA+ID4gPiBvd25pbmcNCj4g
PiA+ID4gPiBtbS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNlZW1zIGxpa2UgdGhlcmUgd2VyZSBzb21l
IGNvbmNlcm5zIHJhaXNlZCBhcm91bmQgZGlyZWN0IG1hcA0KPiA+ID4gPiBlZmZpY2llbmN5LCBi
dXQgaW4gY2FzZSB5b3UgYXJlIGdvaW5nIHRvIHJld29yayB0aGlzLi4uaG93IGRvZXMNCj4gPiA+
ID4gdGhpcw0KPiA+ID4gPiBtZW1vcnkgd29yayBmb3IgdGhlIGV4aXN0aW5nIGtlcm5lbCBmdW5j
dGlvbmFsaXR5IHRoYXQgZG9lcw0KPiA+ID4gPiB0aGluZ3MNCj4gPiA+ID4gbGlrZQ0KPiA+ID4g
PiB0aGlzPw0KPiA+ID4gPiANCj4gPiA+ID4gZ2V0X3VzZXJfcGFnZXMoLCAmcGFnZSk7DQo+ID4g
PiA+IHB0ciA9IGttYXAocGFnZSk7DQo+ID4gPiA+IGZvbyA9ICpwdHI7DQo+ID4gPiA+IA0KPiA+
ID4gPiBOb3Qgc3VyZSBpZiBJJ20gbWlzc2luZyBzb21ldGhpbmcsIGJ1dCBJIHRoaW5rIGFwcHMg
Y291bGQgY2F1c2UNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGtlcm5lbCB0byBhY2Nlc3MgYSBub3Qt
cHJlc2VudCBwYWdlIGFuZCBvb3BzLg0KPiA+ID4gDQo+ID4gPiBUaGUgaWRlYSBpcyB0aGF0IHRo
aXMgbWVtb3J5IHNob3VsZCBub3QgYmUgYWNjZXNzaWJsZSBieSB0aGUNCj4gPiA+IGtlcm5lbCwN
Cj4gPiA+IHNvDQo+ID4gPiB0aGUgc2VxdWVuY2UgeW91IGRlc2NyaWJlIHNob3VsZCBpbmRlZWQg
ZmFpbC4NCj4gPiA+IA0KPiA+ID4gUHJvYmFibHkgb29wcyB3b3VsZCBiZSB0byBub2lzeSBhbmQg
aW4gdGhpcyBjYXNlIHRoZSByZXBvcnQgbmVlZHMNCj4gPiA+IHRvDQo+ID4gPiBiZQ0KPiA+ID4g
bGVzcyB2ZXJib3NlLg0KPiA+IA0KPiA+IEkgd2FzIG1vcmUgY29uY2VybmVkIHRoYXQgaXQgY291
bGQgY2F1c2Uga2VybmVsIGluc3RhYmlsaXRpZXMuDQo+IA0KPiBJIHRoaW5rIGtlcm5lbCByZWNv
dmVycyBuaWNlbHkgZnJvbSBzdWNoIHNvcnQgb2YgcGFnZSBmYXVsdCwgYXQgbGVhc3QNCj4gb24N
Cj4geDg2Lg0KDQpXZSBhcmUgdGFsa2luZyBhYm91dCB0aGUga2VybmVsIHRha2luZyBhIGRpcmVj
dCBtYXAgTlAgZmF1bHQgYW5kDQpvb3BzaW5nPyBIbW0sIEkgdGhvdWdodCBpdCBzaG91bGQgb2Z0
ZW4gcmVjb3ZlciwgYnV0IHN0YWJpbGl0eSBzaG91bGQNCmJlIGNvbnNpZGVyZWQgcmVkdWNlZC4g
SG93IGNvdWxkIHRoZSBrZXJuZWwga25vdyB3aGV0aGVyIHRvIHJlbGVhc2UNCmxvY2tzIG9yIGNs
ZWFuIHVwIG90aGVyIHN0YXRlPyBQcmV0dHkgc3VyZSBJJ3ZlIHNlZW4gZGVhZGxvY2tzIGluIHRo
aXMNCmNhc2UuDQoNCj4gPiBJIHNlZSwgc28gaXQgc2hvdWxkIG5vdCBiZSBhY2Nlc3NlZCBldmVu
IGF0IHRoZSB1c2Vyc3BhY2UgYWRkcmVzcz8NCj4gPiBJDQo+ID4gd29uZGVyIGlmIGl0IHNob3Vs
ZCBiZSBwcmV2ZW50ZWQgc29tZWhvdyB0aGVuLiBBdCBsZWFzdA0KPiA+IGdldF91c2VyX3BhZ2Vz
KCkgc2hvdWxkIGJlIHByZXZlbnRlZCBJIHRoaW5rLiBCbG9ja2luZw0KPiA+IGNvcHlfKl91c2Vy
KCkNCj4gPiBhY2Nlc3MgbWlnaHQgbm90IGJlIHNpbXBsZS4NCj4gPiANCj4gPiBJJ20gYWxzbyBu
b3Qgc28gc3VyZSB0aGF0IGEgdXNlciB3b3VsZCBuZXZlciBoYXZlIGFueSBwb3NzaWJsZQ0KPiA+
IHJlYXNvbg0KPiA+IHRvIGNvcHkgZGF0YSBmcm9tIHRoaXMgbWVtb3J5IGludG8gdGhlIGtlcm5l
bCwgZXZlbiBpZiBpdCdzIGp1c3QNCj4gPiBjb252ZW5pZW5jZS4gSW4gd2hpY2ggY2FzZSBhIHVz
ZXIgc2V0dXAgY291bGQgYnJlYWsgaWYgYSBzcGVjaWZpYw0KPiA+IGtlcm5lbCBpbXBsZW1lbnRh
dGlvbiBzd2l0Y2hlZCB0byBnZXRfdXNlcl9wYWdlcygpL2ttYXAoKSBmcm9tDQo+ID4gdXNpbmcN
Cj4gPiBjb3B5XypfdXNlcigpLiBTbyBzZWVtcyBtYXliZSBhIGJpdCB0aG9ybnkgd2l0aG91dCBm
dWxseSBibG9ja2luZw0KPiA+IGFjY2VzcyBmcm9tIHRoZSBrZXJuZWwsIG9yIGRlcHJlY2F0aW5n
IHRoYXQgcGF0dGVybi4NCj4gPiANCj4gPiBZb3Ugc2hvdWxkIHByb2JhYmx5IGNhbGwgb3V0IHRo
ZXNlICJubyBwYXNzaW5nIGRhdGEgdG8vZnJvbSB0aGUNCj4gPiBrZXJuZWwiDQo+ID4gZXhwZWN0
YXRpb25zLCB1bmxlc3MgSSBtaXNzZWQgdGhlbSBzb21ld2hlcmUuDQo+IA0KPiBZb3UgYXJlIHJp
Z2h0LCBJIHNob3VsZCBoYXZlIGJlZW4gbW9yZSBleHBsaWNpdCBpbiB0aGUgZGVzY3JpcHRpb24g
b2YNCj4gdGhlIGV4cGVjdGVkIGJlaGF2b2lyLiANCj4gDQo+IE91ciB0aGlua2luZyB3YXMgdGhh
dCBjb3B5Xyp1c2VyKCkgd291bGQgd29yayBpbiB0aGUgY29udGV4dCBvZiB0aGUNCj4gcHJvY2Vz
cyB0aGF0ICJvd25zIiB0aGUgc2VjcmV0bWVtIGFuZCBndXAoKSB3b3VsZCBub3QgYWxsb3cgYWNj
ZXNzIGluDQo+IGdlbmVyYWwsIHVubGVzcyByZXF1ZXN0ZWQgd2l0aCBjZXJ0YWlsICh5ZXQgYW5v
dGhlcikgRk9MTF8gZmxhZy4NCg0KSG1tLCB5ZXMuIEkgdGhpbmsgb25lIGVhc2llciB0aGluZyBh
Ym91dCB0aGlzIGRlc2lnbiBvdmVyIHRoZSBzZXJpZXMNCktpcmlsbCBzZW50IG91dCBpcyB0aGF0
IHRoZSBhY3R1YWwgcGFnZSB3aWxsIG5ldmVyIHRyYW5zaXRpb24gdG8gYW5kDQpmcm9tIHVubWFw
cGVkIHdoaWxlIGl0J3MgbWFwcGVkIGluIHVzZXJzcGFjZS4gSWYgaXQgY291bGQgdHJhbnNpdGlv
biwNCnlvdSdkIGhhdmUgdG8gd29ycnkgYWJvdXQgYSByYWNlIHdpbmRvdyBiZXR3ZWVuDQpnZXRf
dXNlcl9wYWdlcyhGT0xMX2ZvbykgYW5kIHRoZSBrbWFwKCkgd2hlcmUgdGhlIHBhZ2UgbWlnaHQg
Z2V0DQp1bm1hcHBlZC4NCg0KV2l0aG91dCB0aGUgYWJpbGl0eSB0byB0cmFuc2l0aW9uIHBhZ2Vz
IHRob3VnaCwgdXNpbmcgdGhpcyBmb3IgS1ZNDQpndWVzdHMgbWVtb3J5IHJlbWFpbnMgYSBub3Qg
Y29tcGxldGVseSB3b3JrZWQgdGhyb3VnaCBwcm9ibGVtIHNpbmNlIGl0DQpoYXMgdGhlIGdldF91
c2VyX3BhZ2VzKCkva21hcCgpIHBhdHRlcm4gcXVpdGUgYSBiaXQuIERpZCB5b3UgaGF2ZSBhbg0K
aWRlYSBmb3IgdGhhdD8gKEkgdGhvdWdodCBJIHNhdyB0aGF0IHVzZSBjYXNlIG1lbnRpb25lZCBz
b21ld2hlcmUpLg0KDQo=
