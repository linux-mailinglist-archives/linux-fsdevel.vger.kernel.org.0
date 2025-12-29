Return-Path: <linux-fsdevel+bounces-72153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C81CE6223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 08:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FBBC3046F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714B313E0F;
	Mon, 29 Dec 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAq1kMvJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F3313293;
	Mon, 29 Dec 2025 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992694; cv=fail; b=LChpgswt8uV9IItINrtTsxE3Qt0nyn6PkK/JGla5EGlOgX8fO7yqtzdLyv6/J2M8V00KAf9PxzOwRTbl2u5nhMS8ULpawThXi/ObhGRusXJTZmt5z4GAbt7ckS1C7u3IbHK9VPCzG4aN0hlIeTpYMUpcdyks69O1Ryib2YxJ0UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992694; c=relaxed/simple;
	bh=Z5QPvXYDREdOD17ZpsBeZfLLzLY49wW3UwzaBw8gvDk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m4F6fSUrFezTt2my59Ns0JP21MoqtKb7bA0UVD4HRd0UEypG3TZ9gYIWCBw1C2qYO5CgUulhRU2uztujnejoTavWiCEIzliUuJsyihMoDVyx9UPXfYHSQ3deJ9RLaBcTACnGCjhIcRAJggGkSqrlZrtdtzeAaLpk0WRHEWn0cRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAq1kMvJ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766992694; x=1798528694;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Z5QPvXYDREdOD17ZpsBeZfLLzLY49wW3UwzaBw8gvDk=;
  b=JAq1kMvJesBOUWzpqoSwlYswydIgO+fY83fAU6clYVID+RPlAiCg2Wjd
   aeyYRX/4LdPFIK0uoT7/he6YL95J+LQXp+hazcONPOzx0h/E3nZUDVwr6
   NAp+ltg2INWOjVOTI3muAji3iwc4faqPWz6QRWwUVXPpeBq9pKr1RTxnG
   M8jwWajbrhCnJG7Hvb77cvqEVzHKDAaJhBIlnlI8ydurKb6q/kEf4T7AU
   tL5avmLw6fGihhwbElG9NcK7Ekg6yOowqyGqFu9MY97dcxZLJOXZW1pf2
   +BkZNXuIVPtzkfj5DQi/27T1QPyiYaBlgPVVgdpMHRURXfzoI13HCdVoL
   Q==;
X-CSE-ConnectionGUID: z18nZAEFTWu14L9Ij5+Gqg==
X-CSE-MsgGUID: jzD1rQafSqCubkjr8Z38xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="72228755"
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="72228755"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 23:18:13 -0800
X-CSE-ConnectionGUID: TLIZQ4M9SYy39Fgh5lLM+Q==
X-CSE-MsgGUID: tu/BmYdeSJim0gwsQmbIfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="200586436"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 23:18:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 28 Dec 2025 23:18:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 28 Dec 2025 23:18:12 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 28 Dec 2025 23:18:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1MjM6T0vzKDXMjStFujTHh10cyP7zs4k3X1rty4BN3O2As2U/hA5WPFA2O1aMfwSRLX1yzr3rNjEqTheF8P67kC7wvCJJIVynCNBmseqVmMSuXd4DfK9QUvoE52HSZ5AaFn6+/S1FDaS+VVKGzjk6m067tunVZ1XXmXraD5Y4v1l3Vmtc/0MIcQCTk3795TJhhEU0QNoUMaZk81/JxbTcTm5aU3XZoHD20aQ5GrIwxlpLm0bOSV5P+cEu9xpCUzl9l0GmvZeYXmeyCpU7bdvcCw/4aeOCpuSIXIRSKAIQpiMoU5D18NC+3LmhOih6bgb/+R3DS7lfdcfRN/TI/EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC+O0RMwD77sDEU3bZuAWA6JpDbjiiOOw3zx5b5A8IM=;
 b=OzR21OlR6+77RPlbsOvtdnljNZeIC8scg2UIg3DEfPGYo9CRlK87e5aPKCYEvGeF9S0jKoYLed1C8ARwd+3I/SMBHVLp7mqxBy28CwNIaIBw52dipm3XeMS05qDy7a7NkltqCymmVTGyHQJrt3X7EJtSZCd4dVTls/1dY8Owtxj1plJ0bpewcL0kv/BOpwlGh8rY6CFnk8NESI2egGzCPIGjoyH3qV7FJYUzFdK1eIYZoI5iviHYaQwCQEXmSSwvyQu3q5vHtZHwMa5QAS1kgvpLhzr0SnnlRTqb35yrdX554VFQB70jqjq76hwLc1X9XqX9kdRbZqfjyf7kXhLH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 07:18:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 07:18:09 +0000
Date: Mon, 29 Dec 2025 15:17:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joel Granados <joel.granados@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Kees Cook <kees@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Joel Granados <joel.granados@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 3/9] sysctl: Generate do_proc_doulongvec_minmax with
 do_proc_dotypevec macro
Message-ID: <202512291555.395cc7b0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251219-jag-dovec_consolidate-v1-3-1413b92c6040@kernel.org>
X-ClientProxiedBy: KL1PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bbfd9c-2f9b-4c39-4b9b-08de46aa6b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WgifrbPnhuzX71YVFglgJqOlY6o9ikP37kBAK3WUnicblrGKrTpAh3Blf30b?=
 =?us-ascii?Q?DkNjvWfCilO83UDwKvFVSolymO5hmvFMgCVGOtDW/s55T55YflFquqpJgtWx?=
 =?us-ascii?Q?+yna6G0ywK24UPH7eYIWU+vUW/eDEMa6EgeIAAULjgv4hgnce53wNyeOiENx?=
 =?us-ascii?Q?dh9yntmoAhULVp9Bd2xBnty2zGENM82fw8cEkonVqza2rXzP5wYXkUR9eDVY?=
 =?us-ascii?Q?8whJfjIVr/e5ymQgDA409aTrHHYbGkQeRAtvAVgK7mKANqJc//fJrBBug1Yc?=
 =?us-ascii?Q?GmvfSbQl7WPRWAwmbb6fVldvWKs7Drq+YITkyppPOshZI+jmil0mXnm/KQBH?=
 =?us-ascii?Q?H1iZ7BgsSycZLOdDvEiGhqEtLFSn0A3TjUO0cnFfaF6AdJx2Vg2Svjzgh6Pr?=
 =?us-ascii?Q?EF48asDjbJ/jrZaviuAQfPv1gPjM1g+rBUiXOOlSm/X4uyaud1hRrwDkW7gN?=
 =?us-ascii?Q?3vA1e13M/42ctp3KJHygjH/TJE0tMD/JZzn9PkwsgKB+uY5rkctrGKYxhCI5?=
 =?us-ascii?Q?dGdq3/5zA6FQNxafI1U5zyt9dDjYNKrh+y9U12n85TpvprlbMAcBbwYEG1Eh?=
 =?us-ascii?Q?OFUe/23xRgWYFlNjKQ6cpf6OoS53NFTLbLa/B3xaj4W/6ax+URRdcK+MnGRp?=
 =?us-ascii?Q?RppaZQ8z3T2j1/O0vzqcu7MqPTRmINRzEJq+Xa7+b3tYuHXyB0ZSc4DoludX?=
 =?us-ascii?Q?f042oIty3W1FUvFx/vqc8coDgjSoK+VVW824noMhCfXbSsMWH9Qqs2MAYcCF?=
 =?us-ascii?Q?S0EcuLHJq4cYqi+/5GiGdN3t99CC3Upf3jYx10wIJ62m2uYtiSL7eGGWEKVl?=
 =?us-ascii?Q?uXbgrVvFaMizejGxTn1gVMQ69Ca7o6tZAN6W5h1+KQmuw4hrhJXjtSpQhAh+?=
 =?us-ascii?Q?PmjSoQbs66KyIlIgoRZZv668LZp7GPGShjkZgl6DYL6Q0I+woSY0TMbGVB3c?=
 =?us-ascii?Q?Uf0b+qB8xQP5Qc9oUMBBQ0BuqtTqYDA0soX/2wSoWHNrjDaeKYEReNijs+L/?=
 =?us-ascii?Q?dV1u1HxnzIspDwPX898HVfx1WCBRia4NL7USJPbv21zFw2JrEsUOTIU3zl9R?=
 =?us-ascii?Q?6piWcVgH7sbLscLGrh91zdjioegqm/is7TetBjdTzTUBsMYYfPbiy8rj8tMK?=
 =?us-ascii?Q?J6tAVKbIj5ytzQnLQo1Y2S6JE41VylkSeh/6Y9jga7Ophi7ZllASXSS3kzT0?=
 =?us-ascii?Q?LX8D3zlNklC1p/JpzvVIV9FPD5Ck4ikVOqMOI2YnFCEKF/e2AiquRd1ggXuh?=
 =?us-ascii?Q?T3RwffZtyZPsWkCnEjbY6Kz1kto2h6uY6KOrSa8GzuvJl3QDAX5gtXTxGmUU?=
 =?us-ascii?Q?+WHoGAFaZFkODdVwxxiZrm89Icrnl4bpNZ3zwW9p5bSlsh2vemmTSF82jmCR?=
 =?us-ascii?Q?o6TgXSSHjn+8JLymZaFsqqlguLJ7IHxM4ERdXCZ6pa9afAeKXigg0rPoZtQI?=
 =?us-ascii?Q?7s5i8KxfG1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pXfrZlEGuxBO51qtbFYWr6Q1YrtnVy4hqXyQBk40ZOlSH+k+O+i0ulGzq4G?=
 =?us-ascii?Q?SUGJds9+Yv+IBxiW037JKgkD3kf9AtgjlntNjeFVHkHZKsdTD4XU1wlhqY0r?=
 =?us-ascii?Q?cKEy8bGxr1YHtwpHOtS4M0wWMcFKovpnQpMMzH81aYU++CruJ2y5gZ5694kO?=
 =?us-ascii?Q?jkjUKPUB76zyw4KvrTCWKmbJp3NDkPVpOiQjMIZTnoPW1Z3UlnpI2bEoBfFn?=
 =?us-ascii?Q?KkGcy8arY/UmFirjyRJiQULjn0TiCvL5X0MO2+MzqWwQOJuUk0HxEfUz0co8?=
 =?us-ascii?Q?Ec69zchx6VcZtvcHV/SvoXQKZDaFXL6lfVs2t3gGiBWcy6n9B+4P5rhQVPp4?=
 =?us-ascii?Q?DZXAnYaQ/dd82ASzaq8qbNsGU3jx+bp+Blh2+qs+x5uNhemzPxqnPBPdfaqQ?=
 =?us-ascii?Q?d+jXDBsBoHKVJr9ukFj2nVJNK0hc5YLJKodFRH6aTLJEUFUOzCxqjCj72m/t?=
 =?us-ascii?Q?gbY9BcRcJ5aVbqhHsbT2r/+csxjwxkkEjfUDQ3/O3SIHwLI9UFSC7ckdDeyW?=
 =?us-ascii?Q?LYuXCq2GW+rgCau+1SsUr/FuLOroqP7Wm5knpygGTLtRoJMMheLNl3UFA4Ma?=
 =?us-ascii?Q?oXVZfGhZ4RubOUqM9bIaIHGAxdjI7MXYWmoNMneETsaT6CsTkYnAznWoBGjN?=
 =?us-ascii?Q?dfdt1SwKhkSNhmhDXvyD9djkP72XFinI9fSPonwiscwNECvuegCNxl8iawun?=
 =?us-ascii?Q?+WHckI322LBVVZySsFFZh9LEC+a6O3aokZRY2E8SzlyCEfONzBwMPcUI4yi9?=
 =?us-ascii?Q?CpiJTfQt4qdTqwRGJR1Jb/BoRuiUpcZ51puylJtTX6nYWZ1TsnYyk4ajV1D8?=
 =?us-ascii?Q?KYu95lAjacik1/K72gOgixvgJemZd6mWYuLkp2Yi/x+6nLyxyOqBwuY0EdHe?=
 =?us-ascii?Q?ywBCYTlPmqzfWKLuPrkFdG3XRkIA+Q0hDx2usOdOTWLwI+5w0Bf7IcdtMSlF?=
 =?us-ascii?Q?1TY211bsU9D5dre3vxdcnMWIroEgZgEmmLzQWuNahgUhvbO2lkmKT35LbT3v?=
 =?us-ascii?Q?3pLKORVimuf7tlnNn3qGldeWE/av5+tMadYFjNggSaJg9Z2Rz68FTZo0ewBC?=
 =?us-ascii?Q?PF5UYhU1PBJ+393f8B6f3Wut/0npSk4sJBtoKDXRZDB8Ah3uMyFqNBj/smEM?=
 =?us-ascii?Q?+wodzRAZUHT+hHxab8eQ1AqV7cuNExxl9hYxZHKYxDec6QNtpViSVG1st9q1?=
 =?us-ascii?Q?MgNMzvh3eEHIxvqVB6K/yJ4wDFgf6CLbXUtDMtllhjBuyDAD16r0V7u9ObTh?=
 =?us-ascii?Q?fyyTkGMhN75+nZjKWXEg30k9vsIYlAa7+eKxiXDvxr9LzKbEoL8djAmXvI4/?=
 =?us-ascii?Q?+sTKErW5zJ5+MH75gPvxBBf/B9WoODS8vfPGCPvkY6RS0JNjQCBE6u8OI8kf?=
 =?us-ascii?Q?bj77qgO/fuLvBiXlKVMaqz/6WG4L+ldIcaYk76Bos4D4/VWGekiv6yZZTcKu?=
 =?us-ascii?Q?YKVC0ShBvqyMCDRTqAlEos3rdvU06xZvetwUutJUUXNw9+Ae/1MQEMBBOmNV?=
 =?us-ascii?Q?A3fC6wN00PmbzHvAgwgtqoEfMKkBd1qRm+g7BixAvbBlmiiujRrLTW7Qdr4/?=
 =?us-ascii?Q?Vr9oYIOnY2k22Z88VRbwz0YNWcoAAoBtJ/uTPQ2HHrVJL2AzunjVzY12tET5?=
 =?us-ascii?Q?/cIVbs+WZLJXDRGvz19wx6uBoR+D0NETaRusI9yTsSZOQJVFPdaMyRPqyIcs?=
 =?us-ascii?Q?jPyV4gO/hQc1zhW/P55BPrKl8UoS9XcB92y56C0RPl7PJOhjIBuRMo6xDUIT?=
 =?us-ascii?Q?MGATe3cuJg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bbfd9c-2f9b-4c39-4b9b-08de46aa6b81
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 07:18:09.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+ZmS9Fjbj0KvHG6NvgK3uE4/OKjs0yiTuYBDzoTtCIZSyzpo+KyUe5bBXvUEzB5NA5B1foSQ4aL1UyctVO+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.block/020.fail" on:

commit: 216729bf72d98eca7a48326bb17b577c3fde9634 ("[PATCH 3/9] sysctl: Generate do_proc_doulongvec_minmax with do_proc_dotypevec macro")
url: https://github.com/intel-lab-lkp/linux/commits/Joel-Granados/sysctl-Move-default-converter-assignment-out-of-do_proc_dointvec/20251219-202253
patch link: https://lore.kernel.org/all/20251219-jag-dovec_consolidate-v1-3-1413b92c6040@kernel.org/
patch subject: [PATCH 3/9] sysctl: Generate do_proc_doulongvec_minmax with do_proc_dotypevec macro

in testcase: blktests
version: blktests-x86_64-b1b99d1-1_20251223
with following parameters:

	disk: 1HDD
	test: block-020



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512291555.395cc7b0-lkp@intel.com

2025-12-26 15:49:33 cd /lkp/benchmarks/blktests
2025-12-26 15:49:33 echo block/020
2025-12-26 15:49:33 ./check block/020
block/020 (run null-blk on different schedulers with only one hardware tag)
block/020 (run null-blk on different schedulers with only one hardware tag) [failed]
    runtime    ...  42.071s
    --- tests/block/020.out	2025-12-23 16:47:43.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/block/020.out.bad	2025-12-26 15:50:16.434082831 +0000
    @@ -1,2 +1,10 @@
     Running block/020
    +iodepth: min value out of range: -16384 (1 min)
    +_fio_perf: too many terse lines
    +iodepth: min value out of range: -16384 (1 min)
    +_fio_perf: too many terse lines
    +iodepth: min value out of range: -16384 (1 min)
    +_fio_perf: too many terse lines
    ...
    (Run 'diff -u tests/block/020.out /lkp/benchmarks/blktests/results/nodev/block/020.out.bad' to see the entire diff)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251229/202512291555.395cc7b0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


