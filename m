Return-Path: <linux-fsdevel+bounces-79137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD7vMx63pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:25:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3A1EC9F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C8031010B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE929382373;
	Tue,  3 Mar 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ZPcgRwYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E539099A;
	Tue,  3 Mar 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533435; cv=fail; b=GdO2Vt4MVhGAcuDdUVdVRMIGMf/i4RGn8Gyn9dQEQkJE7AWcwQFDG15y31viPdiwkXLff/MnHgF5cguoDS3v23LVwwQYz9V+FUhKZNjUP/SkqWsKBmI646Ihb5M0iHY4TjUM8/2ocDsy/Rdea3sS2nVfGWzwB2vBlbJvqIyK6WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533435; c=relaxed/simple;
	bh=MAwrNDmCln0z0M8XjBWhT9tjfTQojs/WnK2fjuStDsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OCuOC5RzqMa1wULdSLF6FJR+t9kGVqdTuD6eF10BUUIHlNI7XiIyNikPTI0G7Rv+8RkCNlCG5OaDlj3ECQJYv3b5El6493KSpc9PdmJbJwXv8AKwI1BBGy2NIKU7X5ny6DrodU9kPfNX9cxQphSXW0gvEXhKPyj9AANg9ZBpLyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ZPcgRwYS; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022107.outbound.protection.outlook.com [52.101.43.107]) by mx-outbound12-114.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 03 Mar 2026 10:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOVt11sY91euP+zs8pARCR0NFdy7lDc9bFNT+y3SHNH/Sp6uzhc9qW0pZF3Bf9STmr8goKUVGfTuGyV1llAzd0gyDo/ifBIGot3n9elXkstNknqyeXXE4h1SYwWGxtXmF+C1ZZKhUwJzuL6KmS9a+yZg3a8EMMs5wcAvNAN95E7c6NDHYCPmSKKF35FizxxHt88fo1tE0MiHGcB5siRkFGtBdS99yF2V4mOT/WvCvEF5b8+UKMvsYq+g0lbo+o9j/OHNu6U7Z0Ts5m9TaVWqE5sgj0KSyBeqS2/or8C0w7CLgt2ce2WdfmhNV/1FM/7WBgNGjfaf8mPslRmTELNU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3fE1ZKUziC5ZLKZ1BVN07Vt+c1kTUlUTEAoXTDVhZk=;
 b=C0BjYDl7LNE/s9MhFCEnrTVy39/Em9FXXZzWYsYzKFseM1aHe0po3vXGGo5JtA8szsrXuPj/0Yyd0siEFfuYroSrGGheUY9o5M3KmoCSL1IOVMpPnS3Sj94UBgFMzwJeO0TJOGe+HK672T0saB31Lwr5po1wUpEPamwwy4dR8xZyib9mrgkMm8gFzgjYQYeuEcwnWe+Xrt1EKoXDavjChH9yp30x7+bktDtHm3DBnOqB7mOeersCtkknyB4W4ofKayL7fF0/Z8slp0S3avdFwgGl1c2n4Q4snH1M5K5p7FS7tVG4hkJOReRbPa11xdk/9+ohYlklgQ87ND2kNSCVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3fE1ZKUziC5ZLKZ1BVN07Vt+c1kTUlUTEAoXTDVhZk=;
 b=ZPcgRwYS2Ge64/SJC8NRSanunqTnVSPZ0+3BuqqWb0DnimsaAS7xjIxtds2gzxMCTKEghLKTQNYne1D8SnKKkEcM2LAknAuOozPYLH0guXjYWDf9nnFW4jC14mpY3CJfypQ51/OIjokvk9aSwVu34/gWqSLjpmmlBXu3bJZUJM0=
Received: from IA1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::8)
 by SA0PR19MB4508.namprd19.prod.outlook.com (2603:10b6:806:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:23:42 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::87) by IA1P220CA0014.outlook.office365.com
 (2603:10b6:208:464::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 10:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Tue, 3 Mar 2026 10:23:41 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 682705B4;
	Tue,  3 Mar 2026 10:23:40 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 03 Mar 2026 11:23:39 +0100
Subject: [PATCH] fuse: move page cache invalidation after AIO to workqueue
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com>
X-B4-Tracking: v=1; b=H4sIAKq2pmkC/x2NSwqEMBBEryK9nob4N3OVwUWbtNogUZJBFPHuN
 i5q8aBe1QWJo3CCb3ZB5F2SrEEh/2TgZgoTo3hlKEzRmNKUSOkMDr2sSBpHbtZK2GkRT3+V0dq
 2GnjwdddY0Jkt8ijHe/Hr7/sBkDze23IAAAA=
X-Change-ID: 20260303-async-dio-aio-cache-invalidation-9974bebd5869
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cheng Ding <cding@ddn.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772533419; l=4670;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Wa+p1Weg2NqNyjv1eyyHatJk/do6M0GRboo9OLCKkdI=;
 b=e+FKtSd7254zNkwD4L5UHUzRyYfpQiBmiBfi/etDoOGo7REhKAD7fPx6swioKjULaD4CJlVjN
 ZHphAZxB2XFAxCFr4blIVnIGNQ5yGWftBCRA426FAz7xcjLd9l+eiLK
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SA0PR19MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0a32f7-f5c7-4242-4282-08de790ef127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|1800799024|376014|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	r53fuRrzGq/6omxJ/cnoRh7tPfunU4NggzgoU9Um61yrYEzQCgvg/gMpepueRgANl/AvDHl9/+gopjeQhjJwJzPUi77yv3EwPAtYY6ZLTq8unTn2yWIsBpHqoIgpGhzQbiRSFBUwm8gNgeflHFrYWtl/BTMQ+TrGXSQOujwXQ7v4as8Iwd2RPbp4Ucxcta31xUZLJmFmzFr236N9Vuf9mBoPkOL2stj3cQbUVG7f8wHgYlrJQg9V47cekgwB3mTb5jeE5CIeTJDwQ7PbTUk2qsALblV+TS2ALTwQyyDmVPr12CdAe91181PWRrurvXH31wSx7NWXY5hh+v35yUgp3OU2MEMjtpF7hxCqC8YyzmspYAhZUuf0B8D34/nIux+Wsig4QP6qAXbJf+TYBWI6kCqYaM+Y8nrH53KcUO/ftcRaujde/lphDo1mDbNqWIQ/ckplHT1oeoIxP0swPUGXCzfZvs0cyXqB7wOu5Qfe2gIT+Wt2I+z9wCZQAgytgWiBsGFxj9hnwBk2g1cgR5xz5/16Zvi7Tu77FFjy7SkrkGuLfHYoiifexEPjNfaUaCfdSy5hnkbNKx+Y0c1vFSTHN7BbeH+tC8ZyMLxNM0BGtQtRKzXTmUMNOGYV3EDiH3JIf5gV6G2tDCOPA8dxNCjVUMAF+WxrS+L0yDhpHMOuMRxs/uBRtmZQcdV8rMO36BeCSBuQ4K4hpoVKaDE3YQz2g9pKBuslWASleB70pELU0e0CD3WsgtcDWpIRvLUzPlxcNu57s5qA0R358tZly2/EcaEHaGKEC43M5GPSn8TFdrVqP8oju//QOy9pa3uEs7dxRgceuGBeQH68GzluG0DYCg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(1800799024)(376014)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e8FZKlv95qyzovjt1oHuWHdSOn5SoxNFrq3YFXrxMPka0XgLVrmcDA3q79greLeAYAY3dlwWBGgXww2Chicm8+SEWf+z+SHRq6sFZm9b1owsuzyJBV6jgWO4jpBTawgBK/b1howg7NOhMzm1QE5X8sNn68hYIsumURhAmPhyCcrvj5WkVfmRYDerg3kz3m51XS/+BuTI4RXOuSTeyvSKP+7ajT8msUZlk1HDX5Y3MhGt103mncbBYRSIYzhoYyYGgAsXFCEyEQgUEXyM6TqLcYa5xBtmB8vrfe0PNtpxoVqBguOCEasLMh3oUX2mZBvYanMUNUKUHjtnn1976rMe8sVpNu9XxjtHvv8cOAmJHIRMKuTjXmJIzgtRukkHNofVBDC0jHs7B1uIunZjqkCRBJXbittwd1WjK3peFg22N7ESMpZHRxtb95BrdZKQCmni
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0NAsRZosM17b6K4dOaNN+d4mlPxCnQfDE2M1Xl9ttvvuepik+A51cF45LUUuDyMXYh0q+ldpHk5wMijlKIy8/kLWxiQS8SUvvnCNvh6ps6SADNyAGrJtaLWdR3O/l+OJyka85fncd+DkOJDeL4az6FzOCTNdB3JiAPzy5rpq0fwnSYn/V3j80xTLYEAlNuR7Dathg1cv+NTexpGu/TH3G7NUATSx3p2EztmrXBuLA2S+yiliQJXjUIO1vvbztXRbUCMBAXm0Tg1wmFL/Ewuh5/73a4+xyJFlOfA9iAu3D8SmQk/u1gwPGGBPZblVyhoDyEEsgoAd7bVhc9MJ8dp2bbOmcO5Ktrjv/13LYdqG9AwojDHZJX1ta//JuslJ0Y9OzOy2ikkmpC7zq0Qc38N4eMW0TUfp8tMf0uRw8xumEr+kMS0pvMAjp2ISflzUcMB+qcH8HklMoaWBBgL57qYvzeoeMoLvo98Skq5cPG0jh8tUe+0TCa+Ao30yH7EhNARVtw6hKTroTluLNDGS1IWlLJNdxaqXCR5hhlPEzUNbi7jCFp1q9fQF02EIwb2lcop+ie7xUQZMP4aDRCpbhpQs2uCMdoeKUaskn4T1uq07ECZEpMWwPbPNfVRO65tntTJwFoCF+SuWv4qSdJaYMEa7EQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:23:41.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0a32f7-f5c7-4242-4282-08de790ef127
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4508
X-BESS-ID: 1772533424-103186-7674-116270-1
X-BESS-VER: 2019.1_20260224.2149
X-BESS-Apparent-Source-IP: 52.101.43.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViam5sZAVgZQ0CDF1NDY2NDC1N
	wk1SIx1dDCKC05Kc0gNdnCPMnCINlIqTYWAESbl5tBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.271537 [from 
	cloudscan22-222.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1
X-Rspamd-Queue-Id: 37A3A1EC9F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ddn.com,reject];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79137-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ddn.com:dkim,ddn.com:email,ddn.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ddn.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Cheng Ding <cding@ddn.com>

Invalidating the page cache in fuse_aio_complete() causes deadlock.
Call Trace:
 <TASK>
 __schedule+0x27c/0x6b0
 schedule+0x33/0x110
 io_schedule+0x46/0x80
 folio_wait_bit_common+0x136/0x330
 __folio_lock+0x17/0x30
 invalidate_inode_pages2_range+0x1d2/0x4f0
 fuse_aio_complete+0x258/0x270 [fuse]
 fuse_aio_complete_req+0x87/0xd0 [fuse]
 fuse_request_end+0x18e/0x200 [fuse]
 fuse_uring_req_end+0x87/0xd0 [fuse]
 fuse_uring_cmd+0x241/0xf20 [fuse]
 io_uring_cmd+0x9f/0x140
 io_issue_sqe+0x193/0x410
 io_submit_sqes+0x128/0x3e0
 __do_sys_io_uring_enter+0x2ea/0x490
 __x64_sys_io_uring_enter+0x22/0x40

Move the invalidate_inode_pages2_range() call to a workqueue worker
to avoid this issue. This approach is similar to
iomap_dio_bio_end_io().

(Minor edit by Bernd to avoid a merge conflict in Miklos' for-next
branch). The commit is based on that branch with the addition of
https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)

Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Cheng Ding <cding@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c   | 39 +++++++++++++++++++++++++++++----------
 fs/fuse/fuse_i.h |  1 +
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 64282c68d1ec7e4616e51735c1c0e8f2ec29cfad..b16515e3b42d33795ad45cf1e374ffab674714f7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -23,6 +23,8 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/iomap.h>
 
+int sb_init_dio_done_wq(struct super_block *sb);
+
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
 			  struct fuse_open_out *outargp)
@@ -635,6 +637,19 @@ static ssize_t fuse_get_res_by_io(struct fuse_io_priv *io)
 	return io->bytes < 0 ? io->size : io->bytes;
 }
 
+static void fuse_aio_invalidate_worker(struct work_struct *work)
+{
+	struct fuse_io_priv *io = container_of(work, struct fuse_io_priv, work);
+	struct address_space *mapping = io->iocb->ki_filp->f_mapping;
+	ssize_t res = fuse_get_res_by_io(io);
+	pgoff_t start = io->offset >> PAGE_SHIFT;
+	pgoff_t end = (io->offset + res - 1) >> PAGE_SHIFT;
+
+	invalidate_inode_pages2_range(mapping, start, end);
+	io->iocb->ki_complete(io->iocb, res);
+	kref_put(&io->refcnt, fuse_io_release);
+}
+
 /*
  * In case of short read, the caller sets 'pos' to the position of
  * actual end of fuse request in IO request. Otherwise, if bytes_requested
@@ -667,28 +682,32 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 	spin_unlock(&io->lock);
 
 	if (!left && !io->blocking) {
+		struct inode *inode = file_inode(io->iocb->ki_filp);
+		struct address_space *mapping = io->iocb->ki_filp->f_mapping;
 		ssize_t res = fuse_get_res_by_io(io);
 
 		if (res >= 0) {
-			struct inode *inode = file_inode(io->iocb->ki_filp);
 			struct fuse_conn *fc = get_fuse_conn(inode);
 			struct fuse_inode *fi = get_fuse_inode(inode);
-			struct address_space *mapping = io->iocb->ki_filp->f_mapping;
 
+			spin_lock(&fi->lock);
+			fi->attr_version = atomic64_inc_return(&fc->attr_version);
+			spin_unlock(&fi->lock);
+		}
+
+		if (io->write && res > 0 && mapping->nrpages) {
 			/*
 			 * As in generic_file_direct_write(), invalidate after the
 			 * write, to invalidate read-ahead cache that may have competed
 			 * with the write.
 			 */
-			if (io->write && res && mapping->nrpages) {
-				invalidate_inode_pages2_range(mapping,
-						io->offset >> PAGE_SHIFT,
-						(io->offset + res - 1) >> PAGE_SHIFT);
+			if (!inode->i_sb->s_dio_done_wq)
+				res = sb_init_dio_done_wq(inode->i_sb);
+			if (res >= 0) {
+				INIT_WORK(&io->work, fuse_aio_invalidate_worker);
+				queue_work(inode->i_sb->s_dio_done_wq, &io->work);
+				return;
 			}
-
-			spin_lock(&fi->lock);
-			fi->attr_version = atomic64_inc_return(&fc->attr_version);
-			spin_unlock(&fi->lock);
 		}
 
 		io->iocb->ki_complete(io->iocb, res);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d15e869db4be23a93605098588eda9..6e8c8cf6b2c82163acbfbd15c44b849898f945c1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -377,6 +377,7 @@ union fuse_file_args {
 /** The request IO state (for asynchronous processing) */
 struct fuse_io_priv {
 	struct kref refcnt;
+	struct work_struct work;
 	int async;
 	spinlock_t lock;
 	unsigned reqs;

---
base-commit: c8724f58a948da8be255e407d4623feaf76fe7da
change-id: 20260303-async-dio-aio-cache-invalidation-9974bebd5869

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


