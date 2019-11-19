Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0833F101A2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKSHOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:11 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41578 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKSHOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:10 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191119071406epoutp01f5fa081128baccbc3d392fbe3cc6c8e3~YfvGsCndi1802418024epoutp01H
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191119071406epoutp01f5fa081128baccbc3d392fbe3cc6c8e3~YfvGsCndi1802418024epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147646;
        bh=UynEUjd2J6AJBENA5flggnmE+/uNET28DrdikmIOav4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1vCFYY94cHt9jqqcMjtsI1J/DykWb5TkouRWBStOt1+9bil3CcTsysUlO4Q51XXR
         Wv88Gq9ndOhEiyMCQvIt/p1HpUnHcw60Ti9cWjMQwsNAzvh4UifUFcDS15ltX9may8
         PnYvNHJzj0XPBlEPblG81gRHhSn1WvupZCWfEyRs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191119071405epcas1p434f8cc76020feb71c46eaed930f48990~YfvGYoeia0493704937epcas1p4M;
        Tue, 19 Nov 2019 07:14:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HHB46XVSzMqYlh; Tue, 19 Nov
        2019 07:14:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.7D.04406.C3693DD5; Tue, 19 Nov 2019 16:14:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6~YfvFJip3O0222302223epcas1p4a;
        Tue, 19 Nov 2019 07:14:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119071404epsmtrp2b594ed25b8fea1e72f6c38494b3e975c~YfvFIzWJD0193901939epsmtrp2L;
        Tue, 19 Nov 2019 07:14:04 +0000 (GMT)
X-AuditID: b6c32a38-95fff70000001136-e4-5dd3963c3feb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.14.03654.C3693DD5; Tue, 19 Nov 2019 16:14:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071404epsmtip1429b751e4b34d8faa6c3577b942922de~YfvE_XEYb1281112811epsmtip1a;
        Tue, 19 Nov 2019 07:14:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 05/13] exfat: add file operations
Date:   Tue, 19 Nov 2019 02:10:59 -0500
Message-Id: <20191119071107.1947-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmrq7NtMuxBgfWGVo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGh
        QYFecWJucWleul5yfq6VoYGBkSlQZUJOxuM7JxgLfvhUvNr9kK2B8ZhtFyMnh4SAicS7p50s
        XYxcHEICOxgl3hz6wQjhfGKU6OlsZ4ZwvjFKdB/Zww7T8nHhKjYQW0hgL6PEk14mCBuoY2ur
        fhcjBwebgLbEny2iIGERAXuJzbMPgG1gFtjMKPFw01IWkIQw0Jz2CV1gc1gEVCUWLp7FCGLz
        ClhLvNnTwAKxS15i9YYDzCA2p4CNRP+87+wggyQEDrBJPG2aB1XkItE87yczhC0s8er4FqhD
        pSQ+v9vLBnKQhEC1xMf9UCUdjBIvvkO9byxxc/0GVpASZgFNifW79CHCihI7f88FO4dZgE/i
        3dceVogpvBIdbUIQJaoSfZcOM0HY0hJd7R+glnpILJs3lw0SbP2MEl1r/7BOYJSbhbBhASPj
        Kkax1ILi3PTUYsMCE+T42sQITnhaFjsY95zzOcQowMGoxMN7QuVyrBBrYllxZe4hRgkOZiUR
        Xr9HF2KFeFMSK6tSi/Lji0pzUosPMZoCA3Iis5Rocj4wGeeVxBuaGhkbG1uYmJmbmRorifNy
        /LgYKySQnliSmp2aWpBaBNPHxMEp1cBYl8vc9HbDwxM5yfM/Hd2cc2pW7cSUNPG8T+GGz3oW
        /V+cGpgt2iJ11fDGjby/+51uGP86I/VOde+7w7XGeedmP3OxOWHfFR9/0GrbqS8GElNnS8sZ
        1Z+WnTBHe/IuDRUPqWO7/vnPcDEoWDQh+G9n1gK97LrS7R/fyFaz/P0WaJX5YuHdWWLrlViK
        MxINtZiLihMBdomq744DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK7NtMuxBgvPylg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK+PxnROMBT98Kl7tfsjWwHjM
        touRk0NCwETi48JVbF2MXBxCArsZJdouHWOCSEhLHDtxhrmLkQPIFpY4fLgYouYDo8SdKWfY
        QOJsAtoSf7aIgpSLCDhK9O46zAJSwwwyZ8v0X4wgCWGgBe0TuthAbBYBVYmFi2eBxXkFrCXe
        7GlggdglL7F6wwFmEJtTwEaif953dhBbCKhm86IlrBMY+RYwMqxilEwtKM5Nzy02LDDMSy3X
        K07MLS7NS9dLzs/dxAgOTS3NHYyXl8QfYhTgYFTi4T2hcjlWiDWxrLgy9xCjBAezkgiv36ML
        sUK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwsk1K68la
        8tDj//wwgWMMfVGXJeVXPmWfOf/Lw9Untn44z3ThQMLHopmHfq7tl1hyaFHwuvvz2LVfl266
        u3aSzYlnLBPfuEpGTZnClqdreyf96g6Frzt4soyUd15XV+H49EG+cuXd8E92+yfP/C/DvlZw
        jbZoigwnm8Il98Cnlv/FJ0wwfvLIYIMSS3FGoqEWc1FxIgD/gjWmSQIAAA==
X-CMS-MailID: 20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of file operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/file.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 fs/exfat/file.c

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
new file mode 100644
index 000000000000..5afd65a36eb5
--- /dev/null
+++ b/fs/exfat/file.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+static int exfat_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t start = i_size_read(inode), count = size - i_size_read(inode);
+	int err, err2;
+
+	err = generic_cont_expand_simple(inode, size);
+	if (err)
+		return err;
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	mark_inode_dirty(inode);
+
+	if (!IS_SYNC(inode))
+		return 0;
+
+	err = filemap_fdatawrite_range(mapping, start, start + count - 1);
+	err2 = sync_mapping_buffers(mapping);
+	if (!err)
+		err = err2;
+	err2 = write_inode_now(inode, 1);
+	if (!err)
+		err = err2;
+	if (err)
+		return err;
+
+	return filemap_fdatawait_range(mapping, start, start + count - 1);
+}
+
+static int exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode *inode)
+{
+	mode_t allow_utime = sbi->options.allow_utime;
+
+	if (!uid_eq(current_fsuid(), inode->i_uid)) {
+		if (in_group_p(inode->i_gid))
+			allow_utime >>= 3;
+		if (allow_utime & MAY_WRITE)
+			return 1;
+	}
+
+	/* use a default check */
+	return 0;
+}
+
+static int exfat_sanitize_mode(const struct exfat_sb_info *sbi,
+		struct inode *inode, umode_t *mode_ptr)
+{
+	mode_t i_mode, mask, perm;
+
+	i_mode = inode->i_mode;
+
+	if (S_ISREG(i_mode) || S_ISLNK(i_mode))
+		mask = sbi->options.fs_fmask;
+	else
+		mask = sbi->options.fs_dmask;
+
+	perm = *mode_ptr & ~(S_IFMT | mask);
+
+	/* Of the r and x bits, all (subject to umask) must be present.*/
+	if ((perm & 0555) != (i_mode & 0555))
+		return -EPERM;
+
+	if (exfat_mode_can_hold_ro(inode)) {
+		/*
+		 * Of the w bits, either all (subject to umask) or none must
+		 * be present.
+		 */
+		if ((perm & 0222) && ((perm & 0222) != (0222 & ~mask)))
+			return -EPERM;
+	} else {
+		/*
+		 * If exfat_mode_can_hold_ro(inode) is false, can't change
+		 * w bits.
+		 */
+		if ((perm & 0222) != (0222 & ~mask))
+			return -EPERM;
+	}
+
+	*mode_ptr &= S_IFMT | perm;
+
+	return 0;
+}
+
+/* resize the file length */
+int __exfat_truncate(struct inode *inode, loff_t new_size)
+{
+	unsigned int num_clusters_new, num_clusters_phys;
+	unsigned int last_clu = FREE_CLUSTER;
+	struct exfat_chain clu;
+	struct exfat_timestamp tm;
+	struct exfat_dentry *ep, *ep2;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_entry_set_cache *es = NULL;
+	int evict = (ei->dir.dir == DIR_DELETED) ? 1 : 0;
+
+	/* check if the given file ID is opened */
+	if (ei->type != TYPE_FILE && ei->type != TYPE_DIR)
+		return -EPERM;
+
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+
+	num_clusters_new = EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi);
+	num_clusters_phys =
+		EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk, sbi);
+
+	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags);
+
+	if (new_size > 0) {
+		/*
+		 * Truncate FAT chain num_clusters after the first cluster
+		 * num_clusters = min(new, phys);
+		 */
+		unsigned int num_clusters =
+			min(num_clusters_new, num_clusters_phys);
+
+		/*
+		 * Follow FAT chain
+		 * (defensive coding - works fine even with corrupted FAT table
+		 */
+		if (clu.flags == 0x03) {
+			clu.dir += num_clusters;
+			clu.size -= num_clusters;
+		} else {
+			while (num_clusters > 0) {
+				last_clu = clu.dir;
+				if (exfat_get_next_cluster(sb, &(clu.dir)))
+					return -EIO;
+
+				num_clusters--;
+				clu.size--;
+			}
+		}
+	} else {
+		ei->flags = 0x03;
+		ei->start_clu = EOF_CLUSTER;
+	}
+
+	i_size_write(inode, new_size);
+
+	if (ei->type == TYPE_FILE)
+		ei->attr |= ATTR_ARCHIVE;
+
+	/* update the directory entry */
+	if (!evict) {
+		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
+				ES_ALL_ENTRIES, &ep);
+		if (!es)
+			return -EIO;
+		ep2 = ep + 1;
+
+		exfat_set_entry_time(ep, exfat_tm_now(EXFAT_SB(sb), &tm),
+				TM_MODIFY);
+		ep->file_attr = cpu_to_le16(ei->attr);
+
+		/* File size should be zero if there is no cluster allocated */
+		if (ei->start_clu == EOF_CLUSTER)
+			ep->stream_valid_size = ep->stream_size = 0;
+		else {
+			ep->stream_valid_size = cpu_to_le64(new_size);
+			ep->stream_size = ep->stream_valid_size;
+		}
+
+		if (new_size == 0) {
+			/* Any directory can not be truncated to zero */
+			WARN_ON(ei->type != TYPE_FILE);
+
+			ep2->stream_flags = 0x01;
+			ep2->stream_start_clu = FREE_CLUSTER;
+		}
+
+		if (exfat_update_dir_chksum_with_entry_set(sb, es,
+		    inode_needs_sync(inode)))
+			return -EIO;
+		kfree(es);
+	}
+
+	/* cut off from the FAT chain */
+	if (ei->flags == 0x01 && last_clu != FREE_CLUSTER &&
+			last_clu != EOF_CLUSTER) {
+		if (exfat_ent_set(sb, last_clu, EOF_CLUSTER))
+			return -EIO;
+	}
+
+	/* invalidate cache and free the clusters */
+	/* clear exfat cache */
+	exfat_cache_inval_inode(inode);
+
+	/* hint information */
+	ei->hint_bmap.off = EOF_CLUSTER;
+	ei->hint_bmap.clu = EOF_CLUSTER;
+	if (ei->rwoffset > new_size)
+		ei->rwoffset = new_size;
+
+	/* hint_stat will be used if this is directory. */
+	ei->hint_stat.eidx = 0;
+	ei->hint_stat.clu = ei->start_clu;
+	ei->hint_femp.eidx = EXFAT_HINT_NONE;
+
+	/* free the clusters */
+	if (exfat_free_cluster(inode, &clu))
+		return -EIO;
+
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+
+	return 0;
+}
+
+void exfat_truncate(struct inode *inode, loff_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int blocksize = 1 << inode->i_blkbits;
+	loff_t aligned_size;
+	int err;
+
+	mutex_lock(&sbi->s_lock);
+	if (EXFAT_I(inode)->start_clu == 0) {
+		/*
+		 * Empty start_clu != ~0 (not allocated)
+		 */
+		exfat_fs_error(sb, "tried to truncate zeroed cluster.");
+		goto out;
+	}
+
+	err = __exfat_truncate(inode, i_size_read(inode));
+	if (err)
+		goto out;
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	if (IS_DIRSYNC(inode))
+		exfat_sync_inode(inode);
+	else
+		mark_inode_dirty(inode);
+
+	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
+			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+out:
+	aligned_size = i_size_read(inode);
+	if (aligned_size & (blocksize - 1)) {
+		aligned_size |= (blocksize - 1);
+		aligned_size++;
+	}
+
+	if (EXFAT_I(inode)->i_size_ondisk > i_size_read(inode))
+		EXFAT_I(inode)->i_size_ondisk = aligned_size;
+
+	if (EXFAT_I(inode)->i_size_aligned > i_size_read(inode))
+		EXFAT_I(inode)->i_size_aligned = aligned_size;
+	mutex_unlock(&sbi->s_lock);
+}
+
+int exfat_getattr(const struct path *path, struct kstat *stat,
+		unsigned int request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+
+	generic_fillattr(inode, stat);
+	stat->blksize = EXFAT_SB(inode->i_sb)->cluster_size;
+	return 0;
+}
+
+int exfat_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(dentry->d_sb);
+	struct inode *inode = dentry->d_inode;
+	unsigned int ia_valid;
+	int error;
+
+	if ((attr->ia_valid & ATTR_SIZE) &&
+	    attr->ia_size > i_size_read(inode)) {
+		error = exfat_cont_expand(inode, attr->ia_size);
+		if (error || attr->ia_valid == ATTR_SIZE)
+			return error;
+		attr->ia_valid &= ~ATTR_SIZE;
+	}
+
+	/* Check for setting the inode time. */
+	ia_valid = attr->ia_valid;
+	if ((ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) &&
+	    exfat_allow_set_time(sbi, inode)) {
+		attr->ia_valid &= ~(ATTR_MTIME_SET | ATTR_ATIME_SET |
+				ATTR_TIMES_SET);
+	}
+
+	error = setattr_prepare(dentry, attr);
+	attr->ia_valid = ia_valid;
+	if (error)
+		return error;
+
+	if (((attr->ia_valid & ATTR_UID) &&
+	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
+	    ((attr->ia_valid & ATTR_GID) &&
+	     !gid_eq(attr->ia_gid, sbi->options.fs_gid)) ||
+	    ((attr->ia_valid & ATTR_MODE) &&
+	     (attr->ia_mode & ~(S_IFREG | S_IFLNK | S_IFDIR | 0777))))
+		return -EPERM;
+
+	/*
+	 * We don't return -EPERM here. Yes, strange, but this is too
+	 * old behavior.
+	 */
+	if (attr->ia_valid & ATTR_MODE) {
+		if (exfat_sanitize_mode(sbi, inode, &attr->ia_mode) < 0)
+			attr->ia_valid &= ~ATTR_MODE;
+	}
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		down_write(&EXFAT_I(inode)->truncate_lock);
+		truncate_setsize(inode, attr->ia_size);
+		exfat_truncate(inode, attr->ia_size);
+		up_write(&EXFAT_I(inode)->truncate_lock);
+	}
+
+	setattr_copy(inode, attr);
+	mark_inode_dirty(inode);
+
+	return error;
+}
+
+const struct file_operations exfat_file_operations = {
+	.llseek      = generic_file_llseek,
+	.read_iter   = generic_file_read_iter,
+	.write_iter  = generic_file_write_iter,
+	.mmap        = generic_file_mmap,
+	.fsync       = generic_file_fsync,
+	.splice_read = generic_file_splice_read,
+};
+
+const struct inode_operations exfat_file_inode_operations = {
+	.setattr     = exfat_setattr,
+	.getattr     = exfat_getattr,
+};
-- 
2.17.1

