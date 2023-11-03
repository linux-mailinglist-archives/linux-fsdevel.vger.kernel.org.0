Return-Path: <linux-fsdevel+bounces-1897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E17DFEE7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 06:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A361528125E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 05:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C538917EA;
	Fri,  3 Nov 2023 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="dxLm70s4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0617C5
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 05:43:01 +0000 (UTC)
X-Greylist: delayed 1972 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 22:42:57 PDT
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FFF18E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 22:42:57 -0700 (PDT)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40]) by mx-outbound18-137.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Nov 2023 05:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFfLVCJofEv6tNFWB6WP+tj10783++XYkOnCUCnnrd1y8B89uZNmOBLn8XgZLzuTEyQN/ardgKLyB4654qgzYF6c5ElOSW+9RTHOTNc4YZi4UBVrSNi4PJRz/qhaXiTPsu7nV2+XwodwoQQ2Q9ovVcl/0cxxHweAFgP7ObHSrbJYfKXvUEihzGU/5J6GYae6M/cCUBMoRjZrkvE1DG5oQvqVO4UkUb9yMYyD55bXF8RSO2RRoU5N/+dUpBVYiTnnhynTwdJAacrTMg11IK+gqdPgCndfcn9r/OEkC4UW6YYmBCB0bZaEH/t62+hSE+hAxc8lApwKF73sPsqH5IvyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhyhobByy3czDRChRUdmXoPp3UaAxTOpm3dJHErmyag=;
 b=ZWwp3iA2hh/OvEFqTfMkrta8Fg8j1RypsViS0tZwU+kNki0pbf5MT2Zia++Vq8q3O6K7sUYtJ7soLNA3ryYymJq+rZcK3trmvzc0VNNNRq+dcjPafijBCtGyYjIBwWqw0o+ExwT8iGSqsjD8WBcZvX5iSv6mkSsRFnp6DDjRbbsiosRt0mZK+mcqHOovJEHphfsJuFweFs0oaUCeY8hbM8FgPsIatRjGKqUUxA2NpC+fv9cKCPLu7dm8kXue/9a1REnmq0EqqHGT+YMcJlyRPjDgAxOMXAtLAQ+OQa1eOKwgfJKnzKzCk4YNRbQ9pLraIVtkvIIMImXeXYh6GBI7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhyhobByy3czDRChRUdmXoPp3UaAxTOpm3dJHErmyag=;
 b=dxLm70s4D3f9vXwWYpEwj9y4fuLsZIKnebqzPAJb9EczrgTddNER+UHMlpD9eq14dM0qtecDg4jDG+u/c55wsrrm5Q1gXlA8SdYO9v3EpaAgNN5kxnavIKkvaDGTfIbhzBbWPbYQMhs6TlCF69Kx5K+4wkDXCLMuB4t0NVf+Tjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 DS7PR19MB5901.namprd19.prod.outlook.com (2603:10b6:8:7c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 05:09:56 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::d7a0:ac28:9211:7962]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::d7a0:ac28:9211:7962%7]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 05:09:55 +0000
From: Li Dongyang <dongyangli@ddn.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	adilger.kernel@dilger.ca
Subject: [PATCH] mm: folio_wait_stable() should check for bdev
Date: Fri,  3 Nov 2023 16:09:49 +1100
Message-ID: <20231103050949.480892-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0007.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::17) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|DS7PR19MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: fad7d9c9-8e43-4c58-03e0-08dbdc2b1df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tRew/5Q6lmUoVGLBWmUM8mJw47Q+7g9o5N+RVc7taVhXOtGdefNjHcH77YnA61qYSXLW6ek3wyVD8dCfTwkPxO4lubayXzmbwokGd70HoFaoeeVU2Dj8degUtF/YctRYE7s8HTjYsFUd7YCpGy2XbRyQ0XoW0RoFQ+WRU3WcLrxWlHJCrCWmLY17HWWZvq32I/TJQLEmdBgNDKqQEEyLweR6Ku0QMIGJPaCXH8nONGn/CdJllqawQrkccd4z+VcuSGlNoo/L1MY8ZXUnd7epweHOAevi0Y7Epr+XEGX87VIA6+talqJtgejghDSL51/nZK6Grp5UP8gX4Lhn4cIxf/V0pJXAL34d5F3/4mP51cT3S3gm2mKYvvVL9L1vUDQ9RQi2SkXxOL8FfOxbv1O/jIaEG779hBo/jGIo/UdP3gMTZMtzvpa2PZKGogfMjgJrirUVm88CiCKOqNrk8m4/OrNPq/MaElFuNclQyO6NFAUzdDz59pgmUEvr8FjEg+5HbAkK0jD+B8WX14L5XTFzA5r9mdEokBA4HhhChC6B9dTKTv86KszhjCqm3SehId3j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39850400004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(26005)(2616005)(55236004)(478600001)(6666004)(2906002)(83380400001)(5660300002)(6506007)(41300700001)(66946007)(6486002)(66556008)(66476007)(4326008)(8676002)(316002)(8936002)(1076003)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XiI2nZaRFQ6QiDs0k1pfRKGIE6StlLboBrjNNXY29eZ4O36ec2BjczXR61ab?=
 =?us-ascii?Q?Il5xJLqsHC96A9iIBCvXfLZnnSqaPF8nqFZyLwVFPzK0z9TfNyezjv055KKd?=
 =?us-ascii?Q?y3szj5eKnjW+BS9NBZ4xww+nvTPUcdRwMK3/vAj6MW4TxZI1+VYKSEyXNcxF?=
 =?us-ascii?Q?aLF8KTh2ZfdTNsMFzDx/pWQDX2znjW56Xyx4Ns0TUn8JimQ/bAdbbDS6AGoS?=
 =?us-ascii?Q?Tr/fn4r2ErYdAAyDjeESxPazmUYPdI1VLW7zCfAViPRqThomUxNhPkT4mNsv?=
 =?us-ascii?Q?Wvs1ff7grCN/dhUhPNV+5kZ+1ApRau5kLksZf2g28yqRr87xZEIJn92K+Ssf?=
 =?us-ascii?Q?xHXBny5oUMoqEQC6LY6v6T/6mBvtPHa0my3+UuzxW0hV3y+j6gRMhzDgrgUH?=
 =?us-ascii?Q?IBHswxdkW614PhimZ0Q+qgbfLMqxtQ7W99dlLAyz9ZBeQ7xQWvEKTlP+Rl1H?=
 =?us-ascii?Q?Ablvg/VK9FzGuKuNODQDG/S2kZZJUyYGcSvi7z+QX23A6cv/ZkiqF6vszFXX?=
 =?us-ascii?Q?K6o8120vXfkfmf63M59xLBKI3knazcRVfFl287NdzmdEmEvuSyGRrsiSmWvH?=
 =?us-ascii?Q?0BDeJNQptiJGi0aUCcb4cMMD/6xG8ESSSF2N3lHV5/mrmpbewVQ1k8Zhu4JD?=
 =?us-ascii?Q?1jtDXhuEGaJkWoMHRcKC8I2m/HdU8/259OzzYVd/vjOV9Yf+RidhVE+IsXn5?=
 =?us-ascii?Q?8w7i5qei/hF26uL9cQ42ZvZ6kjtqq5wrBZYoTIOFxXNcJD5F+FQ7C7kM1U/x?=
 =?us-ascii?Q?/d/kf/S7UNYrpMwmwDMaDRrldjj6SQgiWVH5sdSP4TeScxiUC006el4EndQv?=
 =?us-ascii?Q?m6+2O4hZsQz5AjO8MfgA3hp4hVV67l9Q2dPqaEWcS0CJHcUtLa71bI3MKtji?=
 =?us-ascii?Q?5PiHqlDCBxDbvLUEcDVfhMnsRb5rvOO202QiQzqYGGXjFRJtaDwu8GCtPqQo?=
 =?us-ascii?Q?lxEqathdooFcNK6IvDozo19HdGopIEWhPVHZFz+pkuhfb3ndtsOq1KCRqHA4?=
 =?us-ascii?Q?IFtGwT25zsZkGw0TpEuEJFistBRERzOaz8jejTVELTqgePggml1N4RjtVAat?=
 =?us-ascii?Q?H95vgdCaIefom4quE8LvJpt48x1ttOXC0DCkwK/mumJQeQH3NphByPfAKY2S?=
 =?us-ascii?Q?lNeRmJeUHSDjiDRD6jRqY5agDOJdnrF6+UrZyz7+FYdWottbc4IEXk6o/6eK?=
 =?us-ascii?Q?7z6zsiMi3QYZ3g2Kj9FQlVFayIhmr1sWetCk7jkidgF3EDRK2NnYE1p2nR4J?=
 =?us-ascii?Q?Y4pRa/WN//1FBYjHWA+epjffGp0E3cv/G7yUswtleZ2KvrfCAvO9gvzm7dJ2?=
 =?us-ascii?Q?dZR0ZZwnd35FM9qzyotCtEwxBfqRt9r22fOJDEG9kbfGL8cARGA3FMf1ja4C?=
 =?us-ascii?Q?Rm5YF79R1DEgkEgmKsYZAitM/Yt4wAZv17W8IRzJ3UUkRDqUfTL9EwKLJY0i?=
 =?us-ascii?Q?sJ2j1JP4HiL20iuqOpHazXWOV6Z8fx0xl2q5BU9ZFg5RepqQPOfcL4G1Hags?=
 =?us-ascii?Q?xZBNq8F+wgpI1zqPxdLuYrP1C3urG1rRiEhm1Z9NhaHdMLsF888uWN1nxIQ+?=
 =?us-ascii?Q?4KjcE7OzIpoudEXBCb4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MaeLRKLVKVytWvIbzPJN6GpD1g9ukdXUmw1N2OjPNSQDTqPBOfghqoCV9UiqMQZrIRUyZJhBLeSrKkyW48R3tIumzpgc/kbSp9/E6+TFptDYzSvEzEiEIaiz2LCtHfFtPuv47YNoDC73ZWviOPbaZC6Dlk8UpdTG57vBx1w0Wk+ZcHjPHb4nkpiNNC3lcb8DISJAjGk88seFsYA2XgHR93ATtVE4mwJtwKk4MPZ9KlwcDze7XiyfGM49MDI3EXdt9bfZbyvmwZfQjnWYPb+Kpn74YH4LcTgcISuAZiU2ZXDWpM2IiHWe2+7rVEVMzprD8ANeLKd3u3QjkE4Cwm5QVcywmEBuMIEMlPXdZ4OlUPEH+GHrIFXjvLPHILTVc1+IxVyvu9PHmRmSCwl4AmvXNjXDnW1BdtmwHMpGqX52mGpHjrDmySvLdCFgl8DRIs0/+zSiCQYpOEHHvBIsSHsbVM/0ugVYskW+yYis2hcXtyMSlz1YKB7q0BE/r/FaYH3S9HKHj97zrJL0dcMDcVOC3IPKN4MxtOO6Reet84KeY9nbsVFU/cLNzUs57KiqhPWhqshJTqKR3ubwTDntizjkkxaJWa17iDh9OlX+IiIfEKPwueX1BO6hSRlcR8uZGf2Uvzc9lwm0wiDyFdNTBFZL5UIUKq1/1tcDQdZL11lmq6r1UHqtgSIUDFDmJF7EHrdxS5VlXd/469gxwm3qE7WNWBx+i5CxCRHgAUEzSDEKrneXkFkaLkGqMbPdnMJltXx+4rSnTJ6S8MAwVqbDgRgxjJq5lIA+lqJdiyztxYztrXx98tepqHUNngGnMMRHGDN/wYCtCjsSukmrCrKYajYxgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fad7d9c9-8e43-4c58-03e0-08dbdc2b1df1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 05:09:55.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twyMsQv5yM9JbDXGWavqaiGPpHxO5vYjPTLM+U0z4lp1XwRSTVrs4xgx0snp56Ge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5901
X-OriginatorOrg: ddn.com
X-BESS-ID: 1698990176-104745-12327-20170-1
X-BESS-VER: 2019.1_20231024.1900
X-BESS-Apparent-Source-IP: 104.47.74.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGRsZAVgZQ0NzEPDnRLDUl2c
	jQOC01NSnNzNzcMsUiNcksNc3cwDBFqTYWAI8ofQhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251874 [from 
	cloudscan12-79.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

folio_wait_stable() now checks SB_I_STABLE_WRITES
flag on the superblock instead of backing_dev_info,
this could trigger a false block integrity error when
doing buffered write directly to the block device,
as folio_wait_stable() is a noop for bdev and the
content could be modified during writeback.

Check if the folio's superblock is bdev and wait for
writeback if the backing device requires stables_writes.

Fixes: 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag")
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
This patch supersedes the previous
block: add SB_I_STABLE_WRITES to bdev sb flag
---
---
 mm/page-writeback.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b8d3d7040a50..a236f93347a1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3110,7 +3110,11 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
  */
 void folio_wait_stable(struct folio *folio)
 {
-	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
+	struct inode *inode = folio_inode(folio);
+
+	if (inode->i_sb->s_iflags & SB_I_STABLE_WRITES ||
+	    (sb_is_blkdev_sb(inode->i_sb) &&
+	     bdev_stable_writes(I_BDEV(inode))))
 		folio_wait_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(folio_wait_stable);
-- 
2.42.0


