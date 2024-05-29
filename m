Return-Path: <linux-fsdevel+bounces-20470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA68D3E67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494181F23FD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E031C0DD0;
	Wed, 29 May 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UaT6hxpA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3851C0DC7
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007650; cv=fail; b=YogxCJIMZBE/p/IK9Xs/UM8EQNl1R4Nz9KvLBX7au98NBMQYjQ0g+6hZwZmLP503e/qrEp5h6TOmImkqpK13WIcDZI8qLDoTMrvsOTLSQWFWuOzz6hd+OIEtO/uruwI8Za+dxK3xXWR9lR+zAva94bG1bz+TkYV0EjyhER+vrTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007650; c=relaxed/simple;
	bh=RGsm+1aSws7TJ9BCCQvgJZGEWH8gdvkYr6JlgxeDFII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=TsQJzK4uq5Oh8JjdVSN8V39NIxVO9BpKDDBUgNo1vErxup0sdSHijkR1g1lc54QwnNu4H/UplaeI5p1zi7L915r/eJRln+hHU7uqfmgPDsUZ08mFqY1+eMDtpySPQmJf3t/o12anlMYFa4BG8g/bUJxvpK98uYNxgWmFfSfGSNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UaT6hxpA; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101]) by mx-outbound16-229.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buReJJL7Ewgz41aDIzhke4OryfPsSyffYkhzaEKviTz+J/MBWi2Xnb1VQT9xHCp43wlljkWizDd5C2UXpxO82MHaGOsGEY1Xg+fREMlijO+vDgzCdSoU9wYELI4kgnK0yZDwfHWAlnv/JV09sJjB9CQLmbHKKH934xYaZrKRo0fIV1SJwWHCNPrbWMpUP7wyqvfCIhdSsVElMCA83O6FvxJ9xAQMbAkn8HP68D9uEVyIpAxTu1CHb3qGrTElpsCKxGMoQJEliKBxh6rrVWIP5C+gTjtOpBJDIVCJ4gq69e+WRMrJdclypg8vFM9RCmryZUHgf8ekBb8BtN9mgOR5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOxclaByjsl02fVv3OvPg6rNpLPA6MpK7aw/CaeLL6E=;
 b=RMKNOc278Ip45GVB31EoreGWIa4aSofTgKi8zo/QjeupW/az7BTVLeG4AQUR6PL6w946VwDoSKHjVyDuhEN8I3uDQ6NKFIgZyhsH6AFwgklRuqgnv2zUGmPVI1DiLgwDxE8mgXFe/SX20DUNfAeb3txcvGx7HBhPBkyX02LmoxwwWpsEeGwAkAQpT59m8H8/bNXeVHH7JposaV2lPe/iD3hZgiumhTFIg686sK9bh8/ajVZMqOUqkXeGVw0IZ4arScghMmgThuM1eJGCxj6KCKcWq6QEq/Ct9UtPZsHjPXi78VovC5et85FT+yWDiiTcHBc2AWVV6iPyxfRMURMGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOxclaByjsl02fVv3OvPg6rNpLPA6MpK7aw/CaeLL6E=;
 b=UaT6hxpAnIjEBZaFMS83980RFKNqOd8NzTLCTUC0sseAw/AFt4kWCJkPDYkVkSTqFX0Ub7tgNmhC6bzFLb1MpezEuQelaKTCD/WFgrqAOFHbKXkOl3W2LmjmRDxUsYg2pZw4dKqjlA2DGIOWAP2JRnip2DpVXWK8yWKlh7HjKow=
Received: from BN9PR03CA0675.namprd03.prod.outlook.com (2603:10b6:408:10e::20)
 by PH7PR19MB7995.namprd19.prod.outlook.com (2603:10b6:510:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Wed, 29 May
 2024 18:00:59 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::bc) by BN9PR03CA0675.outlook.office365.com
 (2603:10b6:408:10e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:58 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 0C51827;
	Wed, 29 May 2024 18:00:57 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:44 +0200
Subject: [PATCH RFC v2 09/19] fuse: {uring} Add a dev_release exception for
 fuse-over-io-uring
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-9-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=2894;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=RGsm+1aSws7TJ9BCCQvgJZGEWH8gdvkYr6JlgxeDFII=;
 b=e2EBd7Y6d3n0uUJDJni6S1QNWHsP6mwpeWGzOdyM2t484MYTXEh3u5mcpLEjismVmt6a76siD
 1TPiCU2dtdUD1neP4Hgj4z/8QNVzb9BACg+86vGZdZXrc6ZGFuRe8CN
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR19MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeed16e-2cba-409c-124b-08dc80094b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnpocjNYVjluV21TSldEa0NqdDN4d1B5U1VrTkIvQ2xlKzB4NERKRDFmSklP?=
 =?utf-8?B?VFBWb2lua2dNUVExTkl2Z0tsYzMxa1orbGJtVlNoMTRJODZ6UUV1dXk1NmF2?=
 =?utf-8?B?TGw4dmhmRERDR2VSUXRVaVJ3b1hJREZoVEZzbmhOV0dFYlRNNGk4N1U0TWo4?=
 =?utf-8?B?SWNFWU8vZnl5YlkyYUREZEgrU2I0SzA4Vml5eVZyS0MzbzdtUVdreTVXVU9O?=
 =?utf-8?B?WUlyZkt5aUtlc0FaL0ZWVDdaWWVjMGRSSmFrb080cE8wOXlkUS82Q0lLcjg4?=
 =?utf-8?B?aElodnZFR3AyTXFVdGplcTJWSm1McjE4dERpUXJUR0tmaDJjMnhlc1d3cUx6?=
 =?utf-8?B?eWV3cXdBbU1MU3FmV3FFdmtYd2h6V3k0N2NiWW5TZVpWcmRMb3VJby9FeFJY?=
 =?utf-8?B?K1N2VDFhWEtCQWR2dTM1bXo2S3hyU2xsaFdmMXFTT1R3Q3RCeGo3Y2ZTTHQr?=
 =?utf-8?B?WVBZTjJMTmZBcTA3Q0hTZk5qQm52T0VNbWhKUTdmeld4eTRWaWM1QUZDQStI?=
 =?utf-8?B?SHk4QjFqdUNkYjI5ak82UmhtaDdtMDR5UHBOa2ZmNHBNa3JWQ3A5a2kyU0ZK?=
 =?utf-8?B?OFcyek9yTURxVzB3M2ZFYVZBTWlVNFp0VTRWRkg0dDJPbWlaNHB2SVNCQ2V2?=
 =?utf-8?B?UitwcENqSjdCR2NEWWVmNlQxUGpkdjV2ejlNdndXa1Q0ZG9HUm54WW9CV1RS?=
 =?utf-8?B?dEgxQWNZTU9ua01Pbjl2V1FLTUxVTllVMGpUcnFEaERKKy9ZcnhqWkhBUlND?=
 =?utf-8?B?Vkowb1NUdDVjejBUUmZEQUZubkVIZXh1RmR4blpwYXVXQlBYU0lHWDJvM0dS?=
 =?utf-8?B?ZG52aUhkTGhvYm9mNWFqVVFvZ3c0a3VKdk00cWZPak5INzRrUTVpY09VemdM?=
 =?utf-8?B?YS9UblpOc1lRTVlUM3o4Z0xNdmVtNzhqK3NSSG93N2ZadFdXSHVDTTBXazdm?=
 =?utf-8?B?R2VSazZVaGZpdlZYL1hIZWU5S0U0T1ZhcHJtMHRPZ2k0c0Q4Nk4zRnAzd1Ni?=
 =?utf-8?B?OUVob01IRklhZUI2dmFpaGk1YkZpaENJSmorYmdzdnVFR3Z3aUxZMFFxRnNC?=
 =?utf-8?B?dlNxTXpNUTc3VTczenlCQVZUNFFFNUw3RlgycWo3UVZ4d2psYTlWMVF1c0FS?=
 =?utf-8?B?L3pnQm9TTnViMmExNnR5eFFHTXRxMStSK1FhY2xrU1NNNTlTZEZZbURpeVo2?=
 =?utf-8?B?QjFxejI2aHg4NEJndUVBZFFwaUxKYm1jNWJhRkRwVEhtTStTUmxCdjZBaWVT?=
 =?utf-8?B?ZGljYjdUeHhtRStKUHowUzFOZlhuSGtuUER6cjlYY3RXOU1reFg1cXdBckc5?=
 =?utf-8?B?SEtwSnNTbXFsQWhwWlZZV09XZGY1K2h2RzI4akhkTXowUUlOWThrUlVIUjZs?=
 =?utf-8?B?YWthWlcvRGdXemxpM2x2SkdPOFhuU01jWXZKeUNrRUpTQ3BuS0N3bmp6eERq?=
 =?utf-8?B?SXF6OFBDaGlVNDhRRFI3emtWMlEvZ2h6NFF6RVUzWHJDa2ZVVEhLZjZ3aXFZ?=
 =?utf-8?B?RG5OTmNTTWtJQlE1STBsZkZYL2xCdWFreTNZNnFtRUhkMEJZUUllS3FieWhW?=
 =?utf-8?B?azVSU3I2dmVMOXB0cEtheUpEZm1JTHdINzJJM0U3ZVNpcnc4ZlNPS1pCR0VZ?=
 =?utf-8?B?K0Z4c2ZxTnBSTDRxTHYwTCtUSWVlUnorbnNPNEFMOWR5OXhOMDNETFMrd3d6?=
 =?utf-8?B?c3g2WVVZS1hPRWVpLzRSYTRMczRzaTR3eS9RYytMVGwrK3UwcVNDZkZLZ3o1?=
 =?utf-8?B?Zkk4TlR0bGIvc29vYlZzTWpQRkxuTjdwYmNNY05SSWZ1YklhQ0g3bml1bDIv?=
 =?utf-8?B?Vm8rNmRSQmd3Rm5TWEk1VVQwUmE1c1dOL1NBOHBMU0hvNzJJTGxQSUNmVlV6?=
 =?utf-8?Q?mH5NUsCeoRSyY?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8I28263zNowyKWsa3hSHD3RfD0KcWgi5+ZevsLMlFOfaPr/FQKeQsuwJ5gVxXBoGoO3MgDhXD++X/A09+Dw8FBVP1yq/WquE/Mc+BpwLJVEFddp7wNxiV767s6+sGLZG+vJ1I3tIB2Ex+OW1bZbYmijmfokIXrv/OxamFHkjx7pbZ6uvSg/6PuFMvQ4jzHtC7WUVMk9OG1NXcByKzsO4IkMmNdE9E1hTTFqwXedIPu/JQdPIssV37nFh/LGi7DsC4Y2//2MzkAx6nUd3+asK+hRsQUVDr0gtGO21GhCbxU1aSPQnzaQvNddW3K39KMcljt6cT+xyiDgh02bCpen8jzZ7m7jMHMX2UMF5d5mpcVpWeWdLEOJ46bniFf/VhBow8lL7ptfUmLKSWcHX2gRFPsC0fd3GM5FPf/ywx6rEeX6ZWk2rekq5pLjpoYQrP4ITPx+GORbj3Z2Qe0EgbGgylmef15ZisL0qBYHsThukjwytzUutKGFJL15jCZXgvXdCIcZQhNI0dg3zszrdm4Ks5jeBfoUtbC67tbuhHrO4/I0RxHCOhyTq03HlnL+qd5uA+ODffgIC2044gluD85OJ0M8pgKvpf5DWdlhpm2l3UUuibUJLwDbscqZrlxtnLJmYG2Z45HzhWMTzpuzOI8IvGQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:58.9785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeed16e-2cba-409c-124b-08dc80094b9c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7995
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007647-104325-12753-9546-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.58.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmluZAVgZQMCnN1MAoLS3ZxC
	jF1CDJ2MAkLckw1SjZ0DjFOMky0cxSqTYWAGp4eEtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan16-161.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse-over-io-uring needs an implicit device clone, which is done per
queue to avoid hanging "umount" when daemon side is already terminated.
Reason is that fuse_dev_release() is not called when there are queued
(waiting) io_uring commands.
Solution is the implicit device clone and an exception in fuse_dev_release
for uring devices to abort the connection when only uring device
are left.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c         | 32 ++++++++++++++++++++++++++++++--
 fs/fuse/dev_uring_i.h | 13 +++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 78c05516da7f..cd5dc6ae9272 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2257,6 +2257,8 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		struct fuse_pqueue *fpq = &fud->pq;
 		LIST_HEAD(to_end);
 		unsigned int i;
+		int dev_cnt;
+		bool abort_conn = false;
 
 		spin_lock(&fpq->lock);
 		WARN_ON(!list_empty(&fpq->io));
@@ -2266,8 +2268,34 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 
 		fuse_dev_end_requests(&to_end);
 
-		/* Are we the last open device? */
-		if (atomic_dec_and_test(&fc->dev_count)) {
+		/* Are we the last open device?  */
+		dev_cnt = atomic_dec_return(&fc->dev_count);
+		if (dev_cnt == 0)
+			abort_conn = true;
+
+		/*
+		 * Or is this with io_uring and only ring devices left?
+		 * These devices will not receive a ->release() as long as
+		 * there are io_uring_cmd's waiting and not completed
+		 * with io_uring_cmd_done yet
+		 */
+		if (fuse_uring_configured(fc)) {
+			struct fuse_dev *list_dev;
+			bool all_uring = true;
+
+			spin_lock(&fc->lock);
+			list_for_each_entry(list_dev, &fc->devices, entry) {
+				if (list_dev == fud)
+					continue;
+				if (!list_dev->uring_dev)
+					all_uring = false;
+			}
+			spin_unlock(&fc->lock);
+			if (all_uring)
+				abort_conn = true;
+		}
+
+		if (abort_conn) {
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 7a2f540d3ea5..114e9c008013 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -261,6 +261,14 @@ fuse_uring_get_queue(struct fuse_ring *ring, int qid)
 	return (struct fuse_ring_queue *)(ptr + qid * ring->queue_size);
 }
 
+static inline bool fuse_uring_configured(struct fuse_conn *fc)
+{
+	if (READ_ONCE(fc->ring) != NULL && fc->ring->configured)
+		return true;
+
+	return false;
+}
+
 #else /* CONFIG_FUSE_IO_URING */
 
 struct fuse_ring;
@@ -274,6 +282,11 @@ static inline void fuse_uring_conn_destruct(struct fuse_conn *fc)
 {
 }
 
+static inline bool fuse_uring_configured(struct fuse_conn *fc)
+{
+	return false;
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */

-- 
2.40.1


