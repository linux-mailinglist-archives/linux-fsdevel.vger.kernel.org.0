Return-Path: <linux-fsdevel+bounces-70619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ECFCA2129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 01:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490E4302A970
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D51F1315;
	Thu,  4 Dec 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKjJgDEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A61D54FA;
	Thu,  4 Dec 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809703; cv=fail; b=MOFBJwpNeilYvlgj2zjbtxXPb9FwTRi0Z2s4dxAQC+0qf2WwTRjXyzJK+S6uJY0KpeeVCVedI5Wkj/JfATNLzWqcRyDCfQeAcLFa69mchMrEFFESKkAUpkiBWOu2fyiDdNwuytPQofIS89CusmrrR2QVDRw34ij+lXib0CuEPOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809703; c=relaxed/simple;
	bh=+APodHUF2hxK5KDjSGcVMs+cfB3/Dj3C3426DdMKdPw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=C7QWl6nWrSaG6uCXxkdXOOe70fBUsCD0ViR05AYtIu9H89UeNlnrxYVoS181g0YGovY0YMgoJrtcZaJmI9iBAl437kDvb8MVcpN8udgovcWICTb/xPWKEGttv89UbQUfPNXy5IAJgt0l/YjNMAtTYvCOxQJk4EVP3v+eO3K5qZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKjJgDEC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764809702; x=1796345702;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+APodHUF2hxK5KDjSGcVMs+cfB3/Dj3C3426DdMKdPw=;
  b=oKjJgDECdA5j+5D9vcy+7ZkPQOax6X2Q2hOYMbaICLD1ecU3wRiqEakP
   9jJphD6rUV8I5/WyW9JX5IWX9khbBtTJ3VVpxkUcQfezu4gnasIOiqxb1
   SWbiBYlA8a1emmUJU8qrWMS+qERwmapuoffdZXAO1oiWPicoRusuhZKz5
   0tlCWe1Ja0yiisruhUDr0Kiv0p7oSvh6NBlJVp8d6SqO1Lq0K4hO4v4RB
   gqIO5dZwoZHEHNu4Aj04zjmoquyv9adLeDNTXZeMwdHeXrJ+QRX08yaeg
   zXV8J17P3kFOoV6/q9gZujfM/YsCquNx0UBg5yFapkS4rhHA5qU3oVdIF
   Q==;
X-CSE-ConnectionGUID: LPfB9KXmTBGWS1ImAxd01A==
X-CSE-MsgGUID: dslEnclNSAmilzGGE23yLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66984595"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="66984595"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:54:56 -0800
X-CSE-ConnectionGUID: 5Hjjxi/pQzuwTfbLw3OpJw==
X-CSE-MsgGUID: WMh/gTt7T1KYtYgf+8scbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="194663058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:54:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:54:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:54:55 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:54:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD8zu/il+7tGSCUEgDgyqCG8p1M5YwcCsIbBQPd1oxC7NyitgAjOC2RceMpNxpgFHDc8zEuHNgT/lhxsTKOA7znDVpxoxx6Q6F/pLo2U3EUqrJDRpEVD5oAkUXZCfl3M64DVNl46ksapghE7AtH02mA17Cg+xJqBVCPEQns8yzkejcjKooYdTeiJnhupn/z9YDTccs4EZ0LZMukiMg1PVmwP2J7Xv8rHDW9CqoV2jVDCtK1264gmlsd4C/crcxU4RkkRofg1IdJRluENzJp/UnbNpL/3BaZIpF3azOZtVze/v5SOg7uT+dNEwlvAcu556N2NM9q+8SiWjHlwfgG+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WudmtTuG0WklBzjEuum9FiCzUaFXbqTu+aUt9AOx7Z4=;
 b=lEc+egsHjCs5lpfB5laUmTSLqtF/xzlPAq9jOgGQ61s5bNavjQSxm3y2iodW8fvRpbbNvXiWf8BO+PiLwqeiVTN1BkGw21LERj5NoLpuXQC76P1YD3yIXfvZBrLlOPEBR6zlsVkQa8EUqPrTl0dI8ZzGQfsatiEELB+K1cEefTmCqeH5zgdR/NGOEvgn7J0y3XZHQjwerHWjEYx6LB1hx4n4GMQxcWK5SxTN/XMgKTlkZ/37y15r4d1s90M9RmXTlfLz1Id0rFSd7p0Ov4LWg7ZDy/TuChzJ39yrgtR8pTWklf5Ee70Zr7b9xoz2T1mvpyFfgjDH7hn7co9Yo7EcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 00:54:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:54:53 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 3 Dec 2025 16:54:51 -0800
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <6930dbdbcc6e_198110055@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-10-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-10-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 9/9] dax/hmem: Reintroduce Soft Reserved ranges back
 into the iomem tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee15765-7949-4e14-3ede-08de32cfbbf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDhFaVUzN2tmelNkS2U4dE0zK2xQRVQ0MUt3LytWa2RSTHBzRGZZZHRKMFB6?=
 =?utf-8?B?aXQ1WVUyblZDUEM4UHBNNGFlNkNiQmtuZ1A1UEtOeTN3SWh5RHU3eElnNUlJ?=
 =?utf-8?B?WVhPQ3RmT3RaR04yOFZFUXVYOXdhY0pLZ2xUQXc5ajBBNVlFV3A4Yzd1eHBx?=
 =?utf-8?B?S3VhUXJkNVR4Z1l0cWc0V2VnNjQ1UlRxdC8yZmVHcEM2RGh6cXRrNnE3OEpB?=
 =?utf-8?B?Z1VzR1NsTGU5RmdoMlNYdVEvTXZqMHMvRGc0a1lLOEJ0OE16QTBuMFhGTXdu?=
 =?utf-8?B?UmRZU3gxMnR2eUR5QzQyZ2Eyd24vV1JQdmZLR0w3dXVlc1FQYUxoS1hyd0U1?=
 =?utf-8?B?QmxPQ0M4TlFDcEN2SDNpT2JhalphMnE4NnkxQytkNy9ZcEl6TGN3NzJSWlRu?=
 =?utf-8?B?ZU5iYjBpWEkvcnJ3TlFDTWoxVzlVamhMWWNpR2ZFcnNJa3hFL3Z6NXdodm4r?=
 =?utf-8?B?N2g2TzVBd2dzYmpDd2tzOUw0OVNWeEhUcXNyd0hjR1lkNDN5eWhRbEpPeDFa?=
 =?utf-8?B?bzg4SG84WFZvMjl5N3BiWEpUbFJNaElaTzRVb2dWVkRZK2c3SmNEb2tod1NM?=
 =?utf-8?B?WG5mWENKWU5FMEp1ZTA0bW5ySW5pQXdTOGl1aGJUS2lMdXZlaTVOQ3RRaWlI?=
 =?utf-8?B?cGxsNUNuNVhjcE9PQ2x4eUFNb05zdFFFby9BSHN5MU9va3o3Q3NYREhYSGFG?=
 =?utf-8?B?YVZkMVdoTExoTjdOY2srME5aTnJ5a3pNUW5RakxIejZzOUJISmsyTzhtUXFH?=
 =?utf-8?B?VytWQk04Q1krYjY1aEwyTTBnTWFra3lkUUZBOUptTnM2d3Qzamh6OVdBV1ZY?=
 =?utf-8?B?UXBHR3ZEMXo1R3RlVnJlSGtHcy9yb3M3anhkTW9MUmRNMHBzMEFGTXVBME9q?=
 =?utf-8?B?Z0lVVFhLeU9zSTcrd090OTdxNFBtVUwrRDRCS2RGTEs0RnhqM2pWZnFWc0Ra?=
 =?utf-8?B?ZEhFK3JIL0prYlRRdFAvcnp0YW1BVHRKQXdzeDYyeFV6d0JXQTIrZG5QUkFQ?=
 =?utf-8?B?N2hIL3pvQWlYek16VDZiVHF0OHcwemtGOEFjWFB3VWlvL1VKT3VLQldiUVpI?=
 =?utf-8?B?RGh5L0dXYzV1YXhwNnBKM3liRGZIZzJHVmFaYmdZaUNBL2dHTUduRkpFZFp4?=
 =?utf-8?B?WmYySnlsa2lpajJNR3RMRTZEbVUxVlFHSUhzbEJzNzN5L1dMSm5vK0oyWkJQ?=
 =?utf-8?B?UnkweWV2dHhVdzhlSmlzNGVpRnRRbFVkdGU0eHFkMWRPWWgyOW5XeHBmL00w?=
 =?utf-8?B?NjRGbVZMeENxcFh2eUNlTG91MlZxWjZWNExmMy91cWgrUDhEVkZmZVZLaGx0?=
 =?utf-8?B?ZVVXc1FkSzRRc1ByT0xUdkRtdTByK0ZKQkxrYXc2S2JMcE5NZ1E5dndvMUZ6?=
 =?utf-8?B?SEY3N2RMR1ZMcXp3SEFCMmxBcHVCRmlXR1FJTjBOay9SRFFIK0o1OHpHWlRn?=
 =?utf-8?B?SVE3c1ZaYU9TYi9BNGUwYmN6bGV0S0hUdE1pTDhIdWU2VnBpcVo5SEpyZ2xx?=
 =?utf-8?B?SjdHSDZJVEFMNHVEQWN5NWhoWDNwYmMyS0FqVkpES3FxRmxlV1BhaGR3ZW9i?=
 =?utf-8?B?WTdLMlNyVTRRSjZKQmRiS0Y3ak1lWXZuMDFlUGNKUmRxbmxWVDNjTEtrODBv?=
 =?utf-8?B?OENoYmtzRit5cnRlVmJ1TEN6WlAxNlp4cEpwZ2lnQnAwYnJmTEFTVTBpQnFi?=
 =?utf-8?B?S2VMMDlnWjhPV2hyL0hRWUo3cGpZK2E3eTkyV1FJYi9LRXdOazhVY2pKd0dB?=
 =?utf-8?B?TzNobno3TmVwQVBVUkRUNlJQQkd1MXFPM3JWT1UxUk9MUWVkTXZZQjI5dzc3?=
 =?utf-8?B?OVZreVkrbENLRmRTczN3UGxkME5lbUJ0aXJIV2VOVUlnSkJvdUxXMjU5WE9U?=
 =?utf-8?B?ZHhGRWdKN1BiRjFVRkdNcjFWeUJ6ZElYM2pOUHNvSzU0amI1MHFyV0p1NjI2?=
 =?utf-8?B?SzRRN3pBLzVlZzZiM3ZYMk1zQ1FtZitMUEZmaVRQMTZPM0lDaWlMQnJnQ0Js?=
 =?utf-8?B?czNZSGQxZjZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldJNlFCd1RTUDNOWHN0VWpkQzE1Z2M2NGVQbHZOY3Z3VjIrYjR4NVVza0o5?=
 =?utf-8?B?SGVUOHRDcHh4WGlpZ2swZzF6VUJyUm1aOGRnT2VMYmgrbUtSK0VDVkh2RWxx?=
 =?utf-8?B?VXhCcGluOWZYdzcvNVo5TmhCUmRtd09HQ1hTN092T0dOWDV6NWxVYzBIQ001?=
 =?utf-8?B?VlNPMGd5MTFjS24vSW4rencrZ3hicFU4SUM3c05GSWVSTitMOFRIWnZjNG1u?=
 =?utf-8?B?QXNpbmhBaklOd0RSRFFRNFJOcFhIaVQvSEQvakI0OWUyK3FNR1JUSVNCV2po?=
 =?utf-8?B?MGlFZnIvRmFDWklERGxtcmxYVG9RWGdJRG5UODZpaDZQa0pXYUF2bktnTFJy?=
 =?utf-8?B?Z1JCekhKZVVHWWVSTHhOOTVIS2tEdUJOSHgvY1c5cXU5Q0FCcHRRem12di8x?=
 =?utf-8?B?VFNXZmdoSFNtOGQvZVdHRVI3NmRES3B0bnRCdkE3cEM1SDRWUGZkNVlsbVky?=
 =?utf-8?B?YkV5UGp4dnNpUE1wKzBnNy9uVkhnNUh5dWwxdDU0RHMvb3NKZTlFVlVaa09l?=
 =?utf-8?B?aGVqdE1HQ3BEYkU0MW5qd0s5ZVo3a0JuWWIrR3RuRy9sV0k2Zmx6VUZ1NWE0?=
 =?utf-8?B?aVFvb2FOMVJlL1BBRWc4dFN5TGNCY25OL1VTYUl1ODNHbmlNa0lHMXZyNWRR?=
 =?utf-8?B?WFIvbWtYVFdCMGVEMVF4OTcrNUFKQkgxVU11LzNkdGxsQzFJanZIOWoxQkpS?=
 =?utf-8?B?eDhGRGVpNDhLWWRMaUJKWmtDYVIxcG1vVkxOMXZOVDQxRGY1UkZ1c1dtTEZQ?=
 =?utf-8?B?YTczSk52b2FXM3o4akVwUEZvRGgreU1EZVNMS0svQjhCSHkxY3oxdFRBdkRB?=
 =?utf-8?B?Z3lKc3M5akhPU250czRhRzVrWWxTK21FUlhZQnBmUHBwMzVaR1RNTFBNZ2Qw?=
 =?utf-8?B?dGwrZFlvUlkrMEZOYnZwQmRWNGh1WnNWcjBON0hQYWdQRDQvN0doeUNGaWhs?=
 =?utf-8?B?c09jY3dWemNXYi91aVQ1ZmRjUFR3UW1LWVZWS1I5UkNET1BpbVA5cktPUVdD?=
 =?utf-8?B?eE0vU1NlalhheFNBT01paCtRTVdaTFpNWXdud2NqUWJSNnk0cS9MOFBzT1JX?=
 =?utf-8?B?eG1aNDY5Wm56cDJMTU9HMVJBdXh6VnIwWkxSeG1BeHFqczVWWUtOWDhaVnl2?=
 =?utf-8?B?ZjhaUGNRMEw5UHc2VVZWR1ZUdGhvNHp5VUlacENEY1diYkRJT1NkR240MTZw?=
 =?utf-8?B?M0RxUW5CNkxwWExmU01PRUIvemtFZFBjYzNvbWhSeHBkWU9mUlhPSFlPQWs2?=
 =?utf-8?B?R1J3Z3cvaWt4N0VqdkdySG5JR21yWEdCUGdWQlhMV3o2cCtGc1FkUTlZZzcv?=
 =?utf-8?B?UlJjd1RLMmpqU3VGRDFheFduaExscWl1cnFMVzE0dDVqQ0lGTk8waUpWUE5t?=
 =?utf-8?B?VVNKdFE5NkpOZ1hhSENQaU9xUVdNREVyTTNGWEl6dG5RUmsyUmJRRFJXeUhP?=
 =?utf-8?B?dTBJZGVUa05DQkxMc0hNZVAvamJSS1Z6UXRkUDVnVTYxc2U1Y0t0WHRucEZt?=
 =?utf-8?B?YkcyOVNlQUc5ZEpFNk4yaFg0TGRnNGE5ZG1vbFhKdkw5dVk4SUpPcUY1K3Y2?=
 =?utf-8?B?blE4YkpSREdzM3E4aXlFYUtpV2ZqNTV0ZUUrSVpDdzlrVUIrNU4xMUJPL1FI?=
 =?utf-8?B?MEZBRVhvenVsUDhvYSsrK0lld3pBejlSaVN2cXRXT1FRTFRjNm1ONDh3RkJv?=
 =?utf-8?B?U0JML3RkU09wZlVyNUhBTTNHdFJEWTZST2NPa0d1TjI1THM3VWNPSGwxcDdR?=
 =?utf-8?B?Tk14M0hzeUY3dlBBbjg1RUFSd0FmemQxbGlvbGNYZWdGeTlBdnplci85bjBI?=
 =?utf-8?B?L2lxRnZxLzFBVHFyYXBRQnNzbmFIL1hZLzUrQXhxN09vanV5RG8vSFBQVXV5?=
 =?utf-8?B?VWE4am1GaTd3QVJ0cmYxd0w4QW9lcEo4TnkxN3VGR202MzcxZkVGV0VpT0tG?=
 =?utf-8?B?aXdDcCtoWCtodFFyNmZGRnhSQXduS0NMa25Gck9ybHlZd0hLdkZCWnd2QjZH?=
 =?utf-8?B?WlpVSFM0Um12SnE0U2lsZmFSQStwTTd6SExrWlVOaVkyM21VQkNFcHBKM1RM?=
 =?utf-8?B?VXh4aE1kMUVNSUV5dnIvT3JMcE9jWVYyM1pEOFh5UDUxQnpUc0o3MENtTzJz?=
 =?utf-8?B?cmRXbWl1Y25MblFmQWxKNE5USGpxVVVBdm5SQ3F2dk92ZDNmcE1oUUMwcDZK?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee15765-7949-4e14-3ede-08de32cfbbf2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:54:53.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtjBYKouCJHqG7uBVLtl6ZgWsRmQxsFxfgSDyn33P/HA8zxEsAc7p8PSed/Bvl0J4g1VrBrXchyWVCCBbNsTB7gkV5DNnDwRndUEAnSCXP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
> 
> Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
> to consume.
> 
> This restores visibility in /proc/iomem for ranges actively in use, while
> avoiding the early-boot conflicts that occurred when Soft Reserved was
> published into iomem before CXL window and region discovery.
> 
> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
> Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks for all the work on this Smita, and Alison too, you have flushed
out many issues and helped me through my blind spots.

