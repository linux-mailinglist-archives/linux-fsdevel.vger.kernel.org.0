Return-Path: <linux-fsdevel+bounces-69962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32904C8CD03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761393AD25C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9A30F533;
	Thu, 27 Nov 2025 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctgctt5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FC30E828;
	Thu, 27 Nov 2025 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219066; cv=fail; b=Gpz19VPWPFHro0VGOu2txTdTdGreCgyWCKpzeWVXJmwrcOGUpOo1cvMyagnX4iqY79YKD5NdiebwzkJ/edLCQMoNie4VZUU/6S9u89aMc+CLTBv71mN/7JesirgONlR3pcftuJEJ/6x4bn3OaYlz8rM1/AuHUtkLED4cDrF7rHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219066; c=relaxed/simple;
	bh=6H+r5gbQsb/vZ2AkSpgbNrBOz9DVi+es/F8DXN5VybI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfZjFY6+UE8cTVsbpxfNmEPeOIwV20d5ii5/oWlg9dwUHe7Udha/wx6znZcdAP4mjYN+hSktjvM/ocKEsSeTo69xakARC/OjGYrSh+nCoRptvH6lW1UjS5EPJHfwAShXBP8SoQk7xCKC1DFyh5Bj9rK6N3DIgy5YMOyCpGaz36E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctgctt5X; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764219065; x=1795755065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6H+r5gbQsb/vZ2AkSpgbNrBOz9DVi+es/F8DXN5VybI=;
  b=ctgctt5XEKTvCAvHSzMHZIvaI3oMsPuV43z1F0V9GMzqkllpcdtZDMLw
   qcKp3Ea5q1Iz+/yJQmp/jOMrx6CGsS2V9olm6r5qV3n5hyESRuaf4MwhH
   TX8kURN7Sui0KCC0+v66gs4KMBQY6fyeGxm5Y8yDNCY2zOagroCDjZTLy
   qSkXjNP4gGoh6Y54U3cMSgWhgJfxp2Whwz9MygBU109eHJygEcWYtrjYm
   v1VE1VOIuZearZ7C/dKAESQxKm2duudo4EAqhjWgUjlWh/fKpME7YU0p3
   /EhP9GpRDC5QiZ1JH2gfHHTyGTdIxOl4CFwLTy6M3fJo8PspVYDFvgbss
   Q==;
X-CSE-ConnectionGUID: nYOEr/csQV6F61y8kfEidw==
X-CSE-MsgGUID: HyuEDSRXT5W3opAmvMPdHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65268346"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="65268346"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 20:51:04 -0800
X-CSE-ConnectionGUID: jTqcBZRnSxqLzmbDpQfwAw==
X-CSE-MsgGUID: oUF1LaSuQaiPDYSLPW/ABg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193354434"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 20:51:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 20:51:03 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 20:51:03 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 20:51:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paDK32hBkOW38UACWREguePuh5vyKDgQmKnGtwROXBouoRy5VEHf2KeQKMbb1oTRKKWb5mPxuvwWfMhKbfgP7YlpcMCyUl4j+Wi8UuXnM90UzPu6y2ZWQRtp+TgfYFmw9fyoRqAWHKrShiieS58NKBzYOF+V0FGmwi42r7Rg90ej8PQC4oCbp+0RAUj1WYa5ZqGzDhTTyItWzwyPOI1YvrCtikAnV9swvhdvvmCc+OUqVbVqV0UfG+Coj7Mqt7nr+ZpJ/tI2le/FInX9iL4kDQXzEhw8IaJtLvuUBl3jX6XhSroJEah31AffNIb/JztoOsax/Gtck5efbCLItZjxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQFxTSxZif8D6kU15b5VkJww5b8is3IuB6bIbfAR8bA=;
 b=Cr2rmZGtCDSiD3YFT5rH9tHKGnvEc0gpInRj7wzqv1cKCOKggEPi4qXXI+QwhBfjk4WPgzTeIAq8hkGipKciQEsNNib3ayz5302CqCxWqj4dUzzn1e5l27CLjLqLdL7xASFZT5jg5LZvkMi/f8XSrFlov/MbAGVL9W3MTOL5N6jwPtGJSDj8wnDACyDEtcA0LTn2BqveICxSEhouRkZwO3d4okqls/cHQ/ZhElnMQczxE3nQAKBS+tuC3G30DfdbZXs8hxLq9XXbMpUP4mSE7Ra10zLjV7cXIsvnVat1oqNhC1RSAoVW+TOnbsGNrdX1NSiz9Qz1wvv44UYI3baY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 04:50:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 04:50:54 +0000
Date: Thu, 27 Nov 2025 12:50:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Cyril Hrubis <chrubis@suse.cz>
CC: Joel Granados <joel.granados@kernel.org>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oe-lkp@lists.linux.dev>, <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <aSfYpFIc4dpYMLGj@xsang-OptiPlex-9020>
References: <202511251654.9c415e9b-lkp@intel.com>
 <aSWI07xSK9zGsivq@yuki.lan>
 <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
 <aSbCY9flDrZGC5NC@yuki.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSbCY9flDrZGC5NC@yuki.lan>
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: d0affd2a-3e13-47e6-fe78-08de2d708c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U02qYYr26d34Y5JLAUT82iL6I4q/1CYDf+hYrtGuAdG+g6YwUAlFBOGzkvVE?=
 =?us-ascii?Q?flgZblwah/P5cuaxC/M61Dq/x8cPfhZJ+l+nJtLIPwv6dPG0O2Lo0j4UVhmE?=
 =?us-ascii?Q?I0o5biKUqfgrvtW0oYfXljseEwiz/qLS+LZPrFru4wFKMnaRx0r7eWOiJNp5?=
 =?us-ascii?Q?Lxjiz1T4oDTpQUS25Y13jfJJUsl4EOpgdLnyiWBVEdhK7TNmKitX1oh1RJJb?=
 =?us-ascii?Q?iYcc8selk63ZEFga47Eg5GRahm+WOFml8xxbsrpnFKZrA2PGQ3UEX7QS2Fpc?=
 =?us-ascii?Q?qWqoxdio5uYko1czVsJy7m+G4bcGPFjk2ohlyEXn6aS9m8ofDd6Op010OEna?=
 =?us-ascii?Q?QCZFYULDZOESPsBI0siXAQFHv6MLCE0DvyJsqx4o1ZXLqHN6CBrZG01Y0hlg?=
 =?us-ascii?Q?i3ZNI2yWQIiaxSMxIVxsPWwKNmDjgI7pBKyX8G/Y1UHSno4F6NCm+elNoyLx?=
 =?us-ascii?Q?HPlmDObzz1LUb92YtBERAmkSxVxt8YlJsczXB6in0xyhsfZW0oY9T5NKt3Dq?=
 =?us-ascii?Q?CAwCtHpO8EgajF+xfIb5vuoTcqINQRstvkP4MYMaPO2iQwCglsMFhyiWOyPM?=
 =?us-ascii?Q?345J8mjlcFFG+W3dal0V7mGyWXWuUlrt69UbuXhVeGTVNtKHuCV0MCw4Wpaj?=
 =?us-ascii?Q?HAYIKPQHV5XqO2NotT+wAiGRtk6UNJbOq3Uh9+dK/xSNgtM0pX3B2mfJEjbr?=
 =?us-ascii?Q?xQQxfi4aUgu6FfJTbF1yteDnmU43S78W9ZHjhJNFd8/ssIQtH6YLRCGVzacE?=
 =?us-ascii?Q?NgYOnHzLpZStPmszEPrjv8jeNeb5VOvH2+H6hE9fHThI6D61FH22+ZQ+9KWO?=
 =?us-ascii?Q?9YMaoFpm1fF3vSbY8AbCm34jmJr/91MZ1fQK9Rk1nqAGbpCiB8lUhROEJQsK?=
 =?us-ascii?Q?0L5cuU5F9gRAvJvHh8Jc8zBrPWQg8g/pOTiOhMQCThcXS39hx4IKoIpyRKN9?=
 =?us-ascii?Q?jK7fuaEgh0b/1aK8kYg6oR0Tqb+UnlHPIMj1GXoExd5gc16EkSDhZokGgEQH?=
 =?us-ascii?Q?q4CYsFaHMBBn1Z8UMShgMd47bebF2aGkPT7sBz3MOskWvk4A3xkrwUq6ZKFX?=
 =?us-ascii?Q?EKURH3Tq7/5SZUHtjfzEpuCvF3yXN6BbNqnm1wUSVNjQ5Ud5xo189AIfLncc?=
 =?us-ascii?Q?q9H9MHmVbG9lB3AXo9/XmNouqrHwv0lE6Fs/fjda3b7+zSwa1eMC9rkb7VRG?=
 =?us-ascii?Q?vT3EiHuJGu1URqTfnmI3rzmzkKqRzKtoRRYGmqqnlEtgF86fsmNtmQAKHLsE?=
 =?us-ascii?Q?AlGc6ryriKx81UHB3/W13a7sy6kftJ/ZNLbNUf5+/MVLNU+PxU4X4fJGqiZF?=
 =?us-ascii?Q?0Jqc6FrDnwN72Jmr6+u4sWRSaVAg929gq3wrG3TNNXf0sGeLDv5aFJgcpaB7?=
 =?us-ascii?Q?B9Dy1gHSsjQzlVcqeiuESfw02Uh4+Eq1Rdh3O9gxokdlThVMD8Jci3HFVTb0?=
 =?us-ascii?Q?PiC8Bk++ugoH9IUmFJ6/mUox6hx7tzM6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vbNJMASwtqS62nm2pvXWPOKksBKlFjABWWkF77cOSjTP4nD4elBk9ntKmE/L?=
 =?us-ascii?Q?XwH6O2pUMdOGv6H0RseEwzVjDBAIASWN0Hp64pTXQbWoQu3OhygN7Fgs4nDk?=
 =?us-ascii?Q?AQfKOviR1/edkmdju95l0pGDdeb53XPcBvKy37ARDEGbrFNZdu8FnPJB8THR?=
 =?us-ascii?Q?rRZMPo37lOm014g0nmeYpd/2mjYzqaqzewbYnLsHhKYeVEbh1CIkaNwHJGXW?=
 =?us-ascii?Q?4SiRcZKMRYCYa7XwSEgjWuvmBM7GBdM7hcm1twMUIO5x8Vvyf7It9jNhmOKX?=
 =?us-ascii?Q?sTftGXwjZJ0m0Qr1uIUzXvgVvX97jE2nGs7vGxbkg6PxmVQVH0oRKXVFJm7S?=
 =?us-ascii?Q?pIXVJo+PCCoRGQetSZ+GbQt6GEMZXzD/ZyRJVDxzyJ5IczvSB3jipCJAhi0s?=
 =?us-ascii?Q?07j5b1JZjTzDgzw2fJk+ZxC9I7ADPLbD2ksXSctfNkhMziaesA7YLKdQnBiF?=
 =?us-ascii?Q?Sn6NggPCkyDFOqF4pBK3NHwCrK8/ySEgv+LNGgeFZ1+TcG3qVvjVl95irXmJ?=
 =?us-ascii?Q?A+3DDjl5veErOUGOIk6kFu5j74EAvO2X6kDi/wCpec9oMTITLbfD50DdWhpH?=
 =?us-ascii?Q?y6GknZYWsmMJKZplwKadefg/B0rQ5yn6RGSxoE6Jbl26Uv7OvWms4uGLfKLD?=
 =?us-ascii?Q?dfWfidVGPS32PjmHEQ28NGhJRfka74ouxynQg1RPO+aIuoAY3dSuGCA+AtBQ?=
 =?us-ascii?Q?xMzDB48VF6TTQP24mPNjHspWhVbWFMqNccxrDVRBogSwBIjk6EDJk+bdGJ02?=
 =?us-ascii?Q?4LKPnzvEpT4k/OeQlLfTHaXc2jRjcP/tGrCCsFh9YZSVZwhrJdkVZVmhp05N?=
 =?us-ascii?Q?9qna/EyijTnmBIsPmrHVbuOB2N07HAeBww1hPlibqKSIKbLPsK2hQA6RIaZJ?=
 =?us-ascii?Q?KeLR1RQ4N+LNwZt/Sr/4qm0tdVSJNWy63WLAxOILM3r7HWPJ7Sktz+HhGh5U?=
 =?us-ascii?Q?0DvJM1302MFlcMK6msdT22VsnuIDLB4rHafKJ0sP4151aG7w8sppKdPDC3IM?=
 =?us-ascii?Q?0+wy25g8l5zP2ekTj8CwJEMmdA7NtQ2WME+qbqPT0szVG2A2JzqAXESVt1sj?=
 =?us-ascii?Q?h0VYwzRfoSle3yMmibwb4wI+0Kt8yL2jWD2pN9Xz/Iu/ongbTtPfcCXy9igR?=
 =?us-ascii?Q?f7jD6ZEp2e2YI8Plw4FqZ97fGATBukMwO52QYY/zkLiYLwXs2dPx7SC7AKwI?=
 =?us-ascii?Q?VFfIc8hYwsgmoUfx85rXeZzomFvLQ+y1EPX4seTXJYy1YgSg1Xnmbkr7gCpc?=
 =?us-ascii?Q?Ug4SmJGRGKjraEeBhHw8fNm2urssXV5jVANePt2RM0JPoMih8F3UxmH6T0AA?=
 =?us-ascii?Q?L7+P6pEGjS+5ic+7FJBr4NoDHUspw/6l/VUQqxwOKr+hDPFVlKHTJfIz8dM/?=
 =?us-ascii?Q?qE8rwW3s6eG6EFO5FKtF6ue94lPRxGLBc4Q8jVkMlGLOTmCfxONvb0stg1cM?=
 =?us-ascii?Q?fwVoWjHEfS7LeMAnr6pvUfx1AD4DWKz8u5RnVWzDt4P81lxlZ00FVZqij2VF?=
 =?us-ascii?Q?kyti1RW2PieSzwmQVSO/bHRakfAuZe2qLkcufrMOM+UwyUhYNCsFWf5323V0?=
 =?us-ascii?Q?oQmXIotteLFYKqmodTrEsrnDtNBZgAnbmwPqIuStGad3Pg5fL+EJxYAbc2Rr?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0affd2a-3e13-47e6-fe78-08de2d708c11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 04:50:54.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bmherm3OAm0M+mA6urp4dclumigxw5lSnPCV3AtyL+DH/MitRsjSRK1M0UXyrx/vORBzVVduIXgbzicL9MrEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

hi, Cyril Hrubis,

On Wed, Nov 26, 2025 at 10:03:31AM +0100, Cyril Hrubis wrote:
> Hi!
> > I attached one results.json FYI.
> 
> Looks like the test is getting unexpected EINVAL when reading from files
> from /proc/sys/net/ipv4/neigh/default/ and
> /proc/sys/net/ipv6/neigh/default/ directories.

not sure if you need further information?

> 
> > it need some code change to upload it to download directory, we will consider
> > to implement it in the future. thanks
> 
> Please do so, without the logs it's much harder to debug the problems.

got it. we've implement the feature. will directly upload results.json to
download directory for future ltp reports. thanks!

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

