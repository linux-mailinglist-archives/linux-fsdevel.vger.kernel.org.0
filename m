Return-Path: <linux-fsdevel+bounces-75541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMD5D9Ped2n1mAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:38:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23958DAF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40659302F26A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5722E8B97;
	Mon, 26 Jan 2026 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rVOFI6g2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F102E62C0;
	Mon, 26 Jan 2026 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463465; cv=fail; b=AQR0041u98fPtsUvjqCjBS3yiCQMi3i9/912LiO7xgqav/UWRURmfSyM42oBNgNH57/cSlBDVjs8jefAR9lNEcLTKvAw1lcYmv8LEVx2nJcHOvzXU8NtA4nLb7sdV3XQOzdDHRydzR4iI4Zd5ueXhtlf3eZsauDtVQMNrqonj2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463465; c=relaxed/simple;
	bh=OuHHvQB/oD0GFvvjfab8tIk3nYw/yv9cWojtkmWkXpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RwS+TYu62xVKBY52VJ/4yCRGg8ORln93RFu0gRaa3/drhP3isRqVST4QwBd5OGNMmMjoEbkEWKLmIL2jSIYgC1OhrrR2urRxFjUzcez6EHFd5aS3CrIFkD4s0S8JsnaSo8/0fc859lcV/P6USyCTBZsgH+wAQ2IK2QYk45+lNe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rVOFI6g2; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpN1FtoCn8PPmtAMLh4T0ahwO3xVxl+tFSboQrzxqW0ecRV09XJkc2qEa7p5kSr20GORH430PhnxHKkw3tvwJ1aA34W8+d08im8zBMUTBECw1ShmrKgbFB4oczBjN1P7cuX+WOBs/5vRlsgOJxuqKoZR9gleTO7vFWB5A75Jv2YmbRcJHwSOnoMD6rB1Vp4afhw0yJIkTK73s5X60PwbqYke1t4CgEUYUZkNwDGTPZEN62guZYVVkQ+L6MVMSO8BUAyBnBilK7OIrFFDOEO5aBMQvdBKVQlDniDYWcy+KYQ1znK2kWiW0XG/lo0bcgXLvxX/y3Dv9At6fiVCIBsX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsWlbgnk3FcNH0vFobFj/i7zB1dbVyCA17xA2wGgF1Y=;
 b=PXUTx5+94R846Gd91W9tWqTaYqBivA9kiG0gyKv31a33/+1PsWbZHO7wlizsTV4H3QDO0bAdyUZM80OEsuB/CJ2DGTKgKyz/QbWAmpzakgA+PFXgUIK3EEXuyEsG9XXHICaYJNn1oHmet8dY2UDZ4/9hSCq4nKX3k4YkVPsyM+okWhRPxVyG+hqDTO0ogSd0BnK+6OSSCY/9BAvRiOtmlfhAoM4/ubuiqFxJmwcVTV9mg1pHIpQiAh7Ldx75Xt2alegYWHGUmRYEWsBBfIqfNu3Gq3C0ujt/oY8xgMJGWxf+5u5S7umSsMjGWM7ws4N2Nqn1vO2ZmYN9lLasto64xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsWlbgnk3FcNH0vFobFj/i7zB1dbVyCA17xA2wGgF1Y=;
 b=rVOFI6g2JYe2aNQt98ZnMxtXFxMns7Jfnbx0giH+hv7w5MQahvcHg1p1YK+cQ72zFDYpsgP7eLOlsGa0tvyoQg6mOCU3aN0cHW76bNglO85jnJtcEss2yrEiUvcjIPWFS/yI7VTE0BPtPtvBCxjk4UPr/OuZG7DRcxEfTshvYsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 21:37:39 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 21:37:39 +0000
Message-ID: <9c5150ba-c443-4ce1-a750-57736f0dabf0@amd.com>
Date: Mon, 26 Jan 2026 13:37:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
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
 <20260122045543.218194-4-Smita.KoralahalliChannabasappa@amd.com>
 <20260122161858.00004b0c@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20260122161858.00004b0c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c5e059-8b6d-4a14-d9b6-08de5d2320f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk5teVdiME5rZ0ZRSkFPaFVIaXgzeFRHMW8waldGbGd3ZHpQOFdUeW0wWnc1?=
 =?utf-8?B?dW5jOEMrRFBZTFo4Y1YwK2lQb1l6SldtWUt2MG04T0Qrb3R5WHlhRmVTM2RX?=
 =?utf-8?B?czZaQXJLSjV1d3RTSnJIcmV6V3hFcVR6MjBIckhJSTArMkphNHNBdlF2WnEr?=
 =?utf-8?B?RG1EZHpTdFYzeXlKdCtiQVJzSFU4MXNDclhPNHExaFVRVUNOOU5zT0grMGd2?=
 =?utf-8?B?eHBsNEluVzNrLzJoRG45ZDM3VHlZK0FMSWsrTGdnWjhheDdrZ05JNEJoWG9K?=
 =?utf-8?B?WlJKR0xxQ3JHaEdNdDhoUTB4NW9nV1k3ZUNMUjdpUm9xd1pUeFpzLzNqcXFC?=
 =?utf-8?B?SVBvU1BMT0tOdE1xdnA4algrWk1mdnNrTm1TSWIvZlk1VE9PVEE2dVVlWnNi?=
 =?utf-8?B?dnZsYkRCa0REY1k3TklLdjFpQWxHRlR4a01udUEyOHUvOVJCaG50aW5STzB5?=
 =?utf-8?B?cTRCZ0RSWDBtb25IZ1p6djdMeGg1SEg1eU5McGdwOGFRaVE2bWVyZlE5cjZl?=
 =?utf-8?B?S211MG1LcnA5UStwR2lTMXJJb1VrcjdnaG5xK1I0NGxLTTQ1TjNJQkN5ZVpI?=
 =?utf-8?B?ektmUy8vRzFIWXRJMC9jTEt6cWthUW13bHRIbC9JMGFaczNTVnFMeFNFTmNQ?=
 =?utf-8?B?Q1NmL0J4NStIVHRhbmFNMklsQUg5L2dkazlPdnVFVFp2amNOd3VTMTUvbFEx?=
 =?utf-8?B?anljZWhTVXI5dWJManFSWlI4ckZOdFpCWHdaM0huZXBDQk16UEYwZnN2eGJi?=
 =?utf-8?B?U0JrSnFSTG1DRjRpRlBaa2lEb28wMGRRaGZGQVNZbzUwKzlXVVNuSW53WUFt?=
 =?utf-8?B?MEJTbXhiNjh0UUw2OGphUjFqSDdza01nN25ueXNCeGJJNkZ6NEhmQVRXZ3dL?=
 =?utf-8?B?YlZweHA0QUdWelA2R3lkNlNrRWluQ2VOUmhqSmo2Z1hPRzg4ZU5YZG9hLzVa?=
 =?utf-8?B?TlVyQ1E5NitDMU1DRUdGZUpSRGxZZ1JCbGUxY2JVakV5OGk4R1JTSHBBekJU?=
 =?utf-8?B?VWQ0d2N4dGZnaDBPNDQ2NHVPUEFRNU9iVVF1Q2dtMXZFQzBZdTU1c0RscWpa?=
 =?utf-8?B?Wk8wbjFEQWYyQ3VqL1B3RHluSU05SVZVc0N1TnhnYlFoQjF4QmREZlZoMVRV?=
 =?utf-8?B?ejJXWlJrNGhnWHpBcEt5OEVJSjFHZ004Y3JZbE1BUm4vOTRrVlRXenM4WmdM?=
 =?utf-8?B?dGduZ2hmd0lUUkV2YmRua0owWFVLNGxqS1VNM1g0QjJRZWltMU1HUk93YkdB?=
 =?utf-8?B?UFY2aXRvQWR2UmJvSzdFWGhKTXFsZFBCTXVqeGpPUkQyOFBRWUYwVUtMN2kz?=
 =?utf-8?B?NGx3TGJyTll3QlcxK3VRREQzaGVwVDhBdWxnZjhGL1VIeks2WFFLbmFRRUtr?=
 =?utf-8?B?aFJjYlF5WThhbE5GTzd4M0pMSnhIN1c5R1ZtTDQ0cU9yUnNDQVpjcmVVL2li?=
 =?utf-8?B?TFAwcmhmWlFiYWxpSEpoQWxlbEJEVVhGaUczcDRudy9lVnUvNGJrVEllYTJ1?=
 =?utf-8?B?T3ZJZUNnbmlpUCtVMHI3eDZya2tFNzQ1elhKdmxEMm5YT1hCYW5tZk5iQldO?=
 =?utf-8?B?Zk1sczRqb1pPclFNU001RDJoeVNpYzR5OU02d1owOUNxdXBnRGNUWlBKVytD?=
 =?utf-8?B?ZllvVERLb3MzTmRDb08zaXk4dFdEaldOQkcxd2VXNEg1WnRJR2lOaktIdXkr?=
 =?utf-8?B?dXpHbjBVUDlONzNhbE5UZ1BmaCtDcWhObVFVQVB4ME15TTZGaWpuNG8rWmN3?=
 =?utf-8?B?UWk5YkJMSFhWeTB3MC9SdkMzc2hxTHdQeExUNThjK0IzNVNwS3JaNWFhekJo?=
 =?utf-8?B?NnhPMTJEMDFscTgraUhkL2Vvby9LSEpjb2RTbzdmZmNmSFpycmRvT3VSSVIy?=
 =?utf-8?B?RnpBcWtxSGlDUVpRZXpsTkUweHdLZlVtSXRUYTZqNXM4SkwzTXZ5M1plZFd0?=
 =?utf-8?B?ZHFCUnVWQ3U0dk50eU94bi9DM09ETTJ0OE9DQlc4RloxRkEzSHJmazV3Vncv?=
 =?utf-8?B?T2gzR3Z1cnRUb2QxSGlCUDBGQ1VyOWhKT0ZTZ0o5WFg2SEpUWTJ0WGw4NmZJ?=
 =?utf-8?B?VUxjcERZMXVXdldMdGROUk55dkRINThBam1neGVMWG1iemQ3ZkFxMFF0bklE?=
 =?utf-8?Q?FvXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VThlYW1yamNwN2JhSVdyL3NGUVVMaWJRampBUTcvbDcvQkF5Zlp2QnRxYmhj?=
 =?utf-8?B?TFZuNHZDRTZveEg2ekg4bHZZTnc5ZmkyaWJ5OVVtdXRPdHN2VnJrc0VTMzly?=
 =?utf-8?B?YS8zcVJZTk8xVmZmTE5sLzcvMjdNYkRDUjRTbE9vU1JSRy8vcGRRNzFpMU5C?=
 =?utf-8?B?RFVJOSt3NmE3bzFFZHZXYlF1QjI2RTMzUWJFYWZBaUt3Vm91RnJ3d2p3K0pm?=
 =?utf-8?B?QnFsbG1PS3lNZ092QTU4ZUVFd3FBNEovcGVpZDF0dGRZNmRzT2tsVm4rc1I3?=
 =?utf-8?B?Y2dMZVE1VXNFUWRCd1htWUVuOEtiMUpkejFoWGhoSWNuTW9hQUpuMXdESGlE?=
 =?utf-8?B?R2lnaW9qT0FFN05tazRSbHBORlJRekJ4NDZtSHVvcHFFdURMcUxkVHFUMzZx?=
 =?utf-8?B?a05tZitaelFTSzRJekcxRDlkZnl6Kys5RzdJSEtJOE9nWUlzOGloYnhXK28y?=
 =?utf-8?B?RzV6QzZTZC82aWFaWUdLNmhsODdwVldYclFFU1FqR2l2NTB3OEVLU3p0S1Q2?=
 =?utf-8?B?OW5XWkkza2MwUVVDQkpuQ2MrT0xUZHBvNlVnbW5xeG1YTGxjUXFqS2Z5cnpm?=
 =?utf-8?B?WVU5SHQ1VC8wcDNGT0ZGdXJjWk8yTSsyYmhSU04wYmtRUkJXWHMvZzVzVm1J?=
 =?utf-8?B?ME52UzFCblliOXl6ei9JOVJCOUp6enkwdlNoS21CN2hROVRhd0cxSUFLYnIv?=
 =?utf-8?B?OU4wdHFwN1d2bGp0QXB0UWh4UVlETk5leFU5TTZGZ2daRUxXVWdZODRNaWI1?=
 =?utf-8?B?SENaNC90SjBWdTJvb2o4MFB2KzZPL2czTDViWGxMbTEwOFFaQmJXNFB5RXFS?=
 =?utf-8?B?ZVQydlJYWC9sTnVkaDRuZnFsVkxFeU96K1YxdGlZNHJmRXA1VE42R0FaMm5P?=
 =?utf-8?B?aUVLdE8xTWUyZG5waTZLUC9UT29tbXgvUkw1aHpTTThhbzZrMUcrRCtkQ2Jz?=
 =?utf-8?B?NzFDcnBrekxqNDZmdTQ3UGFVWjN6QURIYnJqS2FidEw1ZERtQ2tYM2F0NUVt?=
 =?utf-8?B?VVY1UU9TK1lXUDFRMytEM1BVckVtMWNaSmlGQjZEV2xEQ3pGZlp5SlgvcURN?=
 =?utf-8?B?L25LV2Y5ZVR5RU5ITkNsNGhtaWo4c2FtakFyNGVkYXVkRy80TWc0TWxBQkda?=
 =?utf-8?B?T2dkZWFRbjl1VUlHeTJTV2tMcXJVNDVPSUtLSTVmcW9aMjc5Sjk4cmV4bzd5?=
 =?utf-8?B?R1I1eENUbmc0bXpjWnVBMUp1NGsvOGUrUG96MEJSZkFYaFNNREtoc1NMK2J5?=
 =?utf-8?B?QU5zc1FrdWVwd3ZhSXVIVEg3RnpFVUFEajFzRHNEMmt2OE00RXpYTjN1ZjRZ?=
 =?utf-8?B?bzNOMDJiMWZ0M2x3Z1dqN1ZqSW1kaGUxTWpRU2Zza3p3UEFHK042RXVualpS?=
 =?utf-8?B?TVFQTGxvcnlveFczNW00SkVtY3ErcEpCUFIyb05yVTVXR0VoZ2UzbVM0K0Qx?=
 =?utf-8?B?ZVVhNVM0SW94eFpOZzFoNytuUlN0enVGdmtBY2QyRXZheXhFUys0OVVOQ1FC?=
 =?utf-8?B?cjJBSTZMb3NYdUlqOU1wNThmZFNrb3N5UmtEMEdCWmlGWXJTWVNRK0h3eU04?=
 =?utf-8?B?dlBkWUE0cmwxWi9xelpWZkw1ekFtbEU2cm9ZQ25GcmFML2xJNGo1TVpteklJ?=
 =?utf-8?B?S0JPWTkxZjdKbFJLS1JIRVloM0VNcnJmV0o2cGMrVjE1RDFESzZmNGExY3Yx?=
 =?utf-8?B?OW1TMlcxRlRnQnoyeTRSV3VtZ1EzWUg1RVF6Z3RJaUp0RWdnRUxOV3g4K05s?=
 =?utf-8?B?VHVjOFUwcnY3YzVHTzFuNjNPWGZ0ME5RcjQyZW9WTWNTTUM4YW9Qem5kanIy?=
 =?utf-8?B?U29JVUp5QTR2OGNHN09vTzdIN3dQTXVobTEvVnBnRVozZlNVYklOOGY3Mis3?=
 =?utf-8?B?enhTYmY1SFp3MDBXUGNDaTRlUlEwbU1lUlVxUGRJSll1Nmw0dnpsTFFjTnRG?=
 =?utf-8?B?clJnc2MwTXU0dk0vOEtPd3FZYkQyeFlCYUVwZ3ZFblQ1WmdkeDhqYzJwbklQ?=
 =?utf-8?B?dTk3dUdORjRyUGVXcU5XUk1Jc3o4bHdHMkxOWm9oeU9ZQlFkZDI1M2pwK2FE?=
 =?utf-8?B?eUZlL09uOHZMZ1lsWnl4czNaSVJvQUp4NTVEbXVmZ1ZxNnd0bmk2Z21kQVlN?=
 =?utf-8?B?OGFZRnk2eTNFYm13VmRUNE0ySlA5ckZ4UjJENTJPbFVwTm5xNnJ4bTNTT3RZ?=
 =?utf-8?B?TFZ6ak5lQk1pUmtyZWdhZURHUFI4RlJuMlBUU1BTSlFTU1pWZk42elNoT0w4?=
 =?utf-8?B?alpIY2Z0ZDNHc1g0YUcwZmp5N1FvcDJNeWkydE44RTcwTlNUVUk5UmtveVRt?=
 =?utf-8?B?MkVsQmJ2dTNjVExmZnR3OEpJMXFQdTF4eWZIZFhYMEl6Z1NuaTVDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c5e059-8b6d-4a14-d9b6-08de5d2320f6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 21:37:39.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBsiQP1qOrjpwBKkqa/KTj87xpeozQGaDziZ7PEbh0pq74YQlU1uCQMEJbMCPS3p142jVN2cCfeyDbs7cyg1HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
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
	TAGGED_FROM(0.00)[bounces-75541-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: A23958DAF0
X-Rspamd-Action: no action

Hi Jonathan,

On 1/22/2026 8:18 AM, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 04:55:39 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> __cxl_decoder_detach() currently resets decoder programming whenever a
>> region is detached if cxl_config_state is beyond CXL_CONFIG_ACTIVE. For
>> autodiscovered regions, this can incorrectly tear down decoder state
>> that may be relied upon by other consumers or by subsequent ownership
>> decisions.
>>
>> Skip cxl_region_decode_reset() during detach when CXL_REGION_F_AUTO is
>> set.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> purely on basis we should probably not undo things we didn't do in the
> first place.
> 
> J

Thank you!

I’m re reading Dan’s note here:
https://lore.kernel.org/all/6930dacd6510f_198110020@dwillia2-mobl4.notmuch/

Specifically this part:
"If the administrator actually wants to destroy and reclaim that
physical address space then they need to forcefully de-commit that
auto-assembled region via the @commit sysfs attribute. So that means
commit_store() needs to clear CXL_REGION_F_AUTO to get the decoder reset
to happen."

Today the sysfs commit=0 path inside commit_store() resets decoders 
without the AUTO check whereas the detach path now skips the reset when 
CXL_REGION_F_AUTO is set.

I think the same rationale should apply to the sysfs de-commit path as 
well? I’m trying to understand the implications of not guarding the 
reset with AUTO in commit_store().

Thanks
Smita


