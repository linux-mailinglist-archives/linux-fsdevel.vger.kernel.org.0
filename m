Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4C732AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjFPJAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjFPI7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D13594
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085945euoutp01e2b503400942e1bb202f5f272d410660~pGA5MOJPt0612706127euoutp01C
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230616085945euoutp01e2b503400942e1bb202f5f272d410660~pGA5MOJPt0612706127euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905985;
        bh=s42QTWpzjdbXRf/v8kr6TgDyip3CoXMlXkBbdLK2j7U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OKiyQCHQmIjhpQj+TNvuzmyxHfcw+okhHXvb9yf23irKWYJOFqaJYt/7Ja4RId3C+
         QnryZviQgeHT2ucAWljCzUFFyhu0lNpbdJjspQIsms3OevmzdkWcKShZmL/eyTQm6i
         innqoZuyoYtR0Ns/HjmNAJmvKhD7X6dnTY6nDcgk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230616085944eucas1p2d5f9f8aa9dcbd4675c8a09472dfa4f47~pGA5BOFX_1074010740eucas1p2f;
        Fri, 16 Jun 2023 08:59:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E2.D4.11320.0842C846; Fri, 16
        Jun 2023 09:59:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085944eucas1p14e8491c53f5390064035de1ffb354c7a~pGA4mPsH91147911479eucas1p1v;
        Fri, 16 Jun 2023 08:59:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085944eusmtrp19ab93ce2c07d0c9d2fa0a23465908f22~pGA4luWLe0890108901eusmtrp1q;
        Fri, 16 Jun 2023 08:59:44 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-6b-648c24803df9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.2B.10549.0842C846; Fri, 16
        Jun 2023 09:59:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085944eusmtip1a55b416dd4f231c839f2978cd016c00f~pGA4cIQMT1526915269eusmtip1T;
        Fri, 16 Jun 2023 08:59:44 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:43 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 8/8] sysctl: replace child with an enumeration
Date:   Fri, 16 Jun 2023 10:59:22 +0200
Message-ID: <20230616085922.3066990-9-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djPc7oNKj0pBr9mmFrs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlvNl2gaVgk3XFwXWrWBoY
        dxp0MXJySAiYSNw4+pO5i5GLQ0hgBaPEg6vTWSGcL4wSvTuesYFUCQl8ZpS4/FkFpmPX9h1s
        EEXLGSWe7tnMBOEAFc1b08II4WxllJjVOoMJpIVNQEfi/Js7zCC2iIC4xInTmxlBbGaBCUBF
        hzhAbGEBR4nO63vA4iwCqhInntxj72Lk4OAVsJXo++wEsVleou36dLASTgE7iceTGthBbF4B
        QYmTM5+wQIyUl2jeOpsZwpaQOPjiBTPIGAkBZYlPzxMgxtRKnNpyiwnCPsIh8X1aJYTtIvF3
        +29WCFtY4tXxLewQtozE6ck9LCBvSQhMZpTY/+8DO4SzmlFiWeNXqEnWEi1XnkB1OEp87d8A
        tZhP4sZbQYh7+CQmbZsOFeaV6GgTmsCoMgvJB7OQfDALyQcLGJlXMYqnlhbnpqcWG+WllusV
        J+YWl+al6yXn525iBCaM0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4l53oShHiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXAtFTk4rovlsVaSu9v3wpU8mn8
        qenAWtMQx11xpKI326zCgI+vtOubasXUXDO59H5jwf4/iTXtWTKnHKT+xP2olzGeq7NDe+md
        S14LW6UvuTLeDt5f5+5p+XntkR/Kihx/AqpPn/O8su23r7RNreQa/lN5gtuKWg02SyXFLU5v
        Fpf1ZpSbdSR66cHj1uY/ixuvv/f8v5Dr46LT/Vya204uLNuae4xD+mzprke3bK7bdGkGHsjT
        U3jPdO3ShnCFC/v01HsFGE/wMtV2Tk38p7vxsbKizFaW+4u7/798rfNoJsMPGW6H4Mp/e7yN
        bpvOOiS2Q1Nw24So1a4bt31veNsYFnZpausUhfl2DlPrOgKUWIozEg21mIuKEwGONotIhwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7oNKj0pBpu+SFjs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlvNl2gaVgk3XFwXWrWBoYdxp0MXJySAiYSOzavoOti5GL
        Q0hgKaPEu73LmCASMhIbv1xlhbCFJf5c64Iq+sgosXPFdEYIZyujxLkN09hBqtgEdCTOv7nD
        DGKLCIhLnDi9mRHEZhaYwCgx6xAHiC0s4CjReX0PWJxFQFXixJN7QL0cHLwCthJ9n50glslL
        tF2fDlbCKWAn8XhSA9h4IaCSxtv9YDavgKDEyZlPWCDGy0s0b53NDGFLSBx88YIZZKSEgLLE
        p+cJECNrJT7/fcY4gVFkFpLuWUi6ZyHpXsDIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw
        nrYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4V12oitFiDclsbIqtSg/vqg0J7X4EKMp0JcTmaVE
        k/OBEZ1XEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cAUfXSpP3vl
        lIkHjTd9CjzcPH/JCbF53glZss0JQosT/2hP83LtqnDl9Hr5NGTWzW8MCc941nY4+NiLWSn8
        3LrmN1uu5PTt5Z1XUjqf/PVODPJd1ZtTf0Z6XblHWv+BopCaPzMVXx9cZ+3xaM22e0I7ppat
        vXWkY15O8dprp/4+OOj4vmrDO/PMJ5M3PVv4lNk4r7Tkjpt+nMgu4Sd3mj932Ik8P+bxlD2D
        N993g9G6X0cYHZlnzY9YPPnBiokR8z2a/Lg7Uy6py1xOUDT5r66+5n7XIYN+mT2ZXvs5JE/X
        awqbbpogx5CT6/SXy679po5O5IHtZ4WnK+Qos4rUR3+rk1/K8inr6LIWqYrI7SeVWIozEg21
        mIuKEwHJp7fEMAMAAA==
X-CMS-MailID: 20230616085944eucas1p14e8491c53f5390064035de1ffb354c7a
X-Msg-Generator: CA
X-RootMTR: 20230616085944eucas1p14e8491c53f5390064035de1ffb354c7a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085944eucas1p14e8491c53f5390064035de1ffb354c7a
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085944eucas1p14e8491c53f5390064035de1ffb354c7a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the effort to remove the empty element at the end of
ctl_table structs. "child" was a deprecated elem in this struct and was
being used to differentiate between two types of ctl_tables: "normal"
and "permanently emtpy".

What changed?:
* Replace "child" with an enumeration that will have two values: the
  default (0) and the permanently empty (1). The latter is left at zero
  so when struct ctl_table is created with kzalloc or in a local
  context, it will have the zero value by default. We document the
  new enum with kdoc.
* Remove the "empty child" check from sysctl_check_table
* Remove count_subheaders function as there is no longer a need to
  calculate how many headers there are for every child
* Remove the recursive call to unregister_sysctl_table as there is no
  need to traverse down the child tree any longer
* Add a new SYSCTL_PERM_EMPTY_DIR binary flag
* Remove the last remanence of child from partport/procfs.c

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c |  1 -
 fs/proc/proc_sysctl.c    | 81 +++++++++-------------------------------
 include/linux/sysctl.h   | 14 ++++++-
 3 files changed, 30 insertions(+), 66 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 0f2d2e1ee28e..4e5b972c3e26 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -387,7 +387,6 @@ parport_device_sysctl_template = {
 			.data		= NULL,
 			.maxlen		= 0,
 			.mode		= 0555,
-			.child		= NULL
 		},
 		{}
 	}
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 07804097f997..c4ea804d862b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,9 +29,8 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-
 struct ctl_table sysctl_mount_point[] = {
-	{ }
+	{.type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY }
 };
 
 /**
@@ -48,21 +47,14 @@ struct ctl_table_header *register_sysctl_mount_point(const char *path)
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
-static bool is_empty_dir(struct ctl_table_header *head)
-{
-	return head->ctl_table[0].child == sysctl_mount_point;
-}
-
-static void set_empty_dir(struct ctl_dir *dir)
-{
-	dir->header.ctl_table[0].child = sysctl_mount_point;
-}
-
-static void clear_empty_dir(struct ctl_dir *dir)
-
-{
-	dir->header.ctl_table[0].child = NULL;
-}
+#define sysctl_is_perm_empty_ctl_table(tptr)		\
+	(tptr[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
+#define sysctl_is_perm_empty_ctl_header(hptr)		\
+	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
+#define sysctl_set_perm_empty_ctl_header(hptr)		\
+	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
+#define sysctl_clear_perm_empty_ctl_header(hptr)	\
+	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_DEFAULT)
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll)
 {
@@ -230,20 +222,22 @@ static void erase_header(struct ctl_table_header *head)
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
+	struct ctl_table_header *dir_h = &dir->header;
 	int err;
 
+
 	/* Is this a permanently empty directory? */
-	if (is_empty_dir(&dir->header))
+	if (sysctl_is_perm_empty_ctl_header(dir_h))
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (header->ctl_table == sysctl_mount_point) {
+	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
-		set_empty_dir(dir);
+		sysctl_set_perm_empty_ctl_header(dir_h);
 	}
 
-	dir->header.nreg++;
+	dir_h->nreg++;
 	header->parent = dir;
 	err = insert_links(header);
 	if (err)
@@ -259,9 +253,9 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	put_links(header);
 fail_links:
 	if (header->ctl_table == sysctl_mount_point)
-		clear_empty_dir(dir);
+		sysctl_clear_perm_empty_ctl_header(dir_h);
 	header->parent = NULL;
-	drop_sysctl_table(&dir->header);
+	drop_sysctl_table(dir_h);
 	return err;
 }
 
@@ -479,7 +473,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &proc_sys_dir_operations;
 		inode->i_fop = &proc_sys_dir_file_operations;
-		if (is_empty_dir(head))
+		if (sysctl_is_perm_empty_ctl_header(head))
 			make_empty_dir_inode(inode);
 	}
 
@@ -1136,9 +1130,6 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 	struct ctl_table *entry;
 	int err = 0;
 	list_for_each_table_entry(entry, table) {
-		if (entry->child)
-			err |= sysctl_err(path, entry, "Not a file");
-
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1465,25 +1456,6 @@ void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 	kmemleak_not_leak(hdr);
 }
 
-static int count_subheaders(struct ctl_table *table)
-{
-	int has_files = 0;
-	int nr_subheaders = 0;
-	struct ctl_table *entry;
-
-	/* special case: no directory and empty directory */
-	if (!table || !table->procname)
-		return 1;
-
-	list_for_each_table_entry(entry, table) {
-		if (entry->child)
-			nr_subheaders += count_subheaders(entry->child);
-		else
-			has_files = 1;
-	}
-	return nr_subheaders + has_files;
-}
-
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
@@ -1546,28 +1518,11 @@ static void drop_sysctl_table(struct ctl_table_header *header)
  */
 void unregister_sysctl_table(struct ctl_table_header * header)
 {
-	int nr_subheaders;
 	might_sleep();
 
 	if (header == NULL)
 		return;
 
-	nr_subheaders = count_subheaders(header->ctl_table_arg);
-	if (unlikely(nr_subheaders > 1)) {
-		struct ctl_table_header **subheaders;
-		int i;
-
-		subheaders = (struct ctl_table_header **)(header + 1);
-		for (i = nr_subheaders -1; i >= 0; i--) {
-			struct ctl_table_header *subh = subheaders[i];
-			struct ctl_table *table = subh->ctl_table_arg;
-			unregister_sysctl_table(subh);
-			kfree(table);
-		}
-		kfree(header);
-		return;
-	}
-
 	spin_lock(&sysctl_lock);
 	drop_sysctl_table(header);
 	spin_unlock(&sysctl_lock);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 653b66c762b1..59d451f455bf 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -137,7 +137,17 @@ struct ctl_table {
 	void *data;
 	int maxlen;
 	umode_t mode;
-	struct ctl_table *child;	/* Deprecated */
+	/**
+	 * enum type - Enumeration to differentiate between ctl target types
+	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
+	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
+	 *                                       empty directory target to serve
+	 *                                       as mount point.
+	 */
+	enum {
+		SYSCTL_TABLE_TYPE_DEFAULT,
+		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
+	} type;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;
@@ -229,7 +239,7 @@ extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
-extern struct ctl_table sysctl_mount_point[];
+#define SYSCTL_PERM_EMPTY_DIR	(1 << 0)
 
 #else /* CONFIG_SYSCTL */
 
-- 
2.30.2

