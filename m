Return-Path: <linux-fsdevel+bounces-55758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF2B0E646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAEF1C8515A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A4287275;
	Tue, 22 Jul 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="NP5uhin5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5A280025
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222529; cv=fail; b=lVSeHaOkgn/yzc6JTkGspeGOgwf/UnHEMnouYWIkkpPW9aQ3pZL3xLAjdnZXjp00ud04x4eVwk1LHmmthYrFZK/dEk7V3jjaaP4OBamW1zwl/JA74s/JXJJP1/BtH+M55LAUoSfVLaOslreo4KlIoANA4nVtzDuek4dydRVKZyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222529; c=relaxed/simple;
	bh=RmFaWZ4w8DJzYNyZ00hd1zD6HA5lKvrrdRD+efXqj3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=js88l3n/D2EVkKdt3zB9QpA87RNWwIdX0VPACRxYh1ag9xq77/VF4I21qgGRrZYhuSKKbohSwOTPEg9Z/20UscwasLuBaEpDGzqKn+zgvmXvJA4zmioraqcmC5YOfq37r/K3uSAcVovF/R3XUE/pq7dVQsreDlVXLCNZDr+gZNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=NP5uhin5; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2097.outbound.protection.outlook.com [40.107.100.97]) by mx-outbound20-84.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 22:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxdVLPsjs7STOsFx3b5pgPQXAFMhpXx27NH5uMLuwpvQuFZePGPGSqQZJrzq/yQEjo0pzNeGt7D0qcLXhNQuuYdT9CUXtubS6VhMGoxuvaz2UFVm5D38ynM0Z4htMm2eU1aEZu6VN9G89ESnKYeNYy59ynPc61t37QtmA9aUtiU/Jz/EnbOMo/L909k/9sOHtzVMC6u1Pu9fAcVETfZ9oGKlBEvcLhNrCp11YZzlLVD9vbLHwE4zAxiaeBtu24MXlOxrH7sG+3PTqXDdts3LTbLixGQNt4ThAlsF4S5zE9wXLy4DjdyiDru+9kOID2VamHaCvfePxPa/zXGGrvNxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qft+VuRibFlyEv/2W/qCCtkhkwmgGxPEpugjADcp0A=;
 b=C1k6lnPoCE2JOrefbi/4H7MfxdI41pYfNnaluSxdTId8YLejNmvMo+spAM+D56JHbn9WllJWwaQC1vTXSsmPLbf5UvCcgJZrv6ro888hWCjjm0y0uQ8fFv9gEEn/+FGRB2kl0ZDflR56LVHjzgRkf0++juq6NtIms3qgmCqgOaaOHf/ymvKjThJACq8HvTqdqsxQeiLw1quR4/TSQ2eU7KggX5KMD5fXY0Asy3yDvHBhVKtRJtoP7teLK9+RjL3pvf3PU8ZhrgfFeJrlnUTeNPoPHVor6+zsibIwTz5M9qO1DAbzrOmCP7a8v8dPCtfby/wHjkMIAafBgKaWxtMrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qft+VuRibFlyEv/2W/qCCtkhkwmgGxPEpugjADcp0A=;
 b=NP5uhin5dQGMUf0ZgKvd/IdNw5HGeHUX8j+pjtqmEbKaYvBA1T3UEyGSh6n5bQcsT1AX2NSJHfLDQGMhFuI9YjOGqVzUrzZeIY1KCbeHIlO1DVGP13AAxD/6IHJLYiTKQC//lLnhHTJU5pymyA46zhzyTA4hiukILU6QDtgXEA4=
Received: from BN9P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::35)
 by DM4PR19MB6149.namprd19.prod.outlook.com (2603:10b6:8:b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.20; Tue, 22 Jul
 2025 22:15:13 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::39) by BN9P220CA0030.outlook.office365.com
 (2603:10b6:408:13e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 22:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 22:15:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 48AB3B2;
	Tue, 22 Jul 2025 22:15:11 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 23 Jul 2025 00:15:09 +0200
Subject: [PATCH 1/2] fuse: Refactor io-uring bg queue flush and queue abort
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-bg-flush-v1-1-cd7b089f3b23@ddn.com>
References: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com>
In-Reply-To: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753222509; l=3680;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=RmFaWZ4w8DJzYNyZ00hd1zD6HA5lKvrrdRD+efXqj3c=;
 b=AbvkLcqX22z7SGCLZuCfaIHH18QgPFRuCz0Orwg32o55zwPKXOa7PiqR3JV4/Zing7aQ/m3fZ
 HqrpfplYUTfBuJ12BAi7dM60H8g1Ru90DiBUrm5KFsxT/53BEnb8ltb
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM4PR19MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 830a60ab-2201-4b41-5645-08ddc96d3a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlEQkNPU1Zsa3VnYlhjVVZqMWt3WnVyczA1bFF3RkYralk1ZDR0VjM3cmhh?=
 =?utf-8?B?NXBBUGU0SGJ2NUlHdWVjWHhDZG0ranIzcjB5VEFxTjd2MHRiMDFyS1I1UDh3?=
 =?utf-8?B?QW0yQWtoSkZqUDk4UVVBcjQ3R1pwMksvQzZXVTgraHZZbkJOTDl1UnNwUlRi?=
 =?utf-8?B?bGZ5VElsWXpyTkF4RjErOGV3cXc4NDh2Z0I5aUJGTVhjWXJxWTNiV3dwdzJ6?=
 =?utf-8?B?WnlUY0hCbm5pUktUY0wyK2piYms5SnJSSVlWMllmZitDQ1JjOUhFdjA3Z0lm?=
 =?utf-8?B?NGJIYVREd2YyMnZLYWVmMVJRaG0zalBjYm5VVVZjeVc1OE5LSFpHSmQvYkJX?=
 =?utf-8?B?dk96clk5SDJ1OUozeDJxN3c2M0FFRTRDWFBxbGJCMVJHb01WL285Z3lBZUZE?=
 =?utf-8?B?TGFrOWZWVTVOVlVaV2h5d2JaeTlla3I5ZFdNbzBRd1NOelNhRUl4M29MVUph?=
 =?utf-8?B?b3RYUk1FWkwzR2xSQkRxbjFUZ2t2NjN1eTh0aGFaTTlpMWpFWithU1U1OW9w?=
 =?utf-8?B?VVZjTzRkWDk0dzdoKzFEcGFKT0NLci8zT1NjMEhGYkVrSUNlL3F6Qmp3cGE1?=
 =?utf-8?B?ZVB1WXhVNGJCVDlFa21mQXZhYkd2U1JxQU5oVCs1bjBCc2x0NzVJUnQ5S3Vl?=
 =?utf-8?B?cllzR2tpL1lNeWd3OVNUTUpZSXkwbjA0QjNLV2xUMW1HcVVTWHBDYTB5ejFa?=
 =?utf-8?B?ZWNITmxObktVMzJRbU1LVVdOMXE5aE9MZkp3RzZKL2RMemt1SUwxbDZsbmNX?=
 =?utf-8?B?UzlJd3Q4SXpwZzJLSzREMmNueHpTcUR1OUJqbzNvcDMxTk9Wa21wM1pDWGJa?=
 =?utf-8?B?b3NlZWpxazdvZVgvaWFxMW10bnBBZlpVa2tGMDRBRGxrYkJjWng1dTVsRnhw?=
 =?utf-8?B?dHQvOGlFRERveUxiUFgxWnRHNytST3hYSU05MmMzMkNJZ2NNalRkTkRoakhT?=
 =?utf-8?B?THJaNDF3ME5GWlJqWjFkK0JaSDJSSHpWU25WaWY2NE9OTVdPbFlra24zeVZS?=
 =?utf-8?B?V0pDdExCblVDNUEzYUlrNkJCdFZkM3Y1NXpwLzVub0hFeDFicnl1ZWpWKzla?=
 =?utf-8?B?K0pQVmJqUTFSTXl5R0NLMWxwVWJXeXRuOVhpeE84cXZRU2xrWnRlRnRBaVk4?=
 =?utf-8?B?cDJ3MWtHdjEyZTg3UjF1UWh2aStTZXlLVzduTVVXdTFLOFpsc1QxbkhucitE?=
 =?utf-8?B?UStDd0diWGVxenFVSWhXYy9BSkdzUE82YWZ5L2g5c2VNdjVleEM3dFRGdGFv?=
 =?utf-8?B?U2ZNYVFOa0dTdytZV3ZxRDFCWDRQRHUzZVQwNVQ3NFAvdzV4QjNzSDVFaDFR?=
 =?utf-8?B?aGFuOE9tMlVSNzRDUlhsY2tyd2xFTHdabHlEeldXQ0VrQWpMMU8xRERwTjUv?=
 =?utf-8?B?OFFRNFlxSlpJSEFNUmRvQkJqQ2d3MTg3cGt2eGxUZWkvU2xJK05reUgvK2lP?=
 =?utf-8?B?Y1o4blIzQkx0UzNOWDdnQ2VaWVIrYXZoL0xnSm5TTEYzaWlsSUZuRnlzOHIz?=
 =?utf-8?B?MDc4NVFwa0FkN3ZxRXZ4NE5FOHVONlBaMUFERjgxeW4rcS81SGNsQUI1Ykdr?=
 =?utf-8?B?cC9hbWY0Y2V5c0NaWThNa3hFYmNYTm5iU2hxT1dHNDZKVlpuNi9OZDQzYXFV?=
 =?utf-8?B?RmF1Ty9WQ2tiSFR2T2djQ0xGVnlDcWIydHFDMkJVRHo4SWtzcXdEeHlDN01z?=
 =?utf-8?B?R3p2djZKZVUrUlhQNGRRQmNycGFDYSs3czdYeXA5Y3ZyenVoRlU3MVVza1V3?=
 =?utf-8?B?VVRtYzdGZnM3ek5NelQ5TTJmNUZQbWtodzlubisxS3BoMWprYVNPL042NlZJ?=
 =?utf-8?B?dThLV29WT2tNM25BdkFPd2M4eGhGS2Frd3NET1ZMaWZvTnEwQTZ1a3RlNlhS?=
 =?utf-8?B?aHlrME5HcDRNbDJzcnFhQkxCWXRZOFhtZkwvSEtBSEg2VkVQNkQ1UGY4RjRG?=
 =?utf-8?B?OXdDSFhad3lzeEloVUxlL2p2SnBYNHV0L2p5MVNDMWU0UGFqM2lxQWxoelgz?=
 =?utf-8?B?VDM2elc2MEhJMUlqUStwbG5TT0lMaHNYOFlyZERMMlRtZi9VM29rallGNjA3?=
 =?utf-8?Q?MrUf9Z?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hyPdKMG0YddIfg6t+7cG8W15n2AXpflKqHLRmcqNHbKduyg1N7E5aN3+bNQj9oQSQHvXfWpb24c90pdzWSZEMQPYzSe4W+RIq8KTock7yiyJSZp63wrTwEK4N1E7hKccJ/z1n8UgQL0k2TFe8vxm1f1AY3ddyJLDV9LoVd0BMRlTzp6gnq4OFyAEix15ayfOPyTF0/ABj+3QwU1PZ69gfHa1tqeZ10eYalmFv4O9k3PNksn3rREJPaCiLc7iOZUM8vLLvvd1nNJAv8BoVGPMAVA/ak3Jn2EcDbWnMAuqTY9MjN1I8opIUCy8CslNLWfnTCe59uFTv621eggNmxgrZ6xUmcI7JGKgKyECN052HcmNlj0nI3wlZarLS+WRQPsFs9pHAeEqiSf2k48b4iJx9cspQSQx3apcwHMGzRcEhNGUrUHxlkqJWpalABsfRuNzT6Ts8w0IlNNANljiXJfMXwkxQM0+VIVKFj9bspxCVCPfIqZtsmsXrcC381fHdkdyPc8j8XUmWDd8IUUo+69OPfCioPylvJ9Gfc28Lgw3wZqwbdP9xSgNc5XC1kh3WANx2EYmizCCwm9C0Ga/l+ZoMRP+3ec2aE6dnJuIPLxKTOdPPkO78PxkHoMOHes+8/cDKq51O8z3pUThESVkEag/KA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:15:12.2452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830a60ab-2201-4b41-5645-08ddc96d3a64
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6149
X-BESS-ID: 1753222517-105204-28759-2056-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.100.97
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsam5qZAVgZQMMnCyMjSyDTVKN
	EwzdwgLcXQ3CjZLNkyNdnI0tAgMdFYqTYWAIS9lEdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan19-117.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is a preparation to allow fuse-io-uring bg queue
flush from flush_bg_queue()

This does two function renames:
fuse_uring_flush_bg -> fuse_uring_flush_queue_bg
fuse_uring_abort_end_requests -> fuse_uring_flush_bg

And fuse_uring_abort_end_queue_requests() is moved to
fuse_uring_stop_queues().

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 14 +++++++-------
 fs/fuse/dev_uring_i.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1cc2b40ae7b2fdf3a57dc57eaac42..eca457d1005e7ecb9d220d5092d00cf60961afea 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -47,7 +47,7 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
 	return pdu->ent;
 }
 
-static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
+static void fuse_uring_flush_queue_bg(struct fuse_ring_queue *queue)
 {
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
@@ -88,7 +88,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
-		fuse_uring_flush_bg(queue);
+		fuse_uring_flush_queue_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
 
@@ -117,11 +117,11 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
 	fuse_dev_end_requests(&req_list);
 }
 
-void fuse_uring_abort_end_requests(struct fuse_ring *ring)
+void fuse_uring_flush_bg(struct fuse_conn *fc)
 {
 	int qid;
 	struct fuse_ring_queue *queue;
-	struct fuse_conn *fc = ring->fc;
+	struct fuse_ring *ring = fc->ring;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
@@ -133,10 +133,9 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 		WARN_ON_ONCE(ring->fc->max_background != UINT_MAX);
 		spin_lock(&queue->lock);
 		spin_lock(&fc->bg_lock);
-		fuse_uring_flush_bg(queue);
+		fuse_uring_flush_queue_bg(queue);
 		spin_unlock(&fc->bg_lock);
 		spin_unlock(&queue->lock);
-		fuse_uring_abort_end_queue_requests(queue);
 	}
 }
 
@@ -475,6 +474,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 		if (!queue)
 			continue;
 
+		fuse_uring_abort_end_queue_requests(queue);
 		fuse_uring_teardown_entries(queue);
 	}
 
@@ -1326,7 +1326,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	fc->num_background++;
 	if (fc->num_background == fc->max_background)
 		fc->blocked = 1;
-	fuse_uring_flush_bg(queue);
+	fuse_uring_flush_queue_bg(queue);
 	spin_unlock(&fc->bg_lock);
 
 	/*
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce14158904a86c248c77767be4fe5ae..55f52508de3ced624ac17fba6da1b637b1697dff 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -138,7 +138,7 @@ struct fuse_ring {
 bool fuse_uring_enabled(void);
 void fuse_uring_destruct(struct fuse_conn *fc);
 void fuse_uring_stop_queues(struct fuse_ring *ring);
-void fuse_uring_abort_end_requests(struct fuse_ring *ring);
+void fuse_uring_flush_bg(struct fuse_conn *fc);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
@@ -153,7 +153,7 @@ static inline void fuse_uring_abort(struct fuse_conn *fc)
 		return;
 
 	if (atomic_read(&ring->queue_refs) > 0) {
-		fuse_uring_abort_end_requests(ring);
+		fuse_uring_flush_bg(fc);
 		fuse_uring_stop_queues(ring);
 	}
 }

-- 
2.43.0


