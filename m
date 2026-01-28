Return-Path: <linux-fsdevel+bounces-75815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDrbGsmIemkE7gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:08:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB01A9647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F033034B18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4944342CB0;
	Wed, 28 Jan 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xNh2Akb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F8228CA9;
	Wed, 28 Jan 2026 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638075; cv=fail; b=nYmHQ3c1llMuETtX8OtS0zBMQPAwcvlWWJ9KauH5tiQztrkf3VQg+hm9gFyp20HDPsTK2SahHsRe1usYjqBFRqHxWQxAGOEF1irfKmnWzTTsKdK9kB/toRyZ2uyXNpL2D/bPOpKXabWGwedV5iMxr6G6NazcTtvgKB5BfyUxbJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638075; c=relaxed/simple;
	bh=klOYzzsK3UyHshDGL1tFSIBPSNoFB9aAeQu/Y9YURNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oMrXHzmTnLBMF0eyXlNNdc/xIPZk0PilGqH51USA1lyw1YTVoyacLRzyUbG+7yVlHmCmxekehTT+/Ul4zsYl69/X0X8FwG5dJSlnvZ3bqnEOo5CoU2NITkhFo4qJsb6FhvcUFsJqEzKKJuJlq2v6Xrxq+yHo83R9iicc1hpMGnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xNh2Akb4; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2Wrwj8LNmn1gWJEm8R+sQ6umxSvD8jPGEo92Zjsz2lBE3RnRQMYvQbeKfLDtyXhNufafiMt0wRX0Gr0QF8dJwix9WsdvNnVYRoVMNpmKiJZVc4qXgGHX0ZZqiW89Pcn6d3yeq9NtMWKg701Bh78/MMfim9yrdawDD6n9A99O5/A13ytwkAbhE8R4y5tqLp/5V9st7xXYl01ntj8R7c97rn4U434xmmJzs9IzqL6i3K6KWzQS+4noLcHjOduBx2nrCh7pRCFlgBQ1/RRw1PPfQ6/59edlomFicMCd9mLAowCPxv8HsaxmdLkvlwW/Nsu+1JhsPDNFaaBeTbcUQ8nOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6dON4sQ33qlCmd9/KDE75oAoWJ2w2LKpbVHbPevmO0=;
 b=vdoswTg8MGswFkF0ouVxVM02TvaptX1lq/60uzO5HmZjIL04x08a5IecTNufGELcE/JzFiCyG/Lw/0wfdXxA62SytBeop+M/rEAp0pPS0UwFw1nZ0hfGuIhceUTKSNa/DR1LuuCEncgkWuWAsCxuvAkVE/848IseG1Ku9H/KBveqb+/iNd13FuQoZK7SPvARibtN++juo3prMGjY9+V4yjLwBdzJriOFNTWmFST5FXJvzjw4TISrguGX+oMzzGxJBwq2ZLWuysI2owYUC+epj/x8Z/KwP1u5ayTrTuPl4B7euj972ecTrrisSGNtLPKMk8dt6ITngQE0J3JCXqkuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6dON4sQ33qlCmd9/KDE75oAoWJ2w2LKpbVHbPevmO0=;
 b=xNh2Akb46QZZZbh+2f0aCRCPq18bYQRTGF5AECp6a2To9GPDZe25mT7g/Oo1SdWJKP5xzgndKx0wKCKBcgVsObLgcjzfIwt1bWRg/QKjhnpKnq5qPLuUkxJWP+WYVds5KZthPOkfwRJji+59EWlGMQtCmoX7TNCzQNdYKLzRimY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 22:07:47 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 22:07:47 +0000
Message-ID: <81ff49ae-c513-4897-b243-8827ff4ac561@amd.com>
Date: Wed, 28 Jan 2026 14:07:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] dax/hmem: Reintroduce Soft Reserved ranges back
 into the iomem tree
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
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
 <20260122045543.218194-8-Smita.KoralahalliChannabasappa@amd.com>
 <20260122163948.00007ff6@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20260122163948.00007ff6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1f1a8a-1aef-4379-ca68-08de5eb9ab48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNRWVREMFpPR2NpeDNYUFZvb0VhNzVoc3lNQkpTSVp2MHBSNjR0bDVvUXpJ?=
 =?utf-8?B?bUFJdGJCckM1N2tma1EyczZRZll5aUpvaXlPTEEzSnZ5aGJyU3R3RzNBSTU0?=
 =?utf-8?B?KzRaWElPWmlFajlmd1ZQbitNTHlIREZLUmZZRWJGSW1VY0J6WG9FZ2dMbHgz?=
 =?utf-8?B?S1NLU2hkZHZsZkV2aXpUcWRSQ0krUGRaR2dKazNtVmNoNllNUFVUR0FaMHU5?=
 =?utf-8?B?M2sxVXBxU0p1VCtoNjQwVVhyTzVCME9XNkx1VVJhNSs2RGlTL1A1UjA0Z0FK?=
 =?utf-8?B?SmE1ZHM1b3M3WlNhR1Nuc1R2MWZGQ1dTT2UvNzhwd3N5elkvcFFTSmdnbzBa?=
 =?utf-8?B?VHFTZGJHNHRhL3lyUmhHUVJOcnRHWUdiaDRzSk0vRGFyZENaZDRtMG5BYmhp?=
 =?utf-8?B?WWg1NE5GakN1enhNNEw4eHBFSnpCZVFQZUdsRG9HVWxQNzJOSThrL2tGRktP?=
 =?utf-8?B?aFl4MTVmRXF0aEdTYjIwaHpMU3JwM0dkbFVRYjBZbUxqQ0NhN0tLUkF0T0k3?=
 =?utf-8?B?bVRtT0VOQWJwV3VMYVZaUDlySmltRVh1WUMvRmozSjRhZjZORTBraGp6OHBa?=
 =?utf-8?B?S3ZYKzVhSlhEcGdKY1hpUUNPY3JjT2xuQndKV0plUXVNanZxWEN0Vi9GNEw0?=
 =?utf-8?B?L3NyU25ROEJCdXZTS3gzSmg1N0VpdllWWmhqUHFEb3VXK29uMGUwNFRtR2dZ?=
 =?utf-8?B?K2JkOS9Wb0htWW1zSGlhTkt6ZTRtSE5hOFJ0WEhTZEIyd21vWGVtaU9ldlhX?=
 =?utf-8?B?M0NhYWd0eXVER1dYdkx4bFRGTGhJMEhKTDN2TlB4NFd6WjFnNzBqWXhXbk0y?=
 =?utf-8?B?TWwvUTZsOXIraUJQaFg3WVpXL0NtZEZuUW8rMGhXVElubzNiR2xEd1ZvRzZL?=
 =?utf-8?B?ZjF5OHM3MU1hSGhETi9YcEJtbFo3eXlGaHY3VlAyd0tERllKc010VnhRMlRZ?=
 =?utf-8?B?dmR3KzhHQ3N2NmZUUGpzWVlVM0FHR0k3TXZwVXZLTjhQM0NxdkF1dStMYmRP?=
 =?utf-8?B?aEZOaXN6eWlXTHk0Nk5QblhYOXlBcCtaZnZFSVc0bDRhUU9yQUxjWlFZc0Nn?=
 =?utf-8?B?dk4xVXVSbmVuSU5hTm5ieFh1cEpNa2tzUVU2NEdVMnRmc2JMcjg1TExnRUdE?=
 =?utf-8?B?NGkvbGcyMHBreGRkc0VSK3FBTVE5NGFJTjREdUdUQWdZZElBK2owckhKd2ht?=
 =?utf-8?B?aGFBYXhoMjNCZVdDT3QybGdKTWVSOS9ZSUhDdW1qMytIY3dQTnZWSThLdW9x?=
 =?utf-8?B?cFlaVDJLd3FFeXlYclNDaEkvWlNqRnp3OTBROVhHTExsdVhaeWJVek80a1lH?=
 =?utf-8?B?NEZNUWFPSlZmZTFzaDhnQ1lUbjl6TFA2cEJWUm5jQ01mcFJ1ZXVBbEJwTld5?=
 =?utf-8?B?UWplaVphbmNwR3YwWUJyWFlQZ0VuODN3NW04dVJCVmR5dTg5K1lOV21oYnV5?=
 =?utf-8?B?ODJGME1Sc0pYK2J0WDhVeWxldEN3Zmg3dUs4NUhzY3V2NXJUL0s2bnU2K2Rw?=
 =?utf-8?B?VUxkRCtLNVl0MnIweEtpVjYvc0tOaENVUlh3MHF0TWplQjhURTZhMFZ4dWlS?=
 =?utf-8?B?NFBnUDJaczBRM3RUVFBxUmFOR29aV3FncUg4b1h3OXZGbGRRZVZYYUE4S1hy?=
 =?utf-8?B?bEZqZjl6M0dtSlF2dE14anJDbThDTThMZkh1STBUdEZEOEtsSENwZzNxTWth?=
 =?utf-8?B?K1NlMVpjT3pTVUNlSUJaNkFISFpmSmVmdnJxMDIyUmpqR29iSEw4YXJYQWRO?=
 =?utf-8?B?N0p0VW9sZDVjOEhtNkhMbkcyL1M0UW56bDgwRjFPVFZJRG1RV3pCYS9USFJ4?=
 =?utf-8?B?bk44dk9oUUtmTjcvTFByU3FTdmFQWE5yRm5mNEtsQjlacjFYUnkwTmFaM1Qw?=
 =?utf-8?B?Wk01UGRXVGtNV0l2b1hvczZHbU5MclFzWExtSkphNVc5NGVqSHFTNVBVd2hh?=
 =?utf-8?B?TldpZUxBT1hIcjQxWnRyRy9ZZmcwaGl0c3hhWjd4OE81cnF1eEE0Z080ZHFq?=
 =?utf-8?B?VjVKblVTTWhFSXJSaWlQZmlpZXo2S3E0emkvbW5YR3cybHVMZkJLeXMrTEFZ?=
 =?utf-8?B?ZXBVd3c5cnp4MjA4SXlDQ20zbm9ScVZoa1ZvV0JBUGlDM3dQNHovaFE2WkhV?=
 =?utf-8?Q?a4Rw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGh0RVdYWXNwa0psTitiSS80OGc4bk1vU3JMZVdPSmJVRklWVzNScDdpOU1n?=
 =?utf-8?B?QUQ5d2xUeThEYmFHRWlXMCtEODNGcDFEbXBOb1FqZmZjRVpZMGVydlVuZ1VO?=
 =?utf-8?B?TXZyU2l3cmRsVXVRa0xnUU1idFR0b2N3MmlHTnlmVEZnemlDTkd3b2traXhp?=
 =?utf-8?B?dzZ1bUU5aGh2TDdKK2ZXekNJeE5EeFNBcjdiOEo1NlA0eGxLUTNncndPL1Fx?=
 =?utf-8?B?aTZJMWhlZGJjUVBSRlU3MkV2Wmk0bmI5c1JWZWxoM3VoeG1qdjR1QmZtZ1FR?=
 =?utf-8?B?STFqaFpTVlJGOWJFenRaTmRuOHZOdFRDNjNEQVZTUE14bFdkeGtuSmpxNytz?=
 =?utf-8?B?Rmh3S3o3dlgrVnM5dUo4WUZoV3BneFk0OEhqdDlzWkE3NSszUDZ4Wkh3MXlo?=
 =?utf-8?B?OHA4QVorQVpxZUxWWXkyZUVaMDBCQ1E2bVlFUG9JVTVqdEg5eGEvVkNXbVRl?=
 =?utf-8?B?Smc3a1NxUGxqaVQwZGpIaVpRYmxxeHlXekN6T0Z6c2tYM2JJS0hqTzlRK3BO?=
 =?utf-8?B?eC91RXdrbERGdUJBRnUyQTlWendkSmhvRVpBMmtRVk1FbkpEZmNwaTExU01n?=
 =?utf-8?B?a09rdEw4b2VUVTNSV1JSZ05Uei9MdUQ1NG9YaGsrLzA5QU41aHlZWEFzMHRX?=
 =?utf-8?B?WnN3ZFBZcjFkZ3I0R1pocmkrRldYZDc2REdCUXpGT2xIWVQwK0ZhRXNpUi9R?=
 =?utf-8?B?Z0ZWU3ZNdlZicXZIS1BwWTFYU2FJMzN6VE44QWExK0NTY29PL3BuTkhTamd6?=
 =?utf-8?B?N1FvcEd3K1R2RE9FRmJuK0pCU0M5Q0xBVUZjTWNXV2JvWmN2eENWeEZYQTFt?=
 =?utf-8?B?V1JZeEhjcGxtMncwSU1ZQTl4Y0U2a3hKb2Fkc3g2dGR3cUxCdFdNdkJOd1hW?=
 =?utf-8?B?bzgzanRxNVFYOFFUVGJZeVdLTGZNRTFPUk54N3VHampsUlI3OWRNeFdncDU0?=
 =?utf-8?B?Q09XeTR6dEJnSHdjSGQxcS9DZVZ5QTdLNzgzYmhoeVV4Kys4dEkvbjIraEtN?=
 =?utf-8?B?dTFlU21xV0x5alFBK0hQYUNzWnc2K3dBQUk0ZXRWWXZJWVBsTUVJdjV5eVM5?=
 =?utf-8?B?dlVnUGlsTTFDcFB6R2ZoN2NUQmZoK2cwNVAzdzdqM0JSY0NTZ2xLdzdCVlNj?=
 =?utf-8?B?UjBTRE9pSU1mZGN1VmhVZFp2dlE5MGs5aHBjcEhOT0NBcGlQSWRjcjY0ZElP?=
 =?utf-8?B?SU5WRzNtSStEbmdPZUgycGVPSkVrZDJQVmppbDRCa1V4OXVWeG1qMEdjT0U2?=
 =?utf-8?B?bUMwcERvZjdSdU9PazcvSENTNStCYlZ5UWhmYjhXVGoxbE5MNFN4ZThLZU9D?=
 =?utf-8?B?Y0lYcmxsb2pFd3FNUEtkdFptOEJLWVVNOFhyTXVKcFpTOVNaUVNKQzhLQXFS?=
 =?utf-8?B?NWZiUHQvbkN0UjNhb2ZNcFVLeDNqclJteEtjbXdnVUFBV3kzanhwSUJXREVN?=
 =?utf-8?B?WHo2MWFiVUxUSzJmblBmOUNabFZJTW5aVCtZK2loeEhMZW05bWFTS0krV1dr?=
 =?utf-8?B?blNHd2JWZmJ4MGZscWhPdUpuSzhURGdHNVNsaUxIVnVvSEpjVDZYQ0wzWDJi?=
 =?utf-8?B?RmMvOXE5UGxCZ0FIVXRzRTBsN1ZZcjRNK1ZDQ1NYRG05eklTcEFJYldZZldy?=
 =?utf-8?B?YlNxK0FDTmIzZnZYYlpKdGsrZkdPNFEvYXMwVkJXYjE2ZjNGSWp1RUVwbFJT?=
 =?utf-8?B?eTdlSjhKQzdjaHdxS2lhS3BJN1Mwcm0vZDZTcUUzekpUZTV1N0tnRHlvRzJm?=
 =?utf-8?B?QXZ4SFRpOVpnMEhNeUlLSmxjZkdlQVYvREZoTVFNUklCaUg0MUVmMjRwdGxI?=
 =?utf-8?B?dE92anZzNmtDeWZTRmUxdlhqN0VaTTJIZUd1OUJhMWMyUVE0d2N3K3lYQ1Zi?=
 =?utf-8?B?RGI3R0R1SlFwTlAzWHZQcVhZVUx2bjdOcWFkTWF5QlJGVk1jSm9MYjNwZkEw?=
 =?utf-8?B?NUk5MUFjTHVIM3hIR2hLT2J0WmlQUkJGcWtsSFlNUXJKaXpJQUlqa1FYOG9p?=
 =?utf-8?B?YU1kd0JtN1R6L0VaSEEwU3ROaUdLaU5yTzIvUzRKYmdnRkU1Q2ZvcFFrUmIx?=
 =?utf-8?B?RmVLaE5XeE8rMEJtZjlLOXlDNnRSUHlOanVUSmRJQUQvbXdSSUEzTEQyOXFI?=
 =?utf-8?B?ZnM0ZW4zbnQwSG9tOUJ4cU1naEVpYXRoUTJJRnlRNTJ5MTU4Q1FwSkF2TUh4?=
 =?utf-8?B?Tldpd3Y3L015RDV6b2xCYnhEdkIza2JCeW15dk5QWXk4aVp3Vk5MNEZtQ0hE?=
 =?utf-8?B?KzNhT1NNZzZrMUVhZlhFYTVJamNKT2JETTNLN0xpdU5DcUFXeG8zMEhTMlN2?=
 =?utf-8?B?ckRZV0s2T2JFZjVCWm1Fb0QyN0w0dWtub1JyRVVDUW5BZGw1NGFlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1f1a8a-1aef-4379-ca68-08de5eb9ab48
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 22:07:47.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaAk6xF1qNl7jlX24Q2sciKJAWKkbTKrk1hI0mcshyu1Mrb3IvedwpQ9EuZywYe2au5kXYmJjPiFbhGPmc/qHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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
	TAGGED_FROM(0.00)[bounces-75815-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,fujitsu.com:email]
X-Rspamd-Queue-Id: CEB01A9647
X-Rspamd-Action: no action

On 1/22/2026 8:39 AM, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 04:55:43 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
>>
>> Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
>> to consume.
>>
>> This restores visibility in /proc/iomem for ranges actively in use, while
>> avoiding the early-boot conflicts that occurred when Soft Reserved was
>> published into iomem before CXL window and region discovery.
>>
>> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
>> Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> A few minor things from a fresh read.
>> ---
>>   drivers/dax/hmem/hmem.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index bcb57d8678d7..f3ef4faf158f 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -64,6 +64,34 @@ struct dax_defer_work {
>>   	struct work_struct work;
>>   };
>>   
>> +static void remove_soft_reserved(void *r)
>> +{
>> +	remove_resource(r);
>> +	kfree(r);
>> +}
>> +
>> +static int add_soft_reserve_into_iomem(struct device *host,
>> +				       const struct resource *res)
>> +{
>> +	struct resource *soft __free(kfree) =
>> +		kzalloc(sizeof(*soft), GFP_KERNEL);
> 
> On one line. I think it's exactly 80 chars.
> 
>> +	int rc;
>> +
> The declaration and check should be together. For __free stuff inline declarations
> are preferred.
> 
> You fully assign it so kmalloc is all that's needed.
> 	
> 	
> 	struct resource *soft __free(kfree) = kzalloc(sizeof(*soft), GFP_KERNEL);
> 	if (!soft)
> 
> If not, just switch the two declarations.

Sure, I will make the changes.

Thanks
Smita
> 
>> +	if (!soft)
>> +		return -ENOMEM;
>> +
>> +	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
>> +				      "Soft Reserved", IORESOURCE_MEM,
>> +				      IORES_DESC_SOFT_RESERVED);
>> +
>> +	rc = insert_resource(&iomem_resource, soft);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return devm_add_action_or_reset(host, remove_soft_reserved,
>> +					no_free_ptr(soft));
>> +}
>> +
>>   static int hmem_register_device(struct device *host, int target_nid,
>>   				const struct resource *res)
>>   {
>> @@ -94,7 +122,9 @@ static int hmem_register_device(struct device *host, int target_nid,
>>   	if (rc != REGION_INTERSECTS)
>>   		return 0;
>>   
>> -	/* TODO: Add Soft-Reserved memory back to iomem */
>> +	rc = add_soft_reserve_into_iomem(host, res);
>> +	if (rc)
>> +		return rc;
>>   
>>   	id = memregion_alloc(GFP_KERNEL);
>>   	if (id < 0) {
> 


