Return-Path: <linux-fsdevel+bounces-39974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9989DA1A835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7155B1628F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162F15A85A;
	Thu, 23 Jan 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="KUuihVGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79381448E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651349; cv=fail; b=RgfpgG51jLwbRq7TpIsAJv1T8sM7zcRHRiMeejCNAEPrY9RrDOenEuylyIk/yB6acwrXn7wgL/pV00XLeuYGaEJugQhYjG1edmtSa34pw3AZzc27ZrJPePoOH5qldU1MItTTV/mPKdZCvCJKCsui6jTWCq2d401xhQ1toNYTSyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651349; c=relaxed/simple;
	bh=CyEfeuGwJsZlz2eqZ0z2f6wzEwTnWbakOOU5jQCa234=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPliiaveghWznNJioolDUh/CvOX+tLgfigSwfR4f68K1jTdqRQ3qvvkSQaWb2J5sCyCMSYYTtOwIIHQY0QzCbfks+r65VA6VMo3je8VG7l+ybziSYIiLJ8vnDeeTeRnU826xAM2C9u+SfNR3IvkeG/EfNyE32VZKPk6WnszWAwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=KUuihVGt; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170]) by mx-outbound20-148.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 16:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdEWA9jOkyGmec9XX/+bB/IaPeypXi9yxtjGX0PitKyJg4GcPzjK/AFkJ8JbBwVUdoiwbkr+F+ygqZJSvhl924ApAB37DxTzi9Rl0CT0fRPKdvj4kYodbx+H13zkSshepkcthmUtmAXnDY8zICksWOckCR1FGjld/noIiog7SCiKrft2YkKZe23ri81v/Ou1h3pirqkh5UFvbP9puB4rM1KcLEcBT3ctzOLHIBb4VxoN0AIRgDD378jIuyknIPDCvUo0HqvY8l9bAeCGkqchlO5sIlCGOAkkob/nbNurF/HMPdgEtvJPLIC8xM1tyZbUIVNsyoZAs3NBG0Jke5urOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJV9VjYyODZaL3TkWBaQSin3lqiNlrk43wF8TuEO6Rk=;
 b=f7oi+eLslynJS9GtfpqTu3SV+4OyM+iyKRAX6p46mXXCuPOftowVFN7l6v5theK9BmqoHDPoqgIiSqJCvIu8PbcLwQPp9L0C8kSljjk/UAOgVFbcws2ULuz+MmgCrbrEOSGL1Lavsewj1aCQU1dg/g1QEoCkloEt28oo2oq66D2jjmhmqorREEz3iZfGyOhJN4PK/g4S5t3oQycUUt41G3nH1w1hYcnmgIvN3O65vIDkYX2gunItp9O+Ft246D71EG8a+WfXJ1nhOYr3LTt/LpYsv5NBMtrZEBDUIcmwHVaU2tm0k5efC6UUKDcOqdWNmeYH1bOEfhMs81g7AqmrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJV9VjYyODZaL3TkWBaQSin3lqiNlrk43wF8TuEO6Rk=;
 b=KUuihVGtUo5FFwQUYVNgDVBddP4JU/EIpiTD9S+fQNg1egPgN+Z+kBJ76xyDKD/DRRuliAirUP5WB2u0jWSRIbwBNK/ZkDh5df6k7Upqp182M8d5MvcgOLEGCfJY9QeMNtJLYWFmq29CBx5nGmVSBMdrHL4RTNxlH7txneYhKsk=
Received: from BYAPR08CA0043.namprd08.prod.outlook.com (2603:10b6:a03:117::20)
 by BL1PR19MB5841.namprd19.prod.outlook.com (2603:10b6:208:395::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 16:55:34 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::69) by BYAPR08CA0043.outlook.office365.com
 (2603:10b6:a03:117::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Thu,
 23 Jan 2025 16:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 16:55:33 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 7220834;
	Thu, 23 Jan 2025 16:55:32 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Jan 2025 17:55:30 +0100
Subject: [PATCH 1/5] fuse: Fix copy_from_user error return code in
 fuse_uring_commit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-1-8aee9f27c066@ddn.com>
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
In-Reply-To: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737651330; l=884;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=CyEfeuGwJsZlz2eqZ0z2f6wzEwTnWbakOOU5jQCa234=;
 b=llN8WIq5kyQROuwgdFeVLPqXGJKky+mqkcgsHE40NqEowMVFKFH7mPf2GVuEGVAaHNIM75fBr
 BhbtiDYNT6mANSup80J6VFSbwDhR9RGaYtU6MeuzMXmskNEMKVzCvjU
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|BL1PR19MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b24491-023a-4b24-04de-08dd3bcec05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTA5NGw0RzNkTTMyVzdZbWRWbExraVJLMjloOFNORkZwbG1sdHRGUUFYUklo?=
 =?utf-8?B?WWJ0R0ZURUd5ZTg2N1BLeU5CTzZOZDJHeDdWSHNrRWZzSDdWdTYvZWxlR2ZQ?=
 =?utf-8?B?MGxnVXk2ajB0dUlkMTdnVWM1dzA0VThHZVRmVkQyNzQ5UEFWSCtWTlM1TGg5?=
 =?utf-8?B?andiRDB6aGlpUUJVZlhvc01aL0FrMnFJY3duSzZKYWxXN1BMVThEb2g2ci93?=
 =?utf-8?B?WkYvRlJtbWtsSXYyck10MUY0QnFIaTBId2M4czF3MjdQR2o3MUJ3aFJQNHNj?=
 =?utf-8?B?enl3NTlrU0J2QytnR0l1OWQxUXVZRUNFYXdqSTFaSWkzTFQzYU0rSHZLVU9J?=
 =?utf-8?B?MFFKYzJyM0Y2ZUw2QnpvdEhvVFhVdW9CN2xTdVErSVBaVkVZRVU1dU1DQXVU?=
 =?utf-8?B?a0l6a2NRcHJrWmo1S2sxSk9EeW5WTEtTRDByaUg2QlVmUXpZVXVhWFlyYXg1?=
 =?utf-8?B?azNXRXFrcU1BTExKME82RGRGWmxIbkY5bXYxcnowNEhaUVhDczJXbEQrRUh0?=
 =?utf-8?B?dTY1ME1pQ2pCNTNOankwMVFzcnJnRGpsd3dLeFhIeno5Z0p4WTFnV1RIMXFn?=
 =?utf-8?B?VjJUeUFCYUlEYlBTZ0Q4NFpRWCtrSk43djVGUVhKbFBzNTZocG81cU5uRVRY?=
 =?utf-8?B?K0xOVXdNNDdKSjFiNHY2TWUwN1V0UDh6U2JQYndidlp5S3p1T1UxdlNXUXFt?=
 =?utf-8?B?WE1uOEZHYnZPelBFNFlVaTVDSlJtbmtZQmREVHJIMFNnZXB2VktSYXVrcEpL?=
 =?utf-8?B?b2orbzAvbVUzT1pONVVmRStsTHVMOGovWURadmtDVGVaN3B2MjV1d1BOOXg4?=
 =?utf-8?B?WCtUblBuUHAyM2ZLQjhQUHg3bG5CdnhjK2VHU1hHQ1VoUXlLU0g5ZXVmWjlD?=
 =?utf-8?B?MjdUOU54TFQ4aFljWnp4OUFObEtMZXFrSGZDRDdEMGNlY2hXSmpoaXVsdjVa?=
 =?utf-8?B?aWJRMVdXRm8zb1pNczBJRWVIR3hadlZ6ZUQwVjAxaWJsem9BZHppb1h6RUg4?=
 =?utf-8?B?VVorNnVNTUdvNThDNVlNVUk0MWV0alpMS2o3UHN5TmszeEpSaG5rZEJFZEFp?=
 =?utf-8?B?NHRwVlYxRHoya2hTbEdrUWxTbFpvNVdocUYxYVpoU2xkS2ZySGpaQ01IaGs0?=
 =?utf-8?B?Y0ZBQWlRN29wclpDNW45KzBYeEtUSGgxcC8rS3pTdnduaVZTbmt0K2xldm15?=
 =?utf-8?B?NnlQdzRadVB1cDJmcklOekt1OUxVL0lVT1dtcmc2WjlpVG1qNVBDQnRubzRX?=
 =?utf-8?B?S29laHZBVW9vMzU3Z1VxdFJvRGYwQ1l2Q3ZiQTJvdzFiZllJS3ViZytmTW9x?=
 =?utf-8?B?TzFTL2VtbDFBMFE5SWFNa3hLOFdRSi9DTGZnbjZiTklueUtLeFA5Zml1ZGZY?=
 =?utf-8?B?eUlKTHFWYm1HaklVWU9UR1hxOHFoOTE0aE9qb3pCQTB4ZHhsNkJMQ2FWKzU1?=
 =?utf-8?B?RVBkbTlCMmQ2RTBRL2NrWFdUK25vUWpFbUdzT1JNVzBkUlIzdXU1Q1M0ZGdU?=
 =?utf-8?B?bjRIVnIwbTcrZXhEdWdwSVBIRDVUK05wUFROZUpJUWMxVVVRQWE4cC9HR3J6?=
 =?utf-8?B?ZkFYT3pVdFordVUrWURFY2JCWFdXa3R3eDhaSEFhbnJiMHRIWExRQjBIcnR2?=
 =?utf-8?B?N2x6NlVKMjV6T01oSzlXN3lleUFyMUprZXRHUjE4VFFIVDNUQ3dkZ2FTQ2Mz?=
 =?utf-8?B?UzRnRkNGVXF5cUNYRVQyQjhScFgzMnYvNUpEV2tXSnFuRVZkeFFyNWM3TVZu?=
 =?utf-8?B?UjZTeUVJTzdCTkIzSzJUdHFHcDJ5aExRQjF3MnZDdGJrNVVHWjFUTGh6OEVT?=
 =?utf-8?B?NHhwZUx0YUFHZlBhenZxbm1XVXRSLzQwRkZsejBXZ3pvV204aUVLek1LN1VS?=
 =?utf-8?B?R2xJWGhrZEYwVHBDRTErcng0R1BQRzFlaUo2aWtUQ3RIbTE5bWdlYWl3Nldt?=
 =?utf-8?B?cDRFNzZLbFk5ZjVDdkVnUWhtOE9Sbjh2UTE0Sk93TGtGV0NJSTN5ZlBEb3ox?=
 =?utf-8?Q?nCeP8Gh6Mj6FenSNAyWALqtCs+v0IE=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	25sobOJNFndh3jl87KmtLKWj8jirGOLQZmJTiyrukdOxwgXzo8ljbphCcujGrZMUzkGLThWARaUEGdCawOU9ZBTa25/2OzEo+qD79mxlLkigRJNqS2yaRPgGj4vC/mOfXXwaajRGHkPJvPR+2dMl/39y6I0zxb+dWXuo1mbQjHSzPCStNNslRNgoLM6JE2QevVQ2XzQOY+0MKblFQnXb56rT1exR/Ec66cKnwKKmb74Rd5ucQokX9kjSWEQTOD/BgrMIW/+/qPbbdUIUGrliCxUSX7i7dGAr12aoiBgufNJn2lD8ixShHSnhR47DBH2Ju1kWFxfEY3rBXjMolsyXdME3x7JvglNNfDqoZMpUOZOb7eDui6mAsAouLTnwkmSfcE0RTX9Tl4CvnOSMYe7DqdA53CLzFkGw/LctKPluGX1LQPWxsHlFjBgPZL2LiWLzTV7KpGWtQo9O8yrTERYSiR8yv04vzkpuRmB0TSyguxoF3ePYXSQFOtvCyQX/C9sTg9U9v6aOT+dI0IJN6FjJXtblM1RH1kU0BpMJxtHQB6a5y0xFFZhiRPK0rI2D8gyf//63LADVaRZw8gCfM00JBQGJZDYNh4CpfMS5VTmrCBB/znR9cQ49sAOcMFFDqJoLgJiyjpNsixgM/TiTuuKXpg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:55:33.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b24491-023a-4b24-04de-08dd3bcec05d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5841
X-BESS-ID: 1737651337-105268-13552-298-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.57.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhamFkBGBlAsxdjM0tDEwNzSMj
	HR1DLV0sLSONnYPDkl0cjA3Cg5zVipNhYAF1WyJ0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262004 [from 
	cloudscan17-44.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Return code was accidentally set to the result, which
can be a positive value with the number of bytes that
could not be copied. Set to -EFAULT.

Fixes: fuse: Add io-uring sqe commit and fetch support
Spotted in review by: Luis Henriques <luis@igalia.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5f10f3880d5a4869d8a040567025c60e75d962c6..8e15acb3d350d223c64423233f3613b6eee075da 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -779,7 +779,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent,
 	err = copy_from_user(&req->out.h, &ent->headers->in_out,
 			     sizeof(req->out.h));
 	if (err) {
-		req->out.h.error = err;
+		req->out.h.error = -EFAULT;
 		goto out;
 	}
 

-- 
2.43.0


