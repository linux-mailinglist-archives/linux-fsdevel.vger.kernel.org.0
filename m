Return-Path: <linux-fsdevel+bounces-21823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCE90B422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0705728DECA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746F16DC14;
	Mon, 17 Jun 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d48h1cDf";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d48h1cDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1A16DC0D
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635933; cv=fail; b=XeCdCBrtjPWKM6Z6JhmdH6V11ogx8VeRbQzBv8E50NmxAEfvxRuWSDyqY1cWqDFrhMKXoiF0FgakgB5lXWP/UtkyA8siz0Tw3r4MPTsAxRFGlcwi49DMBDW5BSN2ysatSJoOSeaxxfIkqSg1UhAx6gRZjYpJAaOzPE55nha7pwQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635933; c=relaxed/simple;
	bh=4OE0M/TKJXzVZQOAhtFk0kHuGwt5ZjCqKn/NjD9P37o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=up9BPmrZtnFXl+ip17JOkNVwqf2/cPQ/vvF1alLaN9naq4tGBMyDPJeLjzGBlH8xBGJT1F0HWNNNFnr6N0Ebav6FP3nuFzw5dtnYgYeEElS/2daDMjiEnVpEpZiBmNmoAC9zQVl9dDc4Ey2pnGengw3kLEoul9Q/2PEsE/Bfc+U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d48h1cDf; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d48h1cDf; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=T1UrfjnO5x4gqLdibXywf9qYVmOihB4Y99qCQlLEOTvznkoHQM0ZJvJqAmRSWLR/e8PP443uYzTZgySY4lfJYze2N7Uhc4LeAg4NZsqmhLmJybkOxDERD3c+BGwscWZQR3k9dMxLkVjX+R0r025OK3taLJk9Mhh/UMrWmdOg7k3ORMyo6M5QFcx/LD4b4iySOm6E1zT6Z6M8n56M+saN1ypLRDps/wEPjaKzeCr5I+JcU5P5sQX+kmj3Zy2vbkZTG87yaEv5aYc0+9biN3RaLzNhroJx8p+rukXgnHcf9GJDsCw7jo1ljld9r352ax+zewB9F4Aw7jv9bnl9H9ksqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fneA06B+c6m57sZjcFjdKPhgm0kBE1zed7nx9xPdFc=;
 b=kdmvbRnns+GbOu5PhmuG7onXvxWnBq18sAK1waSJy15o7geG7tHO4qgbOamEkIUJ5g55IeY96BV9EfpzobKM33LVNKlUtU9whUz0gZ9FvEBzWe0OXCcAVNVGGZCGuiWWYBtefSPFTgoly3uLaHNkgDXKvDzWhM+W7/usZOOAE4LPWb3IYD5fKkERY0ucWybMGdCtoLdhcaPCkf/RVcXvyU8QPnkEp0SFPJgzByT6mvGsEbV0QKME1UUjP5qE5Y1srjbDJnMmWPrdLUz6Z6t3iPJUZDI4qmcJX8HdCSMRnKJTM6VsjMDI/77aixZA3lWNmZBiui3G0updTXGMxndorg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fneA06B+c6m57sZjcFjdKPhgm0kBE1zed7nx9xPdFc=;
 b=d48h1cDfztLIzGtU8x2M9xrT0PoYiJCsDXfXCjVOFxxr0NljAhHgFSc6gy+xHfvlgFOYZhJmBJmwmHtEIeZMgpayDb2P8mj9qEoCJ3V6VvifOVEhMYEiBxaJztczmg1Ny3LKv23Er/1uRF0k4Pz+5b2io81rj7s7mIs4rhxFt48=
Received: from AM6PR10CA0064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::41)
 by GV1PR08MB10730.eurprd08.prod.outlook.com (2603:10a6:150:162::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:52:03 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:209:80:cafe::b6) by AM6PR10CA0064.outlook.office365.com
 (2603:10a6:209:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 14:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Mon, 17 Jun 2024 14:52:03 +0000
Received: ("Tessian outbound f73a80402c83:v339"); Mon, 17 Jun 2024 14:52:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d418c34d31778aca
X-CR-MTA-TID: 64aa7808
Received: from caff7b950603.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1CC8B1DF-C890-4039-9B5B-65E99A14EB8D.1;
	Mon, 17 Jun 2024 14:51:52 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id caff7b950603.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 17 Jun 2024 14:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvj4AwIiu79WehRpoK1NIQjP7krJkxZlHQ3X3suzOOGIieecQ8cM5ovBXYPw47AN8zcoZ5eheEURg0ZeB8RKdqTRHFrLGakkp7jHWYSdiq3mVb9uFV20SGykN/AsHmu+Pihh4DHW+YPnvcfLTxlTnzsB6XbKUNi3xOQ7YdZkKQ1jhCbOc5sqnbcYzaFVTNy06iMufNOxaHiwNVg9iSnRsycsgt/KXLsSfVDMZkHT/n84AWr7DWdPxHCVqolSth7KcWViAdpwArdaTQIF0f2voYr52uE3W62dDmFqaMy8WFbbPcivmmYUwgeVbrIuBJwWfBPGGielTOHHbfJb2SMMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fneA06B+c6m57sZjcFjdKPhgm0kBE1zed7nx9xPdFc=;
 b=UkDoc/mkKnB/orVzvPU1qv2bpaMgS2khDKELMNdrXj62DkniBDnbK/WAYFSUrN+AgzVyWgZGH/Vxxo/rMkT8uNyuVg0RN8rufyJk8MUTTMLzc03l/RVvD46xPtf+SRTZoAKeb+PLdGhegjlhXpi8V06RaBKURNbZ6tjmHITKnyyPyTtei64rsXK8E19NAF6cQN8LSY/3TCYALl3YriL900nnhGsdKSOxO82YrgRHvE4XQYIYdhxvPbB8A/Ox8nwMgNHvWjToNEnUEsvPEOFKMSnY3DrcC3BLN1GOFQVZ+yuqWZkzdUt/gl6mXAJmZx3NadkS84++iX5sAtO7Ayg64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fneA06B+c6m57sZjcFjdKPhgm0kBE1zed7nx9xPdFc=;
 b=d48h1cDfztLIzGtU8x2M9xrT0PoYiJCsDXfXCjVOFxxr0NljAhHgFSc6gy+xHfvlgFOYZhJmBJmwmHtEIeZMgpayDb2P8mj9qEoCJ3V6VvifOVEhMYEiBxaJztczmg1Ny3LKv23Er/1uRF0k4Pz+5b2io81rj7s7mIs4rhxFt48=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB9PR08MB9516.eurprd08.prod.outlook.com (2603:10a6:10:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:51:50 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:51:49 +0000
Date: Mon, 17 Jun 2024 15:51:35 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Joey Gouly <joey.gouly@arm.com>, dave.hansen@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, tglx@linutronix.de,
	will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <ZnBNd51hVlaPTvn8@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <ZlnlQ/avUAuSum5R@arm.com>
 <20240531152138.GA1805682@e124191.cambridge.arm.com>
 <Zln6ckvyktar8r0n@arm.com>
 <87a5jj4rhw.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5jj4rhw.fsf@oldenburg.str.redhat.com>
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|DB9PR08MB9516:EE_|AM3PEPF0000A791:EE_|GV1PR08MB10730:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f6124c-a021-4e52-227c-08dc8edd0d0a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aFRmaTJUaEplZjIxcFdMam1JUU55cmdUVzdvMlBob05mc1BsNGVRVHUvYnNH?=
 =?utf-8?B?WWtGck4va0kxKzhqNzltb3ZtakNUVVAxWUE5czZIN0J5eHN2ek5lUGExUTd4?=
 =?utf-8?B?U096VlRJdS9nTGlXdmFYQlhXVVRRMnNlTVE4S1RwUlFlTnkzS0crMVpKbjg1?=
 =?utf-8?B?SENEQmFoODdYcW5pVjNlemRJNmtycU5KeEpET2NHSUxwc1IycFJCbk1oZGZr?=
 =?utf-8?B?RWUrRWlYYTI3eGlqTEdFeDl3Y2NRSlp0ZVp1ZlZ1QmpyODdYakE0ZzRCTnZE?=
 =?utf-8?B?cHBnVktXZGZFSzVJeFdqbEhkaE5ZNm12OU1ib0NDdFdNU3M0NTFqQnhTWWRk?=
 =?utf-8?B?TG5OeWhXcDl4YTZkSFJ0TzFNTXV2TjVPdHdaaEtubStQNlkzeStNREVZYUVG?=
 =?utf-8?B?NXBxUU1NYlJxdExrU0VsMVl4RDQ3eDN0MlRhMFRYNGtoVlJLVHlpU0tMdXRY?=
 =?utf-8?B?WithUTZyU0Z4TnB3MG1RTStPVEY0UE1vTzNlM2U2aXVlKzQ2WGFQbEVZdVBj?=
 =?utf-8?B?VUduZDJiVnVndk84NGpPVDFlODRYRzB6dWU5clFnWFcwMFoxaDVMWmpiTDhS?=
 =?utf-8?B?QlhGYXNZTDVORklHR2Y2bGozeXliQkR5WXd4d0ZXa3o5aTUwWE12U1BQRHVB?=
 =?utf-8?B?b1h3cFZ5SE0vT1dvV3pMdFF4RlpVT2VtekM2dUszUFBReGtWeGZJVjR2eGRQ?=
 =?utf-8?B?b3hZK1M2amh1UHMwN2liQk1PMFVMcHhEa09NVk0yWkRTdDFsR0Jtam9tVHdn?=
 =?utf-8?B?VDE2MzRpaGlXbzI2SGJQNEt5R1BPRitSTUVZTWQ1dGRKeFgrbzhFRWZOWkRq?=
 =?utf-8?B?amRqcHJtbVpFT1ZKUVFBcUJxbndhczU2elFDY1M2L2RDVTdkZU96M09TUjJQ?=
 =?utf-8?B?YXc3WmE0RGJ4Tm90bmtrbFBJU3cxckZRL3pSbCtPU0swa2pFR0dNdXFBb3k2?=
 =?utf-8?B?UlNhaHIyMnlNVm9CQUw4MzlRM2YxdnQ4WjJvaVVqYXozRkNxOXlOWWM5RWJX?=
 =?utf-8?B?K2d5cXhhWlovRWZnWVoyMXJYSzJFWU1jZFZLTGs4c0wwcGhLZHJtWTAzQUNP?=
 =?utf-8?B?T1N6ZHZCZFQrU3FxMFRoOWVNeW0wNXhpZGErMzZseHJLNUxuY011bHhENFFR?=
 =?utf-8?B?KzZMUHJZeVVhd2ZNZzVTVStLQzcvTHNyeXRxWGlTdERyQW5Nd25KaGNHRy9Q?=
 =?utf-8?B?ZjhwYUZHK1hmY0s3ekxQMmV3eGExeWR2aVI2VkR6Z3o2T0liUE1qOW9sNlpa?=
 =?utf-8?B?WStidE44QnIzOTFZcXgvbmd1RkRYWkJVVTZIc2ErcmdCMnNnSkhNc2RvdmJo?=
 =?utf-8?B?aFMyNTJuQzZLVSt6ZkZSNkQ3VTY2NHhkVG5JNXVoY2hEby9zcVl0QUwySS9i?=
 =?utf-8?B?Skg0MG5KNVdrNFJkNExiVEI4NHkralFhYzdFRWFVUVNIeGgwSmp1VHpGUXR5?=
 =?utf-8?B?a0xNWnMwRytQZjdMa0lWRE1NMnJIWHNhT1BENW1wbWtCT0hjK09Jd1k1QUo5?=
 =?utf-8?B?azNlV3hKT2RFQnZFNHVyeDlGVXhENFdFMDlKclFhRzhWYmFaeDcwMkdxQW5t?=
 =?utf-8?B?T1pLQXptSlF0RjNmOVlCUFBCNHRFZG1Qckw1Qjcvd0QxeU40YVVBVENaN3Az?=
 =?utf-8?B?cFBpK0ltM1lBOE9LSVdPMWd5eURpQiswVENKaFFEMmluWUF6dDFnb2RKTWRG?=
 =?utf-8?B?SEkvenNWbU5CYk13YzNMOU1IeCsxVDR3MkkrbThZRWIwVC9BSG0xcjRLaXNh?=
 =?utf-8?Q?Vder6hzHj5VCHYs4sh7nyEzdOSSCF+Z6HsOvLRQ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9516
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1225ba1d-eae0-438c-5019-08dc8edd04b1
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|35042699019|36860700010|376011|1800799021|82310400023|34020700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkw4TjE1L29aOVllTlVYTXRoQThWY21uMW1jcUFMQXg2MFdmQ1ZyOTJqdlhw?=
 =?utf-8?B?UDZMOVNPN2UyNnd4ZitvS2ZJRFdiajdzb09ZRFYvYWlLUWJjY2Y3MjVIeFU1?=
 =?utf-8?B?MHZGcFB2dnJuM0NibWN4Q01yUEtCbTBaeWlZRHBycnJ3cVg2UVNxdktrRFlH?=
 =?utf-8?B?Zzk0RXZURkxURmxtN1dpNXFHaXp4d2RLTTg2MmtNRGVBTFBMRmlwWXJSdnNN?=
 =?utf-8?B?N1FJUWFjK2NPOFdROHJsYUl4enlGMnZUWUVSU0ZQM1JDYkdnaXU5SmdNSm9Y?=
 =?utf-8?B?K3p5N1NUYU9HdlI1ZUk4WEM5c3VYSmJJYlZQVDJYVmJRL0FsNGxNdEdxTDll?=
 =?utf-8?B?QUJacWRKTmpvR0lzelo2UlYvYWpWQzhBT0J2TWw5U3BMSUliKzlHSk9yM1VD?=
 =?utf-8?B?U0JqOXBNRnVBZGQ1Rkc3dHdDbkx3UGtKQlFSNm1COHRVTmRKVGxRcGFsUENq?=
 =?utf-8?B?RkZhR0F0akRJR0dKY1pvczNYYTVWNDIxdllFczd3V2EzRzFEUjFRZjdwdGVp?=
 =?utf-8?B?SER5WXJiNFNPS001aWtPYUxDQ2dPME50RkJPTDZWMnR5V20wU05UOGdzd3p2?=
 =?utf-8?B?UTBPYVByUHRmSnFRdXR4cUk0Yk5yaUlVRWUvd0VvcENLK1p4SjFTamFmcFYy?=
 =?utf-8?B?YzJQa1crTlcxRTR2RkpOMmJhd2oyU05veDRFWmRaR2NxNUtCVTU2NVRTR1dL?=
 =?utf-8?B?YnlSMmFUaC8wODJFeVFCZ3dlV0g5ME5WaEdTdDkvd1hDK3VUdGxmc2hHZW9s?=
 =?utf-8?B?cjhnRFY3eERQMjlabkRsMDZJSHlLNnM0L0lSWFhsajJvT24zUG92TWs3UGtx?=
 =?utf-8?B?ZHdoRW1FazBqVThyZkhiVlFEeDhxekZLL3JicUZ3RU9MNFdkN3hZWXJUcFNz?=
 =?utf-8?B?aWJZcllsY2dLa3p4em4reEhoalpjVDYrdHZpd3lHckU5WjFPNWRUWHhUQTVO?=
 =?utf-8?B?RzBqTFBvVkorc3BSSU1kSHRMcjdPR1hteVpjUkxuUjltMCthUGdXcm1HS0dB?=
 =?utf-8?B?VFJtbHp6WkYrRTYyUVUvNFhOUXJ2TzBkb3VKaUgrLytEbDRzbXNSU3JlcDV0?=
 =?utf-8?B?UW1xMDNsYTNhOTVla2h6S3c4L0JYNEQ1QS8yTG90QytmemJVRlUxMUpsY20z?=
 =?utf-8?B?ZW5RdG1hbG5UdEJtb2p5TGFScWtNY2RhNFBxbWNUZGZXNUYyNFQrZUxDcmcr?=
 =?utf-8?B?MmVnTmhOWGRFcmFxUHcycTlMOWpLT1VtR2plWnAvZGZBRnZkR1NNZUk4ZnJD?=
 =?utf-8?B?UmxNTWIyVm10QVJ5NVZWcXYzS1JtbHlYK3BpWms5S04xTmxWSUFaQmJFM0xJ?=
 =?utf-8?B?bWpNUmo3alBiSWsxY2JVbXdUNVZYREhjVDNxblAwVjllc1BySVRyVVlmai9T?=
 =?utf-8?B?MXhLUWMySStLMEgva0JmeXVweDFTTGgzTjh0QzJ3enJkbzNFUEk1RUs3YkJC?=
 =?utf-8?B?V3pEbU5IbkhUNEoyY3FsWjQrNTNkUVAxVEh4dVZ4L0V0bk9MR2QydUJJMmEv?=
 =?utf-8?B?Mnl5QjhaOHVEVTUzSFIyb0JiTkhjSTZHMzIwQjNNYjJWWi9CL1V0VzVEY1FD?=
 =?utf-8?B?a1JhNWpNcWpwUTVjajFpb2RXUjhuOThSRWphY2VGV1h1a3hRSTFJbFFwM0xI?=
 =?utf-8?B?cnFTN3laWm9XNTVpWlNqSGpOY2JhNXo5QW1nYXExS3REalFVczJCSFd6NjVm?=
 =?utf-8?B?SUpzb01jOWp5N1JlV0RFSVZodkNDdi8vWXJHSHQvVlB5MmlxZHNaS0RWT1E5?=
 =?utf-8?B?NmpWYWpzckYvMFh4OGI5NThPVmljUmlqejFhc0NhYjlEdkg4T2JkR2tYQXQ4?=
 =?utf-8?B?ZmVGZm15UGpXU0NSdnhLS1Z4K1ViY0JBcGl3aTVvT1Z0blMweEd1STBvS1oy?=
 =?utf-8?B?VjliVWNvMUkvQXI0S2VuZk1FOCtnNUxQNmcvcmZ2ZDBqWkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230037)(35042699019)(36860700010)(376011)(1800799021)(82310400023)(34020700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:52:03.6983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f6124c-a021-4e52-227c-08dc8edd0d0a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10730

The 06/17/2024 15:40, Florian Weimer wrote:
> >> A user can still set it by interacting with the register directly, but I guess
> >> we want something for the glibc interface..
> >> 
> >> Dave, any thoughts here?
> >
> > adding Florian too, since i found an old thread of his that tried
> > to add separate PKEY_DISABLE_READ and PKEY_DISABLE_EXECUTE, but
> > it did not seem to end up upstream. (this makes more sense to me
> > as libc api than the weird disable access semantics)
> 
> I still think it makes sense to have a full complenent of PKEY_* flags
> complementing the PROT_* flags, in a somewhat abstract fashion for
> pkey_alloc only.  The internal protection mask register encoding will
> differ from architecture to architecture, but the abstract glibc
> functions pkey_set and pkey_get could use them (if we are a bit
> careful).

to me it makes sense to have abstract

PKEY_DISABLE_READ
PKEY_DISABLE_WRITE
PKEY_DISABLE_EXECUTE
PKEY_DISABLE_ACCESS

where access is handled like

if (flags&PKEY_DISABLE_ACCESS)
	flags |= PKEY_DISABLE_READ|PKEY_DISABLE_WRITE;
disable_read = flags&PKEY_DISABLE_READ;
disable_write = flags&PKEY_DISABLE_WRITE;
disable_exec = flags&PKEY_DISABLE_EXECUTE;

if there are unsupported combinations like
disable_read&&!disable_write then those are rejected
by pkey_alloc and pkey_set.

this allows portable use of pkey apis.
(the flags could be target specific, but don't have to be)

