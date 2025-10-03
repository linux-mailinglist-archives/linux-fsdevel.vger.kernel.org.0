Return-Path: <linux-fsdevel+bounces-63360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A7BB678E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C49D4EB885
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4D2EB87D;
	Fri,  3 Oct 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Tu33Zywz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC12EAD1C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488056; cv=fail; b=cxk+FA3D0f7f2snM1ubH7elX4TM7gVI30L8kivNZoEOITwALKoJfsS5mWjhpGqKJeU5Qbu/eW0kmHmi4du8UOQdZglxYPVMwJhPdscCGyTC54S0qF955Y6535cnerr0Xly5XJ5tSZEKVqPybwTEbkAXgkJALAfUhbOF5C+UfcIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488056; c=relaxed/simple;
	bh=N7heEGsd06ON+ssvHqw4p5W2l3ZDImaTVVuNyb9DBok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+uisntv056/uH+QZpc0Uy63UpxBWOAXuK8M4NhMTTGD6f5RTIlkKJ+ywLicmUx5QkbS3iDpxPZyemtJ3Ud0WfDZGs/GRw+cieu3Um7WfTK1ARPB0GgAKvI5DcGbpkrlOto7dQutMPv3DtbOMQ0Ip/AgCz+qVPcItopEh3WsAic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Tu33Zywz; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021136.outbound.protection.outlook.com [40.107.208.136]) by mx-outbound23-140.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUpCq38SaJ5x8hHcSiOw/uv71QdWdQvIh4yD4IIJi1Shga6VP8yz0nmiWaCBwMJM7leaoDG6wTVC3tQ1LNnKSTCa6tslW5rhjOsNhMwpa5V4nbAgRFt9hXVAGR6pPQ4gSWxnStp7RkGGWTMOPG/5MGOSv0ONFtI6qSH6McnLt61fRmHA5bDr8pItDUiUpa5h8OG+M/elu1y4ul+7PJ2McRJmDvGPG7untg6QG6XZcnF82vE6l8/NLC20Xkp63W/Mx2xkgcKNjYFqtPmh9oZgQmoqJ+/5LEsqNye4vTWRZe/YsdDG76DrvfkTx0YORFAGjv3sJq0Vi5pOp/AxabvMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaa+k3zo1mmT6wQ8jtPOiTT4D93MZQ145aHYRXnCsJ0=;
 b=OXPMlzzIiEdaMEi2Qb36gXycRiu9g3Cl8L1+8et0w/g3dx8hxEEhFPI8fGKo8NAR2nPuL54Ey6SQ9XFuoDAUcrDlHY9X8Asrs4FVjTDSMKs5b0GvxToF0aj6tgmwUoIHFISzq+AHwSv+eWr3fDlstZzk4ur4xs+M/vzPxDkqFb81aLeDRxuiTw0GIc7jOOyUwVJEecxGV+K2C+ImbGVWpWFOpQe8AVCt4jcrXk83r8S+N337BIAsY4kcqane87DWyxngsX6l69opWkdqgt1lq/BlorYlqHB0U4aGgxpZPBu8YGMX/hG0qigFMxMnqnd90Ql1gGR+9FwW1RXXSDlp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaa+k3zo1mmT6wQ8jtPOiTT4D93MZQ145aHYRXnCsJ0=;
 b=Tu33ZywzHnHcSlMCV0+kjDihks/BB72jPpFed+RMFIKhJZc+jjDmZN+FeupHXwF9zB5hcIPd+NCWbT2vwAfo8KRdcVAKw1DIlHeLWwZYE5+KB/LBkUnPnibwKFYKc56Y2TVB5TjhFiPzDopXlro8kQ8maFVJhtk3jp2W4EujemU=
Received: from BY5PR17CA0029.namprd17.prod.outlook.com (2603:10b6:a03:1b8::42)
 by SA0PR19MB4523.namprd19.prod.outlook.com (2603:10b6:806:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:06:49 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::e6) by BY5PR17CA0029.outlook.office365.com
 (2603:10b6:a03:1b8::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 10:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:48 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id B3DD626E;
	Fri,  3 Oct 2025 10:06:47 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:46 +0200
Subject: [PATCH v2 5/7] fuse: {io-uring} Allow reduced number of ring
 queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-5-742ff1a8fc58@ddn.com>
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
In-Reply-To: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=1721;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=N7heEGsd06ON+ssvHqw4p5W2l3ZDImaTVVuNyb9DBok=;
 b=TLw13yMV4jY2CbISTY17IkA9Qb5pYQ2FZU767uxD05t2M6FW+w5KVFUFTWT8w49zir4Hpaz9f
 9s2Z50iX8xgDvWiQ8GIHKBdHd1nS+IlAlH3SuitYoLvZn/WecBjmIAr
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA0PR19MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: aec4c492-f3d7-474f-990a-08de02649107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDM0R2xyb3lENFhLSjBPdWkxZmJGVGxlZmcwckdnR2liOTVTWi9LQXBkR0xI?=
 =?utf-8?B?OHJ0ZC9HZGpaTXQwWGRHM1I0OG12eTMyUUYrWHNRN2JVWmF6dVR6NERlRU1a?=
 =?utf-8?B?d3VSMTdORm5sdTR6Q3NSQzVGR1g3TVh3cW1nRG40RjRFTWluOHFxZHd6ZDgy?=
 =?utf-8?B?dU1aOTc1aEY4aW94UmRpeEtCOVh1NHg0aVpCZUZxZFFGU3J2Y3Y0T3Y1V2Jl?=
 =?utf-8?B?SnVvTmxFNksybVJFQ0VLL1g5czNWUmNiRkQwSSs2VHNJaVZvQjhwVVIxNGph?=
 =?utf-8?B?dnBvTFNkUjhlQXVUT093S1FReUtuWnFNMW0wZDZHTWxIdzlSRnByRXBjY1R2?=
 =?utf-8?B?SkJYUFd6QWE5MXVNaVBRWWZVSi9JSmFOaHN3MWtMUGNBZkNxc0ZYYzRhUkxX?=
 =?utf-8?B?ZTZrbENBSjlRQWtzd0trU0NaekRXQ240dkM5WitqanhlaWh5cXRYSHV4NVRw?=
 =?utf-8?B?WVdudjd1cTdjVmorWTYxQ3FhWS9MUEVJV1RVWlZtc1M0NVhOYzNiUHgyY2Nj?=
 =?utf-8?B?b0JYVjB1MlpaaEcyOFF3ZndYS0dualQvMmxGZUFhelIwZWtKOEhVQnVqQ2h6?=
 =?utf-8?B?UkNLRVJTc3F1MEZROVFkQUJ5aFY3TXFJTGJKOC9NeDAxRlZkemkvNlYyTW4y?=
 =?utf-8?B?clBCZ3RxMDBndVpHU0VEMTV5cm9hVW0vY1NBMnBHWFlwYXdvbUlmWGUrcW5s?=
 =?utf-8?B?S1hiZ29oNWREY1hWZHpXV2tPU3ZyNExsZUIvUEhtVXNHMzg3cUNvd3BiaEdH?=
 =?utf-8?B?R2p1QTZQRjhoTU1xUnA0VURlQXh3UnJVT3hYVmJheW93N09qQllxdW9GL2pa?=
 =?utf-8?B?Vm1LRnRLQnNXUSt6MUI1SnNMK2N5RnBRTTgzZjJGUlBkd3VzR0ZWeUs0SCta?=
 =?utf-8?B?Wm9BbGFoWmlrWGF3dGhiaUgvY0UvbzlwWXJHaDlRM2ZQSXlEWGdNQ283Qk1Z?=
 =?utf-8?B?VHVmNVd3VXdZZDZiTEZUNjk4MHg3aUM5WHora0ZNYU9hNVV1RElBOWc2YjRD?=
 =?utf-8?B?WHhKQ1BvYWY0M1o1aEZzY2xvbmtEQ0s1eVVnQ2FSQkNaRmtkbk5sN3M3ZnRH?=
 =?utf-8?B?Mzc5UGtDdmRmSGlLeU1ybHYvT3A3T1BPYVZESUJHc29henBreGgveG55UmJF?=
 =?utf-8?B?Q0NXUWMxL2lRaG1sTXEwYUlMYy9ndUVteituZ0pRanVDNVNaSDRVZTR6aTNG?=
 =?utf-8?B?SU5tZm9ldGdlUVcweGFWS0ZjbFM2SU41Vko1QzNGdFY3Si9DWFZjTE9GQTRS?=
 =?utf-8?B?SU0zK1BUaUtyMW5RNGpOcm5mRVRDZjFoU1VKQm80czI3VFhiSkYxZURKV2hn?=
 =?utf-8?B?YTNRSmptNTBJQW9EZXhjb2lhRnlwejh3SzY5c2xvU0lnanJGREU5cmp0QnFv?=
 =?utf-8?B?S3oxK2locUlWVThyMkJZRDhMQ1NHNmxTNGxxWVdpTUlIS1piclo1bnZGYk93?=
 =?utf-8?B?enFUQU4wZ2ViOVVxNXJmU3I0MEtGSVJHNG5lbFZxYTlCbUlEQkkxTWlnbnQz?=
 =?utf-8?B?c2RkaUJmcWFnZXYyM3A5YjVvQXQ1OTV4MnlCUHdEcnp2dU9XVW9RZXd3WGdl?=
 =?utf-8?B?NlpYbDNWTkwrYjNSWnA0RUVzODg0SXFOaWRUVkEra0tFTGFLRkp0dGRjWHlM?=
 =?utf-8?B?ZFk5a0VQSC9UdHdqMVVac0JYSXVSby85dHo2T28rQ2pZWkRuQ3FycUJ6V0Zo?=
 =?utf-8?B?YUNlK0l1R0h3OFA1Wmh2YlZsaVdoWHlHZ1R3SnlWVk1Ld05uK2E2a1Zoc0ph?=
 =?utf-8?B?WHl0Q3NRanliSU4vb21jSTQ0NTRVMXk4MnVCdzBydDVneTVWV1l2YXJGcGdV?=
 =?utf-8?B?YUxhWVIvdFB3TUQzL2l2NFdJdHRtSytnTGIySTIrSndhNFZyR0MzYy9qKzYw?=
 =?utf-8?B?MzNaUmFMRWVRVjJOQWdrWEN4ZlgwcjlQOW55WWJ0OXI3SStKSTM1OXFKQm9y?=
 =?utf-8?B?L3AzTk1URklBbjhRZ0RScXdlQ2Q3TW5lQ2dXbWNESnI2VVJNVTRyZmxWa2ND?=
 =?utf-8?B?NFVOU2N2Q3lwakhSYkM3L3ZZMlBoeGR5SStMaHc4K3dhazd4cUd5YkJNVmhm?=
 =?utf-8?B?VHFZWWlQelNlQlFzS2dsTUZYV1Q2S2Q2Vk1rWnhjd3BnWU9zeGU0OWlzRm1x?=
 =?utf-8?Q?oeLtg0md1FT7Md2YEJvfCKHuj?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YSIBQZCxEgGL/Vc6PK8cBz/P8tQwaeTr2eUSJ+jQIydi3McE0x/uJZe+AbF2lx+y91WffNc4O8+YuxrpyFZGaGJJMRR/fW4yYOjAlw1MiSPXCUWuIRau4wUxeHABMTE0VCNaOo/i7CgzGPT0x5DVpqFteWdgYxdrOMe3vgj7dkfor86dVa2fJWTONfBcER4IToCoeUaC1VLzPvC1LxJgovuwlBOTjsvwYIEZa7BVJhz/0yEfuc3NvxLytsv9F8I2nc2QuV5/wGK6jcRzEsNUBUbUIqHsxTv/dBOJ4DtNvMcCtl/Zwn4gmaeuOJH89rn59L7uj4BPq2A6aMppeOOxoRqEEUwabWdwacKnI/oHNcDPags6P2Ua30vODg2m1qd8Xtl8wRJFTRIZvaFion48qNXTH/MHkMV/mx+LnTEWp85BMmqMq8Mx/xWVOPrQrMx1R/8tj4PULQ3KlsCQj+Xf6vkJk5AFiGUwCy4i5WYFQSrnXLKbDDO/3roOz4RUbhNmrF1wlQJt3XfuZxkHJy5ROlm/Ls1e1OMsWP/1ZQHrWV3jfNwFKr+TMBN0wDiO7z7pQ3BtGwQejlQDyZ3vPLnx+5xHhhkDHBU1lBx8t9au7vlAj0xRQhrSffhL+gft/rmVNl6uHJ7Z6yqzfmUBz8L++A==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:48.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec4c492-f3d7-474f-990a-08de02649107
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4523
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759488051-106028-2395-1933-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.208.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmpuZAVgZQMC0xxTTR0NzcMt
	nEJCXFxMTAINnM1CAl2cI8OSXFKNlIqTYWAKoy8NlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan13-67.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Queues selection (fuse_uring_get_queue) can handle reduced number
queues - using io-uring is possible now even with a single
queue and entry.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index bb5d7a98536963ec2e4c10982d33633db2573f4d..f5946bb1bbea930522921d49c04e047c70d21ee2 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -998,31 +998,6 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	return 0;
 }
 
-static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
-{
-	int qid;
-	struct fuse_ring_queue *queue;
-	bool ready = true;
-
-	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
-		if (current_qid == qid)
-			continue;
-
-		queue = ring->queues[qid];
-		if (!queue) {
-			ready = false;
-			break;
-		}
-
-		spin_lock(&queue->lock);
-		if (list_empty(&queue->ent_avail_queue))
-			ready = false;
-		spin_unlock(&queue->lock);
-	}
-
-	return ready;
-}
-
 /*
  * fuse_uring_req_fetch command handling
  */
@@ -1047,13 +1022,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
 
 	if (!ring->ready) {
-		bool ready = is_ring_ready(ring, queue->qid);
-
-		if (ready) {
-			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
-			WRITE_ONCE(ring->ready, true);
-			wake_up_all(&fc->blocked_waitq);
-		}
+		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
+		WRITE_ONCE(ring->ready, true);
+		wake_up_all(&fc->blocked_waitq);
 	}
 }
 

-- 
2.43.0


