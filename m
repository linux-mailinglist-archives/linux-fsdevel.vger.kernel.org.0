Return-Path: <linux-fsdevel+bounces-64797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA4BF41A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 02:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E248E1892A95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917C17736;
	Tue, 21 Oct 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdS2Ged5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6510F9EC;
	Tue, 21 Oct 2025 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005192; cv=fail; b=IgdOuRmCrGRd9qCm+MGP2t8freZG914AJw5UpAXghs20svwbuAniDMNdI//QuOT0Zm/hyHdYH/TLAv4u7MHo2pb7mAiGP7Ij612Tt8nQUW4aKVJiMOv8G5vmi9pRve+461cGXMm6rndreusYQ2uatu/1AQGglpD0rAmw8SNe3aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005192; c=relaxed/simple;
	bh=/qfkES4Bx8ULOR3B3KeCDtBjxaBlF7C4Mb7amRLHHbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nu7bSlCBKl1JQ9GmEs2fSmir5I9VDxphJtFzpe2/LybzmeamzA+L8IY+N34rd8ZouT6FhPOSk7Li7JCUNdBQ9NwTUJ3JRWNnjWtIwFKvgYdqQEPmewFEmLVGf1TcqzxFXELMo/uTkjmrI3+MYqcF9PSojJoFzlvSy7/OIUWNML0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdS2Ged5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761005190; x=1792541190;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/qfkES4Bx8ULOR3B3KeCDtBjxaBlF7C4Mb7amRLHHbM=;
  b=AdS2Ged5s2uOIkP0G28JUm4VF+hfQwqM0zzxH92L+3+X0RoLnITBlzZD
   hlaStqMT/7Sw0oroJnkAbhxtzwM9J9Fl+xEqmrW8Kr2TLjS/1V8KAga+m
   S2ib42y/5/8a/kQW3cy3ERXRUuieSxRV38YocGPgD5khFJ+ZBALC9Yev/
   HTWAvQgmGOzOvxmZ9pVgOSXvmwxXKWSZBipRLKLzhqXUmNLd6lCMr3xg2
   HOT5vVUY9hAab+Zuc/Wm1ggNS0D4Z65xZL6SQg6Pw2WQy/imth6RCTGWd
   inf2U9EMTn6cPiJz9EUzdNXCqkoeNR++TMIlc2aIWZGhXsPlIPJ2q8zzF
   Q==;
X-CSE-ConnectionGUID: 2MP/8ooDSdeFE+U7VbXEyw==
X-CSE-MsgGUID: ydFWejuhTuGk5UEAucFnrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63033944"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63033944"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 17:06:30 -0700
X-CSE-ConnectionGUID: sT0AAAwDQmWecnICD38Vzw==
X-CSE-MsgGUID: Bgp0qCM1S8KblFwfGJ978w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="187481045"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 17:06:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 17:06:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 17:06:28 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 17:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBnaBw1sUczi2c4IeXUQS1zHvNyowsAd/o5Wax1u82paeAFtyIXqT5OdxUdiE578R9UbWppLPeG+EWXzurD4K8qryAsPCJQ1391sSO/0xawQMXxp6t0zb2ypQlHuTNQOlWCdsFFQ88EK3bXKwhpJ9Jg1T/zVanrCPqda6cs5aOn+9fV2ps65loC0Lb9g4KjYhhbtYEow5Cy+z9RqMs6Qigmr8GrDF/ywJcL4K8GiE9eaOwuoqW7am4r4nksYCb1uIRBLEw6uJxsAO+R/crVhlUGVdZm0pbY0fDYpGylf5xSQeXxBAKiEK5lzqWyynlXzc3h91914rOAbXH5Lae7DeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ8SJrjOP0rWKD5kVQzq6126myPO8xF4ytMlqe9/T5g=;
 b=IqwR1ZCzNxf5uQA4dcJSoacmv09EmFCj7fCYr0d4f80Xyr7w7Fhrl6/ZAwpGI6uRERKUrESELOn/ezp/y6Jqf6bfqnOZIpkDeCuA+I48w/Nw6GqUwQOIDI88wW00eTYxnXGnI2TDH1IBo20JpWDRqfwFLfXV9mtkm7TtzhgKaAdM96kxNI6One/vTt9IGwjQCIzN7f7/VA9Mbbax5TWzf7KUQ1xZV7TQ6tq57MAXOI/QffovkxH/RIudlFLxLzOvWt/+Mkrb7lvNjhRDhXY3v8wLYQzBifi6OrQ4CwuxmdOdQHVGKfM4MSQO00wNWMp5DYr41Us33QYTvs75wZNqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 00:06:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 00:06:26 +0000
Date: Mon, 20 Oct 2025 17:06:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, "Borislav Petkov" <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
Message-ID: <aPbOfFPIhtu5npaG@aschofie-mobl2.lan>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <aORp6MpbPMIamNBh@aschofie-mobl2.lan>
 <aOlxcaTUowFddiEQ@aschofie-mobl2.lan>
 <e2bf2bf1-e791-47e5-846c-149e735f9dde@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2bf2bf1-e791-47e5-846c-149e735f9dde@amd.com>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2bb61e-eb52-4487-4501-08de1035ad25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlE1dlpLMFJZM2w4dXJpWUNMSkozbnJqelNKWkdxNG8zMWp2Y3VZMU92V3Iy?=
 =?utf-8?B?U3dGTnZLWFIrMndydmlVSVhDT2FaQ0RYbVVsSVBKdmhKcUZtKzhKd3BTc1hI?=
 =?utf-8?B?WjM1MGtEYWdZcE1pWEZnQ3ZUV3BZNWFyYlBReE4xTjlNc0tHZHlyZGV0dEU1?=
 =?utf-8?B?TEVHOTVYTmdqR1hjTFlkeElXVGRkYURXeUgreXJxZmdwMmc4cDBLeFRjdmxI?=
 =?utf-8?B?aW44dTFKM2Q2TFA0aXM1ckk0NVRrampvY2k1aTJ3dHFUdS9qdWQ0QUF5UWFJ?=
 =?utf-8?B?dG1YZFFaWENZZW5FbGtkYmJVekVGUVVLSnIwVnFrMGJsQjUwZzVGV0FVWTJJ?=
 =?utf-8?B?WC85RDVKM1cyS21TZHVidDlWc1ZEVHpmREk1a1dKd0s1bW9wazNjRWw4b1N0?=
 =?utf-8?B?NjFuRmVFMlNvUHF3ODlrSnB3SmdEMWtVWkhZaHI3VjVpbVRtUzBpVVF0NHBT?=
 =?utf-8?B?d1c2LzM4bW9UdlRzc0pGUW5QV1ZrN2EzQkZ5SzZ1bkpkYnY5eEMzSU05Wm5Y?=
 =?utf-8?B?a0ZncTcrM3p2YVJnM09Bc2NQdm1IZG1qdXhWQnAzQmx1ZXlpZ3VwQVlMdUxn?=
 =?utf-8?B?enNsSmFzSkJQL3RXbTlDSnhLeFZ0NGRoQkVoRDZmeDBNRkVBUE9NRnZFc1Yr?=
 =?utf-8?B?WTdBMEcxcE13aklBTzFuLzFxbWs5WWtYdjBEZnliemZqY2p6THNIWHpUKzhO?=
 =?utf-8?B?TDJzaWpjdklJcGEySnNzc1JYdXZVdHhSalJhTGNZRS9RS05zQlF0Ukd4VXNL?=
 =?utf-8?B?Z0JMWis1Z3RCdStpN1RtRnVzS1pRM3NDMGowNU1XWldkZWhiN05iSnBEOXVh?=
 =?utf-8?B?WEpxVGlZby9MQjZzdHpnTVUvTkJZOWV6ZXJTbDA3L2RnUnI3c2FoVmZCaS9k?=
 =?utf-8?B?TE0rNndNVnUyaGF6Rzg2MDFidTFzUU9FUklxeFZsU0RJRzRaVyswTHVNR0JJ?=
 =?utf-8?B?UjVaTXNNMUdMVEEweTVuemR6MS9rTVcvaHZSTlpGcXRaSmcwaDk4dWtWTUNK?=
 =?utf-8?B?ajJlL0FlL0kzN09aQmNUcjhWNmsyYUNsc2RyRHY2M1BvbTdVWStQRUhLaENI?=
 =?utf-8?B?QUp4T1V4S0JobGVhZzkydzl1ZnFxU3lod0M4N1lmZGdTMCtNS0c3eXpZSEZY?=
 =?utf-8?B?N1B1dHdsdSszNTRRTjV5S3Z6cjg4VlFFbjlNL2dtMjJMNlo5Z0xnUFBiSVJF?=
 =?utf-8?B?eGdleUlmNFl1MlBsdDhncUY5MGZtY2FoM3Y1UWM1cXo0NTcxL2RBOWNoWVFI?=
 =?utf-8?B?OFlsMnNCdi8yRXh6ZFVhVExpTUFZUThCVUhMWWdTNUN6V2tVM2xjZmFRS0RO?=
 =?utf-8?B?aTdmZDdxYkRhdnMvN3VFSVA5V2l5M3IzZVZtMGp1Rnc1T2duSENzaWE0NzR0?=
 =?utf-8?B?SlJ4OUdzT3NQNFRDVFBTMHp4WXdYSXE4blN3bTJtanJVczNEbWtuWlk0UWx0?=
 =?utf-8?B?OUdqa3FBTjNCZVIxRHJ3NWtublVuQUtOd1poeHdlRVlSc1hBSVRXY3Vuc0J3?=
 =?utf-8?B?QytqRDY0NnFVd25NOVdDU2FWZkVzSGRHYS9pdE1UaHdrY3VKcGJ0WWIrQ0JE?=
 =?utf-8?B?b1NWWHJ2TVlZK3VIL3J0S2xMZ1N5WHZVaHIzN0ZjZms0YnhxU051ZHdmdkYr?=
 =?utf-8?B?aytVdDNxaXRhZ1ZSTVFiTUFlR0xjbU1JZ2wxbml1SExONHhMUWc0MHpGVE5P?=
 =?utf-8?B?dG9UT3cvcWhOREdFVXE4VEJ5Wk8rdmdiRlRGcE5MV0pEdWtDWVNMVGZYOUlj?=
 =?utf-8?B?YzVLcXpUM21mZWQzRmg4ME5DampQQnV5anhVWVFzdnRpSVh4NjBzRDZEWXhH?=
 =?utf-8?B?ZHNYL0hmd2lYSGpKeXNHbThJNFlPRzZCNzF3clA3dXU2bSt1czM2N2RiUzFh?=
 =?utf-8?B?bGYvZGQ3VG5Dam15Ni92N2VZNEZGWHBETkJQUkM4VDh0MFVFUHVMVGNlMjdT?=
 =?utf-8?B?UEx2RzExQjF3ZDhxTncvN1pQM2txTUZzUVpnTVhENm42VXMzVHpUZUlic05x?=
 =?utf-8?B?Z0Vpc0t1UmdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lhVy9XdzdJQkZmWFlkWG1pT0xhdW5RS0hIZzFuRzI2WDJ4bWZhZnYxZitt?=
 =?utf-8?B?eXl5VDJIcU1vWjZiUjRiUk1wQnYvekE2STYxNnZDY1daMEVzVHZVT0dtbUY5?=
 =?utf-8?B?Y3h5b2hEUVpFTjlPQ1g3TjRDem5XYzZOUittUjloamllQnBZRnhscnMrc1Fo?=
 =?utf-8?B?czIvdzJXLzYxUEZJdVJ6OWVEM0YyZm04TzlXT09jWmJEUDF4Sm9WQ0NSTzJE?=
 =?utf-8?B?YXRGTGlBZWdsV1RGZzZQVmNlMGFYQ3cybUU2ZnVXZGhyMFl1NGJFK3ptNTRp?=
 =?utf-8?B?RGtwSDNZVE1IYTN3Q1BRbStTWXEvQm9rdnJERmVkK1VORlF3bEpuOXF3NVI3?=
 =?utf-8?B?VCtJYWNsOFdXMUJ2MUw5Q3oxRWZsdVhhVmFEWXhMZHp4VkdjTGlCSVdEOUZD?=
 =?utf-8?B?cWFaSFdYaE9kamV4b01EN0xMRGVxR0RIL0JXc3oyaElBbnpzMGp3S2U3enNq?=
 =?utf-8?B?anowWFJXc29YWDYrZStjSUMwcnc5K2E1Z3psYkRBeEV0UnE0QUhYYTB4UHJN?=
 =?utf-8?B?OGkvQTI1VG5YNE1PY0pUMllGQ3NUVktlOGs0ZWVaQXBjRjNaYXducFZjNVlz?=
 =?utf-8?B?MXVtdEpIL3UvVVFRclpyY0FPOWIrYWVFYkdpNG40dWcyZnpzcHNob2FFS2lh?=
 =?utf-8?B?ajcyeXM3WFZpNDhnV1dTZngrUnIvalVqaDQzbVBMOVVtZDNPMHdUWjFUTWJM?=
 =?utf-8?B?bDRtUngzUVB6ZTFEZXFYbXU5ZERyNGlEbFZFU3hNRlFkTjNTbkFFYXhzVnBD?=
 =?utf-8?B?Um4wcmVGQTc2NVRSeUxSb1NxQzRtcGlzNVFGY3h3dEI2aXVUSGUwRjFtTWcz?=
 =?utf-8?B?VWp6RUpHNlo2Z3VQYjlsZ3FvSjEwZUdib1VDWXZCeFlmUCtnejJlQ3k2YTVn?=
 =?utf-8?B?WUhUVWF0Kzc3VXZtQWQ2Sjlja0JiS2ZJZldXaStmVGNqeEFlMkFuWnRCRUJp?=
 =?utf-8?B?NHdlU0taQUpsQWNPTmYyeHBtSTRiNmlmMno4VmFZK1ZOVmQvRm1xVElWVkRh?=
 =?utf-8?B?V1R6WjhSd296M2NlckVKOGZ3cnNtVklodkFzZTFIR3ZxdXJrRFFGeWpIVDlV?=
 =?utf-8?B?dHFSVlJBM3BYaXRESEkxZUVLcEFaZU41RVVVcStEK3ZXdVN3OCsvQXRqVm5I?=
 =?utf-8?B?ZWJ3MHpSMTg5RGZEQnZvTXYzT0NTZndtMDI1ZUJoYlVleHJzSlNNYUxiYThq?=
 =?utf-8?B?Vmxtcjc3aHptQUpnOE9UTFVyRTFxeUk5c0UzTll3S21kTEtFekQzQnA2R3ZF?=
 =?utf-8?B?WmhHRkpjNVB6K2pwaHh1Zit5RkkwUmxHYXJDR1BhZXZzNUdjWVNYL3huNDJy?=
 =?utf-8?B?YWpaUWVBQmFYOGllbkJ4cEdTUFZkejdRcm04dE12blA1NHc2NnEzdHIrcmNq?=
 =?utf-8?B?U21RUm1KaUkwWU1oMkYweEsvT0Q1UjQ5dWVFOGo3Y3BWVkZHVm1qQVVSRitE?=
 =?utf-8?B?Vzc4eEJ5UEtTYXN2RzZ6M0RtLy9EV0FzSENjdVZsVUZoVlRXdnprZUV6Vmhj?=
 =?utf-8?B?MXM5SldweWVnSkkyQ2dFaERVOGpJd0FwYk5sZW12Mms0L1VBdTVrSVdTYVVM?=
 =?utf-8?B?elRYMmJ5am15RDY5VjdrRkExMDZxWU9FOWYzeDJGT3lDZVRPRTJKSnUwbWZa?=
 =?utf-8?B?WXEzVjVWMEY5V2s3ZmdRd0IvL01LdkRqL2tFcnA2RGJNUFJxTnhza01YbUVz?=
 =?utf-8?B?Vk5LU2Y1YzJYRWFZenJacDdDS1JBWjZPMmtwYk9ZQVoxMDZheU9KMW90UG0w?=
 =?utf-8?B?WEhBNzljZHRDa1RGaHM0THdKaGp6YnJFeWhhY3R0Mm1qcGpaVS8rN21OU2JT?=
 =?utf-8?B?RG0xaEhxY1c3bzJrcG9zRzR3RXJPRmNZeUMrdmZlcnRaZ1BnNGJtZDJwVVh5?=
 =?utf-8?B?ekNXN2pRL3liRUlFY3NWQnA2LzNRSGVIT0k3ZTU4SWVXUE9hOE5Da0RSVS9X?=
 =?utf-8?B?K05jQXdIcmJ0MCszUkhFbWxORUNRaVV3TkVRL0hZKzhpZGFBMVNmWHM0M3RQ?=
 =?utf-8?B?SXFxa00yYTJ1TFpJZ21xOEk4T3U0dFh3OGo2MzNtaTUvenRUeEl1ek8vVHpv?=
 =?utf-8?B?YlNib2h4Rk5OVXhuQzJ0VG1HTzUrdmJQN2llL2hBb2t6TVpoYkRxQmJVZGJu?=
 =?utf-8?B?UDRwWjF1aDZ6eTMwdjk1UDN5bTJYcjVUN3Vxa21IUUhtZnpHd1hGWEh4dUpz?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2bb61e-eb52-4487-4501-08de1035ad25
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 00:06:26.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA7CQ4knKA3TvSehn2udpv8R6DNJcM4SPhGb1syrE41O6pGnyjIo4QRui5TV5ULGQH1XmS0sIzxeHJFjTeSkWjQmE46ed8eB9Q9iSYsP+hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
X-OriginatorOrg: intel.com

On Tue, Oct 14, 2025 at 10:52:20AM -0700, Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
> 
> On 10/10/2025 1:49 PM, Alison Schofield wrote:
> > On Mon, Oct 06, 2025 at 06:16:24PM -0700, Alison Schofield wrote:
> > > On Tue, Sep 30, 2025 at 04:47:52AM +0000, Smita Koralahalli wrote:
> > > > This series aims to address long-standing conflicts between dax_hmem and
> > > > CXL when handling Soft Reserved memory ranges.
> > > 
> > > Hi Smita,
> > > 
> > > Thanks for the updates Smita!
> > > 
> > > About those "long-standing conflicts": In the next rev, can you resurrect,
> > > or recreate the issues list that this set is addressing. It's been a
> > > long and winding road with several handoffs (me included) and it'll help
> > > keep the focus.
> > > 
> > > Hotplug works :)  Auto region comes up, we tear it down and can recreate it,
> > > in place, because the soft reserved resource is gone (no longer occupying
> > > the CXL Window and causing recreate to fail.)
> > > 
> > > !CONFIG_CXL_REGION works :) All resources go directly to DAX.
> > > 
> > > The scenario that is failing is handoff to DAX after region assembly
> > > failure. (Dan reminded me to check that today.) That is mostly related
> > > to Patch4, so I'll respond there.
> > > 
> > > --Alison
> > 
> > Hi Smita -
> > 
> > (after off-list chat w Smita about what is and is not included)
> > 
> > This CXL failover to DAX case is not implemented. In my response in Patch 4,
> > I cobbled something together that made it work in one test case. But to be
> > clear, there was some trickery in the CXL region driver to even do that.
> > 
> > One path forward is to update this set restating the issues it addresses, and
> > remove any code and comments that are tied to failing over to DAX after a
> > region assembly failure.
> > 
> > That leaves the issue Dan raised, "shutdown CXL in favor of vanilla DAX devices
> > as an emergency fallback for platform configuration quirks and bugs"[1], for a
> > future patch.
> > 
> > -- Alison
> > 
> > [1] The failover to DAX was last described in response to v5 of the 'prior' patchset.
> > https://lore.kernel.org/linux-cxl/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> > https://lore.kernel.org/linux-cxl/687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch/
> > https://lore.kernel.org/linux-cxl/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch/
> 
> [+cc Nathan, Terry]
> 
> From the AMD side, our primary concern in this series is CXL hotplug. With
> the patches as is, the hotplug flows are working for us: region comes up, we
> can tear it down, and recreate it in place because the soft reserved window
> is released.
> 
> On our systems I consistently see wait_for_device_probe() block until region
> assembly has completed so I don’t currently have evidence of a sequencing
> hole there on AMD platforms.
> 
> Once CXL windows are discovered, would it be acceptable for dax_hmem to
> simply ignore soft reserved ranges inside those windows, assuming CXL will
> own and manage them? That aligns with Dan’s guidance about letting CXL win
> those ranges when present.
> https://lore.kernel.org/all/687fef9ec0dd9_137e6b100c8@dwillia2-xfh.jf.intel.com.notmuch/
> 
> If that approach sounds right, I can reword the commit descriptions in
> patches 4/5 and 5/5 to drop the parts about region assembly failures and
> remove the REGISTER enum.
> 
> And then leave the “shutdown CXL in favor of vanilla DAX as an emergency
> fallback for platform configuration quirks and bugs” to a future, dedicated
> patch.
> 
> Thanks
> Smita

Hi Smita,

I was able to discard the big sleep after picking up the patch "cxl/mem:
Arrange for always-synchronous memdev attach" from Alejandro's Type2 set.

With that patch, all CXL probing completed before the HMEM probe so the
deferred waiting mechanism of the HMEM driver seems unnecessary. Please
take a look.

That patch, is one of four in this branch Dan provided:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order

After chats with Dan and DaveJ, we thought the Soft Reserved set was the
right place to introduce these probe order patches (let Type 2 follow).
So, the SR set adds these three patches:

- **cxl/mem: Arrange for always-synchronous memdev attach**
- cxl/port: Arrange for always synchronous endpoint attach
- cxl/mem: Introduce a memdev creation ->probe() operation

**I actually grabbed this one from v19 Type2 set, not the CXL branch,
so you may need to see if Alejandro changed anything in that one.

When picking those up, there's a bit of wordsmithing to do in the
commit logs. Probably replace mentions of needing for accelerators
with needing for synchronizing the usage of soft-reserved resources.

Note that the HMEM driver is also not picking up unused SR ranges.
That was described in review comments here:
https://lore.kernel.org/linux-cxl/aORscMprmQyGlohw@aschofie-mobl2.lan

Summarized for my benefit ;)
- pick up all the probe order patches, 
- determine whether the HMEM deferral is needed, maybe drop it,
- register the unused SR, don't drop based on intersect w 'CXL Window'

With all that, nothing would be left undone in the HMEM driver. The region
driver would still need to fail gracefully and release resources in a
follow-on patch.

Let me know what you find wrt the timing, ie is the wait_for_device_probe()
needed at all?

Thanks!
-- Alison


> 
> > 
> > > 
> > > 
> 

