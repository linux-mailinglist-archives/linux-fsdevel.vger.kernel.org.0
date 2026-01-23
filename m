Return-Path: <linux-fsdevel+bounces-75269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNsMENRic2luvQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:00:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C4E75785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44B7300CE45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B8318EF9;
	Fri, 23 Jan 2026 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJ9djrsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F3318B83;
	Fri, 23 Jan 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169560; cv=fail; b=P+DsIJALdYWiNGsBrUHCNBY2odM72naXrd+qG7qNriGSDHhK3ipXof5UZxlqMGEBbGp4+Nx2celm0b6QI4FwHU3z1n+FECzSQMwe/DxMMvvPu+z2aFjYrm0OJoI3xpYNadhGRxXrbjipk63Qz4CbRCr+c/5RvwIRJauB/gJvesY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169560; c=relaxed/simple;
	bh=HfXqG9FR9ZY3VxPmV7uO85SNmOqZQy5ebdfdPdaYOvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqyC93fWLtDZC3itvXOGzGYjtR5n7iTVkcgcpuCpxhebGQG90rqMSCEnvKvFRIezRoRXuZI03D4eXsqbLx36K7+518RH0OHcJUUr5qeECgcNHnHHj0vVkjxlmp/NsBU50lPwGrA6+j76UJ3afCGxnoTax7EzTU0S38nFwq9yNck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJ9djrsj; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw9oHbDw3k4iig6ceEM5mzCB53/yXQaWSkr4qnt17BBnKHmQEDwg9qUOG4tMzdNTgEf3g5ui0UEPzW8PLuummfsPEy1tN0wQ7B6AljFNEzMDUNLBKcdqM9vxIqHjo3KJOE7rH4M8uKqveVF9LqbD7YBJ3ApfTvup/RlGddTrfX4e6rkQN/262ATDZId8Uua0CTYrSxuB56EvCta7XvKwoi0O2b75vfwHiIUVfhYmerJZGhXNar52zU2D5JKX/ULXJjZrxP3Is7Adpomo7k8y9TFG6GoTnpMlJkQa4BZ4nJR+UtvNwGZBCNeNs46+Z5RMZ1nB6thq7iLysyCquKug5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGgNBkKHSmtNs2rUa3UFqeNM5+++KYSfyLuGb3JwSYU=;
 b=HiJyIjZfazIx17C7tlYJI945EAJ8qiM1qZdO18SUtLDAifAEdWXiW9DIk1lA/Q1gW+f5wvfyOnmChs5mXNDEtHX3zcN4ByE1A2wHNYiyK9PaMTW4m/AdzZ4iKHcfrOKsbObnwR6uridQAD3qsVoQuNxbHczLB0u4ClupndqAG9Y1pZuUS+P4fdjDhqO7pUBgDmrJzwC3oVJj0pLtnPalWyWilJcUOdJJCZVwsILdGAPZOsM2c3W1kEMsaQ/re3KRhJFwCLyIDh+/ucesEJbPye9Ly6VBHYByAc2FdngOGW+WR7pNrsen6rPgKEospegtPIb7wg6GQS8dbRCe54UQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGgNBkKHSmtNs2rUa3UFqeNM5+++KYSfyLuGb3JwSYU=;
 b=hJ9djrsjU7ftmCh6/Xe8uV2RWhy7A/wEgUjbOn1fBjkC3jMiIlGjo2R0B+uFpBoHpbUGnrCTcr4+olxEyIsnsW2bLYF1VN+Scg+ms2CjeZeFAri9uu3sV830Sj6ZOcKig1IacswYLPUQ5zIcW7gtkAOVq50JNOlX1+26FVdaQAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 11:59:15 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 11:59:15 +0000
Message-ID: <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
Date: Fri, 23 Jan 2026 11:59:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
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
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f11b55-461b-4cd4-c077-08de5a76d49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1QxNGxFTHJxNmZNVnlOSEpCMzZvQit6azZ1aXpvcEdacTZCUlNYM053aTZ2?=
 =?utf-8?B?aXRxSmxiU21paVVOMlBybFBjTEp3bmpUOTIvQm9ncDdlN0QwV1FGVFNqd29B?=
 =?utf-8?B?TndsaVNJbyt2dmdsT3JpZVZOYkxaSGRmWkFDYnV5NXdMenFCQmgxMEZmdDNI?=
 =?utf-8?B?Vzc3T1ZlbkpRcWsrVEFMbkNMN2FQMEt6cFUxRytDbGxPcjVxcE5qTFVVREwv?=
 =?utf-8?B?S2lWdEMwV3RxUTIyWDJSVW1zcWNwd0dJdGFDcVlxUGliUG5OTVRDM1MzTmpS?=
 =?utf-8?B?N3JSSEZvbkJpaFpneGpHVUJQb3dhLy81akg0eGJ2RkNSUTlZVGFYZGMvTi9E?=
 =?utf-8?B?M0YxWGZ0eUNPV0hZelZEeHNJKzBzbFhTUUhyZkFobUNXcG9nRHFtNzZCWnVh?=
 =?utf-8?B?aFFLSjFCYzN6VFRrWUIyM0xVR0E1cndtS01RSCtLRUc3YWlsbnBzY205R25C?=
 =?utf-8?B?LzJDUFV1dEFRbXJ6OFBrczZQMjhDWmlEd29Uam9pQnBzKzhLdFFmZC91K0I2?=
 =?utf-8?B?U2t1YlRoRWtqN1JKeW1maEJJcDgwN2R2T0ZWNFp0OUc2NjUvTjBKK2QycG9L?=
 =?utf-8?B?UlRWeEhiL1M0dkMySXVnTVNLUkdkbkpTeEFCRGhGZUx1VkpkTzloNEY4S0p3?=
 =?utf-8?B?cnd1d0JCSHZudUN4bzZnbGpJMGoyM3NkM0MvbjRzNnY4VnN3ZXQ3UmhLQXBk?=
 =?utf-8?B?cFd1UGw0V2Z3NGFjWVNrRXpvZ2xBdm1NcVBxYmduYm9jMGhISzh5dE5lQ0x0?=
 =?utf-8?B?N1JzcURQcldrRGlyZkV4djA3blNQWjdtUFlJaG1PVEEycEx0WUZ5UWRnclRn?=
 =?utf-8?B?dms2SERDZ2VTb0VBM1plZkxDUWpyRGtDRjZKU3B5V1QxOS90WUhwdHRRcExi?=
 =?utf-8?B?U3IvWUlHQUNLVlh1bDR5V3JnVGtIQnVvazFKMFo4Z2VqRWg4S1N5VlV6ZG9j?=
 =?utf-8?B?T0FWdEdLS3ZpQmhNbTZwbmt4Q2RqUUFiT3FMTThyL3dmT1ZpS200b1c4b2xK?=
 =?utf-8?B?NlVXVVRWYmg0ZExuZHZ5UzBhQWpjVG1FTkJYQVBub2hRUEt3NmMrMktYb0U4?=
 =?utf-8?B?SXNvUjhZNDVmSytXem1pTzZ3M3p4a3hwakpaSFJLNm5oZWRXYzhKcUlQUks2?=
 =?utf-8?B?ZVlTZXlobHZ6ZlNIZHBuQ3NpUTR1bmRBSGlEUHlLb0N1QmVud21ZVm9CUnZI?=
 =?utf-8?B?RnFVOTNpcmxQQzBkYnFTVVhxZmVVdXlwV1pFblNJMGY0ZUhZY2RQdnBXMERU?=
 =?utf-8?B?aDJpOFN1RzZnVWRib0tUejc3OFdXRGlNYkxMNW5OeHRxOHFkUFJHc3I3VlBn?=
 =?utf-8?B?Qy9CRm1HQ0xwTGhySmkrMjhleXRPM2NNODk1d2RyYU9zTWc1bnVVU1hoQjBW?=
 =?utf-8?B?V2Y0MmtTejFMRmZkVUlOSDNRWGJSYTM1T1htb1VTZFFrQTlhVlprdk5xYTVF?=
 =?utf-8?B?RTZVSjA0Q3lLUStTNjdyRXlReEI5WVdabzM2ZW1SVVFBWXZLc0pRT1dTWGQy?=
 =?utf-8?B?c3JnS3VWOUI0bjcvU0E3bW5rOURnWTZ2cUNXc05PcjNrUlFaUnZFajhKWkNI?=
 =?utf-8?B?TkdvcE04OCtSVy9XY09abmdUZUF0QUxheGpuMUZxOTZUaHlRVEJDZGMxRVAv?=
 =?utf-8?B?U2JRc2xvSHlQUlVTNFFONE5Tc1pjQWZ0UzJFY29xRkFCakVIZElyZHhXVUg4?=
 =?utf-8?B?M3FiaDZQdGlwNFJwdkJJeWQ4TWlqdHVRTUUyTFN3WEVyZGVYZG9RMXl2QmVP?=
 =?utf-8?B?RjJnbFM2NXZDNllROC9OTzNnL2gzY3BoUWdHditWNjI0TU1hV2g3L2Z3dnRE?=
 =?utf-8?B?a1lHYmFFcmtVc0tnZm9aYk04Y1NNU21QNFcwUjlRRkkza21ONUhrVUw2ektP?=
 =?utf-8?B?VkR6bXRRZkRHVVVDTW43ZVl3SUVZdnZIRGc2QUl1RW85TW5YdTEwQmh1Z1hm?=
 =?utf-8?B?UllGWmZRT2RNTXgwbTBVWWRNZVlZZHVvMkNZK01rb29jaE54a0pNY1VUcVla?=
 =?utf-8?B?aDVMTkZabytadHMxSGtOa2lQckJ6akJQZEJwclRYQU0rTDFwVTA3YmNoZy9W?=
 =?utf-8?B?VGF1UnZOb0R5b1laSUdGOG9YaGJWV01yZUR2aE1SbnhEVWxWSTFUaUhUZDZP?=
 =?utf-8?Q?YF5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhteC81dk4wWmw0ZzExbk5ra1lEMUhuNHlXVlNKY011MUFOR0tuL29JWXlG?=
 =?utf-8?B?dkhxM1ZyUk96cVpHckRRaEU5cEhuVEdiSW9wbVYxSk15WlRUbXpSRHQycmkv?=
 =?utf-8?B?NmxscnpUQmlubXpDOFg2Z0VFYlYxVDAvYVFBdG9kbmRFaFBIUFo4cE5tM1FE?=
 =?utf-8?B?TjhMb1dqQllWWXRYYno1K0UwNlJsWHpMUTNkSVRxam9ZaWxwYUhLTEVSZXkv?=
 =?utf-8?B?QUNaYlFXM3ZVMnBuOWhIUnF5VGhjaC9VcHhEY1pFQVQreEpVbWVraFM1NmR5?=
 =?utf-8?B?RlRwanJQQnVGeHJHbTVIZjFzL242T1J0Z0tZYUpBa0QxM2dzMTV1L2ZWT2pl?=
 =?utf-8?B?SlJITGtKU1Vvc0R6WnZleUlWNWlPODE2THh3KzcyZExESDlRRDBvaFlseHVD?=
 =?utf-8?B?eXNScTcvRjl3MFNpYXNZWXp1N2xoR2VvNmhxSGYyWHpBZFhqNHlpOHFBU2dk?=
 =?utf-8?B?V0c0NWEydTFVT0ZXbDUrMDRuWnZ0NjIyY2g2ZWx4a2hxTWNpRk5rNElRWVBy?=
 =?utf-8?B?czgwY3JXUkFUbDFEN0NVVkMzalVzZVNTV3NPUWhmUGUyYjRCREQyZyt5bUpl?=
 =?utf-8?B?UDFmSEVmNGkvYmk4Z1BzWWJUMWttL0drL0N3M2tzVGRPZy9uUmxnNG9UbTVx?=
 =?utf-8?B?TnBuNDcxeUJJQkxUWlhCcmprLzA4cEsyMzRPbkZCNWtLcUgvNkZTZlZXVE5r?=
 =?utf-8?B?MW5seCt1U0pUMHVGdkxDZ3l4ZDcweU9XNmo0ZDZCaE5IOG90aTd6ZTluaFlI?=
 =?utf-8?B?cUlBS25pVEhFOHlqQmR5MFJ5b2R5dHY2eG5QTnJNbXB6Sk9TMmp0SjkyMmRk?=
 =?utf-8?B?QThLYXZmTWRGdGVobEZBczhFaUFJQVBjcU12SWZGSDA4OHA1MXl1ZmlnZTB0?=
 =?utf-8?B?MDZXVytucDNDNnBqTmc5V3B4SHVyWkgxZEZMdXg0WFJPOSsyL3p5UWpMei9x?=
 =?utf-8?B?YTdDMDkxMDN6anV1RzFxbm9oMzE1WnFSMGVDdGlYQnBGdGtHRnZpWVpWcFRQ?=
 =?utf-8?B?cU1sdU1odGFTdjJTbGhUdm91ZW8zYUwzRENFakhxZmlsdEwrUkoxbVZ0Z3R1?=
 =?utf-8?B?dUhIbkdhY2x3eXZzVUl3NnV1MFVBbWxncHovc1VpWk8rUGQ4UEs3bHRUNGEy?=
 =?utf-8?B?V3NEWlpCcHBLSm03cVB4ZWxaWkFBdk1tSTUvM0dicEI1Z29nRDAzQllONFVk?=
 =?utf-8?B?QUpZTlBETGkwWEhyTTdXdmRiVWVnM045ZG5GUjY1MlRiblJsSHhQMkljaXVm?=
 =?utf-8?B?M0xpMXczZjJTMlhJSTJSSWQyV2hFMzJRQXdNcml2SW1WQjd4REJWNFdzS3pp?=
 =?utf-8?B?eUF3a1haZWtuQ3BuNzhuM3pCQk1YOXNEWTdXRTFpSEtRWHI1Q09YaHkyalVY?=
 =?utf-8?B?UWIvZUgrQ1ZqbDdpK0F1cHVqRU9YekRmUy9hUmx2ZWhCZXo3MVFZaEllOHRw?=
 =?utf-8?B?bFNZNWFnYTdESVBaTGloL0M2K3hGOTR3b3FBRDdlYU1pN0srL0xJZDRMZ2c2?=
 =?utf-8?B?YmlEOC84UEpNZUpRTmd2MlMwUzkvbFRKTDJPUjRMVE0yZ0RlV1dRM21zVytC?=
 =?utf-8?B?allhYVJQZkZxZDVTWTZrY1c3Q3FKSlBoSEdVVW9WQW53SUNUeElZTTNVcjNu?=
 =?utf-8?B?N0RUZ2pDQTVRTWZCMnlPV3hjT2Z5RC8xSnprK0lXdUVSVXNVZXE1dG5PZS9W?=
 =?utf-8?B?aWw3Tm9iZXdvQnNDYTJwTUtJcU45TTdZM3QvMGIyeXE1NnV4NkllY2dnQ3ZG?=
 =?utf-8?B?TnBPZUNWS2Z2eW9WNGl6eGN1UXhseFFWWEh5TmF2WmhLdkttYllSbFZoc3ky?=
 =?utf-8?B?QlIzaVk1WUVDcTlTclVkWm5uYjBXNk9KMzFXYjMvMUdwSGJOOHVKK1ErRjEz?=
 =?utf-8?B?VTlUTXVlR2UwTWtWMGNQWW00N3lDVTF6YXYyQndYcFRoOFlwZjdlbVhibVBV?=
 =?utf-8?B?VEtoTmc4V1VJcUNETDBtdDdSanVRVTFiUXppd1hCMFAyR0hMdnloaFY2WGpH?=
 =?utf-8?B?bi9TSWJDcEhyY0EvSi9GWFlGSE8rVEd0QlVBazdmclpaWnNhdG1pbTVSU0w2?=
 =?utf-8?B?dlBHdzczRWdhZWhCYUNtaTJBK21LTDNlbHY4aHgxRGdQOE9HQkFiVDdJYktF?=
 =?utf-8?B?aFZoNS9CV2hxL0d6TmsyVVRVVUVvT2dlcDN2VVA1ZDd6dFViY2k4MUpVRE0w?=
 =?utf-8?B?NEFXOXNuSXF1OWJWdjR6T0pxa29CbldNcTR4NzFycmdLWThtQW9lUDQ2aTlU?=
 =?utf-8?B?bWxucStwNUJGUjVHVGhocG9DZW5RT0xraHJmcStjS0RJZnowYkI4NTVVTFdx?=
 =?utf-8?B?cWlxNHR5cGtQSTNLUm9yM29yZURaK0huSFhsLytlYlhQa0FFTWRtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f11b55-461b-4cd4-c077-08de5a76d49b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:59:15.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ0WrCtOZbwHjQnNOerlCsd+ZK6o4LY62S5RInLXQlzZ/Qgn5hcvNCBogFee6rucbOfHxnmvJmLr+nckNP1yLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75269-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98C4E75785
X-Rspamd-Action: no action


On 1/22/26 04:55, Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
>
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows at probe time by scheduling deferred work from
> dax_hmem and waiting for the CXL stack to complete enumeration and region
> assembly before deciding ownership.
>
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
>
>     - If all Soft Reserved ranges are fully contained within committed CXL
>       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>       dax_cxl to bind.
>
>     - If any Soft Reserved range is not fully claimed by committed CXL
>       region, tear down all CXL regions and REGISTER the Soft Reserved
>       ranges with dax_hmem instead.


I was not sure if I was understanding this properly, but after looking 
at the code I think I do ... but then I do not understand the reason 
behind. If I'm right, there could be two devices and therefore different 
soft reserved ranges, with one getting an automatic cxl region for all 
the range and the other without that, and the outcome would be the first 
one getting its region removed and added to hmem. Maybe I'm missing 
something obvious but, why? If there is a good reason, I think it should 
be documented in the commit and somewhere else.


I have also problems understanding the concurrency when handling the 
global dax_cxl_mode variable. It is modified inside process_defer_work() 
which I think can have different instances for different devices 
executed concurrently in different cores/workers (the system_wq used is 
not ordered). If I'm right race conditions are likely.


>
> While ownership resolution is pending, gate dax_cxl probing to avoid
> binding prematurely.
>
> This enforces a strict ownership. Either CXL fully claims the Soft
> Reserved ranges or it relinquishes it entirely.
>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>   drivers/cxl/core/region.c | 25 ++++++++++++
>   drivers/cxl/cxl.h         |  2 +
>   drivers/dax/cxl.c         |  9 +++++
>   drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 115 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9827a6dd3187..6c22a2d4abbb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>   			 cxl_region_debugfs_poison_clear, "%llx\n");
>   
> +static int cxl_region_teardown_cb(struct device *dev, void *data)
> +{
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +
> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +
> +	return 0;
> +}
> +
> +void cxl_region_teardown_all(void)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
> +}
> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
> +
>   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>   {
>   	struct resource *res = data;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b0ff6b65ea0b..1864d35d5f69 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>   bool cxl_region_contains_soft_reserve(const struct resource *res);
> +void cxl_region_teardown_all(void);
>   #else
>   static inline bool is_cxl_pmem_region(struct device *dev)
>   {
> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>   {
>   	return false;
>   }
> +static inline void cxl_region_teardown_all(void) { }
>   #endif
>   
>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..b7e90d6dd888 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>   	struct dax_region *dax_region;
>   	struct dev_dax_data data;
>   
> +	switch (dax_cxl_mode) {
> +	case DAX_CXL_MODE_DEFER:
> +		return -EPROBE_DEFER;
> +	case DAX_CXL_MODE_REGISTER:
> +		return -ENODEV;
> +	case DAX_CXL_MODE_DROP:
> +		break;
> +	}
> +
>   	if (nid == NUMA_NO_NODE)
>   		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>   
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1e3424358490..bcb57d8678d7 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>   #include <linux/memregion.h>
>   #include <linux/module.h>
>   #include <linux/dax.h>
> +#include "../../cxl/cxl.h"
>   #include "../bus.h"
>   
>   static bool region_idle;
> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>   	platform_device_unregister(pdev);
>   }
>   
> +struct dax_defer_work {
> +	struct platform_device *pdev;
> +	struct work_struct work;
> +};
> +
>   static int hmem_register_device(struct device *host, int target_nid,
>   				const struct resource *res)
>   {
> +	struct dax_defer_work *work = dev_get_drvdata(host);
>   	struct platform_device *pdev;
>   	struct memregion_info info;
>   	long id;
> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>   	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>   			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			schedule_work(&work->work);
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
> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
>   	return rc;
>   }
>   
> +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
> +				     const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (!cxl_region_contains_soft_reserve(res))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		rc = bus_rescan_devices(&cxl_bus_type);
> +		if (rc)
> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +		cxl_region_teardown_all();
> +	}
> +
> +	walk_hmem_resources(&pdev->dev, hmem_register_device);
> +}
> +
> +static void kill_defer_work(void *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +
> +	cancel_work_sync(&work->work);
> +	kfree(work);
> +}
> +
>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>   {
> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	int rc;
> +
> +	if (!work)
> +		return -ENOMEM;
> +
> +	work->pdev = pdev;
> +	INIT_WORK(&work->work, process_defer_work);
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> +	if (rc)
> +		return rc;
> +
> +	platform_set_drvdata(pdev, work);
> +
>   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>   }
>   
> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Intel Corporation");
> +MODULE_IMPORT_NS("CXL");

