Return-Path: <linux-fsdevel+bounces-75595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBBDLo+teGlasAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 13:20:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1C94373
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D53730ADA73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E90134AAF2;
	Tue, 27 Jan 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W9E6Rzd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18234B676;
	Tue, 27 Jan 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516216; cv=fail; b=LhH+YWO04c9mgnuWaJnv5h+bppVQGPrzUZrF2C2+pASo71Kby1kCSZJ4YinWmiKXEwFbRIg1yWVJiBgpH7h9u6ShGvtnWTsalW7FknfnBY/IQ5RyXzMIfxB4HXeLMui93ufIVwZ8RellBVLCGW1l6HWtBojdhX1t+LsIVvL4B2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516216; c=relaxed/simple;
	bh=bkFtRjzUtd1tYmpJ+HFxYCgcPUb7T4GtCjn2kdqxptw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bPWFn8dm/B73cyDxcmsDQc3pXYSXIkaHVkNyhIXmEbAM2sOiKZ6Az6I3ZD5v0RPOiKbqZFWqs1nTzkYwiAeL29VU9YVPVJ3Z1Qenu/e6l7+xWcN0jmpKgUqsBc1iZuOOgJYVW8IvyqVyDokhevZI26ET9mapYOaNX1Y69k1qmw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W9E6Rzd6; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QheM1hoA96PzQmmCo7Q6/Y3rBWb+asSiaPcCNAlEFKK6MXihTh9+iO1e3KbKmgYmvQDyoLy9G8thzvuqORltVQLRSCwh4HKoKRvfva506IaLE2biHEIfUXzrqri7KZNr2mASA8vHys6zZjiPw9CDHU01+cHNvifSZq9WFrLBAm7e0gEXuqpXZWwECISvsavQtIU2JYVcIFCvQ63LQScXI49Dd9EAnvMZ/KLOBI34t/8kJ3EwWgShYhVMZu4BZgLKbE1lrER2C0d8Vh0OVo8jgJ/fn+nbjbDjmPVaO8Qz6eSSHuAWwiIwyxH7EFkUw2meswSmhHZYnHBZdd0NxAqpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUl11C/SrWeKQrogk43H82phU/k0LwKhqhyuFQ9yDAY=;
 b=mxtw0uJOIzSXWuMEOC9Tk1U/uUZNxWqvY34Fk85p3TobKzpDc1UHojcX1TC3mREU51/7L0Xa5VjJ9m/P71SMxWbAUK3p18Hj+PzlVMjycE63Mg77IHSnvQUIhlMSL9Y8pTgUKJMgKc9wq5LCT7nXRfv1TSKx6vxBMjzoXQzh0nyBCLiUaIF+zydS47exyLaCUhF3HSwT3bV1D7MCOPS1BaGUyURjyie6VJ5xj/1WUZvklJKb7XVMq4hPZehN0L2FB0YXYmA7oXdtRTVhxz9NvQ0+dK8gmm+zUOCSa+Clfls3VPDRoHmCEzZUuYBTwLBguCdiAlLITHqigsYL8r9o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUl11C/SrWeKQrogk43H82phU/k0LwKhqhyuFQ9yDAY=;
 b=W9E6Rzd6zAGsA3uFilCo4GzrCrBAskiGZuqfte4ZKQs366eiSi+i10+Ek9EbugdUCDrPnhnCA9B0GoyLb5HVquElthfHSeZqHIQHbSJh4Fm7g9KvGFMFT3IyCP6LHWWzW1RDM/gLHM+AyRvM/rpos9s518cwrJATT8F3/uD7aLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 12:16:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 12:16:49 +0000
Message-ID: <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
Date: Tue, 27 Jan 2026 12:16:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Language: en-US
To: dan.j.williams@intel.com,
 "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
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
 <6977fe94d8ee_309510033@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6977fe94d8ee_309510033@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a72509c-01c4-4a93-381d-08de5d9df29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJ4YTc2eTR4Rnc5bmkyYUc0RTBReDkxNmxPNTBCQUUzQjk3TDNteGd1anVa?=
 =?utf-8?B?a0xML2NFcEtWa1lLMEZZaGk1ODY0eUZKNnAyUk10R1NxdUNiRE95a2dLNW85?=
 =?utf-8?B?UWJGV0VtVnJjWGtQbE14b29iWVBmbVdicHZqZ0x2YndmcURueE4wYjJtRElD?=
 =?utf-8?B?S3lrZ2hESkVjdjlSSjNiY1ZNazl3UmF3NU5pMnM5OVRxSFBkdFRyR0EzU2tj?=
 =?utf-8?B?ZWVFUnQvNzZhbmpWaDJyamIwa2R1cHY0eTNKYWwyUWhzR0pOUmFsbENHR2FQ?=
 =?utf-8?B?cmxUeng4Sk9SVDNFTnE5N2dkSmZvcVhwWHFXdmFPL3Rza3Y0VDltMVNlK2pF?=
 =?utf-8?B?OW91SExmNnBjdkY1YVhKaXdkakZPN204Nm5wMDBEeE9FVGc3S3F4TEE2Y0oy?=
 =?utf-8?B?SmU0Q09BQkxPTGpoUlRLbHg3dzYxM3ZQZjUrekVmMFNXU29SSWRCV3BsbUo3?=
 =?utf-8?B?Vm8rL0dGeHhzVVQydWFkYmJqTG1VTzdzc2ViaXB0UVB2cy92RVlPR2p1YXNt?=
 =?utf-8?B?YmJPaytFdGtiNWkwUU9LaUwyUDZIZUVFVXZqd2RBQm9XWjFPcG9EOE95KytJ?=
 =?utf-8?B?UHhlU0VPNmlSV3R4aTE3UUdBa0xjZld0anNTaEtqc2g3OVdJdGF6VlBjRDI3?=
 =?utf-8?B?eWdlTnNpTmh2OFFYcWRwem13LzVTTXZuSHBpcTdjL3B3eVhURWhuUWNheEZj?=
 =?utf-8?B?K29jUldWWlhYN2VJcTgwRlJiSEtHN21hSE5IckJWQTFHS3p0VUZ0N05yaWZZ?=
 =?utf-8?B?UWtMdlB6UWJsYjZFUUV1SjRkMFFQeVVya2xkNkxLVk1tSE5IOWpkQTRqOWkv?=
 =?utf-8?B?TDhKTHhDNUt2TE5mcGZFR1FyVzdOZGE0eGdtYkhBd3AyenRaT2o5RzQ4MTli?=
 =?utf-8?B?WXF0cDErU2cvNGpQT01HWGhSajZRK25EZkFRbWRGN2p0SGp2NlVNbzdrZGc5?=
 =?utf-8?B?ZFdQSzZQSVh6UmI0RGUwSGgxbERvTTZqOHNES0ZCZ3hDb245alR3a2Zoc0FW?=
 =?utf-8?B?TUhCNGxjMFgzZS9Sc0o4dFNzdzN0NjNaVjE1eFVoanpDRHVMa2ZFWi9pY0Q5?=
 =?utf-8?B?N1BzdkphUlZpZFNXcEprUGRySmFib2xtaCtkeFhPSEpuWDRvNy9TTVZoYVZO?=
 =?utf-8?B?RU1FeXFRSndDODhxSEhGc3pOODJFcURhN1QyRmROd1N4WjdGaGYvK3VoZGxU?=
 =?utf-8?B?RXZQaVhsRlJITWNHaThSVDFCaFo2MmF1QU9GcTh5RzNtN1JRc3VmK0N3MmlP?=
 =?utf-8?B?SEZJOXErMVpvc0ZMdUtwbitLaFdSenFCM29RZ3FSdi83bnhHVHlQMGd3Skkx?=
 =?utf-8?B?NGVLQS9TazZyMmFNVmhiQ0N2WVhwRzQyM0FnaGd1NWpqSDYrdFhWSlo5SjRi?=
 =?utf-8?B?Q01md3V4SVg2eVBraC8wZmRRV3VBYjJOUWlTWUJieE9YVWlFRXhTVitGUFp6?=
 =?utf-8?B?bTVicUlIQ201emdWRDdGZU80eHJkbmwxK3Z4Y2IwZ0tSeU1PQmNpL1VtaU1Z?=
 =?utf-8?B?T3RLNTVJV2pkMGVyZ0drZTRWTmNKRVlhc0dWbnlrYmYyL3pkc1gvd3B2SjdR?=
 =?utf-8?B?VHZRTk8rV0wzaWZaQ1VHNVk2RWg1RTFxNHNwcUtzUWRNOEN0TmhZTkVadkU5?=
 =?utf-8?B?TXBLYTZBSUtRclZjakZVMkN1M216bjdTQUQzb25rMVJJWHRqdHBZbUtDUTNH?=
 =?utf-8?B?endlbk5saDcrR1I0Um1hMHZ3TDVwdkpQaENXakNuQVp6SGtDRGFDQXEvUUFM?=
 =?utf-8?B?RUxiZVVLTm9IUm0wTldPWWVVMlVoT00xZ0diNDNvbnh5NEh1NUUwRGFMQ3hK?=
 =?utf-8?B?cm9wOXhhaUpRcmZKc1czeHI4dVlZcXJLWWl4NUpoaitta212azI5WDNaME02?=
 =?utf-8?B?QTZBSUdudHhNbklHeklVLzlsekhwTkZod25YNWRHY0FWQmNETDY0dmRRZVN1?=
 =?utf-8?B?Y0VXVmUvSGVQZjIyRkl5aWE2d0VGbTExQW1Ha2dPNzB5eVVEUVRya2VSMmY4?=
 =?utf-8?B?eGhZN0g2WUw1c0RDMlM5a1NZWXExNDYyNHYrTE45SlpoZkozWHZEOWtnMmR6?=
 =?utf-8?Q?2J5YLk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFBqVXcyU3cvZWFUS00xQWJoWDJld0hjZVZFMXRDdUVteERQdVNPZmk5Mnh0?=
 =?utf-8?B?SGJoa1ZsbHVVNDQ1WDhGd0U4TVdpM3hBL2JGYW5xYWk2QkpQSXIzV245YU13?=
 =?utf-8?B?amZlenpVanNiYlBhdGliZTRiUy8wNEFtRWJhaklvQlEzVkFXWFZ4TW1KRnNJ?=
 =?utf-8?B?QVV2TEJPMHdpOHJ3c3pwVUJxbm9KZlhVUk1hZmw1RnIvbE9JZHB2QWc4Zk9R?=
 =?utf-8?B?OU5haFA1VzhzRkNwWmdYQ1NJT0haUmtYd2h3T3ZUTnNOZ0ZUSnRqZUI4L2Yr?=
 =?utf-8?B?eU1jZHNRVzFSZmYveDc0WHFVQ08xMGVxQytmR1N3UmVBbDA5M2QrYXlUc3NX?=
 =?utf-8?B?UjVaS1V1cVdjTThma0htZ0UwKzJTNDh1S2NKeitiWC9ldkNES0dHNXZVWUgw?=
 =?utf-8?B?RHNhaGxic09WZENkMVFPdHlsWGs3citYaVZseXV3WFBRTFRXVnlzRVNPeS9q?=
 =?utf-8?B?ZklJTzQ4NU9HNGtkTjBDWGd6TU5abVRJYlZaQW5Cc2Vvd0hBZS9IcjJDK3R1?=
 =?utf-8?B?TFJ0ZjF5YnhKRDJVd0VlajVXNXE3QjFaSXVtUXlrK1l5UnJJdXgwZ3BCNjY1?=
 =?utf-8?B?Q0plVWZTY0R0K3VUTENEbTU0MkRZSCtSZmdnZXllZSt2OFFjeXI4SHJNZFor?=
 =?utf-8?B?dDlocmlRcUlKN2M4SktoRC9TSEtiRVdndEo3ci9yMG1VRTRIcHNuMVJGZHM1?=
 =?utf-8?B?a2hucGhOaDl3a3JaREhjdXhYd1BrQ2VTMjRwTmd0cGUzNHozeWE5eGd1YTlI?=
 =?utf-8?B?R0ZGbzUvd2Q3Ulk1TFhiOXAvS0F0aTZsbVU2TjUzcHJveTdCanl4L1ZEenJr?=
 =?utf-8?B?SlNMZHU5RTdlZGo5VVk0aHFwVGRtVlR0MzUrNVNub1UzdkFtcVJWZ2V4WEk5?=
 =?utf-8?B?eDJlMlViS0lkak5keVBPOVBDQ3N1aEpQdktySzNpeHR0UjhQWjlKbzgvUXJW?=
 =?utf-8?B?dUZDQW5mam1NczhSU002Z0RCL0tJMHlFUTg1aFBWc0JMUUJYN3JUcTdtUnNE?=
 =?utf-8?B?OE13RnBNR2JMbnd5eG1EOUhSOWtxZzN6SGJvNXM5emlIb2Y3NjBnK0JnVm5w?=
 =?utf-8?B?algrQU5hNkJjNUYyWXhiTWpqWSs2QTh4MzVablRaN2tDWjZGQkZUeS9MbVJN?=
 =?utf-8?B?SzBROUthUmZEL0ZPdlcwMFlGdXBuRVJjdlhoZUZTYWVNK0VrVHY3N25hWFRI?=
 =?utf-8?B?ZDBhclo5TGxWRG9OMDJvSGhTU28vaVBKbXpZRGtIeStHUDdFcmdWUlEyeW1r?=
 =?utf-8?B?eE41WVFnNHVXM1U2RkZsOGRQOWxKQW1KaUtXY3crQXJGS21XUXF4WURnQ2Iz?=
 =?utf-8?B?dzZIeDdScDhKcXdUcmtUWnJHZ3Nsc1pmVkpnazF3N1ZvcEVKZmhUNzZGdmhz?=
 =?utf-8?B?Y2pubGRjQ2FNdGozWkFRa29oR1doSEhMYXgzU20rZ1c3N0VMQUgwV0JFU1Vk?=
 =?utf-8?B?NEU5UHFOV1l3TXhGOWpiRklJRnZNWjhGRmk1eWEwZ0ZXZ3NoU21OSERUUkNO?=
 =?utf-8?B?Nm9hOTVsYW8wblhSb3VxYkxMSzAzK01tZmxQMXRjc2pEMkxBZWxKVzdLbXRX?=
 =?utf-8?B?aEdiNElMTHVIN0w1V0drOEgrNGM5RDJHS3RaWmFpQ2NVWE1OUWNyN1hlMmgz?=
 =?utf-8?B?S3ZpbzFIUzVvYUptUThjaTY1Rk5kaDMxUDYrZTJDak5nejQwanUyUnNVeHZJ?=
 =?utf-8?B?cnptcmNCcjlHWVVpU0RVMjE0cE11dW5tRGpjalE5WWZ1c0MzWE45VVpWZzhP?=
 =?utf-8?B?MUduZG03bHZqY1p3SG9CMXpkbWRTb2VsZURvTUxVZjJRd3Ntcmc4VytsbEly?=
 =?utf-8?B?MWVQK0QyMldkQUNab0dVQzNNNUZPR2liaFUzdWlOejlkWFV0b2x3Ym0xTERp?=
 =?utf-8?B?cFhsWVpZWjlTcGpuVDRIM3YwT3JjZ1VVRmprRzUzWVBrYVVIZnA2SEVEQkI2?=
 =?utf-8?B?MjVuYk90L3d2WFh6dW1kK0E5QkZHZEVZS3lQUDJjYmVaYXFuOW1uV2J0aTB0?=
 =?utf-8?B?S1ZwN21hNnUvOW4xYlFIME1qUVJURGpUNDM1azlpbVBYN1F4VUJHcDRQQ0lZ?=
 =?utf-8?B?dzZTai82OCt6bVNGeWtCMEdNTHVNaHlMSlQvYnZkNnVRWlNlMTcyOElpM1Vm?=
 =?utf-8?B?TEFoTEhYK1JLRHprd2xGTXpMcDZkYXhKMHVwa2dvbm1ZWG1UZC9qUlVUcVV1?=
 =?utf-8?B?aW9FK3lqb0VPdHB3bzBJbFpPWGRtUkg4Z1N1RUZ0dGpZUEM1dzFod0ZuQTIx?=
 =?utf-8?B?VUVRa0oxL2psdUk2QlF6djNQRndtRS9HV2ZFOHpHSFdRVDVDV3poZ1FDZWF2?=
 =?utf-8?B?UHAyYlNiMGNHcnlGUHFxMzMzUk1DZTlFWVFkbEJnTGx6TjVqWk80UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a72509c-01c4-4a93-381d-08de5d9df29e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:16:49.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIX34zaatQqwgXIeVzsdzNjQxDB0i/r/2nqQJvpIg8jNzrlt2CU9aBclxCI1ZjwExGmy+MolMyoyluccDgVyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75595-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,lpc.events:url]
X-Rspamd-Queue-Id: 18C1C94373
X-Rspamd-Action: no action


On 1/26/26 23:53, dan.j.williams@intel.com wrote:
> [responding to the questions raised here before reviewing the patch...]
>
> Koralahalli Channabasappa, Smita wrote:
>> Hi Alejandro,
>>
>> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
>>> On 1/22/26 04:55, Smita Koralahalli wrote:
>>>> The current probe time ownership check for Soft Reserved memory based
>>>> solely on CXL window intersection is insufficient. dax_hmem probing is
>>>> not
>>>> always guaranteed to run after CXL enumeration and region assembly, which
>>>> can lead to incorrect ownership decisions before the CXL stack has
>>>> finished publishing windows and assembling committed regions.
>>>>
>>>> Introduce deferred ownership handling for Soft Reserved ranges that
>>>> intersect CXL windows at probe time by scheduling deferred work from
>>>> dax_hmem and waiting for the CXL stack to complete enumeration and region
>>>> assembly before deciding ownership.
>>>>
>>>> Evaluate ownership of Soft Reserved ranges based on CXL region
>>>> containment.
>>>>
>>>>      - If all Soft Reserved ranges are fully contained within committed
>>>> CXL
>>>>        regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>>>        dax_cxl to bind.
>>>>
>>>>      - If any Soft Reserved range is not fully claimed by committed CXL
>>>>        region, tear down all CXL regions and REGISTER the Soft Reserved
>>>>        ranges with dax_hmem instead.
>>>
>>> I was not sure if I was understanding this properly, but after looking
>>> at the code I think I do ... but then I do not understand the reason
>>> behind. If I'm right, there could be two devices and therefore different
>>> soft reserved ranges, with one getting an automatic cxl region for all
>>> the range and the other without that, and the outcome would be the first
>>> one getting its region removed and added to hmem. Maybe I'm missing
>>> something obvious but, why? If there is a good reason, I think it should
>>> be documented in the commit and somewhere else.
>> Yeah, if I understood Dan correctly, that's exactly the intended behavior.
>>
>> I'm trying to restate the "why" behind this based on Dan's earlier
>> guidance. Please correct me if I'm misrepresenting it Dan.
>>
>> The policy is meant to be coarse: If all SR ranges that intersect CXL
>> windows are fully contained by committed CXL regions, then we have high
>> confidence that the platform descriptions line up and CXL owns the memory.
>>
>> If any SR range that intersects a CXL window is not fully covered by
>> committed regions then we treat that as unexpected platform shenanigans.
>> In that situation the intent is to give up on CXL entirely for those SR
>> ranges because partial ownership becomes ambiguous.
>>
>> This is why the fallback is global and not per range. The goal is to
>> leave no room for mixed some SR to CXL, some SR to HMEM configurations.
>> Any mismatch should push the platform issue back to the vendor to fix
>> the description (ideally preserving the simplifying assumption of a 1:1
>> correlation between CXL Regions and SR).
>>
>> Thanks for pointing this out. I will update the why in the next revision.
> You have it right. This is mostly a policy to save debug sanity and
> share the compatibility pain. You either always get everything the BIOS
> put into the memory map, or you get the fully enlightened CXL world.
>
> When accelerator memory enters the mix it does require an opt-in/out of
> this scheme. Either the device completely opts out of this HMEM fallback
> mechanism by marking the memory as Reserved (the dominant preference),
> or it arranges for CXL accelerator drivers to be present at boot if they
> want to interoperate with this fallback. Some folks want the fallback:
> https://lpc.events/event/19/contributions/2064/


I will take a look at this presentation, but I think there could be 
another option where accelerators information is obtained during pci 
enumeration by the kernel and using this information by this 
functionality skipping those ranges allocated to them. Forcing them to 
be compiled with the kernel would go against what distributions 
currently and widely do with initramfs. Not sure if some current "early" 
stubs could be used for this though but the information needs to be 
recollected before this code does the checks.


>>> I have also problems understanding the concurrency when handling the
>>> global dax_cxl_mode variable. It is modified inside process_defer_work()
>>> which I think can have different instances for different devices
>>> executed concurrently in different cores/workers (the system_wq used is
>>> not ordered). If I'm right race conditions are likely.
> It only works as a single queue of regions. One sync point to say "all
> collected regions are routed into the dax_hmem or dax_cxl bucket".


That is how I think it should work, handling all the soft reserved 
ranges vs regions by one code execution. But that is not the case. More 
later.


>> Yeah, this is something I spent sometime thinking on. My rationale
>> behind not having it and where I'm still unsure:
>>
>> My assumption was that after wait_for_device_probe(), CXL topology
>> discovery and region commit are complete and stable.
> ...or more specifically, any CXL region discovery after that point is a
> typical runtime dynamic discovery event that is not subject to any
> deferral.
>
>> And each deferred worker should observe the same CXL state and
>> therefore compute the same final policy (either DROP or REGISTER).
> The expectation is one queue, one event that takes the rwsem and
> dispositions all present regions relative to initial soft-reserve memory
> map.
>
>> Also, I was assuming that even if multiple process_defer_work()
>> instances run, the operations they perform are effectively safe to
>> repeat.. though I'm not sure on this.
> I think something is wrong if the workqueue runs more than once. It is
> just a place to wait for initial device probe to complete and then fixup
> all the regions (allow dax_region registration to proceed) that were
> waiting for that.
>
>> cxl_region_teardown_all(): this ultimately triggers the
>> devm_release_action(... unregister_region ...) path. My expectation was
>> that these devm actions are single shot per device lifecycle, so
>> repeated teardown attempts should become noops.
> Not noops, right? The definition of a devm_action is that they always
> fire at device_del(). There is no facility to device_del() a device
> twice.
>
>> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(),
>> which takes "cxl_rwsem.region". That should serialize decoder detach and
>> region teardown.
>>
>> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during
>> boot are fine as the rescan path will simply rediscover already present
>> devices..
> The rescan path likely needs some logic to give up on CXL region
> autodiscovery for devices that failed their memmap compatibility check.
>
>> walk_hmem_resources(.., hmem_register_device): in the DROP case,I
>> thought running the walk multiple times is safe because devm managed
>> platform devices and memregion allocations should prevent duplicate
>> lifetime issues.
>>
>> So, even if multiple process_defer_work() instances execute
>> concurrently, the CXL operations involved in containment evaluation
>> (cxl_region_contains_soft_reserve()) and teardown are already guarded.
>>
>> But I'm still trying to understand if bus_rescan_devices(&cxl_bus_type)
>> is not safe when invoked concurrently?
> It already races today between natural bus enumeration and the
> cxl_bus_rescan() call from cxl_acpi. So it needs to be ok, it is
> naturally synchronized by the region's device_lock and regions' rwsem.
>
>> Or is the primary issue that dax_cxl_mode is a global updated from one
>> context and read from others, and should be synchronized even if the
>> computed final value will always be the same?
> There is only one global hmem_platform device, so only one potential
> item in this workqueue.


Well, I do not think so.


hmem_init() in drivers/dax/device.c walks IORESOURCE_MEM looking for 
IORES_DESC_SOFT_RESERVED descriptors and calling hmem_register_one for 
each of them. That leads to create an hmem_platform platform device (no 
typo, just emphasizing this is a platform device with name 
hmem_platform) so there will be as many hmem_platform devices as 
descriptors found.


Then each hmem_platform probe() will create an hmem platform device, 
where a work will be schedule passing this specific hmem platform device 
as argument. So, each work will check for the specific ranges of its own 
pdev and not all of them. The check can result in a different value 
assigned to dax_cxl_mode leading to potential race conditions with 
concurrent workers and also potentially leaving soft reserved ranges 
without both, a dax or an hmem device.




