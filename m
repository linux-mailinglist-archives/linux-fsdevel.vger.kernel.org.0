Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF0779727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjHKSjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjHKSjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:39:02 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731230E8
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:39:02 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175]) by mx-outbound46-215.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdlF8t4+bGQPhO3ZHjRoLGqo9jXpyFCivgcPHQbc7z1XHMC0sydpkHcldEZN9SO6sn1Y7qc7Bse/DNTUztvQIVtbYlfXp2wn7z9IV9CEsEKxk0W2ENBo/5E8wmZ5IbfrlE1y0/cSc7rgGcbr80joAX1vgGFkEyhugmUFy44jgrwmmxdPKxwLtS30Ls3RC//6ZEOIShn0d6LjShMhsKL0NsDSnPn2pZItju6LTAqfj8dBvLBsoBrqbqV/OwsqjF2ofbntutGmwE5YbxTcj4U1MC2sfNd3c43nhCh42yIio7tROSC0KqsyDywiqS8ECKB9tGt8kMyaBt4Ef1zZ1zphgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc0gZidMxZAsC9qVDHsL4I2niulPDO0WSv/kjqbSjBk=;
 b=ZVPD6+Zzt13XjAMzM9rsWypz0m7g3zn2FSnhxPIkn++W8x8V7dhC2MGjSedmL6XWy2qGgNb4hMgwljpfletux5yGF01yzPmkf96dlq26CvYda0Nu1nW7lzC2iCboccrM3hvqwachik6X8kwh0TEpxGHc6BUP3qg/BRzek+IBwNvcbfhIsj7TZnN4jPtnJVJRCRObXhJOkDBSzKIVkhymB5u8FuOyZzp5m3StPtgcc3/6qJ2Tufr2iPcjCJtrN4Y3EOzE1dQG8rRqTeXFW+IypMe0UUjCIae3Bojds8bpkknBYCoy8tz2Fc/Haw9FUXhDzMeI6j1EZv20KLEStaiJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc0gZidMxZAsC9qVDHsL4I2niulPDO0WSv/kjqbSjBk=;
 b=0yXm37mSFg6QeF7+qWUVBTl7yNUvNRPS2X6Q1qZQVOULsLXkaOJqP8ucENB2sTgOOGj4b1B562ROMPntErqFACN6veSsTiuVnvEeTGTsqpXgrV83103bL5H2rA0iNCvyRTTrWwpmIP7upUBNu3brvWnc5frXbMJM0iR4vD2k5E4=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by PH0PR19MB5504.namprd19.prod.outlook.com (2603:10b6:510:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:38:28 +0000
Received: from MW2NAM04FT062.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::2) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT062.mail.protection.outlook.com (10.13.31.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.10 via Frontend Transport; Fri, 11 Aug 2023 18:38:28 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7F54A20C684B;
        Fri, 11 Aug 2023 12:39:33 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 3/6] [RFC] Allow atomic_open() on positive dentry
Date:   Fri, 11 Aug 2023 20:37:49 +0200
Message-Id: <20230811183752.2506418-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811183752.2506418-1-bschubert@ddn.com>
References: <20230811183752.2506418-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT062:EE_|PH0PR19MB5504:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ba2034b-9d18-4472-40b0-08db9a9a27cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAq5FRTS0PV5gE1gBdU+rVvn4Gx8LqwugdtkCDnzEi8Cd6RU3F90Q45Uhm8VBj5+F7P6x6dN/6cnZ9+Jh9TERLW8q6D1vVIQMYXehNOdN+0RHnePMz56RJ5KafcLUOLocJKWqbNFbDQSe0r64x5E83z/QMYc0EeHPAcsgsC6KxK/GTfJcenJYexdt7h223HO9Q6i8FWjkAzqR4vBj67w77KS4rT6RTVmZf3Fi1QuQ+/KqONHh1NXpr5WMXs/2XUo/xDEJNbsUSd6zhhYk5qbDPucISMDeNuvkxJMebcVAcrtRL8sJvQeKO0P3yhFIP4BUBhB4lGQM9X4Oy38cailY+aEB+WqP/aGvfzG8/7FRtw7PPdOkoyoj13cr3QVE6saQjWPf/0PvK6LJXJoXZVvkZ7+asz0O9+QKTygvnvJfkZji371oFQ/gxfmb+2wwvhT2n04V+yIi88k6du1fttrDZhke6tsKg35y3kgkZ9+V/t7jUMjd5K5OKIGG0KsGBLAOGojbbGC7ZQc3ay21XZA0VbzYSKnuMwer+/cFk5wIlcphIFglKFGrRlpTK0fbPbsuAdbwF8+FUCgailkhfZtiPxkzlY+zyjjx+Y6bNqXivBUVgkUVvE4hRBtysVLCng07irlxg+xEr1W4TGGodcKo8u+sjubcwxgsa5n4x8H6e8U4O6NfnKi7pze099Y7xrb0vFt0snoX84+/HteCCW5Eh1KZMQg/GRY0ndPvaTUB4FeHtt0AafXphFfsw5kd2JF
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(376002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(36840700001)(83380400001)(8676002)(2906002)(2616005)(41300700001)(47076005)(36756003)(336012)(6266002)(40480700001)(5660300002)(1076003)(36860700001)(26005)(8936002)(86362001)(54906003)(82740400003)(6666004)(70206006)(478600001)(81166007)(356005)(316002)(4326008)(6916009)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JP/VzyqUjDykciOBSMpk43VIM/OwVjJkUv6CuzfaTG/N/V0L4NSAhohdZ8iq?=
 =?us-ascii?Q?7iTZPPAerVz64QEEbj6eIxtO+8d6oovoe6ChMciFugj4+KU2+E8q/XOgC4DQ?=
 =?us-ascii?Q?962qHVeRywSDTAF6bks0pEUTyZx1zsniIYyL8UjadzaZPlQEFv50C1cfsILC?=
 =?us-ascii?Q?LGq7wHKYBqPLHhGPENk4nX0EzAKdNxhAyFIpJaGQ0w8lJ7boelwvgY4blHai?=
 =?us-ascii?Q?M2XQuH6fACtrE/C8JtImupopvLuMv3biAWAEIENsfRjCXkxZZWdYp2K02W43?=
 =?us-ascii?Q?8wsfRkrtB4hJx3Z0tiDU78w2xTB3gddYHg+WVkonddizoNyyztzIfXngvehl?=
 =?us-ascii?Q?BnVpTa7Ie0mAeWf1q407eGioGhJheFtd5fqniKioiu1pDnFdHQe/ktqcZRt3?=
 =?us-ascii?Q?a1AX9/D621TR91HofxZf5EC8IGQiHqT54XGrPdbDCjaZUVahHNWxhK0ItVPd?=
 =?us-ascii?Q?s3AQxf9ntXkrmUV6JUvI/s7FspPPS6mlhiAK1SMahE6G2EpgyMp3Cw0WUM3d?=
 =?us-ascii?Q?gH/m1mK43MxwIeBPBSxZvFen3WvH2uhNVMedRl62HtFCzLePFsXBjHLpfjp1?=
 =?us-ascii?Q?2qdcp4viNFWlGtQ06wOqh1Dsp4lkxshQ9+o3ZQv8uirCus2ZfiIFtLn7ejuR?=
 =?us-ascii?Q?N34bfsXX7+/SD9Fmnuc+D3ILIgRLd9kwurMOX7mRFUrvdj1PlFzLQ7R1sEmd?=
 =?us-ascii?Q?LA+5F63vgAnjlSFuGFKfrd9sJEPtRQBxlLTc6+mN7ZXjbvxutZm0L77cN6LZ?=
 =?us-ascii?Q?ql6N5g/iKv1HDzNH3fQSr6a6vIb24dRQfacCQXoSDnTSXP75vKrF4zxk/luo?=
 =?us-ascii?Q?QlIDrUY2Vw59KJv3fk0jNeaAe4OBmLSSqew9bRG6tUWcwxkhgsMGLZ6BMtB8?=
 =?us-ascii?Q?6WSNv95KD4n3WAgOe5HAo/dEjlYnnziFnD4WxSw1Tk9T0WwyMwDUf2R4f1Ay?=
 =?us-ascii?Q?rw5O/VRCUjjuvTJemGpRtzOMumvzfdkM/KzG0e0P76B+zmbpHwIuSpPDA94Q?=
 =?us-ascii?Q?iVW4?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:28.5810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba2034b-9d18-4472-40b0-08db9a9a27cf
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT062.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5504
X-BESS-ID: 1691779110-111991-4730-9748-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.55.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGhpZAVgZQ0DLV2MAwJS3VMN
        kASKQkGhgnJ5sYmhqlpBqkmZqYpCjVxgIA5uQW2UEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan21-52.us-east-2b.ess.aws.cudaops.com]
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

From: Miklos Szeredi <miklos@szeredi.hu>

atomic_open() will do an open-by-name or create-and-open
depending on the flags.

If file was created, then the old positive dentry is obviously
stale, so it will be invalidated and a new one will be allocated.

If not created, then check whether it's the same inode (same as in
->d_revalidate()) and if not, invalidate & allocate new dentry.

Changes from Miklos initial patch (by Bernd):
- LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
  calls into the file system when revalidate by atomic open is
  supported - this is to avoid that ->d_revalidate() would skip
  revalidate and set DCACHE_ATOMIC_OPEN, although vfs
  does not supported it in the given code path (for example
  when LOOKUP_RCU is set)).
- Support atomic-open-revalidate in lookup_fast() - allow atomic
  open for positive dentries without O_CREAT being set.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c          |  5 ++---
 fs/namei.c             | 17 +++++++++++++----
 include/linux/dcache.h |  6 ++++++
 include/linux/namei.h  |  1 +
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c02b63fe91ca..8ccd49d63235 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -380,7 +380,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (name->len > FUSE_NAME_MAX)
 		goto out;
 
-
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -771,8 +770,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 }
 
 static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned flags,
-			    umode_t mode)
+			     struct file *file, unsigned flags,
+			     umode_t mode)
 {
 
 	int err;
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..5dae1b1afd0e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1643,12 +1643,14 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 			return ERR_PTR(-ECHILD);
 		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
-			status = d_revalidate(dentry, nd->flags);
+			status = d_revalidate(dentry,
+					      nd->flags | LOOKUP_ATOMIC_REVALIDATE);
 	} else {
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
 			return NULL;
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(dentry,
+				      nd->flags | LOOKUP_ATOMIC_REVALIDATE);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
@@ -1656,6 +1658,12 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		dput(dentry);
 		return ERR_PTR(status);
 	}
+
+	if (unlikely(d_atomic_open(dentry))) {
+		dput(dentry);
+		return NULL;
+	}
+
 	return dentry;
 }
 
@@ -3421,7 +3429,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (d_in_lookup(dentry))
 			break;
 
-		error = d_revalidate(dentry, nd->flags);
+		error = d_revalidate(dentry,
+				     nd->flags | LOOKUP_ATOMIC_REVALIDATE);
 		if (likely(error > 0))
 			break;
 		if (error)
@@ -3430,7 +3439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dput(dentry);
 		dentry = NULL;
 	}
-	if (dentry->d_inode) {
+	if (dentry->d_inode && !d_atomic_open(dentry)) {
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..f90eec22691c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -208,6 +208,7 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
+#define DCACHE_ATOMIC_OPEN		0x08000000 /* Always use ->atomic_open() to open this file */
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
@@ -496,6 +497,11 @@ static inline bool d_is_fallthru(const struct dentry *dentry)
 	return dentry->d_flags & DCACHE_FALLTHRU;
 }
 
+static inline bool d_atomic_open(const struct dentry *dentry)
+{
+       return dentry->d_flags & DCACHE_ATOMIC_OPEN;
+}
+
 
 extern int sysctl_vfs_cache_pressure;
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1463cbda4888..7eec6c06b192 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -33,6 +33,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_CREATE		0x0200	/* ... in object creation */
 #define LOOKUP_EXCL		0x0400	/* ... in exclusive creation */
 #define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
+#define LOOKUP_ATOMIC_REVALIDATE  0x1000 /* atomic revalidate possible */
 
 /* internal use only */
 #define LOOKUP_PARENT		0x0010
-- 
2.34.1

