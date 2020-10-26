Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EDF299662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791405AbgJZTBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 15:01:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:9745 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791398AbgJZTBp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:01:45 -0400
IronPort-SDR: hB2l5DFUloTy35gTvAvmmZixagS/Vhy4FlH7dwzVhH4nGy7ohZqQsUfJ0EuqQTFCCUsi53YxUU
 YgRQ+U/WDhSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232161772"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="232161772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 12:01:43 -0700
IronPort-SDR: /LvAuZbLvD6Jvn9XarAI6t4jv68vg40z1gd1G6s27lG0HpIFmmXo6VIa/tcJuJPCuhhv7Cehoo
 yfD8/a9H8UOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="350225103"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2020 12:01:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Oct 2020 12:01:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Oct 2020 12:01:42 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 26 Oct 2020 12:01:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuzxFyrqQ3jZEIUkcXjWBLXOn2GZxsTx/5H2yyUdRFU/FToBvNKnY6DzxvcKPPz+A1uIMUprJPely4hxqJ/ZTONP0zG4NkrC++hzH20lQ8As6b8oiovqtUz8yNoNkOcCozfXkrXnWc7dbPxWDoOk+fmkChVhKvUJS0Mw1hxIYdqgHrSKb6fzS3OcW8xRBAAsxnKcoCVj062wkcKyvawQeNPWB2RRVNdFXtqIdX38LkyHtK4ppwuXyz8Z7uozcBBujVrqRt936Tx6c5TtDVyBMDuSOncWIRpKNKkoc5fNYh1Kr1kQXIp4Jc3crztKgtWVEdZpt93IUZgYSO0xu/y0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NF4yvjjQB60CAJBcKIBIEO1nVtwTjUfRE/w5vohYrI=;
 b=jMUDMOWys4S2AhJH8GEll7NvGz8zrgcGGWbi3ZCeCY+3BV9ySkDOxdTw2oHgdBJF4EEzwhlb+qhu+p3vYSgoO7GUtO18z2swSJLKT+i9fWcZsEMC3MMzJN6ZCTyYuU/YFAjjE/+R+bxa8RkngZJZOU8HXIWAfIY3nRh7vVD2YFWC2WSwX1x8H1WD51UvqsEGpqPMnw/6zaOk3S86XVwmJ7+hkVyWVcnafXkAcZI704YGN3PnpghzzDx0BUUOSgUXqH+1O1PQY5s5Foxt9zTyDBPwhav2sqnudKL+u91l1KMdAQIBXZG4WIjUI1stJ4DYzrMSqImuGMkzsd/cmrZbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NF4yvjjQB60CAJBcKIBIEO1nVtwTjUfRE/w5vohYrI=;
 b=a/vPDPRDw6TAI0lz1+iQ0esBQZ57gZlojlfS01XNHQfGuqTpUx3l6aCrJE5VVaWAOo+/tmLnb2tIQ/73GVsVkenyde5M48EqsP3AJNk2EujjRDsHb/AOy/wnUzx9uVhetsf2wDV9ajtkW+0bbuD/C7XRPXRJfRwEyxNHFa0Ow8E=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB2670.namprd11.prod.outlook.com (2603:10b6:805:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 26 Oct
 2020 19:01:36 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 19:01:35 +0000
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
Subject: Re: [PATCH v7 3/7] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Thread-Topic: [PATCH v7 3/7] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Thread-Index: AQHWq3OMPAgNCAY0I0aqf226x9KmgKmqPfEA
Date:   Mon, 26 Oct 2020 19:01:35 +0000
Message-ID: <e754ae3873e02e398e58091d586fe57e105803db.camel@intel.com>
References: <20201026083752.13267-1-rppt@kernel.org>
         <20201026083752.13267-4-rppt@kernel.org>
In-Reply-To: <20201026083752.13267-4-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 831d0aab-984e-43ca-be4f-08d879e18fb6
x-ms-traffictypediagnostic: SN6PR11MB2670:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2670C2AD587A0AACDA0CF33FC9190@SN6PR11MB2670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKYgs+I9xgTiUbv3g7/pOUCPlxP8y79v/91bAdNHzvQUCnYjszS7bQud6ytGBh/w3IUbo6qd54D8tHJS2Ix/gNIUhlnTBo/eBivyUYPOjLzbc9EaSL+kS3f6xk+9o8UlYEZEwYZsY71IXsMl6jba0hChhJebhReDe/6SnTSdhzOpzoFT2ynD5YOoo9Hv6P8oYxbBm5kYfRNC4Iprzv1HTwIzmSSwwKTdqT1B6FflZzSzwLFLCrX+ZLi9g03zKUeI1iWRP1Gg3+QxHXGoEPrX4vlq8F9WGroaklI7WFG3dfK+4Jf/MI4tmKV7161uhR8ZOUF+AjC9D3eCKv79tIpUFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(71200400001)(76116006)(478600001)(91956017)(2906002)(4326008)(4744005)(110136005)(66476007)(64756008)(5660300002)(54906003)(66446008)(66556008)(316002)(66946007)(8676002)(6512007)(7406005)(6506007)(86362001)(4001150100001)(6486002)(26005)(36756003)(186003)(7416002)(8936002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: leddIN0yhCwx9tLT5sYtS3UgyYJuD7WN9DKkliWAgkoEmVlV3tuZsPdMFAtS1nljzuk/TAD0JOqeWjwmorvc+AWraLTrqKvm8j69SQ1QpdyRnl9PSnTqdpDitQ+dvexG1zHnWPlv5nB29XzlxOuQnCfLHJtVuwxaGS+x6iRYij4/RqFj8e11OWjrlPr7C+3azU/OFQAOTtb61CrYr2Rsq/PvYUiQDMzEXCW5w1EVvrV//pKCwOGOZ9UnaFb1jEDOXkx4PTnJaS+nr9ZBa3VRK0fnhBt2NRcLZ0dywY6MPuxHH5il0FC2jozPi4dAND25Wock+ARXuGodHwf6CTWkJ+1/saFiPUc6nvzulG1QDR/6ktmfj19ipvYCZpc1db+AmzOMSsTkf2+ZGTQdsYYgMCNdxQQtSeBACLTsAmOyGTaqFXarFFnL7GKRezCVsDLg1MP2TeVx8T/hPFEDWCHmi0HJUHi0kMt9H5QhZOT1zCOfW0KB4Cig4OOS/NuetkNSfgcLO4Np6WFgqUU8wSKjqISFyFsaS9ugj1jxiyk3V0+zTkOLNQ+5NgCIVTlBOpQ7oPR1dtnxQKmOcaQd1gH8yqD6ql8ThgGYmvuVXSVncQuNz3CM9aOWQKVrUIp4EBhgtmxAximFQh+zNGZEeEjHew==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9967912813C94AB3CCC9D15F421100@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831d0aab-984e-43ca-be4f-08d879e18fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 19:01:35.7336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFvFgsbvKk5OlWUhRYxyvk8h4UP51JQ11V7igFujnoGjPLjKuXbz46Goc36uMgxgWvORz+8dOFaOcMS7xeYMxXwwimc4KDLOSgZgFDlImew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIwLTEwLTI2IGF0IDEwOjM3ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiArKysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jDQo+IEBAIC0yMTg0LDE0ICsyMTg0
LDE0IEBAIHN0YXRpYyBpbnQgX19zZXRfcGFnZXNfbnAoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+IGlu
dCBudW1wYWdlcykNCj4gICAgICAgICByZXR1cm4gX19jaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIo
JmNwYSwgMCk7DQo+ICB9DQo+ICANCj4gLWludCBzZXRfZGlyZWN0X21hcF9pbnZhbGlkX25vZmx1
c2goc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICtpbnQgc2V0X2RpcmVjdF9tYXBfaW52YWxpZF9ub2Zs
dXNoKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgbnVtcGFnZXMpDQo+ICB7DQo+IC0gICAgICAgcmV0
dXJuIF9fc2V0X3BhZ2VzX25wKHBhZ2UsIDEpOw0KPiArICAgICAgIHJldHVybiBfX3NldF9wYWdl
c19ucChwYWdlLCBudW1wYWdlcyk7DQo+ICB9DQo+ICANCj4gLWludCBzZXRfZGlyZWN0X21hcF9k
ZWZhdWx0X25vZmx1c2goc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICtpbnQgc2V0X2RpcmVjdF9tYXBf
ZGVmYXVsdF9ub2ZsdXNoKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgbnVtcGFnZXMpDQo+ICB7DQo+
IC0gICAgICAgcmV0dXJuIF9fc2V0X3BhZ2VzX3AocGFnZSwgMSk7DQo+ICsgICAgICAgcmV0dXJu
IF9fc2V0X3BhZ2VzX3AocGFnZSwgbnVtcGFnZXMpOw0KPiAgfQ0KDQpTb21ld2hhdCByZWxhdGVk
IHRvIHlvdXIgb3RoZXIgc2VyaWVzLCB0aGlzIGNvdWxkIHJlc3VsdCBpbiBsYXJnZSBOUA0KcGFn
ZXMgYW5kIHRyaXAgdXAgaGliZXJuYXRlLg0K
