Return-Path: <linux-fsdevel+bounces-77056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGAJJ+sxjmkxAwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 21:02:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F18F130D58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10ED30A54B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2692DEA95;
	Thu, 12 Feb 2026 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YuX3HOU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72C41760;
	Thu, 12 Feb 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926540; cv=fail; b=tvmveqGGaa5dh1BkVnxE2+xqZ46pjphtFiBC9cmhxPp4Lm7s+zwTRoiPcY4rzZNHpgLGFZdCeM213c7inHvC5WllMha4K9hxBlEoW9hvi2YCJj/bVhwo81nH6yi2HzK1J4tHoWT+gOje8YilkZ0wYDvfPaY8iC2WAhTqO07SNCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926540; c=relaxed/simple;
	bh=Yh86IIc9kwu7kvTaj3r42Fdrmfs57aXeTt79lHuJycU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gyVlguqJAVSW6z6AzOH1VuFtxvWFb9Zw4vBJ/P8gbLXvtC7bg/0GkM+jMwL1Nv4MUJQMaQhoSReAof2MfUJL6vCALB3PQtZbGORXJD/Qna/QJUVgWsBtDrYHv9apGG3Yr4E5PJi2NPxwanHFIk0uAVZryWOdbEj0r0gi5NPi0wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YuX3HOU3; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jozCjxdMevgHNgQCwt47DX+eErn7gErVEmBBvRGJMXiliChDHB5gi7QFa+T0M6Wft9jeWxVK2mNKKhV/UYk52oR3Iz7qxAIp/GWrsIHbRbdKaoc8Y1+xeRJGFgsdiEW9XTCnoIOUV8rL6vzE2C2lASQIsYChdoBzySsv9MKrpHPJ4g9xX4GZ4OYJnv+QbJfsz+qt6dodob+8xaxMgKkLptqtNtGXgl/A+WsIjFjSYELM9F3wvJ7XQDnub9lFQmaC7FYaS/qHLjucjb0nCMnH2a27g325Mso5kca/UUI2M3s3lIukzD1d6/gAZ6cqPURJ+L/2aPV527WPHjSRt4b/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxLDjIk1NlfB8QYhMnY52ItfjG0wTobcYh9zxQ07oLA=;
 b=Rt/ONaLhLXmt+C86aEFdak6DVieDiSn3d989nmdDfUWqVEIyhBke2Tt/jv0mgFFuS8AKM2FsKFMXJnkL0jfi6C8FkNueIefm03qdOSY9Em0cdXv9Q4g7ZagubrOI2nCMma91qdtckjZZrajfuZAiGFl0jOl0d1fCgBwlAZWbMwkNjxbOLrVaDNWFrNWw0fkGYGKgbx3rzRrrkDlBP3770UnIBpez0vP3ZOTPHs/8gfzwB1vbSti9JTr5EeZtpo3cGiavxzJsykYTjGkYygjiQvDhU6PC5TZJKky030ovI22cXUzowOGjSCTFh6IUp8ml8tnEU4U+KZIkJO+OeLt2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxLDjIk1NlfB8QYhMnY52ItfjG0wTobcYh9zxQ07oLA=;
 b=YuX3HOU3U4CYKE4P4LMEtsnZkq3FmIaSumn/ZPQqDSTudZTvxpYI+FPalr8YyTpPDIicfPwHKBm2GvxBU/ZtFhVDAmmf6B1+76R/G26RvDDodyMLN+T1/fM0x6md9PXraG5UhfuQcluYN9VjuEwaNpstTB7oTwHW9xFIVOZY56A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 20:02:15 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 20:02:14 +0000
Message-ID: <4e83f2d4-6d6c-48b9-9abe-b9233d6ebf82@amd.com>
Date: Thu, 12 Feb 2026 12:02:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-dev] [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft
 Reserved handling with CXL and HMEM
To: sos-linux-dev <sos-linux-dev@mailman-svr.amd.com>,
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
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e033f93-2a32-47a0-9b6c-08de6a719dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVRMdXhEaWtWZVBYUWlPdlRlV3BxejhBUzFYem1leEZlR3JCaWxNdVlmcGVi?=
 =?utf-8?B?WWZmV0FSVDlDZ1dCZFhiYlpZSHRBV3l3UlZTQ1FFRVhET3NlN25GMjZscHNO?=
 =?utf-8?B?aGJjeTZ1Y05jbE85SjhkR1lyNUY5azNhMHJyclVxd0RUTWtIQzV4bUNpbDRr?=
 =?utf-8?B?V3ZiT0FjRE1CeFhrTDBnSWV6V0UweFlWSmVqbk9YYVp1NXdmb2xnbmdYTlBi?=
 =?utf-8?B?NGExNGRUS2pDZ3MvMHhNRGk1cVkrTHNERXkxUDRCYXM1MkJPZnZuNmRYOUdJ?=
 =?utf-8?B?NktLR1liOHdDN1RCdHluUlN1Nzc5QnBxbHhuWmw2UWNJZlkrbW5Cb0FoY2tM?=
 =?utf-8?B?VFAxd0tVbTliRDI4WnNGZ1JMN0pLVEtKcHBqVG9mYkZNd1M4bUNtWFNiTTdS?=
 =?utf-8?B?Zm5mT0p6SHYvTW9WRjB1UzVocFlBNjNSWkFiWGpLM0IvK0QybHNTSHp6bTRl?=
 =?utf-8?B?aCtYcXo5QWJMNkcrV3dmNkpFdVh1Tm1HMUMyRFNtbG5aMlhmT2Jta0xDSGVu?=
 =?utf-8?B?cmIzMXc4aC9mS25HcnRFMksrdEJUNFI5aGVUWEVCZXhDRTAxeTA0TnNnd0FS?=
 =?utf-8?B?LzdQaDBaVEZaN2tTK1c5QThyeitmQ3QrUXlBc0FDdmhwdFIxWElnQkd0RU9a?=
 =?utf-8?B?eURDVDFleHg3aUJwQWtnV1FGNUE4TnJlSmRWTUtkVEphdHRPRG9RRXZwSmk3?=
 =?utf-8?B?SW1OL0dUWnE2aG1sMGJkVFhMUy9oam9NVElYdW9tdzN0M2p2WlNMUERiZTVY?=
 =?utf-8?B?aDNObmY2dGh1ZnAwNTdLcSt4S1dhaWpQd1JpWFg3b09lWnVXS05EUEJLTEc0?=
 =?utf-8?B?S0RHZ2loV01aSWFzdUJOU20zb0JmZjluME1wY3lqQzNrZ29YbW9KdnFUdytj?=
 =?utf-8?B?QWR2UWZqN0d0L0hya2VkWkdhN0lmOVVEaVRPZlNxZUpMdlZDSm90MzljR3Bs?=
 =?utf-8?B?cHhTT0c0cnAwM1hYdG12VGRRSjRIaS90ckNsYnZJWnUwa042djRseXB3Rm5R?=
 =?utf-8?B?Ymtxd0I5Qmo0OEdRVnB3NnFrRUQ5SjF5c1M5bzhkNVNxcVV0UzVLbzNwYTJJ?=
 =?utf-8?B?bnFkenBjUFMxT2lZc2lOelFXUExsTXVLY2FKakRzQ1RBMGtkTGFzenR1aUhi?=
 =?utf-8?B?QlNpS0FlY3lpbEhITWdZNEN3N3o1cDlHQk10VlU3V0xJb1JMVGkxNE1zOFIw?=
 =?utf-8?B?d1l4bEhvL2V1NXQxZDJlMEJMTE5aOXM1WHBrNkdTTmlZSDFZck1qaktmNzRj?=
 =?utf-8?B?eWc3c3BER0dEVTZHbTBDcnNLR0RrSElnZ3k0RjE4VkQ4b1g5SDdJVVFDZE1p?=
 =?utf-8?B?NmduTkx3QVdpalNtWkRPSzM0YTlRSWpZYlRoam9OU25vaVFYN3loNkJQb0tk?=
 =?utf-8?B?R3lPOE1RN05KNDlHYVN4UEtVN3BIK2Rwa09tRm95ZFI1RW94enZXVWVrNUdH?=
 =?utf-8?B?SnZWM3dpQW4wNzVGc3dXd1lZUHJPRi9iR3JWYTRjZ2RWOVhhcllhdVd0NVdE?=
 =?utf-8?B?MDV6T29EZ2h6akZYVkZTT0N6NkR2emJuRlQrRnVEbFlQUHdtVGc4eEEvL3B6?=
 =?utf-8?B?aEE0VzVabFZWTFp0TU02NHZ2b1VncEdaZXVjWG5sU1dDZFNiNzR5S1JlMG53?=
 =?utf-8?B?MUZnV0o5VkZZNjRIck5MWUZuUEJ4RzFWTi8zVGQ2cHNMc1hDUHdLU1piTGxL?=
 =?utf-8?B?eEw3VEVqM3pQNlh0SEJLaUdmcTBmMjU4cDNPcjhrVnQrN1VMMUNOWFRZZ1hu?=
 =?utf-8?B?UGdYMUprd2dkcFVreERzV0JmbHFub3F1RERSRnVoNzJGK2F4clptQUozYWcw?=
 =?utf-8?B?SVBNOGtKd3hZNE0wKzMzRUhINnkvcEFSSXFJTUdZVU9UcDc4S3RXbURCZWdu?=
 =?utf-8?B?SlFQbFp3S3lNVHpTVFBsaE8relpnVWZsUml5RWVJQncxTTl3Q0xXY2h2ekRK?=
 =?utf-8?B?QW96RXVsazFybHFnSWlNb3pCSUFZYjZrV1V6Z0FFcHNSVFNOVHorN1pmWUNn?=
 =?utf-8?B?eGpGQms2QldjT1RNOVNhMTV3VnI1MGlaWGtkN3J1cGVtNGw0T0lLdUpiVkpy?=
 =?utf-8?B?K1hENkxYbFNheXRZcVExM1VHU1N1UUdZODlkZ2xmWUp5M1pveDJIcUZFSnhX?=
 =?utf-8?Q?CY6/jJln7ZUCi/UOYMhgmwULQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGZWV281MEpTWVZIUDBLaVhrMXlnTFZFMzh4M0x3Um5nN1dGbmZ6VTlDU2Zz?=
 =?utf-8?B?SjUxK3pkZVhMQWpoMEFmTkdGV29Pblk3S3ZvVWNjT0EyME83TzVYd3dmaG1R?=
 =?utf-8?B?VWNKMFZpcTI1KzNCRkxPU2w1cHJrNEhLS0VaYU5YamwrLytBRWRLRnNFUDg3?=
 =?utf-8?B?dm41N1oyekIwa3RRZFcrdHJ0ZGpYUmVQNlZDQi9EMUpsVTVYL1RVQm10Qkd2?=
 =?utf-8?B?M0R3d3BhNU11cXpzQ0ZWUUJyellOTTJ3M2tES2twLy80S1orc0xjUG51UjJq?=
 =?utf-8?B?VkVuZjFPclkvaWdSRFZWVGFSM1JheWFQeFl1UTBQMXIrQ0hDYjM5WUtUZTRM?=
 =?utf-8?B?TDlucGk3c3pvTnFuQndjSjc1cVY1Nnh5ckNsVFMvTGgzTWFqY0tUeks5bnBq?=
 =?utf-8?B?bVNyS0w3M1ArWTF4WFBFVHlWVnNsdk96a3FkUElMMmtvQkdXdTNEOFNPVTRs?=
 =?utf-8?B?QnQvOEhvSmwwTktjTjFXZ2NURkhDYndLcUl5N2tYeDdOcFg1WVRpWWF6ZC9I?=
 =?utf-8?B?dHlrRmZlMTkvS0Q3V0Y5L3paSWJXN1gwWE9zKzN3MDVNL0FTYnIyNUtGZThN?=
 =?utf-8?B?TjdDT0s0dlIxUDgyek13RXZFNWQzbkNiazhlOVk0MWxZZExqY3JZS3BXcWhk?=
 =?utf-8?B?blh0VHNlRitnYVBKcURjTXhsWnlieFN0bHM1VFI5V2FvQ3ZIYTc4K1kvUElk?=
 =?utf-8?B?NGN1Q212dmhZcnBXOW5WRmN0U3pxeVlQK2JaMjZOdnhLdEtXODZJUHUwbUh6?=
 =?utf-8?B?Zk1ybUVWdll5NUo2SGNBVTZlTWJVN3ZJMDVYTWcrdHV3eGxFblFyaVlQSWdR?=
 =?utf-8?B?bFJMUk0wZWNnNTZQeEdmMEtYT1IwOTErN3BDQVhGaGwwSlJLNHZzeFQ0dndK?=
 =?utf-8?B?NVZXbDhFckFacDFURjg1UzVHWDl2NVgrazBNdjdtWjJRb0xVYXBIaWk0Uy9s?=
 =?utf-8?B?b1pTSldNbWVjNU13LzdWOTlMMkZ4Z2c3L2tGM1RCNDRmeFAvWFBQK2NqY2FH?=
 =?utf-8?B?N1lOcW5XOVdkRzg0dzhrTUhrNWZBNkhkaXZYdHM5aTZaTkpUZFZKRVZVUEhi?=
 =?utf-8?B?QnNYNyt5eFNnaFJpTk5KL3ZUaGdQVElOV1lLaWhBbHl2OXZBYWJ1VEZseWNM?=
 =?utf-8?B?ZmlVUGNXTDd6bXA5SE9GeEV2MUdHZVR4UnNhZnlYNHpPOGwxNGFZanEvK1Aw?=
 =?utf-8?B?WkV4VGJQK1ZWRVJQSGw0ZWRSZzllNTZUcTBaRFpyYzZpUWlXRUZUQzlVVGh6?=
 =?utf-8?B?dGxVYWNJM0Q3cE1HOE4vNERzdkhZWHFoOFErcmhDbWh0bERlTnQyRWF6WXl0?=
 =?utf-8?B?cTZNS3R5QTNSSVh5SHdQTHd1ei9MNFJ0Ymx2VVdrN0RlMFd5RUtrT1BSU1VI?=
 =?utf-8?B?U3I4SGNxem85V2VJNHdIT0d0SnRmRXFTeFJFUmZHMGdXWWNNcy9yczJ2Z3hQ?=
 =?utf-8?B?TklpZDAyWTNlaEdyVEVLU2ZRYXJDVVJ2aGtEakk0UTd1Z1FGa3loc2VHRUVO?=
 =?utf-8?B?bWdiV0pIbnZmUzgwS2t3TWd0bk9XY1MwTVlBVmFId0ZudTR4M3dmS2w1dXNP?=
 =?utf-8?B?bjJncG5TQkQ3d2ZJNHRKQkgzRFFYNDlpL0FmcUxVRkRxNVFzcWZ5bWZmSFg3?=
 =?utf-8?B?OVVYS2xUN3F1TjZjY0tlTHZjMVV4My9YVXR4M25za2lMeGIyMkZKZU9FNjJT?=
 =?utf-8?B?b1NUSVAyaU8xV3BHMFFYVUhpd3NidWF2dEVZNWhFNWs3NmFwd3ZkQ3VWSUxl?=
 =?utf-8?B?WHdXU0x1VHRxV0xaUjlzYkxTV1ZOL2hCRWlLQW5QQjVjRVJscHRBaUpnWGJo?=
 =?utf-8?B?OHlZQ3RtZlJaaUNsRFRvWDhWL3RjYXBqL2dSVytEL0h1dHBmYjA1Q1RTQnha?=
 =?utf-8?B?NWhta3k2QUNCOGtHMkJiYytrODZJWkVuZjd3aDlOQjZuYURNVmV4UFdsUGQ3?=
 =?utf-8?B?T2lDa0l2U1VkZWFZUnpRWGEzTU9qTVkxU2d6MkphMFJ6eUFLSFV0YmNGVEQw?=
 =?utf-8?B?M2xxeWVYZTdzaHFkZVNyTnY2OVZjMkEwL29udnptWlJnRnlDd2xLb0p3VjBK?=
 =?utf-8?B?OUJJemsrdXdmcG5GOXM4OTUrdWhacThSU09qbW93WDhOdE1OTytyQUgyNHgx?=
 =?utf-8?B?OTQrazRVUUNxblVzRFVTUTNCbEI0S0JzUHNrWTJVZWxWUEdHOHlPaE5IYzBP?=
 =?utf-8?B?ZnVSRWJORmEydVpGTjJJOU8vSnh1S1RzYmplaWxlRjNaOUZnWGRRb0tmT3VI?=
 =?utf-8?B?TVVwemJyMit6Qk93Mmd5cmRNTHVMV080eFp4cXo2NDM4b3Fad2NGaFJIOGw4?=
 =?utf-8?B?QkRTRU1hUTdSeTcySGY1U0NWSDFQSE8ybE0zME9EUEUzMnpNYldUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e033f93-2a32-47a0-9b6c-08de6a719dc5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 20:02:14.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhNFAlkTgcN7N+4BUUPQCE/kLTSvdbQppDWpzIHjw8a0Tzixfi0ihd70uj4kWL/oL8c+YRv8ggFsPkT0RbZ65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77056-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 3F18F130D58
X-Rspamd-Action: no action


On 2/9/2026 10:44 PM, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between HMEM and
> CXL when handling Soft Reserved memory ranges.
> 
> Reworked from Dan's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
> 
> Previous work:
> https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> 
> Link to v5:
> https://lore.kernel.org/all/20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com
> 
> The series is based on branch "for-7.0/cxl-init" and base-commit is
> base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1
> 

[snip]..

> [5] When CXL_BUS = m (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = m),
> DAX_CXL = m and DAX_HMEM = y the results are as expected. To validate the

Typo here, this is DAX_HMEM = m. Rest all looks good.

Thanks
Smita.


> REGISTER path, I forced REGISTER even in cases where SR completely
> overlaps the CXL region as I did not have access to a system where the
> CXL region range is smaller than the SR range.
> 
> 850000000-284fffffff : Soft Reserved
>    850000000-284fffffff : CXL Window 0
>      850000000-280fffffff : region0
>        850000000-284fffffff : dax6.0
>          850000000-284fffffff : System RAM (kmem)
> 
> "path":"\/platform\/hmem.6",
> "id":6,
> "size":"128.00 GiB (137.44 GB)",
> "align":2097152
> 
> [   30.897665] devm_cxl_add_dax_region: cxl_region region0: region0:
> register dax_region0
> [   30.921015] hmem: hmem_platform probe started.
> [   31.017946] hmem_platform hmem_platform.0: Soft Reserved not fully
> contained in CXL; using HMEM
> [   31.056310] alloc_dev_dax_range:  dax6.0: alloc range[0]:
> 0x0000000850000000:0x000000284fffffff
> [   34.781516] cxl-dax: cxl_dax_region_init()
> [   34.781522] cxl-dax: registering driver.
> [   34.781523] cxl-dax: dax_hmem work flushed.
> [   34.781549] alloc_dax_region: cxl_dax_region dax_region0: dax_region
> resource conflict for [mem 0x850000000-0x284fffffff]
> [   34.781552] cxl_bus_probe: cxl_dax_region dax_region0: probe: -12
> [   34.781554] cxl_dax_region dax_region0: probe with driver cxl_dax_region
> failed with error -12
> 
[snip]



