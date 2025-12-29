Return-Path: <linux-fsdevel+bounces-72152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F9CE619E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 08:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B6A0300CB9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C82F39B4;
	Mon, 29 Dec 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7ceF+F3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493202E091B;
	Mon, 29 Dec 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992532; cv=fail; b=up/Gzj/dngROb6w5sehMeykOCyK/hGEEI++YQ3RW+2sHjE/fryUUtNw7YqS9q86WJvwqUUY2QTGD4F7ZF8YRHdbpIvvhqDAQOCl2+ldfg0fOs64+xcULic4z9Ro2PXBSNVgSC82KQqTduoC5/eW84gRCqFnklM2r0nbfqrbWxPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992532; c=relaxed/simple;
	bh=gxgra3WWqGd/qDa2IaZhe/bkonVAup2E0j8BDMpBKCI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=COLCIo6qkw+6urG90z8qXXzgNE3HiVWthdUaQpYuzF98NaU5gxEIfl/4JMpf7LUbOT7jGwO0B+pByZtoyUC8/Ec+osWTFooWUXkFiVXXa8RPKMH2UtxZKW5QK7TL/fIBm8R96j4jb8kYpUzqDnjaWHq/GCcF2rXe5IMXQrQNyAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7ceF+F3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766992529; x=1798528529;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=gxgra3WWqGd/qDa2IaZhe/bkonVAup2E0j8BDMpBKCI=;
  b=k7ceF+F3PIml91dXboqihf0oFhtObADm3Fn//MErMsSkhnaqoFvQHHCv
   jgIKk5oTNxzYXDtDknWAxLFWU9MWQaJQBngeiEplHDUxOdENYAtxtKUlP
   9/UGg/dW4WbzJCu76P0eYBxXR8S+wulomrxLvSgktHCqMMhyG7GJd8dGF
   z8ATzvuEV7Cj/QVcgAWNzPtjZ3qDaR0X06BptAi34twjQIcR8g0lyuRfw
   +2qA9+VjXvfgcXnCyC3EsPsh7LxrKVp7m6ZXlAH84zxJUdhtvgKttKgp0
   sdjYyxLi9uB7NtfKigjZbjcAymbf+NUasqJd7voU3OVy2sej8scaQ2Z0t
   A==;
X-CSE-ConnectionGUID: pIu15IV+Txmx5Dz48ttgwQ==
X-CSE-MsgGUID: QGAQ+p0AT3+neVocy76/ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="80055712"
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="80055712"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 23:15:28 -0800
X-CSE-ConnectionGUID: p+ejvzfmRi+q1CEtU5iusw==
X-CSE-MsgGUID: 5Pswykw8QtOUchvKtembUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="199990350"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 23:15:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 28 Dec 2025 23:15:27 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 28 Dec 2025 23:15:27 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 28 Dec 2025 23:15:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBSDNlKYShLwjfH7hWtdpyGkYwCnBQ+HtctB0xFNzftu3yQ5OiQIaLxrLHjgCp8Qn/L5MzoOzux4YlMlKBwt8X+35l7Paa1niz5mzuenOMsldIC+U+VaIaEgZuI98X/X6KmXDVa0zrImM9j3lwjYBxuRzY+o2bM1rvmfg0oyUpPYf8atqyWqcZQLJ/d0kqhVMyVhXmkQHGVv9m+EJlCJFW5uDG2Et4pOkS11jy+E3Tn6PDE+Ny2SgRIVfJjf4g6EmHQo7JXtenGcLS+/sSkKI9YBoW3+RbRZcLFkrJWhjkjoKzu81IpcgZwFaR7wiuBqASJK7LBlRdnF1T8qU4rntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqpKnKFxt3qAfiNmYZg4IpEdUz502OweBmcGdGEuWgc=;
 b=Sk5Zn9axLfcr9yzhihvsWGgywVOihJLy22BblgOnN8Km5qNVN0FzzJo7qI6RhkGdsnhj3vfILfaagtEhx5fzuHUpOouaoMBVBDRMgJWoutHn3y/KBY/OoBap4YaJZmieLL4fJldeKIaS11FaEvKdHKx+hiPMyuHw4Va6eObRaITouMm0sf6YzAWOfFWhY70O+iSTBVs4+HaHtzIvagOMZsjnDKXcCGJWTKD7roYyT/dhcIQny9IiDp4Fqt6O4LbeTNkTqmEUAFBGBEmOgTQeo8w6yZ/piI+Y+Svq4Llr8OBOB/JrHn5jRhg1vvb+hgcxHWhcm0EL7rP4vHIiYAkJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 07:15:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 07:15:24 +0000
Date: Mon, 29 Dec 2025 15:15:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vitaliy Filippov <vitalifster@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, Vitaliy Filippov <vitalifster@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write
 restrictions
Message-ID: <202512291503.11709b09-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224115312.27036-1-vitalifster@gmail.com>
X-ClientProxiedBy: KUZPR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de545e2-c51c-464b-6263-08de46aa0932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NqCCQ9ISJh1gbAsZPL3k92wXTR2hU+UdpVJcdN5N5jnDi2Fx918Bw87MfjP4?=
 =?us-ascii?Q?jitFrBaRGhpQqr1hgDLK6vvgud82EL3eyji6Mk8zg+BEJNhfbWQDXYvw4GIj?=
 =?us-ascii?Q?57VorBLAAh64l11My2iLNQo+mbWp5+OQ+7NQzfXanjrAOOt4x7Wsx54L8ULW?=
 =?us-ascii?Q?5TK60PTDOejlUHRApG+6Xph2xGEHSqSOsAUeNyC7vSUd98HYspqv5Q4/de4q?=
 =?us-ascii?Q?QMgQAKRq1lgn5wkwGRYysO1nlhdEh0Vouwa25l6PsSg8QssJMTd81h0Pu7Lg?=
 =?us-ascii?Q?RWP0z8YMD9VTdo5ltdBDd4/fVo4yE5yGndYwvt2Gm5UFkCJGomQnx83pmeQT?=
 =?us-ascii?Q?4GWTqErp7G8LfoUQDsTAiDdtpRr+iTZy1gY9uLzmwmeMxY36BYhtybBEEzpk?=
 =?us-ascii?Q?UQ6BfLvWy74AmCRCw3kk9tlSaEdcV1a+UmX/pObuxvffNE29T0cz066IghVo?=
 =?us-ascii?Q?p37yk+kLuRq2kRfiLgAvcnwZRNonvPDbZ1jpziu4LkI/1BCYkFaVEd3aOb2p?=
 =?us-ascii?Q?fFpG/wAFX4zaSRmrxhC7fL4xsF7BjyvzBfe0TVS22vQX6sNYOylRcf2ZCl6Z?=
 =?us-ascii?Q?3tw0scFGOv4bcumJQFOrrH9zaoRfJ+AXyPq8LITXtKPP5sNdsKwLRPaLqqUu?=
 =?us-ascii?Q?pruuFofU0MdVIWX4KwNE5f7Zb80h3ROPHxuQPHz4v47XzUfZcKfIEDI9ul7M?=
 =?us-ascii?Q?on5CRtzmBLTc5Sdj+kbBvC3acUWzu9ccd0B+x4+NQ4SCuZX2qyf1h9tWWhU0?=
 =?us-ascii?Q?G1FD9Sl0L4QRzwDN6fXLnqWt9FjRcPwSkzaKr7VRbryE93u6nFV4ymGwjRft?=
 =?us-ascii?Q?RFRJlJ1Gdpo/0GMjh+jTiz9I9mSIs4dwq1O18Gr2XrGrpEk4otzypNXx48gK?=
 =?us-ascii?Q?FgtNXO3qHI+0CGCHzjIuhtD6/8DpJkibzKrw9zOb4KRVTizJRwckUGuh0fzh?=
 =?us-ascii?Q?uyWh2vbwpKYaJhIsK19mkvoZoIq2IGPYt3CReFdIgP+K6IpRimrvq/3EAD3G?=
 =?us-ascii?Q?35CFN0HNaLkV5MTIMF7nicNtypF6FoOmMChEn/rF8LnX0tV0zn5XkxOab6IZ?=
 =?us-ascii?Q?dsoISuq7MbNev+2JK7GVKrdIfy/2SPvEv5DoVCsaDvfF19ryVgES3tNpd4M6?=
 =?us-ascii?Q?rQMfhIQkWixI0vtmN/Thlwfk7sbQqI0O1+QidEOZxHzsO2z9YdPoi3k6OB5p?=
 =?us-ascii?Q?pitZYiZLX2m7cuV3jeDE7Uqfsti+YYkS4PrHi/GwFKMw3imPF2YFIeXdBYaf?=
 =?us-ascii?Q?tOCa4moRpfwt/PuIvTvDs2MAg/s33qLX32UM6GkAYQ3azNup0Kdsj6qC/yFd?=
 =?us-ascii?Q?q9oyRAwcA5b2wL6AwxaHPV3l7HvjU3JmFfNrF5gbIjmwV4Gk3qNyBQWE4FFo?=
 =?us-ascii?Q?3sUKSuHp+GHGofZ9e+mCFitx/BOBG/aCpfbVpMD+ra1Y3qO1eveGDbBgfqEB?=
 =?us-ascii?Q?F+JYA6MHA0Lji6RlcFn3OMljH/FFm12dIkQpH8DYWNqJQCeeHbdEbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KnylMxVWo9NzzU72cdBwUb6YMk3NbX9dQqecTVHiun6biC6FhgyMnjeJ3jDm?=
 =?us-ascii?Q?xYZL9Ka3QooNVuGVLGeF+ANzgCjD5gVV7gzOwoxH2jZQL74YbnaVn7akoqh5?=
 =?us-ascii?Q?gKyBPM8V3w9pdzk1Q709O1Evap5BiP2KDVCqJvmMjFJ9bNZQANLj3jZKcyRa?=
 =?us-ascii?Q?bYIxOBLfk8JsrN1TO7MTAoNJdVeniPkgu4n6UBax3ibyhkWufs6TQPK6wnOL?=
 =?us-ascii?Q?b0hKUrkHIBhuy7PogTMJQpFn/rQ72TqlYF5wuydIPkigobJsAL2w/9Z9d7fg?=
 =?us-ascii?Q?UKDbv8E6Ewgp/RlfSuVL+u/VqJLjLvKDyNtQU3yr51+zdDN8U6fBOpyAEqOc?=
 =?us-ascii?Q?SkPXLO/6D9Rlzso4kHgbUz9ecnGx3az/JpSUccMMe7LLnbV0GJcvw//FCp0M?=
 =?us-ascii?Q?mralhxgWL0RI8HQZAV9RdRhCybjpDsG+P+ENiC8uQ8YZBGk6YOERqpO+HMn/?=
 =?us-ascii?Q?Wp2WMmqJZudDZxEq7JTw2mHEhuUxhLF4MlDaCmYuaKplwCJ3BwUBoLBtrI+C?=
 =?us-ascii?Q?5WQg2JSntDXS0SuwVxZinIM05ivGIoUTikM4WQGMxj/397vT25F2fJAf7WDK?=
 =?us-ascii?Q?IWdUN0HdDdDG/NUqUtkd6+HzFL0iD+ivEQEC1/mBkyiCJaYFKnurbhyHQXA3?=
 =?us-ascii?Q?NviXZI5+Lth4gDluKXmp3DYpR4TVchz4VcUeunLBGkewIenZoast7hwwdR3i?=
 =?us-ascii?Q?yMZv72U6rKzoP3gw01c93KNFzV3vqQPI/pbzBaQUuz7/FIO+w372O6zZtF++?=
 =?us-ascii?Q?HxVQukPkFUPmxji+xml2Bp7hUApEPm/ks8mTk0VBmFbCvWG2rsYj35BWIWyn?=
 =?us-ascii?Q?rkElKYAz9IL4UKxu4ugj/hS7y5LWAerYo/ALGgAAiNaxBfk1prDjRAJSpjrr?=
 =?us-ascii?Q?24AjllGcZYygsT4iEfesdhrh0yw2WyLtAdmKI5dMaTnkMUeWtvrHESPvS3BW?=
 =?us-ascii?Q?QnRtrcTttAZTHLHbyw+H4GYy3nsnsoqqd0pHslUwGF96kQbmOXPEhw/XRR3n?=
 =?us-ascii?Q?fY1ETtU7HKrGFu9mVHSrvFH1EsSRA8JDjI3kZU3vT+kptGFdsotbFqea4kGE?=
 =?us-ascii?Q?9mKcVuCIHck5+/sO+k2UMbqslXU1DU8rAi1c30AyZHPLElnZ3LhyLlbzxPKH?=
 =?us-ascii?Q?bck34qvCOUBmPuHozjyoFH5bPWsxF36ceFYbiHzq4O2gO7HAtYS5iBVGtQ2z?=
 =?us-ascii?Q?NQCdCLQBtEcciXttwzzEKpMvSzBZIZFHsH76PTMRGxdf32q+1Ow94sCSgf9v?=
 =?us-ascii?Q?1gkruj1mCFx9p3opp0zjW9FUCq9DjZNJXABMl+z0zyURK/5ctyz7io6O2oxp?=
 =?us-ascii?Q?POOSNawoBtemSjFgOYEAhrtsLS/LuiYYUMWZjfA1VR+mujqPCdvwHmhAm4id?=
 =?us-ascii?Q?MQ4sxaCd/M9/g5oWUpN+aPir0GgOqcTzI6jJOcXj9deThAVWabTm0GQOX54N?=
 =?us-ascii?Q?LrYo/pC7k8Q9BN3kn2rzYhcRgECcEwwkRMf/8ENVY6nAWHCEP8HiRK973Ddo?=
 =?us-ascii?Q?TI6ARVVaWEiYNv1XENC9fsAihWO4dUnHV2swidzSVumy2Q7JzHtxvcS6rON8?=
 =?us-ascii?Q?AQTIPollMm3gIVCsi1MagiMielwPGpNAMxQ6sw7/NJyv/45OeYsju0hPUrBS?=
 =?us-ascii?Q?5kh2AYEcY/5O2fjE6rikDA+zXLDHMjNmbgw75CkfSvdDKfD7xwIWBJAnvv70?=
 =?us-ascii?Q?EwZ7IxyonRgSyJWKJ6zTrqNhdeXbm8d6LDCXL/HV0Va0BqbP21wMqUbkiwVY?=
 =?us-ascii?Q?mo9d+sZDbA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de545e2-c51c-464b-6263-08de46aa0932
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 07:15:24.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsRwErINI8Vti2dxYIL2v2wHVlZKu92AxFi+aLAgAk5ryoLlwv+akcvNA/rV5hD0XzBnNfdK3GMTf+E5VaD9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.767.fail" on:

commit: b493223bbb16c8b00af5ba371d8bb2ca56506527 ("[PATCH] fs: remove power of 2 and length boundary atomic write restrictions")
url: https://github.com/intel-lab-lkp/linux/commits/Vitaliy-Filippov/fs-remove-power-of-2-and-length-boundary-atomic-write-restrictions/20251224-195553
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20251224115312.27036-1-vitalifster@gmail.com/
patch subject: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions

in testcase: xfstests
version: xfstests-x86_64-a668057f-1_20251209
with following parameters:

	disk: 4HDD
	fs: xfs
	test: generic-767


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512291503.11709b09-lkp@intel.com

2025-12-26 12:13:54 cd /lkp/benchmarks/xfstests
2025-12-26 12:13:54 export TEST_DIR=/fs/sda1
2025-12-26 12:13:54 export TEST_DEV=/dev/sda1
2025-12-26 12:13:54 export FSTYP=xfs
2025-12-26 12:13:54 export SCRATCH_MNT=/fs/scratch
2025-12-26 12:13:54 mkdir /fs/scratch -p
2025-12-26 12:13:54 export SCRATCH_DEV=/dev/sda4
2025-12-26 12:13:55 export SCRATCH_LOGDEV=/dev/sda2
meta-data=/dev/sda1              isize=512    agcount=4, agsize=13107200 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=0   metadir=0
data     =                       bsize=4096   blocks=52428800, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
log      =internal log           bsize=4096   blocks=25600, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
         =                       rgcount=0    rgsize=0 extents
2025-12-26 12:13:55 export MKFS_OPTIONS=-mreflink=1
2025-12-26 12:13:55 echo generic/767
2025-12-26 12:13:55 ./check generic/767
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.19.0-rc1-00037-gb493223bbb16 #1 SMP PREEMPT_DYNAMIC Fri Dec 26 19:51:19 CST 2025
MKFS_OPTIONS  -- -f -mreflink=1 /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

generic/767        - output mismatch (see /lkp/benchmarks/xfstests/results//generic/767.out.bad)
    --- tests/generic/767.out	2025-12-09 15:20:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/767.out.bad	2025-12-26 12:14:08.927883699 +0000
    @@ -6,5 +6,4 @@
     one EOPNOTSUPP for buffered atomic
     pwrite: Operation not supported
     one EINVAL for unaligned directio
    -pwrite: Invalid argument
     Silence is golden
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/767.out /lkp/benchmarks/xfstests/results//generic/767.out.bad'  to see the entire diff)
Ran: generic/767
Failures: generic/767
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251229/202512291503.11709b09-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


