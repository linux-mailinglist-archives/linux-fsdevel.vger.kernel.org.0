Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8657116C4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLILcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:32:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:32:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so15244236ljr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 03:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=139VhUE0ULptSgM687dOPDSISRH69HAE51tANtu1U5A=;
        b=KgSR4MHuOqo0MAzhIBFDX7Pgk1tvfAAcgxqFzJcZromZyqt/ER2Fz7o71lJ+XwXwfi
         lkSWRCXpiWYHQSssYGt6AtxCBA+I08ogBBjuLdAauFi4UCR46zqbhy968CxXqi1XcrMo
         mFHXv5TV7NqjGr8kYmYNVNNjZpnCDTT3X5b++LvHKgutDrJNmGuxl0Hg6MGsR3S8IcYA
         Fc4AzmZIGvEeJ4KwM3BA5LTu+raZQ1QH6ziZBC+IbzTBbqxlKBvVnkl42Nm4mTdvEGt9
         e67UlVvRv73g5WshmyYBv3ZcXxU/C5Acw/rpBJ7P/Qki7PEeON6XKxbWPw3tfATew2ci
         1Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=139VhUE0ULptSgM687dOPDSISRH69HAE51tANtu1U5A=;
        b=EYZSOr0fN6+f3hwbA00mooT9koJfgqh36siY4CxOFyw10/24DkLLJ/7Bf9HLlFdEhw
         a2mWSV9cCvFGXwwyQ/PEWUPZtr4EnDlYxn3cb2mnjPOCeizx3jr917Fqnj+TzfU1/PG+
         fbrFCPiFjwRNbFm4pdKMbGEftEya7UIFHTfnjjm0dlPmNmeT4W5qv+hCnffVqEtblSYW
         VyVMNBTavcAa32H9FwNpXX6l+3xOTxZ/RnEP5erbRq7mBu+pciMtRtZJ5Ky8wxDaUCh/
         BqOssd9gXT3GPls62bwowvjOInBdxXWdNV01Ol+GcXvalQxikWyXbejYOT2sGunT0Xt3
         igIg==
X-Gm-Message-State: APjAAAVSV7wclBl8291ph7SD4EEjYwYkqMPuVrx2uLo+Ku1poKF+UX/u
        jTw/Sz496f/orvubQVf9+dL5iwTJvH+Q+4Ox
X-Google-Smtp-Source: APXvYqwuBQcYqsVPHHkw/+7RHfyKlSHlx0rL1KZ2GKOomyPwWF1Q61sGQrQitT4Q/CNEnYoyn8Cr4w==
X-Received: by 2002:a2e:b045:: with SMTP id d5mr3872840ljl.184.1575891153363;
        Mon, 09 Dec 2019 03:32:33 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id g85sm10797035lfd.66.2019.12.09.03.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 03:32:32 -0800 (PST)
Message-ID: <e234c599ec452ed81fb703c69adf60c1e57062dd.camel@dubeyko.com>
Subject: Re: [PATCH v6 05/13] exfat: add file operations
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Date:   Mon, 09 Dec 2019 14:32:32 +0300
In-Reply-To: <20191209065149.2230-6-namjae.jeon@samsung.com>
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
         <CGME20191209065500epcas1p3da26ef7963bbba978ed614bc19b2ea07@epcas1p3.samsung.com>
         <20191209065149.2230-6-namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-09 at 01:51 -0500, Namjae Jeon wrote:
> This adds the implementation of file operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/file.c | 343
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 343 insertions(+)
>  create mode 100644 fs/exfat/file.c
> 
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> new file mode 100644
> index 000000000000..1a32a88e2055
> --- /dev/null
> +++ b/fs/exfat/file.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/cred.h>
> +#include <linux/buffer_head.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +static int exfat_cont_expand(struct inode *inode, loff_t size)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +	loff_t start = i_size_read(inode), count = size -
> i_size_read(inode);
> +	int err, err2;
> +
> +	err = generic_cont_expand_simple(inode, size);
> +	if (err)
> +		return err;
> +
> +	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	mark_inode_dirty(inode);
> +
> +	if (!IS_SYNC(inode))
> +		return 0;
> +
> +	err = filemap_fdatawrite_range(mapping, start, start + count -
> 1);
> +	err2 = sync_mapping_buffers(mapping);
> +	if (!err)
> +		err = err2;
> +	err2 = write_inode_now(inode, 1);
> +	if (!err)
> +		err = err2;
> +	if (err)
> +		return err;
> +
> +	return filemap_fdatawait_range(mapping, start, start + count -
> 1);
> +}
> +
> +static bool exfat_allow_set_time(struct exfat_sb_info *sbi, struct
> inode *inode)
> +{
> +	mode_t allow_utime = sbi->options.allow_utime;
> +
> +	if (!uid_eq(current_fsuid(), inode->i_uid)) {
> +		if (in_group_p(inode->i_gid))
> +			allow_utime >>= 3;
> +		if (allow_utime & MAY_WRITE)
> +			return true;
> +	}
> +
> +	/* use a default check */
> +	return false;
> +}
> +
> +static int exfat_sanitize_mode(const struct exfat_sb_info *sbi,
> +		struct inode *inode, umode_t *mode_ptr)
> +{
> +	mode_t i_mode, mask, perm;
> +
> +	i_mode = inode->i_mode;
> +
> +	mask = (S_ISREG(i_mode) || S_ISLNK(i_mode)) ?
> +		sbi->options.fs_fmask : sbi->options.fs_dmask;
> +	perm = *mode_ptr & ~(S_IFMT | mask);
> +
> +	/* Of the r and x bits, all (subject to umask) must be
> present.*/
> +	if ((perm & 0555) != (i_mode & 0555))

What's about to use constants here instead of hardcoded values?

> +		return -EPERM;
> +
> +	if (exfat_mode_can_hold_ro(inode)) {
> +		/*
> +		 * Of the w bits, either all (subject to umask) or none
> must
> +		 * be present.
> +		 */
> +		if ((perm & 0222) && ((perm & 0222) != (0222 & ~mask)))

Ditto.

> +			return -EPERM;
> +	} else {
> +		/*
> +		 * If exfat_mode_can_hold_ro(inode) is false, can't
> change
> +		 * w bits.
> +		 */
> +		if ((perm & 0222) != (0222 & ~mask))

Ditto.

> +			return -EPERM;
> +	}
> +
> +	*mode_ptr &= S_IFMT | perm;
> +
> +	return 0;
> +}
> +
> +/* resize the file length */
> +int __exfat_truncate(struct inode *inode, loff_t new_size)
> +{
> +	unsigned int num_clusters_new, num_clusters_phys;
> +	unsigned int last_clu = FREE_CLUSTER;
> +	struct exfat_chain clu;
> +	struct exfat_timestamp tm;
> +	struct exfat_dentry *ep, *ep2;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	struct exfat_entry_set_cache *es = NULL;
> +	int evict = (ei->dir.dir == DIR_DELETED) ? 1 : 0;
> +
> +	/* check if the given file ID is opened */
> +	if (ei->type != TYPE_FILE && ei->type != TYPE_DIR)
> +		return -EPERM;
> +
> +	exfat_set_vol_flags(sb, VOL_DIRTY);
> +
> +	num_clusters_new = EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode),
> sbi);
> +	num_clusters_phys =
> +		EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk,
> sbi);
> +
> +	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei-
> >flags);
> +
> +	if (new_size > 0) {
> +		/*
> +		 * Truncate FAT chain num_clusters after the first
> cluster
> +		 * num_clusters = min(new, phys);
> +		 */
> +		unsigned int num_clusters =
> +			min(num_clusters_new, num_clusters_phys);
> +
> +		/*
> +		 * Follow FAT chain
> +		 * (defensive coding - works fine even with corrupted
> FAT table
> +		 */
> +		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
> +			clu.dir += num_clusters;
> +			clu.size -= num_clusters;
> +		} else {
> +			while (num_clusters > 0) {
> +				last_clu = clu.dir;
> +				if (exfat_get_next_cluster(sb,
> &(clu.dir)))
> +					return -EIO;
> +
> +				num_clusters--;
> +				clu.size--;
> +			}
> +		}
> +	} else {
> +		ei->flags = ALLOC_NO_FAT_CHAIN;
> +		ei->start_clu = EOF_CLUSTER;
> +	}
> +
> +	i_size_write(inode, new_size);
> +
> +	if (ei->type == TYPE_FILE)
> +		ei->attr |= ATTR_ARCHIVE;
> +
> +	/* update the directory entry */
> +	if (!evict) {
> +		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
> +				ES_ALL_ENTRIES, &ep);
> +		if (!es)
> +			return -EIO;
> +		ep2 = ep + 1;

The ep2 could point out on the garbage here. Maybe, it makes sense to
add some check here?

Thanks,
Viacheslav Dubeyko.

> +
> +		exfat_set_entry_time(ep, exfat_tm_now(EXFAT_SB(sb),
> &tm),
> +				TM_MODIFY);
> +		ep->file_attr = cpu_to_le16(ei->attr);
> +
> +		/* File size should be zero if there is no cluster
> allocated */
> +		if (ei->start_clu == EOF_CLUSTER)
> +			ep->stream_valid_size = ep->stream_size = 0;
> +		else {
> +			ep->stream_valid_size = cpu_to_le64(new_size);
> +			ep->stream_size = ep->stream_valid_size;
> +		}
> +
> +		if (new_size == 0) {
> +			/* Any directory can not be truncated to zero
> */
> +			WARN_ON(ei->type != TYPE_FILE);
> +
> +			ep2->stream_flags = ALLOC_FAT_CHAIN;
> +			ep2->stream_start_clu = FREE_CLUSTER;
> +		}
> +
> +		if (exfat_update_dir_chksum_with_entry_set(sb, es,
> +		    inode_needs_sync(inode)))
> +			return -EIO;
> +		kfree(es);
> +	}
> +
> +	/* cut off from the FAT chain */
> +	if (ei->flags == ALLOC_FAT_CHAIN && last_clu != FREE_CLUSTER &&
> +			last_clu != EOF_CLUSTER) {
> +		if (exfat_ent_set(sb, last_clu, EOF_CLUSTER))
> +			return -EIO;
> +	}
> +
> +	/* invalidate cache and free the clusters */
> +	/* clear exfat cache */
> +	exfat_cache_inval_inode(inode);
> +
> +	/* hint information */
> +	ei->hint_bmap.off = EOF_CLUSTER;
> +	ei->hint_bmap.clu = EOF_CLUSTER;
> +	if (ei->rwoffset > new_size)
> +		ei->rwoffset = new_size;
> +
> +	/* hint_stat will be used if this is directory. */
> +	ei->hint_stat.eidx = 0;
> +	ei->hint_stat.clu = ei->start_clu;
> +	ei->hint_femp.eidx = EXFAT_HINT_NONE;
> +
> +	/* free the clusters */
> +	if (exfat_free_cluster(inode, &clu))
> +		return -EIO;
> +
> +	exfat_set_vol_flags(sb, VOL_CLEAN);
> +
> +	return 0;
> +}
> +
> +void exfat_truncate(struct inode *inode, loff_t size)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	unsigned int blocksize = 1 << inode->i_blkbits;
> +	loff_t aligned_size;
> +	int err;
> +
> +	mutex_lock(&sbi->s_lock);
> +	if (EXFAT_I(inode)->start_clu == 0) {
> +		/*
> +		 * Empty start_clu != ~0 (not allocated)
> +		 */
> +		exfat_fs_error(sb, "tried to truncate zeroed
> cluster.");
> +		goto write_size;
> +	}
> +
> +	err = __exfat_truncate(inode, i_size_read(inode));
> +	if (err)
> +		goto write_size;
> +
> +	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	if (IS_DIRSYNC(inode))
> +		exfat_sync_inode(inode);
> +	else
> +		mark_inode_dirty(inode);
> +
> +	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size -
> 1)) &
> +			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
> +write_size:
> +	aligned_size = i_size_read(inode);
> +	if (aligned_size & (blocksize - 1)) {
> +		aligned_size |= (blocksize - 1);
> +		aligned_size++;
> +	}
> +
> +	if (EXFAT_I(inode)->i_size_ondisk > i_size_read(inode))
> +		EXFAT_I(inode)->i_size_ondisk = aligned_size;
> +
> +	if (EXFAT_I(inode)->i_size_aligned > i_size_read(inode))
> +		EXFAT_I(inode)->i_size_aligned = aligned_size;
> +	mutex_unlock(&sbi->s_lock);
> +}
> +
> +int exfat_getattr(const struct path *path, struct kstat *stat,
> +		unsigned int request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_backing_inode(path->dentry);
> +
> +	generic_fillattr(inode, stat);
> +	stat->blksize = EXFAT_SB(inode->i_sb)->cluster_size;
> +	return 0;
> +}
> +
> +int exfat_setattr(struct dentry *dentry, struct iattr *attr)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(dentry->d_sb);
> +	struct inode *inode = dentry->d_inode;
> +	unsigned int ia_valid;
> +	int error;
> +
> +	if ((attr->ia_valid & ATTR_SIZE) &&
> +	    attr->ia_size > i_size_read(inode)) {
> +		error = exfat_cont_expand(inode, attr->ia_size);
> +		if (error || attr->ia_valid == ATTR_SIZE)
> +			return error;
> +		attr->ia_valid &= ~ATTR_SIZE;
> +	}
> +
> +	/* Check for setting the inode time. */
> +	ia_valid = attr->ia_valid;
> +	if ((ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET |
> ATTR_TIMES_SET)) &&
> +	    exfat_allow_set_time(sbi, inode)) {
> +		attr->ia_valid &= ~(ATTR_MTIME_SET | ATTR_ATIME_SET |
> +				ATTR_TIMES_SET);
> +	}
> +
> +	error = setattr_prepare(dentry, attr);
> +	attr->ia_valid = ia_valid;
> +	if (error)
> +		return error;
> +
> +	if (((attr->ia_valid & ATTR_UID) &&
> +	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
> +	    ((attr->ia_valid & ATTR_GID) &&
> +	     !gid_eq(attr->ia_gid, sbi->options.fs_gid)) ||
> +	    ((attr->ia_valid & ATTR_MODE) &&
> +	     (attr->ia_mode & ~(S_IFREG | S_IFLNK | S_IFDIR | 0777))))
> +		return -EPERM;
> +
> +	/*
> +	 * We don't return -EPERM here. Yes, strange, but this is too
> +	 * old behavior.
> +	 */
> +	if (attr->ia_valid & ATTR_MODE) {
> +		if (exfat_sanitize_mode(sbi, inode, &attr->ia_mode) <
> 0)
> +			attr->ia_valid &= ~ATTR_MODE;
> +	}
> +
> +	if (attr->ia_valid & ATTR_SIZE) {
> +		down_write(&EXFAT_I(inode)->truncate_lock);
> +		truncate_setsize(inode, attr->ia_size);
> +		exfat_truncate(inode, attr->ia_size);
> +		up_write(&EXFAT_I(inode)->truncate_lock);
> +	}
> +
> +	setattr_copy(inode, attr);
> +	mark_inode_dirty(inode);
> +
> +	return error;
> +}
> +
> +const struct file_operations exfat_file_operations = {
> +	.llseek      = generic_file_llseek,
> +	.read_iter   = generic_file_read_iter,
> +	.write_iter  = generic_file_write_iter,
> +	.mmap        = generic_file_mmap,
> +	.fsync       = generic_file_fsync,
> +	.splice_read = generic_file_splice_read,
> +};
> +
> +const struct inode_operations exfat_file_inode_operations = {
> +	.setattr     = exfat_setattr,
> +	.getattr     = exfat_getattr,
> +};

