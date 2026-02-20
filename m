Return-Path: <linux-fsdevel+bounces-77822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KYJNbXFmGnyLwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:36:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C058A16AAD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96B2A301DB9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE8D2FE584;
	Fri, 20 Feb 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sSzWbuxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B52302CD5;
	Fri, 20 Feb 2026 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619759; cv=fail; b=m1eQU0EF6AMMno6ZPzF+qySQ3dHPP2EkyApILxAK+9K4Q8acHfiKCfhopWX/49nMW5EV+tScCxgjeopoB4SiV4H/vMy5jGinyySe2Cv4Ik8BCNDgEFvjxQjyVuNuo0kH6B5hs82WPAwexncvx0G796AM8pBZJoA1WxUfnmNuPiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619759; c=relaxed/simple;
	bh=gGu8yobnmahZ/kvroWuHPIA8jKjwYmApOkYX34eAD2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwHPvH8cqgLk1Zvrm1OsxgEDgHpP/xOTtda9pW7AWAuzvZgEiHtKJ5TfdAakxPK6FeEVjjubLvHP+INTDS80Dh1aM9Ym78o8Ak6ToQrPUuhFRupSChmjckQjXZNQRAT+IhMVGlycJrEsipg7wKchJb1F4JJQTnEh9sPziHBbmVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sSzWbuxm; arc=fail smtp.client-ip=52.101.56.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT5LmOj+TEl2ggB8PI2a9VgFrGIQ5NFPMpuyBSl4+LywxGS7XeMbljLWsoXXeMz5o3oSzwRu/ZplAtdHUI/cTYuLUBEhJZGOpFkZ8Ov2Ryu9kpKEEiZTjTZTfJ+WHkEJS1Dfa6c3JEp+YpQz93GlQxCMVKTYjTVFpKvRrJdjZEyFgAyeHsVVVrtKQUkzemuC0KyME0LgYhQw88554B4OifhS6VEOW71cv+5ArngTfJprPtfbrTXb+WYd2YsSbZ078DH+rog0UCWx+7jJM4xzkzrzKgtsaeYQOP5AofdyR84NhyKc9GkC0+7DCuOw8OfSuUATO/BxZd2S0KRyvIfR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqTxJETkMcn67sKuuF29Q3akie+wpFXKEKGdqWrBHcM=;
 b=a5RYZcyXTKfCNpBil4VJHVEVj6Wpf5KdWmOF7s8a2YH/GJjR/i3kRetIpJ2DW0dlJEPGhXaYbsra6hK7WbrTYM8dqCaczjk9BQrt67cL0JCRg+Pk5/SVAJWlm02S9+zzHR3qKBF1cnvtVctm4y8YObo8CgCZZo11q6YvtaSjKVpnB7DhE26lLnnWXvd5eAcTSePJWew3dMAVFq4XWTJ2IA7ecmxpXf7MJF649C8dHz3lfT4Hi2d8jwuiOdfh5tglLkV+m9FTO0xvu7tfSfidjaEqfx2fZho9oei/S2fUkYmye42dDA1RSCTGhysoR19505GPfSeI7bJqXpsCVaI2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqTxJETkMcn67sKuuF29Q3akie+wpFXKEKGdqWrBHcM=;
 b=sSzWbuxm1w2AYZQfeSHGR7A/NKV5LzL9YiLr5StbagmDKt9MLg0m7f4g8996nVb1TkL0if3Sq8+k26dsng+F8mJcIfbVoqS/5UcBtsyx1H8pL78iqAcI4LoXSw3UoBmHyWJqO2GvrexfMuhDam7p0INyRPfC/VRvyyeamtGeOgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:35:51 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 20:35:49 +0000
Message-ID: <909004d4-f1d5-4fe7-a71f-11d9c6885cac@amd.com>
Date: Fri, 20 Feb 2026 12:35:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
To: Alison Schofield <alison.schofield@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
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
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-4-Smita.KoralahalliChannabasappa@amd.com>
 <aZaHJPdKMy56dLcW@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aZaHJPdKMy56dLcW@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: ecad083e-c25a-4d61-3ced-08de70bfa1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVIZUhtMER5Tm5TcEdjd2crd2wrZ3dSYk52Rld0VU5lVWpuK0ZIRm9TSnVC?=
 =?utf-8?B?WlVVOURNR0VkLzUyVHczeWttS0hoRlhHWnU4MkpISWRiSXI5d05xR1dsY0dR?=
 =?utf-8?B?N1RoSTlsU0JwNW1qcGNQMHlMWGJEcVRUUm9PcVJYOVIyaEw5U1IxYjgyRkRw?=
 =?utf-8?B?VFk3cWRwNmhIOXVBZW12NFRNWE13OFA2YjFYbEd0Y1dnaXZlZWNzMW9CdEdJ?=
 =?utf-8?B?RUVMU0JaN1IvTGt5ZlhQYjkwVGwxUTZROWlSWjU3N0VyWndUWHBYSXNjWE8x?=
 =?utf-8?B?OFRqYmVXazFTUDliRHo3amtDMEI3eWRUa1JTQnNVM2VaTnl3dVBubDE4dlpk?=
 =?utf-8?B?Rk1BcDh1d2x2N1FnRGlXM00vVm5PS3k2NVpRY1ljbVBndGtpRUFlWFpMdEpE?=
 =?utf-8?B?KythRWNuSEQ4Ui96ZDB4SElvcWpnMFkxL3Qza3hDeW1jNDhjd3I3cmY2STNi?=
 =?utf-8?B?WVJHVG1tUmwwSkZUa0RFVWFzaktSVyt4R0FabG53RVFPRDdnekVZWlpaZzJy?=
 =?utf-8?B?TUhKSUFPSzNpb3V5b21KQjlZczB0VFhVeU8xREJXc016UmFCUnAxSW5vQS9v?=
 =?utf-8?B?TkxSQTlwTm5EelZQNmVtQnhVR25LclZ2TjE1ODZkbFJqN1c1bWFNR3paQTBG?=
 =?utf-8?B?Nm43UGlib3FXZWFnNmhpZEt3ZU5BYnNnTG8zTDloTFV5Um1oWjArbkhoYXNL?=
 =?utf-8?B?K2R0SnFJaU9aVkcxcHhielNHVHRXM0dvSXN1VnpkTnc3NkdLZGZpZVV5S3U1?=
 =?utf-8?B?MlB5R0JXbkR0OCs2MnY5TjE1dkZudjk5YUxmT2x1alhmWjkwVmtCNHczRndK?=
 =?utf-8?B?WFlVWXJKMHJGRXloajJpblNNcTVCeTNoU2l4MHpZL2tQaFZOa0ZoN04xbTls?=
 =?utf-8?B?Qm5lVjdMUDJCNkR1ZHJ2RHZnQmhub2hYL2lqU0M1Q1gxU2J4R1JtRkdGYlpJ?=
 =?utf-8?B?WXlLcE85MVdRL0pNRUhPc2xjRVpaMkF2ckRUSnZYWk9lMFNEV2RXMWdQWkxs?=
 =?utf-8?B?VUxYVUQ3ZjlialNJOUdsbDhkRjVmNlQ4eVV1MG1JOXhlaFpRNWZQUURxSTQ0?=
 =?utf-8?B?SzdZRVZoanBsRnowVm56bkVtMXJQelN2VEV2R0hnWlJrNThFbEt3OXRucmdC?=
 =?utf-8?B?NDJPcCtBejJpWklicVNZMnhrbjlWdGJ1TDNaVFFzWTNrYmlBZnpKWEl0RjJB?=
 =?utf-8?B?bjBRUnI5MmFqNHFNS3pGbUo2NVFvUHl0N1V3NnJXbTc5bmd2WXRpaVBQaW1q?=
 =?utf-8?B?YThHK0ptLzFkRGQvWllNUTlFODd1MzhQUEJEaDladGprR25BVCt3cytJdDNv?=
 =?utf-8?B?QU5kRUJ1NHFJY0JmZkR4ZnNIcWtNL3JpbHNsYWpYYzlycVpKU1lFdUxiTzZq?=
 =?utf-8?B?ZDlRdFBKbStLQ2hxalZCcENCS1UxekxTOCtsV0VraHp5QWlUQ0ljNXFuWUJZ?=
 =?utf-8?B?MXRGY05BWGlJNTVpbnMrNG0wR3FwYWVhMU5jdzc2TUJPa0pOclcrQjJ5Nito?=
 =?utf-8?B?a2VLK3krb2pCc0lKT2p5OElCOWRuaVJhdHFnRVpRZkRkamRuTDRFSTRNTzM4?=
 =?utf-8?B?cWFuMU9LTnZsZVBnQitZSDJUTzdJWEV2bkppTktCVnFDMC81UlZrVHRBRUlO?=
 =?utf-8?B?MCs5NVl2cnlEOFd0bG5xYnFWMWJXVVJablFFS3lkZDhvZTRKeEF5K3cxQXNz?=
 =?utf-8?B?NnVRd3pxMlFlWUt6Q3hqUEZWMzdlZHk5VmYxakZaVHFDNjIwTXlJcjRsZFpm?=
 =?utf-8?B?Vys0Z3lLZ2loQUxXcVc3cFVCcndqQTVDL0pQRlplRTkwMTE2M1hZZkpHT1M3?=
 =?utf-8?B?L3g3UFlheitETHBNdVp2bHpHMEZLVHRQa3BBTUdEY1o4T3RTOXVXOE1Ca0RM?=
 =?utf-8?B?L1FUZXl2a0JVRjR3WEdldG55eXVlb0pjUXJDcExYOUlocDRVb2k4eVpWbDNW?=
 =?utf-8?B?V0EzVU8ycWdWanhpUkdvUDYralc4UDZsaG9ZK3F2UDAvcWlIS0xyOVRUOEFS?=
 =?utf-8?B?MFM2eG5YSlFNRDRXc2NLRkNmZlBVWExNVTNjSUxZdTE5QXo4Wm1sYkVLYXoy?=
 =?utf-8?B?Z0J3TWlTUEt6YXhhY0phM3VSSUwyMlJ3Yk9SMkZNUDNzWUIrNzhpWFgxa01k?=
 =?utf-8?Q?8h5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU0vTFN4SUZhdUtPU2lEbzF0Nm5EQ0wyU2hMYk1jWjBMTWc0RWhWRFdyT1FF?=
 =?utf-8?B?aHQwcmh0ZC9ZZVkyd0M5cVZOY1RTanNiemZKQnYwU2tlV0hRUjZERXNJWS9X?=
 =?utf-8?B?Z3ZoUk1HWnRzZGJnWXl5bUtydjZ3VE1RZ3d6TEZKM29jMTdyWVI1RDJXSXkv?=
 =?utf-8?B?ZE9IMlFxaWFRTHV4Q0JmcXErTHZzRFJoU3BXVGlFNWVrNFlxSDBpMDEwV2lR?=
 =?utf-8?B?dUlubTlVdHNUSC92VE9rdWh1dWhWVjFMMVhkUysvZU9rQ2I2UklFaGRLazVl?=
 =?utf-8?B?YkRCZWpvbXlhTnVoTDFmTE93dS9ZdVBwbnhGNHNVRzlOTklKakcxNktiSzRl?=
 =?utf-8?B?M0JqQ1hJZXF0QVUzVE9VaWhYZW8xMUk3Q1RVL3IydnhybUdEN1V6SGQzTTMv?=
 =?utf-8?B?RGcxc3NFL05RRk5kZ1granZHaUdSVEVOcnhhUThHTmhuZXVic0FJRzVVc2JX?=
 =?utf-8?B?OGJ3Yk0vdk4ybkhsNm5XVFlNM2xIMklIWEJCNFdta3ZpQ1VJZXBRZzdvR0h4?=
 =?utf-8?B?cU54UzA4RGp0Nnk5VEI5ckZtdUV1eHM2eHAybzZxdzBBWEVnVFNSRlY4ak9l?=
 =?utf-8?B?aXlOQ0hOSXJUSy9TZjJnVXZLOURqRWcwaHcxK2ZxMS95Ym5iRSt1UmNqWVBo?=
 =?utf-8?B?VnlIaXpLbXplV0duV2xkL0FPeDZqekQ3VDM2Qy9tSkpPL1BFZHRTZVpZa2RU?=
 =?utf-8?B?V3pPMzJYQklsQnJ4UmdnbkQvTGZWSFM3MTIrcEhBZzN4M3BibUkySEFySHhW?=
 =?utf-8?B?TForRnpwNUZkaVlERVlud3Q5SFhTUGtnYTNIT2RieHczWDNxdjBNZ3JyQjFK?=
 =?utf-8?B?ZE9URjFicW1QZjNRMml5VWJaS1V1a2FGcUVIWjhiM0U3V3VxTVRQVGxLanh2?=
 =?utf-8?B?K0xjWlgrOTJzdFltRFM1VkhoYWlvSk8zUFF6Nk1kTkpYWWJGNGFyeERZcHZm?=
 =?utf-8?B?TWlYTVR3Nm5UdTJLWEp1dTlVVlNCdXdVdlhId0o3Um9zZi9IcXV2MUF3aXov?=
 =?utf-8?B?bXlQMWJRRWd2dlBMV3ZPMjZmTk5KSDZhR2JZUnNGV2pSbldxVkIzR1RuS1Fv?=
 =?utf-8?B?YTAxZmVqSzFFTnpVdXZLc2JPRFVlZjVPVjVjRkFDV2Z5RjhpMVEwdG9FY1FE?=
 =?utf-8?B?QTczaEVoYlk3dWQ0MG10V1crV0Fpa0FYUHpGR0xRaXk3YnFjYy81eHZDNFMx?=
 =?utf-8?B?cUsvdmJGWGxGWDdtOHZoQkIxYnVLSHlMYzl6TnRQdkRxUjRjZ25ZczM2dnlj?=
 =?utf-8?B?S0ZTN0hEQVV5SUhZUDMyc09XOEZidG1VV3crMHNzZitmRUtjOEcwa3YrY3Y1?=
 =?utf-8?B?bTJhSGhGSDhzTURBT09nYVV6RXgxWEtaK25YdXJKS1hHazJ4Mk5NZXNPeVM5?=
 =?utf-8?B?cnVEczJvc2loaXMrQmRzM0JEazkzMGFxb3o1ZmV3ZEh2Qm1XMWpVdzI4aFpn?=
 =?utf-8?B?cUJrTGw5dzZaSTl5aXA1aVI3bDNXa1QyUVBJcjBDUjFWK1NlOUZQMWZvZVNU?=
 =?utf-8?B?bkFOY2J4NDZ0OFYrME9FR2NHSUJSOXFIMFJvTmtkUGRHeWRQRlhxSHd0UU9T?=
 =?utf-8?B?Ymc3eGkvbVlkbjgvSUNHazl5dDlnNDF0bk5xbDUzQkJTWDNBM2xSUnNlNEl0?=
 =?utf-8?B?NGMwU3lPanRpNEx2a0NpR3o1VUlSeGJtcmc5elY1b0xsWnhYSENXNGxEa3Rw?=
 =?utf-8?B?QUp4L1NBbWdSMGtTWVVOQ1gwcmxNOElBbHhadU84ekxtOWpiNVJvWWI2UTlK?=
 =?utf-8?B?TXd1eitvejUyU2VJc3RBWDFUWTlER3VxemVIcXZKWVhETU02a3MwM01VbHZ5?=
 =?utf-8?B?OUdIZXRDR1VDWmdSUUlyUy8vckpzYk8vbi9DVU8wTnlJN2ZCMVIwUzEvejY2?=
 =?utf-8?B?cEtaWi9jME1HQThxNnUwbkUrUVUxL3lmbzFLc245Tk1Zd0lKN3RNMTlTdjNF?=
 =?utf-8?B?VXV1Z1crYk1nb2VBYmlreis4V0J3QU9kNlpQclNqeXppUitkZkV3UjFxMGdt?=
 =?utf-8?B?WFEzZGNrM2ZkRTg0L3p5WW5JVFdlVWdqeGtnTzhWQkVDTWR6TDRPTUFhTGlZ?=
 =?utf-8?B?VUlWaDcwS2hYcWxlN3ZkTFE3d29laFZteG9TQ29XdW84d0dUQWpuL3AvNzB0?=
 =?utf-8?B?cE9aRGo0QXVTQUs1aXRxV1F2enZnei9TajgzZDhCWVJ4WTJtTEtjbUR2NkhQ?=
 =?utf-8?B?MHd2cjY3L3oyWTF3R2NYNDVBTHo5MWtyVzgyUlgycThnMWVUdC84RFNKeStB?=
 =?utf-8?B?MG5QVEEzakFQUWF5cHB6MndTWjNjVGFzdWlkSjVFQWVibWxVSmZIalBETVJL?=
 =?utf-8?B?Q0pkRXNOVmRUemxrMndQSzhmekhFbGcwOENJOHJSMkx6MitONHpOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecad083e-c25a-4d61-3ced-08de70bfa1d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:35:49.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6ICRnAs25ZXI8HSv9pNcG5xkeJ29wfbnmbGFWnc5A6J5oYf2q8f9Oy/Y79nQeIngzNHW8SXGrfqO/ISkGFn/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77822-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: C058A16AAD9
X-Rspamd-Action: no action

Hi Alison,

On 2/18/2026 7:44 PM, Alison Schofield wrote:
> On Tue, Feb 10, 2026 at 06:44:55AM +0000, Smita Koralahalli wrote:
>> __cxl_decoder_detach() currently resets decoder programming whenever a
>> region is detached if cxl_config_state is beyond CXL_CONFIG_ACTIVE. For
> 
> Not sure 'detached' is the right word. Unregistered maybe?
> 
>> autodiscovered regions, this can incorrectly tear down decoder state
>> that may be relied upon by other consumers or by subsequent ownership
>> decisions.
>>
>> Skip cxl_region_decode_reset() during detach when CXL_REGION_F_AUTO is
>> set.
> 
> I get how this is needed in the failover to DAX case, yet I'm not clear
> how it fits in with folks that just want to destroy that auto region
> and resuse the pieces.
> 
> Your other recent patch cxl/hdm: Avoid DVSEC fallback after region teardown[1],
> showed me that the memdevs, when left with the endpoint decoders not reset,
> will keep trying to create another region when reprobed.
> 
> [1] https://lore.kernel.org/linux-cxl/aY6pTk63ivjkanlR@aschofie-mobl2.lan/
> 
> I think the patch does what it says it does. Perhaps expand on why that
> is always the right thing to do.
> 
> --Alison
> 
> 
>>

Thanks for the review. I will fix detached to unregistered in the commit 
message for v7.

I think there are two paths here: Correct me if I'm wrong.

F_AUTO guard only applies to __cxl_decoder_detach(), which is called 
from unregister_region() 
(unregister_region()->detach_target()->cxl_decoder_detach()..) path and 
via store_targetN() 
(store_targetN()->detach_target()->cxl_decoder_detach()..). In both 
cases, this patch is preserving decoder state for auto-discovered regions.

When a user explicitly destroys an auto-discovered region via cxl 
destroy-region, or decommits via commit_store, those paths call 
cxl_region_decode_reset() 
(commit_store()->cxl_region_decode_reset()->cxld->reset) 
unconditionally, they are not gated by F_AUTO. So users who want to 
destroy the auto region and reuse the pieces can still do so. The 
decoder state is fully reset in that path.

On the DVSEC fallback fix: The endpoint decoders were being reset (by 
cxl_region_decode_reset() unconditionally), which zeroed the registers. 
On reprobe, should_emulate_decoders() checked per decoder COMMITTED 
bits, found them cleared, and incorrectly fell back to DVSEC range 
emulation, treating the decoder as AUTO and creating a spurious region..

Also, since nothing in the dax_hmem path calls unregister_region today, 
this F_AUTO guard in __cxl_decoder_detach() is only for preserving 
firmware decoder state during auto region teardown. I need to rephrase 
that in commit message properly. I will also expand the commit message 
for v7 documenting how the explicit decommit path still remains available.

Thanks
Smita

>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index ae899f68551f..45ee598daf95 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2178,7 +2178,9 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>>   		cxled->part = -1;
>>   
>>   	if (p->state > CXL_CONFIG_ACTIVE) {
>> -		cxl_region_decode_reset(cxlr, p->interleave_ways);
>> +		if (!test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
>> +			cxl_region_decode_reset(cxlr, p->interleave_ways);
>> +
>>   		p->state = CXL_CONFIG_ACTIVE;
>>   	}
>>   
>> -- 
>> 2.17.1
>>


