Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE977E3B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbjHPOe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjHPOeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:34:10 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEF2715
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:54 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174]) by mx-outbound10-11.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA8/ns7u4T0c08E9VInPqS0DtTS4Y1PAOkDz8BcqSWxFqaoUEOzc04YhDdtZKaFCcDexEJIOTuQFZbDNpW1hCl1g//9iMSsUMjeI3W4JqNbZUqDAI7TUhpVTruy39BwZhtTJZ3bUoVpart1qb02BFMf4lSvyE2xhq+DeSiWirljYsNVX9gjdFA5CcPUUFEQ8zXsE48VxQA4BIJlG6qR7S3IYKF6jV1J3qvNP9TUWvRYn+Xodh5Rq9RrmQmS3LfxFR/nkxLAXF2GMR0IscZfN7bPcfWbQ4RTJdHm6tqQuEm4Dw4AB7ayHnW3jrP3xKCagvUQ9rBBv8Nt1wSRq1/0AbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sViZTQPtLMzKO0no/8MkkD59+kLqtQUdq5qBlCKaXvo=;
 b=XIdupKgCPP1AI8KKfJXhBSWRZfvwksHXdugEE0+Z+fVULHojT6d8eAvlvY1MgdgGG74UxLeb4y3KSqVOHWF/2bMptdcCllSqhjWqz0+D+jTSmSbMCLCpF2nfrdM4rvysdumKRTIxbuaPCeyK8J8yE6vuE4QfZHOjVOvz+HXpBPsprGo9Z5VGBhPhEPf1mpHxDDP81VE7NMFzlX7iVsitkK7apn4+M2oIGeD6uwzlbmtscDYsRxCKG/M4AMpRYTY46SBVCFbk2tRH4uhZ0BYB4Kw34CX8/n6Y+rrUOl0WWl3+sYXKub9XJOAKbOim05JN+jrBGyNr1Ki2K9DjCjvMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sViZTQPtLMzKO0no/8MkkD59+kLqtQUdq5qBlCKaXvo=;
 b=mSsDAf0KcPqIWQaQT7Tic3mdY4XZxlxw9r7FyrSjHKLhQD20S/7T8mWeXs/I36w8DWoEZ3rasupVPIf5oT1weAnA9tbIeJmxyaRYA6+7nv7DJZ5c8L9lZZVnyZWkg3cfReusiW1Q7CXaiR3yJBhXUPYkjQtWPXqYegtm/V6P9gk=
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by PH8PR19MB6812.namprd19.prod.outlook.com (2603:10b6:510:1bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:33:31 +0000
Received: from DM6NAM04FT006.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::8e) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT006.mail.protection.outlook.com (10.13.158.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.17 via Frontend Transport; Wed, 16 Aug 2023 14:33:31 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id D07F420C684B;
        Wed, 16 Aug 2023 08:34:36 -0600 (MDT)
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
Date:   Wed, 16 Aug 2023 16:33:11 +0200
Message-Id: <20230816143313.2591328-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143313.2591328-1-bschubert@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT006:EE_|PH8PR19MB6812:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bde91da7-eec1-4a5b-812f-08db9e65c370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NXQU9U0xdZESdZaqZ5f890paddp0jVTCnVMR203gytVoR0YHdf1C00gyRfOlQhnqMHP7GymgFWCzWZvkYf2WBk/30AAJZu5KSJMmtlQj2De6HA+eXceZaoArfaHc5kcDF9/+uBxQ0oam7shbbTPzTuhYD8zhSElfdCtpiCADPgDlApN7/tLFXREZUPhE8zCEgEPNnDf9BsDjiabrKcd4B0YJiLxHBTBmjfSo0zQvQDkq4u/3jSBjJzA/Qwt7cAysYpr6ER9s8qmZpheuEHFP3VJ4xbbAUOVEoC4lVL4a3znkqOuiwpZWwgXNtjq2dGc1yMlNiY2wJiL7q23UaYV1Oa3x4605rBlc9mAkOsSCipt4qas0VvZ2TQcYz504ZzlRHnGwTrhyUfpCkqL1hmmqxLcMu6od/7N30+/PK8LAkHUwNii6+ubCD/2/s4PYOHMbKpOX/1B1vA2OIopY4qAUhOTp0z1K3hhm+fjqwALd2kZcxT5JOxfEcQCrSKgVWvG/X0PZ6l+UsXisDL6ulMbW8feVd00dAvZWj8PPbO3JL3qGaWan6KIuaFXCTPAQC6i7tuFwM48d6cuhlDuWfHYwNq73NTKTG+aCud8H7OVT0qUJ+9M6cjqQGtwiCWnr3lVulbJcedPYueaDtOj5e2+LxZTox3g8FFXopy8kATYG9sgvCtMaS94NrBsdaN7LAOJanoQB9toBJMpeyvbCeUDcYM1c+8YAmV9najmub2GMAxTBKWXpfduuYVraw5NNz75g9xmcY73+ZIHAnyJCoJ4QvJMQuI0mcb3sv/W9RA/28k=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(21314003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LegsrYyskpUNKTlthwq8iqtDwxvksqvBjELMMmgMOro2ueVV77wblstYjOiA?=
 =?us-ascii?Q?PArfiEDHJ8xI0JriMsXhIy8ay/NlnMNQS+WozR1KIHbKCiQ0Mn3tDQO3FGRS?=
 =?us-ascii?Q?VHNy13iNN6vYjU0iBjtCwxVPrU0uQHs29GfJsa3W9saQpaRHl3SQxq1soKzf?=
 =?us-ascii?Q?9cuWLB0a6VLgdOlYKAWu2mlq4ZZ4SvuAQsPPebmhCyb7lux4mgpe9o6jVLdX?=
 =?us-ascii?Q?QiQF80v2S0kqvCHbVZNrrJNbd+0STd6nsX4F8biObdeFllwmpYCWQJNEqTpJ?=
 =?us-ascii?Q?53w7Q7mLgsft/n47FNrBe8znb89s49edyy1Yor+CtYy/718k+9HqLEIbVz5o?=
 =?us-ascii?Q?3DQv4o5fMg6tg5ZRDu37G/WSGpOwG8Qb3H05OudYuzD4m82nQ829UDFYG1V9?=
 =?us-ascii?Q?OCAsvbY6L+Vlgvws3loq48d95+8jXUgDyTGnBb072H4s0sGqckGD1/Eao110?=
 =?us-ascii?Q?+3NvkXLUIb297IgsTkpzYL+wRuUguXWTum7l4wEu+JTcj/tW8CzxT6h/Zu0n?=
 =?us-ascii?Q?VCKHDfK/iNS42gA0G/Oq2uwE7SbhMajacPJv1WATkBtT2allJmSBZOyIIsrF?=
 =?us-ascii?Q?oDLEelwyIAUS/b8tusHhXhiIVZ1GmeFYPuBXCSNSoLYGbqqVLEnNL7iPLis5?=
 =?us-ascii?Q?hB7RH8zTLkLmh24ZegAvYUtWLlWrVmNoY32+fZOwdzMhSWliTJqSK8O6lIO4?=
 =?us-ascii?Q?oyEE2dr6x30MV7cfITCVwKYDWMqHZTc569yFLgLhjFuHXfnWL4ewN5hwWM3a?=
 =?us-ascii?Q?hcKCOANbw2cCgb9x6MM0JDCoOlSiOASpMwnrgrrTaWbCp6x3OXmqwf/EZtuH?=
 =?us-ascii?Q?3Le5QkNVZo3ViB82ug9jmvLy7dNhUkX+ZrxMEfNAMeNsfrSINrus94CdvcWX?=
 =?us-ascii?Q?RCet/BfyXYIDsJSME0sS/KReau9ua6ENLw8+C/HsvrzALXMsf/Am7y9e7R2R?=
 =?us-ascii?Q?/B426ytK88E54oF+vJ1e0eLJ6eQGwtCvmpj9LUQ5T1ElS3qrqvgedkyBBV8d?=
 =?us-ascii?Q?4gNs?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:31.0091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde91da7-eec1-4a5b-812f-08db9e65c370
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT006.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6812
X-BESS-ID: 1692196415-102571-12363-1283-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.55.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmluZAVgZQ0DzJ2NTIMCUlzT
        Q10dIoxdIyxdjSwDAtyTgpLcXUwMRQqTYWABrkHwZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan20-0.us-east-2b.ess.aws.cudaops.com]
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
 fs/fuse/dir.c    | 204 ++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |   3 +
 2 files changed, 177 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bb68d911fd80..701f9c51cdb1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -230,6 +230,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
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
@@ -280,12 +293,12 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
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
 
@@ -769,12 +782,84 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
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
 			     struct file *file, unsigned flags,
 			     umode_t mode)
 {
 	int err;
-	struct inode *inode;
+	struct inode *inode = d_inode(entry);
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	struct fuse_conn *fc = fm->fc;
 	FUSE_ARGS(args);
@@ -786,10 +871,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
@@ -841,37 +923,57 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
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
@@ -885,10 +987,52 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
index 4e2ebcc28912..6a35f109d214 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -675,6 +675,9 @@ struct fuse_conn {
 	/** Is open atomic not impelmented by fs? */
 	unsigned no_open_atomic:1;
 
+	/** Is open atomic is proven to be implemented by fs? */
+	unsigned has_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
-- 
2.37.2

