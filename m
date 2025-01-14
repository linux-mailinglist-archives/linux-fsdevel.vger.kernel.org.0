Return-Path: <linux-fsdevel+bounces-39106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01EA0FE68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC41169D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9A3230981;
	Tue, 14 Jan 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2NIeq9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61233596D;
	Tue, 14 Jan 2025 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820330; cv=fail; b=Kq+NoXYx+YJDFoQGbYcToEFKf795PHY//KulLsXhWtaMgCWNiJXXU0hsPcOU2iOQFMJxIDRhuYLhNJJYiIycGMCTVCQqmUvSe+QOHxhoPPTov29sNQCXdeIhghpUeAbwssHvhPb3GraA3QUvCy9pT+cYtc9luAXKo4VByDdEfgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820330; c=relaxed/simple;
	bh=4iHFmlua39Pop6qs2IjIfo/PP6Rd1K2uRIiRWqSdJhg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p3oovhFYAxHMjyvDGuGkvmkYLnwwt5IgAhPO1tRKL0iWWijWnOy2Ctbd4vPxhVbz9yxgV1BW4ZSNjeF1jaBmPRJMBotZQWoIr7OIVCCMySzENBBwi/G7gNCQNgTVQ/C+scpc4nGHCoO8KFp/lS6hpZM7QFi3CfKkCL1nIbrd9HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2NIeq9w; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736820328; x=1768356328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4iHFmlua39Pop6qs2IjIfo/PP6Rd1K2uRIiRWqSdJhg=;
  b=K2NIeq9wpq7qbK0knt0U2n6z9YeyXIhYrQFVElDD70imwPsrqsNJhVuh
   H3/Z+LfgA/mIoqqjnNpXxYYg8EF5aBj1FtRYGMHJOuk4Wb0W50x1GV+WL
   HLIao+2jtoVeohr4WkGPlbyH9VwqAYnSUuVMU5uT+uF8BKAPbcGiob26+
   7D29uxNf5GojRk9Uj/yxiyXctlO7VE710L/wX/sswK+GluU8Kmj3CFRix
   Qg3i4VEbJR7uUgoxuMVNihJgmx4aEwNyRtoHsQ5qMCcTUFBmFsPpV5+tP
   UPDnhCsgrR3ftwSnM8eeABzM08sBMK+aQHOF1b4NCVEJuOrALwYCLDtb6
   A==;
X-CSE-ConnectionGUID: nH1vIwtVTH6rB1cfTXqpHw==
X-CSE-MsgGUID: LfZwD6snTQmpIntnHV2ERQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47681568"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="47681568"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 18:05:26 -0800
X-CSE-ConnectionGUID: B2BETHLMQ3+FGc5aoO7bIw==
X-CSE-MsgGUID: Ux3Q26DMTmOf6YFB+odsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="105226518"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 18:05:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 18:05:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 18:05:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 18:05:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqx/9HGMZ8FUNCf9y41cRaJg9jEejp2f26FjYIKuB2rJuVzoACRN/16MneaxXeaSNP5osQIGWG2e3g3cNaD/gUwsmnpL3arE+DLZkesOPQmwKIndk8fDWuiFjRkficTFYtkhrjeujOucG6Q65up2IotLgzVuKaB6uBcAKom1rWZRGG0LZBIVtWFGoXRDsd4CJFsg7CqMUUvC2pbQLV0T2fzxTtves4mPJs6axe37xH/TGcNtfp+eThSlM+TMlc3tXyZtCv9M3748bkWHF3SIH6l494nSDJRRzZZn5eiiDmA5OlHQ1DNjvliZta115EOW5R6iAwJCyFHRO8MHrxKndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NEY3NWfhnrns8LRudAGMFE0YBKi6OdCt6jmummqaf8=;
 b=hOgsHRj12QE4nNikWg4sJMw02V0u3yJjt9TO7wEwuOE6+W67D3gtNxbGV0j7s5vMEZy7m+av0A7LY8w8JzEAA1qsE3xVbFNUIX/kTvtmeOoNIlRfZcROYpHVLfIbZeU2dhNEbcDiTbZeGlEAWUeEWiDEKDqZ7PaBfXzxoySTxkBaLiTETBTLL5FlylQCs8xotKz75TcRPEVyeDKpVsW8e7Sr/7r/8nowUljYk9Q7JXqDD34Iv+7lWcuqYnnK5HiguaJdoqtQ6SyV7wRmtTWTK7iS7e6DoX821xPyUEVzjl6RIlmJq1UlB9VZr0tZBSXAtiZd4anbi7LlcNC9YawYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 02:04:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 02:04:19 +0000
Date: Mon, 13 Jan 2025 18:04:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 16/26] huge_memory: Add vmf_insert_folio_pmd()
Message-ID: <6785c61e79bb5_20fa294f9@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <02216c30a733ecc84951f9aeb1130cef7497125d.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02216c30a733ecc84951f9aeb1130cef7497125d.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 515e4374-cbbe-423a-22fb-08dd343fc18e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FWd1uVY8wsDyzzVGG4bLZL3CGoUT/qcjQR9YBmfuoS2A3EPP1E/IoIg843n?=
 =?us-ascii?Q?gNSNtEivJEDZH7q9x/1L8O4jqvJdOMC6gAv/mHPIpVroVdGrHFiaK4foJm0h?=
 =?us-ascii?Q?yi/CNOsy+OSoJTNfSWMhq1nEJNgYTDp8PD9n3xkaQOpivx7pJIM+ZJeS1wBG?=
 =?us-ascii?Q?3Icl9Q987BYKLQQpZEdFEWl0+K1/1cbz6+hEb8Uj/BTI6oFDARvf91tm8hlA?=
 =?us-ascii?Q?Nb+cGX7G4cTlK/meZXpMG8c3G2JgqxsoocOGY3zZbS0MGeyxBQ+B2oPKbwu3?=
 =?us-ascii?Q?YDt84rZbO49mPCe+jjHF37axvgWY27KhTKWj0ZNtVqWJBPyUpoz9Jpbj57Mm?=
 =?us-ascii?Q?a8uO0/C4e4xB0cq6SwoBTGNsLLR7IrCNlIbo64fpCUP0gCBQK51hHe/c8bTF?=
 =?us-ascii?Q?nSIWFmt5RkyvqBzZj0dCAqSFe4Lrk/hqh2ucePH85DD9cPvzNwr5tuLtJeDk?=
 =?us-ascii?Q?aO2yHF9IXY5bOUXYfxCji8V2C+2TWWnuelALY4260a2zoI/pec+pAzHqjuET?=
 =?us-ascii?Q?cowedQvFk5wdM33kDYsC1tKE53pZFRoNhXUXyv9S/lI8O3KIHnM9MBU5wOyp?=
 =?us-ascii?Q?1PIfJaqE4EqyHiq1a5YUB/v/rGHWF5koAAk0mwIIXtLjHaG0XWN+2pJdIVVJ?=
 =?us-ascii?Q?O8iDQhNpLSA2SUIA8j7Z/pqXv1iRopX0SunbiuiY2wlH4f3l7tu9/qoX4HNW?=
 =?us-ascii?Q?K/8IJAV7mkbqCkxa+9p/WlQjy2TJmA4MzVkz6/NKQ/rCLClGUlcNPLj6Qprw?=
 =?us-ascii?Q?34bSGdqgbIWRMcWoGvXoZJYl9y2s67MjwzObP9kMi0+yiTHWaqDCUC9qAlJB?=
 =?us-ascii?Q?g9vEpPmuQDzooOjNmxXXExpTDo+nqLW4cWSAljPorNFzRCLrVsZb4ikz31SU?=
 =?us-ascii?Q?xGZmBKjCP3YPovd0196An8uY6MqWjVJjpSN/l6hXx9kO38Q8rVJAsRfupEZc?=
 =?us-ascii?Q?5ZyJ4Xf+mq/X8wZHJBJfZSAotm3BLtyWjDVsmyF9J4+SL1nyL+5LrQnRod3b?=
 =?us-ascii?Q?zkUEoDMLsDA35NRGWudvf1tPRpiginCdw+UPejul2X8Qp+B1Bl+4hAx1zNbu?=
 =?us-ascii?Q?o4Zvm5Pf1CknfJECzElJ94HsDtp6UMEqwmRB/fDDP29P/KYuG7SGVTTXJWvu?=
 =?us-ascii?Q?bnj69wcSgNTzZHb5OVYWB+hjLdGgPafNo+MSscee5Z6f/iTpe0isrdC9h5z9?=
 =?us-ascii?Q?2++p8q3dY+wKR2oSSDgFBiY0st8kgvB/Dp1Nc1hJfscYjrBgXdCK+5RJNeQX?=
 =?us-ascii?Q?ePwEDAnzFLc3+NyQiZL814Zwj7CdH5K2XAmYJrEB2rXxaymHUcdu/dfZ3AL+?=
 =?us-ascii?Q?Hp4wnLzfn0YB6c6VDwx8Z1lSZXQZIqjq6qD2dzJnNhcmgZ+8XgWL/2GgILv1?=
 =?us-ascii?Q?ZG0ony0vtWlYwLcOt+knGK4uARvy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyJwgWVDdUUmpVLs7IQR/ZGD6Ryy6zAgmctZxPYQEKVYOz6mhpEg0ma5CC0D?=
 =?us-ascii?Q?j1hwBcorttqENBwWkWbZcycwi72iYsjE+wEwDV6EFeDEz6hbVc6MDKCHW1Hd?=
 =?us-ascii?Q?aoa9vbkHazLIa+HohFha+tvzUySKOXoIUQbA7pDZMj/2CQ/NfxC807/GZD1n?=
 =?us-ascii?Q?nBlyafBhm4/R/JZOGCP30aBPKKwBoqOXbUn6sNBY+aSfyMp/nhitD8dkbHis?=
 =?us-ascii?Q?sgVpeH8Vwtb6U+Qwj1zvfMvtT0ZSZywYHjhsHe+qMnIy11nlN1SKLaQtZ6Hp?=
 =?us-ascii?Q?mOACl5cY3slMJZQHu5vgNEA5i+15cqN3tb/sRx2MubmOYOQ8YjO6WEmQVG/a?=
 =?us-ascii?Q?uQM1d7Ef237anFKxDMqMWw5+PGXbGbSJZlY37I4PwmBWnmI4pOJoc/I/MWHU?=
 =?us-ascii?Q?g1BYS5MHiWorh2VB4FkG346mgAjyZ+hePtZDZntLPMl4XiHce0w59tCDsNUq?=
 =?us-ascii?Q?tRU4w1z44BfPmOXV/nZlURPSlG/R7nZ5AcvmHSflDg2Xv2Y8aevjUUXIovYF?=
 =?us-ascii?Q?KEqXmpJUEulAczRyHUxn5gRZOr5TmniIBlHo/JD39uOI2SWakEBRSnNt2QrI?=
 =?us-ascii?Q?ZytPzQQAGAyKkgj/HB9bvtyqe/tqV+kvVW8ERvbk4tVNqYIgccE/biw9iouS?=
 =?us-ascii?Q?88N7qqS377LUnAKAlKREgrTRWAUW4NlgAP5GdFOwvZZDQsqVEfmiKRwT2dyi?=
 =?us-ascii?Q?3Hhmc4qXFzULSJjE77RPUlC4WHxOTBOuqDselwr37//oIqnAqQYfUrbXtfIJ?=
 =?us-ascii?Q?oNLmqk4QbcQM/7qSlcIHkDvU8yIbMKFJJY+XPjMPxGE0v449eLD4gfWe14zO?=
 =?us-ascii?Q?1XRfucYh7q+i0x+j7H1MJ/QoUlyfnquGN7cQTpgKIS9I7ecdvt99gGakq4y6?=
 =?us-ascii?Q?5un4SvfRDnxtlzZLrUtDxgtBitoHoLkBiBz8yg+q90ALl+i+4awaJhxSk37T?=
 =?us-ascii?Q?LzyClImWj07nwQfZXDHSO/+deNQFLBQ2BVqrt+Mkuo4gXuKUuGxua+mcPvx2?=
 =?us-ascii?Q?0F6hLWYkJm2+226tDdOFljsLvu7PA3fBAVuKwAVz0G3NcNnOePHHMXu5gZw1?=
 =?us-ascii?Q?cwcxPB9Wy93X19W2B73GDfdETV4o2FZXRwrOLH/IBR0g81JQ4veHaF0s6UpE?=
 =?us-ascii?Q?piAsQIcZStfmiA/JOPqREckyMu3qKmfz7q8UP33PSbgUJ/0gGb6+bC52BwUD?=
 =?us-ascii?Q?/rrNc+vqujkrXG5dV0RipWY4uFGQ4ClfRxv7vKnbBum6YkRN+Bf4/cZnOvya?=
 =?us-ascii?Q?nVYPaNYLm981yTB70cfHGNyNoxL9MZpQG4kAtrecws4Jo+pqDNFsaZmYFMHf?=
 =?us-ascii?Q?3GVSouUG0GRxqS1Ak93WY5IL5hI/yQvE98W7f5NQ0wM+xGoFrB2w4IfQPw2u?=
 =?us-ascii?Q?z6IJtmgM5KFt0DcEUuUTbAJXIBNIZSXto/rvrgBVvyTi0BGpaY42HmItpu/l?=
 =?us-ascii?Q?SBjZQAvU43p5NZp6/g1XNrnR6msLBZbEz/prYE6VOGo81LBvuU9tGpxHDlMQ?=
 =?us-ascii?Q?ckrBoaId162K+spFtKpr+5ZBXXsCfMCXBbxARwAuqJhGOEvfA7HHMJhLQXP2?=
 =?us-ascii?Q?SP2Awb/j0/fVvd+HVSG8KujKMARnL0HaeLFflIX3v0ekEbdvQoBsWFE1rJVc?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 515e4374-cbbe-423a-22fb-08dd343fc18e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:04:19.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQszmjVNr7m1aLdBg51qUXMa7Z5cqLw1UNFkN5swqnlE3N6XeiAzIbbwnQTECX63RaaxtczsyLVlFBEeWIQcrMPL/8QK35ZmPJOieY/UtzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Currently DAX folio/page reference counts are managed differently to
> normal pages. To allow these to be managed the same as normal pages
> introduce vmf_insert_folio_pmd. This will map the entire PMD-sized folio
> and take references as it would for a normally mapped page.
> 
> This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
> simply inserts a special devmap PMD entry into the page table without
> holding a reference to the page for the mapping.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v5:
>  - Minor code cleanup suggested by David
> ---
>  include/linux/huge_mm.h |  1 +-
>  mm/huge_memory.c        | 54 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 5bd1ff7..3633bd3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  
>  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> +vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write);
>  vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
>  
>  enum transparent_hugepage_flag {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 256adc3..d1ea76e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1381,14 +1381,12 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	pmd_t entry;
> -	spinlock_t *ptl;
>  
> -	ptl = pmd_lock(mm, pmd);

Apply this comment to the previous patch too, but I think this would be
more self-documenting as:

   lockdep_assert_held(pmd_lock(mm, pmd));

...to make it clear in this diff and into the future what the locking
constraints of this function are.

After that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

