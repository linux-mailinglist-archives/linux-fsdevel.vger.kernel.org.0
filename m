Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1365B9B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 04:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjACDdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 22:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjACDdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:33:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB682C749;
        Mon,  2 Jan 2023 19:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672716800; x=1704252800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LatRCUBthXhJ+o+53LiWlHn6mK7KBbJO6MDf7+3N06c=;
  b=UIiVgEROWdusQvqBVkF5kbuQEWi/RJB0rl4qLy8+FL4JENMyUaTrCxUN
   oZbLHX0BrU62qqOmooufPAaNE2v39aTZ6lCwZoJllH1s05GlPwOgI71n7
   mufbuywtBZfl12hKwQMvipMk6X2nPu1aua6oznljMeCxYgBE3qKeHrDqJ
   k5kLyITehxd4N3TloCBQSFuMwgvcjZOfCy/y8D0dwLzLyn2gPJwii0Z5k
   zOz7fivTbMkgEzkoX7xxmonNvS42xWQnZyy6dJ8XcSFEcdsMjTzHb93qK
   s9oNz08IWq4wd3BmLL3LydmJwpYPsQEKpCDuZLn2kcNc7osAFqt7eatWs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="348796281"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="348796281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 19:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="828721606"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="828721606"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 02 Jan 2023 19:33:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 19:33:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 19:33:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 19:33:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdwrJpqXuM6rbJ8mitVGy2jz8J5n2BTDpHh1nUFB7kAqi2p93D12NLG4TzDky8txew+IziroGlc2A4LCAwasGGxU/DAhOMrTUfdLljm3TnRWa9/sFf2TIfchN3FVLwqUmXj9TKcBQXSOJJT/b69lZ2gUuiw5ivX0CEvxWomCQQwANiQt6FKLgAUsFayj8dcB27tHlNlDy7O3DFQWDBpkRjK3tThBvCmkhqVxLuCAQmqEfbyR5jDszKJ30WT/9NsMxWHNRUyFcNvSoUS7/SrbIzvNUMljOl8fHLN2sfydTIlpGJ0y418pKRGtCImJQGrP7nSVUbW3Bb9W6Q74USh5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LatRCUBthXhJ+o+53LiWlHn6mK7KBbJO6MDf7+3N06c=;
 b=Cng5JrNyeBMvDOYo5ETM+EzPIjX+Km9o2fThzaRMPEk1wy2LKWxA9LshxUMGujDSOQfHs0vHew0+tYnD6MVlzrfOD272JN9ZMaC8rDm9CyfFnnvhfEx5w4o1+Ro+WRjYBPdZFRSPe3CHXJWsE0H2P9hx91EDFHSRF0iT5d5rmUNkhJChIVkGiVSOBcdL3yxRUj+PEGAkQndhShFZxmhljzliVbUqb+Eik7KL8E+g7KLnKBj7/VN07/RjLjD90SnuTsPXnbi76qRvkTVkXmL2Xgoo80cCr5QoFKSzuFaqVRvEJoJVnWG3eqQqKsdzRQHJ+JSwuoisO3KmVW7ECIjTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 IA1PR11MB6420.namprd11.prod.outlook.com (2603:10b6:208:3a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 03:32:53 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::97ed:f538:dc6a:a9c4]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::97ed:f538:dc6a:a9c4%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 03:32:53 +0000
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Hugh Dickins" <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>,
        "tabba@google.com" <tabba@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>
Subject: RE: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Thread-Topic: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Thread-Index: AQHZBhXu7Ax4+tqGyUuhRxsCPgD73q6DIGyAgAj77wCAAAbkkA==
Date:   Tue, 3 Jan 2023 03:32:53 +0000
Message-ID: <DS0PR11MB63738AE206ADE5EB00D8838BDCF49@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <1c9bbaa5-eea3-351e-d6a0-cfbc32115c82@intel.com>
 <20230103013948.GA2178318@chaop.bj.intel.com>
In-Reply-To: <20230103013948.GA2178318@chaop.bj.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|IA1PR11MB6420:EE_
x-ms-office365-filtering-correlation-id: 9892dbcc-5ac8-41c4-27df-08daed3b326d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+KLpaMrR6owufWhxcR+8lZt59GtjmLOmwiVbCBBEYU9soEWVbHA2yvSqLl5bGa3A5tT54E8b876zTSgPWYlEbH2EwEpdlZP/hYj9PAhYe7BwI6EBS6iyUUOXW04pXWi52lE0kYDRw4hX0yK66ZBIZ3pJl0gEQ9FK1+Z2xBtEyxeUdjr1JQGr4FHOnfXrcTbtNkSFQ7Uet/5/41WMKbAkMqTpOne5gFwBp0LK1WYK7NSClEFz9pBndS56O5WotKc6D4Su91DwcTXteEn/mnbha6jCdxHrJRhoI0s4wn6Ul/MR5/P24QGzE3GFFCpzbkPeNx3h1T7WuYbUAI/yKRBKN9YQ8wimNi6igO0nmWfZDX6M1DdObfj8iTfTvWT9EUZG+uvKItDhjmphzwA01BDAwdXe+3uRhdki3jJy5B6JbxRPZgKuBktd/HAmaOKTo1QT1gQNa5CNOmffqTdi6yi/10VFUWbBm/yVAO7D9l2QA+/jB09OkEb7XItPxjFN8c3cWcSRPLm6RNCVu3Cz4MeJtYZSky0pKUt27ZkyI3R+PYscBJ4T7LgE+0ZWI44GqNDNTKRSG6aTRuATfCK/zMeSalNxIXxh06iJGWUjgwMDSysUNKTB0MC2pbS4ETt1iEIcxQHLKoT8XUy94KonAGChYigS7/ryfkrgBiMTUL3BecZ2Vo3p8S5JLNsST7K6Iwl4/A5NFdAk4GirlFRSe+0DOyBkxePsQ+xtMljAxrxgtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(55016003)(33656002)(64756008)(8676002)(66476007)(41300700001)(66946007)(4326008)(66446008)(66556008)(7406005)(7416002)(52536014)(76116006)(5660300002)(8936002)(478600001)(26005)(71200400001)(53546011)(186003)(6506007)(7696005)(110136005)(316002)(9686003)(6636002)(38070700005)(54906003)(86362001)(82960400001)(2906002)(122000001)(38100700002)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0euRj0C0gwYDf1F/xYNYAMOR5qffSfECF+y/peU6UVAfIobbvlRj4BGHCUte?=
 =?us-ascii?Q?r5ZXwa/tC1R0p4/G1NuUSSMuptirSyY1fGke2752HxpH9b25br/rcRVoDfEB?=
 =?us-ascii?Q?vc/pPiYN3IUpK0ttH2IIiIgPnMaLfTY80+kZgF3pC9h34BjPiAy7fKTujbdd?=
 =?us-ascii?Q?qxi7F/SVJWOysan9dnug52oH8kE5i6+Nlw+FZwKumu+dh3240nNJuRxPXrZ8?=
 =?us-ascii?Q?8+r3hMEYj4sxIH3/LldX8bwjScUKq1cC761ij4KmZmjqCO4YqCQk/CR/yYHF?=
 =?us-ascii?Q?IMF0N2slwWbI6ZyLCr5FhIiq4wepz4iVCygpJbf1s8U/jeBSAHk7GHEjQzFU?=
 =?us-ascii?Q?nlV4mon0cCeryiTOt/InJDnIL9SJ+6MXKtSTnBiDzT1J5voQYP/6akDt1PSL?=
 =?us-ascii?Q?BKjgQf3udwM+LOxKngrJpB1PN9YzdndFa6eNk7QIECywDICtYAWZxeucwEYi?=
 =?us-ascii?Q?nFeqOLwv/yspqJfOAQl9Jegd8A+DFW3EXM9dFDDvD2KfTFr85zw1dd5c0P8A?=
 =?us-ascii?Q?sR8HI9ZglttSEJ4ogQSZDfojtcs8ABKCErcO/H9DAamLgSM7rz8l40WMzOOH?=
 =?us-ascii?Q?0F8D7OHhG53fnLf0TL2ATO/z/Zz5JyZMUktYsjPzxcD0HKADaEwZbtwJBQYJ?=
 =?us-ascii?Q?bdsJi7zKtILd2+MWyVp6HgohTX9MbPE26L3ej2jbuAWz4v8psQbqMuxF0OhX?=
 =?us-ascii?Q?YvwYrvav1jIPYHHuI60A75Yp4BuSYCOf7RHE2bsalalUTzqqo4OvGX2gsCDe?=
 =?us-ascii?Q?jL//+JMZ8mucpJBramwGvywvuI33z21Qhgi1ZhyG98IGmald+DJrInOwZkTz?=
 =?us-ascii?Q?+bj6ynmbDGdk4qOACOB+p0hxm9KYDRg+M4HkRhzwIUxPn9/O8aiXPSqHNqUi?=
 =?us-ascii?Q?4sDTrRNOqyOAJi/Vf6+SL21jj+Lw0rA+evz0MJ5+3j/vzsATj4YphfTQq1ft?=
 =?us-ascii?Q?EkmaLBIgxRF9RZCIXGdaCikUYmyl/by1W+gnNFnVWpcJmSR1kTGCemO1hM+R?=
 =?us-ascii?Q?zriZ/L0GTDnyiMU3fes6QSv8z4gTZb/gWG9M4S6PxcnBiqGF1I2pGhrpT1g5?=
 =?us-ascii?Q?0ma5cyOBC0UzN4bz5fh/GlLgrogA3Y8yWBSKe71dRud+nuxz3GUcfUFLWMCV?=
 =?us-ascii?Q?1qT71KhgvikU699+5HoqxWjs6ReWAaX0dwyj4Q+DgCn2UETwb2mQg+RcD1wb?=
 =?us-ascii?Q?FREJwcBr5mujLyxfhBJpSK6uIcqGUmrFbdBGPVshq6G+ujyF9ig6epXs+10M?=
 =?us-ascii?Q?2Bx5VsMvB7Jrbj4H4REngPguRv8nI9hAAZTiAADzvxSkxwx6lAmXz6WdD2Sm?=
 =?us-ascii?Q?Lbe4aSRJiaMOtrHZDfUoJ3OEAJev2dIueoe7fhM5s6UUkE9zgWPYBmjsxzR8?=
 =?us-ascii?Q?s58lDn+13A1HvXKNXb0wUrxlWIAQOgRpPtQ7dlsxGAxTH3R5ipar/Iln/oNG?=
 =?us-ascii?Q?9xpgQYUPWKf0HOxkAKtjIXrUXIRhqX0t5PViURjQAHwnuUGaVRjpEQWXFgly?=
 =?us-ascii?Q?78D+A7n+dODdzed4Qm24gxnVoT/gAxS/EWwgcShLNw5W27kjJlNs+zZl4ler?=
 =?us-ascii?Q?NFJYDazcX68InRNxlmpHNdNkBh/vfWRMOiALVprs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9892dbcc-5ac8-41c4-27df-08daed3b326d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 03:32:53.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: An4kFQjQKfSwR+EaL9uksgjxgsiXQbUhfGm1APkx92jw1MVtvSJ2RhCTYCSsLuxsO9fyThEfaBe3pboD2E0AGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6420
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, January 3, 2023 9:40 AM, Chao Peng wrote:
> > Because guest memory defaults to private, and now this patch stores
> > the attributes with KVM_MEMORY_ATTRIBUTE_PRIVATE instead of
> _SHARED,
> > it would bring more KVM_EXIT_MEMORY_FAULT exits at the beginning of
> > boot time. Maybe it can be optimized somehow in other places? e.g. set
> > mem attr in advance.
>=20
> KVM defaults to 'shared' because this ioctl can also be potentially used =
by
> normal VMs and 'shared' sounds a value meaningful for both normal VMs and
> confidential VMs.=20

Do you mean a normal VM could have pages marked private? What's the usage?
(If all the pages are just marked shared for normal VMs, then why do we nee=
d it)

> As for more KVM_EXIT_MEMORY_FAULT exits during the
> booting time, yes, setting all memory to 'private' for confidential VMs t=
hrough
> this ioctl in userspace before guest launch is an approach for KVM usersp=
ace to
> 'override' the KVM default and reduce the number of implicit conversions.

Most pages of a confidential VM are likely to be private pages. It seems mo=
re efficient
(and not difficult to check vm_type) to have KVM defaults to "private" for =
confidential VMs
and defaults to "shared" for normal VMs.
