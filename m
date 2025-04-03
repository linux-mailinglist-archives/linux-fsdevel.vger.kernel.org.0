Return-Path: <linux-fsdevel+bounces-45700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5FA7B01C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671FD7A192D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5C1F1312;
	Thu,  3 Apr 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="hKWQwvMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0D1F03EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711788; cv=fail; b=LLbF+w867OaDn3jm0Pic1qlh6bQVpHLZGlio6R8cj/d75SFB31ipU03XtOZd/mD2of1FRDvQ4Ob/86AouWu60ERiL6wxDTUEGYJ4ie/GHdIPGleV5IfvD8TMmi6cAJHFagMX7eoA1jIVc/jqp26NXHT99+dK/p9EPbsyRLnylM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711788; c=relaxed/simple;
	bh=+H5d4+HjaXggM1OVhJ66708re3e0BUKtpHGh11I8B3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAU+1v8Q7iefrVmkw15HCBl2Y5nlJ7wzVw+67FKTH1m9pb3OLXWtz9SGv4TlWnowIzoixPXmcM/u4ycvnHQCUn1FvrNB3xwVrxbkcKLtfjAF96G22VgzZcgYeXzyu0coGWLDNRp97tmSEnirQIH9KTHNCkMETI4UuCyFeiSKlqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=hKWQwvMY; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176]) by mx-outbound22-67.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 20:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHO3B+2KjACLpBANiLo3rda9+N2WRookNK92CE55jZ8X/xfs/PvstK1l8GSu5F+WzL8zWtw5E0/cNEfEXnQeQdY3jVE8bzEctrj0tfDOolm4vpncRO8tSLgj2sXadpmqeum+ttbMsTYPLnBK9rxHTUbfxRj+28HBGhln6DYACSew1B7+VSDOTQfXyY5z4wEP9CEUADj81xvFv6TH7UZk2fsM4B+qQolmvJYcD6zqNhsFP8NDgNElSUfSMPecRC8wIcSBWfXSo/G2VYNFwZjhXAbMBQ4bwV3PCjdwaMQa7uHkYgDClY1xR3H1cKHPoIq9hXgmaq2tQWLmQoYZhKfqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnWArgEZ/mERbronoBEh1oTWNMpbuidXjFCxeQHpW+U=;
 b=isLvRbT+dFgf79RNj6Dawp2lUqwMiiwxerSF01qzZR8modJ4xTT9qi01DaCGfujQDNMkw2k5l/86h3lHe6ydz9G8pUV0iEi/n/FyWfbNUG8yktTaZNTQ+EEkcPJxlytX8Wg11609ZOrwGuHK7OWnu+zY6yvrg3uNSc4Sq+eGb5PxohunIUkvXycXiWoL/8ie49zVVzjbrFikmE6b7G68ayjMkN2szQJYkrkRP7gtWW+sfUDUDPj8o21M53bsg/3+Wz9tFbqWx2XS+ICXq+eM0pBQOLvjPSrnKkiBceYGbYIreUmqc8AU0Qo1kqOQ3bpksQFbPZ43CQpAM6sOWrZPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnWArgEZ/mERbronoBEh1oTWNMpbuidXjFCxeQHpW+U=;
 b=hKWQwvMY1kj5zm4HM0kJ7/yG4FnlJk+/gGxzEUKpCacLdeuEofxgZYW3fgnT0QvwvNogtX3DJMBqs+G+o5KpTY63E5pn7DsOdmbHSox+buF+QsPaanW69ks7+5gvRDUOWKLSZZTlbOvPI3tmc/LCsOvuDCBXii2RYEEA3PZv0hU=
Received: from MN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:530::16)
 by CY5PR19MB6243.namprd19.prod.outlook.com (2603:10b6:930:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 20:22:51 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::53) by MN0PR02CA0015.outlook.office365.com
 (2603:10b6:208:530::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 20:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 20:22:50 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 7194F4D;
	Thu,  3 Apr 2025 20:22:49 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 22:22:45 +0200
Subject: [PATCH v3 1/4] fuse: Make the fuse unique value a per-cpu counter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v3-1-35340aa31d9c@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711768; l=5386;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=+H5d4+HjaXggM1OVhJ66708re3e0BUKtpHGh11I8B3E=;
 b=F7l4k4+s3In7gEId7C/PGWGtFRnXiCjfmqPVzwVEndukhqoHOZOngQ381YRZXrQsDmLGVsTqg
 nNCQlMi8s/3B6RnT1p+LY2DT0zMZUW403/7mqI9lTe33uBDVC+h3a54
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CY5PR19MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: b449b176-d214-47d6-0f7f-08dd72ed4e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkYzOFl2QXRGTHpoZXh1cElLcDl2dy92Qm1OV21PVnE3Zy9tZkhiazZzM3Fr?=
 =?utf-8?B?WmZGUnJMZjJPZGtxRUVtQWVRTXVpeUtjcm1ON2h4ZmVYT0ZIcGJVaWt2c3lM?=
 =?utf-8?B?cjJuWmdsNUQzSTl6eENXMzZ5NjBSY1h6cVAwL0lXOFY4L1M3M0c4dEZWQ2lz?=
 =?utf-8?B?eGdSOEpGQTVEamw2cW9CZUlVZGg5ZHRGeVd3ZXNXR1lnMUROaUVyNTN2VXNm?=
 =?utf-8?B?SkhnYnZxUVpSc1g4OFlTVitjL09zdXllQ2tmaTU4N0pIRGJVR0FHT0xubkFn?=
 =?utf-8?B?U1ViY1N1aW1GdG81aEMxK0M4ekhKRkxWcTFqcHRUVUNTRFk0c1lDSVMyeEVn?=
 =?utf-8?B?UWROa2lMQ0h4SHFrSiszK3lScUlHS2Vyb0FyTGNKdzk0R2YySVlHcnVSS0g3?=
 =?utf-8?B?K25rdXJKQUxUamxjdzRTaVF3Q2xrYmgxRUtXOUVuY0JGZ3Q2ajBTQkpjWEp4?=
 =?utf-8?B?SVc3SXpkbFg0WHhWZzJ6Yk9DUjMyU0Q1eGxkbm44TlBJTW1Yc3Z2K2ZDZ2Zs?=
 =?utf-8?B?eUJXajhaSzA1US8rVkFrU3RJa2gxUmZLNThBa1czaWJEdWgvVU9qK3p0RmxL?=
 =?utf-8?B?TW1MZDZ5QmhuNUM3SkQyUnRMbmFqcFl2SkJqMlJhaWkvYS9taHhENFNlSE5O?=
 =?utf-8?B?ckl3em9VellTL2ZZU0kwT2JOcmNVSkxFODBiWkNIT2EzOVNCVTJ1MFlZeGxn?=
 =?utf-8?B?T2ovREJQcEtTLzRDYkJ1UEhvdGhoWHltcnN5TTg3bittN0lldk56eEFHMXlS?=
 =?utf-8?B?WjBKKytwUk43Znk0ajM3SmE5ZWJKU25CVkswb1F0WDB0VGtwSm9jMXZld2VR?=
 =?utf-8?B?RDhEdGVDRVhxOG85dFljd1NsTmV5cFRHT3NsSmxzR01zdVJnelU0MzhuaVRh?=
 =?utf-8?B?Tmw5NElTek9JUy9xcjRIV2twZ2c3MUQvYXVXYnBSYndYMWw5QWxnYlhxMmVH?=
 =?utf-8?B?aTdKR21xZDcyYUJtK00vWDV6ZVNEbWpxQ281V3dSd25sTFhpeStQYVAydDc5?=
 =?utf-8?B?RGQyNU90VHErWG80Q1lQUDh1eUgvVVMyeUhlWUFtTEs5THNpclNuZE52aGQw?=
 =?utf-8?B?M1BRVEgyb2NxTllzTWhHRVdYSUV4VWZBZHVSMkRpbDd5cTRGNGZyajByRlVU?=
 =?utf-8?B?VnVIMThTN1huWGtrL0ptZUZwVkdJaXRwL0FJRHZ2eW05K2VBVEpVc1E1VXZ5?=
 =?utf-8?B?cUJYS295a0g4UkQ2RWUrUWdxTmVRT3lRazZIRTVjZnFLY2pWVFNOSlJ0NVdv?=
 =?utf-8?B?Q0VTT29MY3BRQVpHaCtXZVJVaHFocnBQRUpYazR6ZGlrRFo1Qzd6M1RuMUhO?=
 =?utf-8?B?NWdKMEZjc09KK1lCS0RPemYvWlVqU051QWg2cGNuR21vbTFGTnZ1ckpUd0ln?=
 =?utf-8?B?d3FoakpSOEFZVi9FcGo0RzVHU0JraW1NVW4vMnlxU0N4a0ZrbFJudVNQalN5?=
 =?utf-8?B?QjFRVTk3a1BFQ3kweDRrZ0tRY1JiOFV5SFpFVG10WUM4YXdsdVdGdFZnRmlF?=
 =?utf-8?B?clF3em1DZGNBemF6WTNaYTUycG8xcTcvQXBINDJ5NEtmU25QUzlHS0hzMTQ5?=
 =?utf-8?B?OTJaeXhvUkdIb3crQktYM0l0Y3RWSjQwSkMxTzdQVUFwdjhidFVqdVJkcnVN?=
 =?utf-8?B?RHN4ZE5nRlJFVEpFVnZtSTZOMXdmaUJ6YStmMmg2SVBMU2VDTFQ4cTB6UWpF?=
 =?utf-8?B?emF5em0wc3k5bG1iUDRnNnl3S0c3SkQwM1FQbVp0QzkrblI4YU9MNjF6ZEhl?=
 =?utf-8?B?eXQ3RURNLzVqeGZlOGZ5QS9lY2ZpL095VkVnb1pZRHJyZS8wQlMyVkR6UktR?=
 =?utf-8?B?amVhVmtmN2x1YVhHVTlXSGtLUmhkZTVWL25aOUNTVkRLaDBxR3ZWd2E0VHFt?=
 =?utf-8?B?emk5bVpVTkNsSEg0NDhOSHFNWGprTHprMnlMK3p5bVRIMktUcnUxVmtLb3NH?=
 =?utf-8?B?cGdNeHlSL052eStXVzZRdmczMURYajJVY3gyVUxZMHljalF0eHd5Rmh6QXlk?=
 =?utf-8?Q?VOR6wGFzpGgebOyZn3CJhEW5taR3AI=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bfyIMm+2Q+UGBKnU6RvUr4Hf0OWo2FiSlRm1ip7WnUvJcdVCHsa4Mifr/8tqYhOumWa7mzfePDaQqEv0Zy0SW7s+QuxXaF1s7D0b1xmEFMxGact2zpmfB8Jh51vEzuRGvyQyHgsNYJ17/UbkCmTlijatPPoNhWnaNh+3eDpy+JLK5KlLr0ChHGPJcIZJbO+cLGpRECQ6etvt5WPeFLPQYwv6b9KUXfPIUzwhB8qV15xWxsX9hvCTuIyapzkgWOvLPCUEPBDzRyIT5Lz5sGXL4tzpQt8MLHuSWI1aE7aI+ZSJLkuEeH1hVfzbluYMhXCMtiVWqe912wFaN9eRkUeYRW99IhR1yoxDgQCsTVKsRT+tyvrUJ1bN6+SqKYmb/MQzXC11hfbJn/WzjMvJ4zdlE6QRt6UC44nukzB9ZdY7oQ/AeOj6xJgAA5xjtKBtL0N7pztEA+c/zvOUWf3fo3mhnaowYyJFjkZvrr8UBVyk0Zu8rm4m5951pwn6lzbaxqi45qC/9UdqTVF3pKk6tTp2K/sUwd87Yv3r9Ry+n7OmqcWUMimuAHFpmZ+4ICWv5y9fY9Xj2yqEzNr2AV5pzyQTV3eaVqSR4+85FMaArSwt+a/S5Ypal8qGVZyJiUTOWzchDnh96mPXeVyyia2bB3U8eA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 20:22:50.3678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b449b176-d214-47d6-0f7f-08dd72ed4e7e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6243
X-BESS-ID: 1743711775-105699-9992-81-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.73.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZGhiZAVgZQ0CQtKdkyOTXN3N
	LM0szQyCAlOdk0LTHNwtQ40TTJwMRIqTYWAHA+3YVBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263629 [from 
	cloudscan22-245.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

No need to take lock, we can have that per cpu and
add in the current cpu as offset.

fuse-io-uring and virtiofs especially benefit from it
as they don't need the fiq lock at all.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 24 +++---------------------
 fs/fuse/fuse_dev_i.h |  4 ----
 fs/fuse/fuse_i.h     | 21 ++++++++++++++++-----
 fs/fuse/inode.c      |  7 +++++++
 4 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51e31df4c54613280a9c295f530b18e1d461a974..e9592ab092b948bacb5034018bd1f32c917d5c9f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -204,24 +204,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
-{
-	fiq->reqctr += FUSE_REQ_ID_STEP;
-	return fiq->reqctr;
-}
-
-u64 fuse_get_unique(struct fuse_iqueue *fiq)
-{
-	u64 ret;
-
-	spin_lock(&fiq->lock);
-	ret = fuse_get_unique_locked(fiq);
-	spin_unlock(&fiq->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(fuse_get_unique);
-
 unsigned int fuse_req_hash(u64 unique)
 {
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
@@ -278,7 +260,7 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
 		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-			req->in.h.unique = fuse_get_unique_locked(fiq);
+			req->in.h.unique = fuse_get_unique(fiq);
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
@@ -1177,7 +1159,7 @@ __releases(fiq->lock)
 	struct fuse_in_header ih = {
 		.opcode = FUSE_FORGET,
 		.nodeid = forget->forget_one.nodeid,
-		.unique = fuse_get_unique_locked(fiq),
+		.unique = fuse_get_unique(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
@@ -1208,7 +1190,7 @@ __releases(fiq->lock)
 	struct fuse_batch_forget_in arg = { .count = 0 };
 	struct fuse_in_header ih = {
 		.opcode = FUSE_BATCH_FORGET,
-		.unique = fuse_get_unique_locked(fiq),
+		.unique = fuse_get_unique(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..e0afd837a8024450bab77312c7eebdcc7a39bd36 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -8,10 +8,6 @@
 
 #include <linux/types.h>
 
-/* Ordinary requests have even IDs, while interrupts IDs are odd */
-#define FUSE_INT_REQ_BIT (1ULL << 0)
-#define FUSE_REQ_ID_STEP (1ULL << 1)
-
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b30cd57b8a6bbda11447a228cf446..80a526eaba38aa97f6a6faa60e5276fcd7f2668f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -44,6 +44,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 
@@ -490,7 +494,7 @@ struct fuse_iqueue {
 	wait_queue_head_t waitq;
 
 	/** The next unique request id */
-	u64 reqctr;
+	u64 __percpu *reqctr;
 
 	/** The list of pending requests */
 	struct list_head pending;
@@ -1065,6 +1069,17 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 	rcu_read_unlock();
 }
 
+/**
+ * Get the next unique ID for a request
+ */
+static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
+{
+	int step = FUSE_REQ_ID_STEP * (task_cpu(current));
+	u64 cntr = this_cpu_inc_return(*fiq->reqctr);
+
+	return cntr * FUSE_REQ_ID_STEP * NR_CPUS + step;
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
@@ -1415,10 +1430,6 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 
-/**
- * Get the next unique ID for a request
- */
-u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150878634728685af0fa15e7ade628f..d2d850cca4c7bc3cd7158e773c5e602e15afe4e3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -930,6 +930,7 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
 	memset(fiq, 0, sizeof(struct fuse_iqueue));
 	spin_lock_init(&fiq->lock);
 	init_waitqueue_head(&fiq->waitq);
+	fiq->reqctr = alloc_percpu(u64);
 	INIT_LIST_HEAD(&fiq->pending);
 	INIT_LIST_HEAD(&fiq->interrupts);
 	fiq->forget_list_tail = &fiq->forget_list_head;
@@ -938,6 +939,11 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
 	fiq->priv = priv;
 }
 
+static void fuse_iqueue_destroy(struct fuse_iqueue *fiq)
+{
+	free_percpu(fiq->reqctr);
+}
+
 void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
 	unsigned int i;
@@ -994,6 +1000,7 @@ static void delayed_release(struct rcu_head *p)
 	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
 
 	fuse_uring_destruct(fc);
+	fuse_iqueue_destroy(&fc->iq);
 
 	put_user_ns(fc->user_ns);
 	fc->release(fc);

-- 
2.43.0


