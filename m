Return-Path: <linux-fsdevel+bounces-37340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615E9F11B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A95B16519F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA61E048B;
	Fri, 13 Dec 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="fNUU4ur4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FC1DFDBE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105721; cv=fail; b=VtistoQSjedU83vzDel5qDiCHJBrcmGJOC6h8UsY9uC1COeDuUb1iq4YDNhshekQY5RLaeeoed1ysv/xS43aDldFqBk2SQTKUDEenqPX/HVTEQx5uni42qNxQ5dnZyTx7aMoHagVLVQ0EYxXj7mO2oxLAPVm0Fv6htmr4m75irY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105721; c=relaxed/simple;
	bh=Y+jl8fICPjJPTBlBvriWveQNF5Y6GNKCsIMoskeilno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtgilRu8m9Z2/ZhZY6y6yO+z60KSQNMfoQSw0Lumbm6F6E1k12gDlzIegMeHy7na5TSUIK+VdCxufM2AyLPzQleJ3n04FDyuPzU+zV5oih+/zDeIgX3ByaxldTrXxjPaptdIqqWi1zzuATt7M563QGOsGPyV3oPP92STbU5o9LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=fNUU4ur4; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44]) by mx-outbound41-19.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Dec 2024 16:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXo085mgGMsRD1IUpMXqVB7tlIgWcOb1svCg6JyCQ7KDO0pofJ2Lf3y5Y+7NZhnIotI0xxdFiufA1rII7NoCJs3B7Aob0Otzsw5n0oK4GKb+JffztlHiwQDOMAEXlYOlslBnB9kUErdQw5VRr+nUOS2+3a7ei3haWwk/PkC2AieFpVXhg6u5C8jK/zF34oDfa9b+CgQdhFqWhvsCCqk46CpusltOZ4g3lsLSvKuVzJ803+IWTeqNo+rIUPw2EazzqUOuGTKSfZ4CTg9k7orl+cZvRAYJHUCGhj8/T3RLN1/woTAyqCT/SFSod0jyttnXzsdBbzN5eCs2z0R9Xp7Qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdSps3YBtV07uS+VoI+vP2dxi49kD12z1ukJ6D+LLZM=;
 b=jaMIvL/a8THGd6Vq7M9JG+gDOTdEmPzugMd468faxVCMpr1k5uS5/TUqdPGclvk/fUDZ57rpdadY5CRK78Q384chH3h73iwJysma5DmFFtmRsOePKJae8GwdfIFYwOC5/y7h/vwrOtbihwocHBUVYkqa5aqdGptMA9PFszbZrLIT7YgnrMMhpdv1NrPOy+1tsxgQhWnd34f8SGLdedYQqrZPFZKL08VxRQQ2+wbP3aVWkqs1vvEgfNGmIzg+D0tR9USg/pmFq5ezMBBLhXyjR4I8Adl0HlvpLv41mZLXA1E4Qp1zSP71yE01pRE0xJ1YxQjePzYUMKgW1ZpHQahQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdSps3YBtV07uS+VoI+vP2dxi49kD12z1ukJ6D+LLZM=;
 b=fNUU4ur47felVpZxz1N2ylUmO5mif5Y/n2sb5YjrBPAhyics5OWj1ruyHYLIEm6pJdHBcYR0SaLM+S6u3Nn3nISDfslChNZneSnFF4U7HTKkPf8235wCqWS/xJjBh/wacHllFDWZy3gFu6RpZWaAHGSHuorqkWbRdberdsl7D3w=
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by PH0PR19MB5575.namprd19.prod.outlook.com (2603:10b6:510:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 16:01:43 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::73) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Fri,
 13 Dec 2024 16:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 13 Dec 2024 16:01:43 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 795B255;
	Fri, 13 Dec 2024 16:01:42 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 13 Dec 2024 17:01:39 +0100
Subject: [PATCH v2 1/2] fuse: Allocate only namelen buf memory in
 fuse_notify_
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-fuse_name_max-limit-6-13-v2-1-39fec5253632@ddn.com>
References: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
In-Reply-To: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734105701; l=2235;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Y+jl8fICPjJPTBlBvriWveQNF5Y6GNKCsIMoskeilno=;
 b=PaVxn/u7zmEPCgyOMAai/xQJ0tMZGJ2BJXo0fRlpqr69KDvJZBXaRcFs/4hZz6lQvwXh2uDEg
 nacXGCjv7dPB4DfvDNlKKQTh01TxKLhgNHL0RJtpqLbghSi+AWcF60D
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH0PR19MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ed9d4c-2199-4e18-8831-08dd1b8f7027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFhBQUxRTmU5RVZqZm1jTllCQkxjVjh3WFJIb3VUUXVTVFhEeDZaaGxHNzY2?=
 =?utf-8?B?R3crQnJBb3k0MklFZGxYakt0NFJBTEt6U0poYUpaMHcwclNRMVBPZW0vZENY?=
 =?utf-8?B?c2RrWGtCeHFRYjYxbDVrdnlsYzJnMGJjYnQxc3BUb3dsMW5WYTh4RGNaSjcz?=
 =?utf-8?B?NGxGY3hQek5SNkhYWVZodk1aYlYxUkROM0dOTk5Ld21Xd2U5Q0NBZkQxQUJU?=
 =?utf-8?B?Ty9IbEJ3d0tkTEthbUxERjVWd1hpWDBVMmF6QnpmZ1V1WUFPZmNtbllyaVJB?=
 =?utf-8?B?YUJwY1dJZjk0bDNyZUMxd1VLdWFjSGZaUjJwRml5SE51UXdpZHVReWZDUmlP?=
 =?utf-8?B?Qmg1aFhjZWI3NjlBdDFSdFQ0Z0dhN1M3UWN6ZGNEQ1BzOUgzM01NRWNqTlZF?=
 =?utf-8?B?ekxJUzhXT014SEZHdXg0MGM1V2w0VUVtMk5SK2VKL3BFeGtST25uQ2drSWhu?=
 =?utf-8?B?QW03WktJb20zREZ3bU9LeUlGblllRVZnK2F6WXEyb3FjdERrcmMvcyszOVpY?=
 =?utf-8?B?ZjY0VktYMHR6QnNEZXlnMDIvTzVWTUpGZE1IbC9JNWxsVGlzREJyN3JvMHgx?=
 =?utf-8?B?WDFKblAyRTRGWkZDK0VyeEVQQnhBaUR4dHIxVm84aldlaGtxM1pITU1GWExs?=
 =?utf-8?B?dllQSWE3M0toeVJkMVBBYzkycTVnalgwbVpDNlJRZUIrdUpSZU1TZ3F3NXJS?=
 =?utf-8?B?N0tvaklJT3ptSTlac2xxekVDMHJSazhBNXlCamR6bS9GL1BMMDREN2pjMHZF?=
 =?utf-8?B?Z2NuNW1QVUw2V0doVVdGbk53UzlRaFlpOGhxdi8za1orZGlFd3k5VEVnbEhp?=
 =?utf-8?B?dks5WXZGc01Xb1dZUER1MHVHZmQrRVdvMjBtZ0k5dHVUMmRoOWhrQ1BHdHNv?=
 =?utf-8?B?TEtWaUYzaHdRc29pRkcvZ2Vma0JsQkRwMXVZOTgvbk83VFFRZ1hwM1hJNEpV?=
 =?utf-8?B?THpSamVadlBEaTdFQWFhOTZQK1o4NGdHd0E1ZzU1QVd2blJyQTNGS29ZRzRO?=
 =?utf-8?B?ZmgzdGJrSUZLZ0lWaEhSTVVVSkFFNmZETit6ZFRuSnZyQWkrV2gwdEdSTWtF?=
 =?utf-8?B?SjlKaldod0NqZVpSelF2T1Fadkc4TFY3aWRENFNEbCs4bmhPRzczUHFvYVZD?=
 =?utf-8?B?WWdwcXdvREZuR2twdDNSMDNqeUlxNlMwOVNKb25TY2dqSmQvTEhJRXdNYzZm?=
 =?utf-8?B?U3ZIdzRjVEVxL2dmZnVKUlpGbVoydXlVam03U0VSTlRRTWhIWEVXS05wdDV3?=
 =?utf-8?B?L2NLbUIydjdraDJLS3BSTU9vNDg5R2R0SU5iR3NkdG91WkNqRG5JbmZQejJn?=
 =?utf-8?B?eUhhQStQZ1hpUmplMkhiS0xGT2F5NHNVZmxaMjl5NkNGZVdveWJJc29ZOUpq?=
 =?utf-8?B?NkRyTEZVYWlSUHpxTTJRMVFCVWJNK0NvbHB4WkVmYVdjbWt0VFZsYmVmQkoy?=
 =?utf-8?B?VXhrSUpLclVOdFdobHgxYjI4bGJCRHNVdFZOenVEczYvWUU5cEpWYXRGTStq?=
 =?utf-8?B?STJVUlh1a3FVQ3BYSTBaK0NhWnJud3hkRDdDZlFKc2tNUWFLZzQvUzhQb1I2?=
 =?utf-8?B?T29adFNSVUprZENWa1ZFNDloYXlnc2ZpK2dGTGpxeWUrVjRVVzZ3UllwNUdB?=
 =?utf-8?B?azROTnBvZlN5SXFvWXZlb0xhOU12WWFCUkthZUlzZWpDOS8zbG9EZFFycjhu?=
 =?utf-8?B?VzZZdTM2MFZCL282T3JhT3ZuU3UyeEtXK3I1OHVIM1BocGRWTDdGanZuVmRq?=
 =?utf-8?B?cTU5aUxrRkM5a1R3Q2RMTjhjUlZSZzA1RDZKNWYzT2IrbmRHREcrNjJ0N3lr?=
 =?utf-8?B?eW1pc3FtVXcySlNIeTR3Rk56U0pPZlUxclN6YlVZWXFkc2lEWXplQTlrRWw2?=
 =?utf-8?B?V1FrMTl1R0FxWVhoUDYvY0U1OGZTeU1NM2FDSEg2cGNvZ2xuWGFnWVY5UVBR?=
 =?utf-8?Q?Xj1XWaaLqyN/Y2vRfwG1rwwH+ipi2EAG?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d6EJiUqTyOdNbgvLQ0Ti2bAp2l+f4nqOiVYJoSAMv7l4O0jePsaOreUrFYUFBKt58a6GBvR9zutImI1C6FeWjvjt12FpxyLhOP7QWKnOtPpaCa7hZNYZd461YI9EXB5YqM0bYm87lvjm1G5J5879m+fPCSxxPuEjTwdnrKK5q4GQ/q9hqX+oXfC5HF4Oe8qj5Zg6WYSUFW+k1M4PPTDq2T8c4WREXUIJaBeWS+g8PV1N9yikYYx81Bz280Q2y63fBg6nBU3ahU/oK9vuRcHtthvKS8uAHQjYiGHl43chFBS4dXL32egAsGw0v21YPa760JzQt2Psi64+8ffgUYDd8RsjUlUL1BjD6Oq2JmuArR9TFUkKRN2YBdnfvOiofLD4wZgdNwr22BtJhP4FBlKG3KFIV4U/33flynYBvTDro6OPJMeceYNRctZhCYtFL4ZkKHcdXvbNzxkHszgwXNaTz80/O7LlaJ+zkqnNU3gh2dSW1MGj6URUZqFVbaxtDLobKZ5Ec+quzjk4k7l2l+jOPsEiv9vgEWvSABy8UI7Vds0i1aoMLag9QDkqUDb85p83GtTy8K/eNixqRGiWC5m2SUZdbBw4oDcxrZrLHJm7exrrHDSLzT1pKZt0uXPVZtXGE4WHm1DUNKNlYo/nfhUiqA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:01:43.0671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ed9d4c-2199-4e18-8831-08dd1b8f7027
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5575
X-BESS-ID: 1734105706-110515-13346-27300-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.70.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGZgZAVgZQMM3U2CQxycLSMC
	kxMcnE1CA12dggNdEoJdksJcUkKSlZqTYWAOjb6fxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261086 [from 
	cloudscan15-9.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse_notify_inval_entry and fuse_notify_delete were using fixed allocations
of FUSE_NAME_MAX to hold the file name. Often that large buffers are not
needed as file names might be smaller, so this uses the actual file name
size to do the allocation.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dev.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d14ea339aa6c8da63d0ac44fc8885..c979ce93685f8338301a094ac513c607f44ba572 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1525,14 +1525,10 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 				   struct fuse_copy_state *cs)
 {
 	struct fuse_notify_inval_entry_out outarg;
-	int err = -ENOMEM;
-	char *buf;
+	int err;
+	char *buf = NULL;
 	struct qstr name;
 
-	buf = kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
-	if (!buf)
-		goto err;
-
 	err = -EINVAL;
 	if (size < sizeof(outarg))
 		goto err;
@@ -1549,6 +1545,11 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 	if (size != sizeof(outarg) + outarg.namelen + 1)
 		goto err;
 
+	err = -ENOMEM;
+	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
+	if (!buf)
+		goto err;
+
 	name.name = buf;
 	name.len = outarg.namelen;
 	err = fuse_copy_one(cs, buf, outarg.namelen + 1);
@@ -1573,14 +1574,10 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 			      struct fuse_copy_state *cs)
 {
 	struct fuse_notify_delete_out outarg;
-	int err = -ENOMEM;
-	char *buf;
+	int err;
+	char *buf = NULL;
 	struct qstr name;
 
-	buf = kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
-	if (!buf)
-		goto err;
-
 	err = -EINVAL;
 	if (size < sizeof(outarg))
 		goto err;
@@ -1597,6 +1594,11 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 	if (size != sizeof(outarg) + outarg.namelen + 1)
 		goto err;
 
+	err = -ENOMEM;
+	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
+	if (!buf)
+		goto err;
+
 	name.name = buf;
 	name.len = outarg.namelen;
 	err = fuse_copy_one(cs, buf, outarg.namelen + 1);

-- 
2.43.0


