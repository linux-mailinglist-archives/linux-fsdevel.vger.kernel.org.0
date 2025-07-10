Return-Path: <linux-fsdevel+bounces-54423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD57AFF847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37299168F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497721CC63;
	Thu, 10 Jul 2025 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbNb0XZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF51A2547;
	Thu, 10 Jul 2025 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123667; cv=fail; b=Z8TREPP0M4kTapAYDOXXHszu+YrhtuM4B+22HJdggOGEO7sa/Jq4m3VCRVWN3u6iAztrkMnX0p6RFicZXiFVLZsA87VcpvoqGaoDd5OiIGeKmXis9Sk16AAr/xrCtSegiWYNHphFvrLzHsBQHlemHQsE2pX2ctJ48cxaGoNLsvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123667; c=relaxed/simple;
	bh=qkXYAGGDHYjY/ZGp/w31eFbxNtVu8EWXJj9V8726F3Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=O16+igVSaF8otq5mxSr7L30Mt4/OgyRmMoYaq/SZgGhoWgcunIOozPqfgL6+KJQvIoEHphfqMPQ8FPOOZ1A4cHOT3YHAOlSUP126bmnBTeKNsuwvTfHznA8XGlZFHY4QqbDs2XIuvMpR2trlgCm9h20wVhuhYognHAUDjYxqoGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbNb0XZF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752123663; x=1783659663;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qkXYAGGDHYjY/ZGp/w31eFbxNtVu8EWXJj9V8726F3Y=;
  b=FbNb0XZFoXP2NUvKgYjAB82xuQCsHUeAhSa8W182haEiWZphiTvHAzAx
   er4b0ggiYkLaL59/HiqJh/yAzaQUH1F/MHK5YpPLpTi77xelnugkZBAR+
   LSMBE2b1A2EIo5xBMB9xd4TG9NNu33UEd5mLPytUitZkLVv7qO8QB73mU
   CyVO+lZTvMl00F3Wpoq6qGqMFUJ6T2dJONfGP54CH17yPWXBQtzMipwnM
   mrhWQTZ7IBDQ+NVksiJaCfjgMSv/16Qx88XY7iJGvERuZgi5PfsVhPGAd
   kQTAPWoPZMHQ+xVNmDXgqr3T7Q57Tm7uRNfNXFttWT9OIIssrSn4+xMGL
   A==;
X-CSE-ConnectionGUID: UlcsiNXtRd+HrRiltmQFAw==
X-CSE-MsgGUID: YSuGrMWTSImABcgmk64dBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54246990"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54246990"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:01:02 -0700
X-CSE-ConnectionGUID: lylh2zuRQhO5wKYPtlf2sg==
X-CSE-MsgGUID: mMH7eKC+QqufpQN/IRiRqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161523696"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:01:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:01:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 22:01:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.89) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKxhfxBBPVLfzavML69z/X/Lxvo/nj0BE7A5LjMUl2KjMgvpEf6wf+m7EPVeSqMmJNBFxmtGqZc7mqI7n0GPS720yPwmyrkQeTwF2qbCkMNgqAFdwnUQ/3G3KKCwYaAYrDTRY4OeAwVjlmEIFoZUxXzhccSVZdFeigwb9jCaBEA5Zm97oxKVo/X5OCXfgIgWYQM3doe1UFkPKfhnVQqnmm6Qh4Cao8gT03xRT4IrqW2+8v/9RGvCBFBrJgA/to7V4nFeTu+xf2HxZ96B8lnSUm2Pp53Syvuzt4W9T3JPYMtf5jfdnvT7MpFP4QpKKdjWxKkAW2ZDPndbpaSCLtfE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VJCkumMFpvPyGekNQcizFhop9c6qMRx8a7yxB11r9o=;
 b=WM1SC9YKeQ9nHkSHqolfXty4sEIUuaWp6oHJEIo6FB46gam5cmLrn2GNP8snl02R5djl0+Q2Ny/GRY/dcATXmgY6ChZFmTBJ+45+NOvsm+AtkIvtXLG/7K+GaP99XDzRlFwOc8yHUSMR5PzPV5ElCl+b1NzmKiqnKI2DcTUN3f+DHeVra2AbBEaelb3/vvmpBzbrxKkN1EMF2vN1nnG4vSSAI4pRxmFgbCLV8RnLNOzJFZebk2nYHQXw4K2tUMAnu6jad5Ma/AntpBuL7asMxGeGqvC8Nk7YId/S/XYWxcAKclImRSRf4T5mWLf3Wp6gnQE8XgXJ9/jqKI61nx/NLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 05:00:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Thu, 10 Jul 2025
 05:00:57 +0000
Date: Thu, 10 Jul 2025 13:00:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	<linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  9eb22f7fed: ltp.uevent01.fail
Message-ID: <202507100657.c1353cf9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 1158670b-2e61-483e-8561-08ddbf6ec151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OLMORlHzKq0Em6EEJyHwMuCsuOhvBTU7FGFAIL8aVJ45MS9Rm8W3MnCA7tTu?=
 =?us-ascii?Q?Y2vKcXHRBBg8Y40cmrQhl5cnB2uFajI68vxW3FnR8iGQCKw5//Zs9zBwW9Sr?=
 =?us-ascii?Q?b4ryBrOyYH6Nf71j+G9Nt09fyXvUIt95U63aPZrL0q98ouhGDnJf1+V5pv5B?=
 =?us-ascii?Q?MWgmteMA0DUomayd+bMi1vbyIZkLXO9MRCI2LizUs3EzTwZYY3L9zo4Pr/Gl?=
 =?us-ascii?Q?QMIhFX20UfFjk6ErM8S9IoHkfDXezKQ19y0WXa3oufWslP20xewqvB6bL1VD?=
 =?us-ascii?Q?6uRThY0KQ7MuMvsmV/meOCxPQzDGyj/7eFKkfg7+XvtpFYjMPWiIBTqnUQr0?=
 =?us-ascii?Q?tXJgLdoZC8Lpsxbbe8MB+ydAtzCa4BQgUako36b6obHKERGMkSqTxaSCn/lS?=
 =?us-ascii?Q?VM9nXaSbJCQlhHsTEGtQf0CW8wfdsWjbqsReV9QSIvEiG99CU/zui0wa0Z+H?=
 =?us-ascii?Q?X6XHHX9gWSscXS1wBC8gTmg0QEhAV6wk0fEQlPdwGBIEAfAPdevyf1OdCTuV?=
 =?us-ascii?Q?1N2tLxa/kqB24uJvEOjZpNlbbYi5+9CDCH6qVZmpy+boWW4ujRy6WL2Izf4m?=
 =?us-ascii?Q?1+N7rnjMlviBatCH4WV78C4FF8xOv59qspG2HAUlFKPdZGe+bG4b8oMeB9T9?=
 =?us-ascii?Q?zLdz11t7nbQhe94wPXZiUCuouegQIf2lTsBrRyofAcrVY4LFBog888dS+HDD?=
 =?us-ascii?Q?MCa2Krvspj3PZQwswARTyToM/zcvs74iQJ5sSQIpqoNZ38xP13GGTAoh/1YR?=
 =?us-ascii?Q?GCxk6nbQQnOTXa8+vy+bVVYbyeCdxSJUw/ixMS3daD9inUKf5cuNsUHsjGUp?=
 =?us-ascii?Q?PHxhztVSqbuvqg1/sYHBa/0DeJrpPlpvBuIctyChqdtFTAWOIWP7NSQp7xn9?=
 =?us-ascii?Q?mkQfM8QWBD/8/5ewjQHWIwAg9z9dZMzKfkQ95gSjM86fjLLEjcLYlFWL3cvs?=
 =?us-ascii?Q?QBPi/L3yzlGLF8NQDAvpMKvptRlkP85EsVMjfiitJVPUJlJGJHf5Hhpjv3md?=
 =?us-ascii?Q?Ny2xSTQi7BC6xpp4lPjeW7WwQi1uQzdBgDhCVbiL5o6M0gVUIFq9FMhw4uaM?=
 =?us-ascii?Q?1Rk5/7TnXehsQz75G+4/sdv3lyKadCq0ydj+YptJg+6TiJjoRoTN7i1FOj+F?=
 =?us-ascii?Q?d50Lbz84so7pFgZ1bnj4jx2jnI5V7EjENJq27vlUlHfKcqhHIkHbYLZtuGbX?=
 =?us-ascii?Q?jo+gaqcmh+RxE6PCrgJg6KOxtEhJ6KAcIaJLmGRH93f5256+qORX9jd5jQLR?=
 =?us-ascii?Q?MNFkyn9rn/tpVCYaRhlMN59XVjdajHiExRcxHqyRR6H9r9eLt4ohpkmTxyYQ?=
 =?us-ascii?Q?D+pU03jDSuVr1uyvemYxcE7I00m+9EBLLh4DF29fIcf4VUCsyodaiz60Gpdp?=
 =?us-ascii?Q?ead8W8JZvj2DCFxBLoQ+g+2aaj7o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xk21QZqGgRr11IzNj/Mr49lWwTiIucYKS5qxqfkDJy3362hiy7o5cmSGVPNL?=
 =?us-ascii?Q?6Q5ItTDPlX6F4xvzs2jEv83wPxMh5nqp4wEScjwwUj8LK9ZrlvHlQ6JVER3c?=
 =?us-ascii?Q?fAFZL08l0iHU7kKDN8iOb8v2jMfIlBw+UANYhwAVgTFljVm53IeLqau+x2e5?=
 =?us-ascii?Q?LCRr8h7giH/vVc73i6/nSvq3oS8EMz/GO3a2uwPJ/VHjV5oNBbUA/IrBxR1M?=
 =?us-ascii?Q?E9daX7mC8qAdxFZHcN1n67uNzspziar3t4rlWZj3hzho+nSoMK1eU6GBVDhB?=
 =?us-ascii?Q?WDYYok0sF4dyzkH/z48tbI3drEst4Q29PKnGCUjtCk1Ctf8rgO/5oUNNxOn5?=
 =?us-ascii?Q?YPIHZvd6IyO4hkrFgiBblGYRy5yf+9UJa+n7N9uCivpqiIi4pcexwZlq1rjp?=
 =?us-ascii?Q?vcaj7a+150PiWgUROA9B1uq/v2aWakj2HTFQ1t14A3MYV3V0CN5zVPDY3K12?=
 =?us-ascii?Q?UwjuJYOrYKoEwXuNDRJPlMZyN9TB7nSThD1O8MQBAo/38X3YVHEi3caViF2v?=
 =?us-ascii?Q?ZZ+DD/6pRmmbZw/ifMeP4JYDkIIottUV+g/nFe/cnQXkNm6JJliwnwf3Itle?=
 =?us-ascii?Q?WvZKck164dq1EiMvFHdHHGTKlV8vj8auoVVeCms2VBPtENpeSDruoVGrlDIV?=
 =?us-ascii?Q?DgAJnImkC2Jy6yCoOlTfaEc5MSnz9kZy87/eqivTKcaK3XtvKqCo58XDP/iC?=
 =?us-ascii?Q?wB7LfsMMXKHAJT3rM9lkNxHljZJP8rHSrnIj1SxjmiGzYb9c72tThp9Qexnj?=
 =?us-ascii?Q?ey7xyIE2A3IH4Yol8v5lmi5KJckqDGG2aodTVd91cEM3c/HB/yPgECYY0Qmk?=
 =?us-ascii?Q?VOCfJP4OSikWyXxWrNb5q6bwO1PmvG4uGfSN+Br4XxC10tPKiNUQS2h6Z5z3?=
 =?us-ascii?Q?i7p3PrXx9JkPc1aRzaVyzdP9HGF7UOuLMPml+zuuSg4/mHnnYWRH+zDG9dgc?=
 =?us-ascii?Q?4ZHIgukAIChp0Jul0pDQj+4gF90dNFtn5z8Mi7/EK5hBrK3vCNKal2zdW9TI?=
 =?us-ascii?Q?KBMZHY7OilpX8LRxThP22lv041dA4kubRKCQsXWRoOgOhmQ8uLqaFrL5wJWD?=
 =?us-ascii?Q?2sB7TrPgxWLo+lhxuKx9zH7xtReXyOnH09wOM4uHST0F82vADpwook67Zjcw?=
 =?us-ascii?Q?g3RFTUmzmOQvD4Uvwo7sBeYQvjmi/aZGKLo01ufWVqP5IoWCRbX14SoZhmQY?=
 =?us-ascii?Q?kBpUreDgMDVyOLBH3z4Yoa02+QeD2oTSg/c47KUMrY2Bz8WjEEvlc43/GdDJ?=
 =?us-ascii?Q?IirXcbN93927LVuVTTGGPxEZZvfAPUxadbsFPy+OeAOYixZh/YPaOLo1tbrj?=
 =?us-ascii?Q?BJu3qs1weTs69V247ku9IlMPMVCAkQN1xHdWvce24h898hSEv/w1Y1g3nok6?=
 =?us-ascii?Q?WYY0v9Ih4gdxjKSz+1X/HUGYKhP74qRqIgUAGM2istwhqbwbrUlgXEzim5ve?=
 =?us-ascii?Q?VRr1wbnRfJGceMSACcllHgxqBZpKNQoxS9x0o23W4kqVFsZhbImT8BVeferx?=
 =?us-ascii?Q?G+QcN9B0xokBvQDNR/tfaa2i2MwBZStmLHby1c7RMDxUuGnb2wQvLcgARcYW?=
 =?us-ascii?Q?oLS1bRTm58AJufRaD0lIW4seeARmfoXvbOFL3M75zd/pvm6eZ6NcH4FSLcYc?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1158670b-2e61-483e-8561-08ddbf6ec151
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 05:00:56.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s/Eqr838C5s0NHo9l95TvMBBcn8fTrmMK1OknwHzJbZI1zqZTIZB8ALgxcPAdt9iAlk4myAe06as28ONqK9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.uevent01.fail" on:

commit: 9eb22f7fedfc9eb1b7f431a5359abd4d15b0b0cd ("fs: add ioctl to query metadata and protection info capabilities")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 835244aba90de290b4b0b1fa92b6734f3ee7b3d9]

in testcase: ltp
version: ltp-x86_64-df591113a-1_20250622
with following parameters:

	test: uevent/uevent01



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507100657.c1353cf9-lkp@intel.com


<<<test_start>>>
tag=uevent01 stime=1752075642
cmdline="uevent01"
contacts=""
analysis=exit
<<<test_output>>>
tst_tmpdir.c:316: TINFO: Using /tmp/ltp-agSWS1iC6f/LTP_uevIF0Neu as tmpdir (tmpfs filesystem)
tst_test.c:1994: TINFO: LTP version: 20250530-43-gdf591113a
tst_test.c:1997: TINFO: Tested kernel: 6.16.0-rc1-00004-g9eb22f7fedfc #1 SMP PREEMPT_DYNAMIC Wed Jul  9 17:57:45 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1815: TINFO: Overall timeout per run is 0h 02m 00s
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
uevent01.c:25: TINFO: Attaching device /dev/loop0
tst_device.c:190: TWARN: ioctl(/dev/loop0, LOOP_SET_STATUS, loop.img) failed: EINVAL (22)
uevent01.c:27: TINFO: Detaching device /dev/loop0
uevent.h:49: TINFO: Got uevent:
uevent.h:52: TINFO: change@/devices/virtual/block/loop0
uevent.h:52: TINFO: ACTION=change
uevent.h:52: TINFO: DEVPATH=/devices/virtual/block/loop0
uevent.h:52: TINFO: SUBSYSTEM=block
uevent.h:52: TINFO: MAJOR=7
uevent.h:52: TINFO: MINOR=0
uevent.h:52: TINFO: DEVNAME=loop0
uevent.h:52: TINFO: DEVTYPE=disk
uevent.h:52: TINFO: DISKSEQ=4
uevent.h:52: TINFO: SEQNUM=2501
uevent.h:140: TPASS: Got expected UEVENT
uevent.h:49: TINFO: Got uevent:
uevent.h:52: TINFO: change@/devices/virtual/block/loop0
uevent.h:52: TINFO: ACTION=change
uevent.h:52: TINFO: DEVPATH=/devices/virtual/block/loop0
uevent.h:52: TINFO: SUBSYSTEM=block
uevent.h:52: TINFO: MAJOR=7
uevent.h:52: TINFO: MINOR=0
uevent.h:52: TINFO: DEVNAME=loop0
uevent.h:52: TINFO: DEVTYPE=disk
uevent.h:52: TINFO: DISKSEQ=4
uevent.h:52: TINFO: SEQNUM=2502
uevent.h:140: TPASS: Got expected UEVENT

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 1
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=4 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20250530-43-gdf591113a

       ###############################################################

            Done executing testcases.
            LTP Version:  20250530-43-gdf591113a
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250710/202507100657.c1353cf9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


