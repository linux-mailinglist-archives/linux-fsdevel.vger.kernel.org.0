Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF77A779728
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjHKSjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjHKSjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:39:01 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9E30E7
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:39:00 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176]) by mx-outbound17-57.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYeqqIXEDpjFKx1/X2OdnCemiptv3lqQBrMIfEMh0tDOR2OXBrVvI2QS/RaYZHj1iwNbwjDQ0N6cwLMLGEH3KlXFId6tMWlPTo79ujY14e7CE9JiVzIeBeyN9E7nKHN193Eu9LLw1HiExxWYcj507j5RUO4LV7zxBDVJkXtFLsbSCePhQVKFnr9c2rq6YReQPbsbMD6u28nBt9bweIdRZ0YD3zYVc3LBNwYGQtAGmvBNLTk3wROGG6tJVN3hodtNvPHdzhkGWxM5sDMWt/c65hSfY7WYwSQgtaGneDw1FG3dHnLZa3tad/epdyg7RRgicev9pyRsW9bPGsYflC5wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11+XzhLqiLXWB1or4dSmzijzIMduABGC9Fp8Ebs+XAA=;
 b=S8QflNj8F4cloZXMJcmMSQDmUJmt6/M8rTF1lIrwbJ5Hm4c3wzF6s9hgxAHn+OSXJ4OUlPoOdOFL6o36+Fb5tzOX2sT6I8QRZkh3gGojv10p283oh2GYFuptO/r9duEoBwhZUv8cfqA0thEGclA7zR+uKrOXi/r5LbZn7rUtq7sTbkDFMmHpNtiPZyE9Hw/LdVESi2fG7sFbIYsvQj8D+riHTNU96Qko5xqVnyYkwq56gBz2tfKf/Efw+ipIJdbJHH73yQ9ILvKrCtfdr/+zkHPnpC5NZ8c5aJ1WvfEC1QWoRCGeoChM/OuM+vK+QfinU9bfPxaH/7p98mFQ7BKx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11+XzhLqiLXWB1or4dSmzijzIMduABGC9Fp8Ebs+XAA=;
 b=vHXttL4XMehVi1AMKFtWCKDXzjeFMI6CoEvhSSdOvEtCWi5Tr63yqecYjENoS5yzU5i23ccM01YBj8QMqpLKMjCxgP2fb2MK6CFlve2OMDMDcEg7Ar8ehNEaPFeSlqxuL1npEuTJaoDuMuPX3Brm0pK+CEvfjm0h887zeDn7xuY=
Received: from DM6PR11CA0039.namprd11.prod.outlook.com (2603:10b6:5:14c::16)
 by PH7PR19MB5992.namprd19.prod.outlook.com (2603:10b6:510:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:38:30 +0000
Received: from DM6NAM04FT015.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::1) by DM6PR11CA0039.outlook.office365.com
 (2603:10b6:5:14c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT015.mail.protection.outlook.com (10.13.159.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9 via Frontend Transport; Fri, 11 Aug 2023 18:38:30 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id DE1AF20C684B;
        Fri, 11 Aug 2023 12:39:35 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/6] fuse: Revalidate positive entries in fuse_atomic_open
Date:   Fri, 11 Aug 2023 20:37:50 +0200
Message-Id: <20230811183752.2506418-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811183752.2506418-1-bschubert@ddn.com>
References: <20230811183752.2506418-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT015:EE_|PH7PR19MB5992:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bfb2e3cd-0976-4086-8c3e-08db9a9a292c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1lz89mPoFrdCqA3urE85gKlh6MXmiulIrLMPt1D3F7ErWx3AOXxQn8lVF7Pn5aBmYSE13cTNYTaZkNeUFcuguHf40WVbRtK0l+I4nRGjejtf3s8B4XUlVcfBVvcUoMCfh4sKz5qQ3GtbEhGS5PPQJah6EkpyGDSzaEaBI6h4gIuVQIhIcPTUF0WECvV8hAc/xxdafa864NMbEaip0qfKrRwhvBRywYMAE8otM23TDbXfiRcHFeqP5iAvg7F+cVF2a8rEo/N82nPmoraGavBvBzQpoXPvULNpY3LSEirQgGzFzEVLCU3DWF+R0mAweruOXmtBlg2Il2ar8LUZSPoyTGaTkLetQibG626oNX6kE1b9Hvp0AivxiYPTPFsIS4L4Ds+dgGfcy+ebEIucJhdcIDpz5+xLzYAJGpGkbS7p9WSl18gS4JoO8yyLHVpIuvoJaLgtaHyThj327gPFr/ybd7kZFJFza3KILsVY2cAvl52J5VzQgkeQcdhkP+timL5/bHFA8ukCCrlXv+ZCrw0/5Bisj+VaI3596k5hXVA7iY2Jnx4zg4icUvsnJI/TvwZspOp1NhmDfuIRP4uXPqT6UKXakYhnjw1vBLpHo2d+lQiQcKWvK/V7GdDsfSt1Si4R+3qO+7/F0b9AJNidWR/pRE3h3/IyXCwD73V/CjcTuP+9JZA+21KJHLO7ae+ZBubNBRrC58mhz0nmyYRcr2JOsB+NagyvZSUz4oc3j4A9QS31K8fBiG2qFlEAUFRy+yllrA181uxYwIqmj+GQLYJ94GdI/NIRY/ZXRWLpW5IoTI=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(396003)(376002)(346002)(186006)(451199021)(1800799006)(82310400008)(46966006)(36840700001)(2616005)(6666004)(356005)(81166007)(82740400003)(36756003)(1076003)(26005)(6266002)(336012)(40480700001)(5660300002)(47076005)(54906003)(4326008)(70206006)(36860700001)(70586007)(6916009)(316002)(2906002)(86362001)(478600001)(83380400001)(8676002)(8936002)(41300700001)(21314003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GAKJkdc4sW4CNwi9ysQEpAJQkDoFZSyKLCH9P5k1ZOXgsJJjxkPBfisQH18c?=
 =?us-ascii?Q?GcuK0BqInfzQ9QviPVuODNI5JU9spNbbys8nXU93BydRNEzC7s418TKAjVXH?=
 =?us-ascii?Q?iymhHujiS1cD3gUgq42+MTqT8PhSS09u0gBkZk2WNk+M0C6v67CtBCP+tDrl?=
 =?us-ascii?Q?Ko7kvIo73ytmpHIid6gEGRXcZUr1TmmcjtBco7ZZsK7+Tq9okL1opXOzEuhz?=
 =?us-ascii?Q?ycb+bQJ4NwT1ofQIgMn0L9D7dqkf5WrSduDGtOs/kiCxxqzhWcGH7BkrlqYd?=
 =?us-ascii?Q?spwOxyeTnSUJK94B+VEMlnvR850+jctUCQXqJtMwwrEeW+FphCtZQ2RfA7YT?=
 =?us-ascii?Q?jX2Uc4nFVF6w6TdYicy6jJJbmBrMfllqziZjouedKqkM2jaG+j9/XfvxizJP?=
 =?us-ascii?Q?kIeMBdN5QtVTHSfql6Qsg2V8i2Lx1R9XQaQfCQb63lioJ9dekWNzZbZr0boB?=
 =?us-ascii?Q?3cD7E7yptkIJ7CVoVpQhp0eGzCMP9y6zpfnDxAHSQn9+CO8YCgmDZYJe5F/t?=
 =?us-ascii?Q?8stwUIjj1qm8XW8HiC/HbrjpOL+QRnuTEGhcY7thYaClBHdHgezMh1OJLFIk?=
 =?us-ascii?Q?ncOYIVtHzPX+Gw24Q7RoFCgVGbXzdEhmTsD3WvJPR5/cmAVPNNGnsfpoe3lX?=
 =?us-ascii?Q?CttyUoVAz16cQ9E9r+gJ0DH1yPv3orKeAVJT0cs4Lyb271ZEzCgclFO9cD7X?=
 =?us-ascii?Q?4GX4K8XWPbtC+dU5PVOokJ7s6aiCrTVpTb5EzTQrwtTcwwduxrgVU1LgVElX?=
 =?us-ascii?Q?GoLv7yMPXKV8qcX53MyqGoStK3wgmlgdYCntkxJNvvLra9s01E3ifQzP1MRn?=
 =?us-ascii?Q?7fuYO7Fun07Ecsjd2j8wGtd57KAP6U5oiBm3ZPs4T6vkBA0ZkIdXLNqXc1Il?=
 =?us-ascii?Q?IWc7i15DyR3YnDZ1Kba2BmvnKRsfeHKUtneRO9E/TPsWZxHbPZ6PAwwDBTtE?=
 =?us-ascii?Q?3F7jyAf0mIhFnMBzz8OIQyXIgb6Y8t9yfV72uE1KBQo4aAHsWFXxKSldMWFY?=
 =?us-ascii?Q?f50V?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:30.8702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb2e3cd-0976-4086-8c3e-08db9a9a292c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT015.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5992
X-BESS-ID: 1691779113-104409-12512-5345-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.55.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmhmZAVgZQMDnJIM002dQ0Jd
        nMwMQo2dLUMs3YwszA3CDNJDXVLC1JqTYWAIz8b7pBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan19-167.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

From: Dharmendra Singh <dsingh@ddn.com>

This makes use of the vfs changes and fuse_dentry_revalidate()
can now skip revalidate, if the fuse implementation has
atomic_open support, which will has to do the dentry
revalidation.

Skipping revalidate is only possible when we absolutely
know that the implementation supports atomic_open, so
another bit had to be added to struct fuse_conn, which
is set when atomic_open was successful.

Once struct fuse_conn has the positive 'has_open_atomic'
fuse_dentry_revalidate() might set DCACHE_ATOMIC_OPEN.
vfs use that flag to use atomic_open.

If the file was newly created, the previous positive dentry
is invalidated and a new dentry and inode are allocated
and linked (d_splice_alias).

If file was not created, we revalidate the inode. If inode is
stale, current inode is marked as bad. And new inode is allocated
and linked to new dentry(old dentry invalidated). In case of
inode attributes differing with fresh attr, we allocate new
dentry and hook current inode to it and open the file.

For negative dentry, FS just allocate new inode and hook it onto
passed entry from VFS and open the file.

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c    | 207 ++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |   3 +
 2 files changed, 182 insertions(+), 28 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 8ccd49d63235..d872453a6cd0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -230,6 +230,24 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
+		/* If open atomic is supported by FUSE then use this opportunity
+		 * to avoid this lookup and combine lookup + open into a single call.
+		 *
+		 * Note: Fuse detects open atomic implementation automatically.
+		 * Therefore first few call would go into open atomic code path
+		 * , detects that open atomic is implemented or not by setting
+		 * fc->no_open_atomic. In case open atomic is not implemented,
+		 * calls fall back to non-atomic open.
+		 */
+		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN &&
+		    flags & LOOKUP_ATOMIC_REVALIDATE) {
+			spin_lock(&entry->d_lock);
+			entry->d_flags |= DCACHE_ATOMIC_OPEN;
+			spin_unlock(&entry->d_lock);
+
+			ret = 1;
+			goto out;
+		}
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -769,13 +787,87 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+/**
+ * Revalidate inode hooked into dentry against freshly acquired
+ * attributes. If inode is stale then allocate new dentry and
+ * hook it onto fresh inode.
+ */
+static struct dentry *
+fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
+			    struct inode *inode, int switched,
+			    struct fuse_entry_out *outentry,
+			    wait_queue_head_t *wq, int *alloc_inode)
+{
+	u64 attr_version;
+	struct dentry *prev = entry;
+
+	WARN_ON(*alloc_inode != 0);
+
+	if (outentry->nodeid != get_node_id(inode) ||
+	    (bool) IS_AUTOMOUNT(inode) !=
+	    (bool) (outentry->attr.flags & FUSE_ATTR_SUBMOUNT)) {
+		*alloc_inode = 1;
+	}
+	else if (fuse_stale_inode(inode, outentry->generation,
+				  &outentry->attr)) {
+		fuse_make_bad(inode);
+		*alloc_inode = 1;
+	}
+
+	if (*alloc_inode) {
+		struct dentry *new = NULL;
+
+		if (!switched && !d_in_lookup(entry)) {
+			d_drop(entry);
+			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
+					       wq);
+			if (IS_ERR(new))
+				return new;
+
+			if (unlikely(!d_in_lookup(new))) {
+				dput(new);
+				new = ERR_PTR(-EIO);
+				return new;
+			}
+		}
+
+		fuse_invalidate_entry(entry);
+
+		entry = new;
+	} else if (!*alloc_inode) {
+		attr_version = fuse_get_attr_version(fc);
+		forget_all_cached_acls(inode);
+		fuse_change_attributes(inode, &outentry->attr,
+				       entry_attr_timeout(outentry),
+				       attr_version);
+	}
+
+	if (prev == entry) {
+		/* nothing changed, atomic-open on the server side
+		 * had increased the lookup count - do the same here
+		 */
+		struct fuse_inode *fi = get_fuse_inode(inode);
+		spin_lock(&fi->lock);
+		fi->nlookup++;
+		spin_unlock(&fi->lock);
+	}
+
+	return entry;
+}
+
+/**
+ * Does 'lookup + create + open' or 'lookup + open' atomically.
+ * @entry might be positive as well, therefore inode is re-validated.
+ * Positive dentry is invalidated in case inode attributes differ or
+ * we encountered error.
+ */
 static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			     struct file *file, unsigned flags,
 			     umode_t mode)
 {
 
 	int err;
-	struct inode *inode;
+	struct inode *inode = d_inode(entry);
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	struct fuse_conn *fc = fm->fc;
 	FUSE_ARGS(args);
@@ -787,10 +879,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	struct fuse_file *ff;
 	struct dentry *switched_entry = NULL, *alias = NULL;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
-	/* Expect a negative dentry */
-	if (unlikely(d_inode(entry)))
-		goto fallback;
+	int alloc_inode = 0;
 
 	/* Userspace expects S_IFREG in create mode */
 	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG)
@@ -842,37 +931,57 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	err = fuse_simple_request(fm, &args);
 	free_ext_value(&args);
-	if (err == -ENOSYS) {
-		fc->no_open_atomic = 1;
-		fuse_file_free(ff);
-		kfree(forget);
-		goto fallback;
-	}
 
 	if (!err && !outentry.nodeid)
 		err = -ENOENT;
 
-	if (err)
-		goto out_free_ff;
+	if (err) {
+		if (err == -ENOSYS) {
+			fc->no_open_atomic = 1;
+
+			/* Might come up if userspace tricks us and would
+			 * return -ENOSYS for OPEN_ATOMIC after it was
+			 * aready working
+			 */
+			if (unlikely(fc->has_open_atomic == 1)) {
+				pr_info("fuse server/daemon bug, atomic open "
+					"got -ENOSYS although it was already "
+					"succeeding before.");
+			}
+
+			/* This should better never happen, revalidate
+			 * is missing for this entry*/
+			if (d_really_is_positive(entry)) {
+				WARN_ON(1);
+				err = -EIO;
+				goto out_free_ff;
+			}
+
+			fuse_file_free(ff);
+			kfree(forget);
+			goto fallback;
+		} else {
+			if (d_really_is_positive(entry)) {
+				if (err != -EINTR && err != -ENOMEM)
+					fuse_invalidate_entry(entry);
+			}
+
+			goto out_free_ff;
+		}
+	}
+
+	if (!err && !fc->has_open_atomic) {
+		/* Only set this flag when atomic open did not return an error,
+		 * so that we are absolutely sure it is implemented.
+		 */
+		fc->has_open_atomic = 1;
+	}
 
 	err = -EIO;
 	if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
-	ff->fh = outopen.fh;
-	ff->nodeid = outentry.nodeid;
-	ff->open_flags = outopen.open_flags;
-	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, entry_attr_timeout(&outentry), 0);
-	if (!inode) {
-		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
-		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
-		err = -ENOMEM;
-		goto out_err;
-	}
-
-	/* prevent racing/parallel lookup on a negative hashed */
+	/* prevent racing/parallel lookup */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
 		d_drop(entry);
 		switched_entry = d_alloc_parallel(entry->d_parent,
@@ -886,10 +995,52 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			/* fall back */
 			dput(switched_entry);
 			switched_entry = NULL;
-			goto free_and_fallback;
+
+			if (!inode) {
+				goto free_and_fallback;
+			} else {
+				/* XXX can this happen at all and is there a
+				 * better way to handle it?
+				 */
+				err = PTR_ERR(new);
+				goto out_free_ff;
+			}
+		}
+	}
+
+	if (inode) {
+		struct dentry *new;
+
+		err = -ESTALE;
+		new = fuse_atomic_open_revalidate(fm->fc, entry, inode,
+						  !!switched_entry,
+						  &outentry, &wq, &alloc_inode);
+		if (IS_ERR(new)) {
+			err = PTR_ERR(new);
+			goto out_free_ff;
 		}
 
+		if (new != entry && new != NULL)
+			switched_entry = new;
+	}
+
+	if (switched_entry)
 		entry = switched_entry;
+
+	ff->fh = outopen.fh;
+	ff->nodeid = outentry.nodeid;
+	ff->open_flags = outopen.open_flags;
+
+	if (!inode || alloc_inode) {
+		inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
+				  &outentry.attr, entry_attr_timeout(&outentry), 0);
+		if (!inode) {
+			flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+			fuse_sync_release(NULL, ff, flags);
+			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+			err = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	/* modified version of _nfs4_open_and_get_state - nfs does not open
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4e2ebcc28912..c0da4fce1a9c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -675,6 +675,9 @@ struct fuse_conn {
 	/** Is open atomic not impelmented by fs? */
 	unsigned no_open_atomic:1;
 
+	/** Is open atomic is proven to be implemented by fs? */
+	unsigned has_open_atomic;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
-- 
2.34.1

