Return-Path: <linux-fsdevel+bounces-75652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAhcHiQyeWmNvwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:46:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F429ACB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5370302DA3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF032C322;
	Tue, 27 Jan 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEfgJbW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD527FD5A;
	Tue, 27 Jan 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550361; cv=fail; b=SMDIUn9Ar/ineyjVfU5taZSYSvvUXsGcWsxBVjSl/OA0af+uH6tVCY/r5x82B9GXUFnjaZ8DtH4p7asJSk346jgNDwkKSeH34cdg+SbCOjRCTrtyi/YSOlXOq8A+qjMXynzWWFZfz3roJokENHiJCuU++4kbDsYRYT3CXrDKBcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550361; c=relaxed/simple;
	bh=ixsQcTgwH2YRfT9PiLuBORKTjbrQx5itWl3nuqMJqyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyKuGj1GSGR7M9V32WCLUAv4yUaAjnFAJqzy0kdOwMOeLBy2X8S87wrZGPRLRcKhNn1MYrwLYE5sjefOHwU+pycWjNkbDYhL6U6QIMgfzcfuDngMry6VI4C1+vFecFa95lRH0tb//hyp+DCg/iI2b0xT6UTPDNbP7t96N7lSlRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEfgJbW8; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWr1ZHVsz1GtNrGKchsHMhkJ3UEKhXCuOGXIcSOcPCLP1L99rOT6Z+sVE1C40iQSdlPPiEPImzLdKMdTGlF9UPKM/9ESCsqKNfN+CUqsGjIeH4s/SVzQyxaSdwfnFzw+F09QMchirzA3vAzfsqCajnlS9e83dm/kiZs6cYh9vdA5s8nR45u3S8TW/azw9VhUDxSPvBnSj1SGSswzQjfy1Xo98WguHMjreWLmwTJMdLyeWOQcjx53deKXquJEvcKXRFSOocIzKDqm6ygJESYQzkA0VhM+VUTg7mNsMrpkUs1czS5ikW59hT2BmTzafBFC6qOPw5EaMvAPzmtO7Jzd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anjJvAJdNH10wFt5vTTo5HCIea0ApbDRvyESsA2F0nE=;
 b=qulrAIx3r0hzASGKF7wK7JQHaDzGdeZE45XJFKLmWhiyb1raoddlhd4tuY5M+00pDz0t/e3TJXYjEy/a952QUOg9fe3a/SFIGD0oNYND2KasTO5rzSFaRpvH+kFrlrfpfSMaDK/HDhnqPdmUHRlm086DK4YW7IgBaGOdk9FH62XK7ap4o+/88dRgcJAnuwHS9GQoEDa1x3b+Bl9+tTMGK3ZDM/7m25XteIAY757Y74jBXVwg/+w5aU7r9uHllTWq2DAhVJsV7SYB0hwlW/Jui5L4r3wyMSi+KZBlalP1wwQuNUaWeLNmup5/sB5ZM/PozTQNUIZwPOKkeQZz7536TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anjJvAJdNH10wFt5vTTo5HCIea0ApbDRvyESsA2F0nE=;
 b=AEfgJbW8MU2ZQ+PGyk/Wx/+d4W9iMDoFa326tOuhGTyaXSun2iEMnWb0RY4kCCcRzprgbqmYEoP3vASJoJq9WfJGYwZk9fI3ERgPQQeoOFAyqvuOfqcFoHCbKhKh9L7GUN1HFaAyrdpIr+k7wkInuUUub4PP0LRyBEejt2ztpW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 21:45:54 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 21:45:54 +0000
Message-ID: <5b4988a0-90e2-4f85-83bd-bf54b3f69a12@amd.com>
Date: Tue, 27 Jan 2026 13:45:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: Alison Schofield <alison.schofield@intel.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan>
 <9f33dc8b-4d0c-4e0b-8212-ecf1a2635b5d@amd.com>
 <aXfrptWS1C5Pm2ww@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aXfrptWS1C5Pm2ww@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0574a1f6-6346-46f0-6ad3-08de5ded72b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXg2TUdPeDhRbWlUd1hyL1lUalVaYXhaS3h1VHFnSGxDN2V5UVNWZUtXL29q?=
 =?utf-8?B?d0ZzR2xjZ0x6MWtIZllRcWhPOHVLaS80RGpKd3F5R3NGdUs1R2U2WGY4Z2hX?=
 =?utf-8?B?eXVzN21mQi83VjdHUGZPRzhHMlo0UTg0VnFFVVR0R3JEM2F0aTUzVFZRS1FO?=
 =?utf-8?B?Nk4wVHF4Q01DQkMwYW5pUVN3TWpnMHk4bkdQWXF0MktUVStvaUdvS1piYmNw?=
 =?utf-8?B?UkxEWG5xbFE1M09VN3RUNUxUSzdTUlVSMlU2b2F6ZHBDZys1OXlZM2ZxSVV5?=
 =?utf-8?B?Sko5RHlDc2txaTIySnVSbXFITlVxWm41Z2h6Smx0OXBOTEdnbDNtUHNsWVVa?=
 =?utf-8?B?R2VyaWJWUzRZTWtDZUN6c2I5V3pqQjJ4VjF2NGt4VERuTFVUQTB6S0txaUhQ?=
 =?utf-8?B?eUpMV3JHNnpCZ01CTU1vYWJubWFHNzk3Sk1uYlpiQ3pCQTcyUjVvTFNqWmdF?=
 =?utf-8?B?M3hHQ1lKTmdqU3V3dlorZ09XM0Zqb3daSzNsM3MxQ1ZDOHpnb3BoSDJrV1kv?=
 =?utf-8?B?YklXT09BMXhMZkpNazhzUFN6SGgwNm9PMC9hbW5HK1JHdW5KM1lJb3NNV2VB?=
 =?utf-8?B?dkZ6K2U5QlY5cmoyUzMvRGg2S01KRlp0YjRrZ0RTV0ZoWm9iWlBLWTNFWDBn?=
 =?utf-8?B?WDRGRWtJVlZTT296QW10Y0lGeFJoeFlrTVBhVlJPbzBTWkJ1UWxTYm1BcThj?=
 =?utf-8?B?SEhrejVwNy8zNUp3c2pYay9pZGFjQ0xQRjdFaC9xb2thVFFSakVrUnlUbmdE?=
 =?utf-8?B?cW5lNFhUWE9pSlhQaUJySjZpSGVsRW1UZlhJYnh4MnZadGRpOWNTdXA0em5l?=
 =?utf-8?B?MTBNZ21qQWRLdkZkV29NbUFMR1BkUW8vd3dNM0JXdGJyNFZhbTR4cktNU01Y?=
 =?utf-8?B?MDNoUTVyWHZsaGEvdm56UGVYeFpZQkMwSHFBQ2ZRaGZOUzZyNDBEN0ZUdW1V?=
 =?utf-8?B?VFI1UEUvMjA2dE5EL2JCL2VyV1NEQ01kZS81R1NTSUl5Rmh2Z0VUVHBzM1dE?=
 =?utf-8?B?MDhhNTU3RHZacUZId09icWdnR01IMHF5Y1JXaVdJMU9nV0pzSnNQbTBuUHky?=
 =?utf-8?B?R2grUUNXQm9KS3V2ZGZFWUhQSm5vdVJYVklHWVlKMHpITmFjK0RRMVYzWVA2?=
 =?utf-8?B?eTU4NXc3Y1gybTZaMms4bGRSbWUxbjJtaVFjR3lybVowVDFMbzYra2gzQmVD?=
 =?utf-8?B?aEpESDZJb0o0NVMraHFucnVXRTErWHhBR0ZrYUR0Y0xrcUlqL3VvMTQrOGhz?=
 =?utf-8?B?WkNwRy8wNHNZTEhNVTlhdTVGSFBLU1ZHNkFiNHlLYTlqc1BHWjFYV3UxVEVn?=
 =?utf-8?B?eWVqck9aQ29PcFBlY3M2VHpwTlNvUlJqOW5oTElUTUFZVFFOQ25GZFJ0alpu?=
 =?utf-8?B?YjlxY3FDY1NSZHlEdU94RnBqSGpaTW04bVUxZWRNUXZjbDUrZnJkR1dhS3FX?=
 =?utf-8?B?NE9oYmR2c0ZGSjZHeWhBU0VRcU8rY0pUWmNNc2h3VlZ2QkFiV1haWDRBQVpp?=
 =?utf-8?B?QnN3K1J0N01NZFNqTDQwQlczYUNYRFdUcDVKbzdwaVpabFN1VSs2Z2pySVNI?=
 =?utf-8?B?M1ZtWDJFVE1nQ3ZwWjlMaVVCZHIya2ZPVUQ3bnVQUXpuazBPblZvNCtMTWJa?=
 =?utf-8?B?cXk1Nk9tZEdybVFIdmtGb3dKMmY5VTUyRkVDRmxPU2NwVE9aSDRBc0RhWHZE?=
 =?utf-8?B?RThROFlsQ21qT294UzB1V3FTUXJ3eWFLWEJMR0RlWnVVWnhkUDgxMGRDWVZk?=
 =?utf-8?B?NzFqT3BwS2NlQkt2bmwyUU9zTWFvNFFVSFo2Ry95bmV2WTlHb3o1SFhaaXZB?=
 =?utf-8?B?d1hVTWhVeXFwTXhFZ1FMemN0d1JwL291aXk0N1Y0MWFmbHhwYkY3bE9rdHNx?=
 =?utf-8?B?N2tNRmgyOHVCMm1wYXdNR2VEN0F5VHRRM0c1bU5xem9EQlFrbVZraDI0QjM0?=
 =?utf-8?B?dXNmOWplQ21MdXAzMkRHWVg3ZVE3TWNia2oza29Vcy9MMGRXcDUxTDNaUlBP?=
 =?utf-8?B?alBhTElqQ1ZCVnp5TXo4YTE1ZTk3cE5neHNxaE5Ka2dQOE1lVXZRUThXZTVy?=
 =?utf-8?B?STVTb0twd3ozRzlLTkViWHlibEtPM3BxYkdJNVBzZnBVSXM2OUxYOFk5Zi9M?=
 =?utf-8?Q?RDTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OS82N2dKUm8vRXdOeTlOWlVRVC9RNWlhbXlRUWlqcS9DUWdqZjJuYVVwVnQz?=
 =?utf-8?B?cTZrb0RXYjMrRERKRi9zSnBBbnlJandFTmlpZ2FwaC9TQklQUnBHeDhneVk3?=
 =?utf-8?B?WFZ5c1d4SnBHSnk2RkZRYTZneVRqSndRQ3Q2OTRaa2FVRGxQdjNLSFhtdUNv?=
 =?utf-8?B?czkzZ2tCL2RkRU45VmU3ZkYzQVVDUlg0VTZ4bzdUbG1GcUlNSjBhTHJnOVMx?=
 =?utf-8?B?dE4yUWlpYndzTXYvWk9LUWR1YlpRenAvY1NTTXQyUXQ2ZWtpYTNmNVpJZE5l?=
 =?utf-8?B?QS81anYzRmY0OHBnd0RyZEp6T1puenlRZWMvdVFTdHN1aGdYZUdtVE9yVGc1?=
 =?utf-8?B?ZmFNNjNiY0s5S0JoWm9mYXBiSEo3U2xFeXgzRStqVGtINnRkV3g5T1E5YVFp?=
 =?utf-8?B?TEt5UTl1UC9ic2JyT295MHZSaFRoWDhuUUlycGEvY0JoNUdoNDAwMmVtMGJr?=
 =?utf-8?B?ZjdnbzN0RVI1d1h1WXFBa3ZlQUNFeGw3N1ZTN3ZKZlBHT01oU1hmRnMwTUF4?=
 =?utf-8?B?aVc0L1Bod09wWHNSenFMZ1U2bUtYVm5JbjkyUFMxeGhUVnJ6aEI4Z2ZBeGli?=
 =?utf-8?B?RVdpZG9FU3g2Y2pxWEM2WmE0L1ZZVG1qall0Mzc5Sm00YlBoblZyamdLamtU?=
 =?utf-8?B?KzhxQVFXRmlZMUQ1UWpVZWllaVYvQkI4djBZWkNkZjU5WC93cmxWNE5NN1RO?=
 =?utf-8?B?bGVxcGJhQk03eWtGNUVGZm5NelJsWHovd3RVZThNc0RtQktzT0JoZVZuT1Js?=
 =?utf-8?B?dWtxMlNwTGl0Rk4yaFFRUmZUQk9Oa0p3bi9HZzFwUFpNMVplSUY0QUNwSlFM?=
 =?utf-8?B?UFJPNmw0cUFFT0hLMzc0WHpudEdlcVVKNldLZWV6eWNNYkk4NlN4cGNRc05G?=
 =?utf-8?B?T05Sd1VjMVRoeHo2L091aUlxUkljbDZueTdhbVJsb2NBd2tRTjVJV0tmU09L?=
 =?utf-8?B?OXlrWUwyUzN5MkJwbXREWWlSUjZ2ZlJtdk9hYldYaElKYlpSYWI4YmE5bW9p?=
 =?utf-8?B?cUMvcHBmd2F2VFJodHl6L0hCaSthK1prQzNDcGV4UnZTdEpWQmhBRHM3d1lW?=
 =?utf-8?B?SXZOQnNRRTZmbStkUkQxWU9MS3dmbkNPLzJ2dzF0bUJKaDdsMHE4emc4NEZY?=
 =?utf-8?B?cmpON1FuZXdHamNUTmM0SXc5eTVaL1NVc3NqM1VvSkc0NElVME9KOTBuR0R1?=
 =?utf-8?B?a3Z4S3ZVVDdPVEk0ZS81UTUwemlEbEdYSFpMbnU5ZU9uZU14NVM4ajVsUWtP?=
 =?utf-8?B?c0pWQThRVWRVR3d1bGNYT0EyQ25KNUZXVDVIQ2FIRHR6MXd5Q0tjMjRtR2Fa?=
 =?utf-8?B?Q3FYQUhnendGT2MxQ0RBcUxaT2RXUnMwa3lMOUlhaHBHK1d0VXBYVCthV3k1?=
 =?utf-8?B?eEI5NmY0ZHhZU1pnMDR1aVNpU0Y5ektnNkVDbmZ5bEg2MXV4amNpK2xnNE8r?=
 =?utf-8?B?bGc4N1pQZHlHdE1hQk9zTGZkSWR1TVgrTytUMHJsQnZwdTVpT3l2MjdnWXRJ?=
 =?utf-8?B?aTYvNHZCeGZsd2svaExML0NsbXQ5OEJQS1NhZGlyV2gwdkw2b2ZncjJaaFpC?=
 =?utf-8?B?ZHdsekpDMmpWUHNncnNqUUxwWlgwSDl1V25OUjg2dlJ0aGd4RXd0MmRCYVZL?=
 =?utf-8?B?OENJR012Wm5LRElUeVZjakc1TmFFUnk0dHJZOTFWN2FOVTFwenQ1V0x6NDdB?=
 =?utf-8?B?Z2EwWGovTFVmcDZZamFpT25lNGVmSjF3Y3JodTd5cEtOaVMvZGVERVRvZFFi?=
 =?utf-8?B?VDFyWmwyRTV0QzJGeCs1WUtEaVRGdjF4ejY3Rm1GUExjNkZuYzAyMk5kNzJt?=
 =?utf-8?B?V2dGM2pyK2dqU2VaYmpqQVB1eW81S3RXbm5VWngxd2FSVFhHcXhuYlVVNGps?=
 =?utf-8?B?WkcxZVJsekdZZDVYTjlCaFozTjhCM0dVUHcrUXBDQVNhdGZHVXMzTDBzQ3hx?=
 =?utf-8?B?eVJtOWRFeVk1WWpnNlFwT1AzRERFVWczckFFUDlFT29DMW5tSjRYb1RLQW1J?=
 =?utf-8?B?anJMbUpJMDl5U25oRllsaTJNaURObHlLSWZRMmlIKzhCRWh3cUp4MzhtaVpn?=
 =?utf-8?B?UDI2MjVlV2NjdndrWmRoTEhVVG13c3dtYjhoTTJEQURRazRVL09yL1pxSU1k?=
 =?utf-8?B?MEhwZHpYYlNnVjNhYUxINHdkRmhVN2JwOWpNb1NsMzJvTzhvRlhBcVhGNGpH?=
 =?utf-8?B?S3gzQlpqSmlISUNUemR5RTBtcGZyWGw1bmExckxEL0pRTVA1VjlmUzNXY0k0?=
 =?utf-8?B?eHMwSTNNdStlUEFEVmZSN0tZVmRsTFdhWmRhVnV1VnZpS2FOaTJvUzdhaTd0?=
 =?utf-8?B?M09NVEwzbm5wd3Y1Zm9na1owci83RUU4SEsrMUlOYXNQRkhITXdJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0574a1f6-6346-46f0-6ad3-08de5ded72b7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:45:54.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WajwvX8pNE75Luo32GjcNg6ovuaVI+CCHr33F+9eZU8Qb/nq9oFAt3ydUFuJ72xsbV5kSjLlmK6MU5B8w2b1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75652-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 10F429ACB5
X-Rspamd-Action: no action

Hi Alison,

On 1/26/2026 2:33 PM, Alison Schofield wrote:
> On Mon, Jan 26, 2026 at 01:05:47PM -0800, Koralahalli Channabasappa, Smita wrote:
>> Hi Alison,
>>
>> On 1/22/2026 10:35 PM, Alison Schofield wrote:
>>> On Thu, Jan 22, 2026 at 04:55:42AM +0000, Smita Koralahalli wrote:
>>>> The current probe time ownership check for Soft Reserved memory based
>>>> solely on CXL window intersection is insufficient. dax_hmem probing is not
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
>>>>      - If all Soft Reserved ranges are fully contained within committed CXL
>>>>        regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>>>        dax_cxl to bind.
>>>>
>>>>      - If any Soft Reserved range is not fully claimed by committed CXL
>>>>        region, tear down all CXL regions and REGISTER the Soft Reserved
>>>>        ranges with dax_hmem instead.
>>>>
>>>> While ownership resolution is pending, gate dax_cxl probing to avoid
>>>> binding prematurely.
>>>
>>> This patch is the point in the set where I begin to fail creating DAX
>>> regions on my non soft-reserved platforms.
>>>
>>> Before this patch, at region probe, devm_cxl_add_dax_region(cxlr) succeeded
>>> without delay, but now those calls result in EPROBE DEFER.
>>>
>>> That deferral is wanted for platforms with Soft Reserveds, but for
>>> platforms without, those probes will never resume.
>>>
>>> IIUC this will impact platforms without SRs, not just my test setup.
>>> In my testing it's visible during both QEMU and cxl-test region creation.
>>>
>>> Can we abandon this whole deferral scheme if there is nothing in the
>>> new soft_reserved resource tree?
>>>
>>> Or maybe another way to get the dax probes UN-deferred in this case?
>>
>> Thanks for pointing this. I didn't think through this.
>>
>> I was thinking to make the deferral conditional on HMEM actually observing a
>> CXL-overlapping range. Rough flow:
>>
>> One assumption I'm relying on here is that dax_hmem and "initial"
>> hmem_register_device() walk happens before dax_cxl probes. If that
>> assumption doesn’t hold this approach may not be sufficient.
>>
>> 1. Keep dax_cxl_mode default as DEFER as it is now in dax/bus.c
>> 2. Introduce need_deferral flag initialized to false in dax/bus.c
>> 3. During the initial dax_hmem walk, in hmem_register_device() if HMEM
>> observes SR that intersects IORES_DESC_CXL, set a need_deferral flag and
>> schedule the deferred work. (case DEFER)
>> 4. In dax_cxl probe: only return -EPROBE_DEFER when dax_cxl_mode == DEFER
>> and need_deferral is set, otherwise proceed with cxl_dax.
>>
>> Please call out if you see issues with this approach (especially around the
>> ordering assumption).
> 
> 
> A quick thought to share -
> 
> Will the 'need_deferral' flag be cleared when all deferred work is
> done, so that case 2) below can succeed:

My thinking was that we don’t strictly need to clear need_deferral as 
long as dax_cxl_mode is the actual gate. need_deferral would only be set 
when HMEM observes an SR range intersecting IORES_DESC_CXL, and after 
the deferred work runs we should always transition dax_cxl_mode from 
DEFER to either DROP or REGISTER. At that point dax_cxl won’t return 
EPROBE_DEFER anymore regardless of the flag value.

I also had a follow-up thought: rather than a separate need_deferral 
flag, we could make this explicit in the mode enum. For example, keep 
DEFER as the default, and when hmem_register_device() first observes a 
SR and CXL intersection, transition the mode from DEFER to something 
like NEEDS_CHANGE. Then dax_cxl would only return -EPROBE_DEFER in the 
NEEDS_CHANGE state, and once the deferred work completes it would move 
the mode to DROP or REGISTER.

Please correct me if I’m missing a case where dax_cxl_mode could remain 
DEFER even after setting the flag.

Thanks
Smita

> 
> While these changes add sync and fallback for platforms that use Soft
> Reserveds, protect against regressing other use cases like:
> 
> 1) Platforms that don't create SRs but do create auto regions and
> expect them to either automatically create dax regions on successful CXL
> driver assembly.
> 
> 2) Plain old user space creation of ram regions where the user expects
> the result to be a CXL region and a DAX region. These may occur in
> platforms with or without Soft Reserveds.
> 
>>
>> Thanks
>> Smita
>>>
>>> -- Alison
>>>
>>>>
>>>> This enforces a strict ownership. Either CXL fully claims the Soft
>>>> Reserved ranges or it relinquishes it entirely.
>>>>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>>> ---
>>>>    drivers/cxl/core/region.c | 25 ++++++++++++
>>>>    drivers/cxl/cxl.h         |  2 +
>>>>    drivers/dax/cxl.c         |  9 +++++
>>>>    drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>>>>    4 files changed, 115 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 9827a6dd3187..6c22a2d4abbb 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>>>    DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>>>    			 cxl_region_debugfs_poison_clear, "%llx\n");
>>>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>>>> +{
>>>> +	struct cxl_root_decoder *cxlrd;
>>>> +	struct cxl_region *cxlr;
>>>> +	struct cxl_port *port;
>>>> +
>>>> +	if (!is_cxl_region(dev))
>>>> +		return 0;
>>>> +
>>>> +	cxlr = to_cxl_region(dev);
>>>> +
>>>> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>>> +	port = cxlrd_to_port(cxlrd);
>>>> +
>>>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +void cxl_region_teardown_all(void)
>>>> +{
>>>> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
>>>> +
>>>>    static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>>>>    {
>>>>    	struct resource *res = data;
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index b0ff6b65ea0b..1864d35d5f69 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>>>>    struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>>>    u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>>>    bool cxl_region_contains_soft_reserve(const struct resource *res);
>>>> +void cxl_region_teardown_all(void);
>>>>    #else
>>>>    static inline bool is_cxl_pmem_region(struct device *dev)
>>>>    {
>>>> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>>>>    {
>>>>    	return false;
>>>>    }
>>>> +static inline void cxl_region_teardown_all(void) { }
>>>>    #endif
>>>>    void cxl_endpoint_parse_cdat(struct cxl_port *port);
>>>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>>>> index 13cd94d32ff7..b7e90d6dd888 100644
>>>> --- a/drivers/dax/cxl.c
>>>> +++ b/drivers/dax/cxl.c
>>>> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>>>    	struct dax_region *dax_region;
>>>>    	struct dev_dax_data data;
>>>> +	switch (dax_cxl_mode) {
>>>> +	case DAX_CXL_MODE_DEFER:
>>>> +		return -EPROBE_DEFER;
>>>> +	case DAX_CXL_MODE_REGISTER:
>>>> +		return -ENODEV;
>>>> +	case DAX_CXL_MODE_DROP:
>>>> +		break;
>>>> +	}
>>>> +
>>>>    	if (nid == NUMA_NO_NODE)
>>>>    		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>>>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>>>> index 1e3424358490..bcb57d8678d7 100644
>>>> --- a/drivers/dax/hmem/hmem.c
>>>> +++ b/drivers/dax/hmem/hmem.c
>>>> @@ -3,6 +3,7 @@
>>>>    #include <linux/memregion.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/dax.h>
>>>> +#include "../../cxl/cxl.h"
>>>>    #include "../bus.h"
>>>>    static bool region_idle;
>>>> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>>>>    	platform_device_unregister(pdev);
>>>>    }
>>>> +struct dax_defer_work {
>>>> +	struct platform_device *pdev;
>>>> +	struct work_struct work;
>>>> +};
>>>> +
>>>>    static int hmem_register_device(struct device *host, int target_nid,
>>>>    				const struct resource *res)
>>>>    {
>>>> +	struct dax_defer_work *work = dev_get_drvdata(host);
>>>>    	struct platform_device *pdev;
>>>>    	struct memregion_info info;
>>>>    	long id;
>>>> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>>>>    	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>>>>    	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>>>    			      IORES_DESC_CXL) != REGION_DISJOINT) {
>>>> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
>>>> -		return 0;
>>>> +		switch (dax_cxl_mode) {
>>>> +		case DAX_CXL_MODE_DEFER:
>>>> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
>>>> +			schedule_work(&work->work);
>>>> +			return 0;
>>>> +		case DAX_CXL_MODE_REGISTER:
>>>> +			dev_dbg(host, "registering CXL range: %pr\n", res);
>>>> +			break;
>>>> +		case DAX_CXL_MODE_DROP:
>>>> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
>>>> +			return 0;
>>>> +		}
>>>>    	}
>>>>    	rc = region_intersects_soft_reserve(res->start, resource_size(res));
>>>> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
>>>>    	return rc;
>>>>    }
>>>> +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
>>>> +				     const struct resource *res)
>>>> +{
>>>> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>>> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
>>>> +		if (!cxl_region_contains_soft_reserve(res))
>>>> +			return 1;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void process_defer_work(struct work_struct *_work)
>>>> +{
>>>> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
>>>> +	struct platform_device *pdev = work->pdev;
>>>> +	int rc;
>>>> +
>>>> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
>>>> +	wait_for_device_probe();
>>>> +
>>>> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
>>>> +
>>>> +	if (!rc) {
>>>> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
>>>> +		rc = bus_rescan_devices(&cxl_bus_type);
>>>> +		if (rc)
>>>> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
>>>> +	} else {
>>>> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>>>> +		cxl_region_teardown_all();
>>>> +	}
>>>> +
>>>> +	walk_hmem_resources(&pdev->dev, hmem_register_device);
>>>> +}
>>>> +
>>>> +static void kill_defer_work(void *_work)
>>>> +{
>>>> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
>>>> +
>>>> +	cancel_work_sync(&work->work);
>>>> +	kfree(work);
>>>> +}
>>>> +
>>>>    static int dax_hmem_platform_probe(struct platform_device *pdev)
>>>>    {
>>>> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
>>>> +	int rc;
>>>> +
>>>> +	if (!work)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	work->pdev = pdev;
>>>> +	INIT_WORK(&work->work, process_defer_work);
>>>> +
>>>> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	platform_set_drvdata(pdev, work);
>>>> +
>>>>    	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>>>    }
>>>> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>>>>    MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>>>>    MODULE_LICENSE("GPL v2");
>>>>    MODULE_AUTHOR("Intel Corporation");
>>>> +MODULE_IMPORT_NS("CXL");
>>>> -- 
>>>> 2.17.1
>>>>
>>
> 


