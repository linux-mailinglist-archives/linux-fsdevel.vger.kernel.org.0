Return-Path: <linux-fsdevel+bounces-49756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8DAC217D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF32E3B5405
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC822A7E4;
	Fri, 23 May 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9dyQptP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA222199E8D;
	Fri, 23 May 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997386; cv=fail; b=LyvgM2FHN+HQDZh1oeWk9N4/WyRBr0YPuo6saiCRhJw2dN2frtKL3sEhpL/Id9h0UpLryeVQx/Z4wdT4FjMUtQ2tTijn/ZmzcaDT9Z+EehKuEfzO7gqy9ompoI+hRJwl3myyatpEp8B1dSEVMRbqz4uFTi6QpsolJ9xaL2fCM5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997386; c=relaxed/simple;
	bh=5onImXjronVvwlXE18PFKjkqwlTCCJb/z3G00VlIhzo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nFVj3IMFyNamP2RGpdUD7DBUgNlrUZIVaaAbKgXH6g0nSPQk6PtSg1g/fnZT8fpkZrXLfLWCQ3nzL6dQEidRRNoXSGq2GdNyFEud8YaRDLORcmAu3ybkk5be/lhXCtQybn2PqR7p37XWvJf2+jpI/fWIAZ/D7k3mHCLKksl7v0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9dyQptP; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747997385; x=1779533385;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=5onImXjronVvwlXE18PFKjkqwlTCCJb/z3G00VlIhzo=;
  b=F9dyQptPadheBjbVEpMxv2lNEssd3pcrnXkciQZPOrHoxy7ssbeAwNfl
   T/nq//D7M1pU4GPCTgvbXnGikqd97DEqPUnzJMkm4ImTs86v6BmilfBdx
   5TtihdeQ0mmzpJY9RCSkvacI+fce2hTJiOsJE1ByzNRHHrVOrNiQrf3i2
   NXBm7NvrIUREQpb7sWFkqayf2QQxbucazyLJodHq7kAjUN4Rjxse+hzRV
   PSEGihYmL53dj2RDN62YUrjaYWiNVy86zMoN4tL1GT2odypQkK/08mSPz
   qjSMpgxpFm2cNTa2Xk6P5GNyBl9at45huGJt9hqWe/F/lDTJIh9C1t8zk
   w==;
X-CSE-ConnectionGUID: Q4S3bSSrSBiGu98u1OWnNQ==
X-CSE-MsgGUID: z6bQCKm0R+qfBVIvgtSa3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49933835"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49933835"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 03:49:44 -0700
X-CSE-ConnectionGUID: 76KTtVQqRomhdpAhX7A3qA==
X-CSE-MsgGUID: tH7QON9ISCeuJ+FOOtHp7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="146309417"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 03:49:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 03:49:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 03:49:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.54) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 03:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swc7btqiCET11S9GplozeZMDmnlnVMqaJvBpaDXIlhRqGZYkGAE9XXsSCwIcoPRIt0glEK4d00IzAJEh3RZx4YFu/K/VnxCBD/dzFBeSHBHW2LhMwjO2+IiboBwlUrlYqA/nUueAYLs2Gb+xxSWyOWTHxxUJYeG8Ow/IlJIfSEEvr1pkLR7bTw3icXvdiMctCN99iWXNevyjG81pXZvf3slLHyOV1dcuDQxhP6ohEu/W9CUUnHUJA2O10mxxDNj/HGH0qMGWDg2NtQqoC8DEI2PVbizh6beyBXYwrDsb+9pw1NG92PocNwnlMDfGPQhZD1iNcJ5oDIOb+Me2i8Dt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFCQjl3KL75dstDdho822eSb4Cclpj1hzZdKnZYfx1s=;
 b=l9Ll86/1VROWhK8UX/xuBGhZod/UkTbz+kaOLNsvI+dIzScbfqXJ/jbJ+luSTC8RjKBn7ePG8iEgw7KWPmarpMVCRuI5mZZBo6xPNMfr9FgafVQQGxAX0bQOvEvIroLwHZ22cBtTUNUFeFJXao0B4Jt89ZxbRqB+c6LSl8fTw6kwoNAuWiDjPO1sTmaUYdfwUc2jUG/PSn7/Eifb7dIUjTPXjmacLAq9alMG7SqGB+iG0d7xV/GBGEK7FuUp7xARo1qlCng15m2FtmDZeSMk3Wvl0YOMG6/oLyKKjXy4PkR7bJKvM5Phy0HQZ+xAF2otzNMgF1i/E9Fu1zFyTaz3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.32; Fri, 23 May 2025 10:49:38 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 10:49:38 +0000
Date: Fri, 23 May 2025 18:47:03 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 32/51] KVM: guest_memfd: Support guestmem_hugetlb
 as custom allocator
Message-ID: <aDBSJ+Se1nU8HmnQ@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: KL1PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::18) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fc5513-4493-43ab-20d1-08dd99e782f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ciuf+9pbr/yB+9JM/Xe8hde+VLaMDvjeRh1MLwTqmB21ggYRJ7v9K1GnPcUJ?=
 =?us-ascii?Q?WsytuKv5H4XcPjP4TEEq1PyGH5Nrdt9jfcUufFKi5kqX0RbUAzpTRRpXn4fy?=
 =?us-ascii?Q?6+GOuyMH0PYL5YZf+x3uj1vOqR0BGsjatUqLEI+QsqOQDHQrgy9Pjp5xVQt7?=
 =?us-ascii?Q?jNAoA+GY2owdTbUqpt4fQ87v5Hjky7R0g1+SdUN1Z5SZEkzRGrecfe0VgO8M?=
 =?us-ascii?Q?4BgQhh5f2+ZeqOXzxMIhDm3auBJPTDZn3CKDl7B++YuNc/3JxYFE8ksDLKN7?=
 =?us-ascii?Q?4N5QXlWzFcvcQioq0z91ziC9shLuzf4oi6pY8taqjqSeOqj6XK25T8sEWIEN?=
 =?us-ascii?Q?IDZa/e9XdKaaaO+py3Brt2I2/SYg/hs/qnFQBmlvjvPT6Kxhbhpfw6nW26XL?=
 =?us-ascii?Q?dVjFdJuyiKCfK1AnQEotBV190mYCWRZdq3L2olUR2y1Vu3yvaYKA89F1Qgpy?=
 =?us-ascii?Q?jhsl6TIAULkRpSWknf06nT8eFDJZu8W88Kl4c8k6l2E6GlmmDvWmPcj4nXDQ?=
 =?us-ascii?Q?F3SvkuNz6E+Rh5jNRWk/401+9gkMTmmRm3NaDdCPl3MLvE4DIyJ5tkKsdxBM?=
 =?us-ascii?Q?0hAVbVtl8HrjWwXfMYkMNdOpeqDUIivmI30IbRsXANJfhkrzxc5Dvbbg32+x?=
 =?us-ascii?Q?cwvRfwiKAUEHbe7A4HspVpmnWsyO4AS1lq2Xn/Br4qL9e+OIV8CwLWw6D8qL?=
 =?us-ascii?Q?XD8F2SAlPBBBIaYxeUT5EWXi5Sct0jmnge1N6ts5yJAJIlaSpDmNYwFjyS9/?=
 =?us-ascii?Q?KwIgZf/bQa1foo1lpHDeu7X0ryX/iiT/XIZfoUSlY0g1pe185xzTKWqNbRCv?=
 =?us-ascii?Q?CIRJp/kApaDHXheY5NOsw2an/IBfxj/VLKyVA/QDzqOOo8IZulBKB1Cy21IZ?=
 =?us-ascii?Q?7f35dUg4FYPgOkjFCUw3VWNp6jg7sslw4K4HpHqFD79wgD1pXihHnHG97jSM?=
 =?us-ascii?Q?lZddIGYlGHVeuAbQS4K7gQxm+6ckm7vNiLpESAhYq1uRfj8phFflq9H0jmpi?=
 =?us-ascii?Q?tKas2l4B+nGIGxHjZ4xGuHMSxiaeYsaosYuKftRwA0O7QTkrplHky963fPoS?=
 =?us-ascii?Q?3/KgQOKO15ZWTi6D8hxjGGYEaSkAkF+jThCs6G1IgNkLB05lT+Qhm8BJGf9R?=
 =?us-ascii?Q?4wpPCPd/xL8hAfNfH8sDjMC2rul0vsrH9VNq0EbzVaf//XCnZYFfY5vS7Ma3?=
 =?us-ascii?Q?VV/77LxgHsZQLpqVKyG9ojNi91t4fi+RIhxazJbCPuFcjAN5tuFpyg46SrC4?=
 =?us-ascii?Q?KO2+q99JhW6zLCK1D92fg43Kbak3+EYx/ktDeeD00EqSGVuf189yPOBjIsxL?=
 =?us-ascii?Q?3271yDGPKLzVTXmhdlpEd25acW2K/cihbKXZGmYS5qD3vGQXf2wlAExEB9mc?=
 =?us-ascii?Q?G6lbqcD5M1hT9eL7VCNQ2FEv5EJjpvHDyBOUzEEu8eb+ZSl+ZW2fMQSka5Fe?=
 =?us-ascii?Q?7t05KJGDZ6o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzUJka9PpyzP++JqXXpF5vRmp8XDowG51RiP5ddz3pa/wyF366EhKsM3I6Q0?=
 =?us-ascii?Q?OXNFfnrQ8ZPO9tEQSottNVacm2rGEqmcxz2Qb+y0FloyNg1sPuQK29Atrdbi?=
 =?us-ascii?Q?N4+Gq7lJjQGycGkakVkVbNstXs96PE/WcREps4iNzbkpnOL8s67cNXE25AtP?=
 =?us-ascii?Q?rlQkt+hBMW62Zc072T3x+Q2qJGjRzz7oWdXdgQYjdPyrXiNHQMgo5OXWHvoW?=
 =?us-ascii?Q?uQBa2GmiCC2pdIafT7cFMeow7FtSI0x3D2IXCkQnp8SB9dcjoMzn8ColXtyU?=
 =?us-ascii?Q?AFXNCSRLIZFpBV2+n6EX2OoDq+EI5lKTF53aD9cofJNldXTdUTF7LOGwp8vv?=
 =?us-ascii?Q?ClVZ2MYtZP6WZywJy8ZDAkOCAUKatwssEgLHxVH4+PO/8hn5SNsonJuWEOFw?=
 =?us-ascii?Q?r793aFhi4SqwPP3MhCR4rh4PwsQ2ohgNmqk7jJrcHp+gqodKEuqjajamn9E6?=
 =?us-ascii?Q?tCCCDtpVUjG5yXd4fsx40IBQ1sBWTvBcJ/NY0QjL8AY8XnRmSvcU3tKxhfO4?=
 =?us-ascii?Q?JBoI0FGj/wvuhALRW5xN2DBhmdFG7ahw1/LgR4RKsYc6I/xhXJ4NUwJv9BE0?=
 =?us-ascii?Q?TxkeixSQQ7lNDmznVHG0LEbVWI6MlTnuLKmte33cDffBjaPGHzLvUhrU5N9X?=
 =?us-ascii?Q?dyl/08atZdWaZ/TR7SzgjEmOSVVyfBG2gYzjiM8Aj1ys8U2bE40VeSnKfHgk?=
 =?us-ascii?Q?/kQyPTbvZqnCDNeVwhXQl8bLo9w+/A44sYiIsruTHjm0mZaGZWrK/JjBFwpp?=
 =?us-ascii?Q?k5BOfK619SRQ5mXYNEnHQlpkLra1CUWoXPd6viDLSj5NcIbszMWQEUC9sxNY?=
 =?us-ascii?Q?B9srHXp/xkQzULMyahLUFboiknrYwRom6m7G3L/xG2Gf70+wXOBBsxtU/xV1?=
 =?us-ascii?Q?kDm9B9qzjrKcyEZKtlV2osA1WJ3H11lFwfKMBgGS91+mAJ143wA46HRjfS1u?=
 =?us-ascii?Q?iqPOwRIMWtusjY0/yO/tWehkBNoGNGM5N87+3FoGMJwTiXBJr9yjQbLzERTA?=
 =?us-ascii?Q?OrOM3mQZhAGSK6khkut+KrSlIEB/p0sIfebCViwaPmvXdvEhbhDuKQR2USC1?=
 =?us-ascii?Q?yOXHcO2VigLOW8onREgQRmqarTIthO/nnGlMg7rY2DTxNKD+KIRjkdBITuWN?=
 =?us-ascii?Q?Cy1Vp/kSon1nzC9uGPc7lZ6TS3W3Kgt896CwDHucdf9WKR2HiOKpH/hgvHuY?=
 =?us-ascii?Q?gqhvtcqnnrUl1BhjLzlEk5HBe4OfyIuMZG9IEXUAgdyDG7p1LbfPLO019nyo?=
 =?us-ascii?Q?gv1C4lC22/0UyNxhpBAqV1V6OFTtJL8htFZYRwd4TXot7MVAGKdD/5TGVJCe?=
 =?us-ascii?Q?oK+bYiXXfXksiMFjvRVzBTNmnmfs/b+sHSPYFTSDvHbc5kA6fllOwRoyRZBU?=
 =?us-ascii?Q?W7Yy+ftWzlWaCllutpuhwi3ZhvWSCgkDIY2YIUTeh1/QQWvFuLJojhXPZq7l?=
 =?us-ascii?Q?yxlthCVlqaq3I1QLbcjUHRQzxpX8YyvxQyxRucEzFkJWBZiwOr/v0wMrvniI?=
 =?us-ascii?Q?taG78QUWlglZueX/9GfKmcVNxYmtp1Mh2BfnkjE4cm07fRJf4LoS7kjChHXg?=
 =?us-ascii?Q?yLV+4gU8ynHlxQEMxwyIyzeALl5cV17UX5aPDrn5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fc5513-4493-43ab-20d1-08dd99e782f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 10:49:37.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNQrmRoKFL7GmEOF5s9oyAQiI5+jQ4ALqSpPPuJB1psbG5fEPtJG4NwF4GvWfFuGIuerRpR3LhRhE1KRpgYZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:42:11PM -0700, Ackerley Tng wrote:
>  enum shareability {
> @@ -40,6 +47,44 @@ static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
>  	return inode->i_mapping->i_private_data;
>  }
>  
> +#ifdef CONFIG_KVM_GMEM_HUGETLB
> +
> +static const struct guestmem_allocator_operations *
> +kvm_gmem_allocator_ops(struct inode *inode)
> +{
> +	return kvm_gmem_private(inode)->allocator_ops;
> +}
> +
> +static void *kvm_gmem_allocator_private(struct inode *inode)
> +{
> +	return kvm_gmem_private(inode)->allocator_private;
> +}
> +
> +static bool kvm_gmem_has_custom_allocator(struct inode *inode)
> +{

+       if (!kvm_gmem_private(inode))
+               return NULL;

> +	return kvm_gmem_allocator_ops(inode) != NULL;
> +}
> +
...

> +static void kvm_gmem_evict_inode(struct inode *inode)
> +{
> +	truncate_inode_pages_final_prepare(inode->i_mapping);
> +
> +	if (kvm_gmem_has_custom_allocator(inode)) {

The i_private_data of the root inode in pseudo fs is NULL.
Without the two lines added above, evicting the root inode during unmount will
cause NULL pointer deference.

> +		size_t nr_pages = inode->i_size >> PAGE_SHIFT;
> +
> +		kvm_gmem_truncate_inode_aligned_pages(inode, 0, nr_pages);
> +	} else {
> +		truncate_inode_pages(inode->i_mapping, 0);
> +	}
> +
> +	clear_inode(inode);
> +}
> +
>  static const struct super_operations kvm_gmem_super_operations = {
>  	.statfs		= simple_statfs,
> +	.evict_inode	= kvm_gmem_evict_inode,
>  	.destroy_inode	= kvm_gmem_destroy_inode,
>  	.free_inode	= kvm_gmem_free_inode,
>  };
 

