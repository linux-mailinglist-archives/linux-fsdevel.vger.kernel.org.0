Return-Path: <linux-fsdevel+bounces-73490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77329D1AD78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE8DC30119A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6E34EEEC;
	Tue, 13 Jan 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JspSnzJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9634BA24;
	Tue, 13 Jan 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328979; cv=fail; b=tosZe4yGIaKyVM+tmCLzCt7Z6jrRiFwAtScFqV9T7vhU6pCGMDvcaAEEbh/yYjKnVlPmrv3FqnXpigeMw/Dxdosx42ClfxmcvhVCY27gwC0yz7HkSSuqDtb4qXDNL2ZCgnUL2s88U30ZYF3bk+BkzIuzlRLKiTKhDRukywUNy/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328979; c=relaxed/simple;
	bh=bpCToNOvtup2dzD2g4fwk7t1+FoulXncXu2pycDcvJU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=e79/RVSV8nwkpVjYzhBng5QMMVSsRdIpeWochazCqi6d7LkzV7Y/GSAwLBs+cvKnGNwc9oSWPAG1ODyMpBfEQfVF0EraJskbpVvIofrMaRZMxw7jCyUncGuWHlmtBHijZCQe2uq+1BYfTXLWjsxQ2tK4mVWBEpG37V9OJlh8qkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JspSnzJ1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768328977; x=1799864977;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bpCToNOvtup2dzD2g4fwk7t1+FoulXncXu2pycDcvJU=;
  b=JspSnzJ1LKAtl60j+VcSEgZQ2UGzgNHD5vemoV0VrCNHmfVKTNF2IYMa
   MO6sRW0MiMPCes+eu/a1SjEvpQYyMuGFzcDV39fk+9c/0RmGjXhx5rZ1F
   Ewq4/njkHZuSPCCPVBXEpMCWujaSAeLwI3hB8J8CI1YME8ZgH2AEQM6xj
   Q/2KlFnSKoTkk0vqhQf1BIGnKUXclPDyzJroY24y+cI0z3CScDMpSYYJ9
   hasAeVb5jKc2h78MimQSgmscqO9VsR9YaLrfUGzialTCtiL+nhDmGogTJ
   B43IY6PObWJF1mQz3W8dOF3YdWqOEctP8XB5UosFvbfbz+Z6Y8Kl+L3tY
   g==;
X-CSE-ConnectionGUID: Qv8OGka0QiexCwA7RLeINA==
X-CSE-MsgGUID: Ro3DhMPlTTmNLEdBjH3AxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69678548"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69678548"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:29:36 -0800
X-CSE-ConnectionGUID: G/klgHnOTP++28yQ8g/tFA==
X-CSE-MsgGUID: zBVjMMnqTouJ6rerN4zCTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204737715"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:29:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 10:29:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 10:29:36 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 10:29:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxBucCMM6i+OCFc13f3TVWxSyA9MnJ6DV2OciV2+PqHp36NohoSvQYjTC8I2vJVI6EXXmweoEoRBpxbNhjh92OtoMrqTUH7S3j0ELtaWvAno5iKNUklvoHktaN5dEz5NMVT4lrpvt63U6nAFZLSEwaYlhoNhOU5GFRGVYOWiZP7iU91uYmQAuXOLxtbYd46XNJSDk5XMeoPMNBPw5Cy/0RDJ3N+hjnkycaBKv4TewnUpRms1wSs/AiIlU0HXpvjxgz4FPEanz5pNdg/sRs3FJSUEqt41nl4c19EdCEdR3QsLHXc5Cpy9Jf5GrNGDZWHTUX+JHCkLDGfP8360GLxCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXSwrkhMTLPZ5mMU1mkU5mdJL9NJJcP0XHB9CU2cqME=;
 b=AtjX1qobmqngLZkddsABJ096bnqFvFg5WWfYi8zFEQS/zHPhapqwgH3SVGsUiBST5XVFJvjdZNdbHOaN/LYxYi0oPZXRHxKKBOfOIRjm7+vrMXDnA7pQ10Vef1nI5UtLuaEXkIcM5NJ7L1HxnPFJ7AO6ZOcT9LOdZFnlFPYqvhSos2jNdpZZDZJavlu4bx8FkUPKBMtRYWyI1mD8CVr1Of0t0X31zyVYJXaLQl2sXupBbWPNKcBGCH1PKa3vV635AgpMiDxZnJIZKeSHONCY8nE78s7HDQ/Qz7nRTKVLkhw01GqRPDO0E5xzGGhWwO6xsHifihj29RntinFil7CXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 18:29:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 18:29:31 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 13 Jan 2026 10:29:30 -0800
To: <dan.j.williams@intel.com>, Borislav Petkov <bp@alien8.de>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Message-ID: <69668f0aac4d1_875d1009a@dwillia2-mobl4.notmuch>
In-Reply-To: <69443f707b025_1cee10022@dwillia2-mobl4.notmuch>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
 <20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local>
 <69443f707b025_1cee10022@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7ab83f-35a1-4ce4-4876-08de52d1b167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFQ0WjlpKzVuVEttaUZqK1IzN3hHSkRSM3d1azBHNVZmd09pelJQRTZTa2hJ?=
 =?utf-8?B?WW9MOWhBa2xDcUdSTU1kQ0JHdk1SSTkyRVBQbDdQYWx4L0FIdjZxL0d1RUhF?=
 =?utf-8?B?Z1dwZ3ZXZzA2aUtsUGxmVktNT1BsNmhjRzdRQ0oxVmVmUVVCWnFQaTlTdk4y?=
 =?utf-8?B?ajdoM3Q3YlgwcUxYakVhRG1QMWVEMkhsR1IwaFZRNTZwVkhpQkE4aFM4Y3Bi?=
 =?utf-8?B?Y0VjbVdhTTVicDRxRkxDSzZhMEQ5NTkzYXhxZDc2Sk5mYS9PV0JKR3hJMkVq?=
 =?utf-8?B?LzV4Sm1yc203K2JzdFJNKzBucmxsV2wxZ0pabWhkTjFTb1RKOU44Z1pva3ZJ?=
 =?utf-8?B?MkI5ZW5zR0dpTlFVQVIxMS9tWWlRV0YxNEs1bEVDQ1J4ZDlKYjl1MHFrWk9y?=
 =?utf-8?B?Z29wcFdKc1p4UUNjQmg3VzAwdlZhNHpCR2lJMjYwNGlJRlNFaVVFRlVBWTkr?=
 =?utf-8?B?bEVQNmEyY0VKZ1YyS1hzeGhxMjhmS05GK3RtWDgrTUFtbm1FczVCTzZ3akk3?=
 =?utf-8?B?ZEhqcWxHWmhLaDZ0Mmt1eEp1K0JwdlNVVTN1Zkl1c0JERmVtUXhOUU9TVFlD?=
 =?utf-8?B?VHRuNUh5bHExbml1SWk2V0ZSSnpxWFRyYVlSQURVbHBpamYvbmhIZW1uOEIw?=
 =?utf-8?B?RDQ3VG5JbEppNVM1N0dSekY1YjVjV2IwdnAyUmlPelZiS2YzYU5HU2FEbjl3?=
 =?utf-8?B?QUxKR2dtK3QxNktIZWE1UlNNVFY4WUN1eTVjSWk3dUFwQmJGMElHeUF6Qzhz?=
 =?utf-8?B?K2JSVXhHcVptOHRjcTBoZlp5Qk1aR3EvOTJlQmJsNkVzTW13azhCL3dSZ2l4?=
 =?utf-8?B?S0UraHFBQnZ3RzdqNHA3b1FkRWhlNHZSR3prdmZITUxvNWtPK0RNa2UxMER1?=
 =?utf-8?B?cGpjUDR6RkdGNlJYc1JTb1JRUkFwL0FyNlhJaEcyUFI0NzV6RVVvR3E2YTUy?=
 =?utf-8?B?L1hBc0VPY2c2bUYzZXd1U0RFTEJLUkNHbERKVzRZQW5SZi9iWHJNYU1VUnBL?=
 =?utf-8?B?SFJiMkwrS2E2ekNwRmJZVnlWZ2x5cG9sbWVQUEc5ZW5oYnNwSGhSb2xNY1A5?=
 =?utf-8?B?VlVQRjYzS0ZIaVFBWGl6TEp4c2xwbG9kc3RFNmtWYmxHMGRTaGo2SEtnOE1u?=
 =?utf-8?B?Nk8zL3lPZVBVeXVTZnVWNXdUQjVKUjNuWW5IVkRDSTdQdTJUcXVUbmRaTTRB?=
 =?utf-8?B?M3lVV3gxQ2NpS0VPRm81QWhlWi9nc0FteEhHSTRSRFFTOUdCdXlvaUczdm54?=
 =?utf-8?B?ZjFmLzh6TEVlQk9XWlJpdnQ5bmo0SWdyaXZjYjJYbUxibmx3ekhGeHl3cS9C?=
 =?utf-8?B?dkh1bUJCU24rYWd2NXRCdXlmdS9pZTMvR1d0WS94SnZLSjNvcERWWXdpL0w4?=
 =?utf-8?B?YkppcXVVbG1wRitCTVB4VldhckhqT0RQTERLZlA0ak54ejZYa29tb3JBZHpC?=
 =?utf-8?B?bFMvcE1EYXdpbEFBTEQ2UFNLbUtsLzFVSk9jaXBGT25ZRS9NeGxCNDU4R0tL?=
 =?utf-8?B?UXFNZWZ6QVlUVmF0cVpZMTM5c0ZjSS9yRWJpck9USkxaaENUZHlWZU9oU1Ju?=
 =?utf-8?B?OWRCTWtnaWVSVGNaL0h2d3JPRk4xcFN0ZitFUWtabk1Nc08xdG0xdE51R1pD?=
 =?utf-8?B?akxlWHhIcVJFakMvSmFkcVlYdFUzVHdGbXZFLzJkeFBiNlVLZXJISVJYN2d2?=
 =?utf-8?B?ZStpdUl0MDA3MWVJNzhYbzRyeHFNL0VXbzdYcWIvZklWS08rK05UdVRzNmF5?=
 =?utf-8?B?M2x1ZEJIMk8xby9hM1Z0TmIzRlgvenJ3TE1YZ1Y4NzIyWWRKbERZL3d2bU5V?=
 =?utf-8?B?VlJhOHkvdUs4RVF1bjluUW1YTGtIUGd1KzJkc2g4b0J0dHdhWUhSZmFYOWF2?=
 =?utf-8?B?SzRTS0MyTmxuRHp3OXZJWkpweFRDNHJRQU5YSUtydWRqR1lUejZXQTlPbzk0?=
 =?utf-8?Q?1CTx7gSs83vsCUbAHN8OXHc6LVAB+b0E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3BDdlFhVFRnZ0pCTmEyOU1RYmRKR3A0ZmtnVCszZURYa090Rnk5YytWSmVC?=
 =?utf-8?B?M0FXb0RDbzRiWEd3akg2QUtnQUJHZHdtd2k1aTI2Ykg2TklZdkFsT2xkekZM?=
 =?utf-8?B?MzMyZU1TYm0wMWxjSXpPeTMwQ0huVHExc0N4V0ZrM0orRjlINzhYMXJmVVJj?=
 =?utf-8?B?RTJ4STNsK1pWQTVTVlpPdS8wUHZBL1Vpcis1VzRJWExwd0lmWUNDaXc3bG5B?=
 =?utf-8?B?bk84NjRmUmp5MWhab3dzUS9nU1V2OVEwU1pVb1ZybkEvZFJqa3pXaEZleDdP?=
 =?utf-8?B?bGV3cjZ4TmFMclZtRlhRd2VRTVpqcDRNaGdJc294OWNMMzJVU1cweHhXMHhK?=
 =?utf-8?B?K2V2K0IweUVYYTEzcjB5aHRxbWlMZE1qdkJKSWdwTC9GNVdIeHNHT05nbkFT?=
 =?utf-8?B?Q0gzQnowWUwwZFZFZzBqY0pJUFoyOUFLam9YWDVUdDExWTFuWHh1RW1TRlBC?=
 =?utf-8?B?bFplREZuRHhpVlc5Z1VPSVI5NVQvbTc3VWlMVDFDRS92cFpldW5ybnN5R1Vh?=
 =?utf-8?B?c240cERxQkZIMlNUYjBkbDg1NFgrZVVSUjJqeDFjQTFGR3k4Njl0TmhnSmhz?=
 =?utf-8?B?NTN1aUJydVVVdngxcmI2S1YweVFQNE01cmZjVlI2VjN4RU5NYVpjSC95ZDN3?=
 =?utf-8?B?WXVnS0UwUCt1N2lDTEtEK3hYeTNZdzJSUmlTZ1c0ZzdudnUvZjlBUThLWE8r?=
 =?utf-8?B?WlRpYmptTXV2UW40ck1EOVNCNEJXZ28ybVB4ZUp2U3paUkNnUUtHa09JQ3dO?=
 =?utf-8?B?ZG1va0JFMU9VTDBnaWxVZGFFbnAvdXVZRmJwTzdwWmZ3aHJCYzE2Tm9HTmU3?=
 =?utf-8?B?bHNFK1RNR2pGcTRITXluRmJNLzBXUHM1Y1BLY091RnpJSkxwVjdZdFFRSnJ0?=
 =?utf-8?B?dHlKL3RVVENzRzFLOTlPK3FJVXpTNU9JWWVNbW92MzhneG5iekJjRDExQ2Ix?=
 =?utf-8?B?aERtcDVnRmh1WG1DMXZicGNSNXBsZ0xTWGJ0dlExZWRPZ0NnUG1uNmREeHo0?=
 =?utf-8?B?YWkrcnFyUU1jTzZPcE5FMWUxclp6TzRsc3k2dXErd0w3V245cnBNZVR6VUZC?=
 =?utf-8?B?RENPM2FmemlRcG1UbEFuWTlXYnR4RU0wU3hRYjJJZ1JxYisrWUtQb3JEWlor?=
 =?utf-8?B?VUdKcnRYZkJScU1KV2l5SjhCUTBHcW9keHFMT2xWM0M5eldtWXNRZWg1cG5o?=
 =?utf-8?B?ckJVLy92M0xxbE5qcGxLdEJuUHcyTXc0bTNmb0VYUFBER0NMdmZ0N2wwZFNZ?=
 =?utf-8?B?aHhtQnlieDhMNkgvdy9DTnF4RnhWZVl0ZUNFOUI4MVNEOHZhL1NhczhsQzlT?=
 =?utf-8?B?MzhHbTJTa0NxUEdzSlZPQ05kOTl1YUVOQ2o0SVRSNUFJUE1pWlFieGErNnBv?=
 =?utf-8?B?OEtuSkhwYmd5Sm11d3kvMm9rZHpsUE0wblNEZnQxSStlL3F4Vm1zOUFWQ21w?=
 =?utf-8?B?SW9jb3ZNdjlEVjZjS2lSVjdyMktNeVU2MFhSUFBaU0xNUDhDMXhDL21SOVEy?=
 =?utf-8?B?bWNXZUhHT051TE5uaysrK2xWVW0zdWIwU2hIVWFLQ1Z5ZFZYVUlJb1BZQ3FU?=
 =?utf-8?B?SEV6OS9xRFppTTJtVy9xMU45TlZZcjBwbDBmekIxUks1a1BqSjh5VEg1Mm1a?=
 =?utf-8?B?Z0NkYUhrUk9Rc1dNK1VleHpZbVZpMVRIbGdIeVYwWDBMMXZOZEtSSU0wVUJz?=
 =?utf-8?B?UE4xZU5yLzdDZkZLZDhud2NVTk9vQnUxV09rRkdLSmVReFU1UXRXcHdBS21q?=
 =?utf-8?B?eWNpMWtUOThTZlJ4RGxwbDBpUDFMTkdtTlE4RTd2VWQ0UWZwdGZhV1ovQ1RL?=
 =?utf-8?B?Z3JDSm5DNXNBMjk1bnEyR2F4ZmVDQkRvVzhRVXRWeTlaMDlnNko2UHkzcUFt?=
 =?utf-8?B?eHNLTk9nTjNXMEJUMHZGU3dQTEkzTmMxcmdsalZyK3RDTHAzNTN3eDRqSkJj?=
 =?utf-8?B?bU9uQkR0YzlZcU51WkQ3RGxXZElQcGlmeVcralE0OTZDNFhUbW5ldUhVdlZr?=
 =?utf-8?B?SE1PUEpvdHpXTE8za1Z5bmtRNXRkcG9YeXg3Y3ZhUW11VitIaFVPYWRsdzAw?=
 =?utf-8?B?bEVWUTFhQjM0eURXZmNnL2RsZ2ZHSlNLYk8rT3c3NWVGS3h4Tkc2cmlybmps?=
 =?utf-8?B?Q0dETTFiVnVsMkVKY0pLS3luYVFrcHU5a1h4UTl0TWZ4V2JLTWI5dk9IblRt?=
 =?utf-8?B?cmsxS1lCWTd6OHhmK3p4VGIwb2I5MHNSLzRxL1VuR0VuR0NsUjFRSDNOZVov?=
 =?utf-8?B?UHk3b1RQZEcxM3Z2blBicy9scW1WNzVYb0JCdnNqY1lOS0ZZQjhpeGRNRllo?=
 =?utf-8?B?aGZQQzhiWm01S3NXSGRwMVRVRXlKME9QZHlHRGFSR3VBVUtKa2drNk9zZElY?=
 =?utf-8?Q?H97XkQYIDGOwJzNw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7ab83f-35a1-4ce4-4876-08de52d1b167
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:29:31.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TAuI+PCBXQXaVIMZTmrK9SHC70BD6rbvosfjLKuMgm89s1UHuslNlZ2YdN3ajQBoAvjVwMsjiS8N2+TxOcjmao3/P387oGorwSl9GqUJ10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> I am uncomfortable with insert_resource_expand_to_fit() having
> build-conditional semantics. However, I agree with you that my initial
> wrapping attempt with insert_resource_late() was not much better.
> 
> When someone revisits this code in 10 years I doubt they understand what
> this redirect is doing. So, make the deferral explicit, open-coded, and
> with some commentary in the only function where the distinction matters,
> e820__reserve_resources_late().
> 
> Proposed incremental on top of v4 rebased to v6.19-rc1 that also
> unconditionally defines 'soft_reserve_resource', drops some redundant
> arguments to helper functions, and sprinkles more commentary about this
> mechanism.
> 
> I will go ahead and pull this into the for-7.0/cxl-init topic branch.
> Holler if any of this looks broken.

Boris et al, I have not heard any hollering. I am proceeding shortly
with the proposal below for Smita to build upon for her series.

-- 8< --
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 61bf47553f0e..95662b2fb458 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -232,6 +232,7 @@ struct resource_constraint {
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
+extern struct resource soft_reserve_resource;
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
@@ -242,8 +243,7 @@ extern void reserve_region_with_split(struct resource *root,
 			     const char *name);
 extern struct resource *insert_resource_conflict(struct resource *parent, struct resource *new);
 extern int insert_resource(struct resource *parent, struct resource *new);
-extern void __insert_resource_expand_to_fit(struct resource *root, struct resource *new);
-extern void insert_resource_expand_to_fit(struct resource *new);
+extern void insert_resource_expand_to_fit(struct resource *root, struct resource *new);
 extern int remove_resource(struct resource *old);
 extern void arch_remove_reservations(struct resource *avail);
 extern int allocate_resource(struct resource *root, struct resource *new,
@@ -419,13 +419,10 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
+extern int walk_soft_reserve_res(u64 start, u64 end, void *arg,
+				 int (*func)(struct resource *, void *));
 extern int
-walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
-			   u64 start, u64 end, void *arg,
-			   int (*func)(struct resource *, void *));
-extern int
-region_intersects_soft_reserve(resource_size_t start, size_t size,
-			       unsigned long flags, unsigned long desc);
+region_intersects_soft_reserve(resource_size_t start, size_t size);
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0df7d9bacf82..69c050f50e18 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1151,11 +1151,18 @@ void __init e820__reserve_resources_late(void)
 	int i;
 	struct resource *res;
 
-	res = e820_res;
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		if (!res->parent && res->end)
-			insert_resource_expand_to_fit(res);
-		res++;
+	for (i = 0, res = e820_res; i < e820_table->nr_entries; i++, res++) {
+		/* skip added or uninitialized resources */
+		if (res->parent || !res->end)
+			continue;
+
+		/* set aside soft-reserved resources for driver consideration */
+		if (res->desc == IORES_DESC_SOFT_RESERVED) {
+			insert_resource_expand_to_fit(&soft_reserve_resource, res);
+		} else {
+			/* publish the rest immediately */
+			insert_resource_expand_to_fit(&iomem_resource, res);
+		}
 	}
 
 	/*
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index e4a07fb4f5b2..77ac940e3013 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -856,7 +856,7 @@ static int add_cxl_resources(struct resource *cxl_res)
 		 */
 		cxl_set_public_resource(res, new);
 
-		__insert_resource_expand_to_fit(&iomem_resource, new);
+		insert_resource_expand_to_fit(&iomem_resource, new);
 
 		next = res->sibling;
 		while (next && resource_overlaps(new, next)) {
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 22732b729017..56e3cbd181b5 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -83,8 +83,7 @@ static __init int hmem_register_one(struct resource *res, void *data)
 
 static __init int hmem_init(void)
 {
-	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
-				   -1, NULL, hmem_register_one);
+	walk_soft_reserve_res(0, -1, NULL, hmem_register_one);
 	return 0;
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 48f4642f4bb8..1cf7c2a0ee1c 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -73,9 +73,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 		return 0;
 	}
 
-	rc = region_intersects_soft_reserve(res->start, resource_size(res),
-					    IORESOURCE_MEM,
-					    IORES_DESC_SOFT_RESERVED);
+	rc = region_intersects_soft_reserve(res->start, resource_size(res));
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 7287919b2380..7f1c252212d0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,6 +48,14 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
+struct resource soft_reserve_resource = {
+	.name	= "Soft Reserved",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_SOFT_RESERVED,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 /*
@@ -451,24 +459,17 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
-#ifdef CONFIG_EFI_SOFT_RESERVE
-static struct resource soft_reserve_resource = {
-	.name	= "Soft Reserved",
-	.start	= 0,
-	.end	= -1,
-	.desc	= IORES_DESC_SOFT_RESERVED,
-	.flags	= IORESOURCE_MEM,
-};
-
-int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
-			       u64 start, u64 end, void *arg,
-			       int (*func)(struct resource *, void *))
+/*
+ * In support of device drivers claiming Soft Reserved resources, walk the Soft
+ * Reserved resource deferral tree.
+ */
+int walk_soft_reserve_res(u64 start, u64 end, void *arg,
+			  int (*func)(struct resource *, void *))
 {
-	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
-			     arg, func);
+	return walk_res_desc(&soft_reserve_resource, start, end, IORESOURCE_MEM,
+			     IORES_DESC_SOFT_RESERVED, arg, func);
 }
-EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
-#endif
+EXPORT_SYMBOL_GPL(walk_soft_reserve_res);
 
 /*
  * This function calls the @func callback against all memory ranges of type
@@ -692,21 +693,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
-#ifdef CONFIG_EFI_SOFT_RESERVE
-int region_intersects_soft_reserve(resource_size_t start, size_t size,
-				   unsigned long flags, unsigned long desc)
+/*
+ * Check if the provided range is registered in the Soft Reserved resource
+ * deferral tree for driver consideration.
+ */
+int region_intersects_soft_reserve(resource_size_t start, size_t size)
 {
 	int ret;
 
 	read_lock(&resource_lock);
-	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
-				  desc);
+	ret = __region_intersects(&soft_reserve_resource, start, size,
+				  IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED);
 	read_unlock(&resource_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
-#endif
 
 void __weak arch_remove_reservations(struct resource *avail)
 {
@@ -1026,7 +1028,7 @@ EXPORT_SYMBOL_GPL(insert_resource);
  * Insert a resource into the resource tree, possibly expanding it in order
  * to make it encompass any conflicting resources.
  */
-void __insert_resource_expand_to_fit(struct resource *root, struct resource *new)
+void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 {
 	if (new->parent)
 		return;
@@ -1057,19 +1059,7 @@ void __insert_resource_expand_to_fit(struct resource *root, struct resource *new
  * to use this interface. The former are built-in and only the latter,
  * CXL, is a module.
  */
-EXPORT_SYMBOL_NS_GPL(__insert_resource_expand_to_fit, "CXL");
-
-void insert_resource_expand_to_fit(struct resource *new)
-{
-	struct resource *root = &iomem_resource;
-
-#ifdef CONFIG_EFI_SOFT_RESERVE
-	if (new->desc == IORES_DESC_SOFT_RESERVED)
-		root = &soft_reserve_resource;
-#endif
-
-	__insert_resource_expand_to_fit(root, new);
-}
+EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, "CXL");
 
 /**
  * remove_resource - Remove a resource in the resource tree



