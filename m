Return-Path: <linux-fsdevel+bounces-57448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC53B21A0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC77E1705D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 01:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8660189BB0;
	Tue, 12 Aug 2025 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kfz340Sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFE2475CB;
	Tue, 12 Aug 2025 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961097; cv=fail; b=s+kcoRhf/Az6lwCYVapfg5tqxQ5/0MkZxR+LmCX7kmZDwgfyJWvpCTjfJmAss/VcnVrAHG5IKJiKJhwl0Lt9zuIApUPUWD5QiapY2EimtCL1VlO2mK2bADwezuyqCWb5tyo5XBVB6/FDkxiT2ga/178sQScMHGXK9/RvhKWf88c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961097; c=relaxed/simple;
	bh=zA7+n2syXp7guQLLXhG+LgwZaSaQlPJ0JwOR8mhKc1Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pAfOUPVQhZCemCvTWrSYVCabTyPbwbflUioc2c0CCyiyxhJzM1y16aGDFQ9fwKL+xEauHe32vOkNJ9M2bercPldCyfx/8Ni2YFxf2DIkRyKOebbBkGhTfH91m4WFKNvuYgixV9pJaIoARo5gwDIrIlLRNhanYeC+mcHCFoQugIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kfz340Sy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754961094; x=1786497094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zA7+n2syXp7guQLLXhG+LgwZaSaQlPJ0JwOR8mhKc1Y=;
  b=Kfz340SyPiZbGZGJ61olZFXz/sFzLp33hongat7BrWqZiUywYIKQu/dP
   vvVvoJWCXVSbECz6e7yV9CbGfBoV20ococ3K6Fo+e+iWNu7oZvrmlfk6H
   CS4a31w0ZRaFJgDGQwkIjfsm4H7R4xtB2J8wtYEw+UIzy/wWYMzL50CxC
   vgsJxaNf7fV3PkSg9VeUMb2wrsR8DWWF6TKoIFRh3OS1Mj9S1mzkMOOZt
   RATIciGMmPuql6NlewqytJ3W8pkAfrAbaX8m+6MFSudCz0ZNzNNUAvqSy
   k2ngwZUZbYY37Vhyb9b29ixHfL+QK1+gJy3m1pYihxKUndfnrpF7exP3H
   w==;
X-CSE-ConnectionGUID: eHPpkywHSnqFgYPysVppVg==
X-CSE-MsgGUID: a28GiRzAT1CyLrXg2OmOqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57371778"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57371778"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 18:11:34 -0700
X-CSE-ConnectionGUID: dj9ZuTG2T2WLVN5odmqCQw==
X-CSE-MsgGUID: QG9KSn5DTPOzTOAS5cM1LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166353383"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 18:11:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 18:11:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 18:11:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 18:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzjeVRIJmrGTudJhntwMfUFrq4wTPg7BSvvMdSVRVF3D7PMG8OfvzIoxn45Xad5+yqc4ohuyk90ltTN6ylp6XcMX9PxfTvQzprlGH8cZiNT8scDSgCr415fgT1kC5l3da1whIcWqYxkj62fmOK0vbwlejHvBw6CPFouKUXLSNzZ83k9wDxEu8byc34FTL/5jJ4lorwuySC2uglouJEEj8YGLlA2y/XrxZSAoLc2Mww2fptMGX31Zy4RIT5j7JB5DFYBJdVD9LNiZ3N1OnmGnIFxkRdj01qebPt8jMe4YYl9FzoztOx183a7pK8jctiVM6J55Pd2uqiC3+9KBulv5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aywufxwf5+XU+RqEB7soaIQ/io26k1+Zd4L2sWzTSc=;
 b=Y1JP1xXVaWEk5m0ZnEXbZ4UThjPAEtyjgHubUV0Mf0bD0OU6vOcBR3b353P9h/i69XGiTthZHtKJfFLwB3zcYfx/8jW5Dgj17IwALL0+c1kMo0SP1808bvwZtOQc+s+j+vT0m4wB5JpZseDMfpGzWoyRXNNLxUUopXwR3KHrmq2Evh6ZUkLn7ehhDlQvalOal6wp7FJr2LOvgq/R85T+neKqbkeNzNNeSfwa3Gzep6vBfZy6OliU6GikEJLMXLsIuIFapXkku3vsoSQ6D77CusF4H6mVrL6tSaLo/cyvNYdB4FENJI0gQkYSLEZwVH7K7IrRQLdT9Si++8F+NJ1HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 01:11:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 01:11:29 +0000
Date: Tue, 12 Aug 2025 09:11:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, "Orlando, Noah"
	<Noah.Orlando@deshaw.com>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [clone_private_mnt()]  c28f922c9d:
 kernel-selftests.filesystems/overlayfs.set_layers_via_fds.set_layers_via_fds.set_override_creds_nomknod.fail
Message-ID: <202508111025.70bc9757-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc8492f-aad4-4c00-6cdd-08ddd93d2b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UV4ydHKYKW+Ao9GKqDblNJnTJ+tA/YbfEDWtNWmlFi854ATHd7jPLNtZ/JQZ?=
 =?us-ascii?Q?+thJNVJgXXjQdeYtlsnzAbmc6nVTYNYaPFBd1siWolIlU+sEcxppdyEqoVGW?=
 =?us-ascii?Q?b/iFkzyqoQ0CFrSEfloS+j8w7PQbFJTMw8jIUcax6yYeYL4sgjCXjHM9FeTY?=
 =?us-ascii?Q?F+ZssaNUGXpvq7QhRijv2y82rTxHlFhbaOyAOFi+FangA7l6Wms3erMJIXnz?=
 =?us-ascii?Q?Xjvx+9SH+xhMqsF6M3SuU1Lf5EypHgOMm8M5tjWfHVxs1bV+eZEMIEt9KQbh?=
 =?us-ascii?Q?wIqUmWbeijxSBAovtyVNXNAj7jM9XKXBd7ag3T5iAmpYLB0ZZ016JiemF79Y?=
 =?us-ascii?Q?pqc8sU0rxoXuewu1TAudhGU4n3XHcJ+Esnf8ZIIwK4CSBn6D/Uyb9JmvIJvi?=
 =?us-ascii?Q?CwtUsrfY4LryAYhRgGA52AMB76vm4tXYtu3/zbgTgmZ7KBaZ1UoTPgHOLBEF?=
 =?us-ascii?Q?4brw7j1bBcGV4RhQm3DqwibaX70wU3JqpmCysfVjwfMcJFlNNoX3I/zKvfHg?=
 =?us-ascii?Q?LF7N9ceajBkpfltwqETun4Rk35xuMOPh99lcLM33HP3dlQiXWLMwb3C0vPxq?=
 =?us-ascii?Q?bJN9ql9ry2BUfbcS6wWBctyki8rUKKrwZFmiuNB37B9Um6GtUr1sj73hW1oH?=
 =?us-ascii?Q?6C5DNP4RlcghacD6cM9Rj/K19SN6xnFqcfzH5hHe4u2qrvY6z4S9N3zoOZgJ?=
 =?us-ascii?Q?KEkfB9HbkHMQ67N6bXvGbBdthtbjJGPI+nqTuh6SR8sYuLNuVaL7hKLIfQQj?=
 =?us-ascii?Q?QzOfWY5IHXTzCV7Wakmx8AnG4Dzvit0ApcYKnrnrMr7Nocn8TTzf57Kr+McU?=
 =?us-ascii?Q?C1qEhCW6We15YqSVtqzosbmsO6zEbOBgK/bC+mW/7vllPoFtbk7OtQKsbJrg?=
 =?us-ascii?Q?gAHcZdpPyPIAcdsTwnuf9t6NidoGM8OmFlkhBTPUlUL1s3gECt9c/dWFBmZc?=
 =?us-ascii?Q?5u5MCP5izbg3h4NYNcq+xSznvVDZO0yxTeGtQ4JEWb8tOGCl2k7EonnAvvuA?=
 =?us-ascii?Q?pCvs7l+MtjLEhFNbH64kxLeo/BY1099TXnN+82SqfcQ5HDecMq4yh3EI7Fcm?=
 =?us-ascii?Q?PVclmFrr56JGaKeJ80iRkDGNRNNG8qGqfJBriN87f+xncbclX7+/GZziMW3X?=
 =?us-ascii?Q?rK8eSzW8HMODGT8V+3YA3FUDypra1SI87OoAsPmLD2eAAJi9CrQSTfQnRr3K?=
 =?us-ascii?Q?CgE51MJQX93qU3luTJBLbwbF+AWq5/34xvc2bX1/U9lP9nZenEaOeiEASyHq?=
 =?us-ascii?Q?wD2c5v5OCZ9YPIv7t+U1TYeSfwLF2QHTwEPQQIw77jJ0/nBeqel7Bj6muK7h?=
 =?us-ascii?Q?5YDLh50jvarYM9JEV5LDNmd47mlq5CWFkKTxj9lGcgEQIMvva3XH89XBgNIo?=
 =?us-ascii?Q?0YkM4d+YUoYfmHXmYKHHJA0seqfJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CyQA7Zb7q5mkOF2tOE+qqheFkwvF3X/vL3LOLx0xlCiaCzw4ZovInOVg6ei?=
 =?us-ascii?Q?wLkfBm+Hv4q89jeN/C87OVRQgGIa4uMhSVASS4kklKzVtDVJsWuw4lCnSWEM?=
 =?us-ascii?Q?61O0iLRQYSPOG+OBa8UIuz76VhMKSI9IXO3JiO2dmh/sYTf6zd83A9lY+BPv?=
 =?us-ascii?Q?33SCsFyIwQordXfugIY7TyMJa6HWrjfoD5yUQG+bjYLaENQorMWBMuTQmCkk?=
 =?us-ascii?Q?DigGLiqdLo54Bao8yHyID1058SBQ/yZJhU2KkYDifIMmZkVRUjTAn/HJUImL?=
 =?us-ascii?Q?Qwa1DV8UpeEpfMQ7e7XJuP1HgyY/PG/DyrVoFbF9TCSU98rgNh/Hx6MdVUTm?=
 =?us-ascii?Q?RWOUYextnd0GESoN4JovhTFZ7pxki/Mk978ttaTnhI1wTabE6quaDH/5e4vu?=
 =?us-ascii?Q?wqNA5dmu4yodwBljQ7DuYQ67h47926ChUBEnM7gc6V7m0lhFpzAxLh0vdift?=
 =?us-ascii?Q?M8oyuDSJIr4QEZmEb3T7oTCyuNhVtV1IqSrKrGiI/TLmOW6tQoEiMxN2p5Y1?=
 =?us-ascii?Q?vzEG1pJZNkhm7SJFJtXXTJiR3mZgqU8taYQdV+M8ofBTr1bthpc5dUyt0gd+?=
 =?us-ascii?Q?aNMomUPMzKraNJqXJDHmdBH6M+9W6Z/h8jFjlIE956N2bgjK7KfHdLeEfQlY?=
 =?us-ascii?Q?3LcyKiecDnDU7f6odFZT/Bt1zRQUgWL5d6SkTsdaIPBLR3i/Tykc57S6+cMA?=
 =?us-ascii?Q?MWJbs9VApBL7gO0s97EzDZNDzTaC6ea7HcYR9ogkQ8kUiX3RyzI5aRjHt1w/?=
 =?us-ascii?Q?gupdFCV9/4Iq/5SsiYI95xTQzmrcN6Hk+TzjUxyfeO9XRlDv4EvFKaQiopnd?=
 =?us-ascii?Q?BskVMJvHfGH7DAcEFtroPpsVoawnwWM83La93ZZ87nYxfjGQ7a3o9tJg9ulT?=
 =?us-ascii?Q?/ZS0ZPMmD7EtE8JPqzEDCekA0WKGwJXn1o4x/iBV+jhIgzOh+NhXEIQpzoCg?=
 =?us-ascii?Q?/5CW9uAsbipvLpLDGQkMBtSGZbNIUhrHwqFd6Cse7zw2mFeQXNFC32nZpWYA?=
 =?us-ascii?Q?fqQRVjM3JqiO4D4NH9X5YV/gyv4hP9LicLxp4raJOJjWNttvzGDge8ZcTaf/?=
 =?us-ascii?Q?N1IMmVnvvYlyQeb2vpJi49X4xntVCofQI3QQyWgiaw8anyCd63Nzieusswqs?=
 =?us-ascii?Q?Q0+HdTV04CL8GH22/2xd9yVmSk4Yqx6YM+rGXHSOImqCjf2ly/ywkg7cvQsX?=
 =?us-ascii?Q?gO1o03Ii8qtzvizgaC34MsGmY0YG7A0oInjZb1he/VyxbAOz/f4HtjXdThYQ?=
 =?us-ascii?Q?goygMV3rd2NksSFWYMuuzzcB4wTeEK1QMB1o2OyUweIVEovVmzzES1KYFmWe?=
 =?us-ascii?Q?bnMvqkoYJW9+9nu/asHDfgrpRK7kZoiUN4WuPPkjAAqn3jPsnqe9UXzUsVy4?=
 =?us-ascii?Q?KKtjIhlen6F4hBUf7VJfGScSWl6V/f8Axsd8/SuXoEIO41cY7kHoqPeMFON9?=
 =?us-ascii?Q?oKh6XZHeuvZ61wUFeyuhw8qalcWSV/DVI2nZEyWPyaKTAoMHOnIFoqHR9fbF?=
 =?us-ascii?Q?ZLjnNexCutEy+SF23LSKgchzodL73f1mc+XaAsdqULp6aVPBiQBZ7MSBPg5Z?=
 =?us-ascii?Q?I1SJjpdhD3d7f+iG7Q4WWQyn9vuDwtp5IcjQkfn2u+LI2J2s4U3PBr/B2zeL?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc8492f-aad4-4c00-6cdd-08ddd93d2b3a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 01:11:29.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMGpwrKz+aN+/76f+GuOm10W8kG+lZznpfC1KVAMxAKPiCjIIKHHrUpJ7KOioaVPWHS9+xQ6Y/UILnGUpFPAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.filesystems/overlayfs.set_layers_via_fds.set_layers_via_fds.set_override_creds_nomknod.fail" on:

commit: c28f922c9dcee0e4876a2c095939d77fe7e15116 ("clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 6e64f4580381e32c06ee146ca807c555b8f73e24]
[test failed on linux-next/master 442d93313caebc8ccd6d53f4572c50732a95bc48]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-186f3edfdd41-1_20250803
with following parameters:

	group: filesystems



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508111025.70bc9757-lkp@intel.com


# #  RUN           set_layers_via_fds.set_override_creds_nomknod ...
# # set_layers_via_fds.c:516:set_override_creds_nomknod:Expected sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) (-1) == 0 (0)
# # set_override_creds_nomknod: Test terminated by assertion
# #          FAIL  set_layers_via_fds.set_override_creds_nomknod
# not ok 5 set_layers_via_fds.set_override_creds_nomknod



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250811/202508111025.70bc9757-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


