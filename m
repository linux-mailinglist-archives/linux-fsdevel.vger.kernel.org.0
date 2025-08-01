Return-Path: <linux-fsdevel+bounces-56483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51474B17A55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B0C1C23B59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59923D81;
	Fri,  1 Aug 2025 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD9uLT7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58537139E;
	Fri,  1 Aug 2025 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754006571; cv=fail; b=Ia6bYTympSAG2NBRnIOdtLFiM9mecwfd+pjD7dEsuyoR3EBJy8965XJF+/bMtXZiWc8lD3tGMEcA7RioCeR1Kyz5yTqAaZqIo68RYB144yNReK6KOGw+P3Kla97TcdO72SxgPMz/cwR5DfakdvKPnbQgHeP60nCal+/KLOMD3Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754006571; c=relaxed/simple;
	bh=JBOvuB8IQ0okuCl6BDorzbjTJWkoZFkODfLWhac9/Ws=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtlYk388BJtvgWqGdWQxtq8ls0SU2wnXWVFsARzvXPp8WPu+csnb/sre1Br9gc1RUkrErAFbB4ARFZ7lcpE+DjCUhfjkPX4HKRHxBp7XXCjHarHvdj6UKCnfgAiK4BOmUclg4XvnPp+fFgMVd3Xu+jsL/a7YhrCBS0hiV5CXOBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QD9uLT7+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754006569; x=1785542569;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=JBOvuB8IQ0okuCl6BDorzbjTJWkoZFkODfLWhac9/Ws=;
  b=QD9uLT7+9Lt6GWUTWUSUsNmdGh+dAnyC44TPZ/co4vY9xpz3MH2AoRDG
   19ij28U3ZWg2R+b+nUwSdE43O3GKci5ic92huZtwiXS2EI1CEMeMA4+jU
   BudR4JDT/lRH+ggrjeMr/GL6j59dwr0Kv9ZFe6uKmOgPqXV3HtKDhcWzJ
   /FQZeZtn7v+NTCiBKnQh2ZA8jeKi7Jh70VTpbUXKOGx7H9/YaYrmGwEiR
   OgUECozStFjkWQUK4oPEx4/rVJipC4z5Hu/y8cUF0NOHh7dJqAR1bcp9K
   njeKbtEHDkb4qUcLS8G8MjMNaUWlKzpGSl0gRoFhcxpC8RTX/qNcmTvTA
   w==;
X-CSE-ConnectionGUID: 3iTvCoRAS86hXdX5s9KDoQ==
X-CSE-MsgGUID: rjUTUHbuQEi/Hs9TQ3kJUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="73936195"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="73936195"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 17:02:47 -0700
X-CSE-ConnectionGUID: dE8A+MdURpmaC9Uwuyy5ew==
X-CSE-MsgGUID: Qarn9KsCRZS2Vmm5gnzr2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167665069"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 17:02:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 17:02:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 17:02:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 17:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMP4TrgiULHjlhxQbq6xekE3KtaKr2VnXd3XHJGglo/xpygGayNpUoTkGpLh1aTwD57HZ4nGC4sutlH5AXnnU9YXKwh8ix88XTvgdkjlX1fJEbC+Esifxi7+dOtS+KfO2vgwavYLLcQj3tQUng7YVa4BDhfiAMlD1RoWeIVuS7KbfRkVJ1QkS5fZ9DnfRyheevMVD1ejRmfoPV8p/OWZbGf5HV+G6/n9Lw5PUxshe5nkL9zAW/Wt5tKJDFl2KNTpwBPs+YJiTHdodMxpgHMuS1NXeOnW9F9zQsXQLTS2Oksqof1ZU3kJbERRJhkpIHkvrCiGshxnZ/tFfE7ELAuhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK3tdvM46EhPuOyV9We1BHfwLLPXaZEVOB6N7VpmaZk=;
 b=PB5U8Z3btDsDhERxI73H/V+EEiP8vaBrgtrvrwIJHEoeejCbyd6jlLxg82qmXQ1NgIcsh/m4kwGcUXbOYU7eVlG4tAxiUzlfWOKb2VXzuosRxAc/+JNKLa4ZB1ySV6WLa1OuchbGQRyq83GKmwDL0bGCXb+VYy3wX0Ul6uVqfjujJCxMli8XxcYsV/t+ANfCKWsGM2ZIgODT/YUOO/yqCjQssk620e3TKjXkLRayeRI3r6+xcVOhHS/KfDWqQUJKdWwAzYIl0xN7dUt5Wov74NjXi2rDiWz40c3+rk45X6Nih7eWz/xxZLLhVsd5GKzIPWBsfE9iILYEoB41ApKU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Fri, 1 Aug 2025 00:02:38 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 00:02:38 +0000
Date: Fri, 1 Aug 2025 08:01:42 +0800
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
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8e8323-d40d-4f49-d49f-08ddd08eb9cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CJK2pB9nykuKLrUAyNe9Yy3pzDFbbl4VZjo+h5/U82rM6knJ8NPY2Qxdk8SX?=
 =?us-ascii?Q?FBR4MQjkhfKiX86sjYTVaMFGVwlgq5pK9ZHzldx/Y9sTvsPJ7w/OFy047nWu?=
 =?us-ascii?Q?OLcNAzQFLCfJ0Ysa/23eZ4yY5YA+w27qOU3MTzJXvTo/z7AqDB+XbCUlSKEp?=
 =?us-ascii?Q?8ZGQxSWTMDJq4u0XA/ZuQvld5RzHUN7oJkWDF3tk4nvAHyZXAzVM24/YtBNj?=
 =?us-ascii?Q?bhRa3qtp0KT7JTS2XmYgEVnkDbdYeWEwS0s/EEYvgpFyOnveZxH+NKvIYM1Y?=
 =?us-ascii?Q?NjOnMH/vWwAPtlS2QWBNhh68AGIMdLvxTAuN5gzXwdV3+sq96dZSorrMFEuD?=
 =?us-ascii?Q?BswQQJzwSmTrnIDZehLGYZ6ehdVgbz6HzoTT4Px0GuEu59htZ1yHZ7xEq2dx?=
 =?us-ascii?Q?d+s0nqXWgUPqwAfp43bIO0a9dkqT7zEumIhq/GoAKaCIE6W2AjHA9bzeMUAH?=
 =?us-ascii?Q?uWad5rJA0RqP7P+nnwSbiRbyotrFiZZpM/F21kCqT+48+YFzmNGkyIUrVr1h?=
 =?us-ascii?Q?QL0IDBy+be71InWO6NiJA3jAQGXLHj4ykxtkseexzqoYnkICat+h2TJf/HB2?=
 =?us-ascii?Q?USy+LlmUTOt8wi13aFs+bK87Ru2Kar5IACI9fQ+Hh13BZN79ZMczuM6DWXvk?=
 =?us-ascii?Q?od3acPnm7ku+w4bNH9AwoXad1pZ1GKBfG82QpNIpShdMNbGTmRhUNgxkbauO?=
 =?us-ascii?Q?gADCmg9ZZhv4RXEKCbzkn3xaGXDwTNIUFDduVYi56v4mMqvws6DvcJ3sXZQD?=
 =?us-ascii?Q?6+Ii0PMSWdb7OOun+SxiZ0Q6XCp4jWzVhNx8jov89Q4EAmkt8PmNgeup1Vxi?=
 =?us-ascii?Q?iiWfvHVMouKOM/9MhPbjUpDP/KuKyLFApps0TCwAkQLI6YDcxhHAgTEJtSwB?=
 =?us-ascii?Q?j9hAtNaZ1J2nfFHfB395OM5IkZ4qpr/5lw3skjRzuD3mWRo7Racu89RS1mDM?=
 =?us-ascii?Q?5eZjm4EeCY3SvXRW509tsJ2pJgh3NEpCFfG0r5iQ085PK91GJOTvmyW2EduT?=
 =?us-ascii?Q?1LyGTGGDf4lURBl81Zkf+pg8MSU6XMQJbPLSyMncQw84Ly300h6/ed+LVrox?=
 =?us-ascii?Q?JrUa6Ywrgzzzk65wHGhJ9bK8io2X3MSOgfWIaBFvNetvaR+ElFrsWP/2FDrr?=
 =?us-ascii?Q?0j6yYft1hyCJNrnJ6bgtKxJTMzCtN2WD+9lmWw6pt1VQ3mCOInDHVCixXH9j?=
 =?us-ascii?Q?NNrWrh+a0mczEwMUws5Gcnl84pgY1XBagvbrGjtHI3YArwLQZhYJT7enEZvy?=
 =?us-ascii?Q?mSAydPKVGxeAmYKBCHCheZ7Y7zxoBT72gJWBkEv7RUuIXqqQcsgArFBszYOL?=
 =?us-ascii?Q?oIKvNGEAIeddTWmwgcQHktb0ClPjc7Tat+aTAke+NlpqULWfCUy2nXA3juSs?=
 =?us-ascii?Q?gccKZmqZpGu3anO+Z9j3UKFg4wjR+NqRemSbgVIV5Kla3TT2r7p4szHJJMQC?=
 =?us-ascii?Q?PMagcUBH8WA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xO1vcAwNU5xHgrothtw6b7V+twQoGIkvUQQ1LAFRmz60x0/wgdGTyghqhJXO?=
 =?us-ascii?Q?6jt4V095uRV/XFIfCLGcRy7XFzssvzazn+tk1iyL8FqunzFV1JutZyp8kKtD?=
 =?us-ascii?Q?9ssiBe4Md/FRXbvwBrtvKZgQ7acWI/kGlIv6/1ZxXK4QlOopa/oebUfR1Pah?=
 =?us-ascii?Q?GBdGRqSBzzbamSjyGQ9kPe9HfFMLd/TEqDYc4n6e8E5WArB/Mcy48Y+ns4/D?=
 =?us-ascii?Q?xGBv7Wm8WAcJUXNmWOc15pEwQQnyakAWNzSf9poVqIL0e17eM9zx4ZXpDvCA?=
 =?us-ascii?Q?8gfPHlEuRMHhlxf8jQx0NFDRmtIL/hx4XSLhjPxw2n2ws39eGqsnoeBjhR3V?=
 =?us-ascii?Q?nVLBE2x2nw/eipmlP9JOHGb1wYRUCHAkee9hKK95Qlte/gleC3nl/mrN2sB1?=
 =?us-ascii?Q?YvuASkd+Hwwb7cQtvmXsFJUngkauHgz9xeEhtuaZgBai5FN+jsFVQor2wdOl?=
 =?us-ascii?Q?/SMaZMfDruRYvbRoj9LLncTmwVa6kaRx6jx0zrOERtPJV0baFiYjxdY/0qz/?=
 =?us-ascii?Q?v3XG5Vh4xNxlW4x0ohggsfxY1lU72ZgQh5hQwkoRGWt8wkEWmkJERisWvIRC?=
 =?us-ascii?Q?Ez9MKBSljx0cxCYhQiJjOx3usgEbXmWFnGRa7CY3979oWaoNT099TfTrRUg0?=
 =?us-ascii?Q?gmWryOOwCOF0QbYyKX3alcyrndRrXFt2kt0l2cM2anvSa//pUxLqHYyDKUqn?=
 =?us-ascii?Q?NWkMyE0+DMaL/4r4wYjKgDBS4/XSVYFjH9zmzHv6ZlY8xXJNvOy1uawislos?=
 =?us-ascii?Q?jUqnlJWqATqqH4YK9NJxCp1gogF3JD3vVQdbXVaLelImzoYUCuTAXrt9P7hd?=
 =?us-ascii?Q?c1KgWT95VyAMv13o3f9PqGOUj1mwfI08mt4KYe9n6C26akNh9jm2hauLDKQG?=
 =?us-ascii?Q?IEwwgU/5aZCWjAu09aiYAlCuQdKdzI67uNBM50mSFqXhXURfkmstB3/jLbfv?=
 =?us-ascii?Q?z5KR9Jzzp1YWs5SGDCgYQIEYrqbl9obgqyPkF/2AFt7S51lN5E7DfI0QNYSL?=
 =?us-ascii?Q?aIkVx+Yny6sDz3YCbB3BlkMeIevRK8oDBsvCuufhuONEXj4GgsK68NnbOT4m?=
 =?us-ascii?Q?V4RBlydckO0y5ePaZX8nIlT28wPt3Hhmb8Bj0TVHIaS0vmWS/JseOBRUvYHX?=
 =?us-ascii?Q?T71GS3gWQDf/0VFR93vyxRqwzSEBfgutfyyZcMdLykbDHgFRWQco6zMRuf0h?=
 =?us-ascii?Q?J3WEoDPRztHnq7Uq14nPBHspT2Hi4D4gvQt1tXNOfk49NDXtVaJzjRZDdovu?=
 =?us-ascii?Q?vx3OZu7suC8KM2baDF6TiYju2eZNcpkp4WD9knVAYbh+RXSIt4qOWDLXVdYl?=
 =?us-ascii?Q?4YqalG8juPhijbkFwWK9xS0llEyDMWjej02Y7/rqjdAxEKIMNXK5Io+xQBga?=
 =?us-ascii?Q?DoqoXW1q4WKHrZcqua/qQFdzKl1NZ5s3RpfGvN+Tcq4gptOvvtxSdYqQlQ8Z?=
 =?us-ascii?Q?YN6e8htmYjTBRhCtRZ990wmqkLhrgDXuCMuMTUP3uhQmEjHZEt7glSF54Xnv?=
 =?us-ascii?Q?CJXPOpbdDiVp6cgdQJZO8UaLvSKJTZxG0vaXsGBFuYMkaQyU8oBGZ2MngsEr?=
 =?us-ascii?Q?waLrzI9u5I5Kre++aFzmYGelRaa0+83S/HGXIvJA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e8323-d40d-4f49-d49f-08ddd08eb9cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 00:02:38.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xztOWYRXO/dpf6oeda1RambTid+LnYY1lqeOzHd+nbyfPYYaPJpqzRtXPZHmo2z1jDhhvz9Mlhwhv+9w9F8ZYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
> +						 pgoff_t index)
> +{
> +	struct maple_tree *mt;
> +	void *entry;
> +
> +	mt = &kvm_gmem_private(inode)->shareability;
> +	entry = mtree_load(mt, index);
> +	WARN(!entry,
> +	     "Shareability should always be defined for all indices in inode.");
> +
> +	return xa_to_value(entry);
> +}
> +
Hi Ackerley,

Not sure if it's a known issue. Just want to let you know in case you're unaware.

During a test to repeatedly launching/destroying TDs, I encountered a warning
from kvm_gmem_shareability_get() (see the attached log at the bottom).
The reproducing rate is 1 in every 20-100 times of launching TD.


After some analysis, I found that the warning was produced by
kvm_gmem_shareability_get() when it's called from kvm_gmem_is_private(), which
is not protected by any locks.

I can get rid of the warning by either fix 1 or fix 2 below.
(I prefer fix 1 though :))

fix 1:

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e78fbebf4f53..136d46c5b2ab 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -2024,7 +2024,7 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,

 #ifdef CONFIG_KVM_GMEM_SHARED_MEM
        if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
-               mt_init(&private->shareability);
+               mt_init_flags(&private->shareability, MT_FLAGS_USE_RCU);

                err = kvm_gmem_shareability_setup(private, size, flags);
                if (err)


fix 2:
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e78fbebf4f53..9a4518104d56 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -171,7 +171,9 @@ static enum shareability kvm_gmem_shareability_get(struct inode *inode,
        void *entry;

        mt = &kvm_gmem_private(inode)->shareability;
+       mtree_lock(mt);
        entry = mtree_load(mt, index);
+       mtree_unlock(mt);
        WARN(!entry,
             "Shareability should always be defined for all indices in inode.");


Thanks
Yan

[  845.253021] ------------[ cut here ]------------
[  845.259236] Shareability should always be defined for all indices in inode.
[  845.259273] WARNING: CPU: 148 PID: 3775 at arch/x86/kvm/../../../virt/kvm/guest_memfd.c:175 kvm_gmem_shareability_get.isra.0+0x39/0x50 [kvm]
[  845.283330] Modules linked in: kvm_intel i2c_i801 idxd i2c_smbus i2c_ismt kvm irqbypass nls_iso8859_1 nls_cp437 squashfs ghash_clmulni_intel hid_generic aesni_intel
[  845.300914] CPU: 148 UID: 0 PID: 3775 Comm: qemu-system-x86 Tainted: G S                  6.16.0-rc6-upstream+ #520 PREEMPT(voluntary)  49e4d0c13b52dd8fe7006bbbb80b018c4576ab2d
[  845.319631] Tainted: [S]=CPU_OUT_OF_SPEC
[  845.324956] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.SYS.0101.D29.2303301937 03/30/2023
[  845.337749] RIP: 0010:kvm_gmem_shareability_get.isra.0+0x39/0x50 [kvm]
[  845.346085] Code: bf 48 02 00 00 e8 a7 d4 08 d1 48 85 c0 74 09 c9 48 d1 e8 c3 cc cc cc cc 48 89 45 f8 90 48 c7 c7 a0 56 5c c0 e8 68 3c b5 cf 90 <0f> 0b 90 90 48 8b 45 f8 c9 48 d1 e8 c3 cc cc cc cc 66 0f 1f 44 00
[  845.368227] RSP: 0018:ff29e9c2e336baa0 EFLAGS: 00010282
[  845.375038] RAX: 0000000000000000 RBX: 00000000001825d4 RCX: 0000000000000000
[  845.384020] RDX: 0000000000000002 RSI: 0000000000000001 RDI: 00000000ffffffff
[  845.392966] RBP: ff29e9c2e336baa8 R08: 0000000000000000 R09: 0000000000000000
[  845.401912] R10: 0000000000000001 R11: 0000000000000000 R12: ff1236f76e067a80
[  845.410878] R13: ff1236f76e0ecc00 R14: 0000000000000000 R15: ff1236f783af8000
[  845.419850] FS:  00007f8b863fc6c0(0000) GS:ff12370458883000(0000) knlGS:0000000000000000
[  845.429915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  845.437304] CR2: 0000000000000000 CR3: 00000003e9989005 CR4: 0000000000773ef0
[  845.446265] PKRU: 55555554
[  845.450224] Call Trace:
[  845.453887]  <TASK>
[  845.457161]  kvm_gmem_is_private+0x4b/0x70 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.467348]  kvm_mmu_faultin_pfn+0x14a/0x360 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.477740]  kvm_tdp_page_fault+0x97/0xf0 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.487843]  kvm_mmu_do_page_fault+0x23d/0x290 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.505524]  ? __this_cpu_preempt_check+0x13/0x20
[  845.515349]  kvm_mmu_page_fault+0x8c/0x3d0 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.529136]  tdx_handle_ept_violation+0x16a/0x310 [kvm_intel 1efe846cc4054cc289d319f1912cf040ec0ca0e6]
[  845.547760]  tdx_handle_exit+0x44f/0x540 [kvm_intel 1efe846cc4054cc289d319f1912cf040ec0ca0e6]
[  845.565647]  ? lock_acquire+0x52/0x70
[  845.574284]  ? vcpu_enter_guest+0x452/0x11d0 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.591886]  vt_handle_exit+0x25/0x30 [kvm_intel 1efe846cc4054cc289d319f1912cf040ec0ca0e6]
[  845.609407]  vcpu_enter_guest+0x4b1/0x11d0 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.623253]  ? kvm_apic_local_deliver+0x8a/0xe0 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.641247]  vcpu_run+0x4d/0x280 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.654096]  ? vcpu_run+0x4d/0x280 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.667165]  kvm_arch_vcpu_ioctl_run+0x544/0x890 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.685231]  kvm_vcpu_ioctl+0x143/0x7c0 [kvm 6f655eadf3c2ae71b90b04a3d4ef5b799600c3f8]
[  845.698810]  ? __fget_files+0xc2/0x1b0
[  845.707633]  ? __this_cpu_preempt_check+0x13/0x20
[  845.717555]  ? __fget_files+0xcc/0x1b0
[  845.726405]  __x64_sys_ioctl+0x9a/0xf0
[  845.735241]  ? __this_cpu_preempt_check+0x13/0x20
[  845.745163]  x64_sys_call+0x1054/0x20c0
[  845.754043]  do_syscall_64+0xc3/0x470
[  845.762701]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  845.772906] RIP: 0033:0x7f8d9c124ded
[  845.781398] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[  845.814651] RSP: 002b:00007f8b863f7cd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  845.827882] RAX: ffffffffffffffda RBX: 00007f8b863fccdc RCX: 00007f8d9c124ded
[  845.840591] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001e
[  845.853201] RBP: 00007f8b863f7d20 R08: 0000000000000000 R09: 0000000000000000
[  845.865776] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8b863fc6c0
[  845.878246] R13: ffffffffffffdbf0 R14: 0000000000000007 R15: 00007ffedb593c00
[  845.890732]  </TASK>
[  845.897565] irq event stamp: 859157
[  845.905815] hardirqs last  enabled at (859171): [<ffffffff902447d3>] __up_console_sem+0x63/0x90
[  845.923321] hardirqs last disabled at (859184): [<ffffffff902447b8>] __up_console_sem+0x48/0x90
[  845.940892] softirqs last  enabled at (859126): [<ffffffff90194ef8>] handle_softirqs+0x358/0x4b0
[  845.958654] softirqs last disabled at (859207): [<ffffffff901951cf>] __irq_exit_rcu+0xef/0x170
[  845.976232] ---[ end trace 0000000000000000 ]---



