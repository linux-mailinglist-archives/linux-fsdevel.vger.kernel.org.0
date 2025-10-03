Return-Path: <linux-fsdevel+bounces-63359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A326FBB679B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEDE48635A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FA2EB863;
	Fri,  3 Oct 2025 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="XF//v+hH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7C2EAB99
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488051; cv=fail; b=X45lfXlQK7I5jV4gLfy2XdaKMZ+7sS4NDJqf9Yu9TQqKi3vsgsWqRGPJAbDqEXXo66xwyUoWMspYSTCHt+57a66OeJF2D3ajUCJd+fUy8y5zhso6+YN2kempptYjTAg7DTA4eyrMzfiHe2O0d/yIC41SzMNXPUdh83jmNDQSqaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488051; c=relaxed/simple;
	bh=whwruQ/b6bwJzy46ce0tLn2imLEI5NYK617in5+kN5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfeWCU4D5LMecXmEkj1J5RKYywhzNzb4yOhr+l6QxLxUkK6ZnlP4PR+Zv91EGNk8JpevsoxDjRFdQoCix9fN1gAwAAUTDWoNgvKyS+W3/0iQwChVNZnbVjXhBUWJZ+y3Gw1OXrOlT/1jayI8S47yVfz04RPfLZRW1Oz/DOU7cRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=XF//v+hH; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023103.outbound.protection.outlook.com [40.93.201.103]) by mx-outbound12-87.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ6IqYpQmVFe4V6pqosC0w6dpulDIZwS64AWZCXcFvMxsUtL+xiadYIxojABzhcfVk1HbqntoBbQZVSQ7KC7fiOUtn+ZZWq3KvI1k/yJeVbXQdpOhJM4+L8k3QDivJpGfkMg7R0lTv5nKUh4rF9NCNWBZ4NMjFUx1eQ1PshqHrUX3pKPTNAmxWFdr/1oy/qXungb7TFiez54gY3gq752p8Gpeq+kmUjSjrHYI63TnY9RLFm78WgqH5E2guxe359bnhFYq9oEStOskwdqU7WLbh06hYNtk6pt/Ip/7xkS9qdTf+gex1Xh+HGqngC0WyV0K2yS1ZifXkgCtYV/vioW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ9jpexmh2D3UZghP6edlPrArLVXLhi69gojQGULvVs=;
 b=hjemGizTwcDbhjWEKpJRHtVSQVb3601hpA9wleYNZOUCIN7i3WEYL/CDj5Sz5mW5lkI93P5MQw8DwD0VVKL1U7jLRd6JMAa6nMdbBlcTGL3Vtow9fxuEmtPgdmI9sFIoArxd0u0aHCOXJmevc/L2i4RgnZ0nF4m/NGW3p2VwcsTGEfPO4LMdaHWOoPcGWnMYeKeFJmBcFrdGAE0IARW3zp5SdNVe4H//q7t4nbjBahLVAcfmCF2tS4OdMRrlzuZJnq9A2YBqZWHxXQIinVYs0aBexvD9D1m8sGKd6voU9qk1MLNQEULZUuPajMK5BbRHsjidrcTPyoXufhuThoE76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ9jpexmh2D3UZghP6edlPrArLVXLhi69gojQGULvVs=;
 b=XF//v+hHeVk98K/Em8lYMycCqDEsh/sxL9ibj7akN5BpsOIITF0rp/YE/LUsE2fM3oJpcds3zoY2JG+Y/f9C9pm1NTLCTtsCaMQo1ShNkRbr33OWhty+uYFYjE5/8dozDVj9hitprNvjHTKwvFE7wNfPtVo5dmze919O83Tf1TQ=
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by LV1PR19MB8941.namprd19.prod.outlook.com (2603:10b6:408:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 10:06:45 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::d1) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 10:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:44 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id DF45426E;
	Fri,  3 Oct 2025 10:06:43 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:42 +0200
Subject: [PATCH v2 1/7] fuse: {io-uring} Add queue length counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-1-742ff1a8fc58@ddn.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=3159;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=whwruQ/b6bwJzy46ce0tLn2imLEI5NYK617in5+kN5E=;
 b=3ZjaunPLJpN87HGsKNDy+8tie2sdsFoogPTuYAvaWA8W9t/oqKxPNRspZ0aJLf9WM0ReXbala
 IdXtSm4tIKkCNVVZqsLt7qS4pk6XV0feBqogrMYq6PCyiejj02Rn+IM
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|LV1PR19MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc273de-560b-4c96-4b74-08de02648ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|36860700013|19092799006|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MUJkQmo0dFBBWDM5WFhISjd6TXBOZ004amh6UnZ3bGpPakxCR3hFM251SzlC?=
 =?utf-8?B?cDltZWtNSzVENWVxa2ZDanRkWWRxTlJLdnByL25KcUJiakhla25RbGIrRWNW?=
 =?utf-8?B?UzZnMU9TWFYwWjdFWkRIYm9BNDdSVmpqWUF2c0pMRW84VHF1SkFQeXRhT0VI?=
 =?utf-8?B?eEVuNTd2clhyYmJLN25lS1QzaHBCZnM1eUVJaVlwQnhMTS9PTnVITkR4OVYv?=
 =?utf-8?B?RVA0ckQyeFIxR0xnSzhTWlc3eVpaL2NtL2s5RlZYVWFaUllhSnQvMGREcjVG?=
 =?utf-8?B?cVNWdFIvamNNRXZTc244ck1WdE40alMzYWR3VTJwSFhEbEwzS2Jrd3dRa3Bm?=
 =?utf-8?B?UDFPQW1mcTRxQkwwK3NTZUZzUWxodHlKV1pqN21xdStScFF0czFzUXdoOXZL?=
 =?utf-8?B?alkxM2R1OHREYjM5aTI4ZzdsQlN2T2ZoNTZHR2o2WEI5ZGw3QXlIdjBLQUR3?=
 =?utf-8?B?NThITzF3ZEhuSUZRbGJTSW9rNVdzUmk5YnVTRUYxM3oyTXNobzlRc1liVXN6?=
 =?utf-8?B?R2FYN2w0LytUekpFeWpZWHQwRDVUZ3JGRldJblRlY3hFdzgyeXN0cy9vbmxp?=
 =?utf-8?B?UUpnSFFBNjJQQ3R3c0p1MmRxWkVnWTRGOThjL2RJKzNGaDMrOGdHNHo5TTBi?=
 =?utf-8?B?SVBlcU00OTBub1VPdk5Pa01xc1V3dDVYaUkra0xXbHNNTjd2ZjIvaURrWGlW?=
 =?utf-8?B?N0dsMEZSNjB0bEgxeUZ2eFFXSVhKZDRLbSsvVW1vZ3IvTnRwL2NwMXdJTzdC?=
 =?utf-8?B?UWNNUDFwTEhpVnFPSDlNaGR2K09NT21VZnR0ZnpRdXhraEdQSmFPeVV0ZGo5?=
 =?utf-8?B?UmE2bWZzaGhUQWxhbGlmTER1YVRTU2xQTUplWW9GV3NjclRralRtOVM3ZUxs?=
 =?utf-8?B?WGlqeS9kWDdqUXp2TG1GN2tPQmVSaHFNSkpPRE5TQ29CZjFPVkVTRkRBLzJO?=
 =?utf-8?B?NXlxbGZYNnhxM1FPSzA0UkRJaUljNGZHWHN2RlNsbFE3MytLZnJEVmI0d2Zp?=
 =?utf-8?B?UFI2WHFVV0dLZ2tNRytVbEJlcTNpaGs0R0dobHlqYlZzUkQwK1E5dkFsTHZG?=
 =?utf-8?B?d0E2WU5hVHJBbzVqMXJac1JhUjhITTJMdjVocURwdFRUUTlQWnRCRDIyNmti?=
 =?utf-8?B?NzNTQ201TFhUUWo3c0xvQlpXUWFEYnBmQXZzbERPOE96V3RpeGtNUWx5RUpD?=
 =?utf-8?B?bTUxdzNncGhGZWZzeWpiQnNLczJPM1puWUtjUEsvMzFQRTJRZUVkT3lHQVph?=
 =?utf-8?B?THBYTDUzTFl4QUpadHFFRVk0UXJDUEdEVXFHMmM0NGw1QmFVS2dzMGZ5cW5X?=
 =?utf-8?B?a2NyUjIwWU1OR0t5U0ZXWmk0Q0xnMzl6NVNqTlVRQ2JDalZMRkwxRmRHYzNi?=
 =?utf-8?B?U2ptYXFwZWo4Q2taaUFabDVvQmRTais5SERIM0VSYmV2c3RUTVVXKzVxcUZ5?=
 =?utf-8?B?QjJHTThHUHBwU2FrcTV0aVNvVGNlU0EzcWRxTVJqS05PVUZtVk9RTysrL2N3?=
 =?utf-8?B?eUpIYkd5bUcrSWpORjJLcmFsN3pGSjRoRW4vT2FOZCtUeUhXQTl4NkQ4LzZr?=
 =?utf-8?B?QVZ0dlQwRFVkRTRqMnpYdXZxVFpZVmlKWGJyQ0UzRUFCdnFMa1VxdzhYb3pZ?=
 =?utf-8?B?bHZaVXN0RTNuS3VOT01DRjNPRE1GVkt1L2d0UEM0Z1g4cW9OQWw3RXhlTXFS?=
 =?utf-8?B?SkI2Z0J3N0lqNmFJRnJQcmZ4M3pWSTBTaEtJMjRiYis2Y1drSldZMGVXUW9a?=
 =?utf-8?B?U3pkVGtXZi9jYkFlNEU5RzF5Vm8wOW11SEdyMHIxcFFLaTVJcjZLN2g2VHp6?=
 =?utf-8?B?cWdUZTJIdVBzQ25qY00rUEpLWHBjckUybG9JOG01M3lzbE1iR0dyV3gvL2JX?=
 =?utf-8?B?dHk0VEJCRHh4YlFmQ1NIZStWKzladlgzMjJISnZkZGwyZk93bmVUQTQ5VmhV?=
 =?utf-8?B?NHk5VVhLeDdaMXR5MDArcTJMUWdhdzlGZnhtU2s1WWUxU05NMFhJWTBxV3dL?=
 =?utf-8?B?TitsR0ZPVnJIWWh4YkczMzBDZ3lvY1JqeWp6dDd5RDVPMFhsLzlJMHFrSDNa?=
 =?utf-8?B?SHd6NFNqQWVabmpyZzdyZ1dCTy82NW5vdXoraVRkSVZTRHhJbHowbWpmMGdT?=
 =?utf-8?Q?hxW/KDS40E1kRA17znrdHcEZU?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(19092799006)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 NDjrtbUqXpB60eg7xDwY2ezSRJK7FRKX+COpfZcR4l51RoG+dNsYkyrPpUq5A2bqyVr5P7mDaeKaaId/b1UzcNygycocR9LcAcXxVjviFPpMLLdIKlSVSu9o8Z8DdGwVRvD+/XAmFvzAtfdZawOXlqZrVqykGYJEjc9MgN9cTbCyrRJWgx57dO7g59kwvcUi0mgc4FufZGbYrFIpx0kYkzHc6QI35VuGAb5oBRUsmx8wjOrDZW5OfNyXD+RHzq+DBEDL0OLik7IH4Y7moMbY0NU1DgE+TjYfgmA4uTkeufjtiw41IkKV2qdDD0S50b9ivk+uoQqNOBk5Yh0B5WUa0Fa5/1cWIz1uODjxHX6UvBorfhxpfx+kcwOF3UjfoQSE4VMPXY0iGgOk6WiHf55chca26vtOT7rlVbB+EtIPtnfAtZvw/Z59CAyiEc+tTZ7IrGoHkYuFyG1u/z+dPn20cCbd56giPJ5wK5w8wYm1sFXwUx8X6VzJ7RG8McNZisBCZ67odJIi5NhYalTndwyMeDRB14wztrUdyrviFs0LtJHhBAc1dpUv32QObncdaEWFJhI/O4bolLmRhsC2XoNRtWzzZEhBL1MUIetHjNIBXrthE9k1AEcXvS1IUnTnExV81LyiQFkF2SP2A8VcT8t+4w==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:44.7825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc273de-560b-4c96-4b74-08de02648ec8
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR19MB8941
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759488045-103159-8916-11814-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.201.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGZmZAVgZQ0DDZ0Cw5xTjROM
	000cDCxNTExDgp0dIiLc0s1dzI2DRFqTYWAKc5/rpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan8-127.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is another preparation and will be used for decision
which queue to add a request to.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 17 +++++++++++++++--
 fs/fuse/dev_uring_i.h |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1cc2b40ae7b2fdf3a57dc57eaac42..2f2f7ff5e95a63a4df76f484d30cce1077b29123 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -85,13 +85,13 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
 	ent->fuse_req = NULL;
+	queue->nr_reqs--;
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
-
 	spin_unlock(&queue->lock);
 
 	if (error)
@@ -111,6 +111,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
 	list_for_each_entry(req, &queue->fuse_req_queue, list)
 		clear_bit(FR_PENDING, &req->flags);
 	list_splice_init(&queue->fuse_req_queue, &req_list);
+	queue->nr_reqs = 0;
 	spin_unlock(&queue->lock);
 
 	/* must not hold queue lock to avoid order issues with fi->lock */
@@ -1280,10 +1281,13 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->ring_queue = queue;
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
+	queue->nr_reqs++;
+
 	if (ent)
 		fuse_uring_add_req_to_ring_ent(ent, req);
 	else
 		list_add_tail(&req->list, &queue->fuse_req_queue);
+
 	spin_unlock(&queue->lock);
 
 	if (ent)
@@ -1319,6 +1323,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	set_bit(FR_URING, &req->flags);
 	req->ring_queue = queue;
 	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
+	queue->nr_reqs++;
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
@@ -1351,8 +1356,16 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 bool fuse_uring_remove_pending_req(struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = req->ring_queue;
+	bool removed = fuse_remove_pending_req(req, &queue->lock);
 
-	return fuse_remove_pending_req(req, &queue->lock);
+	if (removed) {
+		/* Update counters after successful removal */
+		spin_lock(&queue->lock);
+		queue->nr_reqs--;
+		spin_unlock(&queue->lock);
+	}
+
+	return removed;
 }
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce14158904a86c248c77767be4fe5ae..c63bed9f863d53d4ac2bed7bfbda61941cd99083 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -94,6 +94,9 @@ struct fuse_ring_queue {
 	/* background fuse requests */
 	struct list_head fuse_req_bg_queue;
 
+	/* number of requests queued or in userspace */
+	unsigned int nr_reqs;
+
 	struct fuse_pqueue fpq;
 
 	unsigned int active_background;

-- 
2.43.0


