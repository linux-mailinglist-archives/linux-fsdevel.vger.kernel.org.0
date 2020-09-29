Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4427BC98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 07:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgI2FzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 01:55:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:61546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2FzF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:55:05 -0400
IronPort-SDR: t0pSNbRhJHaQ9yYpAppY7kdL892TmrOfdqGBm1bIkZEgdtZronCb/RhYfSe1YlX2HnmX6NWPX+
 L+gBcWUXXuNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="180270377"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="180270377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 21:58:56 -0700
IronPort-SDR: MTa3SG/D44iPy0JwazIs4vYf6q4sqQXDHzSUKL55ywUxjojUAHVckBJLYiTCfwbvERNG4JggIG
 lQ0mmaWesEtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="307614587"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2020 21:58:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 21:58:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Sep 2020 21:58:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 28 Sep 2020 21:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjk+TjRFFzrQVZP8/NQqAuTdBvNyVCNKraSHHBOXgS7Jr8314m9q6gf/1kSny7UgDvIPTwNLlhA6aJ3IaU8ZKL6cNNrIDQETGm4ln0Z3VBdqNXUAjGD2K7jckaYQ5TOREnRWPsvTZENdUSGoIJ4gakMYQxdFmWExiKneE5euY9hoFOhRivoa7Infe3Afj/GyVuvlrdEHsQ1W64U2qbPAyyoc68HailuVnp+tVyHVZhC1fFobNzEn3Ab+gP0LtfgsLw9lhHAVypqB+lJU87RuRYuIw8MPQXRxY75HCkzf82KeKHwIhEiD5gKM7bDnosxctfDeN5iXNnKS7SRRfbjgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUsklQmapfplnqf1yTcJidXuvWTsT7CgEvKfdT9uYGA=;
 b=Yo3WbhvaZyeUOlSYy6/LeB8v7qWxBpxXv1nlOx4h8+M5NxzrST0pP54laPmmf9XVDzS6zCGgusYntb6hvenQNoyCYBedXo5YkZDTNKe1hkpsUA+caIZGGuB+GEb68qneDVOiHPxkdRuInma79ixhjkE2STdUqbbnRIokk6azsjZsMhgpGJlm9HVqMQI1BdVG5V1NK5SUq7A6P5flWabkHR3S1NdMNSHxeILJsx+pHV6OuuB7pF55ml/jQPFiDxNNlFQqQ5JM2uVl11sIolXjcyNADdFY/mSTEsr353aX8qz3olUUEyv8UDBJukHZhYDOrm7mFnQpF97xodFJbPmClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUsklQmapfplnqf1yTcJidXuvWTsT7CgEvKfdT9uYGA=;
 b=jEE2yb6RnQ0rsQ9qDKcMYvr/aBP5IoS3W6zJ8EuQy4gulLXEIFXDj82054aAg54qBKUZyECehLlNfWmEZF36bHOeMMlAXfNMLXpZ/n9chorIBzMpIxsQw5+lFBoAtLRVwimT4LVTvMdKGVOxGXw4rbJTJf3lj/ow/BTQvLxJ74Y=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 04:58:44 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 04:58:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "tycho@tycho.ws" <tycho@tycho.ws>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Topic: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Index: AQHWlh00WOVRjW6Kw0OmwswTJieWmg==
Date:   Tue, 29 Sep 2020 04:58:44 +0000
Message-ID: <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
References: <20200924132904.1391-1-rppt@kernel.org>
         <20200924132904.1391-4-rppt@kernel.org>
In-Reply-To: <20200924132904.1391-4-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f70bc009-fad6-405a-8e4d-08d8643457cd
x-ms-traffictypediagnostic: SA0PR11MB4653:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4653F3AF8D931E8B3292D667C9320@SA0PR11MB4653.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ieS4qv3igJqVq2uNt8hS2k67axxhLmQpSmyH4p/UhJwfou7k9DeSxTNFgFcZlnjNXNBMA6P2MLM9paGd+6AJcLBwAI1LeqPtFqG83RPIPUiL3OB4uDE/RYQARLa+BPcvje3Kw++No46etp7OUi1bN3DJijZEBPbruuqh/eH7tquAnQogNbIRK1irozw17BH6RXIkJlIY6kql/wSavqO9h22SfkFejG9U4Qb0LcOrizbvhCL+Hw9iXN69n2E76JdQjcfNKxVeEijTRbHeK2zBCE1VDHk5B777G73nJ6I07P0V3/DQPTagPN75esUsU7FEiMyHbTUw/FeClE0pcEQ8LHSvIWMke6S8Yl2ClKSas5+v00NZ9N4cBqqj3ziG6FSjGsiGDzFOfw1xFVnH28GcZo+sbbogI4h3MRV/T8Dbc3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(7406005)(316002)(66446008)(4326008)(64756008)(186003)(5660300002)(66476007)(66556008)(6512007)(6486002)(8936002)(26005)(91956017)(76116006)(66946007)(8676002)(86362001)(36756003)(83380400001)(110136005)(7416002)(6506007)(2906002)(478600001)(71200400001)(2616005)(54906003)(219293001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RxwwA1BEh2ArsB3KR0Moev6U8/fZwfr8YodkyCbo1nSTSbC3k2hqil6A7vXde1YZGqgwqG0OnuBn/XSfKLUeFRbHFXziVwc/57IA4IE2iFNh/1U+YRGE6ZWFWJ0o9lJIE9FCJ58Vh0h6Tg4Mh0VWth/UrvqgkjcsYBY2hI7PIeu/sMOvsQqJkmOAvNno4QeIYZUPyfq6mtaddTP0wjeEG51ws5/L0YuTmTizeH+LBrmy6GnxdMo/uFjp7jlYn2uVo9JI6mFgxSGbKC+tPl1jMB15kE8pbOcjIpcA0/0SBeUZsfEukKryQv8VvPm61qrHj29la/xPD7RWjeSlywFBy820BJBsz+tQ3JjgbesYr3WnpCFMLjmIQMTYBFVbvARNut0SmOE7iDjp3m9VJ42uD4gIa2Rl4malMnc76DZhXDzhvbXQgN+5IeIfAMDJKgc7vBlnI8TVXeADuRQZ7vt2ZJDJVnBq0tQt7mytDphUgP+zBu79/3SV4raAm6IMyxM+iaZaYafqhv0Qmg7ZY6Fr7ERxwLvhr2nK9cznuw2x7Su/JMGvuNcpPDvef237krn4qOQORCXM3V31YueNAw0UpZIDEXFIz9ezmDrdPA9yGjPqjiMnga2pbWmA6dgiNGJBt7KUxWQ0q3XYF19KSJxZ4Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FEAF26BDE791E4CAE434527DF482AD0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70bc009-fad6-405a-8e4d-08d8643457cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 04:58:44.4152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etO50W/t3kxQxurmTtPYdwh2lIDsJCMEOsAsZgbyH0b+f4mv2fltU/sZqL5BUysy+feywqIiVmJEnSrFbZ2N2W7WcYwG47lolWQLnvPYgCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTI0IGF0IDE2OjI5ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBJbnRyb2R1Y2UgIm1lbWZkX3NlY3JldCIgc3lzdGVtIGNhbGwgd2l0aCB0aGUgYWJpbGl0eSB0
byBjcmVhdGUNCj4gbWVtb3J5DQo+IGFyZWFzIHZpc2libGUgb25seSBpbiB0aGUgY29udGV4dCBv
ZiB0aGUgb3duaW5nIHByb2Nlc3MgYW5kIG5vdA0KPiBtYXBwZWQgbm90DQo+IG9ubHkgdG8gb3Ro
ZXIgcHJvY2Vzc2VzIGJ1dCBpbiB0aGUga2VybmVsIHBhZ2UgdGFibGVzIGFzIHdlbGwuDQo+IA0K
PiBUaGUgdXNlciB3aWxsIGNyZWF0ZSBhIGZpbGUgZGVzY3JpcHRvciB1c2luZyB0aGUgbWVtZmRf
c2VjcmV0KCkNCj4gc3lzdGVtIGNhbGwNCj4gd2hlcmUgZmxhZ3Mgc3VwcGxpZWQgYXMgYSBwYXJh
bWV0ZXIgdG8gdGhpcyBzeXN0ZW0gY2FsbCB3aWxsIGRlZmluZQ0KPiB0aGUNCj4gZGVzaXJlZCBw
cm90ZWN0aW9uIG1vZGUgZm9yIHRoZSBtZW1vcnkgYXNzb2NpYXRlZCB3aXRoIHRoYXQgZmlsZQ0K
PiBkZXNjcmlwdG9yLg0KPiANCj4gIEN1cnJlbnRseSB0aGVyZSBhcmUgdHdvIHByb3RlY3Rpb24g
bW9kZXM6DQo+IA0KPiAqIGV4Y2x1c2l2ZSAtIHRoZSBtZW1vcnkgYXJlYSBpcyB1bm1hcHBlZCBm
cm9tIHRoZSBrZXJuZWwgZGlyZWN0IG1hcA0KPiBhbmQgaXQNCj4gICAgICAgICAgICAgICBpcyBw
cmVzZW50IG9ubHkgaW4gdGhlIHBhZ2UgdGFibGVzIG9mIHRoZSBvd25pbmcgbW0uDQoNClNlZW1z
IGxpa2UgdGhlcmUgd2VyZSBzb21lIGNvbmNlcm5zIHJhaXNlZCBhcm91bmQgZGlyZWN0IG1hcA0K
ZWZmaWNpZW5jeSwgYnV0IGluIGNhc2UgeW91IGFyZSBnb2luZyB0byByZXdvcmsgdGhpcy4uLmhv
dyBkb2VzIHRoaXMNCm1lbW9yeSB3b3JrIGZvciB0aGUgZXhpc3Rpbmcga2VybmVsIGZ1bmN0aW9u
YWxpdHkgdGhhdCBkb2VzIHRoaW5ncyBsaWtlDQp0aGlzPw0KDQpnZXRfdXNlcl9wYWdlcygsICZw
YWdlKTsNCnB0ciA9IGttYXAocGFnZSk7DQpmb28gPSAqcHRyOw0KDQpOb3Qgc3VyZSBpZiBJJ20g
bWlzc2luZyBzb21ldGhpbmcsIGJ1dCBJIHRoaW5rIGFwcHMgY291bGQgY2F1c2UgdGhlDQprZXJu
ZWwgdG8gYWNjZXNzIGEgbm90LXByZXNlbnQgcGFnZSBhbmQgb29wcy4NCg==
