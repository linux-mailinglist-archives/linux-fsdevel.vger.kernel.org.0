Return-Path: <linux-fsdevel+bounces-75539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JVfLULXd2mFlwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:06:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B08D7F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF168301AA6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BEF2DEA90;
	Mon, 26 Jan 2026 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XErw+koI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2292DCBF8;
	Mon, 26 Jan 2026 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461557; cv=fail; b=d/DDGKFUoLEavi2cidBYqGFEg91QtVLZb0gxdcLNLVvdr/g1RY3QftKdpJWNERgvpJiOSvTKqOkvapBHYk4BXe/0rNjZQUnaGjueqvKOksN8nFUnnBqJOpr7E3g56PfqLYyHQX2ENt3Y1j34MuGIJcIzTPGDCAHyYoeyL1OVnwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461557; c=relaxed/simple;
	bh=hUDDk8mvOhpf/RXuezRpsvOCIf0tnm+WwkD4hetaiaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6neo6nQqkxXUkF1CKRu//nivijST9V46mNtkBjHI5nVNi78Zu0dQDgk07aKgjld701pKn44zG0Mfd/FwgPb+jIkeik85Ykt/7vNErGIGLKaAoupO0Pz4XaE0VCnMeLhW1Lk8cCOo54CRFM1uBMYSFmkqKVjb1i1vbyVKlq3RyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XErw+koI; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWKagA91NcvA8H1jte6mOEp8aEgjpmuF79k0hy2Zj7cwXhEwlOvLKr7Wpq6MmV7Srp0GTPwgVOOT18W0kksfFfQevu/Fh7UzM1FoBIzOzvY2vvB8EzCaWxMLVpEy2GalnQxXPVHp0XdIg/HPRE44rvzQ1BfmYYvZQI3fJCUuHDw7lPPpRBZjldutd/f71PbBz7sYeJ+SJzthsjBwtK5oIDAzYJJfP4GQyyEpEjOzMsNAPDBReIYya8D8CKW6vURWnoAK2VPmKXZQjHHIvCrDK45XZVg6+OBHNOMrah4sgiw68ATaFYC6DTeK57WY8W/wczpQ9QyAbMHejaTVju+5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l92GbjMkHZ5vo8Dh4bVG2Pw9fowuW7F+zfP7VtpfmeU=;
 b=tIt7MtjoOgUIhb5k+qT1NukimcDcqkEwS0AkMK08ZPzKXpbSuSdq8NYGuAj70KGMKKmz5tT8xmLUNCX5hvE8iA9G2MZ+D4AlIYTYq+T9UHtroy3JWiQuz6lINAPmHQ9teCAXSF8xuPU+hpCB8S8TW28PlXLtLSSxefuRrsEqa4HF18VwOOjvkzOgvWbio8U3MBUznLnC8zvfh9Rc2VWvWeIQUkcQsMPPM9BOPfggJHIY1yVLJBh/OBfaLAoWVMCXK2bpspCBnFSLUvGopZDYsoZVXBvLOao3IifRT+0Vpizz7M90Pl0t0ryNuRfKhwcWPwf6KYN3IxAdNvOKDW91Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l92GbjMkHZ5vo8Dh4bVG2Pw9fowuW7F+zfP7VtpfmeU=;
 b=XErw+koIjXSsZM0hYQxvWT3f0S4qe27qccU7AEDuH+zyYW8EZ3K7KgzThz84Lbn1Qxu5WIOvj7TxMbx3Dx+FfXbtB0vTs2OTRv8yCKRmt0CjSC/arvu1XqBTAz0Zl5Sw7g18GyRxroFcmvjJmnfqy89ZuBteg5IX8JSleydxlvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 21:05:51 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 21:05:51 +0000
Message-ID: <9f33dc8b-4d0c-4e0b-8212-ecf1a2635b5d@amd.com>
Date: Mon, 26 Jan 2026 13:05:47 -0800
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
 <aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: ababfe97-150d-4164-6f87-08de5d1eafca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekVXM0xlUllNcU1yS3ZQTXFhc1l2eEhLWjZxaTNLUC80YmVycWN1cUhMWlgz?=
 =?utf-8?B?bWN2RlBSV3d2L3hTaFNaNkdCeEd0Q3RIR2F0a0xwZVBNWS9US0UzNDcxdktp?=
 =?utf-8?B?ZE8xZWp0b0p3NVU3aFRXL0R5cElHc0FWRUJ3ZG5OeXlCSnpkVFpzRlorUVZk?=
 =?utf-8?B?NDI3enZsN2tlTXVGalVlOTNSSFhiOEp3UGkzT1htL1FrcTkvc0pNdnBmalZV?=
 =?utf-8?B?cysvempyOHRVdERxQjl2VWFGTmdhRldDVTlZV1BMOWNVUXZjeDI0R1hFTVpp?=
 =?utf-8?B?OE9OZnFoMm1oSzU4a2E5Z1BBTlphNm9nUS9rMjhzRk9GQ1d2R1RTL2M0WFgz?=
 =?utf-8?B?K1lWTEdDUkoyc1pSc1pBdEI4RUdRSkE5eUdtSStRYUswSGVpQXc1UWlYVytq?=
 =?utf-8?B?MUlnckpZajB6Z2VKclZIUysvZ2s3d1U0ajlyUElOVE5NcVVEdHVMOTZFWlVm?=
 =?utf-8?B?Tjh3NENFR2VvclBreGgzT2Q3ek5xVWFsWDhYQlBxZDlmdVJXdWVlVE9vdldR?=
 =?utf-8?B?bDhlcmxhbnVKendxajBGdFlHQVFtWXhCQURFRk5GRFRaQXNsNVpZYldCR0tV?=
 =?utf-8?B?V2ttM283NGRGYUhBUFZMTmZaZXdOL05STW1mNVpNVWZ5VjUrbE1RNThiSmda?=
 =?utf-8?B?cHRFUk1vNm9yREZiMHg0RFNKNlNIc3ZjRnlBMnVZTjRJRTNMRXFMN1o0bmI1?=
 =?utf-8?B?TC9wMHI5c2c0N2l4M3pzWnM1UGZacHRBQXdyU3NKSFhHSVZCTU05ejJBT3du?=
 =?utf-8?B?YnVuNTUvMzdNajVNbzdIVWI0bHVKTVNQVGVmMnhZRXMya05uQ3NNbllySzhK?=
 =?utf-8?B?U2ZOZnBOWWtybjYvVS9DU1Ayb09DUEFxM2Vid3NicjBKS0VUeFYxamFtdXdH?=
 =?utf-8?B?ajVWOTh2Rkd0Q2Qra3k0VEdlRHQ3VEtUWGF0a05tK2FOOG80aHp5aEcxK1hK?=
 =?utf-8?B?WCtueHNTNzVsbnVBeEIzZ1dYcHAxWDlWV2NxNUorR0dwZnpabWMrMnk5Kzk4?=
 =?utf-8?B?WnhwMzhxTWFFL1g2bDRISVpxZ01WUWhDNnZRMjZ6WWRrc016dWZXcWpNWlFa?=
 =?utf-8?B?THJJVzMwTnJ6aWpqVWR4VjZaWXpiS2JGMGxhd2xTMFIrNHlCR3JrT1J4UTFm?=
 =?utf-8?B?a1FROVU0RWJiTE9UcGhKYndFUCthSG9aUDNwTVdXTmI0S2JTNnVha3hMOE94?=
 =?utf-8?B?Z1hBaWJUTlRYZHNRdmtTL3AzYkVqQ1FmR1JCZkw4dkNBNm1zVk1NRzdzZnh1?=
 =?utf-8?B?TUpBUzBIUjlIVzl6L200dDVQcWlOU2dBVG1kRHgyeVVVUzFkejViNWU3NVg4?=
 =?utf-8?B?WXFtYlY2Y1BaYTV3SUdjWFFUNTJmWml2dzM3bVN6amVvd0tuUVc3VndFdU5I?=
 =?utf-8?B?a3loQWM3RHVURTFEKzhJblhacWpkNkF1ekhzRmRJbWRhSXlMNVBYcVpYbUJV?=
 =?utf-8?B?UnlNT2pjKzM5dGJJUHZtY2Ric1l4ckMremR0UEtkOHRRUnpuelFuZ213YjY4?=
 =?utf-8?B?U3htRFM4TXlEMDZDZm05elVNK2V2Slh0dlJtTnp1SEtJQ3FtWUJxZ3phYU5X?=
 =?utf-8?B?OWlLRHMrK2JBWHlocEE0WmE2OGZCMlBqSEJBbmtHMXRBTmNlZmxvclJWNWQ4?=
 =?utf-8?B?NmpPbHh1ekhQRnpIb0VWc2lQY0xUbDQ3cndxOEllMkFaNStKaFhDYllRaHdY?=
 =?utf-8?B?V2ZVTTk3aW1Lcjl6RVd4OFovNzRGTUlLUFAvTzlwY0s2c212b0QxTVk2dFg3?=
 =?utf-8?B?aGZEbkxINWZRUlpKbGJLR3c2MHlyclVkdjhlY2hmNDdMVm1xM0czaTdmN2xs?=
 =?utf-8?B?MnlOUGlMc0ZWck5wbTB2RWpqZjNwZjVDY2hiY3E4RXZReldNUkU2OXRKL3ND?=
 =?utf-8?B?YXl5QzI5Nk56QUh6d0pIZXMxamtRb0ZxbDdUUmpZalJIUkhZc29uYUlyRkEr?=
 =?utf-8?B?T3UrOC9Pd0ZIbHNLenlsRE9ncGp6U2xaOGNVZGpKcGN2ZlBaV3IrWlBqcE1u?=
 =?utf-8?B?clBjY1pwTnBmeXBSRmsraHlsZEtRcnovNVhKZldvZzdFRkkxTjA1cnFiaWM1?=
 =?utf-8?B?eEMzc2dLa2dWc2E4aXk0MnNTQ292SWhZdXRPenRYRG5ERlhvdkFlRjZOV3g5?=
 =?utf-8?Q?6tdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjB1M0gwOExQMjJZaGRweUd5TDg1bmxkMWgyVEV0akRHb2gwcnZEUFc0TjIz?=
 =?utf-8?B?WEc3cm9ma2htYU9EVEh6QkZmM0RjS0daWWtDR25YQ2lzRWk2YmxheUZiRFVu?=
 =?utf-8?B?d04rWVAvUU1aL2EremlJR2RJelo1eFFqQTNOa05DQ1JHWkVFVjF5U3ZtWXJj?=
 =?utf-8?B?b0swZThRNVpCblI4MUxWaHZDKzZFNHZaVEFSWVJ1VHpUdzZCQktMY1ZxM0hV?=
 =?utf-8?B?VTAxZzFCMXZvOU1Pd3JJM3pGZ0VaQ3VWU25jU0tHREdhWGJBNGN1eFhyN0lI?=
 =?utf-8?B?ZzJybTBmdzM5TFFYRmdsd3JIWVZyK3UxMG11TU1lMXlxZVJBVmFpTk5qeG94?=
 =?utf-8?B?Tm5NMHRiYWRpdDh4ZnV6UldrR3FUS09wU1Y0VnRZQmVNV215bDJhOUlQMnp4?=
 =?utf-8?B?bm1kMDJWY0FiZG16Z3ZuU3VwUitRaHlFV01keHFmQzB1WVdxYURPNU9SclM2?=
 =?utf-8?B?Z0dCYXErZUJxaFNIcEJTMXBsdGNPNTZESjZxR1FHWjlaUm9FcWdwbnNhYis5?=
 =?utf-8?B?RldqVk52WWppNE9DS2RwNnNZMEF5cDZBYm1MQTd4aHdiQnJaWEZQanpaa1JP?=
 =?utf-8?B?RTlsZ3N1Mk5OOVBzUE9oUkxKZjhsbTdCcW02TVhHU29GQnY0TFRkZ01aYjgr?=
 =?utf-8?B?alV4R3g2SGVRMG5vNWorZ0ZSbGtlWWpQYjA1enczWnhIRUI1d1NqSTEvUUQr?=
 =?utf-8?B?Lys0UFpRWjRkLzUrb3FHWHZtR204eGYybnh5OStMNmxhQ0I2NlhMTWk3ejNK?=
 =?utf-8?B?TjAxeFdVYS9IamJGdTZia2NKUmlKY0FNTGhaejVzd0Y5NUk1eTcrZTRkbkNw?=
 =?utf-8?B?eURXUHFiZmZHYkZiK2NIaDYvcExCdXlsYm9YbUVLWUZQNlVpVTY5MXAzV1po?=
 =?utf-8?B?REhrNVQ5WmNOaWVnbnhWdElsK1BMdDFtZ3E4ODltOGdqZHJRRjUvYkxwVHNU?=
 =?utf-8?B?bm5VR0ZyY0h6d3pNaXZXQWloOWVyaE15NVQ1OW9ZMHJhS1VaaStTeTkvT1pI?=
 =?utf-8?B?aFpOSWxGVDY2SkdUUFJXdm9mc09kRkpqK0R2NzB2NDl5bWlHd2M4UFpsaUJr?=
 =?utf-8?B?TEF5SVd3MGhzSW5mN2tpYWRUOFIyQUIvRXUyUHlwbjN0VlRBMW0zK2tHbzh5?=
 =?utf-8?B?WXo3RXVNa3liOFFGb2xFQlVEZ2hTbHpGcVdsejBmejJvNXlFYzdUeG94cURJ?=
 =?utf-8?B?SnNDbGJnSUthQys4Vm4xSWZZQk9ndHA5L1lTTEpEb3hpKzdBV1BPTnF0eVU1?=
 =?utf-8?B?WldicDg1T0xla294RVMxeElYVnh5YVNwRWNMbDd2bm1rVlpyejNOdjFkUmdp?=
 =?utf-8?B?aE9YZS9uWmttajFUYnppRGFaZW9yYWtLSmFGZjhFOHB0bXZwVk5zVzM1NTZ0?=
 =?utf-8?B?eG9NYUw4Z2g1M0N2SWRjQnUvU0xMUncyRHB3MXNaM3FjSWhXQ0xXNGdjQm90?=
 =?utf-8?B?N2t2NTdLbmYwWlZHa0xqOEJaMlBEanJJUS9vTzl1d2Mrd0pmZ2gyZGhYQVpG?=
 =?utf-8?B?WEplUW82ZlF5RCtLc3hRZ0JNL3dYRFJlN3BHdi8vdXlkMER6eEdwVnlIZDRk?=
 =?utf-8?B?UlZwWjBJTG5wbmp5M3ZPWEkvZ1o5eEd0TmVZanZoRFRkeDRzYkw3a2JrNEg2?=
 =?utf-8?B?Y2kyWHBQbDdxN1ZaVENvbkYxYVBaZGRuWnh2V1E5SDF6NkN2Ulo2N0FUMS9o?=
 =?utf-8?B?YzR6UC96Szcra0VUWFBlUVZsUkpvNnVYNUUwaHlKTExmOG03Tzh4SXdqNTZo?=
 =?utf-8?B?ZVZNTW5UK0J2UUpTOWpDMzdxbDVZY0ExUmxNTDNjVld6SG9KVFpNbjU5ZVZj?=
 =?utf-8?B?dXdNTlNWT3ZCdUdHdjdxMktkS2FNWUF3MjhrUlFXc3VKR0FpaHByTGdLUi85?=
 =?utf-8?B?YUp1ZGwxV2tCdURQZGRIQWFZMjhUaVdSZUs1cHE3N2dkWGFxSXMyVkRURFd1?=
 =?utf-8?B?S21NSzhiNTJGTkJGdzIxNmFsejg4QU10S3dNQTZLeWcyWk9JK3JDQzluTnVC?=
 =?utf-8?B?cmhqdnFCM0ZYZWdYb2szT0dkNDc2OEs5MlpMVHpFM0hhS1lVNldkV29ZNmVM?=
 =?utf-8?B?Si94TnVKeWxkaGJRSSt1RUVIMlpDakV1UnVkN2hpdWdJTXJHQ0Z4eE4rcitn?=
 =?utf-8?B?eTFCRklFNUlsSjdOdlN2S0NnckNSWXh1TVNRbklieE54T0piS0RGckRibjhH?=
 =?utf-8?B?TmJ1YnlKR0YxUWNQQ2tOMlc5ejJ5QXlYK21rR0VBK2ZxeTNOYXRaSVQyR2gx?=
 =?utf-8?B?d2ZFOWU1OGVVMGpsZ1ozS0RwSmJtb2hFaVJIUTQ2Z3BJZm5HbkovQ2V1d2xy?=
 =?utf-8?B?VUlPNUJERUtLZlNsNU5uMGpWVzl4bEhCYWlqQUVVZEY5TTA3d245Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ababfe97-150d-4164-6f87-08de5d1eafca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 21:05:51.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yohxXAF6Cp+lQt9gAHHCcQYUushgyIRcq5CjtDkfgMzzI6e0PEyk85WVf1uBri8OYXacMmjw1D1xC7TEXI3kYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
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
	TAGGED_FROM(0.00)[bounces-75539-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A7B08D7F3
X-Rspamd-Action: no action

Hi Alison,

On 1/22/2026 10:35 PM, Alison Schofield wrote:
> On Thu, Jan 22, 2026 at 04:55:42AM +0000, Smita Koralahalli wrote:
>> The current probe time ownership check for Soft Reserved memory based
>> solely on CXL window intersection is insufficient. dax_hmem probing is not
>> always guaranteed to run after CXL enumeration and region assembly, which
>> can lead to incorrect ownership decisions before the CXL stack has
>> finished publishing windows and assembling committed regions.
>>
>> Introduce deferred ownership handling for Soft Reserved ranges that
>> intersect CXL windows at probe time by scheduling deferred work from
>> dax_hmem and waiting for the CXL stack to complete enumeration and region
>> assembly before deciding ownership.
>>
>> Evaluate ownership of Soft Reserved ranges based on CXL region
>> containment.
>>
>>     - If all Soft Reserved ranges are fully contained within committed CXL
>>       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>       dax_cxl to bind.
>>
>>     - If any Soft Reserved range is not fully claimed by committed CXL
>>       region, tear down all CXL regions and REGISTER the Soft Reserved
>>       ranges with dax_hmem instead.
>>
>> While ownership resolution is pending, gate dax_cxl probing to avoid
>> binding prematurely.
> 
> This patch is the point in the set where I begin to fail creating DAX
> regions on my non soft-reserved platforms.
> 
> Before this patch, at region probe, devm_cxl_add_dax_region(cxlr) succeeded
> without delay, but now those calls result in EPROBE DEFER.
> 
> That deferral is wanted for platforms with Soft Reserveds, but for
> platforms without, those probes will never resume.
> 
> IIUC this will impact platforms without SRs, not just my test setup.
> In my testing it's visible during both QEMU and cxl-test region creation.
> 
> Can we abandon this whole deferral scheme if there is nothing in the
> new soft_reserved resource tree?
> 
> Or maybe another way to get the dax probes UN-deferred in this case?

Thanks for pointing this. I didn't think through this.

I was thinking to make the deferral conditional on HMEM actually 
observing a CXL-overlapping range. Rough flow:

One assumption I'm relying on here is that dax_hmem and "initial" 
hmem_register_device() walk happens before dax_cxl probes. If that 
assumption doesn’t hold this approach may not be sufficient.

1. Keep dax_cxl_mode default as DEFER as it is now in dax/bus.c
2. Introduce need_deferral flag initialized to false in dax/bus.c
3. During the initial dax_hmem walk, in hmem_register_device() if HMEM 
observes SR that intersects IORES_DESC_CXL, set a need_deferral flag and 
schedule the deferred work. (case DEFER)
4. In dax_cxl probe: only return -EPROBE_DEFER when dax_cxl_mode == 
DEFER and need_deferral is set, otherwise proceed with cxl_dax.

Please call out if you see issues with this approach (especially around 
the ordering assumption).

Thanks
Smita
> 
> -- Alison
> 
>>
>> This enforces a strict ownership. Either CXL fully claims the Soft
>> Reserved ranges or it relinquishes it entirely.
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 25 ++++++++++++
>>   drivers/cxl/cxl.h         |  2 +
>>   drivers/dax/cxl.c         |  9 +++++
>>   drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 115 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 9827a6dd3187..6c22a2d4abbb 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>   			 cxl_region_debugfs_poison_clear, "%llx\n");
>>   
>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>> +{
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_region *cxlr;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_region(dev))
>> +		return 0;
>> +
>> +	cxlr = to_cxl_region(dev);
>> +
>> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_region_teardown_all(void)
>> +{
>> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
>> +}
>> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
>> +
>>   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>>   {
>>   	struct resource *res = data;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index b0ff6b65ea0b..1864d35d5f69 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>   bool cxl_region_contains_soft_reserve(const struct resource *res);
>> +void cxl_region_teardown_all(void);
>>   #else
>>   static inline bool is_cxl_pmem_region(struct device *dev)
>>   {
>> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>>   {
>>   	return false;
>>   }
>> +static inline void cxl_region_teardown_all(void) { }
>>   #endif
>>   
>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>> index 13cd94d32ff7..b7e90d6dd888 100644
>> --- a/drivers/dax/cxl.c
>> +++ b/drivers/dax/cxl.c
>> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>   	struct dax_region *dax_region;
>>   	struct dev_dax_data data;
>>   
>> +	switch (dax_cxl_mode) {
>> +	case DAX_CXL_MODE_DEFER:
>> +		return -EPROBE_DEFER;
>> +	case DAX_CXL_MODE_REGISTER:
>> +		return -ENODEV;
>> +	case DAX_CXL_MODE_DROP:
>> +		break;
>> +	}
>> +
>>   	if (nid == NUMA_NO_NODE)
>>   		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>>   
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 1e3424358490..bcb57d8678d7 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/memregion.h>
>>   #include <linux/module.h>
>>   #include <linux/dax.h>
>> +#include "../../cxl/cxl.h"
>>   #include "../bus.h"
>>   
>>   static bool region_idle;
>> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>>   	platform_device_unregister(pdev);
>>   }
>>   
>> +struct dax_defer_work {
>> +	struct platform_device *pdev;
>> +	struct work_struct work;
>> +};
>> +
>>   static int hmem_register_device(struct device *host, int target_nid,
>>   				const struct resource *res)
>>   {
>> +	struct dax_defer_work *work = dev_get_drvdata(host);
>>   	struct platform_device *pdev;
>>   	struct memregion_info info;
>>   	long id;
>> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>>   	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>>   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>   			      IORES_DESC_CXL) != REGION_DISJOINT) {
>> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
>> -		return 0;
>> +		switch (dax_cxl_mode) {
>> +		case DAX_CXL_MODE_DEFER:
>> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
>> +			schedule_work(&work->work);
>> +			return 0;
>> +		case DAX_CXL_MODE_REGISTER:
>> +			dev_dbg(host, "registering CXL range: %pr\n", res);
>> +			break;
>> +		case DAX_CXL_MODE_DROP:
>> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
>> +			return 0;
>> +		}
>>   	}
>>   
>>   	rc = region_intersects_soft_reserve(res->start, resource_size(res));
>> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
>>   	return rc;
>>   }
>>   
>> +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
>> +				     const struct resource *res)
>> +{
>> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
>> +		if (!cxl_region_contains_soft_reserve(res))
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
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


