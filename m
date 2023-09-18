Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085A37A4FE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjIRQ4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIRQ4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:56:01 -0400
Received: from outbound-ip141b.ess.barracuda.com (outbound-ip141b.ess.barracuda.com [209.222.82.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F5EE5A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:32 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound-ea46-177.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyenPZlEE+HCQMfnzbm+rITXqJlhO8lKsdK3kHZR/eNT8gWJAUDY0Z20dAC3a04amznNDshTqKzZEDtc3yWoaPGA/2aAf46jAOkeh8A7x8pQtk80iZ0Mga/ra7Tb4XqPXwTIg+Zflpatxc3TLw4I6CNy8hHfvF/E/WPdfjXOnlXaUx8TvO8ubvsg7Cx8fI2jmHkCSJRrRJ17JOVyAJWgXYTTY3xlTtOwqtsN1NKKHCV/TotJbfloqCe+pWDJvnSUtAa7sdcWn+AgfHbzap8FeVJ3y2Tb0OTi1bgxvj2SGWaFjvDmtClyUMOjEH6CXYJYSJZZ2r+3+fZNdqDjiF1cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kr+5XWP6rtPbZpsJ4rBY5cifpLtBZj/socajKTfQ48=;
 b=TmlMFb5dv/KREjGhbY72Hnr5pTMhhjcF+0r5GqTkg437LNvOUxq+DhoGlAH323efGvkRq9oytm+DHu0exZLY9WtPNAkNdulViFXc8wE4JZHouVaBuVYCcI0cYPpb6hMgWbsGP73GNctGcS5qQihi+qVqtPasM9jPIcCtxoq+31wOi1U49Yxg1aDgtpV3uFDksjxwq8OIJ2xyCW73+ojj8ncdxg4D38g13TcbNybRSRNwCo1t8v+suOpYsKBmOLUN+yVWx5lF93R2/cHi5uyCOBEue2xNpKhXUKyiJfiqMy034z2YJ4plgLOB1js9UstRwvTpCJNBfDzGjkFYWRZpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kr+5XWP6rtPbZpsJ4rBY5cifpLtBZj/socajKTfQ48=;
 b=xgR/hhRVdy2g0AM67hAe0CYWnxlml1IBgJqpa7LGrP2ikFwmVx7D2brdzcriPwS7x5JB3rIFkpq7V4RhVmx99eVKO0F4frJydRGduloHvXkL7H/50rPAOGaIIQJsNIysLXjym8X2eZqISHf+NKC0XhRH+5ds7LaL1Cr/u0iyCEc=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by IA1PR19MB6276.namprd19.prod.outlook.com (2603:10b6:208:3e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 18 Sep
 2023 15:03:24 +0000
Received: from MW2NAM04FT038.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::3e) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT038.mail.protection.outlook.com (10.13.31.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:24 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 4E70420C684B;
        Mon, 18 Sep 2023 09:04:29 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v4 08/10] fuse: Remove page flush/invaliation in fuse_direct_io
Date:   Mon, 18 Sep 2023 17:03:11 +0200
Message-Id: <20230918150313.3845114-9-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT038:EE_|IA1PR19MB6276:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4a8aad9-d956-4e6d-de86-08dbb85867d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmFBXQD/623p4zuSc01GorUZAdtSjq3A6UCiOs1Gww6Dr7o6D6Lvyq4DiT/I9umJj0LYJXGzQGW+BW+u+EukV7t0x2Qu+3AzCKo2h18D6xdk39/8EnC4KTwEIFRI2hnVeETvIdarzuA5gxVYwlTfbYb2glQDZfHWKyusW5RFAqj13qbGysI9P+x00zQY/EBVUkpRwiz4nZS0f9adFqoCQ1aaSQUbm37qIiZgGyY49yNhUdg8xFEF3uPOeJ7YiY50pBOgpvbqJd7ZFZJAmj3a7zwmv88bYu6U9N16g3CA5p5E1w/FIxKm4QuzU8AGT5xQoZBn+u3AREQj7ZXIvfLOQ/MsguiZOjTRUsZCQFcRdtsyWpBDRZna++x48zB9uyPMng6waMO1O7SsvROOU+eDNAMUAOGY8ORovjA8glK2CPJxb+h/WaRNBaUJ4d/zpMH+H50eTlR8zd6o4uSeD8BMKJFEtsESs9mkZGF7nNm/JDD8pSV4uaaP0MBQqadSGT1xDU+t3CSLarawbiL5/Um7EyJs5OZTSWge4EhvomlK7/iPIRPVcifToWjZQf8dySaP0CyjdqkXh7qFCkvKS3nzf4+MUmkDPnlw4sDpAzwgwsSjLJpps3a1dfq6pYgbckIxVd2SqRZQBZF4aLX0iK4cLIiQgnBQla/kSn6FIafKsuNpomdj1WV+O3eueek3mYS4uFqKF+qKaDOPNuc2m2VLcdB8AxNjqjb4+2e3OZ/Bi2g8YjEheXREX7KepliprqMl
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39850400004)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(70586007)(4326008)(8936002)(70206006)(8676002)(41300700001)(6916009)(54906003)(316002)(5660300002)(86362001)(40480700001)(2906002)(83380400001)(36756003)(6666004)(1076003)(2616005)(47076005)(36860700001)(26005)(356005)(6266002)(478600001)(81166007)(336012)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rXETSGwyyo8ygs5pPd0iNUrKnmnYcy/rVDNiAizvTYrm7vvndqIjs3AfVCFJ9+VC/7kz1O/ikzz8bW5jfoVkA06ci8xJcsr9d0M9AcT+8Xx5GN1JByg8r6/d7BSG80qDLpOuIhJv4Uvp7c2XS1D/1eZB/3waKucgGEFwuqjtYKq3dFjZWm5QDPTpjaNoJ7PQqjOVGA6/ckn1/un/KdCrmEDU80n4hFIdJIE0CILZjJgDNRTaIKRbXuYk+lNCAH0UpVXDDRglmledzh6u9IFzepIemwo7Ujrm+vgE11Wa4h8tSi+Yx0nuQcsgsuGxE5k4obf5MN6oXJFblzy8VCGce91ajZB7o0cWN5JHvuMXvLBFeLd9e4cG92wd6s273lyIcwAgtxIGilwt+Ic/UadBALRXYHlOVzwcTjRDOvs0iVKX2vYVmvaOgVNiCxib4pTkbDskx7sBj9+u6UWr3FNaHFdHRMSQyLCQWUNbyREK42XXYzxr6zqJTz9+i8Sb+PY5WTc/Z1TiMcP1xfwtW9pEfJxv/Xzgw9imGf6Cz+ssAwd++8iN3YuQRfwvLHNOmzdU9iStXcp4cO1mjFkXDxTHeFOUWxHKmjnHFlyTEUpQxKXbKMIXyFl77OOuZLZqCNgbRY1GTZpLjQ2nj+WswapZ1ekPdSH8qQ126kY885J+E4DLu9UQB52CQjR9TeonM9564BK3ekyRmSoA+1P2gM4+3gsetBIMT3dDJVbK2boqI0J+AFry1A7qzqaXDk2pfLZMKJsL7KSAGy6w2kxjzvXRnWHFCy8nbrhySL4azR/Z+kk/l3rrQmoLRkAhHU/CedCUYw3EpLlkAU3ngKFSJjQT7XKfoF06uWhJ0aXEpaE9DslPPOU/vpcwJw6UwrZSUMz4RNs+YpCRSd4eKkMDx3euUZMfm86zUeOOw+t5V8LhWOk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:24.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a8aad9-d956-4e6d-de86-08dbb85867d7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT038.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6276
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055411-111953-32470-3941-1
X-BESS-VER: 2019.3_20230913.1605
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmJsZAVgZQMMk8xdzSMsU8xc
        DCKM00yczC3MwsxTgpFSiQZmlmbqxUGwsAsTvJ8UEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan8-128.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page flush and invalidation in fuse_direct_io can when FOPEN_DIRECT_IO
is set can be removed, as the code path is now always via
generic_file_direct_write, which already does it.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a5285a9e36e3..a996368cd38b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1519,20 +1519,11 @@ ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
 	int err = 0;
 	struct fuse_io_args *ia;
 	unsigned int max_pages;
-	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
-
 	max_pages = iov_iter_npages(iter, fc->max_pages);
 	ia = fuse_io_alloc(io, max_pages);
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_relax) {
-		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
 		if (!write)
 			inode_lock(inode);
@@ -1541,14 +1532,6 @@ ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
-	if (fopen_direct_io && write) {
-		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
-
 	io->should_dirty = !write && user_backed_iter(iter);
 	while (count) {
 		ssize_t nres;
-- 
2.39.2

