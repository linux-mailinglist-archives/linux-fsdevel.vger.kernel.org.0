Return-Path: <linux-fsdevel+bounces-74587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847FD3C20E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62BDC3A8F7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2873C0083;
	Tue, 20 Jan 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXJrhzii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABCF3B961E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896490; cv=fail; b=HveazNuHURXjv5X0BGrcq89lI+AmAobsLzzaW1tC24/U+1JKkAgFUvBJ9vIlP5ZHskEGxy3H12TgvrMDismOMuIys0EMkroMqu0wRxWwrgJGxv15OidvQpDzdjs7qW7N0lEUMdlIqufpOnBrNAhmLQKJEgPcRjeHRX/0uBo245s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896490; c=relaxed/simple;
	bh=SvInW1cQioXLNUPWbJK8NSmcDfZOM3RGmb35XYA/mVM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Uvk7Oe+y5L/LueYuNf3JfRFPrc/xwuzismXjqnwt/CBfpo2iMzuuZLWgjHFxLkW5/vt7QrpuoiB+dk9HPhTpqK9Yrq2sRMFRvmSl5Lfp5lf/Lk4VCRjsGuokrISjHE8MyUCEFf1L+S3GTzbb6gjaUXWI+F0JoapiGWwJOpqHAyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXJrhzii; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768896489; x=1800432489;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=SvInW1cQioXLNUPWbJK8NSmcDfZOM3RGmb35XYA/mVM=;
  b=cXJrhziiDSoYU4/troaptlwDz6dzQshj+8N9s/wgm1kkwm4mvUJasNYe
   ubu+U/xYsnlhFNbu7ps/EdTTe7g0sKQjOr8uFd4GOEaznRa0LPv6u2k1z
   O2BbBmhRil56cpaw/OxVykKrnXft9qKWktrfvjY+won2aAsfN3eeYiI2p
   ANK8nY+kA/oNi+dAi2M5alcRbDP2fGr3W9YLx1YSRtJBwsADrUhjncCrY
   ykDwLIFlHj5/HFYg+PnCysoJvGd88KkIt/NK9Lhti8LFlV+jsCuu3Huen
   RKbcROrpwEWXoNHyIzmsq4YcFbbYKngA6JpLM4Z2Qrz4a/s7mwKtGCilZ
   g==;
X-CSE-ConnectionGUID: bnJ8r71oSimb2KhWXnNQ7Q==
X-CSE-MsgGUID: Bp2vudOXQ36bRJlIHLDSuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="92762338"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="92762338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:08:08 -0800
X-CSE-ConnectionGUID: x2Cj/xMERrWvl0mXONwS7g==
X-CSE-MsgGUID: 4jtdHwLFQ9K+E2eIoa/Ftg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210901263"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:08:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 00:08:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 00:08:07 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 00:08:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4Ylr2bmyD2POfj76GfJUv/3yosL5Oqj6b8cSreXsaCJqO460q4CYlNwJJ6DNy2bAe6pZhMURyRr+ph9q68YZ0yNkIAjGdALvfDkVQVCznwVNGKzq0GKAsb2I2zF7c2OhJpX1YbH8IP0bDFGerXiB0Kn9qE37vyyZN/e7rb7GXwv0SpIsaPhTSdeH3PTmAnLvThwg+cURZ8mKy7fMK3ItTjLOuR0UUWWOzTlPVa7te3FqOiAXZMhP7xwG1orCVK30bVT8yvGCeWtIJru67Fyb8KTQEOIAnyxxW9S9ONxzURviDy9YBaMlFgVwx9yRxSazVFfADjgKQcol73o/EZ1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Siosk47MJPu6oIICWvT16gPqiSJLH+eX51ZoJK5zKyc=;
 b=cfhn/6MX9q76tpdpGL6nyN95G+ZcYb54VjjBau5jYXTNp2vWztY3bB8mSaz8KL9PpB63KUB8kWZA6Muzxshsd1t0xLjjP84M0HjuF/Z93brhYltGeeprWmS6CoZpACzwdfKCvlWZ1aUQba9eiMWiXzBDSas4lDygMQ6Sryxl+ysfrpBlbu37EIgMlRHpmj0s3E4EjbHSNdbXkvJo4HFgINRqkXfYu401aGUQJCx3/H40Ywg4DPkhgDH20pirFD0CN7g5C/YMiCTHkexr9wHdrWaXzYKwEYx/sERcF15Ysyepu7C7cfiaiYkM+XtDuhjG+rGxPIbRGsG+u5rWMN+QZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:07:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 08:07:58 +0000
Date: Tue, 20 Jan 2026 16:07:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [viro-vfs:v4.filename] [struct filename]  2a0db5f765:
 xfstests.ext4.019.fail
Message-ID: <202601201519.c7003e60-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 5833ae46-c5b5-4c25-7277-08de57fb060b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrYmpleWWNdwYxviah18ZJbtKSsp5UcUhkHswNO7rtrcEIIEgYi46jHBjpp0?=
 =?us-ascii?Q?VU59av8dr66pJMurPNGj0aPflThYQve/CGE8Sa+VsDA6UnWW2Op/2xBuOukK?=
 =?us-ascii?Q?LvMnTpULrXJuIHPnKoAvuZ5YqUubupkURzXac8XZcFyKlM/wlka8wyzyJOgs?=
 =?us-ascii?Q?40rJUVUZ7gg+s2YGzrXV9pqhNvxzJC+mKbVYCCs1rLYIYxTkX00PhvUy013h?=
 =?us-ascii?Q?exLdKrSpXKd7azxiCQaSDiU9+JtZ+eb8gpwv8NKtUD3j5G0MTHfRtiA0pIjT?=
 =?us-ascii?Q?QmruBTE07cQ5SrO9G9hkObyVvkLvrKCkqSwZZd2JNl3/Lomx3rTlwrUq3eg/?=
 =?us-ascii?Q?vmR6Wp+xC25xRWXuby0gzy5Kr0lFePBDdXjxLxS+pMZ6ozMLFObG7RIr+1Rr?=
 =?us-ascii?Q?8Ak6v97i1jC7V5wVKGcd+80rhp0B94DIcLGdioU4SChe7H5D7fzMlfuHbt0m?=
 =?us-ascii?Q?rNskhI+ZAAQ3hcL/Do4j58ZjWtzXN3fbjqqwJgdlYIO7zD8W5N0r3quvD/w3?=
 =?us-ascii?Q?LrFGxqKu9TgSCY5DiHG7Q/O3hJ0rlxocS8OG/jULEhd5+GShpqZvAM3hIOFv?=
 =?us-ascii?Q?H/Ys6nI2Y4C2nM4tJvf5LPlPO9yT2+BIm1a4wovN9BYH9Jp4UL4V/1lx7UnE?=
 =?us-ascii?Q?rWtrMNmRk+aBCugVfn/3W0wcnj0lPjxHHs9d7E9PDzfgsVERDU+ToNaAyBAb?=
 =?us-ascii?Q?0XgmIHcuADtRmCCoK0xtlouljWYkczXp03oyPp02cxJrzZt1CeZCYqdZkCox?=
 =?us-ascii?Q?i8LcbecsGo4h4lVpIAWDqMiSJcRxensSUgHE61u5OBSrMq/Sp04Q7o78nkmJ?=
 =?us-ascii?Q?ibRjjxD5oDTe65ipXiPCQZJGMFDdsIGDf2ZBzqa/dNwKwxNEatsgR6biIOxf?=
 =?us-ascii?Q?Mn9lJNNvIYg+2qCtt/gf4UDFMpn3iY7VDf8SFqnzUVk8R8zSI1/EVm0xo0Vw?=
 =?us-ascii?Q?7LuoWWznIvgA27tICbrE/LAA96c0jyAzWzuHBsZZGQxkMceJQJozX5SskmUM?=
 =?us-ascii?Q?h2dveBaTH9JntLIUfc7XI4uUlzSNV+vIpiRXBNHU43lz6HxyZhzKgB0L4vZL?=
 =?us-ascii?Q?jC6HWog4gN4mKDyLtWSGMgrwhCzSD5BEbcFK/J640V75yJLxDi7V97K0Y5UN?=
 =?us-ascii?Q?YwxtblwF0oYiKTb7EhxzcdZ+x/poRcTpwR3S1/zoJrnaOmhI2fNm9nsWVUO9?=
 =?us-ascii?Q?1izqCD81IKuxvvapDalKcvgLv0prn/HyDRdRUqp9fQlPo4e8/E4qxYAzPQfc?=
 =?us-ascii?Q?fFS/vq9xx3uTIuIniBudpiEiAHxGrcmmzf58DhLzcmn/31mKfsSc96RxDmLC?=
 =?us-ascii?Q?9PLRMRebiA2yN6koYJgCdOs8lbZ5GMhb/5fXEBPvqYf27TBSMKI/OBzOp3SL?=
 =?us-ascii?Q?2TeBX9cDhqHkYEmaJvv5uCXRLmvrMyv5J3xRmm8qKFrCSbmK/DbQrldgXCp+?=
 =?us-ascii?Q?OkLqlhWOWwOhp4pGtiDAuRJw+cY7UVI8QblkZ1+t4hQSr34vyHcr0pa0B7UP?=
 =?us-ascii?Q?Rx+rUkfBVF93Jpt3LJ+wZuMMJOoO8xpvbCUcjWlNIFbi17yC6IQCB1kSHStP?=
 =?us-ascii?Q?5Gif3HwmmZQ6qblMb+GUoMGH+HS4h8Q7BMt6whuQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4HMvBXzvZl0U3So773S6VxvtGfj064cU1G5+o7S309L9R4KMcbQywH/NuuLd?=
 =?us-ascii?Q?d9D8wRuqtZ+VGCbYJd/B+TLgVHMbqZKoTeaAcZPJAmbE7az4Ryqhh/zvS23T?=
 =?us-ascii?Q?zryp/ipRZHS2kUyfs0o04u6bOM1Apmz8zQ1v2X4KQ7/Qi19vwApXwNjYHYgZ?=
 =?us-ascii?Q?XpzAio32c1/rwok/fyRjO7GgNvuTcA+Q9Ilgx+Dhjvohc2wFkDzlNKjQ2vh2?=
 =?us-ascii?Q?6/w3xv4Kf7Ey0TqESbI+EuRPfqjSlecnV6/yzcjYdrLYjNXoeJ/81P5etTlo?=
 =?us-ascii?Q?oG1g90C53ahVvoygYZfx8zsr+85kUse3EcVZqwelgvpZb2/RGtVLE7Adx60G?=
 =?us-ascii?Q?0DxmOWGo8goRgZqsUK0v4Z8kPUbBGftbhP8OEkHVOQgByxJNsrWkzBGxUUTA?=
 =?us-ascii?Q?4jyNrPXspqqasw5qin0zJVBVY11gqeYnA9GDeRM9sKTFX3nzf3ktrfEHzkjs?=
 =?us-ascii?Q?I3b6OFnGqf0cLjLFNi+mZV8l9z+obp75QP9TQaIbQ7UfgRR1UFtrtUpQRB08?=
 =?us-ascii?Q?13JX1NFrNrBf/emhRiGqiSk9p4KvlIRgpWMP+p/SYKRm6aIz+HyLHSLe6m/N?=
 =?us-ascii?Q?e9l+ZxhAWDotS4PmDpRXP6SpUR0ugJ0YYZ6+aBDME+Gx1AQ/A2t1bFuT50GU?=
 =?us-ascii?Q?UmkirH8q64F1J3h4sVvgOgsha83A2qRfzf0bR83mTab8uKikFFHyQj4K9BK0?=
 =?us-ascii?Q?Vr3cx7KvcKG65wITC9mPndyVNz4DE4ALxbxI8KERYYk2Bi1GSKlmhT4LXG9T?=
 =?us-ascii?Q?00G63zFuXvoMDKnHThMA8zUi4ynpVyNJQSSUZGm2zGONSOxaW5l6WokM0R56?=
 =?us-ascii?Q?9Y75pZMjBnXAEeRxffpkcDgYxPT6xcwjdcs0NMErU6LReYUqtDG0KR59Ry/g?=
 =?us-ascii?Q?0IzvJ80Xf4rwh67Khn7xz61M+7Y40UA9/3ZaFJADq+TQaydJNBf7iz0sw7cD?=
 =?us-ascii?Q?x6Kxvt1nVW/XNksPvzQl3sojTnepCzlOuYG9ESJtkaeulBeeAlEGrMQs/S/N?=
 =?us-ascii?Q?7H9wpV6WOgCZFTOZvjuYeE18BVt4Vfe35ca2ecVMnVvMfMqJhZYqCZ4HGJiX?=
 =?us-ascii?Q?8uHcf5k2UqkSLdK9PYl9BxEIg0Ss8Os1PSsra8K0qYmdJY/ILshlBaTZEbaR?=
 =?us-ascii?Q?5a7bZ2GsU4ZEN2d97tkPWvqh1gKyvgICJj7UshM3krIZxGxmqen+hqui+GwN?=
 =?us-ascii?Q?/PQ+M4OvnE1M5i8Fg/vfXGCH50jgG8ZOkgog4LzXo3R6yNXWjc4ei/5kiIck?=
 =?us-ascii?Q?lLODdJnxtFUMn00Y5IGVxRAxbOCTG1hqkW8MApg+ES/9gIlhkKXK0w8ClXa8?=
 =?us-ascii?Q?B4UTIhqYrDoDtnPQStrDlmNXZmaDaEeLWiO/H+UJiwo1zniZEf8oa79FST+1?=
 =?us-ascii?Q?yJLTxmRAQUb4CCKOk4jbil+ZLiwNfnp7qvx3iHMoNmnXRrDFX0o0lVgGzOtc?=
 =?us-ascii?Q?H4hVUYYJkW2ltGVF+gBeFwA0DC8uEh+VqDdUu/a9FbN7rQFgqgnfpF5E8e9s?=
 =?us-ascii?Q?ukG2gh+TvVbo57oadLy7Ph9F4HMC3je19vmkTpA7re/ErE6CadRR16gIQfe/?=
 =?us-ascii?Q?k5pb9j/3je6BGQgAl7HZLOxIxiOYGBceFAadoWk3HZONgHZSkZ+bXGuY01o7?=
 =?us-ascii?Q?mkyan0vY6M8+go8B4R4+LYzoSnjNNjCul4qJh/hYh/PtNjz4Nv8pnvCnEXet?=
 =?us-ascii?Q?nMGGlTIk61VMF/wDBm6GAN0FNvK6jXzW6of6XTs91ksRuoSoPiUoE61Jvqeq?=
 =?us-ascii?Q?lQmRUdzwIw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5833ae46-c5b5-4c25-7277-08de57fb060b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:07:58.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCCgNVmsEbW8LCcpJ7IcOM3LSOCybvvAo7ec2/V021dz2YuTp8S3sokQQ5DgV0GhUJbW36InlNhgtvvo6f1s+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.ext4.019.fail" on:

commit: 2a0db5f7653b3576c430f8821654f365aaa7f178 ("struct filename: saner h=
andling of long names")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git v4.filename

in testcase: xfstests
version: xfstests-x86_64-df16c93a-1_20260105
with following parameters:

	disk: 4HDD
	fs: ext4
	test: ext4-019



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) w=
ith 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601201519.c7003e60-lkp@intel.co=
m


2026-01-17 00:52:42 cd /lkp/benchmarks/xfstests
2026-01-17 00:52:42 export TEST_DIR=3D/fs/sda1
2026-01-17 00:52:42 export TEST_DEV=3D/dev/sda1
2026-01-17 00:52:42 export FSTYP=3Dext4
2026-01-17 00:52:42 export SCRATCH_MNT=3D/fs/scratch
2026-01-17 00:52:42 mkdir /fs/scratch -p
2026-01-17 00:52:42 export SCRATCH_DEV=3D/dev/sda4
2026-01-17 00:52:42 echo ext4/019
2026-01-17 00:52:42 ./check -E tests/exclude/ext4 ext4/019
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.19.0-rc4-00015-g2a0db5f7653b #1=
 SMP PREEMPT_DYNAMIC Sat Jan 17 08:37:34 CST 2026
MKFS_OPTIONS  -- -F /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

ext4/019           - output mismatch (see /lkp/benchmarks/xfstests/results/=
/ext4/019.out.bad)
    --- tests/ext4/019.out	2026-01-05 16:31:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//ext4/019.out.bad	2026-01-17 00:53=
:25.653451038 +0000
    @@ -2,7 +2,8 @@
     + create scratch fs
     + mount fs image
     + make some files
    -file contents: moo
    +ln: failed to create symbolic link 'long_symlink' -> '././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/./././././././././././././././././././././././././././././././././././././=
./././././././././././././././././././././././././././././././././././././.=
/././././././././././././././././././././././././././././././././././././x'=
: File name too long
    +cat: /fs/scratch/long_symlink: No such file or directory
     + check fs
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/ext4/019.out /lkp/benchmar=
ks/xfstests/results//ext4/019.out.bad'  to see the entire diff)
Ran: ext4/019
Failures: ext4/019
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260120/202601201519.c7003e60-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


