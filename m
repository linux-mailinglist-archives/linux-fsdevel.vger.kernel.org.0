Return-Path: <linux-fsdevel+bounces-70616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D197DCA208D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 01:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22BFA301458F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA9191484;
	Thu,  4 Dec 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwopbdaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C84C92;
	Thu,  4 Dec 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764807790; cv=fail; b=ixd8YoFL1CcyAvn2Z9/s6l/zSOtZXPnU7oQTS6mFZEEpxFI+Kr1RSawfhtzwAsO6t6B6YSAcbUJUQ1x5kPJwt0spAUzQeeojFXd5NHDo7QCAoekKli8Rwxv5yNC2g91gi1WoV5NTH5o9paNnh4/n0KAQ09oMWUPfq5guIwFq7Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764807790; c=relaxed/simple;
	bh=qHmHwuv6Ltsn4bfoEkBpTgS4KEP6n7ihX8EwPWCize8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MD+dukGo6dkwHgdZjPdIc6eR0nLKAlXg0rz10Gm/5j4n5pvACm6ImUxPk1eOXoWHIUO/ABaM2MBAH3XZuLWYhNH2YaTSia2/3VduI+qIRCsLF6sXAp9LnaTJFeSiPamklyJeCEQKd+z2dJJMDSFshIV1jht5ZvKq92/oyQgxix8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwopbdaZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764807788; x=1796343788;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=qHmHwuv6Ltsn4bfoEkBpTgS4KEP6n7ihX8EwPWCize8=;
  b=iwopbdaZOMU5LtG01mZlf8VxYa4tmB6Kiy0b2WVCHqQSrTZe1J23kcks
   yeZQ21WARz7v6p3N4CSDnqq14L4uvkkBrgYGnj7T7+FjmhpJ+FfjLw95e
   L2FkzswVzcJMPFA8DXr+5tf91y3OA3HQdsm1IuPZmWQMmMB1ogTYQa1wY
   9KVJbSR713cMDko3Cddl2NRwt6HwjpAzLyWBfvbLTx3Efm6fgc0Kefs2H
   OVwQBCbNtSrsFRhIaZ8ZzQc0+dt26aHZU+7YjcluvDkYwtl4h7KNpeZCj
   6se2QqIOmfMvzlDfTq7Q5eqfUYztKprNd1l7QRZ/Cwelw78K6u468kQBD
   g==;
X-CSE-ConnectionGUID: d/vAEf98TeOnCwzor04feg==
X-CSE-MsgGUID: +4gAq02QSgiMFBsipHyupA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84419865"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="84419865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:23:06 -0800
X-CSE-ConnectionGUID: WJZH/i1UTqGgu/zwMELz+Q==
X-CSE-MsgGUID: B2pTs/afTiKS4QYxfZ3P0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="194931367"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:23:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:23:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:23:05 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:23:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDpyy4qlc8BzXZu1RUiAINu2kDGdwDB8ucThupk1Nd3x3Sqh/Fho9jSpdVf4rwonpwSJYewXiED9TMQJFOT7oINTBtH38IIDYPmi9ue0ph2peuNGg1OHdDLfSL848fRs/PqWtn+/pFTmbI2aAoT4LXfKway1sQuEvhNSg5GDZQknj4FZ5GqcCYLhj9KsQtudPuCWUC7OLfHFfK14qyuDJdEybZ9syPT5gX03Q/Knf/21A4nolYcnst464UMjQzy77RR4DadWub4hLqiE3dICJKESyfVpvIfgmzxJ35uLaGcSZUpMvVvg71eWt8km9e7QvNJX8fKnjajGoiL/fydkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq0MPlqBosOgX8xTLBjyjcamxP+PrG/GiEAIAsfMw4s=;
 b=XFVpqCdMIHWXL5eeQDXsXOHDM4TiY3eoTZXQxbz0jXNnCRhpkJWdcCfL8UJERj5X2JGhF4JrR5w6fXaXK7arHVRjv7+yj9FGrXuKYLZgIMECgVjFoev+RRpWwWFaoXifRy0OcodfIzGRhR0EdNB2JFyu/VqkmCqd49fVKvuaP1MYLr/wOuy9hMJrisdRqxE9ld19jXX55sljAenHVEkwGb0u3kpu3TSCflcQJsrCnhodew1C2CvGRZZIb2e52k4gIpqA+EYHyMU+hnQy7M98iTdZCuQ3+Z3jQUlQCVFoG3XP1+c3sMUty5XGeYaUY0yw4ZXhJWthOCA/nwKtL5WsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5806.namprd11.prod.outlook.com (2603:10b6:510:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 00:22:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:22:57 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 3 Dec 2025 16:22:55 -0800
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
Message-ID: <6930d45fb836f_1981100b7@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 6/9] cxl/region: Add register_dax flag to defer DAX
 setup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae862b0-2cc3-47b8-3f69-08de32cb463b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzhrR2FLVXYzem5rK21iTXR2Wjh5by9EUkRnWmtkb1I5QnNCd3RLNU15TXJ6?=
 =?utf-8?B?VHc5Zmh2UVFuUHJza1N2SjZudmYyVHNPaGtPOUZyTnhBZ1pWU1hDakhrMk8v?=
 =?utf-8?B?NXlMOTJNMXcyZUZWMTJpaXVZVmZOQVg4dm52M252V3o1YjJCL3M2OW51WE9t?=
 =?utf-8?B?Y0ZUR1pQdGVqcjRQeWpwZm9kQ0IwcHB0ZjdQM1VxWUNyZEZObWYxQWJHR2ZQ?=
 =?utf-8?B?SG5jOXBTQ0JwYzJMdHNNK0pBbHZZSGQ4RUNWSTMyTktocEJVNzdkVFFPZ1l3?=
 =?utf-8?B?NDZmMmNSWVFMZlVvMDBiR2hOSlhEa3JOQWJrRllTRzUwd1dnMUR4UzQwZ2Y1?=
 =?utf-8?B?RnZscmhuKzlVaGp6ckQzdkd6Q1MrNlpkd0pGdzdobjlWWFlRRWlXejFOVDRX?=
 =?utf-8?B?ajY1L1VqWE05Rld1dzRtdCtERkhyTWJweFlVTlcxNTg1TlVvK0VMVTF2bytK?=
 =?utf-8?B?S21ObnN4QUI0ZVhYZ1dyWFlUdU5ETmpkMnBTcGhEbDZTSXIwc1FnWHJlS1dR?=
 =?utf-8?B?Si82KzBWekZiS3p2bVdxeGthUnQ1V3NtMHVoZXVrczBRU0ZYZjAzem9PUVdR?=
 =?utf-8?B?bTQ4NjRSTlRHU1Q2c1ByeC9kaWN4bjIrVExrQW1CdjJ0dXRkbkdmcDYrVkVk?=
 =?utf-8?B?L2czRUdvckdMRDJUbkVnNFVpRXBWNitKMzcwMjR5T2NsODA0clR0RDFSQ2VZ?=
 =?utf-8?B?d0JqNnBDaUxHZlN0U1Fmd1BvWTdROGpoWHFrc3gzWldPdnlVR2tUQ1NGU2t5?=
 =?utf-8?B?Slk0UHRPdTdDNkV6SEwxTXJuWFEyWC9lZEx2VXdOZGlrd3hXZnc0TWtFVU9U?=
 =?utf-8?B?d3JJVEpURGpucmNaU0U5UEFhQU14aXNrYWlzL3NiQXR5UWpFRFA3ZWpwNUh4?=
 =?utf-8?B?SHRPVU56NjVJeVVUUDJoa1o2MWxSN3Y1aE9mSnVzT3FnZjkxckVHZEFmMmRo?=
 =?utf-8?B?ZHJuTEdJaENoT2dmQXBPRkxQL21WR0cxNFgwZ3JMYnI5dWJubEN1bWpyb0RP?=
 =?utf-8?B?dTU3RTYrTG0rNXl5WkVscDhtY2I5VnlhVVhnTlppZGVJTHYvMXFZN2hSUDdS?=
 =?utf-8?B?RnNjVXQ5b2xBTE5FSTRXU29ac285SVZwSXgwenp2ZnlUQ2NFQ2VRVm1Oclp0?=
 =?utf-8?B?NXc3WDA1WFlsb0Y3YzRQQ3VWMnRIc3cxTE5nVWFzcUJLVGxmTjdWemVJMkda?=
 =?utf-8?B?ZkVhZXFxdTgrNDZBKzR0ZUV4MUQ3clhRbm9CY3hOYWJQc29FNnROQ0xSTkRL?=
 =?utf-8?B?dHVkbEsrbEduODJhcE9TUHkyZS9RY05GM3V0V3dldUZhdkZUdWVIak5LbkNm?=
 =?utf-8?B?R01ic1U3a2F4dlRla1NWa2tDWWVWZk1vMUNPUjFHcm5JbEMybjlKV21sQjMy?=
 =?utf-8?B?bzBLWUp0REhEL3gveUtiOWdadmtZUzhOUkRKYUtDc1l0aXhmcWx4WE5FT1FZ?=
 =?utf-8?B?L05WU2xiQldvTTE3T3ZmREtBS0R4dWRrU3hsQ1RXRHF5VEJUVENzQ3RtR2ZN?=
 =?utf-8?B?dFpVdldkdDNSdm5FZ2RFTFdqUUg5aHdRNklVU3JGbmQvYk96aVRkbFBzeVNx?=
 =?utf-8?B?QXpnZ1BlUmdiblFITWU0blAvZ1puV3I0aEt1djBtbXZxQmlxV1VlVm5NUTlC?=
 =?utf-8?B?TWRjY2toejM2SmNoZE9takNnTW1aZTBWWjFOdXNhcWw5VEh4blJid0gzYlc3?=
 =?utf-8?B?Nml1YWFGRUpCVFlUaXQ1TlFqcDE2L1hSdjNMY1ZIUVRwRVdQaUVNTWhHWGda?=
 =?utf-8?B?ZmlBTldNQzJBa3BENnV5QnR6YkJKazR0TG55cjBXWGx1VGxraStiMGd3eExz?=
 =?utf-8?B?Zi9VSHkwZndpcExJbVYzUVVDa0dvMDQzUUFVcjRKcVZzRDd4NDRvZGczaHJV?=
 =?utf-8?B?NjdQWTZyUkJmbVdhb0Y2NVI4Yk5tc0pvMzJxMzY3S0prbUlUV3dOL3VCblFO?=
 =?utf-8?Q?nNFXDMnlFeKCPhcOKnhtMxBQaMkVjMmo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z015dFgxRkFSUjFWYmh6QzlCL1d6M2Joc3JMRGNGaWZEUWpjczNVcFZjaENT?=
 =?utf-8?B?L2pYS21rMDFtSGRRSXJZUTdXeHQyaU5XNTBOYlhEdUFRY1pOSW9oOE41eTRk?=
 =?utf-8?B?dGdXYXFRTWpnWm1kcmRzcnB0UjBZbDhuQS82aGpkUENIRU1Ucnd0V25XQ2t3?=
 =?utf-8?B?Y2dScmd2VU05WnJ0T3lmZEpnTmdZbmpoU0JMUTVybjNzb1dDak83Ulk2eVhC?=
 =?utf-8?B?M1FpTU5XNi90bXE5RWR3VzBIbjFMcHNvWEZ3c0huS0pCODJzdGZOUXFzc1c1?=
 =?utf-8?B?TlZVUGRDdUtoODhaYU5Ia2F1TmpDMHJkWTBJNmpZcUg0ZVZRbVI1YXIvd3VS?=
 =?utf-8?B?RytYQzU5SXRHWkliSHlOY1ZTeTBxOFhZUVpoV0oyckhpRzhiTk5iMVhmVEVi?=
 =?utf-8?B?MzVQdHJXdzhKTFpwblN0RmRzRVBGOXcwQUFpT1JOczVydjRDczNhMk5BT0dr?=
 =?utf-8?B?MmlraFpTaTBXZVRjSXlQUTdrS2JHc3BXczVRd01CcERjY0cxUk1uY0FKVit5?=
 =?utf-8?B?UkFCMkN4T1RRSmdLL2RMWVk5ZnEydlh5M1pjL0g5eHMxYUtzWmoveHF6SVZs?=
 =?utf-8?B?NytPV0lWNGRpN0VsbVA0OVRtTHBPb0JUeUp1dkFaYTVEWTU2eVJmODNxdWpN?=
 =?utf-8?B?UkluTml2UDZ6aWVvVnhFV21KeWFYcG5LY0d0MUFwV04vMXVWcjBqN1c1bGNp?=
 =?utf-8?B?bWpzN3N3aXh3SDdIRVJ5a2poWXlaUXN4YkcxWWNmVXpPeS9zSS9MeHZPMXhQ?=
 =?utf-8?B?cytXbG83TytVYjhuZ0JXMk5OcGdPMFhBYXhHRUdaRytNSU1HV3JWZ0VHMFRU?=
 =?utf-8?B?cS9abzFhTVBqSHJZRGRZbW90YWRrYjJ1TDhEN3NEVnVpRzdwZDVseGxIOGlT?=
 =?utf-8?B?R0g1OStMMXp1RHNoZmQ4MkdWNnA4Ry93ekk4L0tnOGVCbmtDTmRxVDllU2t6?=
 =?utf-8?B?NW85VXUwRUx3b1gyRDd5UUtrNEZGRmwyYS9UZEx3ZmxDVkhjdkpHMXd4cmRQ?=
 =?utf-8?B?L2F5Qm43RUdzeExLWkwvT04zMWJYdVJ5Ynk5RFZndzY2NjIxRzNCSThNRzVY?=
 =?utf-8?B?cGRKNTB5M3llc1psMXByN3M5ZzdkTG1qdEhSbTEvSGNRcG5MaWtQTTlPbUVN?=
 =?utf-8?B?QjBHMXZqUVBQZlJ4SW5PMEwxQXhqSllFRG9kU25pNjRuUHBXc3JtUFRoUGVE?=
 =?utf-8?B?ZFdqUCtjZmhJVnpJQytPaTNHYlBuK0FabFd6cUJqTE9SLzQ4RHhsWUFOdmYx?=
 =?utf-8?B?aHpwWHlIQ201ZkprOXZYQW5rMGJDeW9IanFBazM1MC8yYy9vZy96K0FzbVNO?=
 =?utf-8?B?K2MxaldnaXRjbWJydG93TGtKNDNBWkVzLy9BQ2p6UHBzVEdFa2ZrMEpRa2l3?=
 =?utf-8?B?LzNNZElGdnptNHkrY0xkZmdKWmRsWDkwWHdUVCtneGdFNGgvV3RuWHVrcjIx?=
 =?utf-8?B?alRwSy9sSkVRRUdMeUtIMXcycnRBejF6bWNvcUdSZ09KSFdGUjhGa2JteVh4?=
 =?utf-8?B?Z3lCbm1yQS9EU0VEOUFmWDlsUEJYWXFoTFFUdDFyWXZrcW5ERWVmMTZYdUxp?=
 =?utf-8?B?dDRYLzBtTEpzVFo3SVJ5djZLd29pVWNMbDc2Tk9IMFVmSUZ1SGplWkdPUkkx?=
 =?utf-8?B?dzVGOGdtNG4zQXdCQ25RbmRCVldqY0JITVVSTCtaSGxwNld6dVgxcmpBR3hO?=
 =?utf-8?B?L2tzTW5PSVVLMkZ5ZG1mOXIzbHBVQktrLzlGUEp4dFF6dEp0REVLVXN1ejdw?=
 =?utf-8?B?RGFtZlFqNjNCUmxqVWhqZVh6amdSN2dZcy9JTlpkcDJwcjlWNGdrbW5ob2la?=
 =?utf-8?B?WG1hb04rT1EwZ3R3ZDR3ZW91UDNKVlA1aG1hbHFHdzAyQVA1dVpWWTRGSlZw?=
 =?utf-8?B?Z0QyYnRPWlM1NTBVRnE0RTBNV2UwWXV3ZUlKMVZaUjh1OW11M0tIWGhUdVJF?=
 =?utf-8?B?eldoL0JQUkthMFNVbFFpUXlqQzBTQWxVV3FwUCt5dS95cTVMd0lDVEd3d1Nw?=
 =?utf-8?B?dUYyRktJcTR2ZXdqU0lSVUg5MlJtVjhlQ1Q2NjNTdFJ2UE1nQ3RLeEhMbVFD?=
 =?utf-8?B?bEdaKzV5c1pOVnBmSHRlSEgxNkFIdkJLWEdFWjB2cjVXWHhGRytsWDBLdnV1?=
 =?utf-8?B?cXg1N1FrK2pJaVAzc2tBSUVOV2s3LzRGVzA4Z3lPMEdMcmNSYmlmaHdMUkZB?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae862b0-2cc3-47b8-3f69-08de32cb463b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:22:57.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOUuG9LxE7cTX5Je+YjfueuH1Lq+gVqapMjWfHAq/7nEOjI7aSKPC/7SdWrKmUFXEu6m8QpibXsrdRYWVXHu0mJ+lFh4jLcxbnSpJPWyqBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5806
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Stop creating cxl_dax during cxl_region_probe(). Early DAX registration
> can online memory before ownership of Soft Reserved ranges is finalized.
> This makes it difficult to tear down regions later when HMEM determines
> that a region should not claim that range.
> 
> Introduce a register_dax flag in struct cxl_region_params and gate DAX
> registration on this flag. Leave probe time registration disabled for
> regions discovered during early CXL enumeration; set the flag only for
> regions created dynamically at runtime to preserve existing behaviour.
> 
> This patch prepares the region code for later changes where cxl_dax
> setup occurs from the HMEM path only after ownership arbitration
> completes.

This seems backwards to me. The dax subsystem knows when it wants to
move ahead with CXL or not, dax_cxl_mode is that indicator. So, just
share that variable with drivers/dax/cxl.c, arrange for
cxl_dax_region_probe() to fail while waiting for initial CXL probing to
succeed.

Once that point is reached move dax_cxl_mode to DAX_CXL_MODE_DROP, which
means drop the hmem alias, and go with the real-deal CXL region. Rescan
the dax-bus to retry cxl_dax_region_probe(). No need to bother 'struct
cxl_region' with a 'dax' flag, it just registers per normal and lets the
dax-subsystem handle accepting / rejecting.

Now, we do need a mechanism from dax-to-cxl to trigger region removal in
the DAX_CXL_MODE_REGISTER case (proceed with the hmem registration), but
that is separate from blocking the attachment of dax to CXL regions.
Keep all that complexity local to dax.

