Return-Path: <linux-fsdevel+bounces-77785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEScJDc0mGn/CgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:15:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B44166BA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41CFD300A264
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C733B6C3;
	Fri, 20 Feb 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NbTMDknf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690433A70F;
	Fri, 20 Feb 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582509; cv=fail; b=QSazY974Mh7NSa1rrvSntAdatHwXy9J8KAFtfh06QM5/OmHepqTTSAU23j1raPdwEQb3UZDpCKrAn8+2DXCLiiIl/auoC14WE8leK46dX33NT3k7HStRvZHSYduqrS6O5iKxHNVuKbl5irY/92+E4IoM6ekcHBN9/dcPlj0BZkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582509; c=relaxed/simple;
	bh=ZFOTzRADAs4gf/j5oH7acXpfDIHEx9WMsX/LWRn/KG0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W11B/U/V/xgt6PzJhIa+0Jgal2FO+p9eqgJRwvAHunIwN8i0pQXBntBPhxkhmkyCcuf0EwyiUoGYR004vfrx4le83SZP05Y6m6kMCu/OAP1GuEF8EgjCprM/HY6Y6ElxNRjIgivwYpHXg7pSI7s1OMF8m2aSUka5bKuAPi1tXXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NbTMDknf; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHO0HiVF03am5/1BEbR3ciUYPAMXA6jFg1QIrGU4dk6lWroJWcqZPZJH2sBpST1TwU6s7wsz+31o67h5aB5dHQOcYjZ9p+9ckFBVZQeJYyAv0WrMH3rXVnDlvXNPvoLnYvrcvScgmWn5AzanT4Xle4e+wP244VpmDu3weWiDQCi2hnoFAZcfqDcBQbp3Wf9GNIN48PDwAAxpltooO85LWFxG51o+U3ci03dWI7BFo2EECKuXjs6M8RCrCeeE2aAUSr+JtR4q8cS9n+0mwovlxf2wNmImqB+i8a0Lt3AzkuF3BKEHkdPWJMGQhCFm/0fA0JE2IAlp1fN4XYVbAXR1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCq4I+vHxwppDOsYcM8jBRYU8aBFvnLTrvBxMetID+Q=;
 b=R4V0VGIbLvbRd7UGxPEc5+cSvUkXWEc8zDHzHSZfZ95lCrBcYkLxnjzj3CjQmswL4Gk7R6L5kZ6uNxpzGcDbL39kKKNMiVptbESMj9EV+M6FDTZuH5D4y0cQ6qybTZKOXl/YwUwPic2R7lGrKIMIzouORtUXPNxL1EQ6+JO15wjBe+5aHNexuucp6OAdRn2nItb3v2DamMn5CpvEjRN1asnoxxUq7GiVduUUQBoDxgmZ5sKD1JN6tq8m7Q9c+Ypo+d36JMmcYVzNM8ZlXVRahBHk8dT8IwfLvx8bV3fRf8h6s0PE8cs9BSymHyBOUnyMxHuG+9BdAqePp4xgn8fHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCq4I+vHxwppDOsYcM8jBRYU8aBFvnLTrvBxMetID+Q=;
 b=NbTMDknfxsgeACMIJsSj2F7mhka9v17L21MXuxo9y6gLc6/UcuYtAI8ja21x6ybtOr/RATqhijpWTgva01I4CBzsEyI2QGNZaL133p3Ct+WtqMsWoSWE+rSo9wafcCHMLedBi3C9eHlbTLzBXCEEemdV2wx5dqUzNOzpA1d1FGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 10:14:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 10:14:57 +0000
Message-ID: <95649073-dd8c-4427-b6bf-0964f5f24710@amd.com>
Date: Fri, 20 Feb 2026 10:14:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Language: en-US
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
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
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d6ed76-6579-4006-a921-08de7068e63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1VYdSs3UTJQeG81OWN2QzFtTW1ZUmllR2N5b3NuQ1RJKy9KNFJoUk5vOTN3?=
 =?utf-8?B?UGt0ZEtQSWwzMGtDTGx6Vk1qS05sZkxyNmhFcXBTVGN4WkoxRVdjaFI4bTJD?=
 =?utf-8?B?RmpGZHBOSzd6OTU4cXVTcWhiR1M5OU5jYUVDZWQrNXRSc0FtQlJKRVB3RCti?=
 =?utf-8?B?UGV4Y2ZqNjNvT1Vyc0tjTDkzbFdZL1gzUE9zbE5KV0dqajMzOXFScW9SVnll?=
 =?utf-8?B?TDVpR1NiUmZjV0ZVRnFnNmhFT2FVZmVteG1JYnh2T28vbFR4bEJ5R09yYTZw?=
 =?utf-8?B?dXdlb2Zzc1Q0b1FCM213SjhrYVNJSjN2d0I1UjRVbmZTWXBPRXZ4Tk11bzlr?=
 =?utf-8?B?c1pEYTFPeVJLbUpCZUo3YWJiRExzeU4zSVRlL0YyMG5BYjk2a1U1ZURkREl0?=
 =?utf-8?B?Q1A3UEJiRStqMHNsUFIrUlJ0Um1Uai9hT2R0UEdqQStSV0VPTlZIYTBxVCtV?=
 =?utf-8?B?RjZwRDEwUHdKQlBFMW5sc0VicndmYjlXMXlaTnowVTluYmZDR1JZQ0RyWGdi?=
 =?utf-8?B?TUZCWThzOUVBZzBNNGpyQ1FMMElCRUs4UXlsZ292Sm5jYnN6Z3E3YUFiK01s?=
 =?utf-8?B?RzZMSlAwVVRkVSt4ZVZZaEtGNnJGemw5SW82dTRSUExLak9SYUlvZ01PSXRE?=
 =?utf-8?B?dWtiOFRrZDJIdHVyWHFENzhQWVVXbnRsVmkrNDRIY0lCaER4dGNhUXY4Wjhq?=
 =?utf-8?B?TTVvcHI3a1dlUEJPRnl4REJvRUVHOTM3R1crMXVIKzJaN0Z1Yzk0ZjdqUWlG?=
 =?utf-8?B?blJ1bWtSNGZ6NlJjaUVDbFU0bVU5dGlCNU1JT3dUYWN0RzdYc1ZLeVA5bmZV?=
 =?utf-8?B?RnZrMDNoS2FJeHF3bnBEKzVBTE1LaFB0aFdkMmtjZEF3R2xSQjJGSHhKZmVa?=
 =?utf-8?B?enc4dlU4cTRHcjJNSFhiY1lQWExEUkNlYkk0eVZ0aGQ3VFc1TU9HcTdBN1hE?=
 =?utf-8?B?MVZNUlcycmtQenZLM1NjOGpuRy9Cdi9DTFl4TGpmY3FTZDl6eWxWZVl4UE53?=
 =?utf-8?B?eGxRVC93cCtzVStjaDZBK1psaTJTaWZyYTdDWHg2SnhNdUV5dE95MnYwaERa?=
 =?utf-8?B?ektDRkJPQjFwOVd3bFhROWdadHp4U0prZXVzRFFmaDFpQzdhTjQyTng2cDRH?=
 =?utf-8?B?STZVOW8veGo0UXdYKzFBWmMzL05JbDNKU01ZTGp0ajBNaXQ1aDZ4TENzUzlM?=
 =?utf-8?B?TlR6dEZRaTlWWXp4LytwYnJ0TGp1QTR4cXllTHZjVjF2QW1HNVZ2eGt3VjJ0?=
 =?utf-8?B?RzB5MGdySWFTL3hiaDZhSy9hSjlKejIwY0VmVjM2WjFCWGpucmFNd2hKZFZX?=
 =?utf-8?B?YVh3b1J1SXBlMEJXb1dsY05MTERrcWkreWQ1aVA4S0s5Y2srUU11SlN2cXJP?=
 =?utf-8?B?WFFqcmtTSVpSM1M2cHJoVERQZEplSm41MkZ4amFDR1JJbTM5ZWxwSjliREVL?=
 =?utf-8?B?dzNvQnVsRFJlR1BScEUxK1NlZzhkbjFZQmtEOUZtWEgrZmpSem1NdHVNRVBz?=
 =?utf-8?B?WDd4YzJCcTVGK3kxbG8vbXdnR1Jta2JnaDF6NzZKVUlkMk1NTm1QbGhqNFpV?=
 =?utf-8?B?SXJPYUlDTjNvc0FqVEdWc3puY1U0ZCtLQXBCS1ZCeWkreWIyd05TL2x1NUlE?=
 =?utf-8?B?cHBIZ3ZrdytSTkRmUUdOSmQySFJkdC94empJNmVITldaQjlnVFc2OVlvM1ZS?=
 =?utf-8?B?R21aQXYzd1dVamg0eXRFVm9NMVR6V09xa1NqdURXUzBTWFFYYVhPWWlMODdi?=
 =?utf-8?B?TWhlSTNUSWlZTm42SmU0dTNxZmxtODY4ZndVU3Z1ZHZOQjh0YUt4N1Z6bytK?=
 =?utf-8?B?U01CaW5ncnJ0anhOTXVpVk9DOW52bHlhRmgyU1lSZ2FrRklzT3ZqZW1jMnRr?=
 =?utf-8?B?QnRIVXduc29VMmhyYVd4WmNJRDd2NzBHVzQrMTV3YlUwQ1poZEJmbHJqT0pv?=
 =?utf-8?B?R2VaV0NGc3Q0Z0NLakhkZ244d3hWVnV5OU52ZDZoSStzNjJORkJuenN1cDc3?=
 =?utf-8?B?MDhvRkcrNUsrcE9hZkQ3OWdlU1NVS3pLMUlBY0VKSGV5cnhKSStuY0Z3eGkz?=
 =?utf-8?B?bTB2WVg1bDdXNlZ3STJBRURYRnZubThaS28yQVE0aGQ0RUF6MFoyUFNSNS9o?=
 =?utf-8?Q?yn48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGVOTzJoc2MxUi9Rdjc0Rkcyc3ZUU2ZOY1phZDVIQ1I1S0RKMjg1ek5aY3ov?=
 =?utf-8?B?NGRVSzNCUFc3ZEhiUHRUUzJFdHBxUmZVUTltZDNPTG1qd3hRaUFtTjFyRjdi?=
 =?utf-8?B?YUp6SE93OWdVWFhqclhNS0lJQytwNjMwdHhVQ0ptem1tSGovL2ErTlVHaGFh?=
 =?utf-8?B?SWs0aE1vTGtTNjVScFNscXNzcXJqL1lJY0ltNGVOZWh0NlpTQ3B5ZzJDUFBE?=
 =?utf-8?B?Nm1oYzM1NjR0UlFKcnppRXphN1NCdC9ubjdOSjBNL1VNNHFhMHIyV3Yrbysv?=
 =?utf-8?B?NFlmWWg0MVJ1RFMvSlZXUUwvZEtKN295ZC8zYlBDZVJITHRlZ1EvWndLNm41?=
 =?utf-8?B?RGk5WXZDZ2hhWE5zSnhXUWdXeTltU2U1TjJIMlFqbmlUY1lTaDFramFsK0FK?=
 =?utf-8?B?TFkrcWQxZWRMNG15U01oWjIybTRQQ2d2NmhvNEkzbWtsUE4xTlRRNWMxZ3hS?=
 =?utf-8?B?VW9VZUdKbW1LMHRhSGNjNnFwWCtSa1NKangrVkdqR1cvU0Q3SDRvaDd5eitm?=
 =?utf-8?B?OHZuVHZWRVJjOHY5YUNPUFlxY1liUDdndXVLL0xWbXpsU0N3V2ZEVjA5eHUv?=
 =?utf-8?B?MVdQY2l1Y3dxbkgyN1ZxRjRZaWxNQ2J1ejloOFRDL29hb0NRQTArL25abzVN?=
 =?utf-8?B?RUU3bElHSXJ2TncrblJ1MVZuOVd5QzFFTkFuZ00wUlZLa2c0RjJzVWlpZDA5?=
 =?utf-8?B?enVQWnNxNHA4Qk5DNHExdTltbDkxWXJBZHJaN0JIbVdGbkZYTjE3OGRCMlJ6?=
 =?utf-8?B?VGhxbkIzQUtQMTlacVdLYVRWbXVvbVJndHFOS1kyc01MR2ZZdGluR3RBSW5Y?=
 =?utf-8?B?VGY4K2RNWkpJVUZqTlFaeVU5bjJYelM0ZUhGRXprWWhoaTVHK3JxUUdzVi9j?=
 =?utf-8?B?ZGlKL25kQlBNcUZzTU05ZElHbXltZmd5VFlweGZoOHRkMEhyOFN2OXZPSXNj?=
 =?utf-8?B?NWUxQTcyMXp4dUFoWjFTK3kyUkdHOXdHcUtpdDJMRHREMlE3Y2hkUUdiamtN?=
 =?utf-8?B?akhqNDJ2aytBUFJpZ1EzdVpIOXlSVHp4VlY3K0hydzlmcUVhV1ZkdDd6dU0r?=
 =?utf-8?B?TkdQY0ZkRmwwL3FDN2FYUnN2Sm13K294VzNXbWR4NDlpTmlYSEhKSW9PU0lF?=
 =?utf-8?B?emFRczdnTElrUWdLZ1lLbUI3UWlUWHVwcXJWYWlNVWtHWS9UMDVPeDRINTFv?=
 =?utf-8?B?SER1VVMvVFVMUXoyTWg2TjY1REljVDBESVNyY1ZFdTlMVlloM0h1SEYzY2lL?=
 =?utf-8?B?RDhiV1NsSFJjQzYwRGNkaXJQLzR5M0VyNHRnVE5EaHlLbGQvNWxDemZRQThS?=
 =?utf-8?B?cUJhTlZlVEpaeTdsVHhuN2sxdWh2V0pwVkhTcmxoOGJkTktsc3NGMElpU1JP?=
 =?utf-8?B?Q3N4UC93UFY1SUNRUEp2NnQ5aW9Jdy9GUE9WRCs3MkhCVVdsbGppODUxenpy?=
 =?utf-8?B?MUwwdVpYWTJDek5TVWZlUXlZdEZNS2VieVZ1bzdmTnlUWFZuY3p0d1VQcWYz?=
 =?utf-8?B?aEIrYzRDYTJEU3duM0JWVzRXMWRKY1VZQkJTVEtxMHppVkJ2Rm1CK1NSMVZj?=
 =?utf-8?B?M1U4ZjlUMnZPUW0xV0FmUy9JdXlEQzVxYVdZK2VnRmgwWm05bmQxK2d5WE5y?=
 =?utf-8?B?M3N1TWhHeUczeUNZQ1RMSU9IajFNZzQvU0lRcHRUTHl1dVZVTlV3U3RScy9E?=
 =?utf-8?B?RTlrVEhlbkFYVTcrZXNncEZ3cFBNMFFPSVQxRVNKK3o4QnhLUnJoMjZRTjlB?=
 =?utf-8?B?NXFSYXRxYnV5aHhBRTJkUjUySWYzdEVKUDFpZ2NVeWhUZVAzSmFIZ3dUdTV5?=
 =?utf-8?B?ZG15TGwrb1dZcW9mZGQ5d0dWZi9OdWRxdTc3Y2Z5bUdySEtGbGtHMVVYQ2NX?=
 =?utf-8?B?blJ2Z3JXTUttL1FJT3EyWmZZdFhNTGdIL0FXYjE2TUNuVGYxbTJkREQwZTRn?=
 =?utf-8?B?cWRxL3ZDQlJUT2k1OWcrZHYxYTFJaWQ1OC9QcG13YUFsS1dJdmxtTTNiS1Mx?=
 =?utf-8?B?VGRBREtKU0p5VWJHTFBoY2VvRDJzVGp3ZkhweUo5Y3dtTElDanJrbEtJTXg2?=
 =?utf-8?B?djhLa1hkVnlUN2lSakYwbXNFYVdwZDFqeWRjVnRHZFF3R1YrRldwV0pYU3V4?=
 =?utf-8?B?T1h6OENRRFFCZzcvR2JHQkVORXp1MmVDRjRKWng1ajQwNVovNkRKbm5VZkZL?=
 =?utf-8?B?bnpTUGlRL25SK0lJOStZdDB3SzI3L1k3WjlnN2dJZHliNjhRSlFUa3FKajlE?=
 =?utf-8?B?TzRPOFkyQVoxY1lYQjdlaHNGM3NtWjlpam4yaUNPSEdoNDlIbVpSZzU3NTN6?=
 =?utf-8?B?QTlHSnFpeUpISDZtVHU2b0haWkpXV2NUZE1yV1UzdktRQk0wQXdZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d6ed76-6579-4006-a921-08de7068e63c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 10:14:57.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tRo6Lu+p5RBATqc+9z6U8H9RIN5Dkx50zgCWcu1x9WboyvDDE9T4PXDYBsHDD8BUagrVThRyFKKzp0P7d7FAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77785-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: B4B44166BA1
X-Rspamd-Action: no action


On 2/10/26 06:45, Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
>
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows. When such a range is encountered during dax_hmem
> probe, schedule deferred work and wait for the CXL stack to complete
> enumeration and region assembly before deciding ownership.
>
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
>
>     - If all Soft Reserved ranges are fully contained within committed CXL
>       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>       dax_cxl to bind.
>
>     - If any Soft Reserved range is not fully claimed by committed CXL
>       region, REGISTER the Soft Reserved ranges with dax_hmem.
>
> Use dax_cxl_mode to coordinate ownership decisions for Soft Reserved
> ranges. Once, ownership resolution is complete, flush the deferred work
> from dax_cxl before allowing dax_cxl to bind.
>
> This enforces a strict ownership. Either CXL fully claims the Soft
> reserved ranges or it relinquishes it entirely.


As I said before, I do not understand why this an all or none decision. 
If I understood this right, we are not trusting on how the platform is 
dealing with CXL configuration leading to some soft reserved ranges not 
having a cxl region. If we do not trust it, why to give such a memory to 
the kernel through hmem?


IMO, it is important to state here the reason for this decision. If I 
understood this wrongly, I guess it is even more important to explain 
the reason behind the decision in the commit and maybe as a comment in 
the code as well. I could not understand it, but at least there would be 
an explanation.


Moreover, as I also commented previously, with Type2 devices, it is 
almost certain the modules containing the related drivers will not be 
probed at this point, or if not fully certain, it is a potential 
possibility. That implies not all the soft reserved regions could have 
linked cxl regions ... leading to given all those soft reserved ranges 
to hmem. I know the "approved" solution is Type2 should go without soft 
reserved memory, but some Type2 devices/drivers could be happy enough 
with dax. If we do not want to deal with this problem now, at least 
there should be some indication of this problem.


>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>   drivers/dax/bus.c       |  3 ++
>   drivers/dax/bus.h       | 19 ++++++++++
>   drivers/dax/cxl.c       |  1 +
>   drivers/dax/hmem/hmem.c | 78 +++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 92b88952ede1..81985bcc70f9 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -25,6 +25,9 @@ DECLARE_RWSEM(dax_region_rwsem);
>    */
>   DECLARE_RWSEM(dax_dev_rwsem);
>   
> +enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
> +EXPORT_SYMBOL_NS_GPL(dax_cxl_mode, "CXL");
> +
>   static DEFINE_MUTEX(dax_hmem_lock);
>   static dax_hmem_deferred_fn hmem_deferred_fn;
>   static void *dax_hmem_data;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index b58a88e8089c..82616ff52fd1 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -41,6 +41,25 @@ struct dax_device_driver {
>   	void (*remove)(struct dev_dax *dev);
>   };
>   
> +/*
> + * enum dax_cxl_mode - State machine to determine ownership for CXL
> + * tagged Soft Reserved memory ranges.
> + * @DAX_CXL_MODE_DEFER: Ownership resolution pending. Set while waiting
> + * for CXL enumeration and region assembly to complete.
> + * @DAX_CXL_MODE_REGISTER: CXL regions do not fully cover Soft Reserved
> + * ranges. Fall back to registering those ranges via dax_hmem.
> + * @DAX_CXL_MODE_DROP: All Soft Reserved ranges intersecting CXL windows
> + * are fully contained within committed CXL regions. Drop HMEM handling
> + * and allow dax_cxl to bind.
> + */
> +enum dax_cxl_mode {
> +	DAX_CXL_MODE_DEFER,
> +	DAX_CXL_MODE_REGISTER,
> +	DAX_CXL_MODE_DROP,
> +};
> +
> +extern enum dax_cxl_mode dax_cxl_mode;
> +
>   typedef void (*dax_hmem_deferred_fn)(void *data);
>   
>   int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index a2136adfa186..3ab39b77843d 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -44,6 +44,7 @@ static struct cxl_driver cxl_dax_region_driver = {
>   
>   static void cxl_dax_region_driver_register(struct work_struct *work)
>   {
> +	dax_hmem_flush_work();
>   	cxl_driver_register(&cxl_dax_region_driver);
>   }
>   
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1e3424358490..85854e25254b 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>   #include <linux/memregion.h>
>   #include <linux/module.h>
>   #include <linux/dax.h>
> +#include <cxl/cxl.h>
>   #include "../bus.h"
>   
>   static bool region_idle;
> @@ -69,8 +70,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>   	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>   			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			dax_hmem_queue_work();
> +			return 0;
> +		case DAX_CXL_MODE_REGISTER:
> +			dev_dbg(host, "registering CXL range: %pr\n", res);
> +			break;
> +		case DAX_CXL_MODE_DROP:
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +			return 0;
> +		}
>   	}
>   
>   	rc = region_intersects_soft_reserve(res->start, resource_size(res));
> @@ -123,8 +134,70 @@ static int hmem_register_device(struct device *host, int target_nid,
>   	return rc;
>   }
>   
> +static int hmem_register_cxl_device(struct device *host, int target_nid,
> +				    const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT)
> +		return hmem_register_device(host, target_nid, res);
> +
> +	return 0;
> +}
> +
> +static int soft_reserve_has_cxl_match(struct device *host, int target_nid,
> +				      const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (!cxl_region_contains_soft_reserve((struct resource *)res))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void process_defer_work(void *data)
> +{
> +	struct platform_device *pdev = data;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, soft_reserve_has_cxl_match);
> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		dev_dbg(&pdev->dev, "All Soft Reserved ranges claimed by CXL\n");
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +		dev_warn(&pdev->dev,
> +			 "Soft Reserved not fully contained in CXL; using HMEM\n");
> +	}
> +
> +	walk_hmem_resources(&pdev->dev, hmem_register_cxl_device);
> +}
> +
> +static void kill_defer_work(void *data)
> +{
> +	struct platform_device *pdev = data;
> +
> +	dax_hmem_flush_work();
> +	dax_hmem_unregister_work(process_defer_work, pdev);
> +}
> +
>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>   {
> +	int rc;
> +
> +	rc = dax_hmem_register_work(process_defer_work, pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, pdev);
> +	if (rc)
> +		return rc;
> +
>   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>   }
>   
> @@ -174,3 +247,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Intel Corporation");
> +MODULE_IMPORT_NS("CXL");

