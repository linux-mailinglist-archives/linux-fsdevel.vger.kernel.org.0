Return-Path: <linux-fsdevel+bounces-75470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP3iJeR5d2n7ggEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:27:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC66689723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C52303F7C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850D33E34D;
	Mon, 26 Jan 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZl/Tcx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C733DEF0;
	Mon, 26 Jan 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437595; cv=fail; b=MoObqUdUOiTGAGwgrV0/x1pMFVBuKDE91LQmEvQ8X1OYIf7N00yXDyg8czdTf2NkEgn/JqgI2FHvbU9vi8m1S9pV3RSijF8qKnvQoHrHP5QoJbV2rzqhqWg4ICcGt5kmjkv7B5W4AtgqHGCx0gR7ffmvgMrTzCwa8yyUJuq2v/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437595; c=relaxed/simple;
	bh=E6BigXxPeqRrb9GxkUOBU30GNCsDXTyibhz9LLkYvQI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=acgHKlQYDVjtDbJlbOnyanI0oyK2Yx/szj9/GfFuCTObGdqeiP2MR1Q/r4cCpl3vjgtL0+PMmWWzrJ9KGWq3uhGumwk8TWMFutPqTDvCLD4dAN8gdhokiWrCcBqqF2Ossx6IagDl6leVQZSBB7Rk7m1FBQPqf4grL3/BwEM0Orc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZl/Tcx+; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cleBdZpoJTNLHU5N7Iaqo7QXYbyGN57Oz93ZB4dNVGAsmadzkd+tlDLl+itdKohRBaNmhT76pWFBUNcnnUQ9bYyVgXw2yOosm9JUDPQV4U7SteLP6qDBIiTSm3rIIkWQoYzHcCbUln9Nhye5CbxGn7t8kRYGqIuocwbmKkT1GAzj3tgpo+SCSOUH8nwwFkPrrl0sv5zoFvpI1Q+8mUZvJDKT8rnilDnwxkb0vokJyTf0UYQL0HywveSLHX8e0YMrHtCpVtj+wWkO6c9h2gUunwUN/pGwHK6mzJvY5qzWdhtWNrd+uJdMubd+ftQCTfGl1Au9Yte9Se1elaV0IRjvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJL6zxP5LOos8T2GS5KbcBYbsr/8hI0c6os/j86XIs8=;
 b=GxPIP/eivpkxnzy7dsKieu/7NiLhOkfQb7oDipaao7hM4VgSX0BB2bfYhxiJHdeEc+vjO9RZsqDQoFxoxYdKvaRMhZYWWqgq/dQmX10va3hpfqtuDQViPptQHiNKABMKq0ro+SC1ijIXinN1jadrt9WeiKnDg36vYKONMPyNeJqOJ3d0GjBIDC/6SwQDLyjo1PhT3X81hUV6B3OwvE2+rB8w+GvSOJmhNP6L3mDd+o47RZDHjEAwaT+swdCTpfTndy5yyJSi14wXd1NAEN/BixdfnhXBpkBzArzeXpgrc6p8ygYDJ2PAXD8Ms3Tt0lzbd7O2RDzkijhbdg/dBFPpOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJL6zxP5LOos8T2GS5KbcBYbsr/8hI0c6os/j86XIs8=;
 b=QZl/Tcx+UgqT/uWwT3iIMhbZF8YdgoAsmGOrZnFDhwoUZvvDR44ALq18FWOEPyU6AkT1/kow/l5+1GBwwHUTzv02orVgqJRuTY17ikAp3ztVZwngN2RCmbrcH3P4PAlKZtZVMH9F03UfzW+yTOUEftsMb/NtDhVTHdaGxbicbmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 14:26:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:26:30 +0000
Message-ID: <d8a9e594-b77d-4855-b808-46a7db6473ca@amd.com>
Date: Mon, 26 Jan 2026 14:26:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
 <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
 <9ee0eb8b-9559-495a-8710-730e7f27d8a6@amd.com>
In-Reply-To: <9ee0eb8b-9559-495a-8710-730e7f27d8a6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0408.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 748b59ac-2f57-4925-c57e-08de5ce6e613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?by9JbnZPdDlTaCtxQWN1MkwwTEM3MDM0OXdmV0dCYnZ6R1hQZ2FLdFRtTzRF?=
 =?utf-8?B?c1laT2ZqMXVncDR3d0VLeWFYd2syYUYrc1J2ZEpMRVdCUjh3eFBZQStyTUtw?=
 =?utf-8?B?Y0N4M2dGTTRpbW91MTFNWGwyY3dvL1pTZmovd0lsTlg3bU9TLzU2bjkvcmN2?=
 =?utf-8?B?T20reWtkTEdOMnlFaTh4VnFzRC9BSG01K2R4L0NvVnBzOHNDTktWc2lyUTRZ?=
 =?utf-8?B?T2FtUmw0VVErams2NzZySnYrSExkNkZIU3hDOTB3eEZFdHVFN3hCNXJaMGtO?=
 =?utf-8?B?ck9NdEJkeWliOFRFTFBJWnZWaHk0ZmZzNlk5SjdadkU1N3VQaEJGek8xaUpy?=
 =?utf-8?B?MWJXdTRkVDhCbWZwaUppZWw2Yy92NmJwSGp2NStITW0rdk9NNmM5RzVaZUcz?=
 =?utf-8?B?dk1ObXh6VTdjbG9WL016OWpOSkFzczd0bkIwMWt0ZXhaUkpNTStIVXNLU2Ir?=
 =?utf-8?B?czhFa0hKZ2hLSUlvWlZlVXozVFRtenRqZmhUMG44Zy9QbXBZVVNhbEYxWDF5?=
 =?utf-8?B?cEU1OERzZW0zaW9iSWJWUnUzR29pSGxZRll1V0xVMXJOL0RlaS9DUFJzMjZX?=
 =?utf-8?B?NWlIT0t3UlZKMXdLbW5jd1FWb1gvTHdkTjNpVnNBUURuRTdwUmY2ZEtDdXh5?=
 =?utf-8?B?MGVHVFl1dzQrbWNUU0hUVUd6aTc5Z2RwWGFXU2xEczBJdWJ5bVlTeGdhRE44?=
 =?utf-8?B?QUcvYTdWRkUvdndXcFpIN3lYOW8vVlppekxyamRCOXNPZDdPcXZRNUJaak9U?=
 =?utf-8?B?N2JsaUJGdWJ5L3ZIb0llTU5wN1VkN2Q1MDdxdnFFN21ZZytyM0txcCs2MFVv?=
 =?utf-8?B?Sm85aUlVeUlRNzY5Y1FBVUtNN1dhUVZoUzJ0dFBacERiYVBpS2pXRUFTYTZL?=
 =?utf-8?B?N2hsRjUrd1JFQ2Z6WWgwdGwyQ0FxQUxkUWFDVVdHSXhlNlI5ZUVQNGd4OHhY?=
 =?utf-8?B?cGhVWnpud1VXY29ST2hmZnE5MFhYQ0h3WnJtVzlPM0c5UnlFeTYvRE80SUNv?=
 =?utf-8?B?ck5xOHd5MWhGbDlieHFYQUJzYlMxR2s1NEhyNGhvY0JHOUJJRU15MHp4ck1s?=
 =?utf-8?B?ZkRnWTBrYzExTGorcUgyeVFyb0dSQWlzN3kwU3VBMXFPR01hMys1U0VLcDZl?=
 =?utf-8?B?SjVsVStyZnRmUWxsWTRNaWwwbnkwRFFWQWFuaWVPOGozSWdkZnpPQTNpVmF0?=
 =?utf-8?B?TlNQYXJXTE41Z3M2UmdGZGNKaVh4cWZQckUzQTR4dUNORHk3QzhmeW5iQmVV?=
 =?utf-8?B?SVhVMXhoTXFTaXluSWhRTXFLZlI2OWlJdnAvbG5yaHo1b0FEemdBeXFFRGZm?=
 =?utf-8?B?KzlVY01PbDdhZWhLTUZvTnhOMjJQNzZWck5Uc2FYUlg0eXhxYkRBMlBSSjNV?=
 =?utf-8?B?cFFvSHRkb3hBZ3JYRFJCZzIyVEsxSnBzT3hycG1OeUhEQTZpWmRKcGZiUmhs?=
 =?utf-8?B?R2F5SzZLbzJYNUpLV2VQcUt1WGdvd1FaVjRhZFB5bU9IVk1NR3d1dGpHS1Z3?=
 =?utf-8?B?K1ZOd25QQzlFYnk4Zkg3aTBJckhic0Z0dUFrZjE1aC9mWWRxcVBBOWtJMlQy?=
 =?utf-8?B?YWtqWkNZa2txZ25vTHhaZTJJTXduVDhpT09vVFQ4d0lNSHRVVkFLY0x4dG1j?=
 =?utf-8?B?U1dnWG1QMEJMVVJBMUtHVFVkQ2pvOGoyTDNoamV0NnVxa0RXWmVnUHdzYjFp?=
 =?utf-8?B?MlBNalE0RFoyY1BsSjVzTU1Lc20xSGZMaTFUSFJkUy9tTW5EMk9wUENNdmJO?=
 =?utf-8?B?WG5qMWR4c2FUbjQvUkdsYUYxU3RWeWNZdWRxU2tpYzJwREF1YnIwS3pSU2dN?=
 =?utf-8?B?bDN6VWxtdHhmZ2dyMmZaVGRPNlh0NUFLcDF1RUQxY2JSY0FiaWZkcDFoRlQz?=
 =?utf-8?B?bG1vd1JCMDNYTFhCZmVXdERhR2JRTVcwTUt6dXdsQndKUUtWREZIWXgzelpE?=
 =?utf-8?B?Y1hJYVdtaGVxWDhtK2VRWVE3Q21LT0x4ZFpwOFpqRWFFSHo5K29ndnlNd0pq?=
 =?utf-8?B?Ukt4ckttWnRISktEYzg3Rm9VREpRZisySDJxZE01MFRrMEZTT1pEVDlMRWFY?=
 =?utf-8?B?TXVhYURMbjNLVTVDbnRMMWVnaHQvZFdyV1RWRFlIZDJsSWlsZ1VlWHViejZV?=
 =?utf-8?Q?VaFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS84UWVxNGhRWmRMRkVlRFBoejUvQTE3NmY1WDEzcVhIM0lodHExOVVFaWJl?=
 =?utf-8?B?bTkzaFlDOEtHbW1uOUR0MlZFbEZaRUU0WG56WUFYVDNpZWlacHgwKzRxMUhQ?=
 =?utf-8?B?QjRZWU45MGNhZGQwZ29uYUxCSkhIQmh2RlVsZm1jUzhtb1JtL2tSYUZOcmov?=
 =?utf-8?B?aFNWeWlyYXNXMG84cnJJTkswMGlGSG9raE9IRm9PTXMzU09FdkZYdlpQSCtK?=
 =?utf-8?B?RDRTZFZrc1dKK3pGbnM4WFRQM2pJUittS1U3YnFqNUZ6K2JRUHJUOXY3S1BC?=
 =?utf-8?B?dnJJT1NsWUI3cGdlUnJwdG90bERmRkNZR0E5RmI2Q2RBLzQ2OWpWTlZNaXM3?=
 =?utf-8?B?VEtiRDFodUxXVks2bEtIZ0ZFYjFRU2ZQSDNSRlNvdEt3RjEzdmNGR2tpUmx2?=
 =?utf-8?B?R2lGeVQyUkR2T3htVENkRGszYmtsNDlSVms0RTJYNHFUSU81RzFTcndFYjZz?=
 =?utf-8?B?WGNrZnFyMW4zT3FaaVNIbXBuMTQwdzd0TTRrNUk5MHlhQWxibTdyaWczcUp6?=
 =?utf-8?B?MmxKbTlySTM1c21YUWd6MEdXYUMvME1LZ01zZ2NmZWNBaUlIa3NreGFwVXJF?=
 =?utf-8?B?UjhRWmlaME5JZ1BMU0VDQXROYWlTeDk1V1UxUTZJbEc2bGh4LzhQM0lMbnpP?=
 =?utf-8?B?bmlUYm5yWU5zVmhPTFl6VDQ2a2FTU2p3aVFiOGFTUmZOM0pvWnJVN0d1Smdj?=
 =?utf-8?B?alNsZlBTRGRYM2tNVElsd1paVkovU3BYOTAyZ3RPcERSUnRnNVVZcmRYdUw2?=
 =?utf-8?B?RFBmaTdFMXJGeU1XbGtXUjR5MGpReDZvL3VCcFo2KzBncFJod29xNG0xS0FP?=
 =?utf-8?B?em0rRmtVZUxrWGxJeW44anlISnNOTElsQ2NPLyt6eVoxM1FIQTh1VVFXK2wr?=
 =?utf-8?B?d0VwRjRHLzVkYVU1RjliU3MzclhXbWVtWXBTK3lVM0RocHdmVXo4R0pVY0k0?=
 =?utf-8?B?NG9hbTNPRkY0YkVDaG16WGZRSWc0RGp5OXd0TEtUcnNGY25zK1hpakMwNXFE?=
 =?utf-8?B?RUVEYVFBTXRIRjJIYy9Wd3R6eFdBZWwwK1k0dTAwWnFGaEEyZ1RKc2wvcTFa?=
 =?utf-8?B?NUwxNzhvNmdQN1AwRTladlFtMXZ3eVQ2eVdmekRMaWtQbnNKUXlpNnBCWTNQ?=
 =?utf-8?B?NFZ1cE5KdlQ4bUdSdGJsNEE3YkJRUFFBU1M1S1VhV1p5NEdjR2t1TEVPUGJr?=
 =?utf-8?B?TXNkbmRTQVNpU0FwaTdueHdyK1NTeURLTVluOGtrV0xCZUNoMlhqbEg1OGRu?=
 =?utf-8?B?NWlDMUhabzNNdjRjeVNwVGE0NUVqSUY4VWs1YUcxMGY1c2ZqVDZSeEhocjQ0?=
 =?utf-8?B?OE1rc2tubWNaV0IrRTk5NjZxT0J0ejJBdXVjbmJ1TUJEa3FCdmdxd05FZDhr?=
 =?utf-8?B?TUMwcFBxeE15aWwvS2piM3d2MEhlWkV6ME0zYjgrdnlSdlV0a2V4allYQzZp?=
 =?utf-8?B?V0hMeTc1SWJMa1k0YnJpVldmRkZqTXplWG9sQVVmKzdHQVZJVGFyZHdOb2hn?=
 =?utf-8?B?QnV6c2dqOE1IOXB5Q1ZFSXBoUXYyY09odVIwV1gzOWZOeC9hTFNQRDB4aVYy?=
 =?utf-8?B?WjR3R3BWcis0OHE4M1BMdkgxcFRCSDA0RkMvUWV1Wjg0T1I0dzZJN0Njb0F0?=
 =?utf-8?B?ZEJZd0pUcnhacTJJUkt2Zmpad2EwYVJENHNVcUlOZlFTQTZXVFRQcVpYaCta?=
 =?utf-8?B?L2kyejR5MW9wTnA2RHFxa2lDVVVSZWFSRXdOMmg5dEJic0lTS00rVHpLQmw3?=
 =?utf-8?B?UXl1SjhMb3pETmM5aWk4elp6cURvcDMvZWk4ejhzdWgzVkc4a0R5dlJxbkQ0?=
 =?utf-8?B?WUdBdFkrMGhKczh5SDI3YlNFV04zUllJT0l4N1VJak9CZnRud1FtME1tT3NY?=
 =?utf-8?B?N0hCNGxsdC9ldkxySGtLdUtyT3V1M0RLbGZGUGZuRzA2SExtSGJSdDlEZjha?=
 =?utf-8?B?Ullld2hSU2JMR0xGdHBJYWJ5Y01zRTFUVE5yZ3FhU0tjSGJrZnU1RHYrL0lD?=
 =?utf-8?B?ekpsYVR0UGNRRjVFbWtkQlRqUUZrVEh1dGxJTEZQWmlEdGdUclBQVDRBWWZu?=
 =?utf-8?B?UlA1UUppakVGYUx5MWxqcVdaWXQwWGVZYVBsdW9tVXNiQ05jVEFZdU54dG50?=
 =?utf-8?B?S2Zva2ZoZTlLN1JQT1YvaXVVNmF4WUJKZk1wTDdpT0JaenhGL0lUNldvUVlB?=
 =?utf-8?B?cUE5YWJOTklocGxrS3gvbHpaWnV3SzdyTW5aZm1KUVZFY0QvNUNQeXByVDl2?=
 =?utf-8?B?Z2xwVVFxY0dYYjZ3TlM4aDRrd2E5dDRGNzRqeWtFT1k2SXJlalRWR0hKSm0z?=
 =?utf-8?B?dXZ1ek9aZEJnZWVFK2ZYcnFPUGM1VjJBKzU2dHZDM3BqQ2NWa0dvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b59ac-2f57-4925-c57e-08de5ce6e613
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:26:30.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yhMT16ukm2Iuv18ct+i/8KgLze2nfFeGg7Ltxn/+G3oDdkZDsdlJOXR5jCzMfUFHCyWJPfbjj3l0CzhdGqeqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75470-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC66689723
X-Rspamd-Action: no action


On 1/26/26 12:20, Alejandro Lucero Palau wrote:
> Hi Smita,
>
>
> On 1/25/26 03:17, Koralahalli Channabasappa, Smita wrote:
>> Hi Alejandro,
>>
>> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
>>>
>>> On 1/22/26 04:55, Smita Koralahalli wrote:
>>>> The current probe time ownership check for Soft Reserved memory based
>>>> solely on CXL window intersection is insufficient. dax_hmem probing 
>>>> is not
>>>> always guaranteed to run after CXL enumeration and region assembly, 
>>>> which
>>>> can lead to incorrect ownership decisions before the CXL stack has
>>>> finished publishing windows and assembling committed regions.
>>>>
>>>> Introduce deferred ownership handling for Soft Reserved ranges that
>>>> intersect CXL windows at probe time by scheduling deferred work from
>>>> dax_hmem and waiting for the CXL stack to complete enumeration and 
>>>> region
>>>> assembly before deciding ownership.
>>>>
>>>> Evaluate ownership of Soft Reserved ranges based on CXL region
>>>> containment.
>>>>
>>>>     - If all Soft Reserved ranges are fully contained within 
>>>> committed CXL
>>>>       regions, DROP handling Soft Reserved ranges from dax_hmem and 
>>>> allow
>>>>       dax_cxl to bind.
>>>>
>>>>     - If any Soft Reserved range is not fully claimed by committed CXL
>>>>       region, tear down all CXL regions and REGISTER the Soft Reserved
>>>>       ranges with dax_hmem instead.
>>>
>>>
>>> I was not sure if I was understanding this properly, but after 
>>> looking at the code I think I do ... but then I do not understand 
>>> the reason behind. If I'm right, there could be two devices and 
>>> therefore different soft reserved ranges, with one getting an 
>>> automatic cxl region for all the range and the other without that, 
>>> and the outcome would be the first one getting its region removed 
>>> and added to hmem. Maybe I'm missing something obvious but, why? If 
>>> there is a good reason, I think it should be documented in the 
>>> commit and somewhere else.
>>
>> Yeah, if I understood Dan correctly, that's exactly the intended 
>> behavior.
>
>
> OK
>
>
>>
>> I'm trying to restate the "why" behind this based on Dan's earlier 
>> guidance. Please correct me if I'm misrepresenting it Dan.
>>
>> The policy is meant to be coarse: If all SR ranges that intersect CXL 
>> windows are fully contained by committed CXL regions, then we have 
>> high confidence that the platform descriptions line up and CXL owns 
>> the memory.
>>
>> If any SR range that intersects a CXL window is not fully covered by 
>> committed regions then we treat that as unexpected platform 
>> shenanigans. In that situation the intent is to give up on CXL 
>> entirely for those SR ranges because partial ownership becomes 
>> ambiguous.
>>
>> This is why the fallback is global and not per range. The goal is to
>> leave no room for mixed some SR to CXL, some SR to HMEM 
>> configurations. Any mismatch should push the platform issue back to 
>> the vendor to fix the description (ideally preserving the simplifying 
>> assumption of a 1:1 correlation between CXL Regions and SR).
>
>
> I guess it is a good policy but my concern is with Type2, and at the 
> time this check is done the Type2 driver could have not been probed 
> (dynamic module), so a soft reserved range could not have a cxl region 
> and that not being an error. I do not think this is a problem for your 
> patch but something I should add to mine. I'm not sure how to do so 
> yet because I will need to do it using some information from the PCI 
> device struct while all this patchset relies on "anonymous" soft 
> reserved range.
>
>
>>
>> Thanks for pointing this out. I will update the why in the next 
>> revision.
>>
>>>
>>>
>>> I have also problems understanding the concurrency when handling the 
>>> global dax_cxl_mode variable. It is modified inside 
>>> process_defer_work() which I think can have different instances for 
>>> different devices executed concurrently in different cores/workers 
>>> (the system_wq used is not ordered). If I'm right race conditions 
>>> are likely.
>>
>> Yeah, this is something I spent sometime thinking on. My rationale 
>> behind not having it and where I'm still unsure:
>>
>> My assumption was that after wait_for_device_probe(), CXL topology 
>> discovery and region commit are complete and stable. And each 
>> deferred worker should observe the same CXL state and therefore 
>> compute the same final policy (either DROP or REGISTER).
>>
>
> I think so as well.
>
>
>> Also, I was assuming that even if multiple process_defer_work() 
>> instances run, the operations they perform are effectively safe to 
>> repeat.. though I'm not sure on this.
>>
>
> No if they run in parallel, what I think it could be the case. If 
> there is just one soft reserved range, that is fine, but concurrent 
> ones executing the code in process_defer_work() can trigger race 
> conditions when updating the global variable. Although the code inside 
> this function does the right thing, the walk when calling to 
> hmem_register_device() will not.
>
> I would say a global spinlock should be enough.
>

I went to have lunch and my feeling was something was wrong about my email.


I still think there is a concurrency problem and the spinlock will avoid 
it, but not enough for the functionality desired. First of all, I think 
the code should check if dax_cxl_mode has been set to DROP already, 
because it does not matter anymore if its soft reserved range is fully  
contained in cxl regions. Does it?


But then, even with that change, there is another problem, or at least I 
can see one, so tell me if I am wrong. THe problem is not (only) 
concurrency but order of handling the particular device soft reserved 
range. For example, with a timeline like this:


1) device1 resources checked out and all in cxl regions.

2) device1 discards creation of an hmem platform device.

3) device2 resources checked out and not all contained in cxl regions.

4) all cxl regions removed

5) device2 creates its hmem platform device

...

device1 does not have a dax/cxl region nor an hmem device.


If I am right this requires another approach where just one work will 
handle all the devices ranges, and if all fine, the hmem devices will be 
created or not.


Thank you,

Alejandro




>
> Thank you,
>
> Alejandro
>
>
>> cxl_region_teardown_all(): this ultimately triggers the 
>> devm_release_action(... unregister_region ...) path. My expectation 
>> was that these devm actions are single shot per device lifecycle, so 
>> repeated teardown attempts should become noops. And 
>> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(), 
>> which takes "cxl_rwsem.region". That should serialize decoder detach 
>> and region teardown.
>>
>> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during 
>> boot are fine as the rescan path will simply rediscover already 
>> present devices..
>>
>> walk_hmem_resources(.., hmem_register_device): in the DROP case,I 
>> thought running the walk multiple times is safe because devm managed 
>> platform devices and memregion allocations should prevent duplicate 
>> lifetime issues.
>>
>> So, even if multiple process_defer_work() instances execute 
>> concurrently, the CXL operations involved in containment evaluation 
>> (cxl_region_contains_soft_reserve()) and teardown are already guarded.
>>
>> But I'm still trying to understand if 
>> bus_rescan_devices(&cxl_bus_type) is not safe when invoked concurrently?
>>
>> Or is the primary issue that dax_cxl_mode is a global updated from 
>> one context and read from others, and should be synchronized even if 
>> the computed final value will always be the same?
>>
>> Happy to correct if my understanding is incorrect.
>>
>> Thanks
>> Smita
>>
>>>
>>>
>>>>
>>>> While ownership resolution is pending, gate dax_cxl probing to avoid
>>>> binding prematurely.
>>>>
>>>> This enforces a strict ownership. Either CXL fully claims the Soft
>>>> Reserved ranges or it relinquishes it entirely.
>>>>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Smita Koralahalli 
>>>> <Smita.KoralahalliChannabasappa@amd.com>
>>>> ---
>>>>   drivers/cxl/core/region.c | 25 ++++++++++++
>>>>   drivers/cxl/cxl.h         |  2 +
>>>>   drivers/dax/cxl.c         |  9 +++++
>>>>   drivers/dax/hmem/hmem.c   | 81 
>>>> ++++++++++++++++++++++++++++++++++++++-
>>>>   4 files changed, 115 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 9827a6dd3187..6c22a2d4abbb 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -3875,6 +3875,31 @@ static int 
>>>> cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>>>                cxl_region_debugfs_poison_clear, "%llx\n");
>>>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>>>> +{
>>>> +    struct cxl_root_decoder *cxlrd;
>>>> +    struct cxl_region *cxlr;
>>>> +    struct cxl_port *port;
>>>> +
>>>> +    if (!is_cxl_region(dev))
>>>> +        return 0;
>>>> +
>>>> +    cxlr = to_cxl_region(dev);
>>>> +
>>>> +    cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>>> +    port = cxlrd_to_port(cxlrd);
>>>> +
>>>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void cxl_region_teardown_all(void)
>>>> +{
>>>> +    bus_for_each_dev(&cxl_bus_type, NULL, NULL, 
>>>> cxl_region_teardown_cb);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
>>>> +
>>>>   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>>>>   {
>>>>       struct resource *res = data;
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index b0ff6b65ea0b..1864d35d5f69 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct 
>>>> cxl_endpoint_decoder *cxled);
>>>>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>>>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 
>>>> spa);
>>>>   bool cxl_region_contains_soft_reserve(const struct resource *res);
>>>> +void cxl_region_teardown_all(void);
>>>>   #else
>>>>   static inline bool is_cxl_pmem_region(struct device *dev)
>>>>   {
>>>> @@ -933,6 +934,7 @@ static inline bool 
>>>> cxl_region_contains_soft_reserve(const struct resource *res)
>>>>   {
>>>>       return false;
>>>>   }
>>>> +static inline void cxl_region_teardown_all(void) { }
>>>>   #endif
>>>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>>>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>>>> index 13cd94d32ff7..b7e90d6dd888 100644
>>>> --- a/drivers/dax/cxl.c
>>>> +++ b/drivers/dax/cxl.c
>>>> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>>>       struct dax_region *dax_region;
>>>>       struct dev_dax_data data;
>>>> +    switch (dax_cxl_mode) {
>>>> +    case DAX_CXL_MODE_DEFER:
>>>> +        return -EPROBE_DEFER;
>>>> +    case DAX_CXL_MODE_REGISTER:
>>>> +        return -ENODEV;
>>>> +    case DAX_CXL_MODE_DROP:
>>>> +        break;
>>>> +    }
>>>> +
>>>>       if (nid == NUMA_NO_NODE)
>>>>           nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>>>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>>>> index 1e3424358490..bcb57d8678d7 100644
>>>> --- a/drivers/dax/hmem/hmem.c
>>>> +++ b/drivers/dax/hmem/hmem.c
>>>> @@ -3,6 +3,7 @@
>>>>   #include <linux/memregion.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/dax.h>
>>>> +#include "../../cxl/cxl.h"
>>>>   #include "../bus.h"
>>>>   static bool region_idle;
>>>> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>>>>       platform_device_unregister(pdev);
>>>>   }
>>>> +struct dax_defer_work {
>>>> +    struct platform_device *pdev;
>>>> +    struct work_struct work;
>>>> +};
>>>> +
>>>>   static int hmem_register_device(struct device *host, int target_nid,
>>>>                   const struct resource *res)
>>>>   {
>>>> +    struct dax_defer_work *work = dev_get_drvdata(host);
>>>>       struct platform_device *pdev;
>>>>       struct memregion_info info;
>>>>       long id;
>>>> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device 
>>>> *host, int target_nid,
>>>>       if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>>>>           region_intersects(res->start, resource_size(res), 
>>>> IORESOURCE_MEM,
>>>>                     IORES_DESC_CXL) != REGION_DISJOINT) {
>>>> -        dev_dbg(host, "deferring range to CXL: %pr\n", res);
>>>> -        return 0;
>>>> +        switch (dax_cxl_mode) {
>>>> +        case DAX_CXL_MODE_DEFER:
>>>> +            dev_dbg(host, "deferring range to CXL: %pr\n", res);
>>>> +            schedule_work(&work->work);
>>>> +            return 0;
>>>> +        case DAX_CXL_MODE_REGISTER:
>>>> +            dev_dbg(host, "registering CXL range: %pr\n", res);
>>>> +            break;
>>>> +        case DAX_CXL_MODE_DROP:
>>>> +            dev_dbg(host, "dropping CXL range: %pr\n", res);
>>>> +            return 0;
>>>> +        }
>>>>       }
>>>>       rc = region_intersects_soft_reserve(res->start, 
>>>> resource_size(res));
>>>> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device 
>>>> *host, int target_nid,
>>>>       return rc;
>>>>   }
>>>> +static int cxl_contains_soft_reserve(struct device *host, int 
>>>> target_nid,
>>>> +                     const struct resource *res)
>>>> +{
>>>> +    if (region_intersects(res->start, resource_size(res), 
>>>> IORESOURCE_MEM,
>>>> +                  IORES_DESC_CXL) != REGION_DISJOINT) {
>>>> +        if (!cxl_region_contains_soft_reserve(res))
>>>> +            return 1;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void process_defer_work(struct work_struct *_work)
>>>> +{
>>>> +    struct dax_defer_work *work = container_of(_work, 
>>>> typeof(*work), work);
>>>> +    struct platform_device *pdev = work->pdev;
>>>> +    int rc;
>>>> +
>>>> +    /* relies on cxl_acpi and cxl_pci having had a chance to load */
>>>> +    wait_for_device_probe();
>>>> +
>>>> +    rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
>>>> +
>>>> +    if (!rc) {
>>>> +        dax_cxl_mode = DAX_CXL_MODE_DROP;
>>>> +        rc = bus_rescan_devices(&cxl_bus_type);
>>>> +        if (rc)
>>>> +            dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
>>>> +    } else {
>>>> +        dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>>>> +        cxl_region_teardown_all();
>>>> +    }
>>>> +
>>>> +    walk_hmem_resources(&pdev->dev, hmem_register_device);
>>>> +}
>>>> +
>>>> +static void kill_defer_work(void *_work)
>>>> +{
>>>> +    struct dax_defer_work *work = container_of(_work, 
>>>> typeof(*work), work);
>>>> +
>>>> +    cancel_work_sync(&work->work);
>>>> +    kfree(work);
>>>> +}
>>>> +
>>>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>>>   {
>>>> +    struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
>>>> +    int rc;
>>>> +
>>>> +    if (!work)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    work->pdev = pdev;
>>>> +    INIT_WORK(&work->work, process_defer_work);
>>>> +
>>>> +    rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
>>>> +    if (rc)
>>>> +        return rc;
>>>> +
>>>> +    platform_set_drvdata(pdev, work);
>>>> +
>>>>       return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>>>   }
>>>> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>>>>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' 
>>>> memory");
>>>>   MODULE_LICENSE("GPL v2");
>>>>   MODULE_AUTHOR("Intel Corporation");
>>>> +MODULE_IMPORT_NS("CXL");
>>
>

