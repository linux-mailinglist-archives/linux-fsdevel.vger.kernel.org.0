Return-Path: <linux-fsdevel+bounces-957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B07D3F43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE411C20AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D01224D7;
	Mon, 23 Oct 2023 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="eqfNpYLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3002224C1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:17 +0000 (UTC)
Received: from outbound-ip179b.ess.barracuda.com (outbound-ip179b.ess.barracuda.com [209.222.82.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D3C9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:31:14 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169]) by mx-outbound41-169.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhAxJmgx8HfN6pCLUb7lYk3rNkWIvPCuDv9q3gCXNNhtsTYx36VMtJeIPA8S32zSF8ThGi5TELQyxEYULR6SdBIQJuUNgu6yyDHVGzfCZjAM2/dio8538s89J/NXHI4LlNsi5kbfka/fR1qTuLwKsCH6twZiVg04ughvHvbLoRODtLp1o0vgN+ZKlg/1GLZuivv4jqpX58CAzqsOeXqKzxuuOcvcvb8SXFipY+jIJE7xuByXsd03SU+V/rNLPgtATh2eww5YtXwGu0AQdH2mDt4GNCDLzSmzIudFfqxVlIM3gxlTAd3GGjCQfpK2ebP4/c2P4AdwZCR4vs1Y7rt9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIh5nX/ob8vu1qPPNB9A3kuJvEzF9x+jhIRj+X2HxjA=;
 b=XWEuLGhiDbCZRrjPpK6yt7r1l6XbohbCZGA0lAT3NxDYN/qfJFlncNHmTmcfMa1Hb66tLgTq1BKnak6PmBGTAFU0lhxpiyPS8qoTVArw7dr334enTkrh1teZqQ3JWqrWgFyh3MqDrFRbZwAk5vKqoWwxrc3272whLsg4Nidor2tkXeK4OJ09th9EAhJTmYL5LN8KuGOaIFLamOdBLQ+v7LuoCeq3Fj9nVqDR9sDDgZwpP6/4+Lz8Zry4EHeMVtENveZ6FO9U6fV8Nl+UAoLp81KSuLRyZzHYLo4QXPMolOPxGWYMilvwynb45OXvHkwhz+ItgnhbajQvoFpPX0On4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIh5nX/ob8vu1qPPNB9A3kuJvEzF9x+jhIRj+X2HxjA=;
 b=eqfNpYLh5BE2AK+nisApJoRu+NBtCG7JWErHwRVyr1Vdjg2kbQfikR4PEFqv2L1rgHbFziSCXe3SrJlZKfwK+mqVjSmTf51Vg5MawyVErHdtze6T2zGtDqD18l0shanIhsAr6r0w466PMPXUUnOV61/ykKpcsrgz+Jwv/rvp42E=
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by PH8PR19MB6665.namprd19.prod.outlook.com (2603:10b6:510:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 18:30:43 +0000
Received: from MW2NAM04FT036.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:505:cafe::6f) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT036.mail.protection.outlook.com (10.13.31.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 18:30:43 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7114620C684E;
	Mon, 23 Oct 2023 12:31:47 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v10 5/8] fuse: Revalidate positive entries in fuse_atomic_open
Date: Mon, 23 Oct 2023 20:30:32 +0200
Message-Id: <20231023183035.11035-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023183035.11035-1-bschubert@ddn.com>
References: <20231023183035.11035-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT036:EE_|PH8PR19MB6665:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3bb46d88-1cbc-47ad-8dc5-08dbd3f62a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Fm7nxlvNsFK3XTQc+aSIX7C4y0jWxKBF6T/SAYnIxfNpf3obDXjuAaHQush1pvaj8s3gxQW231Qb/C5Dht+Im+7/jN6TAhjgKDQI5rHrmXlQ+FCNHv5926d8ptnrLQtbulQ+ePyCHwyjPHAKjPDe8D1PqIunkzDqCiyPKD3JO8+agrCaqYf/74ZeSDXWAYAW/FGfE9JYWNSU1V7uMnceRwL0hFBw9XNyhxs5h7+T+JAaF21tG6v5zd9m27Y0efD0DSyospbvVIv3ADhzDt5lS6h+nyLTzyNJAktcJBDImLIu0Fqze70IKcRylqslMy3luKHhTfeIklLJ4GHlPrhad89ffzT1kg5vrL0uKDD+jdDt5tCv9gQULHlrbmCNCYVRVPKQq/oVB5o8LHxuA+odgBxDRmOez8o+gQB4a9IziNTiKpsZ/vq0rSDbvPAvBDjcEGObdY3pWE5kvItv9MgFJj+R/bBMFFi0WbXLI1xNV4Yki8awtDgnZ4tnaOwDWRq22FVfrmrqkYnRYd8V28wZHYp/A0kqgKPxokocNJaskM0Df7GCFnNTTDZnUhwhw1FzZa4yKfMfgmB3bkgQdP+RWHGkmgqIboEztLCrcME+Lhu6zg0ljIkw7QjTpshmi/TjXND37mmwnOnlCnl6hiW907SQVsS/6Vfa+oUc50Eqk2CyfPh1XuMccn0Do/Sw2Tagj1/Ku9vBCMNxnQuFEKtVOHJKbyMDIbzNidfuYiqWg9cpAr60zF6DceWcVv91IbPfQ1NX5yl7sQDXfuGZN50BZobbQD46kEmzw0ukJduT3E=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39850400004)(136003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(36860700001)(2906002)(41300700001)(81166007)(356005)(54906003)(82740400003)(316002)(6916009)(2616005)(70206006)(70586007)(1076003)(6666004)(478600001)(336012)(40480700001)(47076005)(6266002)(83380400001)(86362001)(5660300002)(36756003)(4326008)(8676002)(8936002)(26005)(21314003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?S+9dRRhwMlhWRNwQTmGBFR674CXuhK+FigzDsknr7WWtbxmAUneMbrQqGutc?=
 =?us-ascii?Q?VkV02BI3+smFNe/nH/jE2I/Eil9GULqEsoojqgKzLs/tWia7RBM+RvYa24gf?=
 =?us-ascii?Q?PBtwZjchVJxrs+fEwOy23cr/0XzCs6Dc/kdeUTYk8jjmyURF5PjHU47HPybg?=
 =?us-ascii?Q?VsPHfIPYnOVxrb7VE0IN2gXvkUkVFt61g2fdUXsWzx6paSz5tHTk7dSBlkzm?=
 =?us-ascii?Q?Oj6JkqsIzhb7fx8ev8arKUGbCMgO7jzRvfe0RDMgCpNfcZRqj4aNw66rNQd3?=
 =?us-ascii?Q?cq2zbmm3Ax8xXS3kuDhLHaPu7w5D1Pnr+K5curJ7KQBIC2W7iFulxnNUZPGQ?=
 =?us-ascii?Q?2JZglPiTggSgcQom90TKVtObJeKh00TIxHW7Q1PfEiTjoHMaw1eIVJVMQUk7?=
 =?us-ascii?Q?9r/8IelLiKyQeyEC6Gu8GHPKDWbAAEKbkLpXuFRQ6cDdIUtICGm5fgdYLfAU?=
 =?us-ascii?Q?T2lTMbo9sfcjg0X+inOhTSrC+OpgWwGVWFFDEPJ8m6NKR+yHxOiFVWjKkVNd?=
 =?us-ascii?Q?bobFui/FArPEvpN2vS+qkNSvqu8RclHJ3OiDZXon/KHX1pKZI87STameLmdM?=
 =?us-ascii?Q?yox2UIjjvBMrMmMjZVqzxqzzrYdNVRfkZJ8V9tj5EWW9rI+35XXYLQOGJQl+?=
 =?us-ascii?Q?oLhPyGZhln/tD+T0bWiWzUvg0S9RUeEnDk2WAI5kLgTdJ/UZHQoJPMjb6U6z?=
 =?us-ascii?Q?Y8gfV2d8Y2Gs8y/XH/PNTJ/fOnjuFzjLJmh5OQCqnol0wQA/I+H0+5JVKETQ?=
 =?us-ascii?Q?s8MuA8OQGa9qEOzOtMEqjj4ipi8r2u4tMm8+UHTotC5nlxqGPgoxqTXA7eix?=
 =?us-ascii?Q?zT5X6beR708uKFTC0WAM9Dp8/uw2LXM2U1yqQDS8+h1Cu39Tjo5tgr+s9xhf?=
 =?us-ascii?Q?lOCGRTNsLCw6sZWV8k+0Yii+yG5fRvOvu12Jm8EcTVsL9tOoedYXjSKnyaq3?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:43.2332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb46d88-1cbc-47ad-8dc5-08dbd3f62a98
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT036.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6665
X-BESS-ID: 1698085868-110665-12449-715-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.56.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpamxgZAVgZQMDnRNNnEzMjIID
	XZItHYxCglMdnI3MjCwsgkxdTUItlCqTYWALQfqnpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan22-113.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

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
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c    | 202 ++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |   3 +
 2 files changed, 176 insertions(+), 29 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 61cdb8e5f68e..17ae788776db 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -220,6 +220,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
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
+		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN) {
+			ret = D_REVALIDATE_ATOMIC;
+			goto out;
+		}
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -270,12 +283,12 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			dput(parent);
 		}
 	}
-	ret = 1;
+	ret = D_REVALIDATE_VALID;
 out:
 	return ret;
 
 invalid:
-	ret = 0;
+	ret = D_REVALIDATE_INVALID;
 	goto out;
 }
 
@@ -763,12 +776,84 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
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
+	if (outentry->nodeid != get_node_id(inode) ||
+	    (bool) IS_AUTOMOUNT(inode) !=
+	    (bool) (outentry->attr.flags & FUSE_ATTR_SUBMOUNT)) {
+		*alloc_inode = 1;
+	} else if (fuse_stale_inode(inode, outentry->generation,
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
+		fuse_change_attributes(inode, &outentry->attr, NULL,
+				       ATTR_TIMEOUT(outentry),
+				       attr_version);
+	}
+
+	if (prev == entry) {
+		/* nothing changed, atomic-open on the server side
+		 * had increased the lookup count - do the same here
+		 */
+		struct fuse_inode *fi = get_fuse_inode(inode);
+
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
 			     struct file *file, unsigned int flags,
 			     umode_t mode)
 {
 	int err;
-	struct inode *inode;
+	struct inode *inode = d_inode(entry);
 	FUSE_ARGS(args);
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	struct fuse_conn *fc = fm->fc;
@@ -780,10 +865,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
@@ -835,36 +917,56 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	err = fuse_simple_request(fm, &args);
 	free_ext_value(&args);
-	if (err == -ENOSYS || err == -ELOOP) {
-		if (unlikely(err == -ENOSYS))
-			fc->no_open_atomic = 1;
-		goto free_and_fallback;
-	}
 
 	if (!err && !outentry.nodeid)
 		err = -ENOENT;
 
-	if (err)
-		goto out_free_ff;
+	if (err) {
+		if (unlikely(err == -ENOSYS)) {
+			fc->no_open_atomic = 1;
+
+			/* Might come up if userspace tricks us and would
+			 * return -ENOSYS for OPEN_ATOMIC after it was
+			 * aready working
+			 */
+			if (unlikely(fc->has_open_atomic == 1))
+				pr_info("fuse server/daemon bug, atomic open "
+					"got -ENOSYS although it was already "
+					"succeeding before.");
+
+			/* This should better never happen, revalidate
+			 * is missing for this entry
+			 */
+			if (WARN_ON_ONCE(d_really_is_positive(entry))) {
+				err = -EIO;
+				goto out_free_ff;
+			}
+			goto free_and_fallback;
+		} else if (err == -ELOOP) {
+			/* likely a symlink */
+			goto free_and_fallback;
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
-			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
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
@@ -879,10 +981,52 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
+				err = -EIO;
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
+				  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
+		if (!inode) {
+			flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+			fuse_sync_release(NULL, ff, flags);
+			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+			err = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	if (d_really_is_negative(entry)) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index af69578763ef..80a1fc6aa103 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -680,6 +680,9 @@ struct fuse_conn {
 	/** Is open atomic not implemented by fs? */
 	unsigned no_open_atomic:1;
 
+	/** Is open atomic is proven to be implemented by fs? */
+	unsigned has_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
-- 
2.39.2


