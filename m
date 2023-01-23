Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2E678BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjAWXDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 18:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjAWXDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:03:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D8D2200F;
        Mon, 23 Jan 2023 15:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674514994; x=1706050994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xP/xrMfRyWQ2j2mzFtbVlXsuqlh/G3CHjRu4binF2Pg=;
  b=eHMKY7jkkxd4a80rF8fl4D3bu6pdHLDuWKE0kbKp541mN7kSn28Xta0L
   /wR/C1YeE4ZdRLm4wg2kZUnGEPkGXyBGZVjWTWRiP/iKvKv4A4TnhJFmk
   eejFxNEuNSMww3TRq+qMKgwjeuW6JdXtW3uy4h2vwxmCkodmD8aVTPLop
   OZXpGfVMjyKx+T5qUo8XLjGG/UzNRN2NOb5+7nLBv3vNZqa8/dLtt2C6B
   Qi1gIldHwj8v8+jFZChhZCljd4W7VsYVWXjVvZQTVfUR1uNKMKO8xpinT
   NEYe45CiASA+J1iA+XS5m4BwrtQrwHXtwWyFX36o3qffD12ViC9JeZhYd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="306534208"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="306534208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="990647659"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="990647659"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jan 2023 15:01:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 15:01:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 15:01:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 15:01:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ4K8bqfcvdroO0LYxzhUKQjKcuIHhlnV+Z2dJe695qHihoQP9WPPDsHT17vP2mLfprDfvM9k0WAfLCcMOZG7VZe0tqfZGhowadqTfQQ+IzOTiZN3wUQOlSvZAql3i+3erlkKuRYgSY+z0VJXZVa4mTZEy1bzb/XPNRrGJ/nn2oDqZOhI53Gcce31QMzsgoK+2uoFeATbBjkkQOIVIPS+q+nNEiFMnhnPIYtyU/DMN5LsfKKSFSa4pE+QKmeiLPSnf/Eg56aL9GScbAAIh2vaz+BOkaTPjLgeSxFM68Npf+KRp5woXtQNcHZvMY3uXQVpPWGIJ+1p+e2DMxd38RKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP/xrMfRyWQ2j2mzFtbVlXsuqlh/G3CHjRu4binF2Pg=;
 b=HhqXs9nSqNY8mPlbi+dYchscj+3kyST0Pbk1uM0ku4RiikqteZ8G0YmvfL61Safx+G0Sjyrms1tlAv5frW3Elp8NxeUX7XL9qpZluwfBQ5iwJ0b6SdY3qX0ioPyAggqnxvtpFAqoiLy3KvZUgJEWbujSLaO9EI4YeeyS07hFh2xWMVsK9KP2SoHM0yfURMp3+q0SLvzVDchwnbszzZBaQfwUm40zVKP7BWX5kU6GztvT/v0ckBWcxfrom8YbEJCb+kGKMEREibTc39raMZs92PdMEwkqRaBLvUBjXZdNDjqm3C05h82UM1QTWf/U5JOSeyqWy/mzGcio6ZxKF5vIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:01:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a%8]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:01:18 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "tabba@google.com" <tabba@google.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Annapurve, Vishal" <vannapurve@google.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Topic: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Index: AQHZBhXuq53UEB1w4kqtU0OzCkPOIq5sjtQAgAhi5ICAAA9XAIABemYAgAATugCAAefUgIAAt+UAgDMr74CAAJYsAA==
Date:   Mon, 23 Jan 2023 23:01:17 +0000
Message-ID: <0959c72ec635688f4b6c1b516815f79f52543b31.camel@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
         <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
         <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
         <20221219075313.GB1691829@chaop.bj.intel.com>
         <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
         <20221220072228.GA1724933@chaop.bj.intel.com>
         <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
         <20221221133905.GA1766136@chaop.bj.intel.com>
         <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
         <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
In-Reply-To: <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6447:EE_
x-ms-office365-filtering-correlation-id: a18e27ac-4d82-4bc1-38a9-08dafd95bc66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxTYODu4nwk4j0tTgnmjA7bHbSoFNY3fE6L894EggV1SyuotAKF/Gcsk4oDPO1JLOI0uRgJq7iJzyDDlzFylJ76IggZ96XMl/4BP+Wg9wjyVFeBg72wu/R+IoakB93kHn40mp2U/T4t/4BJhCVJAMoTNeFtaJwB22KTMw5ywOpd24r8FikhuyR/iKEXRAk9xebRJ+NoD9WD5OHpGu6UjDU4oXO5TM4kvOYJ7nre+vjPusCDMAEOoej2gIeapyc2AyABRB6m1bpnOtImCDE+4gIZLys2m51kknZnN+3NVdrzDc8JaUFdQRgyciP5W9VP0j37QIV2ReNVsncifwmnOBymsULC3hzq8Mu3kAEELQHqXqMiRsiPVvhvyPSsr8ODDctlnrVH5bVns8icAAYUzwDQLgHmKbw+3pMVfGOmtzd0BbxGdQvgcGHcMNzOPxRm1CXUH9s1PiYjUTuETEubp+oghURbUXexQTZ8hY8VbcZhlIiWmtseSPQYrdgzG0ILrs9K5O09orWsN77r+pD61r1OjUcPdj48UUyPSNDY+APJ3vtmgzundkr6vuFPozUVcSp0g2avm7BRTPiuE5+EJmRwVXnhYs08B+hhAH+7YY5KSoMKogbK8UTT806ba5l1uhYwI5oBf0LKfw6B7yeXJ0fAHOgffXRj5u+gh5cbBao3aN5mHmC0tSG+X67K/BoY05YOnWRl7dedOfLs0LCR1oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(122000001)(38100700002)(82960400001)(36756003)(38070700005)(86362001)(8676002)(76116006)(4326008)(66946007)(2616005)(54906003)(110136005)(26005)(316002)(6512007)(478600001)(53546011)(6506007)(71200400001)(186003)(6486002)(91956017)(7406005)(7416002)(8936002)(5660300002)(2906002)(66899015)(66446008)(66556008)(66476007)(64756008)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm1nQmVWN1RFalo0SUhkdTZ5MXhOK3VQWitXRis2Zm5ISzlKZStjZXdFTzc1?=
 =?utf-8?B?QTBuanNRVUc3ekIzQ2t6STc2R1lQYXphWGZvQWVNRFhlTVYvOWZESTRCLzIx?=
 =?utf-8?B?Uk1vSWNYYW96MVc4KzY5SWs0M2daWlh5UWk4YWJsWHN4L2dRZGg3TG80bzlX?=
 =?utf-8?B?ODM1R1U1S1BXYzRyQk9rME5NS0ZFZ2NQdGFYTjZuVzlEVTNqSWlNaWtzWXVq?=
 =?utf-8?B?TFl5dUVjSTd3NVZDWWVSYmZQWmo1T0hST0I3eWRLOFU1cmtGSnlDQVpxNGlU?=
 =?utf-8?B?MVZNaWU5aUJLRlIySVYvWDJXY1UzRTNrRVdTdTh4a2JDUm93RHBIZkdHVjhK?=
 =?utf-8?B?czJ6MmRsaEY4REdYTGVnRkFXeWJnWVlBb000NlJOZHRtRVpoUld3K0VZMk13?=
 =?utf-8?B?UndKQWMzOWp6VzRDSS9DOUNRNVpKUTNGVXc4NzlvV1htbWdBVU9aUGIrLzlG?=
 =?utf-8?B?YUl3M3Vjb1JVcUh2N1JDYzVHdStwTDRRVGt4Q2JmaUJFVjFydDFRU2plUmhq?=
 =?utf-8?B?ZVNBelVnNlFIRHF0cG5GY2hZdXlGcTAzUnpod01SeThUVFNKUHpqaTRESzhz?=
 =?utf-8?B?cUd0dkFGSTdlU3JMY0RSNTFXYUVYMkNkUU5ydml0WGEwL3RkaDlVdjNIYzRU?=
 =?utf-8?B?eW1DVkd1Rm1MVXhyU243bmFJVzdlQ3k2UGMrUlllWmFyTWs3WmttZmRpTHU2?=
 =?utf-8?B?QTZvTEdybWVkcUZ3ZlZSbnd4UUVyTmZlUDU0c2gzM2hHU1FtR1lCRGtvU0Fj?=
 =?utf-8?B?a0VEbUwzN2pqQmVRa0h4SlVBYlVqVjBEbmZzR1Zqb3U1WWpaRWorNTVvdTlw?=
 =?utf-8?B?ZnNaR1lZWUdaVlU4dFVFTUxrQStNbW5WMnJUM1dCU2RSNTF1NlBFcStXLzFj?=
 =?utf-8?B?NU9NUzZteFNsampRc3kzZ3hqQy9MZHZ2RzNpc3NYdThWdXNZVVVxM29nMVJX?=
 =?utf-8?B?OEUwRmFTbXJmNzgzRGRRWXBvZVFhcUVqZ0JvbUY2TlN4MUFoZ25RQzBnYm56?=
 =?utf-8?B?UmdTU0ZmZDRYN0JkOHBIMkw0SEx3UE9waFFuc3RUVlVCWlpJbHgzK0FBN1pM?=
 =?utf-8?B?RWtLWUFtMmUxU2pkMW56ZWtad2NRZmhndkFic21jaGFJS3FlcytISCs3MjZL?=
 =?utf-8?B?b2t1QUFCRitucVVhMmFZWVpremRSSFVvdXdYZFg3cExyVlJVcDZVeHl1d2pI?=
 =?utf-8?B?NlY4UXI5NFdJd0dMMXk4MVpCa0I3b3JLb01QOXJ4MTM2dDlTOWVxMHZnSUFR?=
 =?utf-8?B?THFrbmF5dHNDQjBHdVNKWDRWTHhFSU8xUWVValFWYUhzb2JpNFgxODRacWNO?=
 =?utf-8?B?SzJSa2hSTDJ5Q2QzR1RoZFQyYUxwc1pXNVZFbXZOcHhmeVJZQk5IS3Bob1Vv?=
 =?utf-8?B?WmFiQ1YyMmN5MlBwVWhxVGlpNDhVS01Sa1A4Z2NGSGZ0REliSGN6RGFocFhO?=
 =?utf-8?B?Y3k5WFRoam90bnN4RkdwcWVLVXVSM1crL3QxeGZqNjBvTjBWWVNpbTF3Zkht?=
 =?utf-8?B?WjE3U3BrQk1zNWhwSmlENjFOclloOVJEWi9IajVDczBPeGVtaitPY0habjJm?=
 =?utf-8?B?WG9DMFhuUnJVQXAwdUUxVkNCT1I0MEtHWHFzZWdEOXdERlk5VWIwWkxBNnpL?=
 =?utf-8?B?ZnBFWkVPMkxTTXFLSm1HbC90ck9DUTQ3MUtpWDRoK0ZvN3hiMloydmYvQUJS?=
 =?utf-8?B?WW81OWNmU05ZMnV3RmF4cHdXY0hBNWplTThZdkxIUS9xR0NxNFU3enI1M21K?=
 =?utf-8?B?bklDY0l6L1ZjODA3WHI1VGhOQ2ZyVkg3QzBKbHFpSFM4OXViQm13K09UODBu?=
 =?utf-8?B?d2FIN29UNXhqR25yeGs3Qk5NRmhvOFBIeERMR0t6USs5NVhYVG8xendPSHhU?=
 =?utf-8?B?T0tIUzIxNHlHSGlOb3VVbkxPalp3V2ZLanFheHZWTzlCbnhteUJySzF0UXcx?=
 =?utf-8?B?M2RWVEdjQzliakFuN1EyU0t4L2JjajZFZVJGVU8veVRwOU5XdTR5NVR2NXZS?=
 =?utf-8?B?L1c3R0pTdldZc2pmckszTjc0Ni9BaFhLVWZjZ01hcGhvSVBRRFVyYm05WHB1?=
 =?utf-8?B?R25OVXMrdnBuSVF4TWsrbXZPdTcwZG05OG5PUnpZKzBHVHErbnVsWWN6Zjk0?=
 =?utf-8?B?WWNKdzJ0ZmZOLy9yODZkQ203cWt3MHdpYWdOd3A4clkvUlJTY0dySVh3T0g1?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B85396C7BF4DD46BFC6728D6FA12D21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18e27ac-4d82-4bc1-38a9-08dafd95bc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 23:01:17.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUb3gyFMZYWu/6CKFevqe4ahNkNTkcreGb82cpN8KO1jGpmJe9xuTve3r3ppzr7JnB33xasqro5/c0t+WuCjqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDE1OjAzICswMTAwLCBWbGFzdGltaWwgQmFia2Egd3JvdGU6
DQo+IE9uIDEyLzIyLzIyIDAxOjM3LCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gPiBJIGFyZ3Vl
IHRoYXQgdGhpcyBwYWdlIHBpbm5pbmcgKG9yIHBhZ2UgbWlncmF0aW9uIHByZXZlbnRpb24pIGlz
IG5vdA0KPiA+ID4gPiB0aWVkIHRvIHdoZXJlIHRoZSBwYWdlIGNvbWVzIGZyb20sIGluc3RlYWQg
cmVsYXRlZCB0byBob3cgdGhlIHBhZ2Ugd2lsbA0KPiA+ID4gPiBiZSB1c2VkLiBXaGV0aGVyIHRo
ZSBwYWdlIGlzIHJlc3RyaWN0ZWRtZW0gYmFja2VkIG9yIEdVUCgpIGJhY2tlZCwgb25jZQ0KPiA+
ID4gPiBpdCdzIHVzZWQgYnkgY3VycmVudCB2ZXJzaW9uIG9mIFREWCB0aGVuIHRoZSBwYWdlIHBp
bm5pbmcgaXMgbmVlZGVkLiBTbw0KPiA+ID4gPiBzdWNoIHBhZ2UgbWlncmF0aW9uIHByZXZlbnRp
b24gaXMgcmVhbGx5IFREWCB0aGluZywgZXZlbiBub3QgS1ZNIGdlbmVyaWMNCj4gPiA+ID4gdGhp
bmcgKHRoYXQncyB3aHkgSSB0aGluayB3ZSBkb24ndCBuZWVkIGNoYW5nZSB0aGUgZXhpc3Rpbmcg
bG9naWMgb2YNCj4gPiA+ID4ga3ZtX3JlbGVhc2VfcGZuX2NsZWFuKCkpLsKgDQo+ID4gPiA+IA0K
PiA+IFRoaXMgZXNzZW50aWFsbHkgYm9pbHMgZG93biB0byB3aG8gIm93bnMiIHBhZ2UgbWlncmF0
aW9uIGhhbmRsaW5nLCBhbmQgc2FkbHksDQo+ID4gcGFnZSBtaWdyYXRpb24gaXMga2luZGEgIm93
bmVkIiBieSB0aGUgY29yZS1rZXJuZWwsIGkuZS4gS1ZNIGNhbm5vdCBoYW5kbGUgcGFnZQ0KPiA+
IG1pZ3JhdGlvbiBieSBpdHNlbGYgLS0gaXQncyBqdXN0IGEgcGFzc2l2ZSByZWNlaXZlci4NCj4g
PiANCj4gPiBGb3Igbm9ybWFsIHBhZ2VzLCBwYWdlIG1pZ3JhdGlvbiBpcyB0b3RhbGx5IGRvbmUg
YnkgdGhlIGNvcmUta2VybmVsIChpLmUuIGl0DQo+ID4gdW5tYXBzIHBhZ2UgZnJvbSBWTUEsIGFs
bG9jYXRlcyBhIG5ldyBwYWdlLCBhbmQgdXNlcyBtaWdyYXRlX3BhcGUoKSBvciBhX29wcy0NCj4g
PiA+IG1pZ3JhdGVfcGFnZSgpIHRvIGFjdHVhbGx5IG1pZ3JhdGUgdGhlIHBhZ2UpLg0KPiA+IElu
IHRoZSBzZW5zZSBvZiBURFgsIGNvbmNlcHR1YWxseSBpdCBzaG91bGQgYmUgZG9uZSBpbiB0aGUg
c2FtZSB3YXkuIFRoZSBtb3JlDQo+ID4gaW1wb3J0YW50IHRoaW5nIGlzOiB5ZXMgS1ZNIGNhbiB1
c2UgZ2V0X3BhZ2UoKSB0byBwcmV2ZW50IHBhZ2UgbWlncmF0aW9uLCBidXQNCj4gPiB3aGVuIEtW
TSB3YW50cyB0byBzdXBwb3J0IGl0LCBLVk0gY2Fubm90IGp1c3QgcmVtb3ZlIGdldF9wYWdlKCks
IGFzIHRoZSBjb3JlLQ0KPiA+IGtlcm5lbCB3aWxsIHN0aWxsIGp1c3QgZG8gbWlncmF0ZV9wYWdl
KCkgd2hpY2ggd29uJ3Qgd29yayBmb3IgVERYIChnaXZlbg0KPiA+IHJlc3RyaWN0ZWRfbWVtZmQg
ZG9lc24ndCBoYXZlIGFfb3BzLT5taWdyYXRlX3BhZ2UoKSBpbXBsZW1lbnRlZCkuDQo+ID4gDQo+
ID4gU28gSSB0aGluayB0aGUgcmVzdHJpY3RlZF9tZW1mZCBmaWxlc3lzdGVtIHNob3VsZCBvd24g
cGFnZSBtaWdyYXRpb24gaGFuZGxpbmcsDQo+ID4gKGkuZS4gYnkgaW1wbGVtZW50aW5nIGFfb3Bz
LT5taWdyYXRlX3BhZ2UoKSB0byBlaXRoZXIganVzdCByZWplY3QgcGFnZSBtaWdyYXRpb24NCj4g
PiBvciBzb21laG93IHN1cHBvcnQgaXQpLg0KPiANCj4gV2hpbGUgdGhpcyB0aHJlYWQgc2VlbXMg
dG8gYmUgc2V0dGxlZCBvbiByZWZjb3VudHMgYWxyZWFkeSzCoA0KPiANCg0KSSBhbSBub3Qgc3Vy
ZSBidXQgd2lsbCBsZXQgU2Vhbi9QYW9sbyB0byBkZWNpZGUuDQoNCj4ganVzdCB3YW50ZWQNCj4g
dG8gcG9pbnQgb3V0IHRoYXQgaXQgd291bGRuJ3QgYmUgaWRlYWwgdG8gcHJldmVudCBtaWdyYXRp
b25zIGJ5DQo+IGFfb3BzLT5taWdyYXRlX3BhZ2UoKSByZWplY3RpbmcgdGhlbS4gSXQgd291bGQg
bWVhbiBjcHV0aW1lIHdhc3RlZCAoaS5lLg0KPiBieSBtZW1vcnkgY29tcGFjdGlvbikgYnkgaXNv
bGF0aW5nIHRoZSBwYWdlcyBmb3IgbWlncmF0aW9uIGFuZCB0aGVuDQo+IHJlbGVhc2luZyB0aGVt
IGFmdGVyIHRoZSBjYWxsYmFjayByZWplY3RzIGl0IChhdCBsZWFzdCB3ZSB3b3VsZG4ndCB3YXN0
ZQ0KPiB0aW1lIGNyZWF0aW5nIGFuZCB1bmRvaW5nIG1pZ3JhdGlvbiBlbnRyaWVzIGluIHRoZSB1
c2Vyc3BhY2UgcGFnZSB0YWJsZXMNCj4gYXMgdGhlcmUncyBubyBtbWFwKS4gRWxldmF0ZWQgcmVm
Y291bnQgb24gdGhlIG90aGVyIGhhbmQgaXMgZGV0ZWN0ZWQNCj4gdmVyeSBlYXJseSBpbiBjb21w
YWN0aW9uIHNvIG5vIGlzb2xhdGlvbiBpcyBhdHRlbXB0ZWQsIHNvIGZyb20gdGhhdA0KPiBhc3Bl
Y3QgaXQncyBvcHRpbWFsLg0KDQpJIGFtIHByb2JhYmx5IG1pc3Npbmcgc29tZXRoaW5nLCBidXQg
SUlVQyB0aGUgY2hlY2tpbmcgb2YgcmVmY291bnQgaGFwcGVucyBhdA0KdmVyeSBsYXN0IHN0YWdl
IG9mIHBhZ2UgbWlncmF0aW9uIHRvbywgZm9yIGluc3RhbmNlOg0KDQoJbWlncmF0ZV9mb2xpbygu
Li4pIC0+DQoJCW1pZ3JhdGVfZm9saW9fZXh0cmEoLi4uLCAwIC8qIGV4dHJhX2NvdW50ICovKSAt
Pg0KCQkJZm9saW9fbWlncmF0ZV9tYXBwaW5nKC4uLikuDQoNCkFuZCBpdCBpcyBmb2xpb19taWdy
YXRlX21hcHBpbmcoKSB3aG8gZG9lcyB0aGUgYWN0dWFsIGNvbXBhcmUgd2l0aCB0aGUgcmVmY291
bnQsDQp3aGljaCBpcyBhdCB2ZXJ5IGxhdGUgc3RhZ2UgdG9vOg0KDQppbnQgZm9saW9fbWlncmF0
ZV9tYXBwaW5nKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KICAgICAgICAgICAgICAg
IHN0cnVjdCBmb2xpbyAqbmV3Zm9saW8sIHN0cnVjdCBmb2xpbyAqZm9saW8sIGludCBleHRyYV9j
b3VudCkNCnsNCgkuLi4NCiAgICAgICAgaW50IGV4cGVjdGVkX2NvdW50ID0gZm9saW9fZXhwZWN0
ZWRfcmVmcyhtYXBwaW5nLCBmb2xpbykgKyBleHRyYV9jb3VudDsNCg0KICAgICAgICBpZiAoIW1h
cHBpbmcpIHsNCiAgICAgICAgICAgICAgICAvKiBBbm9ueW1vdXMgcGFnZSB3aXRob3V0IG1hcHBp
bmcgKi8NCiAgICAgICAgICAgICAgICBpZiAoZm9saW9fcmVmX2NvdW50KGZvbGlvKSAhPSBleHBl
Y3RlZF9jb3VudCkNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUFHQUlOOw0KDQoJ
CS4uLi4NCiAgICAgICAgICAgICAgICByZXR1cm4gTUlHUkFURVBBR0VfU1VDQ0VTUzsNCiAgICAg
ICAgfQ0KDQoJLi4uLg0KICAgICAgICBpZiAoIWZvbGlvX3JlZl9mcmVlemUoZm9saW8sIGV4cGVj
dGVkX2NvdW50KSkgew0KICAgICAgICAgICAgICAgIHhhc191bmxvY2tfaXJxKCZ4YXMpOw0KICAg
ICAgICAgICAgICAgIHJldHVybiAtRUFHQUlOOw0KICAgICAgICB9DQoJLi4uDQp9DQoNCg0K
