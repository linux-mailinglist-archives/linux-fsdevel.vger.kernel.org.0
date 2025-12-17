Return-Path: <linux-fsdevel+bounces-71587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3CCC9DB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 01:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B113305D7A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AED2ED87C;
	Wed, 17 Dec 2025 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDGyuv+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B16417BCA;
	Wed, 17 Dec 2025 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015956; cv=fail; b=M7fPhT55vi8/1Iw0MgL8za1DBKG6IDsoPzkdh3d/tKJ6Kj6Q4v5TnHK0CS8Ept9bsK+ObSC3VHU2WEQTF6rCUtDZF/sj1/fUjL76igkZ2eJNMWd/yXYpL/a9IQOHdApuJ0ofW039Q2VllNWkVmqyLt+D5VtEwye8TqPN3s9m2NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015956; c=relaxed/simple;
	bh=uQbckFei89O32hHZEEq8yYM5MM0NdtmcZH/4F7CM6cA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ugZpvzhYNFxQuoPpELXDNZkV8ZpWF8ayC94da+HIylDoxz+Zohubiz+FNXc7VGJzIxYRKrdD9QZXbjSpRMKa/x+SMHb2CGcFXKzwLnDOGZcIB+hcFojcO7KjP9fmsG2/tRCLOyMVKdTrcBMycfbvMFMxYXprejxmuCl6jKqA1XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDGyuv+r; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766015955; x=1797551955;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=uQbckFei89O32hHZEEq8yYM5MM0NdtmcZH/4F7CM6cA=;
  b=NDGyuv+r7I5A4xBoFamMcQ4S2KEqk3Ahz/xZSr0hH5f1G9rq6ffPcEJs
   vpZN2zDGjCupxwsRY30ypjeylPRQWT9KzS0xqPn/N7nyppUSTwUSefbFM
   49hFsX5sFq60rJs3n/rt4OdDRLQ39IfZDVxEw4pyDGO8ZbtWicx79yfQ/
   RREUqwCJsCWVG3RwpZ/jfmotO566ex8vdaYhwod0678VQSWB00SkZMeLb
   gw09Y0bS9DJ5la87aPhpCyjldjW6lGpoagAs+/C5T13g37gGEHjlkISW3
   MLACRG+g36CZy1s6k6qe47p2csbw5fydkuNg0Wu1ton+kT5JOEBqOVOKl
   g==;
X-CSE-ConnectionGUID: Mb6ndEvRRZ2OS2KdngOSCQ==
X-CSE-MsgGUID: NHAVqyCaQKWUAcMuCZpiWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67933108"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67933108"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 15:59:15 -0800
X-CSE-ConnectionGUID: 9UyznW09SAyAjNGIhijQtg==
X-CSE-MsgGUID: kXFBoRI3TAyuBueHzmiJqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198046986"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 15:59:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 15:59:13 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 15:59:13 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 15:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/Q7XgF7+lbhHC5w7Dd4DC2HIYrP9HnZejKzQ2SMGZZhFlFpLjG8x/wCX2hcIQZ1jko3aiGVxc5bobU42erjr96NlUpJRduWs321KYGRXs480MR2KFf9ne6munb1mMVgCDKt6szdI5ktdLB3HjmE4W7xUgISO5XZBsFDluMZjJDkY9J8e9GkKg7blDo3p7JwJl4x29JpzaCJoMfButY1rb+6ENAJuDAAwGa4xfnzGK03axrfuifJCxALZZw8jOZKxkdfJ6Tj0Pu5mAPNjP7sZaDwNpajATTSN3O6a7ZY80IorsFNniGcnD3mqqY4f6Mym4/lbFX+vq8zcczWJ/mHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX+f/1PzdYpmJ+m6uvvo9rNqf2MTQC9iiNzOxZo5nXs=;
 b=x4M0G5aGw0vOa5AuMKqaH1aJxfBWJFy1j2T6e0LHiUvQ/Rdg8QGuElLjeJQiUBZgYR08MhicYMw/677yW++U9rZRlpn6P4twp4LuECXNNVQ9d6XBqz/XOWAuggfpWxEXvIM4dpLAz1T4YbhzuAmdtPpwmUfUicLyzBwXYm/2/aNb5UdsocIFnQwo1tdPh+rZUdCg4KQ66WFCiXQhM2ZktGQohekY/4HglIZA/kmKAbc+AG4VfvXFsE6lHR+46oPgYXn5I8W44zQTtFMaBPH4HrkA//tPATibPOCLFxS6FlexPtDV8T+f6x/L/YuNTlfR50KbpsZZcwAyebEypG3gag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Wed, 17 Dec 2025 23:59:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 23:59:09 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 17 Dec 2025 15:59:08 -0800
To: John Groves <John@Groves.net>, David Hildenbrand <david@kernel.org>,
	"Oscar Salvador" <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: John Groves <John@Groves.net>, John Groves <jgroves@micron.com>, "Darrick
 J . Wong" <djwong@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gourry@gourry.net>, Balbir Singh <bsingharora@gmail.com>,
	Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Aravind Ramesh <arramesh@micron.com>, "Ajay
 Joshi" <ajayjoshi@micron.com>, John Groves <john@groves.net>
Message-ID: <694343cc7e89_1cf51003@dwillia2-mobl4.notmuch>
In-Reply-To: <20251217211310.98772-1-john@groves.net>
References: <20251217211310.98772-1-john@groves.net>
Subject: Re: [PATCH] mm/memremap: fix spurious large folio warning for FS-DAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7c33f1-aa66-4171-b20d-08de3dc84527
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkVIYU1Od1VkbnBmSkNnSzFaVTROWFd2aDduL3dZTXhZd2V6Zk5Jd0d0UTFy?=
 =?utf-8?B?TlFKdHpVa3BGQ2pzdjFSSkVWRjV6Z2M2WnpLSXN5ZFoyV0w1bnFpSjlHN1Z3?=
 =?utf-8?B?TmJxbTV4ZWRCblM0OXNhcGZsaGI3bzlyWG1YYnF4eDJuWElHLzNyM0MvQ0lq?=
 =?utf-8?B?K1puMVhuZVAxOVlyOURzZEhBaDRoeHBkZmtCbHY5d2hkVHlLamRWMnlMWnUv?=
 =?utf-8?B?Tk0wVDlTRk4ySVVmd0VHTTdHUjdEZlp2SE0rVm1SMHh1YWxYTGhOQWpYZ0pE?=
 =?utf-8?B?Zjl1VnlYbGtkYTY4d2hmL1ZxSlhUNXJQa0RSUmlwYWZzM1NHNDlxTUp1dDR0?=
 =?utf-8?B?QS9OR05WOVIreFN3ell4ay9jR3QxbTZzR1pJSjV1YkNIOENHS2dxZkhIZ0JU?=
 =?utf-8?B?Sk5tM1l4ZVFmVXE3R2FkY01URmFydkRTUy9RbHhyVTZuVVlPZkowVmtIemx1?=
 =?utf-8?B?WHVpY2pZNm91alp0SVhmelJWckR6MkFqdHBXNFF6K2ZUMlV4bTNQVEhTV0lF?=
 =?utf-8?B?TnExcmRxdEVEZWtTVnUzSkIwNHkwWE94V3Vpb2Uwdi95T1JGQmRxMU9YYnBM?=
 =?utf-8?B?TkhWRmV3bnpheUZ0Qks5MnVDZnlxeEk5Mm9BL09WQUZ5aTVXeUJtbFl4MlAr?=
 =?utf-8?B?NnordjZGYzRUc2ZBMGVMUVJlV0VmKzNZOW1ya2txR1NQM1o0MTNCZXdWN2tt?=
 =?utf-8?B?aDJUMlN1ZlRIZzN0azBSOS9NSEZiTk1yTUcwTzNFa1g3eU5sMGtEbUxiNEQ0?=
 =?utf-8?B?NEtHY0RuaE8zRVBwb1J1bnZZUG5ZZG1wZlRaTWZmTzVGVTQzWUNHa2dLKzVj?=
 =?utf-8?B?V0w0RmNvUlhRaTVLUTQwaXA0dkkyWG40MVRMUFRVUGV2WlBlay9Lb3lkWnRI?=
 =?utf-8?B?OU1nRlRnbVRDTnlibWlsNDRPMHZqNGNNQzdWNmo5b3JYWEZ4YmxEVjNFQnd2?=
 =?utf-8?B?RVY5ajcxMVl5VW9mU2xoeUFHTjB3R0J5aTdWeVdZSWZyUDFtS0JkbVFTSkJK?=
 =?utf-8?B?ai8yRDVuS1BqV1R5V2hOM1ZxTUp5OXozejVwTjk1VEJTckVta0dwZkI4Rmxp?=
 =?utf-8?B?QkorWTdzWU5PZnZSbG1rWDRQQkRLMzR5Wkwra0NpWjEwdEJHYjdNOHVLMlJB?=
 =?utf-8?B?UUtLY0FzNnpzaWNkU1ZpU2R0a1ZPdEU0YmtUOTlGQzhxOWk3OWtTakIzMlRq?=
 =?utf-8?B?cGcvY0dJcmJZZDJibTVENnpNcks5V3I4YjVQcDNENEpMaDMxMW5EclN0SzJq?=
 =?utf-8?B?QVZ4MnpTNjBsWGpjZmpsVkI5SXdsUmpKT2JheEg4RTRSK01qZERoaG5RU2pF?=
 =?utf-8?B?MDJMZ0hKMlJKZU1mQ0N0TWErZmdCMmNibjM5NkVPMGdRWTQwRVR3SWt6aWFY?=
 =?utf-8?B?amIvUHkvZmVLbTZCQVlIMnFIU3ZPdFYrUDFxTC9vd29WSnpWYm8vVnh0dnhz?=
 =?utf-8?B?dGFXVlhKUENzUWxKZjEwSGRQcGlNeGdSNFNWVlprck1ObmQybTNKc3A2N3lM?=
 =?utf-8?B?VlVJODZRYkVzeCtiVFFETzNwbGZmc0dEMkR5TGdELzRMSlRBT2ZrYjVza21M?=
 =?utf-8?B?cExKUE5KQWRCa0pPNG10allMRzVBbE83RXRWcDFiK0pCMFdtKzhpbFp0YVAx?=
 =?utf-8?B?cFhzUk8zb3ZzdlhRWVZHT0tKMk9FOGlxS2c5azlvSFJuT2xHRE1zbXVRVHJ2?=
 =?utf-8?B?UzNaZkhtRGJFTElvaHlPREtxTEk4NEZtT1ZUdmJnaE9sWE8xZWZZY1gxRXpE?=
 =?utf-8?B?QldSM0YvcDQ0SjEyRVVieWVvcDcvRlR1K1BqaXI5OWtpM2JKZ3VBeEZ0VFl1?=
 =?utf-8?B?Nlo5bWV0Zm5SZ2hxU213ZUVrRkdWVkdCRExZT3kvRTN4MWY5M3FVc3lLemRK?=
 =?utf-8?B?bHViYlNON2RtVkM1ZlZsbElMcXhqT0YyczExVTlmTG9wVXl1TjdUZXN0M3pY?=
 =?utf-8?Q?JhLK2IaHMV4OS5fthbdKGjop5eKou4kt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q091Q2tuM2Iwb2ptSmE4VGl5UWJYc1JpWU9hdHBlY2JrRnNpVzhEQkJOSnRi?=
 =?utf-8?B?YXU1bnZyRXV3Ung0ZDFaRU1OQkZ3aWptRkJlYVdrNkNCQVVyc2l4U3lGeTEy?=
 =?utf-8?B?VGlvdDBDRElxMU9PV0FST09Ec1hxQWdabFhTaHhxVTdEcFJEci9oWTZTU2xC?=
 =?utf-8?B?RkwrcERTa0xxYmdWQ3I1Mlh6c0hiR0s2RWdkUzFxMUJOZlFub0wyNXlqb0pB?=
 =?utf-8?B?anA5U0ppSVFoVU05T2pYejRCZXVBL09naVA4aWVYWXpncXFLeVRZYUwycWFP?=
 =?utf-8?B?enBIQkw0VmI0MWlTWXgxVnozei9uN01BVWw3QWRGeldlWDZwTkhlRmhMbU1i?=
 =?utf-8?B?cE5TYW9kTjlGR0FEeFhFSWxZOWJwOEdRcnNLSmc5Y25RRmN4V1dUdXVuQU1Y?=
 =?utf-8?B?U1dMSEw2ekZpS2x2eXREdjNxN0dPM3RsZmtnZGNnQ0YxL0c5SlBxNzVQeTVP?=
 =?utf-8?B?VkZ3OXE3dVEwRUx5ZS9acTRRWUtESnJnU00vQVoySklXNG5vb01EY0tWYmtT?=
 =?utf-8?B?UC8zdmZ4aVpWckkwOVhmRG9FTHZzaGxkMGU0Q3JzYTRlY2U0c1JGdXUxa2xH?=
 =?utf-8?B?K3BYRGhHSXRRMVBlUGU3VDZPQVlrU1J6UmNYQVVLL0UvSVp0RG1ObmZsY1Fx?=
 =?utf-8?B?OThwS1NKZDdOaFI4QlBvaHRlYUlTWHQ1TlRxWi9DRU1zL2N2dWlKalNUelBT?=
 =?utf-8?B?RlFsMmlqRm45dFhhU2E2b1JQZ0VscWN1L3BpSU5uRmVSUzJyVXFhRE0zTmNH?=
 =?utf-8?B?WVRySUl2dHUvWHRoMHJpL1hLNlhqS0dSdTcyRXcyczI0bUlJYzBwTmRPSkta?=
 =?utf-8?B?aVBVM29GK3I5eUM1UzNnLzE5YTMwVVZENWxSY0d5RXh2bEhnWWJldFg0RDRU?=
 =?utf-8?B?VFJSQ3pyaXRVbXllemRxcytYM2FxeDhYcGlOT0pVL3NqZEpaK01MSGl2b3p0?=
 =?utf-8?B?RnRmT0NwRU10aWM0eWxvWk9KbVFva3YxYmdaci9OcHdPbFJYSlAwTmU0Uksr?=
 =?utf-8?B?OEdxdytJTGhhVWZqQjhvYzFMaGZBZkxsS1VFMDNheGprbkYxVFdiWXl1OTI5?=
 =?utf-8?B?UUtPajh4SVZyZzFjRTZNNlF6TTdZVDEzQUd6R0ZXSENZUElCeXplNloyeDhV?=
 =?utf-8?B?cWNBR3lxY1dYZzNlTk1WZkFDK3AzNEdIdUkrQ1drWkRlQS9SajZuRWtaMXh3?=
 =?utf-8?B?MHJoUXhXM0RoMUhpVkcwb0ovREkvVVo4QzU2c082dnRFMjFQQmJDQS9KMXlX?=
 =?utf-8?B?WldXZDhNNS9uQ1BaN2RzOWpqWktwRUlDWFhmemRzRmVKVDZzM2ZhWWc1SUJM?=
 =?utf-8?B?WTkreDM4b1U1cU1kYjZHMzl6cy9nenRxUmtLMkZ2ZmRhUzFtTWFabW92Qit6?=
 =?utf-8?B?ZmlSL0w0YWd6REVrT1Z4Z0l4WXc1WnlQdGFRQnFGajJBR0pjamVqc3dGOUlP?=
 =?utf-8?B?czFCazNCRCt6Q0ZDMmw1K3FPWGR2bktoK0c2eHNoSDRlR0hEbmE3TjJuc0wv?=
 =?utf-8?B?NW5SK095VzhRRjRXUE85ZS9YcFVCYjNaTWJoRStCZHg4dWt6Si9mYTdSK3hm?=
 =?utf-8?B?TE9rNVdBeWg5aUgrUFlWVGxyMHFud25FZkE1eEIxREd1WDg2RktvQW90emJy?=
 =?utf-8?B?NDh2OTluNGpIQTFIU20xZFFWZmpadDZIU1liV1hUNHdkYjI3bFdvQ0p3dkNw?=
 =?utf-8?B?N3RVUFVWYVh1dnNmYUFmK3REdVJkeEQvek1pMHk5VkRZQm0yclhPN2FWOGxT?=
 =?utf-8?B?MDZsY0p5M2dxMmNvaEYwWGIvay9pYkNESU51ekRqWFdVWjJ3MmUxRm9pN01y?=
 =?utf-8?B?VDVob1VBakV5eVJNamt6MFJLcjhiVVEwWWF4ZTlUN3diRDBEU3V3Q2I5U0Q4?=
 =?utf-8?B?b1pTNFhjZHhvOTNMelhROFkwZGcvVFJZakZpKzVqWGpjRGZQd29NVDdJQ2NS?=
 =?utf-8?B?MTVLRG9WYlFxNmR3bUp6bi9VMGpaeHAwOHRzMFJvZzNScEMyNU5GTkVRdUMz?=
 =?utf-8?B?bTM2dHBXQWNkSFRYMk1OVkVWSWtQUTVHcjJJVytzd04wTjBxUkR0bWEwR0R0?=
 =?utf-8?B?SUw0SFh6Q2c3cjhucU9lUzhZdEtianV2YWlaUkc2K0NJMlljN1gwRStDM0ow?=
 =?utf-8?B?Zy9NbEF5UGRYbU5JR00veXBUWnhScXNhZ1N3c1JuNlJXQXlCN2lMSU5GZmxa?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7c33f1-aa66-4171-b20d-08de3dc84527
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:59:09.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VEXJa9cZqh0V2frSNxsFSHyaWLA+gbeRx5mM8xDP/Htiy0OkjBhDdVUWW8MWAS/3wR42AXIv8Mzy40cBbMLgGsRmhNQ5xDN040aQ2JFRIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-OriginatorOrg: intel.com

John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> This patch addresses a warning that I discovered while working on famfs,
> which is an fs-dax file system that virtually always does PMD faults
> (next famfs patch series coming after the holidays).
> 
> However, XFS also does PMD faults in fs-dax mode, and it also triggers
> the warning. It takes some effort to get XFS to do a PMD fault, but
> instructions to reproduce it are below.
> 
> The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> when PMD (2MB) mappings are used.
> 
> FS-DAX legitimately creates large file-backed folios when handling PMD
> faults. This is a core feature of FS-DAX that provides significant
> performance benefits by mapping 2MB regions directly to persistent
> memory. When these mappings are unmapped, the large folios are freed
> through free_zone_device_folio(), which triggers the spurious warning.
> 
> The warning was introduced by commit that added support for large zone
> device private folios. However, that commit did not account for FS-DAX
> file-backed folios, which have always supported large (PMD-sized)
> mappings.

Oh, I was not copied on:

d245f9b4ab80 mm/zone_device: support large zone device private folios

...I should probably add myself as a reviewer to the MEMORY HOT(UN)PLUG
entry in MAINTAINERS at least for the mm/mememap.c bits.

Now, why is the warning there in the first place?

I.e. what is the risk of just doing this fixup:

diff --git a/mm/memremap.c b/mm/memremap.c
index 4c2e0d68eb27..63c6ab4fdf08 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -427,8 +427,6 @@ void free_zone_device_folio(struct folio *folio)
        if (folio_test_anon(folio)) {
                for (i = 0; i < nr; i++)
                        __ClearPageAnonExclusive(folio_page(folio, i));
-       } else {
-               VM_WARN_ON_ONCE(folio_test_large(folio));
        }
 
        /*

