Return-Path: <linux-fsdevel+bounces-74402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C234DD3A0E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AB973007915
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197E33ADAF;
	Mon, 19 Jan 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLsdbfsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DB2DF14C;
	Mon, 19 Jan 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809807; cv=fail; b=WubC/htxPwatPqnE5uF4x3DwPic4dyeWXCIiazgb/OMH9ljZbK26hIVQZ5WQocjV7cy8AVaBWqFBtkeMVzYbgi/DGSj5gOc4g7TYcK/zyVOpIWSXswBsAuHkIy9l0kJqkOn8SaucYqDLHqxvC3+CVzwCDGW8/rADlJG/P5wHQVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809807; c=relaxed/simple;
	bh=MA7GmuZDOnxNSGB3qYApMpomRrmq2/xMchfrqr2BUmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IQkKYYqmDx7d91IqcDJ6LRNTt0qvWZD5S7QdS/+411z3ep3nyLRDLtf5oomRVX2kKCRu+bBS6+i+D5JyCQufDjxaEnQxvkQ2vtjJ0x0KIG6NwzzvTRL+naDjjqr8RekW3Z8KfkdKaAeCrIH9t+8Sc1HcJUZNeJy4r/yRA7wdgIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLsdbfsS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809805; x=1800345805;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=MA7GmuZDOnxNSGB3qYApMpomRrmq2/xMchfrqr2BUmQ=;
  b=PLsdbfsSCTIiqY3PsmgtRW1uUFy1eXJHOEKQ1+PeJB4CUYxKJij3cvq3
   dtXOi2qTHIw+J08GlZ4nv0sDrkBJZCchGoR/5xsE4ZTf1ltbz7ACZuzzE
   s72FeOaHyQ4BRokEUrRyh+meJSbgXkN4fPfes0Y3sxmtldZJf495E8Cel
   GzWz8MvK6q8FI4oHhgi0kLlqc9n63jeR3rhtndk+pB6cqUfyuucZeZm9g
   BEhuV4Lu2QcAWE1iBuuYqQAMgN9sxfHnP0jnGWyW+3GpCvKpLrzh47Rm2
   tIH0vvhQ5X0l33VqdyJB48Sl3+ce76junVDV5fdRbS6rQbLRhZ+dW79/u
   g==;
X-CSE-ConnectionGUID: 4R2R5kkRQH+tSUxJ4P9OLQ==
X-CSE-MsgGUID: DftFfGesTvSHkb2ndr8TtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69919904"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69919904"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:03:20 -0800
X-CSE-ConnectionGUID: 3Qk5rQz/RXK3Ti7JZc8tvQ==
X-CSE-MsgGUID: Y6I75pqsTlG34pD6cE++Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205419650"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:03:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 00:03:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 00:03:08 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 19 Jan 2026 00:02:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2OiRn7AV4hjTW8BRvnoiSojiDeP/SlAqXcT9hziAXsRlx3R+OeMufbp/DMfL3Fvr+SXzH8dRzOy0TfXkkigCstk5ifZ4C1xyTtsXgOF5XheW7w8w032FbXhXY+HYvvGWUt8G0/8TmTn9VpYGyBDLRmaw7+eLh0rCgvWiFFaQOKgmR5qJUwHU91IdFpEcT2gT0wMW/GxDH7zA9O0kPaTmPcTgtHrRgW9D/gbzuYSYB1WZVBg2VxmjV1L7CTmcbnFYU9EPMox46LY4ZG2UbM6u9bhnehf7/IzV3pBsENBot2gll0r23RbPzna+8ACXCE4TFsOn2+QX+X/05iLi1GezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB4LxW1Chlm2kIHtKsmG5jzdQpZRxHKZaNYdn6kr+2g=;
 b=t3lWn66Q3hz6nH/LDXbx45BhwNaAsskvk36vhTwiiIvksAgKdGWjpxBy2z6dh/fkY4IQSduZ/uRxremRB2mVKOa+PSCkxzNcknOJGuxWLgPjj/H/ircxP4Y8Ajnbqup/xg9wwkRO+6jzK5l6oGxt1HcF7WKIsCe+1vxymk97MFWhr2vDLt842GIoUnY7sYIa5iByDJyWmmiaRCRubofl9EmMS5X8AK47UjCvL8Bc1au1Mb6/9aYtb4t8QsynTevyBZ9+EhPeoUugPlcq2S1EE2zE4UZkdR12p4gOdRJ0q/g93cqscXmz45WgjYWQIUWwhA2xw3BIvoB9WSjFRMFYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB7318.namprd11.prod.outlook.com (2603:10b6:208:426::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 08:01:56 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::413f:aab:68fa:b1b2]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::413f:aab:68fa:b1b2%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 08:01:56 +0000
Date: Mon, 19 Jan 2026 15:58:50 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <cgroups@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>, <x86@kernel.org>,
	<akpm@linux-foundation.org>, <binbin.wu@linux.intel.com>, <bp@alien8.de>,
	<brauner@kernel.org>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<corbet@lwn.net>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<david@redhat.com>, <dmatlack@google.com>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <haibo1.xu@intel.com>,
	<hannes@cmpxchg.org>, <hch@infradead.org>, <hpa@zytor.com>,
	<hughd@google.com>, <ira.weiny@intel.com>, <isaku.yamahata@intel.com>,
	<jack@suse.cz>, <james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<jgowans@amazon.com>, <jhubbard@nvidia.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <jun.miao@intel.com>, <kai.huang@intel.com>,
	<keirf@google.com>, <kent.overstreet@linux.dev>, <liam.merwick@oracle.com>,
	<maciej.wieczor-retman@intel.com>, <mail@maciej.szmigiero.name>,
	<maobibo@loongson.cn>, <mathieu.desnoyers@efficios.com>, <maz@kernel.org>,
	<mhiramat@kernel.org>, <mhocko@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mingo@redhat.com>, <mlevitsk@redhat.com>,
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<peterx@redhat.com>, <pgonda@google.com>, <prsampat@amd.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
	<roypat@amazon.co.uk>, <rppt@kernel.org>, <seanjc@google.com>,
	<shakeel.butt@linux.dev>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>, <tabba@google.com>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <vannapurve@google.com>,
	<vbabka@suse.cz>, <viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>,
	<wei.w.wang@intel.com>, <will@kernel.org>, <willy@infradead.org>,
	<wyihan@google.com>, <xiaoyao.li@intel.com>, <yilun.xu@intel.com>,
	<yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
Message-ID: <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1760731772.git.ackerleytng@google.com>
 <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
X-ClientProxiedBy: KU2P306CA0018.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::9) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: e9aebaa6-1ff9-49af-6eb7-08de573103fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vVYEliQ/LonOBolkZv2Q5oe0XBFj7QD5zoZgYtLDBQrbJEe+/DPYNSxfIYKF?=
 =?us-ascii?Q?fiN5lI62/uDxnWspOXPAsFeLK+a/nRCGimACzWpoJFUESaIluabZzkbtM0cb?=
 =?us-ascii?Q?ZY52UDr9w6IV5x44wjhCsqGeiwpThJrYy1JuIet8QVQGmTH3ZI43gnlR3F7m?=
 =?us-ascii?Q?0PWWIqTuCZNuhyZ1Szre/GMsMuDzx8o1q12Hj8xOXwdE77NalZjdQgCAxKOy?=
 =?us-ascii?Q?vMhiUZAeo//FEOQ/FNrW9dUMJDyCYlyqXqI9L0fvkGcqL5+atJW1FoIpwkmL?=
 =?us-ascii?Q?iTjk18jrBYwHiub3vUHp5z/f0j3Q45Aisw2ZyjFxincfD4z+Sx3kNGKv3Xwr?=
 =?us-ascii?Q?HOm60QWUmEYe7MRAR4yiEZ71ABZvzYBDvZuO+/2P+x1dbtKoy7wOu15G0ZVD?=
 =?us-ascii?Q?btZNo40AuP6WjBUkQMarp3YmOy7kXBpYu+S2zpXD3hszA/M7M9ByuNgEAQUe?=
 =?us-ascii?Q?DR0X9p+NAdV9floxiAhahbCb0NXy+uQ+9lC6GA/Rz4o1d+VX0MfSMmEbdZS9?=
 =?us-ascii?Q?4FqJXFlWEAYMt30+6qrB/Ma5sdjf7/39uSn9B0pEWJFJWeafotVaWR8MRmB0?=
 =?us-ascii?Q?D4sIsg48WnF8ZJeTJhHLQGFxoVMYCaUP0FEo7Vqe4AfCwI0kkte3Oi6Seuxz?=
 =?us-ascii?Q?aNKWyA+fq5f6Rjmj412/8wXR+CMS7wcozINuKGJOF0AE+wyw+2nK1Th/k5MT?=
 =?us-ascii?Q?Wwih5dA+BScPFvxU1Qi7FCVSeEkGYHwzovwoUf9oDU6gUjCjQpd/NqphPCe9?=
 =?us-ascii?Q?TlH8exxvSCsa4GTJ0l4noPSERZyD43fe0qQJ0dpatntyXQKalQeUC17qTI1r?=
 =?us-ascii?Q?B+WBK2L3gMmbKoLKOM/pJGc4p3JdBVWxrhRLgJrQwsihguMjkZX1jifbnQm5?=
 =?us-ascii?Q?D9u5Vqcc4uUuq9gfNEKeRQ8C9WzXzGP6PO2mNK1ATH+67Kk7B3yGUgvSR1bJ?=
 =?us-ascii?Q?weOFCUDFJVAkQf4mZrnN24uP0vPYDbljZwvkPulduQAzz+jfHBNOhWkhH9Rz?=
 =?us-ascii?Q?TpjzOAOXs9sQo3eIvcjJJ2jrdbb9gj69X4XJPVFKQckwwWZz+5dEm1xyd2wh?=
 =?us-ascii?Q?tJeiOw76HZYqjXaKl+vAn9j0kk4L2lmQSeKTDtIbMm82C0nhCem4T0QsxffQ?=
 =?us-ascii?Q?W9VHhQ8zJXu0+Yg0UOiuIKCyoYSYYjRKSCLQyj+wtKGyyxX9bDr9fQwpTMPO?=
 =?us-ascii?Q?kPxbAFPXvCoe61UEyHQAQBx0l4m1nT6GZ1Gospnn5X518sFmgnFmuVibVgBk?=
 =?us-ascii?Q?izVGEWKdVnQ5Su+iUaMAN/6VRayPQQcwLNrYBXCR3X/MPve8bsTk+DgSp0tW?=
 =?us-ascii?Q?6u+cAna+Psi9o+uDnHqN4Km2OnHtUgzaLGno33C7hAP2ZTCJ3NFNrRypsvZv?=
 =?us-ascii?Q?XvS/Zc0Wj+C2gWcc2yXX8KTgU3CQcKxF2XHubP01sel487mpPBKpEQxzs+Tk?=
 =?us-ascii?Q?4mUwfMcjc+wcjb+qRPrc9Xd68fKC07+zMCJTTkSwP8LRD6rvz4EDR8DL2t6j?=
 =?us-ascii?Q?HWtd8ac258VF+WQIF82s5YL/BJsSmAqkISqsY75Us1k9Aw/n0vpwl3YVfu/0?=
 =?us-ascii?Q?wyy8JpibX4Z15EhI6HE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mk+II8GlOPbxLsfdzqvDDcoV6reG4Amx9JC1FVOlmFhyt7Rb18i0MsaqxHBg?=
 =?us-ascii?Q?khVDv0Gi+TTvUaPeS/aLetiwUynXBN2IlGXIwHeNywag4lVvDKbG5eCCzlmY?=
 =?us-ascii?Q?barwTCrQJu2lQIbN2Ny0LbL6gBzP2sqbyjXuIUqt+GRnyPJZcHxTTzMdSThO?=
 =?us-ascii?Q?Tt0jTKHTfdkcMPe1mxm11zJtEnBgTyUcLpkmtt9mruJZzcOuxOVybslScD16?=
 =?us-ascii?Q?nFWeCT/ttKObZuYPCf4BXvWH6xL8bM+19xSPzMsI+M4HmcT26fvjpgccAOZq?=
 =?us-ascii?Q?x+2unrHKpWsa8czQV6iWTnuQMy0ob0zu4EW8LfX9tf2t9V4VAxYWJAox1fjQ?=
 =?us-ascii?Q?120FZBtQv2fNHFkpmYfrW6e/oCphlODPFZJeu31UWJBAqN4No6P96A/Vzfab?=
 =?us-ascii?Q?ve0WA7nC4TGi+wvQDfrbkr7CDbA793UIUQb3cgoFMS0s5nCPYixzlv7Yq1Pl?=
 =?us-ascii?Q?wlCCkzv6YgEMa8NWX3P8UE9cL58puwmaPFp2InX0SMA3MSbV8sP8I8n6e0sG?=
 =?us-ascii?Q?mTgwS0hdpor41QNHXcLoNgUYiukcJem6EnyOOpWk/DoC91SVjRf6PjT26Thn?=
 =?us-ascii?Q?0pNKQBZ0crY0uBYvpO7aPh7h8m/sNPEgdyAJeFG9EUJo1z2v2esFfaKB17+/?=
 =?us-ascii?Q?3Jkr8+R3+/VD3I8sd8hohpjJtsTcDvM1K2Jo2pzSidEk6Dtl6u98k9yEPHoe?=
 =?us-ascii?Q?02O+h3WGFJEiRwCCtgGk6u+zzyDsOa2jA5Mox3Vm1CTaOln4sxTvMlmKK3T5?=
 =?us-ascii?Q?XCa9Gi5cImeR87NKWL2V64e19Af/Bp15U7UtQeGbz5ws6req5o017NBPDjf3?=
 =?us-ascii?Q?wOjavsr/KZWUOvK8fIufW3uazRBRqMIjuqiSSydKwP89NJSiKgdjNTgUX3mI?=
 =?us-ascii?Q?QAOGaO35kJJOj6pLuZSgEzpg6/35OiL89ae3WWt+YFPmHDz8T0SHbxTyf2bi?=
 =?us-ascii?Q?XOtRgYnL/Ji2PBK15gtdRqKR4bxCK7/4QB+6H9vGD48J1G0ebB+x+QfiNXRr?=
 =?us-ascii?Q?9FKOsWTs9DQK5/HvL/Y8vcZvesHWyGTYdOeoxDTvb6ZIM2YzJNbGvjJJm33E?=
 =?us-ascii?Q?G11g0FKR+IZdGKKnzob0l5wlmlYVq4Fw0RtdJI+rsI0HqUpyW/v4v5pUglex?=
 =?us-ascii?Q?DAbjfCCeawNFhyBtEWO0JYbxI1p5dLEPYpQ1S1ghHba+UWBa5lBeuo99YVZu?=
 =?us-ascii?Q?OqimYnhF/HoFp/UD0qLZjqt0IrmsIZUdAnq7pY1eVns7uYnR79IeTlJgESK4?=
 =?us-ascii?Q?HWmy1rpGmdSD1zP3BRp44scJ4jk6W7wRjJCjwWe+Fa/8+p8VLHifgZvZgmX7?=
 =?us-ascii?Q?xbAAnf6waE3O1YjPzR6647L3p6wyWLgVrP68xz+QNWc7dLW5LVIiCrj6stcx?=
 =?us-ascii?Q?/pWVeVcYwa+fC4/6N7oQ5FcROgezJqWqa5gcFAe9dlSzjt1Yud2qxOl79acQ?=
 =?us-ascii?Q?oMsmg/bBwCYikikdg72i4Wq1LXMwzgoVzol1P1cal85IJaGrkr3PcYmfMkLF?=
 =?us-ascii?Q?1vfXwZPDJkg3/5ujNtjYbAC474gNEdvEo8eECfhznZdycKs6tWcwzCKZScW4?=
 =?us-ascii?Q?i/Q0iAN0f9qv7i8jp5fkVt5uq9piuuykx60lA9x+odtneoXU2aGSFpjuvQUx?=
 =?us-ascii?Q?x3l5PGEf0kEPNm4daE8l29rsz0ADNcsQFBcsHB1VcU7yd/EzCA53yjrvZUEI?=
 =?us-ascii?Q?8Le8dJWbRMFqbBx4PWgEcBc6wzsdhxJLAxpNgY4QQS0cOfUJjPK4EC4c0jXx?=
 =?us-ascii?Q?k5zb7FkoTg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aebaa6-1ff9-49af-6eb7-08de573103fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:01:56.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I/VKXl71tByz1N0PLdAnEVN+FEV7A4CewPoV/LHNxHibidz/KYicbmjeYFYPrtC9GUF+30eQCGZF5FryDQdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7318
X-OriginatorOrg: intel.com

On Fri, Oct 17, 2025 at 01:11:42PM -0700, Ackerley Tng wrote:
> Use the filemap invalidation lock to protect the maple tree, as taking the
> lock for read when faulting in memory (for userspace or the guest) isn't
> expected to result in meaningful contention, and using a separate lock
> would add significant complexity (avoid deadlock is quite difficult).
... 
> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> +{
> +	void *entry = mtree_load(&GMEM_I(inode)->attributes, index);
> +
> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
> +}
It looks like kvm_gmem_get_attributes() is possible to be invoked outside the
protection of inode->i_mapping->invalidate_lock.

kvm_tdp_mmu_page_fault
    kvm_mmu_faultin_pfn(vcpu, fault, ACC_ALL)
        kvm_mem_is_private(kvm, fault->gfn)
            kvm_get_memory_attributes
	        kvm_gmem_get_memory_attributes
		    kvm_gmem_get_attributes

> +static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
> +{
> +	struct gmem_inode *gi = GMEM_I(inode);
> +	MA_STATE(mas, &gi->attributes, 0, (size >> PAGE_SHIFT) - 1);
> +	u64 attrs;
> +	int r;
> +
> +	inode->i_op = &kvm_gmem_iops;
> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
> +	inode->i_mode |= S_IFREG;
> +	inode->i_size = size;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +	mapping_set_inaccessible(inode->i_mapping);
> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	gi->flags = flags;
> +
> +	mt_set_external_lock(&gi->attributes,
> +			     &inode->i_mapping->invalidate_lock);
> +
But here, it's declared that mtree is protected by the invalidate_lock.

> +	/*
> +	 * Store default attributes for the entire gmem instance. Ensuring every
> +	 * index is represented in the maple tree at all times simplifies the
> +	 * conversion and merging logic.
> +	 */
> +	attrs = gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +
> +	/*
> +	 * Acquire the invalidation lock purely to make lockdep happy. There
> +	 * should be no races at this time since the inode hasn't yet been fully
> +	 * created.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +	r = mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return r;
> +}
> +

> @@ -925,13 +986,39 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
> 
>  	mpol_shared_policy_init(&gi->policy, NULL);
> 
> +	/*
> +	 * Memory attributes are protected the filemap invalidation lock, but
> +	 * the lock structure isn't available at this time.  Immediately mark
> +	 * maple tree as using external locking so that accessing the tree
> +	 * before its fully initialized results in NULL pointer dereferences
> +	 * and not more subtle bugs.
> +	 */
> +	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
And here.
>  	gi->flags = 0;
>  	return &gi->vfs_inode;
>  }

So, it's possible for kvm_mem_is_private() to access invalid mtree data and hit
the WARN_ON_ONCE() in kvm_gmem_get_attributes().

I reported a similar error in [*].

[*] https://lore.kernel.org/all/aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com
 

