Return-Path: <linux-fsdevel+bounces-77755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB97Kqukl2mf3wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:02:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3C163C44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1503014553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4954654;
	Fri, 20 Feb 2026 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ogeBGMjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAF632;
	Fri, 20 Feb 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545756; cv=fail; b=aWpFDww7A33ZAeueG7us/i0hHvajzDoVost+fiMfEF7UT6rLuwl41jHY75iBZeBiVk565aTWIIM0ml9mH5yEWJ5yT/DsZiM7xpMG2G/+uqPhP3Mzx/MkBVi71BLtVxGNJiRDAqAy6Gh9c+yVEy7ApUwbDnaQLhx3dI/Jl81Sdec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545756; c=relaxed/simple;
	bh=SIPeTr0raz5OhEHmAbn8twrgrlesD1bPeyRqoCxyn14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVEkBtHfvyQFL19d8cZ6Uxs+AG6xn7B48TRAiuRsc9ICSUWrCgH5gSE21goqGpWhC3NtbNDc0LFqcClyQsLf9IMoW9ilCXjHgaZb6W7gEeIyHJBLnPXFK7Gt2I0EcRN4d8Tp5w6vmuDsj2I668ZbVKtjsmakHcpVVDXIqlc1nTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ogeBGMjT; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6cXw+bxfZOHJ/eJhW0JukZBiHt/EdQHZYb8BVaxME3FPD8AWg4smnp9lmRA72GYWmE042TPBYzKVeQi/wfueFO1iNB2xPBgUspJREim4Z0SoAYfHPfuAexVrNMUX6CcNX1Q8PO/99tRGc8EwXnNh1walUUsDyeeJAQNwH5UUrJtCWg2reUfEKfNENiMfQmKx/te0Kc0saqMhnbFXnU5fO9h3alVXbcR3thzqtyWJYAMgYqRGiQTPtYujdAvYYBz9JZO5Lz57ab4Qokf+NCuXmU0QMfaB6GjKQrjbBXyTlSun6YtHVR8vg66Bo7mc/yZilwXy7gS8C4H5hWiq/gIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVWeLilEsTZukJvN+q2eRQ4t4bar0ZbBbIbmIdcI6Do=;
 b=mw88iY2xmY/mwpAjSS/JjA0uHvv/JveLxAvXRrI5Xq1kEZEUN/l5VUp+r4waQXrR1hCgW63Ipx7DUF2Hj8rbWo6zqdaFVRyAYUe6Xlhg+6Rn6eRBmZCcGPO8t/Dhoq6dzmxNR013E5pbZFdT57IVGjvxCEujH03XrY3DDBxlJim3yyIOkEUPJbjvSZHIfFqJbehJHulYfPDHRdAvcCq32RJXUtwZrRAq7f0SYyeNN+TQGMu0cs8WF4nasOe0H6FGHqtqf3Ug8KohvasGXniUwmQFRtG6iLtTtDhBmJeDE7OUCn8Wpj/QhJBS//dEUhw9M6Ae+MXPU0Yq3AjacSx1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVWeLilEsTZukJvN+q2eRQ4t4bar0ZbBbIbmIdcI6Do=;
 b=ogeBGMjTf5v/Lh2cNmRXufcNram0CLLRtaPlAZhCbiIMH0EGkGJqH+CoQqAiuG1DbLoUPndMTmD7uw82vZioTxBGs9GKMy4LCTghcSNc8Ew+xb7XPo99nJ1tjzgdWCsv+w1NEHSUsex2v3Ni/6cSymTFGXRp/KjHk02kOPrGJOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 00:02:30 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 00:02:30 +0000
Message-ID: <9b54bd0a-86dd-493b-92be-680c99b23479@amd.com>
Date: Thu, 19 Feb 2026 16:02:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] dax: Add deferred-work helpers for dax_hmem and
 dax_cxl coordination
To: Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-8-Smita.KoralahalliChannabasappa@amd.com>
 <0c464a2c-3722-45e5-9023-5a2fce8aa096@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <0c464a2c-3722-45e5-9023-5a2fce8aa096@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f71be9a-fd17-4777-f6f8-08de7013572e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajlCdWRTeFZLVENzdzFEWXJSM0FJb0dYTDEremJqL3h2ZEs1bXIrYWNnaW52?=
 =?utf-8?B?S1lkMzdyWU0wOUQ1S29rOEd3QjQ0aFkzY2FhdGZiZWVwVnJvMnlwSGZkMHZ6?=
 =?utf-8?B?MDlpb1ZMYWpMbEZOT2gwSkhBL0NCNi8yQndrYjdhd09iTWcyTTVsOUo0VzFS?=
 =?utf-8?B?WiszMy9LZXVpazJscE5iWWhYK0xOS0V4Y1U3QWNCRDRJOGJFQTNoTlUxVEtk?=
 =?utf-8?B?eFVxcnlySWRpQkpuZzF2ZHFkNG1OeVVNamtkamFZekxhbGtEZldONDRGRWw4?=
 =?utf-8?B?RG94aG5ZNFZoSGhRdWtmYWFwdG13TE1yYnJ0RXZTVXU5VDgzZlQwYUM4enBJ?=
 =?utf-8?B?VVdNOFcrTDVDamw3QW9TQ24wdXBiaXYrMDFjNTVDeGdIQXhPZWdTcENpc3VK?=
 =?utf-8?B?K1FIQ3BXa1hVVmlzUmJJaEVVYVdXZ09IeGd2V0RKb0N4ZGxhSnhiSmdsTlJN?=
 =?utf-8?B?UXpSYWx6MmdtdE5naU9vMmphQkhkK2VpZGRXdTJOM3JQNm95REdRcHcwMzJh?=
 =?utf-8?B?bXU5S2t4cHpqdVBheVpaYUNWSUtCTmg2SjBCR1VpZGg0aXdRMTlPNDRTck1j?=
 =?utf-8?B?VFZiN3ByUlVVa0JHSWJzVjBVWEdldC9SaVo5TjRBdXY2aEZLMVk3cmlTblow?=
 =?utf-8?B?Zjd4WHlZTWJvdFJ6cWhseU9JeWZpbmNnMklDUXlkM1lXK2pLaDNXV1pESUJw?=
 =?utf-8?B?VmIzMW5SZDBCMkxqZkZUQmJValJSelhQZWhOVlFjUTRKc1dJajBBZ2NiY1BR?=
 =?utf-8?B?NE9kanBXdHI5VEViSmxxd1ZobzREQ2RKQzRTQ3dINTVlazdaQ2ZpOTJXcmx1?=
 =?utf-8?B?cGZtRFpMTW9hQS9CbHFyR2lqc1BMSCtUN203ejZod0ZYenZQVUs3OW52ekQr?=
 =?utf-8?B?WXM2aW5WMllDZWhVaVdWUEtEM2FNSHBWQzI3bmkwQ08zZm42S1VkY3lObFQz?=
 =?utf-8?B?c2QwcDBHZ3BHZnZkU1lpc0FoWmgxWktEdWNnbGZRQXZPN2dLd0l0eFhiaVJj?=
 =?utf-8?B?dlovS1JFczc2Wk5tdHV0WTBYcmRqektGYkpOS3djMy9OZHBHb25HR0tHekZD?=
 =?utf-8?B?T3V4VVVSWFZhRGU4SW1KakNuN2N3WE1DRHdXYjc2a2w0bUtLNXVHZGFwaEFz?=
 =?utf-8?B?Z01MeG9NZzZkODFIYi9wNzhZWW5QZEQzS0lhdHIramcvT1pDS2pZaDM0clpR?=
 =?utf-8?B?aE1YY1I4VHp6NkxOZTY1UGdNcjVQWjUvMmh0VjFvTDRqblZXVlZXUXdaU1o1?=
 =?utf-8?B?YklOeENmYS8vUEVZWVRNZ1ZBQVdnVFZHYWFBekU1L1I5R2h1SDhZUkJ2ajBz?=
 =?utf-8?B?ZEpvTDBncDdHN1RXTTI2dVhhTjhTbFF0amRvQTBhNVJUbEFtYjd2UW5ibU4x?=
 =?utf-8?B?RElWaENTN2xQaVZRc1NwTDVPd29rdGZyOGJQWTdkWDU3OFVIVUNKSkFYNXp0?=
 =?utf-8?B?OE1yUEFLS1RLRTJHL1JKbGdxbTlBc1NuM1hQcGZoZ2I0SkNGZzRwYmMwMnJr?=
 =?utf-8?B?UitPOHYzcEJRWEw2VzNTMDF5bXJSaXFaT1IyLzZLbm9JT29TdXg1N0R6cnRj?=
 =?utf-8?B?TGgyV1RiTlE1RE8zSFNBYnUzMHJDWExDSG5BQjFsak1oMTJ3NUIxbmxzS3Bw?=
 =?utf-8?B?M2RzZWttdmNYQWFKMDNOK1grbEkxdG9ReUFBb2F6M3R4eXN3UHRpYzBHRVpR?=
 =?utf-8?B?TVg1TURobm9OQXIvZm1VRW56K0hCZ2dsR0l0QStwMmQwaFp5Skt0RjlJVmtZ?=
 =?utf-8?B?eUJobVpjVDRQS295UC9wUnRnNTd0RURzUk5oTWhHeVNkOWNHeGgvNFd3eUpX?=
 =?utf-8?B?V0dQWjNYZTROWkxUNDdqWnJjQWhzazFmOUgvanUzT2poeHZKc2ZGcTB4Z09j?=
 =?utf-8?B?MVJwcVJFdjErbCtoV0xvcHdyblNGc0ZjYVpheGNMUEpPM1VleFAzMWV3SlBV?=
 =?utf-8?B?Qy9oaXQxT0lmUFBibVRmNWF6T2RiK096K2lSZWc3YUhHUXNFeDU4aHV0dFRX?=
 =?utf-8?B?UjQ5d0lwVmtxMXczd2ZnNktBZFJkcDhpZWVxdzFMb0xLOFNuTTMydzl4eFJu?=
 =?utf-8?B?ZkJ0SW4wdEM5SitBRVBqdUF4TWVaZnIyajdvcWtNWEdQSVdyUDdoSmJXaWpL?=
 =?utf-8?Q?WMMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRiNHpSRUYyOWVaVnpYd0RFOW42Y0NtSkhtbXBpWXVKM0t2UTl6U29ibnJR?=
 =?utf-8?B?b09RdENhZ0NJMjNka3B6MWNML09PaWVNYlIxdStXZzlMaEtPZWlrSWpBZWFr?=
 =?utf-8?B?aVFDejFxTWxQT1drNkhJSWJ4d1M2d3FMU1dJeXhpZEptZGovZWFDcythUVE2?=
 =?utf-8?B?TGlOc0ZSZWFUWjNKRTZhc2dUMUtINWhNellvcDJKOEF1UTh2YzZqMTkxbVVP?=
 =?utf-8?B?NVdFWm01RnRpaEQyb01hYWxvSEZ3VkdPMHJxMHdFVzlDcnBTeXlmNVRabDNY?=
 =?utf-8?B?dmlkZzZMa3c3M3lpV09QK3Z5ZmdVL1pQQ3BnL1VNYUpVb0dNdVFmckJTcVBV?=
 =?utf-8?B?OHE2VkZ3dUhYbmdHbW1mZk40UTlocnZMZE1scW1nd1NJaFp2ZjhlbjVkbkZo?=
 =?utf-8?B?L2ZjdnlsQ0Z1d21xZzFGaXQ3SkVTSnByekd5SXQ5UFFJVE1tTnVEeHdvc2Iv?=
 =?utf-8?B?TGs1cm44REkwb2hSTVNMRjE2R2dwK0k4VUpmdkNZejFiR3ZIWDFOb3Q2WnJv?=
 =?utf-8?B?aElxMEQydG5WV1pmbW1wZk9TUlllMmh5K04xM0plTUpHWG4rbjRUTFJyNDhR?=
 =?utf-8?B?WEpxZWVZajlxOGZTMlZRT0doV1J2cU5WYWVYRGIrRXU5bDgzbWZCSVFJWlha?=
 =?utf-8?B?OFhSdWx3TFZxWFEvK0x3YXBYc2I0WVVDKzNCQzF6Qk5OV1kvZG5BU2tpaWV5?=
 =?utf-8?B?NDNQR1hNRmRmNDVRK2RpeE9GN1lFSmE3V0RYNllRS2pKNkdmdk5MNlNxUldF?=
 =?utf-8?B?ZFRrZ3JOY0hhYmJxQmZlb3hVTzRlaTdFemdrL0ZpOGsrQlg4MEdwQ0VaNzZZ?=
 =?utf-8?B?QmR6MWM0Tmd1cmN0d2svOHd4dXdha1RUL01uUlNFWnhGallBeEpvdkZ3bWdQ?=
 =?utf-8?B?eVZaenAwZk12c1M0cmhHaFRBeVptSlJIYlhCbElyUUV1dS9sYVRManhndVRo?=
 =?utf-8?B?d09FeStCT09MbSs4VHpzTXFzdjVMc21HQlducml1TDJ6T21yL3RsR3RoTnhW?=
 =?utf-8?B?cnJqdVA3M2V2SmVwUXlPSUYwVk5DWW92bDc4MmRqUXJzdmZyUE0zVGZhUFRs?=
 =?utf-8?B?MWJsTytFUlV6ZjhyWTZkRUNFUG5RSndka0pNM1hPcEtPZlM1QTBHRmRqK3Y0?=
 =?utf-8?B?MzM2VEltckFNWEQvcWJUMVR1c2krcVdENUdXb2M0dGJMYnpNdXA4LyszOENj?=
 =?utf-8?B?cmdVbFY3TnkvZmpPdFQ4ZU84cjhTUmo4UDNWa2tpblJwbm1hSWlHSWhrRDZO?=
 =?utf-8?B?Z3FOSlRVQnY1K0JjMnVqUTY0clVQOW9jWW0rWTJXMUw3cW92R1VWQVUrMmZj?=
 =?utf-8?B?d1FhdjNlaE1wQ21FNjBLVmNBWW5EZW90c3ZsRng0VmlhNFBJT1dPeUVGY1hJ?=
 =?utf-8?B?OU84eWU5dHZaZWF5ZC9kQloxWVFLdERPVlo3UDdCYmhzZmkzK1NlMnZRVFUv?=
 =?utf-8?B?KzlBSCt4SElYMmhMUVJWVklMampBbGRjcXpCOFNkSnJhQit1ME1RRWwvaXg5?=
 =?utf-8?B?ZzNBM1Q1YVJjTUt5ejNqczYvMFJuaGtRS0U5SmZRZVJPYjZqb0JQN3dSeWhT?=
 =?utf-8?B?NnF6eHBHWkU2MUJmdFBCektjc3Fpd2lBMVJocndTUzl5NFA4SHlmVEI5QTZo?=
 =?utf-8?B?d3AwQTlOR3ZtUmNmdzZCMlRHOE50SDRHd29TSDkxQTZXN0plVEdHNjVoYm9w?=
 =?utf-8?B?RkJiaXV4OUMrcFBGUWdxNDZQWm5paUNKMDVla3luTjNISXJMS000NVg2Q09s?=
 =?utf-8?B?Rlo0bUZtM3ZPMDRYaXdlaHJZL3Z6K2cwU2l4ZjBlT1ZUWUJEbUYrVWFybWYw?=
 =?utf-8?B?MG0vcjZBdW9DcU9vbk04cStkRVZ2aUl6WWZRcTU0K2YrU0w2dG1ZUHh5Z2Fk?=
 =?utf-8?B?NHl2RUl4OGhCOWRWNGNOeFBJZWVRQi9SUXZwV2krY3JDWGZFbnV3eDBFellO?=
 =?utf-8?B?SWp5dHk2c0l2OUs4L3JXZ0lwSzB0U29BM2tnaUYvTTFLMTRhOXgrd0Q0WmJ1?=
 =?utf-8?B?dytzdCtuNjhJUGNQdmNVZ2F2bzNIbGo4R0dPQW9IMEF6clBtZVpidUxRNmNW?=
 =?utf-8?B?L2Z5c0tqMDVQa0t4MERtRUNjOEREZEhVNDJwUG0vam5aQnZqcXJ6R2hTZWxr?=
 =?utf-8?B?UFpySzB0eEEyTHpacGVBclFReFV4RHM5SlRSRG5tclRnQWVmSDI1dEtra3p2?=
 =?utf-8?B?R2hHQnczYkw3YTlvUWt4RURGeUpqS2FlRVE1R0htRS9nOElUNWdvY2EwZXh3?=
 =?utf-8?B?c0M2MUdyUGo2a0lkaUFKV1NWQzJSZ3MwWVdjR2dxeXQ1Q0Jtc0h4NWFxMFhH?=
 =?utf-8?B?REl0MkE5b2ZicStqOFc0QzRPWTZTN3k5WE5DMWZYbHI2d3VoZkdYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f71be9a-fd17-4777-f6f8-08de7013572e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 00:02:30.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waePMQcuWpdwpTx8Ue7o1XXDAgkJ2QRn8moyq/QUQ32+P4ZTGoGPIKTdhrIUogWw4YlJV5/9gLyU2F/DLJixHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77755-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 04C3C163C44
X-Rspamd-Action: no action

Hi Dave,

On 2/18/2026 9:52 AM, Dave Jiang wrote:
> 
> 
> On 2/9/26 11:44 PM, Smita Koralahalli wrote:
>> Add helpers to register, queue and flush the deferred work.
>>
>> These helpers allow dax_hmem to execute ownership resolution outside the
>> probe context before dax_cxl binds.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/dax/bus.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/dax/bus.h |  7 ++++++
>>   2 files changed, 65 insertions(+)
>>
>> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
>> index 5f387feb95f0..92b88952ede1 100644
>> --- a/drivers/dax/bus.c
>> +++ b/drivers/dax/bus.c
>> @@ -25,6 +25,64 @@ DECLARE_RWSEM(dax_region_rwsem);
>>    */
>>   DECLARE_RWSEM(dax_dev_rwsem);
>>   
>> +static DEFINE_MUTEX(dax_hmem_lock);
>> +static dax_hmem_deferred_fn hmem_deferred_fn;
>> +static void *dax_hmem_data;
>> +
>> +static void hmem_deferred_work(struct work_struct *work)
>> +{
>> +	dax_hmem_deferred_fn fn;
>> +	void *data;
>> +
>> +	scoped_guard(mutex, &dax_hmem_lock) {
>> +		fn = hmem_deferred_fn;
>> +		data = dax_hmem_data;
>> +	}
>> +
>> +	if (fn)
>> +		fn(data);
>> +}
> 
> Instead of having a global lock and dealing with all the global variables, why not just do this with the typical work_struct usage pattern and allocate a work item when queuing work?
> 
> DJ

Thanks for the feedback.

Just to clarify, are you hinting towards a statically allocated struct
with an embedded work_struct, something like below? Rather than the 
typical kmalloc + container_of pattern?

+struct dax_hmem_deferred_ctx {
+	struct work_struct work;
+	dax_hmem_deferred_fn fn;
+	void *data;
+};

+static struct dax_hmem_deferred_ctx dax_hmem_ctx;

+int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data)
+{
+	if (dax_hmem_ctx.fn)
+		return -EINVAL;

+	INIT_WORK(&dax_hmem_ctx.work, hmem_deferred_work);
..

My understanding is that Dan wanted this to remain a singleton deferred 
work item queued once and flushed from dax_cxl. I think with kmalloc + 
container_of approach, every call would allocate and queue a new 
independent work item..

Regarding the mutex: looking at it again, it may not be necessary I 
think. If we can rely on the call ordering (register_work() before 
queue_work()), and if flush_work() in kill_defer_work() ensures the work 
has fully completed before unregister_work() NULLs the pointers, then 
the static struct above would be sufficient without additional locking. 
If I'm missing a scenario or race here, please correct me.

Thanks,
Smita

> 
>> +
>> +static DECLARE_WORK(dax_hmem_work, hmem_deferred_work);
>> +
>> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data)
>> +{
>> +	guard(mutex)(&dax_hmem_lock);
>> +
>> +	if (hmem_deferred_fn)
>> +		return -EINVAL;
>> +
>> +	hmem_deferred_fn = fn;
>> +	dax_hmem_data = data;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_hmem_register_work);
>> +
>> +int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data)
>> +{
>> +	guard(mutex)(&dax_hmem_lock);
>> +
>> +	if (hmem_deferred_fn != fn || dax_hmem_data != data)
>> +		return -EINVAL;
>> +
>> +	hmem_deferred_fn = NULL;
>> +	dax_hmem_data = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_hmem_unregister_work);
>> +
>> +void dax_hmem_queue_work(void)
>> +{
>> +	queue_work(system_long_wq, &dax_hmem_work);
>> +}
>> +EXPORT_SYMBOL_GPL(dax_hmem_queue_work);
>> +
>> +void dax_hmem_flush_work(void)
>> +{
>> +	flush_work(&dax_hmem_work);
>> +}
>> +EXPORT_SYMBOL_GPL(dax_hmem_flush_work);
>> +
>>   #define DAX_NAME_LEN 30
>>   struct dax_id {
>>   	struct list_head list;
>> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
>> index cbbf64443098..b58a88e8089c 100644
>> --- a/drivers/dax/bus.h
>> +++ b/drivers/dax/bus.h
>> @@ -41,6 +41,13 @@ struct dax_device_driver {
>>   	void (*remove)(struct dev_dax *dev);
>>   };
>>   
>> +typedef void (*dax_hmem_deferred_fn)(void *data);
>> +
>> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
>> +int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data);
>> +void dax_hmem_queue_work(void);
>> +void dax_hmem_flush_work(void);
>> +
>>   int __dax_driver_register(struct dax_device_driver *dax_drv,
>>   		struct module *module, const char *mod_name);
>>   #define dax_driver_register(driver) \
> 


