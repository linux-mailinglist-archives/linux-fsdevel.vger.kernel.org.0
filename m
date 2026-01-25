Return-Path: <linux-fsdevel+bounces-75379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EduKFuOdWnqGAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 04:30:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742E7F950
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 04:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F025300EFA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F7214210;
	Sun, 25 Jan 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0KLwi89Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182ABF9E8;
	Sun, 25 Jan 2026 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769311822; cv=fail; b=mynCDcuN3B5aiyA8yPyWtQ5uMMPZwh6h2iXfNyPKfocK+15VlMPSHHnXOoo+IYyF7JfiAOchYGHGqiZcYYd3g4uGqbh6RUMNPQ6bIxHoO5b0JotMokyRYb3RK3fp0kNO3x/O3pdAXEiu+wlRUgZw03Ch3EhUA7dUWh+PZzivAF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769311822; c=relaxed/simple;
	bh=ise6kZhSnUv1/r/Imx7yvX0Qgs311YD2yT55DeR1N4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2RGtWgHP2eFhhOEl/kOwSFYHF/yIeA0qRtm9ARjhF5XrLUW1sdl6is/BbvFy0EmAP7/TIdX8Fql/H1DGZcS1+HbqAqWW3esX4NYCO6Qhr1uMP1SpESBt+nYT0OkwNYx5YJ9Uyw3lWm1DuRNO4AOx+BisdRd2jmpB0rKuA2Z8yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0KLwi89Q; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmlM42IWXJgIvtrnQMIVnyKsoFJqFgnqI0ZX6fSgO7aDzct0p9sDoj2ppMx0JQwjcb+tc3MUjB/qWAxBkcbySTYhvHW2J5iXXYcw1AxWepLbFJ8N/grQrXCEKHoQYmUoM4bH2Zxupsz9ijPtFnua98V4LUF6bwuBi9xtCyCXBH6H/VxZ7GTkBSty4HpgDVlaGswUu9KcSEIJFPGsXvrzSw0XF0Kcenfx8PEh4fTByNsLVVla/gS8yNVaYMPa9TZW3BghoYOduH1K/kBBI8nncy+LCTFIrK/Jb+/j3FMPwkHeHRdglS9710nY+KQAvx0eqbnXWlaJKHqJ1SXEIJSubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC5MgIjg3mGn0V5mun4Rj2170qliBST9+JTVi7s0Pyg=;
 b=Z9jz6iO9mvckH7/Vx3rxBb/shktI/L23TyOwaZigBcrXaBItYJdfi9Uv3Pl/hCVtR17m2nuY8zSo4Qed56DSLgalJVuT3PsHPd6sbNX6fTxmK/mKlfYxvECvRTode96WFeYQgJPZ1U2LoUQBy0B2Fj2gFtF8POKKkbIlvf3H1TSFmzlsxQuoPqPwFP7DY7YXrC6yCB3XEptn8gIZimWq3dKvPslj5bA4oy4LbVjYZBPd2c1zghXBGN4FomAlvAtvE8I8nP5ZWgICoG3lxqkmSwWjsBJoB/0MaFRgDvfwE6vrTvHYBnqEJ0ziU0uowApgZAzGw49TT7LrlH7oZAV+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC5MgIjg3mGn0V5mun4Rj2170qliBST9+JTVi7s0Pyg=;
 b=0KLwi89QBDcsZk/JxUG9nuWzhQ1QHtucqe/9xXvwex3UrGay4IbN2/+asHfAhSuQQlIPW1plZ4zMX38RiIFuUDIrqnvCTunPxCEpwDW9PcnamI8MiQx9pTPGRLmDuwRYmL74g3Bs6ICFIPUEcXljkS7zUpHd/5i+OgvaQ+EXI7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 03:30:15 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 03:30:14 +0000
Message-ID: <65c9679c-6e9e-4a31-a4dc-ae3c416bfd13@amd.com>
Date: Sat, 24 Jan 2026 19:30:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] cxl/region: Add helper to check Soft Reserved
 containment by CXL regions
To: Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
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
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
 <ee064449-d0a3-41df-a83e-d83ca17b61dd@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <ee064449-d0a3-41df-a83e-d83ca17b61dd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec9dc5e-b97b-4c2d-8617-08de5bc20dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmNCZnBEWVZoR2prZmpWYXlkc2hvU0ZWOExaekdwcU5COUtnRjZDMFhhdDRN?=
 =?utf-8?B?cHBnNTlFUit4RXJXckVBRnZIS3FmbjMvNTloUENaSW1NNThmR1BLSEdEMmdv?=
 =?utf-8?B?WmhiVi9vdnFKVlJiUWFQVFN6Z0xpQm1keW13bFRJUDdEcmxRSDl5TEVpZzBl?=
 =?utf-8?B?ZEFqUHE5QXBPZ0tvWmhHL2Zta3pxNVV0ejlNeng0UWJvek1JZGRBUjNFMjll?=
 =?utf-8?B?OGUyY0tjaFFoamFWUHg0c2kvRHpDSmlMYkxuMlJZc3NtUlZWZUZ3UnFabDZo?=
 =?utf-8?B?U3RNWE94QzBwNll0VUFBMlJFTFZ3dmJRL1lmWE1rLzUyN05LS25PeXhRYlRK?=
 =?utf-8?B?VUFQcXpRT2w5YjczajFtOXNTYlM0MHBoMUZNS1NFbkp5V1NWNURMSDVDbjh1?=
 =?utf-8?B?R1I2YzUzbkVsaEdxL0FXMnlqaHhEMGlYeW9vSUZJcjlCQ0puTUU4b1ZXckpk?=
 =?utf-8?B?NTRNVWJNQk1zaHBwRjhRcVRaTldLM2V3RGtxTXFTZVN1VHNaVFFyNXNURnp0?=
 =?utf-8?B?VExZNlRSbll6UEdnampQaXdXM1BlWWYwdkF4ek9JbDlxbXFHVHVCbXpTb0FC?=
 =?utf-8?B?K21XaXFiSXh4ZTNVWk1EUE13Nkw0aHNTTXd6b1JyYkx4N0EyMlNXZG42ODJl?=
 =?utf-8?B?dmFoV2s3NVVwdWc4TUVnK1RzMVB6cUtBejFWUFppdnlMQTVmVC9yd285WGFr?=
 =?utf-8?B?dy94RmtVYmptM2l2NEZabllWV1E2M09WNFVETnJMaG1wOGVTSnJkQ3VRWlpT?=
 =?utf-8?B?QUZsS25RZitrcVNhdDVQWkZ1dUtLWTZCMnFLQUZ2S3JHRTd0TUNtYVpyUlZW?=
 =?utf-8?B?eFlQVkljSElCR3g0SHlZRFZaRFd1R2gyVmExZ21vL0Y0SjJvVUFPdVJBclFm?=
 =?utf-8?B?RFRBalBmRi9Ed1RKcE91OWZxYVpJK1ZTM0t6RG8rQUZudFJEWGdJdHc3MlVr?=
 =?utf-8?B?NXRUbjBadCtjT2Jqck5rQ3V2WFZMNFFQRUJoNG1GUVNISHRwRmFwcEZjek1E?=
 =?utf-8?B?TnpKbUkyQVNtc0pJUnMrdEhDNW0vVTd4cVFjTjRwWEpORWl2WVNvMDduK2hl?=
 =?utf-8?B?OHJ2TTN4bkxIRE9Udm90QkZxbjEwV2o4ZjdzY3pibXVRSjR1TUNlWDIxcDlN?=
 =?utf-8?B?NHZqOEpMbnVmT3U0WExaRFY0UnBqcm5ROERwdktnelBlM2pMeklCUzh2dE5C?=
 =?utf-8?B?OHh5OG9Wd09IajhCMmNMd3JZQ29acDZBNTB6L2FHbm1Eb2VsV09EODFyZ3JL?=
 =?utf-8?B?b09vRzNQbFdxUXBlcEpITlpHbWVrTCtKbHM1cUlUbUhxSmpwVmRnUDVMWGkx?=
 =?utf-8?B?dlM5SzdyLzRhUHFTczgzc1B4WjJod2oyM3FEa2pMWU9GR0RLc1hVMzFOemNB?=
 =?utf-8?B?c1NZT1VNODdYY3dsQWcvSU9vbkZ3bUNHV0VUNU56eWszZUVrR2ppNTM0TjdS?=
 =?utf-8?B?cXptWUp2azdZcWlIeVBUM3RacThJejJCcW1TYU5USlpTUUprbk1HeitVMmpE?=
 =?utf-8?B?NWlRQ2NrL1BXNG5JMVRBcGR1eGZHWjJmZ0NSM0RCS1FZaGMrbWp6QStGWnBz?=
 =?utf-8?B?TnhtejBvM1RhaDlGbHVJaWFpT1JlYzZ2SStaMkdzYjE3aU40TENvVXEzb1FZ?=
 =?utf-8?B?TEF2dFRyb2F6T2UySk9UU3dBQ2ZXL21zNThkY3piOVh1WE5ha3JGK1BvS2Zv?=
 =?utf-8?B?UVVRenY2SmkrNDBWdnJLT0VtQWdDUmFsUFZCbXJLeldjL1ZTS2NGNG1lVGxa?=
 =?utf-8?B?T2RRNFhVVnJIUVBUME91eUtuQ1FGQ3hPTjVhZWI2OW8wMWU5dDhoVVQxL05s?=
 =?utf-8?B?d1dleGQ5azc4Q0VLa1pZZFcvNmlaUUZKSWVZTHFvSEdnV1pHakpxQkJESmIy?=
 =?utf-8?B?aDM0SVQzdnZSOVVKM1pOcWpFeTV5QVlzVXRySDNjQVBNOHJPMFBreFFmTUpQ?=
 =?utf-8?B?U3phRmJOaDNHNW85cXdHWWZ1YUc3NU9YeVpSTXUwNXBpb25MWDE1anFJS1FK?=
 =?utf-8?B?cTRLNUFHQzVKaHI4ZmVLbE01d0ZhYVlhQ1RRK2FVak9XV0V4NFBOZEVDU1BF?=
 =?utf-8?B?aGN6UDNmUnhNV0E3bUhMNTVNS3pac2FPU25GZTkyN2p4RWdjZDJIbmZDTVpD?=
 =?utf-8?Q?yCIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjAvNEttQ1JJL1Nya2MxTzlCWVdCTzZ0M2xCZ1ZOTHBiOXhZbUE3MFdEU0Rr?=
 =?utf-8?B?N0t6eFVVZmlaSzkyZlhQenhCQ1gzVUVDWXBJdm9Ba216aFk5eEdnR0dZRHQv?=
 =?utf-8?B?Mmgrb0l5UnZ4amtiZkFkeWhENjU2aXhjcmJnb3dvUDdnelg4SFpVMysyUTNI?=
 =?utf-8?B?MXErNFFqd1pOajY3WXA0a3JRT0xlNUM5Tm9aYi8wMWdUd3Z5UE9nQXM0MFB2?=
 =?utf-8?B?SXlPNGJuYzdCTDFITGZ5alYwQklmbTFYcE5UbXR0OFFGdWJFSnNIa0lrNVlN?=
 =?utf-8?B?cTZra2lVNEh4TWdtNXduSWhTL0NBd3NqcG1oajdxYzJTRDNFTzlpdFBxaHFP?=
 =?utf-8?B?MUxYb2VOaFhxcXd6bEpGVzhFVk9Yd012MXQ3YXRqb2hUdHc4WGdxZzZuclNE?=
 =?utf-8?B?VHFUVFcxdXVyNHYzekc2WU1tY0FiRWlFakE1and2bDZidUtwdTlJWHMvYUwz?=
 =?utf-8?B?RGpCL1l3c3ZhVE00SHJmWGM1TWJpTUhua2xwZnRUcEp4b0VhWFVGTEVnWHZS?=
 =?utf-8?B?S1RFUU5rbnJIeE9aRk1rSE1VQm8zUW4rQzhOVi8rQVAxWUV6VHBxTHBoMnRs?=
 =?utf-8?B?STVrUEcyYzdXU2NhcEdUWlhjRjJsb3hoa1hXTTJJdEtORmx5SHpJZTk3cHQ5?=
 =?utf-8?B?bXcvdUxwUkpJZjJlbTA4MFJpejkzYkVCV3ErY2NvSWlCTTdZOUY4OE9PWDI2?=
 =?utf-8?B?c2dwaFN0by8zM2Nra0dYMGtJcWNRWmtMSEtUaS9nY1lZaFpmRjdva3JXWlk4?=
 =?utf-8?B?c2M1V3dnR3N2V1JZKzhPVXdzWE9Ob05Fcmp6ZFNsY2YzbGFxazVWYkhMSnVt?=
 =?utf-8?B?eTNMb2ZQZ29YWExZeVc0QW5BNk5OQ1p2clFnMEUrdmNYbkhkNEtkdm8wZlpV?=
 =?utf-8?B?OC9Tdm44RnIzNEJ2dUpkMk9jVnFDdVlvWTZ3b21FdTZvUnNuUVhUdXNHc09O?=
 =?utf-8?B?UWdtdzdVSzBTM0xMY1ZOUWFxbEhUbit4OGY2Mm9UTGZnMFEyK29Gakh2N1Vv?=
 =?utf-8?B?b2dtRDJEdFFveE9CWklRYk9xbXhqcFVSNHI3TWVHZDN0YzRJMW5qc2F0cTJF?=
 =?utf-8?B?eXZVaHJ4MFVQbWZrZ09vYS9BTTgwWGFUK0lld1FwWUU4aEE3SEdtY1RHcjR4?=
 =?utf-8?B?T3hhcExZeFowSmtQenMzVmxHd0x6Y3BrVTNOR1pzSS9LT2dyZm9JVnY0ZWhv?=
 =?utf-8?B?UmttNTExRlh5QVZIVG03RUhvK1NLeUlYOVp5d01GRm0zSk5ENklyU1h2dWN5?=
 =?utf-8?B?TDR4SnpwTkJyQkc1TlI5dGtKUXczSkpFVnNLMVJydFlzM25xSkJFRW9uTTJO?=
 =?utf-8?B?VU1hNjhlVDN4ZDdTc1VJcXB2SWErcmlhK1BzaWg3T0xNelJBMHBIWDF0L2Vu?=
 =?utf-8?B?eE50U09WZEJPOVlWdG1XY25mUlh6ZFowRDZvaW5tK2pFelNPa2lBQTZzUlNQ?=
 =?utf-8?B?MElIcDFIWDlsL09BeTkrSXFHREVkQ2NHNEdvdlFqNzUwTWd6UU1EZkNMcW1v?=
 =?utf-8?B?c0RxTmNkVnNmWkwyM0VLNGJOYkhxc1pXRXYvUTdTaFNzSUgxMWdXdVIxcGN4?=
 =?utf-8?B?RHZaaGUwSC9sQ1dpWXA3MFc5VFdFSkcxZHdQeFkxelo0RGdOaFlMaFIvQU8v?=
 =?utf-8?B?UlJhWUF0STB6SFFsUU5LazZUdklJUm05Q1FYVkxKSkhmNDA2eEprSi9xNTYy?=
 =?utf-8?B?RmdQaFB3dVNMbmt1SVI4UDlkbVJUR25vbGlzTDE5WGNURWZRdGRSajdQcjYz?=
 =?utf-8?B?cnZqYjlONDNqZzMrZDJ0ZmdPYjhwS3paMlByclc5c3dVTVRibDQ1TGZwNERX?=
 =?utf-8?B?b3h5VlR1ZTd2L0VYQkhtZFMzTzRKYXQ3dXNFT3hkUDJ0Z3ZGZ0xwY1hla01F?=
 =?utf-8?B?Nmd4WlBrTHk2WG5BOUQ5Z0tGMmtOdTJndjJkSXJpOVhoSW1IUndkeXFZTEJW?=
 =?utf-8?B?WEgvdHU4dkJrYm0vWmt1cTM4OS9TRWVqWUN5ZWwzWlFJNnVmNXJjMmxqSURD?=
 =?utf-8?B?aE40Mlp3RDd2ejRabDFuTzA3dHlpZWZQOWxnM0FVd0c2NG43Zi94KzMzUU1K?=
 =?utf-8?B?dkc1UGJZem1JU2tqZGxNNTJCd0VZZDA0cVN5RE01cHN0ZnFhTk5RSkdVT00w?=
 =?utf-8?B?c0dnbnVOckora3g2Z0p5TCsvQWw1T25qczhRbnM4WWFaZ3g4TjRWR2R1c2hQ?=
 =?utf-8?B?NDU0OCtQVVhsSVN5U1liTENnbzIwQjhoYVc3SkYyVjFFMkVGVnc0NGdoMHdp?=
 =?utf-8?B?UUpEVFg5R2hmM0JUd25YWkJFZ2ZBSjN6Rk0rZThqenVFb1VqVmNHQnkxVld3?=
 =?utf-8?B?TnF5VWhvbm5wRC9JcDRhRkF3aGs0ZnpvejZtdDNyeGIrR2VmTmpBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec9dc5e-b97b-4c2d-8617-08de5bc20dad
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 03:30:14.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3b45DpocEv5VbYdCWWWewBMLhLygQ2ct5gmC8gc3N/WDu/pIq8DERpGNzRf15fgfl2Y/KVypxz5sZacZ++0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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
	TAGGED_FROM(0.00)[bounces-75379-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0742E7F950
X-Rspamd-Action: no action

On 1/23/2026 2:19 PM, Dave Jiang wrote:
> 
> 
> On 1/21/26 9:55 PM, Smita Koralahalli wrote:
>> Add a helper to determine whether a given Soft Reserved memory range is
>> fully contained within the committed CXL region.
>>
>> This helper provides a primitive for policy decisions in subsequent
>> patches such as co-ordination with dax_hmem to determine whether CXL has
>> fully claimed ownership of Soft Reserved memory ranges.
>>
>> No functional changes are introduced by this patch.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Just a nit below.

Thank you Jonathan and Dave for the review.

> 
>> ---
>>   drivers/cxl/core/region.c | 29 +++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |  5 +++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 45ee598daf95..9827a6dd3187 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3875,6 +3875,35 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>   			 cxl_region_debugfs_poison_clear, "%llx\n");
>>   
>> +static int cxl_region_contains_sr_cb(struct device *dev, void *data)
> 
> Since it's a local helper, maybe just call it region_contains_soft_reserve()?

Okay I will rename in next revision.

Thanks
Smita
> 
> DJ
> 
>> +{
>> +	struct resource *res = data;
>> +	struct cxl_region *cxlr;
>> +	struct cxl_region_params *p;
>> +
>> +	if (!is_cxl_region(dev))
>> +		return 0;
>> +
>> +	cxlr = to_cxl_region(dev);
>> +	p = &cxlr->params;
>> +
>> +	if (p->state != CXL_CONFIG_COMMIT)
>> +		return 0;
>> +
>> +	if (!p->res)
>> +		return 0;
>> +
>> +	return resource_contains(p->res, res) ? 1 : 0;
>> +}
>> +
>> +bool cxl_region_contains_soft_reserve(const struct resource *res)
>> +{
>> +	guard(rwsem_read)(&cxl_rwsem.region);
>> +	return bus_for_each_dev(&cxl_bus_type, NULL, (void *)res,
>> +				cxl_region_contains_sr_cb) != 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cxl_region_contains_soft_reserve);
>> +
>>   static int cxl_region_can_probe(struct cxl_region *cxlr)
>>   {
>>   	struct cxl_region_params *p = &cxlr->params;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index c796c3db36e0..b0ff6b65ea0b 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -906,6 +906,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>>   int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>> +bool cxl_region_contains_soft_reserve(const struct resource *res);
>>   #else
>>   static inline bool is_cxl_pmem_region(struct device *dev)
>>   {
>> @@ -928,6 +929,10 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>>   {
>>   	return 0;
>>   }
>> +static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>> +{
>> +	return false;
>> +}
>>   #endif
>>   
>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
> 


