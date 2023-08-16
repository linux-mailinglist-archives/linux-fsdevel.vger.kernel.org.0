Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F181877E3AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjHPOd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbjHPOdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:33:51 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3C271E
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:43 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102]) by mx-outbound10-189.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU1NWYkNaiPO/5CaWQxhEZy0tCKgZmaXMa2/cFWi3dg/g7Jlpx/GAmsCaurkT5nAM6HMEFB83qv8WGB2tp0xR4/K3FBm9p5f9O0Anhs1+RefTgIr8TlNsYIhDbin4hjzyEtDdyqkHT+YC0M1jkq0P7A1II2XmaPjbLIuUr1Bq4g3jHD9lgNT/bGgWZtva/hbM7RMaJKEPq4V8jdt69Xv23L8ipeTKHgupUW1YV4tnebrFmJm7kmEPGXGK7akJmtWb2n9klg9PA/Uux95DouASlQJP9a5301pYQwlhaHbbTcIepmAxjk9O0visGrDeRzBPhup4PGEtjYHIINTnM50ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RyHP8MWUcfxnqGv2FS0zugv49b85MMPFbsW99XNlig=;
 b=UrVYRXdKLighCoAgsSDij/7lVYs76H4rs0+EhyP3yEWSfaTMdzaw1BA+cnUovV/NwhP4kJIwxEbUiRPRVTA/h1qH6lA511ehoy8LaLjcUPx26GzALyhpRhJ/Qx7IPKTKpNaUfItrOSVPFpvRyaByvgt4Bpr1d80xFpzbpekFyNsVhGVsIfQD/SbD7Fj3Q6CWURUFkc91gn+lW9Z648Lv4++HpTHWRg+SM6qv2RMBtER6BzAMdSijq9GvbSAJ0439WRNcljuw1yQUzaxlQTo2VP9ukcrFqVRo6KQPe8Zyi/y4I8psX0h79b9BWUo9er3CT9DZ/Swu7C+glLqbVCnOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RyHP8MWUcfxnqGv2FS0zugv49b85MMPFbsW99XNlig=;
 b=yNywD1TaLxbqyIgAch4DG0aS+1oBVi8rW10dDoF8ndrDTkf45QIgI9mMn4+NtZgst+V6ISSXmqsCojdnbqXcK9LDsC6fxjPQToJfxtJ+OL5jvh5hPbawg1L/7XGDXkiKB0AukNh4iDKArqXFxN9RDGK/LiUk0sYDFMaT5ZS9Yek=
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by DM4PR19MB7191.namprd19.prod.outlook.com (2603:10b6:8:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 14:33:24 +0000
Received: from MW2NAM04FT039.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::36) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT039.mail.protection.outlook.com (10.13.30.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 14:33:24 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 4F51D20C684B;
        Wed, 16 Aug 2023 08:34:30 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 1/6] fuse: rename fuse_create_open
Date:   Wed, 16 Aug 2023 16:33:08 +0200
Message-Id: <20230816143313.2591328-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143313.2591328-1-bschubert@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT039:EE_|DM4PR19MB7191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f9987b7b-c8cb-407e-f5a7-08db9e65bf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xH9fP0pjgIso3x2xlF8q1asnhwzaa1b3+GuyNkxT4LsEm+DG9OeeEpX38zsvaMeKoJNhEaEIuumYY9c/d/3rWbATeCuxZJWMrTie+XK43Xox7hFX5F8tCk8kAAx7lS36Fw0WiXb/hA1JDnVnWnUDbbSWpKiY/njCj3cEjRlbBF8EJC2TVIIcxDwp/6Ipoz4CXgAWr0FTxkF9bNQJ0kOdJ+T93eox80vb1qksEJeICXAuaSmlsSGkx8GgpuQtDjaSyU443bdVpyyly5TY/mztCadG+FJUHWyIJ79EKylIVT1MWn9Eli5DcZlCKRv4cF4OXN8b3qjhvyRVl7BtiBb0xpNBqVk1eH5a5gR7WSBuZIMOgZRQtjIFHl3Q9Z9qd7KsL0IEyldDLMqPS/RiTinY++8jvh3ESj4ysjebz7KK3NfhQdBUOyP3zUoVGIXvqiNJkHiCGLO/z37kq2Y+0XsDfUfiLBdtAIj6TPG4+dVC2NUgBTNgL+iyzhfUriTsssmlnE3gMy7q4Gi3e0B6t2CLYFl/SBdBlHaHhUT+JIphzyJMYXnNFBzm6HtpqhCaOclkmaKl8B77slOV/NI5GMULqijRl84GeP8SM6b86oetroqJqpuhqaV9hRI3MwXmc/8rlMUewRRd0FV871wtqSq145NVVOH6M6XR5xJoosuyFI8t1CFVE9te0wc150VKRRlGoELIoFRXcQWlKJaR2WHbTDZ+5/v8tAxD6qqK8RyN6y7Q12JmsJ4yQf+s/dIjr4w
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5sE1VrAbbNd/9F+xYkO9ZLq3iApp+LuZ5xs9PArSYZa9JsBSXiVlTJZ8qpw3ts0jXa8HGdCWA0cCuRrYxmcejArcHnsNdVDDP4W+XVcoo5esBvAmZC/JvrPmH09prSpl8p2ENfL7ubq5WZUMWbksMrA4hxdfafoy5weLAXoQybZlo+z3nlaX3p3uTsMSe/tG37VqgqXfwMthxggmUZl+w+1XCgHbSeY7qks9kvDnMWZrtP3BcB5KyZsyj0KUHwbFG8hNaLO1g5gDdaVvs/FrIK8Ot2BC6/qg6PFUYsyNce3kitaFZz9yN7pDDBF6zyFgdjuYwN1xgKJAww4RpOvyxcRKie+fi02Pv9aF2dNbQB4KGndPBXwntfZgtb9xO2RQdd8XrQdv07M+t/ZI1SO5G9u4NLy79noQsSwXIAhn2k37uyJ6Scc8ExZvG0ytpXvognrO3MZYCgfH6oqQYA7z9Lqv4HYWV/J3DlZxWXaZ48LxPPxsC9jWWiSdZjCt3i92PTkbfVCLVQ9CFaFBqMvqAiAXLtJNfiZHOrlxL1VngN95XEJs0BW3uspTafDKXPEz3uGDUxShzgFizR42ws9gXyojdywrHko+igMXWBpTCnjeI5f6wkqBf7DDAoPssYb8gVrk0+3cw2c4JWqw7u19Dbl8RORNoHqPSU0ObzqdevXXnGwtRUWzZ4Y/KkJCSncfCwUAugl2fgslRMcPHWriFf63ghaXDLSM/VFwQ1bu7VfnwUaLBQDmYitfIWvGY0Kpkq5/FJUDD4T8wohwigUrIaxARx9wbShvHHHot5HHBsqNRcyELk6v3K+ApFB8I7EvTkACgT4L+UvfSdt8ZxLKqAKVjwlvf1TGRCG5XKnM8d6JmbJj5U8Ie606Jsubw4HdJ3AvC5MBTUPXXGokBvsZYjde8ZGuPQl/5QmwqVTeLEs=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:24.4257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9987b7b-c8cb-407e-f5a7-08db9e65bf83
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT039.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7191
X-BESS-ID: 1692196408-102749-1080-1092-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.70.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxpZAVgZQMC0pOTXR0MI4Nc
        08JSXZxNDSPNkiNdHIwCLJ0sDQLNVEqTYWAO12wolBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan17-27.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just preparation work for atomic open.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..6ffc573de470 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -613,7 +613,7 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
+static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
 			    umode_t mode, u32 opcode)
 {
@@ -753,7 +753,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = _fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -879,7 +879,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = _fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
-- 
2.37.2

