Return-Path: <linux-fsdevel+bounces-52158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2203FADFF96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90C617F88C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9901266581;
	Thu, 19 Jun 2025 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvWChcS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF3219302;
	Thu, 19 Jun 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320976; cv=fail; b=AJoQQa7RyFvLpcN7f9BKyt3GO/b37OaksaUo2BvJw0NstwgoQ2quzW97sEIqcGyqsuqohKUq6o3peINguoD5KwwzXEQnE+O8aGLxJJ95ob9jUQ8zNYix+1kN9gYMyBIWkX/8FFxcTv/06ya6bfM7DX/lDCnXuulY5AJUmgqoxDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320976; c=relaxed/simple;
	bh=Cgn7OW7yUf+Am0ktUoAkzKy/E5n5e7g8XWdqZJnyVAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=efstNoaLdgmL0DV3UVP7+d8/buDd1e7e47JxlBa8zNMCB4M0DUV8G0W7/aJAvFC1lGPF4qDNJDhUCBzHqldv5OuJzSR+rz6PlZNSefnrnOWzS9Pmm3LxWcfiqbUopGOI274/x2xmV2gKr4ksgp6gnQGhN+B99ouUO9gYxd0Jvn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvWChcS4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750320974; x=1781856974;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Cgn7OW7yUf+Am0ktUoAkzKy/E5n5e7g8XWdqZJnyVAo=;
  b=RvWChcS4DyjCgwdReK1j1tAofX3+jKYVm/e5LELCTTHVYTGWS6MZlJD2
   tXJJMkSd0hVMDwqcK0swZbiuJxtCf64Lnt56T5ao5DlIrCOrpcgUFarvn
   AJprSvpMDl18/p2CWnz3AcQ046t42rIXnZcTht2dA8ahF2Efqr76waHn/
   wAKZJn6gyCuPAxXBPmkvVMh1hGRbmqRMPqM4YOeQ0Yh/BfUb/KKi6o7Iy
   N+nfDz9thRPaA0cyxNxecnlzy0WntbQbUq3pG/7tELT6amCPM79xnLBLr
   l8To+QJVQ49qAcyavHbzvfnZBhoxFyqmWC/iSFIef6zKMfYvUdiZAGoya
   w==;
X-CSE-ConnectionGUID: 7OHOFgCcReq1I7VGAFFW+w==
X-CSE-MsgGUID: 4sNBO6nzTd6I3Q3+OaWtJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52446467"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="52446467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 01:16:13 -0700
X-CSE-ConnectionGUID: s4bYcTz6QHCIhMb05qlysg==
X-CSE-MsgGUID: qDi4NkBqQKaEyk5sYmEtLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="174104621"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 01:16:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 01:16:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 01:16:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 01:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDiOJBsB6+5Vg5EpMvE3MHvd+/f1cT9+2YABKwaWZ/Ihml5Kvy8BRqJ7ms19Ugk7ch+g5TpVwCxBLj8xtmQk7XKgjQsWHoK+f1WyGcqBM77Slw8HAsiSruKkOaiojwkNACvmRfV8yAU1QnTkWSyovWSDLfqcbYa43NVAnFO6kPE3eiOpdl12zEuiBWq+tBSW3iKCMAaE4bGZBVLOrE2wyindmHp0AAGTb47zsnsV0U0gyR0P9M36qbsOcgth2udUNPYjtcTFcOp3UCk/zZMqGsOWL6PatSraIVHNzooHwJ1H4LjhannVL87n0jJhqzu3cu8A99yhMj8baP0wIsar+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INREof09M1QcFCLiWpt20R89OJ+QmqkYNWG7K9mied0=;
 b=ff0dw7EtFiEI96Wcv8kuzADkJTMM3YiMvHPVDqftiDLejXpag2JVeQQpDR76rtEtFyC6ztZ2bZCljSh3KrfcZ/YMPT6pzUt8Wt+9cvrhzrvlv+5puLqJhAxMzIEzVq0wpse7vBycXyOj9tGjyzp/B8BSrLFxesEzBXFcX/fnUCREFQY1Hc/JZBQRMqBXyz3KylAmSxfiRjRGT/gxx0PjDOJcQcdhAg9LW17rQWbMMgm2QpEROrABBPzH27clKH+nFCj3+/DyI9yI4Giu8SAXFV/X8/aecEMtMZiR6rj0H8dIVVc+7rWOFUhqSeOrZZ6D8l2Z8rCGX8S/j1P9MUMScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 08:15:58 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 08:15:58 +0000
Date: Thu, 19 Jun 2025 16:13:08 +0800
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
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: KL1PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:820:f::6) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a03caa-c809-4f9a-7f08-08ddaf098520
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/byHW1UtP9wsX2d8BLB4Vwfl3LMEvFwcNJIAm2u+65mXcFYsZXdCnF24TXR3?=
 =?us-ascii?Q?bqKMqMxJoqcgOaWeB6RY/pDZ2uFbFK8+fszQVw4884vzffgU/XLmnvTQZbij?=
 =?us-ascii?Q?R/qve6RPe7x/iRErhtRlWH3bKqS8eNjrYMQZW4Q1uFnO7LWDaJNKLoj+uW36?=
 =?us-ascii?Q?6akZsUOmZZwNRQkIF6LivdiepVOQ+P4gIJ33b9Q3f+hPtQUYmttYVNUaOprM?=
 =?us-ascii?Q?ds5m9r+FAFO0dX4D2RxMWnHXl/4otXVfcbRxhghEyiUsUdlu8VOBsnjSYV4F?=
 =?us-ascii?Q?8utGiCcu604TZgZVzpsCk18ZUNJZmCfv04y4Ne87+hc4MZiPTJXOh2YWsqpN?=
 =?us-ascii?Q?uJMxjXQh0Qd5ydD6U7wBXU9iT7lqFtx7B9rXwcbPOlTMyy+YOFk6sSt2ldyX?=
 =?us-ascii?Q?Ho9f1M3+gr4QZCSh/w4fLbnGM0D/mV9OYmHniMHHzCeARPfvDAOnjVve9cQ6?=
 =?us-ascii?Q?PjQnxq/osB8daph/1W3IiGVN4y8y2Nhu50CGz/w5eIBm0N1okdLtUSX4v1DF?=
 =?us-ascii?Q?Sm+EAKRyE8EhPmJd03TtEYZ/o1CA2px9wIZKzrYfaveJh45Bwj99yXe2mpty?=
 =?us-ascii?Q?LlPQGKticislo8J8WaXsTF7TigfB9sCAcPA6FkcrO95I6D8xI+rtKY3UFNRT?=
 =?us-ascii?Q?d7FkruvmbuYysUnW/UHvS8Os0w8q3InnDsYECGaa9MuiyRwZMejGbPdFj6Bh?=
 =?us-ascii?Q?rpY/TfnYkmjD2/a86w9MJhPcg/KqPoDsrJWbPVkCbtZFrTbvgjdJfnhCsN5b?=
 =?us-ascii?Q?RKsV5F461mT1K1/IzrlYw8ZvUohlyd/WNXRuD+1kKC7ASfVlGALd1qrbVMYG?=
 =?us-ascii?Q?sEn7HiNhdDQdHCAcMHgCyFLKfrldXISF9NjaFXw2FKIK0voKAnQ4MV90kkX3?=
 =?us-ascii?Q?ac5opPKGMsnQxA+E7fP+0i2/AsaxOhqsrcSci77jeQudM8XE3QeSI7+WNGys?=
 =?us-ascii?Q?cbvZTjIuY5TwMF57TcumxEoXUHoV0Oe27MLoYKI7BG5F5khGK+nnCqnfXml0?=
 =?us-ascii?Q?vJdUaiPPKUWU8sTAIVs3wWfMyJtw1T9dYl9mWgsSECSq5H5Uyl22SWokvCgK?=
 =?us-ascii?Q?vJnLEZBVgVH8RoJofTuUMWZ3UAXwXU90oyWyl0wf6gpkyRz1ye3UTw3HW8p7?=
 =?us-ascii?Q?pTnX5rPbDDRFGXk+/4nMcHfLLuaH15W5MpzLI4jLH+BNlIDrw+J6P/5LcUvD?=
 =?us-ascii?Q?2JI+1h8o9Jz5ygzHxqM8+xLpAxFDo2khqF9Xz0tWT8po0ZbARFhQ2QKUJed0?=
 =?us-ascii?Q?lbRuAy1vAjJ8INfAF0DQXHnD3lMnzmBnye4Km0tXjPkWL6TwooBMdf6O1Hgs?=
 =?us-ascii?Q?DGmRGTfxTYSGYumV30fEwHfTTH1kM+/SuXVQ0WLO7BsfHf/KHcm90O/VsT/P?=
 =?us-ascii?Q?RV+RKWmQ82pdQM8exx/erdGn4l5Vemq6E8Sktm1EHcJsTfsSO4WWqRf1gGSp?=
 =?us-ascii?Q?03dZdO7zkDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4c/3Zn+qF8LDoyFsHkgtSEGOjVtjtrfkh3bnI2nG5er7Q5U138etX+00cxP+?=
 =?us-ascii?Q?mxJY49Bv5tNyJwJ4Gy0tsHSj8X6qWiy4C917ERMS8rmxFP4xVKBMoaLkVRjB?=
 =?us-ascii?Q?IEJz/iy3ywqcm0kHRa2DnLFzXFGx7vQgadp5BsBysMaR3fzRMb0YppDaIB8J?=
 =?us-ascii?Q?1lQk5GDXUjJxXjpEXVNwf53EY0MoLlmIoFKTN0zPSTDz7l9LDXz0WElm8a/j?=
 =?us-ascii?Q?KpxVJU0iz4plSZUNGxoE9kv4AiYV80In1oymWgoU8Bq3X9843sUhpXWjEIw5?=
 =?us-ascii?Q?Vxy0x1fML2Cpq/pJk20oFApDMPgvh1YKIcJ8XaOGpQNo98cwXU7mbu0cOzf+?=
 =?us-ascii?Q?54WJqlc5O+ns/t9iNIr1SIpRdPdBEQOMoee0GDw799dHmE81VdJfVM4Q1/Xb?=
 =?us-ascii?Q?fIUTLwb9d8wjU9tbklRmMqsLpg0kECEAZm9jlon8Kx3CNbWyKBKS33E5y/FX?=
 =?us-ascii?Q?MdJrcLnPSmcSbAP6bvIvuXDGbmhvqYowuiLAoxqAVrAfr5s0LSZhQpJTiTuT?=
 =?us-ascii?Q?B8ELb+zAIWu5Hban7fmZwp/Q3wERD1mC3n/KwORZAnIVql3NLpp66s6jjLvB?=
 =?us-ascii?Q?UVOqVejTE3b5vyQdYcY2FDKXSZUsuEWiPVBIiRqo0T3pXM/UZzkhrdLfbQb0?=
 =?us-ascii?Q?Hgjdflhon50TBFjYu1so6nfrg8GZUmTPRFww5sHhRHcrONOKvZgqI3ikehLG?=
 =?us-ascii?Q?n9nJL0QAkK4xlUzUCFHBAMxVKBkxp0KaA9VECV0/VcFWk/r2FqXvKyt60ViE?=
 =?us-ascii?Q?24YIR0B0NpUzkmKFH21pKjK93pT7ZDlrx344BTmNlSH/6QgeT8Hb5bYVyIBl?=
 =?us-ascii?Q?GCmGUXafbIS0XW8ZaQsSmR/SvWlDvWuF9iaelqVC1RVI59GEPPYowSb0q7ot?=
 =?us-ascii?Q?ElY7ocvW5cEMzA1WjPzwviR8gpCE0wUiRqh2dBNCJxIs/bWtDbOl4cuY/ftE?=
 =?us-ascii?Q?UlJDJmX5cHiXJgKFH7tHL1Vcdx9/RoBIxXdJySXNMfShO6QjIj2XFhUPcdMc?=
 =?us-ascii?Q?+hnrGa4bLJ7M3CGUIyryW2ruEmeZ0YVSFAXZhyV0B2/1weSCdKFoVzEZQSaR?=
 =?us-ascii?Q?lHsSBk2FNoViClscb2A9XsKgkT6XTYavrjAgTKObQlOiQJEhCVNqm9EOJRyr?=
 =?us-ascii?Q?LcVSdPrvVaYZIEQj9QSf7ensEo9eLF3J8tCoaV8y15PYlkGDcqQUFthfPRZw?=
 =?us-ascii?Q?Bpm/I32a0hMQQsK3CnWtR6BAHSAjFTRvsSA42cQYXbjU9kPEYEMm/zaaIURz?=
 =?us-ascii?Q?66Qg+IpoWZwyd5PDV5T2ErKea+J0gR94a1j/M2QLGHoeh8kJHiAonuxndcSB?=
 =?us-ascii?Q?DTs6JivPzOunK/UYfJhwJXJu0TDMWhiaBORAhod2J0JnPqBABMEc/bsHxmut?=
 =?us-ascii?Q?mLKr2wojAV/d9fo0vPLGtdjhiMopKbxFwpvanzb0OD1Ex5Z8juTMV9gQ2bEZ?=
 =?us-ascii?Q?3MOWl9SrE/2d6yJ8ZrXxL5Qnt2+vvD4f5BC9O5nMku9NWFEZNG4rMLsMlaB+?=
 =?us-ascii?Q?Vj5FMIYjYGOiDL0Dy2f5hhip7kvvvxmNIiRI3hQZO+qRicB2pwhBYBIDnZD/?=
 =?us-ascii?Q?RucM0wBCrFD+d/OQEDuUo/W+ZsNOgzjaFirSVp4u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a03caa-c809-4f9a-7f08-08ddaf098520
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:15:58.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTaTnxJ+XPLuQCdzXYEM+cHEQwmt7smdydGWnZ2dXjx2UMtv8ghXSkUbIaYL9Jrlb1oj1tMKRAIRc9JLKlqM3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
> Hello,
> 
> This patchset builds upon discussion at LPC 2024 and many guest_memfd
> upstream calls to provide 1G page support for guest_memfd by taking
> pages from HugeTLB.
> 
> This patchset is based on Linux v6.15-rc6, and requires the mmap support
> for guest_memfd patchset (Thanks Fuad!) [1].
> 
> For ease of testing, this series is also available, stitched together,
> at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2
 
Just to record a found issue -- not one that must be fixed.

In TDX, the initial memory region is added as private memory during TD's build
time, with its initial content copied from source pages in shared memory.
The copy operation requires simultaneous access to both shared source memory
and private target memory.

Therefore, userspace cannot store the initial content in shared memory at the
mmap-ed VA of a guest_memfd that performs in-place conversion between shared and
private memory. This is because the guest_memfd will first unmap a PFN in shared
page tables and then check for any extra refcount held for the shared PFN before
converting it to private.

Currently, we tested the initial memory region using the in-place conversion
version of guest_memfd as backend by modifying QEMU to add an extra anonymous
backend to hold the source initial content in shared memory. The extra anonymous
backend is freed after finishing ading the initial memory region.

This issue is benign for TDX, as the initial memory region can also utilize the
traditional guest_memfd, which only allows 4KB mappings. This is acceptable for
now, as the initial memory region typically involves a small amount of memory,
and we may not enable huge pages for ranges covered by the initial memory region
in the near future.

