Return-Path: <linux-fsdevel+bounces-77825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK4ICmnImGngMAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:47:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1B16ABC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F191E3007526
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90468314A78;
	Fri, 20 Feb 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f3M4Ian8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153BD2FFFA5;
	Fri, 20 Feb 2026 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620453; cv=fail; b=uEIO3OTEF8YSKS7vbqlsi0zS1uWcHb8Jl/BVLlXtnf+AD0yLLg5Wh03P7lYxsYsD+bGTPpWK1gJrCLQ6rnPYsWRX9dkAfm9LjHQOaWZS4bOoAPso2xnUXOO7Om0sBGoLPs1ZB2yXSXL34D8e3sOmuk4AylR0Aq5FEipPGqjTmfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620453; c=relaxed/simple;
	bh=Ikt+fU1R9uJIKPClfACFDYB0+B+vVmw8U0uXLoqacpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1J/EUFIyqi4RB5SYkfnB/NqB4u6vnhaVVLs3MZKWQ8B4wtgaw+ZAcQ50XYsSbtgZxKwsCgz+A+WPc+I1/5APBVEmUsrNTC1irGcLNqXC975Hui6r0kszIzwQcm2lga5FAFFu324BIdDYfdO4KSLf5HPUKOrPb4vcG7xbN/LUcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f3M4Ian8; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVpA+vovb8HaTioit/ihocmTxkIJp5t6nizoIsGu3b1Y3y5Szc3q/bHChPjol+OW9VysT4Cd3h3cWEuYlBNsueKB7bHCHw8+rkkU0Ah5G2QLg0+84uKN1Guy+yh7fPXDvOVqxpxA2eYYHqWG8CLxQKnTxB/6Qq3s5iIFFq60kDJsyJ7GBE6EyOE4pNCtsGzbJDgU5i7EwAQAtkEG1yHzM+zyvCV73Av9HaDujBCOTQ5N9zVdOc3u12pYg+0CzjCoSL6XFhOYAxqjnTJ8eriFIQvNz5O5I6NjlRmWMGJ3mlfTUino37PiRsr77YlBthVqTsS/vBLbtf7xjFu5edSctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbgnF+Rc87/uoPK2xCVKwLg05B0SC64VJmsn1l8Jgi8=;
 b=CLwd8uYuwFODaCSpFn/RvBDE1TMP50Wrb98blwqbjQds/tU9XUaXAPMDRFgw5DRPV5k/Y/PU0h9RNuGc9M53jSnc4AA31NExEQrZkmxpPw+9NpyUie1mm1toGdCyA8n4hWHtK74lfSajTBbrTXULv5BRkBxNKMtVWN/dYWDpd8P6mWcPLkGLMocZcd7EEPRcaxHvutWRUnl2b9MeorkXyB3+XcFrQUi4EcCCgbEWdCRyRfPzgEdWsnW5/CIjbFlVZ9HYvkt5dd0Kc/63HCjJAzOEzwBy0+2MU16iTwvjam4UAYqJtRX5Zue+jFpeAtULEmZ+sKxB1O77nHLug+uC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbgnF+Rc87/uoPK2xCVKwLg05B0SC64VJmsn1l8Jgi8=;
 b=f3M4Ian8to30cYyUAymmB394EUeWa7RMGlJsNlLm/Hy3jTl0JPx/tVN15oelU0UGQ9WBtyvShzz4Tv6w0tHp5u57i8fjno2YihApdjLFqb+6qVrLK9xmkKclfHrW9a2Ovv5Lz9tlP5kN6etBoBXrUMiim1U+fdxC+X4bQPHqPH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:47:28 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 20:47:28 +0000
Message-ID: <75f2f90e-9bc5-46ce-be4b-a5226296683e@amd.com>
Date: Fri, 20 Feb 2026 12:47:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
To: Gregory Price <gourry@gourry.net>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
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
 <aY8vf75vVQ-poVBN@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aY8vf75vVQ-poVBN@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:40::39) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: a63c4dc5-d124-4627-2631-08de70c1429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHVDUE1SNGZtanJEZzNycnhBZTMwVlJvNHJXYlp0UmsxREIzZUU3dEp0RDVr?=
 =?utf-8?B?Yi9XN3JJT1BkUGZ4cHI3UUFoekdRN1VDeUNyRGprdURObENMNGJZUkdhN2dl?=
 =?utf-8?B?bXlWWnJndmdBUEFFT1gwK09YYkExNmZkcGhDSXBQa2JUNTU4QTJQV2I1OVQz?=
 =?utf-8?B?SnQvcXRCb3UvRjI2eU9ROGs3eXEyZjNVODFvd1d6RUlLcWlLcWMweEhNQlho?=
 =?utf-8?B?ZTlGUnNjZStTQlQwdnl4SkZQZy9FUlp4MWJyVDhPY2RrSVBMWEN5ZGJzQ2ZR?=
 =?utf-8?B?bU5ScmZXRTdLRjgrWG5BNHNQYUJDU3ZIWEtRWFpIMjZZd1laVEJZNU80eUZa?=
 =?utf-8?B?K1drNWk1a3dJTjFBMklCS29mTHhPSTJreEh4bWphQ3FVSnBOZW1EYTNhSlcz?=
 =?utf-8?B?S3JJcmpUSWNCa1M2Ti8zQVJWa3VTeGNRdEJBS05ra3dCRVZVV24rYk41OUpM?=
 =?utf-8?B?OGJIV1hCd09JTDF3bUhLcm9QWTRvMzhzQ0lMTEMyS3ZIb3FOUlUwUFNKeDdt?=
 =?utf-8?B?bVk2UXZIakovKzZKbXA4ZkVkaFRRM0Z1ZllBSmVCV21JdUJsajhQU2tzSW1N?=
 =?utf-8?B?Ti9mNjBrc1lRajQrV3BvMFF6bUZmMU8vMVREMzZWYVRUZDlSamNFZjgySFRm?=
 =?utf-8?B?eXFvK0UxT2lhbWhIYU9wdTlOaTliTDNVN1JWcDVKbTdTSDVqREdCNC9ud0lZ?=
 =?utf-8?B?T3JVVjJ5TU9QS2lYZkQzUnV6WWxIaFVKZVMxNjhNdGVHc29tS01meERudWdX?=
 =?utf-8?B?SU91QncvRjFSMUgwSGZnc0lsck9Gc3IxeDZxV0FaS3A2dHJleFcwNFVCdW85?=
 =?utf-8?B?dkZYdGJITHBkQStsWE5DTWt1M255NTBEQjJkVUIvUEljQ1Z3ZXRXSXJoeWcv?=
 =?utf-8?B?Yy9udEVYcExVNGFiYjBRVmVkOHIwOXN6KzN1Q1RFU1JVcEl2czVscFJKK1dy?=
 =?utf-8?B?aXNMWDRIUWZ5ZSt5L3h5Zk9NY1lCb25EbklaZW4rWHE3MjBkdWo3Q0EzTURa?=
 =?utf-8?B?dGQ4Wjh3UHl4c1hkVU10My9NcEwySjdORkNpOWtITGNxaG1tU25IbzM1TDVE?=
 =?utf-8?B?N1Q1c2VBeHV3ZjBVdHNzb3JxU3hpWVlYdkUxM082UGRSa2JGUURiZkpkbGxl?=
 =?utf-8?B?ZzFUWmhsbjVFL1cxTmdQVlZyQmdDMU94c3VLM05BaFJJbnpNUkJmOWQyS1dJ?=
 =?utf-8?B?U3VtQ3p6dHJTQVN0elNGZC9YQ0JoMysybzVEVURJQnY0aTZkZ1BOYWthcVAy?=
 =?utf-8?B?VGdvYk1YOW5yVjMvTEhWWFNGVy9nU0ZxRlRsT285VWltMXJHNHBKZ1djWks1?=
 =?utf-8?B?M2o4cnBkRkpCRDNwZEgxMUNSandRcVlTQ0dPOWUrM3JiaGZKZlluNEVnNlNM?=
 =?utf-8?B?OVB3ajhqQUJBdGhuOVJlUERhdVZVeE52a2h5M2VsZ1FZc0ZidnJrSHl6c2dl?=
 =?utf-8?B?VE9BNHlESmJsVit4azNQczVYZlpYMWFxMXp1V0N1eVhsdzFlQWZKUmZBNTVp?=
 =?utf-8?B?bEZPSGhzZzJqYmRybUIrbTBYWStlVmxsL0t3NlFheG8rQ1p4dEd1azg4Njg0?=
 =?utf-8?B?M2Jmclp4UDQ4cFhybXMwUWZVb1hXa2QyR0RGdnc4V2dLbWpnWXIvQi80RTFM?=
 =?utf-8?B?WkpDQUtRM21iaGxhM01ZMzRZaCtPcTVjRWlqeGFvaEplRzVwNHdSVXlKeDRp?=
 =?utf-8?B?VWFNSmY4NUE5OVJqMkpZOTVDU25sUlhUZ1BaSStuZHBsT3JLQjkyRXN2L3JC?=
 =?utf-8?B?QnV6ODV5SzNBc20vSGQwZERIc0NuTDN3VzR5RzNWVDgrMEtuNlNrVFVRODE5?=
 =?utf-8?B?QzIxeHBMbEdsQ0Q1cnk2c2xrMGdVN2tzRlExajg0Znc5Mnc4azN3R0xkaTFV?=
 =?utf-8?B?VHErVWxLeTZ3UkVpeVNXam5MekF5Z3d2RnRrdmFXRGZJYVN4SjlrMDcwYmQx?=
 =?utf-8?B?U2x2UHV2QU5qVlQzVUdqNWVDendSNmtJMzloRDI3WHpTTk45RVJDekhhQlMr?=
 =?utf-8?B?dWNUQWRwZzl4Y1RaU3h2ajF4ZjBWUHZIblFXUFdtTGFFWlMrNksyWkZ5TE5q?=
 =?utf-8?B?QU9NTklvTThNL1dNekcxUzhjSzJ2OU5FUGtMTi9vYkl6L21mMDVvTFVGdTlk?=
 =?utf-8?Q?LAbw8ETt0ZKt1K+wSRxdkaF1w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cENLaEFEblVYMnVrZDJvTGFqWmc5dW4rdzhXVk1aaXY4TjBlRHE5TUYwOWUw?=
 =?utf-8?B?cW53MUw1aW02azNnSm1ESDZiZHVxQjhHdm1xcU85WFpKZTNqODRKa1V3ZytZ?=
 =?utf-8?B?cHM3SG14N3JaUk5MdVU3WnpwbkxCM294Wm9iWXhxVngvcWdHSnJxOVZLck45?=
 =?utf-8?B?aGllaEhXdXVSOGV5cyszNGw2ZWlyNmJ5SUdWdHI2STRvQ3Z2UDlpbkRPT2Zh?=
 =?utf-8?B?ZnI2RU92V29ELys4Zis0SmRPSEs4TXhzdGpRa0VtN0JOU2M5a3JiSFNscVEx?=
 =?utf-8?B?eGlRWjRvMFB2R01mdFduZXFyRGVNWjh2WWJHTVBtVjlHbzVMR21NcmsyWWl0?=
 =?utf-8?B?VzZtV0RQd0tpbThKMG9lS1NGK2JlZUY2cTR5bjg0RG0wQUxDS1gvWlJzb2tq?=
 =?utf-8?B?YWROenJnbkNETzcwdEdFVFByaWZ1eUdxZWowUUx5OFFQMWExZEZvY2pVOC83?=
 =?utf-8?B?cVRzSmtxN25vRG0vNmE0RkJhVVhFQ04rWUpJWnlQaHVFeFdKSE94UXN3YVpM?=
 =?utf-8?B?bmpmNmhvQXVtS2s3K1BKVzVGcjIwcStmeThQVHd5eGZFTnVZRkVGNXB3L0Rq?=
 =?utf-8?B?a2JPbGZlaXBqMDZWMzB6YzhKSWRPNlRMcVBZMnl1ZzViQVNHK09kR2xOd2ZG?=
 =?utf-8?B?aEJ4SjE5dytydFNEeHlFNlZROFVmSEZLcUYzRmx1RkJBWWZPbWhXUm84NXNq?=
 =?utf-8?B?VWJwdzkvd0N3ZFZ2dFJyZzExL0dTZFFYemxJVkg1RVhDUzFNRGp5Mldibi8v?=
 =?utf-8?B?WDJ6L1pJMk5JOUxnMGZ1VHpSZnE2ZVhPQ2lPWTNQZGRrdkFsamFWTW5CS29h?=
 =?utf-8?B?K1ZlS1ZYdTZiWVdxNG9zemZDc2RXOU5DVFpVbm01bi9YNTI1YVRJUVdnejdC?=
 =?utf-8?B?UmVJbWdTclZURzRjV1MxUTJYWTZydjNMWnk4ZGN6Mk43b1YvQ2l6M2pFT0sz?=
 =?utf-8?B?RnBlbXRjbjg4aUlkY0VTTGM5VHZSWTZROGcvVDZENU5YTmd3Nmo5U1FBQ2tE?=
 =?utf-8?B?bmdLMXNRZnFCL2F4aWxEQWdCUEQ1K2VxeHpVdjlEc0ZEYlcrODZKdk9FRzl3?=
 =?utf-8?B?a2lycWtCbm5VNnJBSEdKSUdUZGZCQlcwZCtiWThiOVRJYUV5WG8vUUxudGlR?=
 =?utf-8?B?MjNva2d1VW5LMFFCYTRFWk9BK01abXRxQllCZTJ4K3lyay9tdDNQcE1od1Jk?=
 =?utf-8?B?SUVnUUhjNmhOdUdvQVlrZ002TkRrazJTNkJaNzlZcUpTRVhneGlGdTQxcHAr?=
 =?utf-8?B?YlVvQ3VrWlRPZFpNaHpZRTUvaHMzVTFLNE5FdGR6b0xiL1BGWDFXQitwVFY1?=
 =?utf-8?B?VVhZNWFPTTVwWmNaMzM0QklwQlRPRndGaTFYZ0pYUFNYd2pCWWMvRWNZeHd4?=
 =?utf-8?B?ZUx5ZzhOQVNrL2NmU2liOHB4VkwvRnlXQWJjcWFxbzNxQ09xOE41ak50UXlS?=
 =?utf-8?B?OUYvUDF1QTZFY3hnSFJsTkFUQUtHRytXOFo4Y0paRjBjbnlTQkJMM3hQeU1O?=
 =?utf-8?B?d1hybm9GOU91K2ROcnc0Sk0rZndGOE9DT3hNWldzbmQ2NmNnTXRsMjdybThH?=
 =?utf-8?B?dkFpWkdZaElPWXh1ZllYRjZlYmdXUTVVZjlKYmF4ZW9COVJ6MTl2N0JuaW9R?=
 =?utf-8?B?NW9KcFRuTVhPdSt0SEZwVnhSd29qaFJ2b2JTelhuVUl6U2s4RDhpeGNJUDFt?=
 =?utf-8?B?T3VvdjJFMy9DaEN2bXNwc1l5bXVPL0FHaitNM3g0YlBTTW9DckNEUzViOCs1?=
 =?utf-8?B?QUxGTVhLeUs5ZWcrc2doZXhOcEF2Z2h3aUU0WUZjZExmZ3VyMXMrc0JiQjBP?=
 =?utf-8?B?QVVBbTBpZno1UVNiZnpNVVlTbWk0YSt0RitjTWxzYjVLczJuTTlVNEQ2Wk0w?=
 =?utf-8?B?cVFlWmF0U05IK3QwYU9wV0xpeFRZSUlNTWRkczFEYU1ubENOMUgwQTMwQjQy?=
 =?utf-8?B?SCtBcnF2cFBJN0V6TjZxbmxYaW0xVFcwN05UVUtITkJtK2E1QVNVTjF0S1Bv?=
 =?utf-8?B?UzQ2eThTS1FvQitIUVhYRFZFZFVuM2wxVU92bHV2VE1zY2tQamZWazdrbGlU?=
 =?utf-8?B?NThaV3BUeHZLQnJLRWRqSWRZOWxBU24rUGJ6b2hHRlRpZzlzRWVWbjZTU2Nu?=
 =?utf-8?B?UGRqYUszNDZPa1FGS1dWOUVyalVTbFdFNVplYnpFUjBYZXZTZHNTWGFSNTlT?=
 =?utf-8?B?cmxOMW9OWWc0enlFeEoyeGZWMmJWQjdTQUZlZ0E0eWRHbWVZV0lUMUdVMXZm?=
 =?utf-8?B?azNzbmtYcXdFcTZnejZXYktqUEZWd0NaOGNoR0NjUjB4ekw0VHZTbUhSQjdZ?=
 =?utf-8?B?ZHpGcUJhb3BkeGx5NzliakZub0xFTjJqejQ3RlJiSEptMWRSbFZzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63c4dc5-d124-4627-2631-08de70c1429c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:47:28.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fgu7NRIg0QN237gKLUEXV8CkyZDs78//R20imOxN7iKOJyodrpyPqT/adOedkBUSAD7ODO/GQmFU6NhZ9FBFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77825-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: BEB1B16ABC7
X-Rspamd-Action: no action

On 2/13/2026 6:04 AM, Gregory Price wrote:
> On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
>> This series aims to address long-standing conflicts between HMEM and
>> CXL when handling Soft Reserved memory ranges.
>>
>> Reworked from Dan's patch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>>
> 
> Link is broken: bad commit reference

https://lore.kernel.org/all/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch/

will fix.


