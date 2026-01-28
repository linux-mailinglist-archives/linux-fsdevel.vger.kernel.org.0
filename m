Return-Path: <linux-fsdevel+bounces-75806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE/2N1l8emka7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:15:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FDA9045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37EC53008C00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F337107D;
	Wed, 28 Jan 2026 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XAFLxKuu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3DD36EAB7;
	Wed, 28 Jan 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634903; cv=fail; b=he73jW85hIdv5LAkhlQRXl9JvveOWBu7UD0QOainbziB/f0pObRQwMkrKbQVJoFi1jvX+LRg0MQL6lEDOiWZK5n6lydA/IbBFxR9KtkSBoZLoo+fb+otyD7KSOqgTnqF9gwx+dRc7xzZtdDl/vVdYTYR/mV/jDC+Nv4tgWmj9ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634903; c=relaxed/simple;
	bh=aPFoSLuZpuWuymnO1Kka/6xmTIPjIGgtBO37tOx9WR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cUP3ZL5+QxUTWojE+/CuvjxN1IyKO7qsFg2m8VHXoCXLdGrhgXXdsfLxI6ZtCFjUiGOPwbu0eTIfGr2NV10c2g+OMF2XkMXsji+gJywpb8tPqkz1f7JVdjpGpFr+lU73HKrIeGbe+Ksm3cqDf+CFo6LE+atfsvEa7GTkTKVIgY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XAFLxKuu; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IG3mNKAnE7GUaLkIGbjeJPL1SdWcAFXKfkcBVc+Iyc8LstuWHWeE4sAgDG89B6gHyxdVhUww18Wl+RYoz9eDvUc5A8PbFW7p773LytQVKSzWE6jdKZW7FsRzBeTAGQIDrJmhidR+FmO/Zg04NXkT312VM282F/5cmpzpWyKL3CPhXOgszSS+IexF7T23X5XARsjpZkcQGpQdsHMKmrKh6PnOZRX0ClDjQ+5fY7zMZDUJVAZi/kL4b318O1eUGG5DliAEBEdS0Pnig+T5b2QRIFgaIxUguS/9n4i9CqLu8gjutQEbjS+voFZszpqoVawfS9+96HojE3dI+cYsZfWwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9C+14RfbiXfB/B+BzZzjgXjQI6zY1j1M4yCj9EtZcQ=;
 b=L8skuyizbr3ZW4WdseipJyLUX1j6gIPk3jlx36TNxEBi6OpD0jh6SOub69TJH6kkrBLDiwr8bI3ZSE/8BgpofGop9xuy1VYAbFr5A8uvss4XmzsYMwiW6UrCvFbWqtl8X/6Jw+dFl66kn1B+K/hFd+922rxl3ksh5RnmkHmGndMhncs78LMDr2C8ED9hcWO6Ttc6AecCijH9whhzEZUhE7YZt4ExSnWqHEWr9BlZ8MNHPTpJ1OJLtm0p8Qy+2kr42rmlCgI2iXhwiVFJ02ZUxWL4Eo3RHTd9lqTvyg3MQGSH7BH/KSX16hq302IYPhFqHYhn1ows/j1lKrH2m7z8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9C+14RfbiXfB/B+BzZzjgXjQI6zY1j1M4yCj9EtZcQ=;
 b=XAFLxKuupGRHazz8BWQlaDtY8yRmrf4V33H2s3wgu+lwBUZ6MTelnfm/gUAF8fBs+zdjL2mymefYrOiflEbhuocSqNh0YzR044+I/MEyYT/kRSQ5BUNxSLDfetK70YoQtniavXYIptEr81PgehIuC+rZXDc330rDA3d3XpK5cM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 21:14:56 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:14:55 +0000
Message-ID: <5a150b32-2396-4870-8467-fc3fa9f8d0e7@amd.com>
Date: Wed, 28 Jan 2026 13:14:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
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
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <aXgXA2OYOUfyGlQF@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aXgXA2OYOUfyGlQF@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4ee596-08cf-4549-c1fe-08de5eb24918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHJqQ3NyMkpackNhd3huVEhNZXJCajdsa1AvTGd0Z2VmUHY1cmlOaDNoaHhq?=
 =?utf-8?B?OUFkdTZWUXV6NEJmVkFlY3FseStQN2VlQzExWU9TYUlmL25QOFB4K3dQY2li?=
 =?utf-8?B?ZXRmTDdJSjNVS0hJdGZUZFkzbm04MXdUNUpDdVlEWkMrd2phVEJxU2xnN2da?=
 =?utf-8?B?bWttTmJkYUxoT0FBZHdNTDBiaHp6REdHdW9RZS95eGEyQU15SlcyWFBFc1Az?=
 =?utf-8?B?VzVVckl0ekJzcnBaaExhZTVxblBhQU1lSHhnQ2t3SkZxQ3VQUU5NWlZxcTFh?=
 =?utf-8?B?a2w0SkhSLzdCK2h6cEtwa1hscTJyQXJkTHVmUEx3UHk3cFB4eGk1a28vaWxO?=
 =?utf-8?B?dnc5eWswVDVpamsvQnZkUnFtSnp2bzJkT1kxZE9Vclc0LzVOUWVIY3llVHJE?=
 =?utf-8?B?aGg1d1E3R0tHWkpqTUdHNDZKTklnQWpCTlNXVGpSazNvbC96QW9hRExDbWIv?=
 =?utf-8?B?c21rQUFXY0ZLVVZ3MWNPMkdwUGptd1pldWZFeXBaaGE3SmVYcGE4NnlaYnZS?=
 =?utf-8?B?ZTNmM2srMlVvRm5ULzRuSFl5b0RNS1diSWlFL1krbFlveHNsdEZSU0VuMXN6?=
 =?utf-8?B?KzBIb1RjbXdKa2RxSHA5S0JKRDlQYkZEbVZQdWM3bmNtZzE5UmRLdUlHUExR?=
 =?utf-8?B?WVpha2VoTnQ3Z25HQW44Zkd5WEYxdXRYRkcrWW1XUXlkVEE0YnFrd0JIYXI3?=
 =?utf-8?B?a0swNzd1QThJLzhIM2ZtZEd0dGszRG40QkpyTVVUTHJxRitnTkVESThxNjhH?=
 =?utf-8?B?dWkya2h6Qndjd2Ywd2hnVEtISmE0d0M4QktwdFh5R2dTemxrdWprMHVHcjly?=
 =?utf-8?B?SGpMZGpxNldPQUEwbmM4aHhEQU1obEhsL29acHkyQStjN0lGUXZ4aS9zZFVm?=
 =?utf-8?B?TWM0UVFtN1dMWTJubE91WmNFdU9qb2h1eHlEWHkvYzhrRVNYQUYxck0ybTNy?=
 =?utf-8?B?S0lDUElRb212RzVWVnBGZGJ5NWg1ZktQQkJBYUZJWDJRRmI5Sk9PVzh6a0dD?=
 =?utf-8?B?cEpnNmJlL3Q1Wm5yZnIxZnF0NGVjVDZOYTlRS0VndStVOVp3QTc1TnRLWE9o?=
 =?utf-8?B?SVY4aFh0dzF2SjhodElBeTZXOEUyQ2ZCSGQyZm8zYzI2VkZxQVFFZzlER1VX?=
 =?utf-8?B?alJZMXJTaUg0czRNWVY4Vm1CZGJQSWhvZ1VZeDFYenJ6OEZ0eU41cEMwWlh0?=
 =?utf-8?B?Uy9vSWgvZFNxVnJrL0ViSnpaYjNUM2MxdERQSHdQYW5nRU9vYkoyM3dKNFk3?=
 =?utf-8?B?K1pyN3NPSXU1NGJ3bGM5TStTYnQ2Ny9lZk5YVGdaMXd4ekVUY0Qrd3dHTDRF?=
 =?utf-8?B?clNRWXNNeXcwaVEzbHNYLzhralMyTUVlWkw5RWVWdG4xOGFvMTRmRnV1cWNS?=
 =?utf-8?B?RWppQ052ZHpVTndDODViVnhtNk1udytTOElRdExNOG8xakQ1aFFvTVM5RGI4?=
 =?utf-8?B?WGg1K0JXRXNrU29IMHpqbjdWcWhBYlhRa2RGb1hRUUFzNjJ3T2kyR2hRSmVE?=
 =?utf-8?B?aU43OUJicFR4ZnBhcjhQbUxsRlQ2dzU0WVBySmZlOHZVa083aEpDQVFFYU9S?=
 =?utf-8?B?L2VsNmh6WnhpYVJzUFNmUGh4WEhYcjNqQkVoemZ0aEx4QjJKOXNuQ2ErY0lF?=
 =?utf-8?B?YnR0SDR4a2xlaVZ1Wk5FTmt5ZmowaVlUNTVTd0tqa3ltS1lGNjZWV2Z4MDJx?=
 =?utf-8?B?UFhLZVNuOGl5K1dEZzU5ZHg4dUZLem1tUVdFTU92b3NjZUxhbFJicmJraWNz?=
 =?utf-8?B?M3lVTWFKR21hdWpzT2o5bmhzTUcwdkorZjlYTkh2b0MyUDhiSHZqRUtiYWE5?=
 =?utf-8?B?Vk1mVkNYdlpnTjJ1TDEvWFdhM3hJWUpUNytlcWhhelgzaGdkMFdXejhEdVNR?=
 =?utf-8?B?YkpoQ29sUC9yVGxwTGdpbWpUd1hXSmlWM3lwSFZveC9Peit2UGlXaitYa2xx?=
 =?utf-8?B?U2NxRVVsdUUvRGNFeUM1VHY2TlhYL0ltYzErRVI1SkZDQ3UwK1NuQmlFZFlo?=
 =?utf-8?B?OWUzTTE0SjMraXpERDRrWHg0YThseVMwVVkzQ3ZyckpZd0hXbTFKSlZja2dC?=
 =?utf-8?B?b3M5V3lCUEljRm92dVVIaTRjVXQ2N3llZ2tUUEdaSER5bGcvcnBUMTkzSmdy?=
 =?utf-8?Q?Yw7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJNcTFHMGl5bWx1a2RZWDBSOGhDTHk4cE55ajdweWdFTWNiL1ovanJvZGV5?=
 =?utf-8?B?OXpVY1ZvY3N1enpMaDN4NXRQQUI2WitNOHNSUnZ3V0tVQ0JJeHVpQ1hnSHpV?=
 =?utf-8?B?WkNyZzNWdkpCNTgrOUNoK1pIeHByVEk5aStJY0tHN3U2Y0tvaWtPZ3RVT29y?=
 =?utf-8?B?SFRJMXJwK2FXRW1LYzM0eEdKY05lSnlPNEljNDdpQUo4c0hWWDNqSWJpZUV0?=
 =?utf-8?B?d3hGWm4wRjF5UVVEcjhmYXNPY21pYUVVVElMSEQ4S2FTd3ZNUXgvZ1FoaXpm?=
 =?utf-8?B?enVJRUFHYktFWjg0djhOR2FJWGJVdjhFNDBEZVM2NkpEeC9HRkNMMnJudGdO?=
 =?utf-8?B?QXc3d0JWVmh2aCtqblAzVjlZMTFIeVB0YmFsOUlJcUduTGkyS1Nic2xtMWtu?=
 =?utf-8?B?VE9QcnQ2NGIzbXU4UWVvdmN0bTlTNFJLQTJRT1dBQ0hwdnlGcVhBVjBZY3JX?=
 =?utf-8?B?Ulo2a0c2TXByK2VXbnJBWm5PYStTbHBQaVNGck1kUSsrOHpodlhTZlNvSGZH?=
 =?utf-8?B?Q3ZQZ2dCd0ZLRHFZN2JlVDNyQkcyb0JxN2NIRGtoQklhbnJxblpOYUhtelVk?=
 =?utf-8?B?cC82c1JkcVcvZmtBLzlrL0MzWDk5ZEJkU1JBL2d4cGVTUnZscS9tV0FkUDV6?=
 =?utf-8?B?WWE4V29IOTF4YmNsVmZ2L0p3MUNHSVBvdnJRV1FrUGRQaGJEZ0xycllJSUlM?=
 =?utf-8?B?ZHY1VW42dHRZN1FkaUdTOG1TbEVTU2dBVmlaY2poWGkveGRBamVlay96eFB2?=
 =?utf-8?B?aGwraWNveWZzendBVG9MdVJBQlpJMk04RzRYcC9INEludUFYK2tIQkVkT0dt?=
 =?utf-8?B?Mjk2TFZSNXJUMUtCekI0SklWQnd2dFR2ZmRrK214WWt3di9WemVkWDFRck5s?=
 =?utf-8?B?YXM4T2IvOCt5TzMxYmNrbC80TGdkQ2hhR2M3d2ExdWordU5QTHg0aGsvcG5U?=
 =?utf-8?B?UDFmeGgyTW8rVlFWeUllZjlUSnYzbkFzM2VvdVZMVVBlVlgxS0djby9kWFlN?=
 =?utf-8?B?UytOcnZhMWk3N0V4RjRiZ3BMQ0J2ajc1eWd6UUE0YTZnUFRlRkQwbmxYN2M0?=
 =?utf-8?B?STlwdzJ0R3FhRVA3OS9vMTVPL1FGdGQzbmhHMHB4V1g0QjJIS1ZJWXNFMzVK?=
 =?utf-8?B?Ri8rWUl3RUplUXZzRE1GOHNJYWd5UHFHQzhINDNIUGIvbERaUDBPcTlVVUZh?=
 =?utf-8?B?YlVOVWVybEVVL1FLL241WklKOGRqYnkwVkYzZ2puSFRrZC96UjJxU1Vnb2Ru?=
 =?utf-8?B?MjdDMEVoNzJYQ3cxNDROWWVTOUYrZU1wSUpXOWtHcUZwa1lWdlR2d2RaSEhl?=
 =?utf-8?B?aXdlWFhrNmM3ZlRKNGZCNTFnSzJKM21EOVA0Q1JDTG9lU3R6Q1NSRmlHWG5u?=
 =?utf-8?B?b0p3b09sRjZwNi96NUdqbnR1OWNTLzQ5cEdYRkU4WnZISVMwSjA1ckNZRHVt?=
 =?utf-8?B?UjVaTndTUFk3eHlHWGRWeG95UHEzcGRkUFZtNkFqcjBXdnJBdVJIRW5CdTJp?=
 =?utf-8?B?VlFJbjFWaElUY3N2QVdPVFh0NjVPbE9qQWR6bWYrM1E1M0s2bWx0QU5jUWt0?=
 =?utf-8?B?S09rbWNMOU4zUnVQU1c2bXhqbGdEMmVXY2ZQdTlIYWdtL3FPbDBiZWd5Q1Nx?=
 =?utf-8?B?ZEFqTGpHaXduZitBdEJxQVhiYjgyL1pPSDJ2cmZPdHpiWjlCdUZTdGtSOTFq?=
 =?utf-8?B?cExsN0k2VVB2V2E2MWh5WVp2bitUWnEyNCttMXNoLzdYc0Rna09LYVM0dExO?=
 =?utf-8?B?N0hsTlBaL3FQeEF5V3pzRUZ0cXN3RHlsU0hQVHowdGlyK3I4ZVlUYXpsUGFW?=
 =?utf-8?B?emp4YTBwcGo3UDRIR0phR2FNMXRXcjNFbmtoV01VUVF2MHlQSElWcDlTdHJ5?=
 =?utf-8?B?a08wOXhrcEFacUw0SW9ObWt5cjZRR2tDR2piTzl6aDFuaXJCanNFUTNqajl0?=
 =?utf-8?B?MkhzcVJ3d0pXV2Z5SWwrWlNJL1hpNnI3cXNQWlRrWGpTaEFjTVN5UWRoQmlR?=
 =?utf-8?B?cHc0SUVzb2tCUjhscDRzVVR0TWZCV0U0VVNxbXF3L0FRRmpEbVdpTEpjcXNp?=
 =?utf-8?B?bW8zUU9iUURvcm81cDYvR0VyTWNHS3lsMkNncW8wZUtkRE1OM2kraldMSGRu?=
 =?utf-8?B?ZFlubHBoNGIxcFc4Nmt2Q3MxWEdRSDI2Zlc1TU1scTlSNnZURFFxSk5hUVJi?=
 =?utf-8?B?ZUorWlMxaUZLS08vdWxHL213N3YwOW5OZ2ZsY0JMdCtkK3JvdWhFc1JFVDRh?=
 =?utf-8?B?UlRGT25ic1dQOWRrcjVwRzJKWk0ydUh3QXRsU3NOTlhkK1NFbC80Wk1BOVNi?=
 =?utf-8?B?N2psOUE4dmwvMWlFeGtvclRZTnUvL1VjUVlLZ2d6N09CTDFSSXpkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4ee596-08cf-4549-c1fe-08de5eb24918
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:14:55.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Zp5iqC/1tKMirWoW9FSZY7ppQ++TJilxP1R8y4ckuXVNUXFhCZBXV82nSlfSussjnGrlgWbrXSFYP+RP100fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75806-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C44FDA9045
X-Rspamd-Action: no action

On 1/26/2026 5:38 PM, Alison Schofield wrote:

[snip]
..

>> +static void process_defer_work(struct work_struct *_work)
>> +{
>> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
>> +	struct platform_device *pdev = work->pdev;
>> +	int rc;
>> +
>> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
>> +	wait_for_device_probe();
>> +
>> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
>> +
>> +	if (!rc) {
>> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
>> +		rc = bus_rescan_devices(&cxl_bus_type);
>> +		if (rc)
>> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
>> +	} else {
>> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>> +		cxl_region_teardown_all();
> 
> The region teardown appears as a one-shot sweep of existing regions
> without considering regions not yet assembled. After this point will
> a newly arriving region, be racing with HMEM again to create a DAX
> region?

My understanding is that with the probe ordering patches and 
wait_for_device_probe(), CXL region discovery and assembly should have 
completed before this point.

Thanks
Smita
> 
> 
>> +	}
>> +
>> +	walk_hmem_resources(&pdev->dev, hmem_register_device);
>> +}
>> +
>> +static void kill_defer_work(void *_work)
>> +{
>> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
>> +
>> +	cancel_work_sync(&work->work);
>> +	kfree(work);
>> +}
>> +
>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>   {
>> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
>> +	int rc;
>> +
>> +	if (!work)
>> +		return -ENOMEM;
>> +
>> +	work->pdev = pdev;
>> +	INIT_WORK(&work->work, process_defer_work);
>> +
>> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
>> +	if (rc)
>> +		return rc;
>> +
>> +	platform_set_drvdata(pdev, work);
>> +
>>   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>   }
>>   
>> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Intel Corporation");
>> +MODULE_IMPORT_NS("CXL");
>> -- 
>> 2.17.1
>>


