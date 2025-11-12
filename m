Return-Path: <linux-fsdevel+bounces-68012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D7C50A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 06:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263D3189AAEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 05:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B432D77FF;
	Wed, 12 Nov 2025 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUlqzjDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BBC14A60F;
	Wed, 12 Nov 2025 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762926051; cv=fail; b=bv6BEckqnWkaTr6VmrqMtXkO8eo705A+lDvtQlOEu23NhXVMX69h58yNg+Ds4oJCl/8ApmqorjIRrfAdDmqBnOQP9GNE1PGZLHw7nEUuTASDSQNYJ770jCZZ5gsEKPn0PtDDbgd8dDjgF/f3OTY+mr7f4nTLqxKCqlNhTu07l9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762926051; c=relaxed/simple;
	bh=Wb6LP94EQdxjK9tIrVkngmFSLpbzHPMYMgoKY63Dlg8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bkq5Brlas0HTaThudQf3HC/51+o5KxU3XwhnuA/Bp7L/mPtumeA8Lr4PHWBOqAGf+sxqcCfL/vyEL6uTu7Vbr7O1QsSCIK4uOEfPIlO4T9Q8CSlPlKWTIL8OzFiq6RvkqcPD386+NxjcJz429ipJTqSWzEkcXcviqdUIKdM+xPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUlqzjDk; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762926047; x=1794462047;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Wb6LP94EQdxjK9tIrVkngmFSLpbzHPMYMgoKY63Dlg8=;
  b=KUlqzjDk4WB6+BABvNMD6QyIlGCRvHjbH9Rig3bXj3c1AfEq2NSwnwGM
   bD3BybgNft31FKHClmw8YvpSh4ZUQjoax0Lys5XSTVpa+MK5KMKAgayLK
   yiCwYDsFQNdEp0iqECyjA4FVqsNE7wrB6BfOZEF37VBdTnB245GTpk5Gt
   BDUihB9YhbJsoe9KzPE0Dgc0siFQw7XxEJYh4CCJSpZ0UttGYadKX2DlT
   mQmdz1vqCKLEP2YvfKHn8NQdPD3RlRnENrBBWfRYFCMq3pV1P66YWmzAe
   32SB6+NZ5Q0nLcSS2gmHFvu+soSllfkUkajm/sCWDTXY4NMUTd75tiQje
   w==;
X-CSE-ConnectionGUID: lPZpYVhKQ52VScYMbWFyqg==
X-CSE-MsgGUID: kLf5K9LVTDuarVN6/vYeDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="52541134"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="52541134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 21:40:46 -0800
X-CSE-ConnectionGUID: uw/eo4+TS7uWvbVF2vLxhQ==
X-CSE-MsgGUID: QQdp3ZhnRbuWEx6cdujz9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="212524131"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 21:40:46 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 21:40:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 21:40:45 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 21:40:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnklhFyRxu+3Z44FEeYVvUW3JIh8XcWRAVoWu0n/Wc4H011byppuB9vBamxdf+JIEx30+XzdUIvS/FzoM2SCl/wOxUiWTQL+1IV7W1dzxs+gQceMfkFGLV43ZE2JvIMDfcMIn4sLQBXOWxDwAT+Yzvbb/qcd7eQVocFuI83p34jt+Asrgt+6QYcaWAUJSLD7W32eUPg0Q7FxPE/11VSfyO5X25dYfjwsCsFhkMCWmjauLoEeEQu21IhjZmJ0o+dhYsjggkKSsozV1m8Zl3wBFqfkUHq2eYhN1/1lAT4a36WWlse++P79FB7oF+Fuf1+PTLM7ihp65wvtdHZCBVhC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jb/xoa//rl6WaW+8Q9653/sPk068USk3dXTvmd3nDk=;
 b=ejJjMc0B6qZQYSnxcXZLQtgrBbgo4nhiug3HkeVZitm+QK6G1MtU969Ruh0pfNY6U8KpM32hhPbYm/cNQVIJJORHQttoEXOIHNGf/5DXWpESWwz/fDMu3JV0VdVQ5ing2eTPAfkL7yKwO7YlznJfWkmh/bt5ljl53+YwJDlifstryNgf8wO560DYhqcOIu44B6Q9iazC6yQzAXyj2FloaB9YAwWWVWAc0PaFmA598sHepAOp9wKF3i1INNE6P6sR2F6UfKB0XwMDYiu443xtyLwd04ekKUPpioewlxIT09d6chUCTRmdwdElrdfu6ebVlGWSS34B1OTJmc1QvDPUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:40:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 05:40:36 +0000
Date: Wed, 12 Nov 2025 13:40:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Edward Adam Davis <eadavis@qq.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, Hillf Danton
	<hdanton@sina.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Max Kellermann <max.kellermann@ionos.com>,
	Tingmao Wang <m@maowtm.org>, <linux-fsdevel@vger.kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	<linux-security-module@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	<syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] fs: Move might_sleep() annotation to iput_final()
Message-ID: <202511121304.5e522f7b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105193800.2340868-1-mic@digikod.net>
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 13672eac-c2ba-4d55-7d0e-08de21ae0167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DUWHQN35pDJFMCtJ/F+32kgzBf98fB2+xLqTphbKeNoc2zCe90pXIP3IdUzP?=
 =?us-ascii?Q?c6TdeqImt9IOEjDm2oq/1g0O4Fbk4Y4USCDy8UuwO4EWZ/Hn3vTTcHkYm842?=
 =?us-ascii?Q?71dgJxoczJ0pco5I3dDxub9uRhwfHyIbjSbyErm4hpPD3KVR4wtsFq7kUU1R?=
 =?us-ascii?Q?1aTJzb96Z+9MUf856qrOieZk2FzP9p1PZJdnWg8M0EhvfEpNMZsDN1vVrxdD?=
 =?us-ascii?Q?Ws2pnfSwpNQgnwj7kdz6x+n+/2r1r7LXQziHmYqIyX8BeoydfKExH9I0UDge?=
 =?us-ascii?Q?qwbcL+nqIj8dzz2WLMEkQveqlleCtl+LmkMzrM9Kp+tj1H1wC1IKVsEAYdyf?=
 =?us-ascii?Q?ElKe6O3ruDu82uN4ZNkVD44LSt/34LmGi6C6lS1QLjgnei1nzbLh3olrXXa6?=
 =?us-ascii?Q?ZU/ysJuUZvMF+nIXRJOHVHLeLu6jlur6XqFaWyU1zv9rn49zZNwIHx+lD9/Y?=
 =?us-ascii?Q?3BKbjEU1qBGOWIYaRYz+fDsmZQIGYIEVJBexhMnQQctc/avrO/4siZ8yIZIo?=
 =?us-ascii?Q?fmzUE9yphS6p21GJoM+QqG7jZ8UtnkjKXEeh4v1+OIccSBkbS9FhS9Jk7n1H?=
 =?us-ascii?Q?365sqVQQzgreZf44HHzBeNZungXTA24DAolBdiW8wW0hAapXH5HjU5jvrDHI?=
 =?us-ascii?Q?eh2yqgcA1chgOIiYqCKVzV1mSGpzPBK3D+u4SLALA7XLzgVOJJX2gQc4NMIr?=
 =?us-ascii?Q?8LjJ+ERoRVQ1HGYsL92LE46i2DIT5g4P3Yv3OlFQA7Kmu/hmukmDHHdWBppR?=
 =?us-ascii?Q?cVkc1e9jFyxjm06fju6MAUO/zLf7moRR4SFxYrnZBm068nUGfWenbIAJZon3?=
 =?us-ascii?Q?2D6/rRufT+LVRTHQp4DTV2tWVVpMZNGnC0+i0K9EOuDfkbPZs28g6LXMONvd?=
 =?us-ascii?Q?FrzqFKmmKLifs7c/7rOnv1As5DT74xDpYckEiIW2GZ9lo4O1uvX1Kc6hj6Fl?=
 =?us-ascii?Q?SdqceybGMGFw8aStezULC/cA150LLPcmx8xF+4utmULUiYq2FWD5D5MG3zGr?=
 =?us-ascii?Q?OPG4wKEjHQFmk6Oe7Nz5rCjzQPOXVED4DK+Pw0km0dB66dE3zedjhDBBwp1R?=
 =?us-ascii?Q?b0KXQovFdsDlq4IK/BImavMSg9f6D6J+mN2kltD5xkGs2ZagmhOC6t3a4TT6?=
 =?us-ascii?Q?UMbbSHOTZ2tU7Bd7EqHf3kVRM9WeBhpwE1FOKagwZ1TGF20Fe1rv71OpwYa1?=
 =?us-ascii?Q?ts1CO8lV3UZfytOq4fRPWv2gnXG68mA8wWF3Y9g5DBwpNVyVMhtFgusbbTVx?=
 =?us-ascii?Q?5jYPelUuCBQXeiputq1UTGbjdGPIQkxN5eZJU1+7InFwRV50uk6poKx/L1GB?=
 =?us-ascii?Q?dikS8/em3f98J99rlHG0xW9NrMWiowMUCygQaSq7dAgQYpa+vpaYTuSyxU3c?=
 =?us-ascii?Q?EDGqJph5zmTR2toHQdX9xhd72xcUqf0raDjnbeqrCOMaeYcNKcPIXrnCReTr?=
 =?us-ascii?Q?i+e72+sDiL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NslBmpc2hNluXjoTwmi84z98BHdNz7T91QCv1e3kkbFe9amJNI7TecwVBe+O?=
 =?us-ascii?Q?rEBH+QioBzBTLr3KtBx53+ZbQyUshxiOybEAGYMFH0v/esqYKUhUQ99EfmBl?=
 =?us-ascii?Q?nPxKEeZkHFRSlLtX974sLoe83HnFHYx8+QM0A9mmquYMTf3ASrKRfC2qnRT7?=
 =?us-ascii?Q?dmWP+wULOdIg5VLS5rUSHY4hIRUtlew3z7nj8/mTnWPKiFseS7GeUCB2FQLb?=
 =?us-ascii?Q?OkEjl0iXbRmB2W7sS97/ZxUdnnIaL+rHhZnBsUlR1Exk2rYkmYH2zk5jC+qs?=
 =?us-ascii?Q?8AIXS5qgvjWQgdhnibJ7hCt9knH4m9MLdWWexR0IZqaQ/ZX1UENyytFLl6Sx?=
 =?us-ascii?Q?+Cs/T/M8z26Rh6hSXbAGWjueFr3KsvBrORXF0jOYmY/7NdRv9iu8JNjNjC11?=
 =?us-ascii?Q?25L/xGMAFEyM5Ylro6zvxySkI+IzQ2cKrKFcEkmeAsDsZUnzI268dOsMtuBF?=
 =?us-ascii?Q?BvDfg06HWKFPWGw85cZ8EFbj+5n6uwjZx1T0nevZjDTNIlDbrw9DM0ujTAlF?=
 =?us-ascii?Q?3Uowx0Mp393izTxRHmCYscV4WoJLtHcWRqixCmd6PoGsLq4agiMlQo5BsUZn?=
 =?us-ascii?Q?K7N8Uor6uOv5pU6HG0rj5TTIGUpGzcyitYcG1vyOpdmcmkdnhtgUf78JLbkZ?=
 =?us-ascii?Q?eAccZf8pS8SpwWCeMRybzjs6rTY7Oa/Dj/sltUUqD2P9MT5YleyYL4A9uaNm?=
 =?us-ascii?Q?eA4Zeh45Tm9ulRgetjEgNT+ltUffgb0G+CbVt0Vsyr44D2ftho3zzDBqnW59?=
 =?us-ascii?Q?qUPnepJLLQgLuBs4vMg98cNhMElO8/XCmuR4W/jHnApb6q77mpyMFf6GhNos?=
 =?us-ascii?Q?33p6raZH3ZR6dwHYk+Th5p44754nduxqthsbfaKWfmunN5CLHSyTnBvnbjka?=
 =?us-ascii?Q?hplQet/9gTj0LzZFYKNlp/EZ//mExnRw8ryDr7Xl6IOk87bdGHdEqYyHSbzO?=
 =?us-ascii?Q?M38vTyL2MFX0bmqwEbUMKrkOyDgEIx8BZU71xBcc1RjSYCpxJvmlaLlUQs9U?=
 =?us-ascii?Q?PNB1nbaLC4jB6C+uP3iSK4c92XJFle0ImCuPmtEoUc0JiEP9goak4LMXzUQ+?=
 =?us-ascii?Q?88sxFqv0U/OxXLXfehpvtNKoyuK53JIKBugPUpY+0ef2pEXFNoRUwm+ZxunE?=
 =?us-ascii?Q?/FGdFoUnBLx2npuvD8RXMDdxyfYKBZ++4RP8bNpVDa+YKh8hQTmU3BGf1rHo?=
 =?us-ascii?Q?5tnMG5P/UrbXYhG/Rs1gmeTb2o5E6ZjjpavqvEfoQySDRRl60d0QVzWhoRGL?=
 =?us-ascii?Q?S2QWQdvnihg9dmlsAz9sAnBCgv+3l2zEz96DynY3ZJ3acSiMHcd2I7r0qKsE?=
 =?us-ascii?Q?F2lYr5ZoBMW/XpTQTmJLhOx1IRxOgLHbqwVk6qU8+zDxIIQ95aqM5Ttj+POw?=
 =?us-ascii?Q?TWDfZuRy9GI1t2I+sFjZFNn/fVdBM82GToOoQM2tD+HVHRfcpZWMXdHDT+5B?=
 =?us-ascii?Q?hTtck4aDgvcQtEaBfZ5+v12Z97xDmIryEM27ZfAE4Nx4dNt8FWx1S9TYRV/A?=
 =?us-ascii?Q?D038hCa4a9UG1OHArZslOV3q/MiBBCejRyL1DopYy5NDBgHjLZZLqmj2O1XN?=
 =?us-ascii?Q?pupfto0+9/JugcYv/UDYpia8LTur8tZylE11xpE3DpLNn8VyxgMo2dMwvBgK?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13672eac-c2ba-4d55-7d0e-08de21ae0167
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:40:36.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiCUzoY+4u3gSdk4WnoehANNP8vS323hbBgkJ7cMTVwwFtwkXiFve0HGN0wyoOXl90Msfs//FkJdAkRv1nR5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_fs/inode.c" on:

commit: 29fb8368dfb5d1f784fd936cec578c9601d77325 ("[PATCH v1] fs: Move might_sleep() annotation to iput_final()")
url: https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/fs-Move-might_sleep-annotation-to-iput_final/20251106-060704
patch link: https://lore.kernel.org/all/20251105193800.2340868-1-mic@digikod.net/
patch subject: [PATCH v1] fs: Move might_sleep() annotation to iput_final()

in testcase: boot

config: x86_64-rhel-9.4-rust
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511121304.5e522f7b-lkp@intel.com


[   18.387422][    T1] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   18.389429][    T1] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: init
[   18.390340][    T1] preempt_count: 1, expected: 0
[   18.390892][    T1] RCU nest depth: 0, expected: 0
[   18.391438][    T1] CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   18.391441][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   18.391443][    T1] Call Trace:
[   18.392215][    T1]  <TASK>
[   18.392219][    T1]  dump_stack_lvl (lib/dump_stack.c:123)
[   18.392228][    T1]  __might_resched (kernel/sched/core.c:8838)
[   18.393064][    T1]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   18.393072][    T1]  __dentry_kill (fs/dcache.c:?)
[   18.393075][    T1]  dput (fs/dcache.c:912)
[   18.393077][    T1]  __fput (fs/file_table.c:477)
[   18.393081][    T1]  __x64_sys_close (fs/open.c:1591)
[   18.393082][    T1]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   18.393086][    T1]  ? __x64_sys_connect (net/socket.c:2131 net/socket.c:2128 net/socket.c:2128)
[   18.393098][    T1]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   18.393099][    T1]  ? kmem_cache_alloc_noprof (include/linux/kernel.h:?)
[   18.393104][    T1]  ? alloc_empty_file (fs/file_table.c:238)
[   18.393105][    T1]  ? init_file (fs/file_table.c:174)
[   18.393107][    T1]  ? file_init_path (fs/file_table.c:326)
[   18.393108][    T1]  ? alloc_file_pseudo (fs/file_table.c:?)
[   18.393110][    T1]  ? sock_alloc_file (net/socket.c:?)
[   18.393113][    T1]  ? __sys_socket (net/socket.c:?)
[   18.393115][    T1]  ? __x64_sys_socket (net/socket.c:1765 net/socket.c:1763 net/socket.c:1763)
[   18.393117][    T1]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   18.393119][    T1]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   18.393121][    T1] RIP: 0033:0x7fcfd14c3040
[   18.393126][    T1] Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 99 09 00 e8 a0 3f 02 00 83 3d 9d 71 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 9e b1 01 00 48 89 04 24
All code
========
   0:	40 75 0b             	rex jne 0xe
   3:	31 c0                	xor    %eax,%eax
   5:	48 83 c4 08          	add    $0x8,%rsp
   9:	e9 0c ff ff ff       	jmp    0xffffffffffffff1a
   e:	48 8d 3d c5 99 09 00 	lea    0x999c5(%rip),%rdi        # 0x999da
  15:	e8 a0 3f 02 00       	call   0x23fba
  1a:	83 3d 9d 71 2d 00 00 	cmpl   $0x0,0x2d719d(%rip)        # 0x2d71be
  21:	75 10                	jne    0x33
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 31                	jae    0x63
  32:	c3                   	ret
  33:	48 83 ec 08          	sub    $0x8,%rsp
  37:	e8 9e b1 01 00       	call   0x1b1da
  3c:	48 89 04 24          	mov    %rax,(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 31                	jae    0x39
   8:	c3                   	ret
   9:	48 83 ec 08          	sub    $0x8,%rsp
   d:	e8 9e b1 01 00       	call   0x1b1b0
  12:	48 89 04 24          	mov    %rax,(%rsp)
[   18.393128][    T1] RSP: 002b:00007ffd4cbc7398 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   18.393131][    T1] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcfd14c3040
[   18.393132][    T1] RDX: 00007fcfd1526f2c RSI: 0000000000000000 RDI: 0000000000000008
[   18.393133][    T1] RBP: 0000000000000008 R08: 0000000000000003 R09: 0000000000000000
[   18.393134][    T1] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcfd221b6a0
[   18.393135][    T1] R13: 00007fcfd15563cb R14: 00000000ffffffff R15: 0000000000000000
[   18.393137][    T1]  </TASK>
LKP: ttyS0: 86: skip deploy intel ucode as no ucode is specified
LKP: ttyS0: 86: Kernel tests: Boot OK!
LKP: ttyS0: 86: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 1
[   18.589452][  T181] udevd[181]: starting version 175
[   18.598118][  T107] is_virt=true
[   18.598124][  T107]
[   18.603531][  T107] lkp: kernel tainted state: 512
[   18.603537][  T107]
[   18.612979][  T107] LKP: stdout: 86: Kernel tests: Boot OK!
[   18.612986][  T107]
LKP: ttyS0: 86:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml
[   18.661802][  T107] LKP: stdout: 86: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 1
[   18.661809][  T107]
[   18.676637][  T107] NO_NETWORK=
[   18.676643][  T107]
[   18.680228][  T200] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[   18.690939][  T107] INFO: lkp CACHE_DIR is /tmp/cache
[   18.690945][  T107]
[   18.694448][  T200] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[   18.761028][  T107] LKP: stdout: 86:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml
[   18.761038][  T107]
[   18.781039][  T107] RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-9.4-rust/clang-20/29fb8368dfb5d1f784fd936cec578c9601d77325/0
[   18.781047][  T107]
[   18.805586][  T107] job=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml
[   18.805592][  T107]
[   18.857299][  T201] libata version 3.00 loaded.
[   18.872519][  T107] result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-9.4-rust/clang-20/29fb8368dfb5d1f784fd936cec578c9601d77325/0, TMP_RESULT_ROOT: /tmp/lkp/result
[   18.872526][  T107]
[   18.880780][  T201] scsi host0: ata_piix
[   18.899515][  T107] run-job /lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml
[   18.899520][  T107]
[   18.908385][  T201] scsi host1: ata_piix
[   18.910926][  T201] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc140 irq 14 lpm-pol 0
[   18.911964][  T201] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc148 irq 15 lpm-pol 0
[   18.932209][  T107] /usr/bin/wget -nv --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&job_state=running -O /dev/null
[   18.932216][  T107]
[   18.974405][  T212] ACPI: bus type drm_connector registered
[   18.978482][    T1] init: failsafe main process (320) killed by TERM signal
[   19.074983][  T307] ata2: found unknown device (class 0)
[   19.076067][  T307] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   19.077908][   T12] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[   19.099276][  T312] parport_pc 00:03: reported by Plug and Play ACPI
[   19.104906][  T312] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   19.190656][  T384] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   19.191608][  T384] cdrom: Uniform CD-ROM driver Revision: 3.20
[   19.201172][  T212] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   19.206902][  T212] Console: switching to colour dummy device 80x25
[   19.207699][  T212] [drm] Found bochs VGA, ID 0xb0c5.
[   19.208107][  T212] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[   19.209140][  T212] [drm] Initialized bochs-drm 1.0.0 for 0000:00:02.0 on minor 0
[   19.216585][  T212] fbcon: bochs-drmdrmfb (fb0) is primary device
[   19.233924][  T384] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   19.236779][  T212] Console: switching to colour frame buffer device 160x50
[   19.296502][  T212] bochs-drm 0000:00:02.0: [drm] fb0: bochs-drmdrmfb frame buffer device
[   19.300750][  T391] ppdev: user-space parallel port driver
[   19.386935][   T82] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   19.387879][   T82] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 82, name: plymouthd
[   19.388607][   T82] preempt_count: 1, expected: 0
[   19.389718][   T82] RCU nest depth: 0, expected: 0
[   19.391578][   T82] CPU: 1 UID: 0 PID: 82 Comm: plymouthd Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   19.391582][   T82] Tainted: [W]=WARN
[   19.391583][   T82] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   19.391584][   T82] Call Trace:
[   19.391587][   T82]  <TASK>
[   19.391590][   T82]  dump_stack_lvl (lib/dump_stack.c:123)
[   19.391599][   T82]  __might_resched (kernel/sched/core.c:8838)
[   19.391605][   T82]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   19.391609][   T82]  __dentry_kill (fs/dcache.c:?)
[   19.391613][   T82]  dput (fs/dcache.c:912)
[   19.391615][   T82]  __fput (fs/file_table.c:477)
[   19.391625][   T82]  __x64_sys_close (fs/open.c:1591)
[   19.391627][   T82]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   19.391631][   T82]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   19.391633][   T82]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   19.391635][   T82]  ? __x64_sys_sendto (net/socket.c:2255 net/socket.c:2251 net/socket.c:2251)
[   19.391645][   T82]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   19.391647][   T82]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   19.391650][   T82] RIP: 0033:0x7ff9cf9f9040
[   19.391654][   T82] Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 99 09 00 e8 a0 3f 02 00 83 3d 9d 71 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 9e b1 01 00 48 89 04 24
All code
========
   0:	40 75 0b             	rex jne 0xe
   3:	31 c0                	xor    %eax,%eax
   5:	48 83 c4 08          	add    $0x8,%rsp
   9:	e9 0c ff ff ff       	jmp    0xffffffffffffff1a
   e:	48 8d 3d c5 99 09 00 	lea    0x999c5(%rip),%rdi        # 0x999da
  15:	e8 a0 3f 02 00       	call   0x23fba
  1a:	83 3d 9d 71 2d 00 00 	cmpl   $0x0,0x2d719d(%rip)        # 0x2d71be
  21:	75 10                	jne    0x33
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 31                	jae    0x63
  32:	c3                   	ret
  33:	48 83 ec 08          	sub    $0x8,%rsp
  37:	e8 9e b1 01 00       	call   0x1b1da
  3c:	48 89 04 24          	mov    %rax,(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 31                	jae    0x39
   8:	c3                   	ret
   9:	48 83 ec 08          	sub    $0x8,%rsp
   d:	e8 9e b1 01 00       	call   0x1b1b0
  12:	48 89 04 24          	mov    %rax,(%rsp)
[   19.391656][   T82] RSP: 002b:00007ffd01a06c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   19.391659][   T82] RAX: ffffffffffffffda RBX: 0000000034e212e0 RCX: 00007ff9cf9f9040
[   19.391661][   T82] RDX: 00007ffd01a06cbc RSI: 0000000034e212e0 RDI: 0000000000000007
[   19.391662][   T82] RBP: 0000000034e20f50 R08: 00000000118a0360 R09: 7fffffffffffffff
[   19.391664][   T82] R10: 3fffffffffffffff R11: 0000000000000246 R12: 0000000034e215a0
[   19.391668][   T82] R13: 0000000034e21570 R14: 0000000000000058 R15: 0000000000000000
[   19.391670][   T82]  </TASK>
[   19.684798][    C0] hrtimer: interrupt took 7335062 ns
[   19.697123][  T109] 2025-11-10 18:26:34 URL:http://internal-lkp-server/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&job_state=running [0/0] -> "/dev/null" [1]
[   19.773587][  T109]
[   19.827552][  T107] target ucode:
[   19.827558][  T107]
[   19.854980][  T107] check_nr_cpu
[   19.872576][  T107]
[   19.875184][  T107] CPU(s):                2
[   19.877090][  T107]
[   19.888546][  T107] On-line CPU(s) list:   0,1
[   19.888553][  T107]
[   19.922264][  T107] Thread(s) per core:    1
[   19.922272][  T107]
[   19.925376][  T107] Core(s) per socket:    2
[   19.925383][  T107]
[   19.942720][  T107] Socket(s):             1
[   19.942727][  T107]
[   19.966452][  T107] NUMA node(s):          1
[   19.966460][  T107]
[   19.981930][  T107] NUMA node0 CPU(s):     0,1
[   19.981942][  T107]
[   20.557619][  T497] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   20.558839][  T497] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 497, name: udevd
[   20.559927][  T497] preempt_count: 1, expected: 0
[   20.562617][  T497] RCU nest depth: 0, expected: 0
[   20.563969][  T497] CPU: 0 UID: 0 PID: 497 Comm: udevd Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   20.563978][  T497] Tainted: [W]=WARN
[   20.563979][  T497] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   20.563981][  T497] Call Trace:
[   20.563986][  T497]  <TASK>
[   20.563989][  T497]  dump_stack_lvl (lib/dump_stack.c:123)
[   20.563999][  T497]  __might_resched (kernel/sched/core.c:8838)
[   20.564004][  T497]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   20.564008][  T497]  __dentry_kill (fs/dcache.c:?)
[   20.564012][  T497]  shrink_dentry_list (fs/dcache.c:1114)
[   20.564015][  T497]  shrink_dcache_parent (fs/dcache.c:1550)
[   20.564019][  T497]  d_invalidate (fs/dcache.c:1660)
[   20.564022][  T497]  proc_invalidate_siblings_dcache (fs/proc/inode.c:143)
[   20.564026][  T497]  release_task (kernel/exit.c:292)
[   20.564030][  T497]  wait_consider_task (kernel/exit.c:1276)
[   20.564033][  T497]  ? do_wait (kernel/exit.c:1714)
[   20.564035][  T497]  __do_wait (kernel/exit.c:1640 kernel/exit.c:1674)
[   20.564037][  T497]  ? do_wait (kernel/exit.c:1714)
[   20.564039][  T497]  do_wait (kernel/exit.c:1716)
[   20.564041][  T497]  kernel_wait4 (kernel/exit.c:1874)
[   20.564043][  T497]  ? get_task_struct (kernel/exit.c:1599)
[   20.564045][  T497]  __x64_sys_wait4 (kernel/exit.c:1902 kernel/exit.c:1898 kernel/exit.c:1898)
[   20.564048][  T497]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   20.564052][  T497]  ? vfs_read (fs/read_write.c:492)
[   20.564055][  T497]  ? __x64_sys_read (fs/read_write.c:?)
[   20.564056][  T497]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   20.564058][  T497]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   20.564061][  T497]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   20.564064][  T497] RIP: 0033:0x7f0bbd443c3e
[   20.564068][  T497] Code: 00 f7 d8 64 89 02 48 89 f8 eb cc 90 48 83 ec 28 8b 05 aa e5 2f 00 85 c0 75 1d 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 48 83 c4 28 c3 89 54 24 08 48 89 74 24 10
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   6:	48 89 f8             	mov    %rdi,%rax
   9:	eb cc                	jmp    0xffffffffffffffd7
   b:	90                   	nop
   c:	48 83 ec 28          	sub    $0x28,%rsp
  10:	8b 05 aa e5 2f 00    	mov    0x2fe5aa(%rip),%eax        # 0x2fe5c0
  16:	85 c0                	test   %eax,%eax
  18:	75 1d                	jne    0x37
  1a:	45 31 d2             	xor    %r10d,%r10d
  1d:	48 63 d2             	movslq %edx,%rdx
  20:	48 63 ff             	movslq %edi,%rdi
  23:	b8 3d 00 00 00       	mov    $0x3d,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 51                	ja     0x83
  32:	48 83 c4 28          	add    $0x28,%rsp
  36:	c3                   	ret
  37:	89 54 24 08          	mov    %edx,0x8(%rsp)
  3b:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 51                	ja     0x59
   8:	48 83 c4 28          	add    $0x28,%rsp
   c:	c3                   	ret
   d:	89 54 24 08          	mov    %edx,0x8(%rsp)
  11:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
[   20.564071][  T497] RSP: 002b:00007fff65aecee0 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
[   20.564074][  T497] RAX: ffffffffffffffda RBX: 0000556a4924f6d0 RCX: 00007f0bbd443c3e
[   20.564076][  T497] RDX: 0000000000000001 RSI: 00007fff65aedfe4 RDI: 00000000000001f2
[   20.564077][  T497] RBP: 0000000000000000 R08: 000000001bb5db01 R09: 7fffffffffffffff
[   20.564079][  T497] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff65af3948
[   20.564080][  T497] R13: 00000000000001f2 R14: 0000556a49215250 R15: 00000000000003e8
[   20.564083][  T497]  </TASK>
[   20.689253][    T1] init: networking main process (512) terminated with status 1
[   21.005572][  T107] sleep started
[   21.005581][  T107]
[   22.006385][  T210] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   22.007457][  T210] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 210, name: run-lkp
[   22.008482][  T210] preempt_count: 1, expected: 0
[   22.009261][  T210] RCU nest depth: 0, expected: 0
[   22.009992][  T210] CPU: 1 UID: 0 PID: 210 Comm: run-lkp Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   22.009996][  T210] Tainted: [W]=WARN
[   22.009997][  T210] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   22.009999][  T210] Call Trace:
[   22.010003][  T210]  <TASK>
[   22.010005][  T210]  dump_stack_lvl (lib/dump_stack.c:123)
[   22.010015][  T210]  __might_resched (kernel/sched/core.c:8838)
[   22.010021][  T210]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   22.010026][  T210]  __dentry_kill (fs/dcache.c:?)
[   22.010030][  T210]  shrink_dentry_list (fs/dcache.c:1114)
[   22.010034][  T210]  shrink_dcache_parent (fs/dcache.c:1550)
[   22.010037][  T210]  d_invalidate (fs/dcache.c:1660)
[   22.010040][  T210]  proc_invalidate_siblings_dcache (fs/proc/inode.c:143)
[   22.010046][  T210]  release_task (kernel/exit.c:292)
[   22.010051][  T210]  wait_consider_task (kernel/exit.c:1276)
[   22.010057][  T210]  __do_wait (kernel/exit.c:1565 kernel/exit.c:1681)
[   22.010059][  T210]  ? do_wait (kernel/exit.c:1714)
[   22.010061][  T210]  do_wait (kernel/exit.c:1716)
[   22.010063][  T210]  kernel_wait4 (kernel/exit.c:1874)
[   22.010066][  T210]  ? get_task_struct (kernel/exit.c:1599)
[   22.010069][  T210]  __x64_sys_wait4 (kernel/exit.c:1902 kernel/exit.c:1898 kernel/exit.c:1898)
[   22.010071][  T210]  ? count_memcg_events (mm/memcontrol.c:? mm/memcontrol.c:847)
[   22.010073][  T210]  ? handle_mm_fault (mm/memory.c:6423)
[   22.010078][  T210]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   22.010082][  T210]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   22.010086][  T210]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   22.010089][  T210]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   22.010093][  T210] RIP: 0033:0x7fe001e18c3e
[   22.010097][  T210] Code: 00 f7 d8 64 89 02 48 89 f8 eb cc 90 48 83 ec 28 8b 05 aa e5 2f 00 85 c0 75 1d 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 48 83 c4 28 c3 89 54 24 08 48 89 74 24 10
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   6:	48 89 f8             	mov    %rdi,%rax
   9:	eb cc                	jmp    0xffffffffffffffd7
   b:	90                   	nop
   c:	48 83 ec 28          	sub    $0x28,%rsp
  10:	8b 05 aa e5 2f 00    	mov    0x2fe5aa(%rip),%eax        # 0x2fe5c0
  16:	85 c0                	test   %eax,%eax
  18:	75 1d                	jne    0x37
  1a:	45 31 d2             	xor    %r10d,%r10d
  1d:	48 63 d2             	movslq %edx,%rdx
  20:	48 63 ff             	movslq %edi,%rdi
  23:	b8 3d 00 00 00       	mov    $0x3d,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 51                	ja     0x83
  32:	48 83 c4 28          	add    $0x28,%rsp
  36:	c3                   	ret
  37:	89 54 24 08          	mov    %edx,0x8(%rsp)
  3b:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 51                	ja     0x59
   8:	48 83 c4 28          	add    $0x28,%rsp
   c:	c3                   	ret
   d:	89 54 24 08          	mov    %edx,0x8(%rsp)
  11:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
[   22.010099][  T210] RSP: 002b:00007ffc8644ef50 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
[   22.010102][  T210] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe001e18c3e
[   22.010104][  T210] RDX: 0000000000000000 RSI: 00007ffc8644efb8 RDI: ffffffffffffffff
[   22.010105][  T210] RBP: 000000003db55300 R08: 000000003db553c8 R09: 0000000000000001
[   22.010107][  T210] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   22.010108][  T210] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000ffffffff
[   22.010110][  T210]  </TASK>
[   22.147235][  T107] /usr/bin/wget -nv --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&job_state=post_run -O /dev/null
[   22.147244][  T107]
[   22.859171][  T109] 2025-11-10 18:26:38 URL:http://internal-lkp-server/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&job_state=post_run [0/0] -> "/dev/null" [1]
[   22.859180][  T109]
[   23.872028][  T539] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   23.873181][  T539] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 539, name: post-run
[   23.875374][  T539] preempt_count: 1, expected: 0
[   23.876396][  T539] RCU nest depth: 0, expected: 0
[   23.877455][  T539] CPU: 1 UID: 0 PID: 539 Comm: post-run Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   23.877459][  T539] Tainted: [W]=WARN
[   23.877460][  T539] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   23.877461][  T539] Call Trace:
[   23.877465][  T539]  <TASK>
[   23.877467][  T539]  dump_stack_lvl (lib/dump_stack.c:123)
[   23.877475][  T539]  __might_resched (kernel/sched/core.c:8838)
[   23.877480][  T539]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   23.877484][  T539]  __dentry_kill (fs/dcache.c:?)
[   23.877488][  T539]  dput (fs/dcache.c:912)
[   23.877490][  T539]  __fput (fs/file_table.c:477)
[   23.877494][  T539]  __x64_sys_close (fs/open.c:1591)
[   23.877496][  T539]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   23.877499][  T539]  ? handle_mm_fault (mm/memory.c:6423)
[   23.877504][  T539]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   23.877508][  T539]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   23.877510][  T539]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   23.877513][  T539]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   23.877516][  T539] RIP: 0033:0x7f1031cde040
[   23.877519][  T539] Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 99 09 00 e8 a0 3f 02 00 83 3d 9d 71 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 9e b1 01 00 48 89 04 24
All code
========
   0:	40 75 0b             	rex jne 0xe
   3:	31 c0                	xor    %eax,%eax
   5:	48 83 c4 08          	add    $0x8,%rsp
   9:	e9 0c ff ff ff       	jmp    0xffffffffffffff1a
   e:	48 8d 3d c5 99 09 00 	lea    0x999c5(%rip),%rdi        # 0x999da
  15:	e8 a0 3f 02 00       	call   0x23fba
  1a:	83 3d 9d 71 2d 00 00 	cmpl   $0x0,0x2d719d(%rip)        # 0x2d71be
  21:	75 10                	jne    0x33
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 31                	jae    0x63
  32:	c3                   	ret
  33:	48 83 ec 08          	sub    $0x8,%rsp
  37:	e8 9e b1 01 00       	call   0x1b1da
  3c:	48 89 04 24          	mov    %rax,(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 31                	jae    0x39
   8:	c3                   	ret
   9:	48 83 ec 08          	sub    $0x8,%rsp
   d:	e8 9e b1 01 00       	call   0x1b1b0
  12:	48 89 04 24          	mov    %rax,(%rsp)
[   23.877521][  T539] RSP: 002b:00007fff879e0888 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   23.877524][  T539] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f1031cde040
[   23.877525][  T539] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000003
[   23.877526][  T539] RBP: 0000000000000000 R08: 000000000000000a R09: 0000000000000000
[   23.877527][  T539] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff879e08e4
[   23.877528][  T539] R13: 0000000000000080 R14: 000000000000000a R15: 000000001dc63a08
[   23.877530][  T539]  </TASK>
[   23.937654][  T107] kill 429 vmstat -n 10
[   23.937662][  T107]
[   23.944123][  T107] kill 425 cat /proc/kmsg
[   23.944131][  T107]
[   23.962000][  T107] wait for background processes: 435 432 oom-killer meminfo
[   23.962008][  T107]
[   24.972654][  T561] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   24.973813][  T561] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 561, name: post-run
[   24.974943][  T561] preempt_count: 1, expected: 0
[   24.975752][  T561] RCU nest depth: 0, expected: 0
[   24.976454][  T561] CPU: 1 UID: 0 PID: 561 Comm: post-run Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   24.976459][  T561] Tainted: [W]=WARN
[   24.976459][  T561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   24.976461][  T561] Call Trace:
[   24.976464][  T561]  <TASK>
[   24.976466][  T561]  dump_stack_lvl (lib/dump_stack.c:123)
[   24.976476][  T561]  __might_resched (kernel/sched/core.c:8838)
[   24.976485][  T561]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   24.976489][  T561]  __dentry_kill (fs/dcache.c:?)
[   24.976492][  T561]  shrink_dentry_list (fs/dcache.c:1114)
[   24.976495][  T561]  shrink_dcache_parent (fs/dcache.c:1550)
[   24.976498][  T561]  d_invalidate (fs/dcache.c:1660)
[   24.976502][  T561]  proc_invalidate_siblings_dcache (fs/proc/inode.c:143)
[   24.976507][  T561]  release_task (kernel/exit.c:292)
[   24.976510][  T561]  wait_consider_task (kernel/exit.c:1276)
[   24.976513][  T561]  __do_wait (kernel/exit.c:1565 kernel/exit.c:1681)
[   24.976515][  T561]  ? do_wait (kernel/exit.c:1714)
[   24.976517][  T561]  do_wait (kernel/exit.c:1716)
[   24.976519][  T561]  kernel_wait4 (kernel/exit.c:1874)
[   24.976522][  T561]  ? get_task_struct (kernel/exit.c:1599)
[   24.976524][  T561]  __x64_sys_wait4 (kernel/exit.c:1902 kernel/exit.c:1898 kernel/exit.c:1898)
[   24.976526][  T561]  ? _copy_to_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:147 include/linux/uaccess.h:204 lib/usercopy.c:26)
[   24.976530][  T561]  ? __x64_sys_rt_sigaction (include/linux/uaccess.h:232 kernel/signal.c:4648 kernel/signal.c:4629 kernel/signal.c:4629)
[   24.976535][  T561]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   24.976538][  T561]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   24.976539][  T561]  ? _copy_from_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:185 lib/usercopy.c:18)
[   24.976541][  T561]  ? __x64_sys_rt_sigprocmask (kernel/signal.c:3340)
[   24.976544][  T561]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   24.976546][  T561]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   24.976549][  T561]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   24.976553][  T561]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   24.976556][  T561] RIP: 0033:0x7f1031cb6c3e
[   24.976560][  T561] Code: 00 f7 d8 64 89 02 48 89 f8 eb cc 90 48 83 ec 28 8b 05 aa e5 2f 00 85 c0 75 1d 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 48 83 c4 28 c3 89 54 24 08 48 89 74 24 10
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   6:	48 89 f8             	mov    %rdi,%rax
   9:	eb cc                	jmp    0xffffffffffffffd7
   b:	90                   	nop
   c:	48 83 ec 28          	sub    $0x28,%rsp
  10:	8b 05 aa e5 2f 00    	mov    0x2fe5aa(%rip),%eax        # 0x2fe5c0
  16:	85 c0                	test   %eax,%eax
  18:	75 1d                	jne    0x37
  1a:	45 31 d2             	xor    %r10d,%r10d
  1d:	48 63 d2             	movslq %edx,%rdx
  20:	48 63 ff             	movslq %edi,%rdi
  23:	b8 3d 00 00 00       	mov    $0x3d,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 51                	ja     0x83
  32:	48 83 c4 28          	add    $0x28,%rsp
  36:	c3                   	ret
  37:	89 54 24 08          	mov    %edx,0x8(%rsp)
  3b:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 51                	ja     0x59
   8:	48 83 c4 28          	add    $0x28,%rsp
   c:	c3                   	ret
   d:	89 54 24 08          	mov    %edx,0x8(%rsp)
  11:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
[   24.976562][  T561] RSP: 002b:00007fff879dfb10 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
[   24.976564][  T561] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1031cb6c3e
[   24.976566][  T561] RDX: 0000000000000000 RSI: 00007fff879dfb78 RDI: ffffffffffffffff
[   24.976567][  T561] RBP: 000000001dc65f00 R08: 000000001dc65f48 R09: 0000000000000000
[   24.976568][  T561] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   24.976570][  T561] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000ffffffff
[   24.976572][  T561]  </TASK>
[   26.014722][  T539] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   26.015763][  T539] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 539, name: post-run
[   26.016818][  T539] preempt_count: 1, expected: 0
[   26.017515][  T539] RCU nest depth: 0, expected: 0
[   26.018261][  T539] CPU: 0 UID: 0 PID: 539 Comm: post-run Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   26.018266][  T539] Tainted: [W]=WARN
[   26.018266][  T539] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   26.018268][  T539] Call Trace:
[   26.018271][  T539]  <TASK>
[   26.018274][  T539]  dump_stack_lvl (lib/dump_stack.c:123)
[   26.018284][  T539]  __might_resched (kernel/sched/core.c:8838)
[   26.018289][  T539]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   26.018293][  T539]  __dentry_kill (fs/dcache.c:?)
[   26.018296][  T539]  dput (fs/dcache.c:912)
[   26.018299][  T539]  __fput (fs/file_table.c:477)
[   26.018302][  T539]  __x64_sys_close (fs/open.c:1591)
[   26.018305][  T539]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   26.018309][  T539]  ? mutex_lock (arch/x86/include/asm/current.h:25 kernel/locking/mutex.c:152 kernel/locking/mutex.c:273)
[   26.018311][  T539]  ? anon_pipe_read (fs/pipe.c:404)
[   26.018313][  T539]  ? arch_exit_to_user_mode_prepare (arch/x86/include/asm/entry-common.h:?)
[   26.018317][  T539]  ? vfs_read (fs/read_write.c:492)
[   26.018319][  T539]  ? __x64_sys_read (fs/read_write.c:?)
[   26.018321][  T539]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   26.018323][  T539]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   26.018324][  T539]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   26.018328][  T539]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   26.018332][  T539]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   26.018334][  T539] RIP: 0033:0x7f1031cde040
[   26.018338][  T539] Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 99 09 00 e8 a0 3f 02 00 83 3d 9d 71 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 9e b1 01 00 48 89 04 24
All code
========
   0:	40 75 0b             	rex jne 0xe
   3:	31 c0                	xor    %eax,%eax
   5:	48 83 c4 08          	add    $0x8,%rsp
   9:	e9 0c ff ff ff       	jmp    0xffffffffffffff1a
   e:	48 8d 3d c5 99 09 00 	lea    0x999c5(%rip),%rdi        # 0x999da
  15:	e8 a0 3f 02 00       	call   0x23fba
  1a:	83 3d 9d 71 2d 00 00 	cmpl   $0x0,0x2d719d(%rip)        # 0x2d71be
  21:	75 10                	jne    0x33
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 31                	jae    0x63
  32:	c3                   	ret
  33:	48 83 ec 08          	sub    $0x8,%rsp
  37:	e8 9e b1 01 00       	call   0x1b1da
  3c:	48 89 04 24          	mov    %rax,(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 31                	jae    0x39
   8:	c3                   	ret
   9:	48 83 ec 08          	sub    $0x8,%rsp
   d:	e8 9e b1 01 00       	call   0x1b1b0
  12:	48 89 04 24          	mov    %rax,(%rsp)
[   26.018340][  T539] RSP: 002b:00007fff879e0888 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   26.018343][  T539] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f1031cde040
[   26.018345][  T539] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000003
[   26.018346][  T539] RBP: 0000000000000000 R08: 000000000000000a R09: 0000000000000000
[   26.018347][  T539] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff879e08e4
[   26.018348][  T539] R13: 0000000000000080 R14: 000000000000000a R15: 000000001dc65a08
[   26.018350][  T539]  </TASK>
[   27.079314][  T577] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   27.080408][  T577] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 577, name: grep
[   27.081456][  T577] preempt_count: 1, expected: 0
[   27.082233][  T577] RCU nest depth: 0, expected: 0
[   27.082945][  T577] CPU: 0 UID: 0 PID: 577 Comm: grep Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   27.082949][  T577] Tainted: [W]=WARN
[   27.082950][  T577] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   27.082951][  T577] Call Trace:
[   27.082954][  T577]  <TASK>
[   27.082957][  T577]  dump_stack_lvl (lib/dump_stack.c:123)
[   27.082966][  T577]  __might_resched (kernel/sched/core.c:8838)
[   27.082972][  T577]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   27.082979][  T577]  __dentry_kill (fs/dcache.c:?)
[   27.082983][  T577]  dput (fs/dcache.c:912)
[   27.082986][  T577]  __fput (fs/file_table.c:477)
[   27.082989][  T577]  task_work_run (kernel/task_work.c:235)
[   27.082994][  T577]  do_exit (kernel/exit.c:971)
[   27.082997][  T577]  do_group_exit (kernel/exit.c:1111)
[   27.083000][  T577]  __x64_sys_exit_group (kernel/exit.c:1122)
[   27.083001][  T577]  x64_sys_call (??:?)
[   27.083004][  T577]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   27.083008][  T577]  ? __x64_sys_close (fs/open.c:1591)
[   27.083010][  T577]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   27.083011][  T577]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   27.083015][  T577]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   27.083018][  T577]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   27.083021][  T577] RIP: 0033:0x7f5f03de3408
[   27.083024][  T577] Code: Unable to access opcode bytes at 0x7f5f03de33de.

Code starting with the faulting instruction
===========================================
[   27.083025][  T577] RSP: 002b:00007ffd05f705b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   27.083028][  T577] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f03de3408
[   27.083029][  T577] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   27.083031][  T577] RBP: 00007f5f040d7820 R08: 00000000000000e7 R09: ffffffffffffffa0
[   27.083032][  T577] R10: 00007f5f040ddb80 R11: 0000000000000246 R12: 00007f5f040d7820
[   27.083033][  T577] R13: 0000000000000001 R14: 000000002f100438 R15: 000000000000000a
[   27.083036][  T577]  </TASK>
[   28.126767][  T582] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   28.127828][  T582] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 582, name: grep
[   28.128876][  T582] preempt_count: 1, expected: 0
[   28.129633][  T582] RCU nest depth: 0, expected: 0
[   28.130368][  T582] CPU: 1 UID: 0 PID: 582 Comm: grep Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   28.130373][  T582] Tainted: [W]=WARN
[   28.130374][  T582] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   28.130375][  T582] Call Trace:
[   28.130379][  T582]  <TASK>
[   28.130381][  T582]  dump_stack_lvl (lib/dump_stack.c:123)
[   28.130391][  T582]  __might_resched (kernel/sched/core.c:8838)
[   28.130396][  T582]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   28.130400][  T582]  __dentry_kill (fs/dcache.c:?)
[   28.130404][  T582]  dput (fs/dcache.c:912)
[   28.130407][  T582]  __fput (fs/file_table.c:477)
[   28.130410][  T582]  task_work_run (kernel/task_work.c:235)
[   28.130414][  T582]  do_exit (kernel/exit.c:971)
[   28.130418][  T582]  ? get_page_from_freelist (mm/page_alloc.c:?)
[   28.130421][  T582]  do_group_exit (kernel/exit.c:1111)
[   28.130423][  T582]  __x64_sys_exit_group (kernel/exit.c:1122)
[   28.130425][  T582]  x64_sys_call (??:?)
[   28.130428][  T582]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   28.130431][  T582]  ? __x64_sys_close (fs/open.c:1591)
[   28.130433][  T582]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   28.130435][  T582]  ? __x64_sys_close (fs/open.c:1591)
[   28.130436][  T582]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   28.130438][  T582]  ? alloc_pages_mpol (mm/mempolicy.c:2481)
[   28.130443][  T582]  ? update_curr (kernel/sched/fair.c:1224)
[   28.130445][  T582]  ? place_entity (kernel/sched/fair.c:?)
[   28.130447][  T582]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[   28.130450][  T582]  ? __smp_call_single_queue (kernel/smp.c:117)
[   28.130454][  T582]  ? native_smp_send_reschedule (arch/x86/kernel/apic/ipi.c:78)
[   28.130457][  T582]  ? ttwu_queue_wakelist (kernel/sched/core.c:? kernel/sched/core.c:3880)
[   28.130459][  T582]  ? try_to_wake_up (kernel/sched/core.c:4224)
[   28.130460][  T582]  ? tick_setup_sched_timer (kernel/time/tick-sched.c:307)
[   28.130464][  T582]  ? swake_up_one (include/linux/list.h:226 include/linux/list.h:295 kernel/sched/swait.c:31 kernel/sched/swait.c:53)
[   28.130467][  T582]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[   28.130469][  T582]  ? sched_clock (arch/x86/include/asm/preempt.h:95 arch/x86/kernel/tsc.c:289)
[   28.130477][  T582]  ? sched_clock_cpu (kernel/sched/clock.c:397)
[   28.130478][  T582]  ? irqtime_account_irq (kernel/sched/cputime.c:67)
[   28.130481][  T582]  ? handle_softirqs (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:407 kernel/softirq.c:468 kernel/softirq.c:654)
[   28.130483][  T582]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   28.130486][  T582]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   28.130488][  T582] RIP: 0033:0x7fe98a926408
[   28.130491][  T582] Code: Unable to access opcode bytes at 0x7fe98a9263de.

Code starting with the faulting instruction
===========================================
[   28.130493][  T582] RSP: 002b:00007ffc82246da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   28.130496][  T582] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe98a926408
[   28.130497][  T582] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   28.130498][  T582] RBP: 00007fe98ac1a820 R08: 00000000000000e7 R09: ffffffffffffffa0
[   28.130499][  T582] R10: 00007fe98ac20b80 R11: 0000000000000246 R12: 00007fe98ac1a820
[   28.130501][  T582] R13: 0000000000000001 R14: 0000000012c71014 R15: 000000000000000a
[   28.130503][  T582]  </TASK>
[   28.839638][  T107] /usr/bin/wget -nv --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&loadavg=0.78%200.19%200.06%201/108%20594&start_time=1762799196&end_time=1762799197&version=/lkp/lkp/.src-20251109-171750:1aad5493ad31-dirty:35b842bfeaee-dirty& -O /dev/null
[   28.839648][  T107]
[   29.442824][  T614] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   29.443836][  T614] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 614, name: wget
[   29.444824][  T614] preempt_count: 1, expected: 0
[   29.445535][  T614] RCU nest depth: 0, expected: 0
[   29.446242][  T614] CPU: 1 UID: 0 PID: 614 Comm: wget Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   29.446246][  T614] Tainted: [W]=WARN
[   29.446247][  T614] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   29.446249][  T614] Call Trace:
[   29.446252][  T614]  <TASK>
[   29.446255][  T614]  dump_stack_lvl (lib/dump_stack.c:123)
[   29.446265][  T614]  __might_resched (kernel/sched/core.c:8838)
[   29.446270][  T614]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   29.446274][  T614]  __dentry_kill (fs/dcache.c:?)
[   29.446278][  T614]  dput (fs/dcache.c:912)
[   29.446280][  T614]  __fput (fs/file_table.c:477)
[   29.446283][  T614]  task_work_run (kernel/task_work.c:235)
[   29.446287][  T614]  do_exit (kernel/exit.c:971)
[   29.446290][  T614]  ? __lruvec_stat_mod_folio (include/linux/rcupdate.h:899 mm/memcontrol.c:798)
[   29.446292][  T614]  do_group_exit (kernel/exit.c:1111)
[   29.446294][  T614]  __x64_sys_exit_group (kernel/exit.c:1122)
[   29.446296][  T614]  x64_sys_call (??:?)
[   29.446298][  T614]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   29.446300][  T614]  ? filemap_map_pages (mm/filemap.c:3935)
[   29.446307][  T614]  ? count_memcg_events (mm/memcontrol.c:? mm/memcontrol.c:847)
[   29.446308][  T614]  ? handle_mm_fault (mm/memory.c:6423)
[   29.446317][  T614]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   29.446321][  T614]  ? __x64_sys_close (fs/open.c:1591)
[   29.446323][  T614]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   29.446326][  T614]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   29.446329][  T614] RIP: 0033:0x7f69b74d2408
[   29.446331][  T614] Code: Unable to access opcode bytes at 0x7f69b74d23de.

Code starting with the faulting instruction
===========================================
[   29.446332][  T614] RSP: 002b:00007ffcd55f1d78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   29.446335][  T614] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f69b74d2408
[   29.446337][  T614] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   29.446338][  T614] RBP: 00007f69b77c6820 R08: 00000000000000e7 R09: ffffffffffffffa0
[   29.446339][  T614] R10: 00007f69b77cdfa8 R11: 0000000000000246 R12: 00007f69b77c6820
[   29.446340][  T614] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[   29.446343][  T614]  </TASK>
[   29.519252][  T107] /usr/bin/wget -nv --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&job_state=finished -O /dev/null
[   29.519260][  T107]
[   29.555346][  T109] 2025-11-10 18:26:44 URL:http://internal-lkp-server/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&loadavg=0.78%200.19%200.06%201/108%20594&start_time=1762799196&end_time=1762799197&version=/lkp/lkp/.src-20251109-171750:1aad5493ad31-dirty:35b842bfeaee-dirty& [0/0] -> "/dev/null" [1]
[   29.555355][  T109]
[   30.276210][  T109] 2025-11-10 18:26:45 URL:http://internal-lkp-server/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml&job_state=finished [0/0] -> "/dev/null" [1]
LKP: ttyS0: 86: LKP: rebooting forcely
[   30.276218][  T109]
[   30.285962][  T107] LKP: stdout: 86: LKP: rebooting forcely
[   30.285968][  T107]
[   30.324585][  T107] /usr/bin/wget -nv --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=vm-snb&tbox_state=rebooting&job_file=/lkp/jobs/scheduled/vm-meta-119/boot-1-quantal-x86_64-core-20190426.cgz-29fb8368dfb5-20251110-11844-dgg7hi-0.yaml -O /dev/null
[   30.324593][  T107]
[   31.152096][  T641] BUG: sleeping function called from invalid context at fs/inode.c:1920
[   31.153357][  T641] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 641, name: wget
[   31.154471][  T641] preempt_count: 1, expected: 0
[   31.155280][  T641] RCU nest depth: 0, expected: 0
[   31.156362][  T641] CPU: 1 UID: 0 PID: 641 Comm: wget Tainted: G        W           6.18.0-rc4-next-20251105-00001-g29fb8368dfb5 #1 PREEMPT(voluntary)
[   31.156367][  T641] Tainted: [W]=WARN
[   31.156367][  T641] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   31.156369][  T641] Call Trace:
[   31.156392][  T641]  <TASK>
[   31.156395][  T641]  dump_stack_lvl (lib/dump_stack.c:123)
[   31.156408][  T641]  __might_resched (kernel/sched/core.c:8838)
[   31.156415][  T641]  iput (include/linux/kernel.h:61 fs/inode.c:1920 fs/inode.c:2010)
[   31.156420][  T641]  __dentry_kill (fs/dcache.c:?)
[   31.156423][  T641]  dput (fs/dcache.c:912)
[   31.156429][  T641]  __fput (fs/file_table.c:477)
[   31.156432][  T641]  task_work_run (kernel/task_work.c:235)
[   31.156436][  T641]  do_exit (kernel/exit.c:971)
[   31.156440][  T641]  do_group_exit (kernel/exit.c:1111)
[   31.156442][  T641]  __x64_sys_exit_group (kernel/exit.c:1122)
[   31.156444][  T641]  x64_sys_call (??:?)
[   31.156447][  T641]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   31.156451][  T641]  ? count_memcg_events (mm/memcontrol.c:? mm/memcontrol.c:847)
[   31.156453][  T641]  ? handle_mm_fault (mm/memory.c:6423)
[   31.156458][  T641]  ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[   31.156462][  T641]  ? do_syscall_64 (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/unwind_deferred.h:37 include/linux/irq-entry-common.h:300 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[   31.156463][  T641]  ? irqentry_exit (include/linux/rseq_entry.h:576 include/linux/irq-entry-common.h:271 include/linux/irq-entry-common.h:339 kernel/entry/common.c:196)
[   31.156466][  T641]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   31.156468][  T641] RIP: 0033:0x7f07d32bf408
[   31.156471][  T641] Code: Unable to access opcode bytes at 0x7f07d32bf3de.

Code starting with the faulting instruction
===========================================
[   31.156472][  T641] RSP: 002b:00007ffc164c7eb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   31.156475][  T641] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f07d32bf408
[   31.156477][  T641] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   31.156478][  T641] RBP: 00007f07d35b3820 R08: 00000000000000e7 R09: ffffffffffffffa0
[   31.156479][  T641] R10: 00007f07d35bafa8 R11: 0000000000000246 R12: 00007f07d35b3820
[   31.156480][  T641] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[   31.156482][  T641]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251112/202511121304.5e522f7b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


