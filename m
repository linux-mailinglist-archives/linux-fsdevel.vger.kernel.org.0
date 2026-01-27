Return-Path: <linux-fsdevel+bounces-75650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKK6H3QueWlOvwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:30:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D29AB49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8C6302D945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977812C0F97;
	Tue, 27 Jan 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bx/gL9bO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE42550CD;
	Tue, 27 Jan 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549411; cv=fail; b=Q/VYbaPbm+eMY9SeaWzSoonxC+SorEeTXydiRbvC1PNql+GVu2w7JQK5neRWsUw0WenzY21XOW/RlPqcm2eZ3CuT9vV7xZD3LhPkZICNlatvWB5Ls+jqAYegSP60yixKleaxaMtX3UNYCXcgtrsNSjTqkIVGqLyxzfnMPYfIr00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549411; c=relaxed/simple;
	bh=sthQ5/lQZYTQPA9TE/qplfJ18bKCXk57QHTzoLRk/wM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IsObUGHwRwZjnCtMe0b+6Ql5YEawDZPLPTkqR4Cuo649QCSYxkxRKjjFj8NFBueGbDtp8id9qzbYpwlwb3QD9YslOHaetFoDj58Txj7ciLcMaBBdnRflsUqrLO0DGOD1tSUmmcsPSbH7iP+eOhML02S+tFYuHynDaIDRfJnFpVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bx/gL9bO; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9WLG3lE+mTjlehRr466yAd4+GcVH2oSd4uzYo2u+cOkjCRTUEsOluWSqqf3FTdhY6tw8WKTRrcsd1szsHYy6p5pSqxHvS8YjMxMh+Dws6a7vZaleXmyxG/Rc3vIQBTHWgKj136EX5YK9EqKVWoRx6uqkuPKCem/jzGeGCI8XkIDJrkdy1rS9T23c0xHGjRzIOGMrm5aWfkB+HDboUX5MyLcqLq4lkjwk8EFRyfNqc4MsAJpqaspy5dmTwABztm3JWJTVfV/X6gXQ9GLSbFf4fnA1I27c49h2oRy62Ve9Ib9gVq5dbrLQVxxy1i2W4WK9oSnLPDKVtbGvNwfSsYxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWfWAQojirQlfXdu8OVSGoAk5H2gVVPRNjBegCeO5OU=;
 b=KCB1ObxzElCkR3QC7LhO/7EtV6LNBneRVtLLZqtRCb7TAIO8oCBcpGyeTV/koTLeusldRB3flyVEEJ1ZdOpQMuFYn9+22Cpu2O3PiXg/YKT7ACa3eAiNN1jqbjVgRX87jZDa11W6RyF/lMCmJ4/iXO3icKiAoP3VCjQG69im315lgLCgj9K7d+ByDeFb2v/qF0blaDhcgrKhfxcPTIiRkqL1bk5zvMa6aLK8VGcR8JC7N4x6aPeNNI2XiZC9PYwgDEBykpTUCua/+r8IrxR9DXHV6opH6qqCyZXzq6k30toVmZpUotd8NvzhjCGRTXHPacCnJPX/zxNVEyyin7kiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWfWAQojirQlfXdu8OVSGoAk5H2gVVPRNjBegCeO5OU=;
 b=bx/gL9bO7wT7u3HDR0rc9zgsiaBXWt3A8n6YHugKd2RhEZHXB8KzzsW44aYOxBKZTewRIXjQMc2JXRNQB51SLtjwuaAqVtnx6/WNZ+/Cxz36gzcM5wwEME0Z2b6Rp8OeD5iM93SjrYvxRVrc2LNngvFxOvV1w0Glu9I80tiWO3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Tue, 27 Jan
 2026 21:29:59 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 21:29:58 +0000
Message-ID: <dc3b5be1-3a9c-4db2-8a38-4a6e16e321a8@amd.com>
Date: Tue, 27 Jan 2026 13:29:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: dan.j.williams@intel.com, Alejandro Lucero Palau <alucerop@amd.com>,
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
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <6977fe94d8ee_309510033@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 1074e1a4-98dc-4bb4-886a-08de5deb38e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlU0em9nU2R3N0ZoQVljMjhuNFcybEM2SW1udHhBZzFMSnc5REwxY3d2VG8z?=
 =?utf-8?B?WlRJWUtXMVpGbU9rYkJIOFJvM2I5R1FJMGxsT0Z1MzlYSDdIL08xakhFTzVV?=
 =?utf-8?B?Vi8wNHMwWFYwWW93eWZvSThEVnFLRWtBallSSWtUQTU1cmNLMzlhWGVPNFVS?=
 =?utf-8?B?VlNqVGRGUzhDWWQ4aGtEa1phRDYzdDVLQ0FBMkxqOVE0N3lMR2l0NVhST1Y5?=
 =?utf-8?B?MmxpRk9XVHhlSWRidjh5Qkg4Q2xUekF5akFlaElOb3lSLytGUXhNNnBGNnNj?=
 =?utf-8?B?WWtWMVRKeFliZll0eE9waWVHcEkyM0IzOFNEYjloOXFxdDkxdjFtRGdjY2ln?=
 =?utf-8?B?Z2l5R0pOZ2J3Y3l3VHlLZFZLN2F3ckRFS0Y2OGoxU1RwSytYWnNjNzlmNG5U?=
 =?utf-8?B?QklJblFBc2pocE9YeUtJS2ZKdkJmcVQ0UkU5OGRqVXpXZE5BcVd6K0prbjhH?=
 =?utf-8?B?eEI4bUsxUFpsUktjM2pOb093K2JoQ2VtTWtNdFFJRHlCTVhnNHByWHpib1RO?=
 =?utf-8?B?VVdlNndkWlM2QnpUZ2RiQmdNSVA0QmZoNDlBWWhqZEJKNXQwTW9CRWFhWlRR?=
 =?utf-8?B?TlE0TjQ0SlBoNkttcU9KM253ZmxaUURhNDRXZDEzdGZBUTZWNzJ6OXJIMTJU?=
 =?utf-8?B?Rko2cENpYXk3aFVKSjBrekFDQndvSGJoQmR2ZVVnelBQekFMOW5hc2FmcnYr?=
 =?utf-8?B?N05EWnlyVzY3eUE0ZmdCNnhQOTVBN2Z2VHFpVEFRcWdRNFl1MzA3bWM3SCtX?=
 =?utf-8?B?RVBwNXI0ZzBuWUcvaWdTK0NBTjVJMUVIRGR2Z0tTY0Z3V3ZtcVY3ZE1tZTNn?=
 =?utf-8?B?SXFQbXlqcEdDZnhsSFExc3VFK3AzbzJiaFFGU0FQNTc3TFhMbUJJeitZR2Zo?=
 =?utf-8?B?aXM1SlZqVldNMVpianQ1QXZLZ3pBMytCa2oxRU4yd3FQR2lQMTJjdnJxVlpk?=
 =?utf-8?B?dUlNU3VvS2NvWnpsUUNEcWUzVnFNYTNjWWVTNUZEMldiaGJRS1BUNFpPTHpp?=
 =?utf-8?B?Z3Q3dTZPaU05amMyT211bXRvSU9YcjhzcXdNM0xoR3oyNmN2Rk9SeHJHUy80?=
 =?utf-8?B?ZmEzOWtJcWVxdHE1NlNKZGVySmJ5WnViK1VQN244SUhCbG9aTGxPK3ROWmtI?=
 =?utf-8?B?Mm5ONjd1bnZIMFlrMDJvNDdodS80TFdDL292YWFGYWM3allsQk9EblV1TWNJ?=
 =?utf-8?B?aDVwV3lTNkFCMjZpWmZCdEpSTnNySUd5b0ZaQ2d4Sm00K2JuSDBUSndvZmpp?=
 =?utf-8?B?NVhnRFdrZVJVWnhlMkMzTFdxdk5tNkVKUGZsYlZZSktPOHRKcVdUai8rK1Ny?=
 =?utf-8?B?ZHprTWZ4Ly9MQ0dnYjI1OGVLSGxweC80ak4zQ2ZDaE5zR3dJSFlZNWt6Q3BI?=
 =?utf-8?B?ZldLSVBHemc1VGVHcDB4ZXQ4MlhUTHVsMHk0VFR4NWp4T29lTlN6b2NvVGdi?=
 =?utf-8?B?S3RpYkROOXNKTUdLSS9DQ2dWcVBXL2U1bUxBd3RtRXI1MlBuWlJGL2kxeXQ3?=
 =?utf-8?B?OEJvbXZENVgyVWV3K1NYTkIyNkExNldTQnM3ZnZUdHUzR3dvTFhDM3N5YUp6?=
 =?utf-8?B?ZkpQQmIxTVcrY0NlT3NGM2dkc01BR0MrYUZUa0dTVnE0QnV2WlhXZWhiejZm?=
 =?utf-8?B?a291UWJjMVNiMHVENW83RG15RHM4c3dUb0JWV1dOMTI5VW5IRzZYeFdLSXJi?=
 =?utf-8?B?TVNOL2lWQ1ZYQ0tkeWZRTk4raTVLN2ZjN3Zmd2w3WHliRTJ6SUlxeTcxSHUy?=
 =?utf-8?B?RTcybi9sUHdaQk1lcHRWdzNMODEySkF6TDNlSnlWNU1KT2o1dm1vMTBnTjIv?=
 =?utf-8?B?ZlBKMXB2cnNLaGtERWdpNzlnRWl5b3JNbmNCdlovRkpKQm85cEJPY2Zjb3A3?=
 =?utf-8?B?aWJBbFgyLzlWM2RSVDRxYnZpd1hDb1NXMFVydW1SNGRKMDhvREtKOUhSSUh2?=
 =?utf-8?B?cTRvQlZqcm82a09qNzN1aFZMV3JLVGVlY1JmL1NTNVBVamhHaW4wNmJHdWNa?=
 =?utf-8?B?YUFiZk1BQ2lUZldYK1N2YVV6cUw3OWExVkp4b1duU1lHZkxqUFlJSi9qNEZB?=
 =?utf-8?Q?syGVUT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDVsem1IeFdBNHRSUHZtSW1CUUpVS1NOVnJiakN6WGkrK2h0R3g4R2p5SFYr?=
 =?utf-8?B?VXFpSXc4aDBmMi8rWWJtZFExbTdmYlhYQTI4UmpaK0NzaXF6NmtuU0pjZldq?=
 =?utf-8?B?QWFia3RDbDU1QzN2RFRMZExnUFloc2JhdS9QY3VCNHI4cVlxVlFjWksxVCtZ?=
 =?utf-8?B?RXhkeWgxSTRMRkJjaEFwNzlLclV3TzhmRXlRSGhvYWl0aU9DKzh3eXFnMndn?=
 =?utf-8?B?U1J4RW80NHZ2MjNXdnN0WEdWSjNES2p5VzZpMWo0WldzdkFBRFh2K2ZyNWdE?=
 =?utf-8?B?alc3YU1pZi9uQXkwazhvNkc5VGNZVVVVWXZ6WDVZc1h5ZGJkYW9PdjRYdVVY?=
 =?utf-8?B?N3dxTTdjWFUzam9xdjVkYVFuZFJOa1FoWkRsYmhlajgwa1Y1U2RzT0pUcmR1?=
 =?utf-8?B?a2tsT1JtWVd0TFQ5OGZtaExtbkpHTjUzQmI1WStPZS9pYkMyMWo1OWFGQ3FD?=
 =?utf-8?B?WHBDWGgySHEwUzE5b01yang0T0gvVE4zZVNqbUlKbEVHZytFZ3VsbkNTakF0?=
 =?utf-8?B?MW16ZHpWWEtXcGtHd2x2TkJpRDB3YTEvVnBERnV0ZTJRRU04SWIvQlRVMmVr?=
 =?utf-8?B?dCszQ1M1L09BYitxTzlMRnp0QW1rNzRzTjlsRnY4S0hTbU05TGtnL01qSmZV?=
 =?utf-8?B?WjN6a3NxNUp5ZjFUMUdGT2xkTmZrSmpiV05NR2hOVnV4dDlWSjBZS0l2QmZy?=
 =?utf-8?B?ZTJWUmFQcFdyY2RMbldOay9mNmMrSElTY3FTcHdlRTJiczNqRUJNSGdzbDBJ?=
 =?utf-8?B?eVYvVkNib1l0WE9QeW9xZFBGMWtyYWUrNGUwSjg3YXBsdi8yQ0lGY2I2YitS?=
 =?utf-8?B?cUU0Tmc4UFRLQmNMY3FBVERHak1NMG5LVSt1UVVKZVgybGRoZ1FxZ1podUVv?=
 =?utf-8?B?ZmREcTJCNkYvYmh4TEorSzNQbGFTNi9SMjE4VDBsWmo2SGROd0xhQ0RTRzlx?=
 =?utf-8?B?SHJSa1lmSC9NR1NHSFZBbWNLK3ZleHIwU0ZnQ3F1ZkRhSEFuODEvOHZtWHYy?=
 =?utf-8?B?LzhBclVQTldyQndIQ25LYTg3cUhxNHRITGM4eEVMblRoV1pHUUw5Wk1uU3Z6?=
 =?utf-8?B?b1hLWDREbHdibStiUFpFdmFnRUNrWGNMbHRBS0xnZkF2Q1FVdEVacFNSKy9U?=
 =?utf-8?B?c2cveDZMdEY1TDJHSDFkUzJOUm9oNGN1anNIVnF0cW1HRGEzUkRWL0VzUTB6?=
 =?utf-8?B?dzN3Wm4vb2hGTDdHcnVZNklyNXVpUWZvazlOSldSWVh3VDhvR0tvMHpuK1Vy?=
 =?utf-8?B?QXRnYmJFQnRoVmF6M3FnQmQ2TkdFbElBOTZCdVBDNjY4R3VyVUpVeVZFditO?=
 =?utf-8?B?d3EvOC9qUFNoL2hEWFA1dWlnUUJYMWZLcUw4eHFLUEtqNklTRE9nN3JhQXFI?=
 =?utf-8?B?dVRnOUgveWwzalNWOVJOVk9IRlNNRUw5T3pCOHU3b3RNTDFhaFVkdTVRMWVC?=
 =?utf-8?B?bHZsVjQ5UmNXWTdCWUEzVHlpQ0dtbmJteGNhT3pvWmdVWC9iZklEa0F2dEdX?=
 =?utf-8?B?ZWk1WFdUdEtpVFF3QjdsbXRDcmJKNElhU3FvTVNGRjdHaHBQTzIwV3VZbFIv?=
 =?utf-8?B?RzN0SkR3ZmJOK3hwcGIrY2ZNM3YxaDJmcFk1RG1rUW4yV3FhNUF0K2F5UVVP?=
 =?utf-8?B?QlNPSmRmVXppOTJIdWpHejlTTkxWQzA0VnVTazRRMlI0ZWtueElTZUlVaFRu?=
 =?utf-8?B?WU8vQU1wdmkxTjdmcFZBdTByZFhXU3R4Y1d6WWxzQnQrbmFDQ1FmK0ZjTFIz?=
 =?utf-8?B?dkFoOC9QVjJoS2h4SFhzWTlLZXVrejVLNlh2dzMrakxOeFJqaXFpSGhJUHNQ?=
 =?utf-8?B?bis4SThIcHBCM1p6dGFYc2toWHhhNzdQWFlRcmFtbFJHQkN0eStFZEE4UERV?=
 =?utf-8?B?UTQrSzMzaGxMMDRVWTBzYTR4dTBzNXVYbjdIZkgzYXhJemRKK0NsYWsyV2RP?=
 =?utf-8?B?bTJYRGQyd25TUHVGSFdaaU9XLzFVbG5rV3NmMU9XbUR6cU5lYkhnZ0F0aUFY?=
 =?utf-8?B?eGFCcnFqL09vNnNHckVVTUQvcnhFZTloTHg3bXg2SjZod0VJSkFLbXVXNVZM?=
 =?utf-8?B?L0Uzb2tWTW84N3hLbDF4VFRqdlY5T0JVNnJUR3haYjM4SEE0cEpkRjVuV3JB?=
 =?utf-8?B?ODkrVTR4ODJiUWp2L002aXRvNWsvRDVaTXRoZ1FyUDVhcmlBQkpncExiQU9F?=
 =?utf-8?B?VWVJbHRBaWRTcVFnYTRRUlJmQUJERjJ6dDVQM1lWSFBpVG8ya2FVNWhxakRT?=
 =?utf-8?B?VmlUWDlRZTh6elBBYTVVdUJHZzliSEtaQmRFLzNnR21hdFlFUm5zUkJFdnJ1?=
 =?utf-8?B?UlJrRlMwdWtVVjI4ZGxrWkFsOE5nRTFkNGh5YnE4MnRiUVl3WWVRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1074e1a4-98dc-4bb4-886a-08de5deb38e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:29:58.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kklUb4yj5bYmHPlN/n/GTXO8JvaaUfrkTeeW3yfZoAaO/X1fefJWoC/Z1QWdc7QwsxezYEsRviIIZDbneVsrEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75650-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,lpc.events:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 115D29AB49
X-Rspamd-Action: no action

Hi Dan,

Thanks for clearing some of my incorrect understandings here.

On 1/26/2026 3:53 PM, dan.j.williams@intel.com wrote:
> [responding to the questions raised here before reviewing the patch...]
> 
> Koralahalli Channabasappa, Smita wrote:
>> Hi Alejandro,
>>
>> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
>>>
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
>>>
>>> I was not sure if I was understanding this properly, but after looking
>>> at the code I think I do ... but then I do not understand the reason
>>> behind. If I'm right, there could be two devices and therefore different
>>> soft reserved ranges, with one getting an automatic cxl region for all
>>> the range and the other without that, and the outcome would be the first
>>> one getting its region removed and added to hmem. Maybe I'm missing
>>> something obvious but, why? If there is a good reason, I think it should
>>> be documented in the commit and somewhere else.
>>
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
> 
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
> 
>>> I have also problems understanding the concurrency when handling the
>>> global dax_cxl_mode variable. It is modified inside process_defer_work()
>>> which I think can have different instances for different devices
>>> executed concurrently in different cores/workers (the system_wq used is
>>> not ordered). If I'm right race conditions are likely.
> 
> It only works as a single queue of regions. One sync point to say "all
> collected regions are routed into the dax_hmem or dax_cxl bucket".

Got it. My earlier assumption of multiple executions of the deferred 
work is incorrect. Thank you.

> 
>> Yeah, this is something I spent sometime thinking on. My rationale
>> behind not having it and where I'm still unsure:
>>
>> My assumption was that after wait_for_device_probe(), CXL topology
>> discovery and region commit are complete and stable.
> 
> ...or more specifically, any CXL region discovery after that point is a
> typical runtime dynamic discovery event that is not subject to any
> deferral.
> 
>> And each deferred worker should observe the same CXL state and
>> therefore compute the same final policy (either DROP or REGISTER).
> 
> The expectation is one queue, one event that takes the rwsem and
> dispositions all present regions relative to initial soft-reserve memory
> map.
> 
>> Also, I was assuming that even if multiple process_defer_work()
>> instances run, the operations they perform are effectively safe to
>> repeat.. though I'm not sure on this.
> 
> I think something is wrong if the workqueue runs more than once. It is
> just a place to wait for initial device probe to complete and then fixup
> all the regions (allow dax_region registration to proceed) that were
> waiting for that.

Right.

> 
>> cxl_region_teardown_all(): this ultimately triggers the
>> devm_release_action(... unregister_region ...) path. My expectation was
>> that these devm actions are single shot per device lifecycle, so
>> repeated teardown attempts should become noops.
> 
> Not noops, right? The definition of a devm_action is that they always
> fire at device_del(). There is no facility to device_del() a device
> twice.

Yeah they fire exactly once at device_del().

> 
>> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(),
>> which takes "cxl_rwsem.region". That should serialize decoder detach and
>> region teardown.
>>
>> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during
>> boot are fine as the rescan path will simply rediscover already present
>> devices..
> 
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
> 
> It already races today between natural bus enumeration and the
> cxl_bus_rescan() call from cxl_acpi. So it needs to be ok, it is
> naturally synchronized by the region's device_lock and regions' rwsem.

Thanks for confirming this.

> 
>> Or is the primary issue that dax_cxl_mode is a global updated from one
>> context and read from others, and should be synchronized even if the
>> computed final value will always be the same?
> 
> There is only one global hmem_platform device, so only one potential
> item in this workqueue.

Thanks
Smita

