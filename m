Return-Path: <linux-fsdevel+bounces-71585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C0CC9C80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 00:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41BE0303ADC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBAF330336;
	Wed, 17 Dec 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGUFt2zV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462583A1E8A;
	Wed, 17 Dec 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013479; cv=fail; b=BapiBxjYtE38hROmZpSz0mL8tTlnZzhKbIy3Culqi2w3Z1S8McK5bRaO8cdcmUEZBjOuJlnuNGa/eku3Edts3skTF7NplwBUs3Mpq7qG9iueX5rM74e0vNihiOAZWB6mhanDxFT+nYK6z66nAHO2ilkjt3NAXMgEO1bFeTQgj8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013479; c=relaxed/simple;
	bh=/WHYVbhUFasmIPpXwz5B1HgIdY/MJHVNi6vS8yRo63k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WU34HAdnxfbURXjtzNObF9j63sqQf+DyXhEAejTMhWi08/eDmH0TFkPsX9qBEtwHo7/7jQ5mjyZ1HUj1wjRVdzZOXG5Tk3hs48b4DcDYs4TBHux83lMK03pyfPn6tvV/qTdR3ftJNB4Ky64LP8uZbZGdmUOGgC6fDBExzKPJbik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGUFt2zV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766013478; x=1797549478;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/WHYVbhUFasmIPpXwz5B1HgIdY/MJHVNi6vS8yRo63k=;
  b=JGUFt2zVUBaBUJlQyPCTATgYziCVNS3EeF8D7gljwXJtm5jsY0NxJXw3
   RzUypGJLcmoiMV2GnSvwqx1+/vISvOWdEYmkovxJKOc8EVnq9Feq4xmNo
   0ezSCxt+okhI6TwbCfgqbQOU3zJBzzFGRaHFWXql8QTFQo9zldoqsHuNu
   1/PBrTUoaEBQGYjWDVb6MS3N8oIvDmkH1DavWuYYmwN7hM/8+FxYzRszg
   dydW653husd5qCF/1pYdSf6jm8720VNIuVl3ZIHdrGp6GmkQ1N9Z47FK5
   fJRPqXQ5NUyH6eOm4MBsfQHWaXGf+v91dvXjsh/oViN02NlSiaW8etEwU
   Q==;
X-CSE-ConnectionGUID: y1npzwh2SVOtKz4H9SeNiA==
X-CSE-MsgGUID: K1S9Bv/DSPCAzwrmCkafbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="78275291"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="78275291"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 15:17:58 -0800
X-CSE-ConnectionGUID: aUwftkpkTGmskH1yhwz20w==
X-CSE-MsgGUID: gKA2+KNvSluEC0ZJxPznow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198200811"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 15:17:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 15:17:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 15:17:57 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 15:17:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAhj+NN7qHvx/bLonLcw9mE4ytkDKOEin31+poTu3fWGX3HFx5pOBf03mAMvv3NOWc/qPCKP2QWvVvI/raVHHOSTTtBLi+D7KPmqPrCyD6O3eu8AoyXeZlSNLWKZhiuPI5zHZFGVj1GSCXRh5LzK4puXirS+OkGedckkTwRdcvlIDLz1VJGJbyi3YFxAIEzcSMMkDzDt5s4Q0UNFVWvTLl7TC2qRLtd4fui4CUIUu/4fFGuF1KlfN69jfbkm2Eo4UR4mo4srHV1/l9i/drwBT43s+knmFVM6vTZ7QxdAUf9SZy+ZOsrv3rQrt6WqZLoZf7JB6rkS9fwTbbeXipuotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdddUGb1fbRoxeeXoezH8OrBF5YUm8eFo6NsxhNAD1I=;
 b=wtSi26cUf2LdO+K3FGo8NugqO7LDLDMNt9H8CGuyY2uVClIWlCNcsxfMZsSGGMuh4KPEDknrXAE0YPuq9SYeBGoQqKgNkDqpKRwmXHxGlEF1FEFL+1hlpIsdZCPIly4lPh3Qo1HYO8PfGSOQaIFDk6CPk74M+BEvavU1zdiA33quwIeRkp2RBz7TA9sm6DvSbUBO48tIzCtrUfUthpZWGebY0mHUkKAuL0pGeqHtgyHLQjyZL/kNLfNHW0x8MFUAivr2i8069BhcRYnt0l/88fvIqnRCjSfViLs2XPb+tzLwKj/FMXj4RAMi94h7wGx3ltgnRTtC7GHY8OrXx+nSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:17:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 23:17:54 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 17 Dec 2025 15:17:52 -0800
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Matthew
 Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, "Ard
 Biesheuvel" <ardb@kernel.org>
Message-ID: <69433a20ce302_1cf51004c@dwillia2-mobl4.notmuch>
In-Reply-To: <b3f230eb-b11a-4a83-ae6c-3ac0a70e8e20@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
 <692f65ecb5603_261c110090@dwillia2-mobl4.notmuch>
 <b3f230eb-b11a-4a83-ae6c-3ac0a70e8e20@amd.com>
Subject: Re: [PATCH v4 1/9] dax/hmem, e820, resource: Defer Soft Reserved
 insertion until hmem is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: f45552e8-5e48-4629-62a2-08de3dc281bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW5zekFNMlpCVW1ha05uL2FwaFhMQ3NoVENSMXB0NlZ1VGtRSGR2WVQvbEpu?=
 =?utf-8?B?bFpXUFpLWEFVZnR2dWZHNTEvdWNaQk5vclk1VjJHN3UzL0NyY0pFc2w2cnZp?=
 =?utf-8?B?R0JaUHp4M093VTNTa0kyMXg3cUxvTitoTFkyNXpNNFByamx1eEtDWVFhdDRq?=
 =?utf-8?B?a29NVEFZK3F2MEo5UWJJdEw0L0lMYVhBZEtHVkJ3T01peGhrYytBdVlNN3Zo?=
 =?utf-8?B?Um1FUUlaUUd6U2MxRTl4Zi9BQXd1UXVEaHM5U0x1TjJSd2R5d2o1Rlp2OXdR?=
 =?utf-8?B?OE5NczlZdkJoS0ZzcGMrV0k2U3FZMWpwNU1DYzBnTlVKYkFvRXZETFZYRmdC?=
 =?utf-8?B?cDdMU1dXT21TN1kvK2hVZXJiTy9XazJuOXFVZml6UklWNnlMbm9ldG56QmRm?=
 =?utf-8?B?QWl5T3BEZkZGbGVIaEFCVWZwdVZmVGUweENBdmI2dVNTbVAydk1kc0RZK3Rh?=
 =?utf-8?B?NFZtN3NOQkVJQXlianI1QU5lbm5EWEYxVWxjcTM1UGx0ZVo1aUhqUldycnMz?=
 =?utf-8?B?RExRc2FQLzhXU1hVdjNVa3lqVGRIelhuMytrY2toMS9hWDNmM1FSbzBsam5s?=
 =?utf-8?B?Ujg1TkhhT1JWTEVudEhEMFlhUGZNS3NQQ0xPbS93aUlHdkFRWmJVR0tFY1kw?=
 =?utf-8?B?UnZOem1xa29rd3hPczdSWko0N2lpRmVyTk0zNm9haWoxYUY0NERzUHFFWTI4?=
 =?utf-8?B?eE1YdEdXQkIvdnNGU09lS09ZMXNWeUlnOUE4YklEWG8yVzJOdU5zU2oySDlW?=
 =?utf-8?B?T0RrOG5vNDM1YjBuT25FT0RQcTRiL2VUL2o1VjFXNjIxNm1XYUI1bHVVYXhR?=
 =?utf-8?B?aTlUemp1eTk0TUZZdTBVa0Qrb1dqZVExM1lkRUdKZXNaWFQzTmg3dHYwdTg0?=
 =?utf-8?B?SmdTR3pXR2s4NEIvbnZ1LzNIU2hwVjBmeG5XczNaSjJmd0FoNC9uZzhhcjhJ?=
 =?utf-8?B?aWlqOHc0bldheXYzUnNyYW9lWFY3VTZ2dmRsS0h6bU9XblBPOFpVZUZjelcw?=
 =?utf-8?B?cjdDclBDeS9tc0w1NHJQVmpsNlBEdHpYRlVHNlFYejIvUW96MTJrRVI0RkhF?=
 =?utf-8?B?bVJBR2xKRXlUTE4rYmdTdWFFTWVhd2RNZGpCeFNQK1V4TFZ1WmExbWRmb01Q?=
 =?utf-8?B?bElldVRDRFlxa1V0L0srYlhqWWtsQWgxc1pDVmVITjBpbmZEV2d5WUhPY0o1?=
 =?utf-8?B?ZDdOdTYwTXdSS2U2a2hTN2t6b2hzTEllYy9GcG5xMUd2Ri9QU0h5d1Q4Ym5P?=
 =?utf-8?B?ZVVFc3dHeEpCd3JYM3BKZ2dra3JiejZ2dFRUSHZpMTl1R0JCSFFFTEY3eHBF?=
 =?utf-8?B?WEVhckJaYyt5WmE0Q09yYTlVSEY4dDBiU1gxRFpsd3djRThhYjZUaURVRlg1?=
 =?utf-8?B?amFlaEpNK2lrenErVFRORXk4VStiZENhb2ViR2hQM1BHaDBiMVFubGVmMHZr?=
 =?utf-8?B?ME1BbEZOQnJWVWpXVVY2eEQ0TXYvMzlDQWgrcStmSjlRRnZmcm5WcnY2UTFm?=
 =?utf-8?B?SlRzcml0Wkt0UmRVV21JR1lsN2pYUk9RVFE2OHIyWDU1blFRdU9nR09JcXpN?=
 =?utf-8?B?MWtJQ3BsUG1IZmttTi96cUNiaTdVVXRBRmFlUXdITURGaVVvT0owRFdzYTJH?=
 =?utf-8?B?UzBnOGpVVjRKZDlpSEVqZlhFNnlmZlZIMXh4YmJsYjkyejZtMmJsWjZiUUwv?=
 =?utf-8?B?VVNKM2p4L2I3TkFiVlRRVGR0aU92NGk4VjE1c0VkVU5oMXc5ZkhLc09tQXdk?=
 =?utf-8?B?bERXbytERVM4bHM2VDBwZ1g5Rm1SSGpDa2x1Y2xac2NiWklCOFpxclllQnB4?=
 =?utf-8?B?UEFtM2tXdklBWHRlcUhTRWtoOVEwNUUyb2dFdmZHYW9FeDdwRzBzM24xb0Nt?=
 =?utf-8?B?L3pPeW5PbWJWdzdnUytiYWNFZHVtSEM5UER2d3NTWTQwaVkzOHNST1kvcVlu?=
 =?utf-8?B?SER5VDhhRnVpbzljeUxZNktITWdrQ2p1Q1dKOEZvb0dtczlzMC9MbGxMNTYw?=
 =?utf-8?B?cHlQK1R1b0x3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZMVjJiVUxPTEVmQ0xPOXcwLytTUmZqcUxrajlkVVdpSE4vOVo3U0FUNFJu?=
 =?utf-8?B?eHpXV1IzQjFNWjMxRjdNdnhCVjROK08vcStPa1ZVV2s3WTZRRllnN0NSNUZs?=
 =?utf-8?B?VmFWNFE4RHJ0anE1OW1ocVNYNExHSmg2ck5EanE4TmgrcnpsQW5LbG1xMlVH?=
 =?utf-8?B?MzlGNWNOVnNBRmpPc3JyVThzdG54VEZWOUpET0UyQnl3NnhMRkg1MTFCMklS?=
 =?utf-8?B?NjJXQWVJSjhnbWJwTzRVNW1kWHdnVlV5dXlnd3VwbHo2cCtOTDdWT3J5S0Ew?=
 =?utf-8?B?YnIxeVZrcGMrMlNHY1F6TVhWOVJHaEhNZ0NDZEtnRy8va3gzeHRhMEhZVll5?=
 =?utf-8?B?dWk2dXJ2Ui9sVGFGajIzVEJRckozTERCTzNob0RsUkh3dGNrWGF1UDJ2UDBR?=
 =?utf-8?B?OGR1ZWh2enBsUFdsUEZoYlVyYzBrRXJDK0xCTjVpWktuQi8xSm05WmJQUVZP?=
 =?utf-8?B?Y1Zmc2dZaDg4dTVCYUxJUXZBZTBNL2xyTkZMeGdmTS91S1BuRzhSM051OFBS?=
 =?utf-8?B?N2EzZUMzTGpkc0FnbHFxUWl1Ym9sa3hQQjRwR3FtYUNubXNqdUswaVgyQVN3?=
 =?utf-8?B?Y2RyNEliTUIveXJxVi9HSVcyV3VrQW5kdG0vNC92c3VRVkU4dWk1Q0hUbXZ6?=
 =?utf-8?B?TDV1TWZCU3hUWnMwRTh2S0k4NENYQkk0MHhhZVRRZnkwNGIwNmxpSFpsbGlC?=
 =?utf-8?B?bFM5WXNoQjdWUWFBckxRY3BYKysrOXdDUitIbEJ4aDNaa1hyV3pkS3FkVnJH?=
 =?utf-8?B?ZXJYN2t4Q0h1VHZNNjV2M2RWVjhaeEJMVG5rL09kNk1vY1BwUDIzOWo5UUVI?=
 =?utf-8?B?M2RLRW9CSHA3U0NPbHNKeEVUVC9meEZ3bHFCYTE2eXVCTHhod0ttNytZdXg2?=
 =?utf-8?B?Rzk3RVltbnQzRjlVS0FTRFk3TEIzNlJsWEFZMmtPZ1F0bk11QzZXTUVWK3FV?=
 =?utf-8?B?aW9wRm5oZkN3Lys4WTdST2tZYlp4eHFVaHVlTGFUbmwwaUZJMWVJY3pLM3dN?=
 =?utf-8?B?TEMyMzFnYTNkcWN4bzRjeWZLTFBUVXZ3TGxjL1RSTFd2M0V5NDhUNXQrRCtI?=
 =?utf-8?B?NExkcTdSZis1VGUrSWJqMnJSd0hTcGVIQThGcEpHZFBlM0h5Wmg0Ykx5dGRC?=
 =?utf-8?B?b1lDU1kwT3FFT0x0RlZCcUhhZVZOdEgwSG40aGs1bFAyZ3pMdnpDMHlwcDZm?=
 =?utf-8?B?TDdQNWZJTmdMaVVIK2JiWVkxK3RRU2tFUFhLWVc0R3VSTm5DK0M4WXJMUGtu?=
 =?utf-8?B?UzRlU0Q4RGxnR1hZbzBCeHhoa2RKc0FzdHZMcFZDRGxBSVN6QkJJNlQ4UXNt?=
 =?utf-8?B?T1VsRDhxRURUYVBtaXFRMmlsTVBleW1YRkJvWmJxYzNxZENTeTU4QktWNlk1?=
 =?utf-8?B?cU1zOTRuK0ZhUFRrNEJvTjdOUzk5WDBhTDRLTmdrN2hIWUtaVE9yUlZIaW9h?=
 =?utf-8?B?YzRoMkN0QXplTVN2V1B5MmU2WUZvUHFkUWlzTmlZakJUZWpzeFA4SngvR2Zj?=
 =?utf-8?B?dnpLRzdHMmdvdDhYN1lGQjZlTmJ0SE50ZFpFRmpzYkF0cFM0Z1pqaHJrYkR5?=
 =?utf-8?B?V2tGVHhoUFF0OURSS2dOUTJNbXM2Q29OZEF2a0JURHR0cDcwMU1Id2RTb0tt?=
 =?utf-8?B?ZU9yN010bEFhZkdmZXFndHk3UWc0bWlMaFBLNVZ6MFZ1d0pENDdBSS9JN3RY?=
 =?utf-8?B?TXQwOVZOVFZhODdDdklvdXpoMjNxQXFCOUhBMFFqVjFtWDZnVCtvNis4NzZI?=
 =?utf-8?B?NXJKcnNucTlSb0JGNFZQbUlrTExGVUVQc2V6a3ltdjBEM2lUeHhTWTlaNWla?=
 =?utf-8?B?M3cwM3ZDSzc4d1lKb0k3N0FiVVdWNzVWTnpmWEFyUDJWbW54a2FyeEx5ZlpT?=
 =?utf-8?B?VEM4OTJza0R3eHQ3VitjWVZZL2NsZFNzUnZSczZ6eGx2WTl4TS9yZE1hbk9m?=
 =?utf-8?B?OUNkMG03blNXbmt4amtwUGJYZWdFRkJFaVQ4Y2RxYUFpNFJMbUVJMzF1OEdH?=
 =?utf-8?B?QW13OGZlNkhQOGpCOVRNblVkNVp2ejdrVTZEYWVDeVYyUlFsNWxDcnQxdklj?=
 =?utf-8?B?bFoxeCtQcXFxdlZuR0NtV0p3bi9URm1NdzZScVJycXZKQmh3U1RtdU9WeThq?=
 =?utf-8?B?S3AvaDBNVWpSK0ZhaldiOGRtc2czWUdKZlk5QUprZUtuQUdaeHdPMjZnWnlk?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f45552e8-5e48-4629-62a2-08de3dc281bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:17:54.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bafqGVoXyX5Rz/s5mqYHWYMHCvxCr7aalM6uWGqFZ9v3QIphs5tz67omi0QRzd4gG5ozz/FWT90YcjKD52NT0WwQpN+F0/V1gkREdYas+T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com

Koralahalli Channabasappa, Smita wrote:
> Hi,
>=20
> Sorry for the delay here. I was on vacation. Responses inline.
>=20
> On 12/2/2025 2:19 PM, dan.j.williams@intel.com wrote:
> > Smita Koralahalli wrote:
> >> From: Dan Williams <dan.j.williams@intel.com>
> >>
> >> Insert Soft Reserved memory into a dedicated soft_reserve_resource tre=
e
> >> instead of the iomem_resource tree at boot. Delay publishing these ran=
ges
> >> into the iomem hierarchy until ownership is resolved and the HMEM path
> >> is ready to consume them.
> >>
> >> Publishing Soft Reserved ranges into iomem too early conflicts with CX=
L
> >> hotplug and prevents region assembly when those ranges overlap CXL
> >> windows.
> >>
> >> Follow up patches will reinsert Soft Reserved ranges into iomem after =
CXL
> >> window publication is complete and HMEM is ready to claim the memory. =
This
> >> provides a cleaner handoff between EFI-defined memory ranges and CXL
> >> resource management without trimming or deleting resources later.
> >=20
> > Please, when you modify a patch from an original, add your
> > Co-developed-by: and clarify what you changed.
>=20
> Thanks Dan. Yeah, this was a bit of a gray area for me. I had the
> impression or remember reading somewhere that Co-developed-by tags are
> typically added only when the modifications are substantial, so I didn=E2=
=80=99t
> include it initially. I will add the Co-developed-by: line.

Yes, there are no hard and fast rules here. My expectation is that if
you make any changes to a patch that change its "git patch-id" result,
then add Co-developed-by. If you make "substantial" modifcations then
consider taking Authorship and move the original Author to
Co-developed-by.

[..]
> >> +void insert_resource_expand_to_fit(struct resource *new)
> >> +{
> >> +	struct resource *root =3D &iomem_resource;
> >> +
> >> +#ifdef CONFIG_EFI_SOFT_RESERVE
> >> +	if (new->desc =3D=3D IORES_DESC_SOFT_RESERVED)
> >> +		root =3D &soft_reserve_resource;
> >> +#endif
> >=20
> > I can not say I am entirely happy with this change, I would prefer to
> > avoid ifdef in C, and I would prefer not to break the legacy semantics
> > of this function, but it meets the spirit of the original RFC without
> > introducing a new insert_resource_late(). I assume review feedback
> > requested this?
>=20
> Yeah here,=20
> https://lore.kernel.org/all/20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.l=
ocal/

Thanks, I will go reply there.=

