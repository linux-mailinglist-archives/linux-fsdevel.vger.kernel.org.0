Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA77A8AB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjITRfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjITRfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:30 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD59B4
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:23 -0700 (PDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103]) by mx-outbound20-254.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsqVJ0uXECKv+lsJNfhHYKjQr3aRlSJdd81/bKPLRPN4oJ5qf6gckMir2YD+IDPshNsXBAzXc1rgg4Sep8r0RTHVsR2Yfr7+1nuTX7ByX5mtWFS+KwwRK4yBh0uhNuW8DMpYSezdh4m6UnKTpWuRv6mGuPc100YmaOE/w+RkKvIkp9nIkwdx0fVbKKSaVfvCd1JDmVew0V9zSvafoc32cByjYR+M2JgLK+0yjpZKDp3BR0i8ZiWABc68mNW+aL19M89CEEy3riPC1TjxSxJhtYOB9LCHHUlgSAaupvYN29GJ9J/bK5qC70x/k0/VtCuiJoNo8cCyFLGLxwe8eMJ4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIKchc+i1MBszxLkRo9yoa5Q8mu/F9AvOHkWVa4shWs=;
 b=RSOIcNx1yAWnKqh5AryTQZxo0Emx/NV6IPy0CEDngK5bt1I5HRlVOxlWdNd3i9B4dQ1s8BY30Kr50wB5M/U5wrGV2j2RRGLypQKwYH/NbIFHKvmpWdB8L12FsOS2hnY2FTwat4leFctbTpy12FEHuYigMBFMSy6mj6ID594nncwChgQWDj9Vop+/IGWHhfGyRjzCzUixS773ZVuKP3vSR1EkyFTf2nQGdrowT5Eq3gae8ve/QB0kM5iNhYXD7yA05RoHaOYTuXZgVEaG129hdqjmDsv2Yv1OauhY2/R93VgeCyXPK3um6YeSld/alHrnsjRxETfAMF+jpoAyKsi9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIKchc+i1MBszxLkRo9yoa5Q8mu/F9AvOHkWVa4shWs=;
 b=pQwLUGv0Ze/FyAat+C0zdZK760HJVxd6JVxhzALALC28TDuusO404BOEo/eEYOK6MBmCsD7AlyNWkLCUEP5Xus9kArgYN5KsY0Tx0iL6a9iWhBW+1l303uqpDMQ8SQVCM2dFYd3sk7RgNplblxLE9NbLcDN51p2gRSojQYgJ0sY=
Received: from MW4PR04CA0368.namprd04.prod.outlook.com (2603:10b6:303:81::13)
 by DM4PR19MB6248.namprd19.prod.outlook.com (2603:10b6:8:a9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Wed, 20 Sep 2023 17:34:50 +0000
Received: from MW2NAM04FT040.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::3d) by MW4PR04CA0368.outlook.office365.com
 (2603:10b6:303:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT040.mail.protection.outlook.com (10.13.30.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20 via Frontend Transport; Wed, 20 Sep 2023 17:34:50 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 545D520C684C;
        Wed, 20 Sep 2023 11:35:55 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v9 1/7] fuse: rename fuse_create_open
Date:   Wed, 20 Sep 2023 19:34:39 +0200
Message-Id: <20230920173445.3943581-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT040:EE_|DM4PR19MB6248:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 80e9a1a5-9494-48cf-9e5f-08dbb9ffe47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpxVbiRRI7E8kxFrbTQu3DuPvPtfhbUJ3W0rI92rFqayY8y6lrpt7aDt2UGtJKHfr6qg2jbFjqvGaJ5rMEpc5mWql4AiaAg7+AxxeB5I6/FFscFzzHp+DKj84GQ4nS+pb0M6LU6+5cexyDGBGapX93gvM6CMNrh724+ghnIoRzGbqxEFYszMpy5RmGh0+pHw13MKa7ib5aF0opXe2sw14jMIxMuZ9evs6iT3RHqvFP+7Z8dMjz9Y56dwZQ+Ej7FTOVExQ5A3o2vaGlMFWswK2sLTI0xGSGoS0BiiaKB61AyjPvlEb2jbgeACeSwyGKml2C6iNlUgUaMQ1s+iRuA/d3jbsBMQgd2jZILIKJiQ6rcG+8DLHHHvve01Q+U5rUm4GBTz4ULGC4e5E8TBXOdIq1tWA8rAc2Fko311IobJh9wCX3tvdphH68g7TwBysbezHg2rVONWc+NtRFYiNovFrUucuIZK+N3GnZ2aPyI2dhpY9KU7Cndsh//E2OLkko+TaVD5b9x0P79ASa2JZhaYrH8ykxL7b3kLzmQGVsVeF48tZNsbQsXeK2Fyiod1HptrmypVIfdAQJNesMkgAzGJRGGBpRLRrC+JiysPp+4nHqX67atZJ2mCW5ywUftjdgd76DeDE2GcP3hIO6KBCkKPQv+EoR9usKzweIJ4XYGr95gzI9o2h6eOKGM66wa2Bd7YrAEhQfzv5P47SXoauXI8LxMCS8RW7fIBejpDTh2QorvAtaJieMKRPw8UqseJcVPl
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39850400004)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(5660300002)(86362001)(40480700001)(36860700001)(6666004)(41300700001)(478600001)(8936002)(8676002)(4326008)(36756003)(316002)(6916009)(2616005)(70206006)(70586007)(26005)(1076003)(336012)(6266002)(83380400001)(2906002)(47076005)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: su6K2jlkJDxYCzcOPqRoDH5cDhGtrD952k9TajzWJ29KWtbog40tb5NmuvtiZiGW8Oov3he5MydsbujQwW60VGGECRhpbq7XyfCVWEIysw7uhzNVqL0o9OlR48XK/vQ4ugzBe0xXGw6W1LDAH4pY2VuAytU178YFRZLGyUz/H5FJqAc09W92vXvpaposMV4XhfD59waveU3FEr6Lyj8V9+mIRkYDvgKRCk1Pc84xQbaA2RqGf91Eke3j9iURkZ2M9s1ZLqAInlK5h/k4wljlFbOOx+WoRJfGQAqXRJtnbV6tgDDvPe754fvbYaUCmdtZdKTDZqSLH9E/1mL2jTLPaZXQzZmoAdGzxExqGnfsuS2Ykdz8llWlJ60FNpBjvjEPXj19HEn4vx3U4nU6vZz3Q9CqJXe8nB3LXVtE2nW2JwgBk+xxqUEut9AVfFO+Slxt9BmmKfstfILb9cSKT47LVdICuJM31DfOp7w5h4fvJtjXGf7CxudD+UOraIbt1j5zjr/nr5hUo4pWtyx6aQ5G8odiMd/MuBi3N6s2swwxiknBdtNurWT7YTfb1mQprJ/yLs70TSOm3sNYO7Mf7Ba3jA/ZOieAFGOtH3EyoANWKGx10/qUJ3lLdJAYetX+7D7U89gNRu0NcPXJWvx3I02dBdEr5baAq9RHIVQDK5Tl8Etv1gk3mJXQkHmTnJ3SXnQIgk7/3c4TXdkB0YkJXq8BmE6jMk7+zVcP5cLv78jG1UlA569PWu3BQ+U+qcD30CB/7lE8RKPXo9j345ZnNOZWOeVfSTuJXUj6NORUFUuDNAXrH5hD3GECMehm7FtWtLWnMDA5fVGFMo28oNkmlFiitYzQdj8U0nBA29Nq/WsCIhM=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:50.3381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e9a1a5-9494-48cf-9e5f-08dbb9ffe47b
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT040.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6248
X-BESS-ID: 1695231318-105374-17477-6411-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.55.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxpZAVgZQMM3CNM3EIjEl1S
        jFMsncNMnS0sjELNnQwjLR0CQ5NcVAqTYWACN7O41BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan22-178.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index f67bef9d83c4..542086140781 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -611,7 +611,7 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
+static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
 			    umode_t mode, u32 opcode)
 {
@@ -751,7 +751,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = _fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -877,7 +877,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = _fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
-- 
2.39.2

