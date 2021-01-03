Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951E02E8DF1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 20:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhACTvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 14:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbhACTvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 14:51:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A117C061573;
        Sun,  3 Jan 2021 11:50:22 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x20so59768825lfe.12;
        Sun, 03 Jan 2021 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TvfnUAY1SgI03Kuiug6GUBwACUdLjnyIVSBnyZjSUXM=;
        b=PijcJXvXQUNrXAJDo24yZQGEYPCiqBM3N6jhLG5dwjkifjXYj1qmAZ/h57XSI+uNwy
         SpVHsy7JogSdfMifghFePcfoMEXbTAy1gxY4Z/jLrfeCCZ9ZrswmhvKtvWG7tcaDeT1D
         q9r6Ll5Kt3i1giU8zUB1Fxc+KvwmrQtLOyTwG+awlaoDB/THtgDP5r1oQ+O76XAR3iv6
         PuWKw95Io7ql5/nTAytcU4HCITM7zTt1v3/h6uyQ1R+hBjenU6fpeXfmNXR0rDf9tSX1
         eCDqnMv9zcOE820RZDofeypNRr622NosOmjZM6ohMU9K4X17D3wG1bvuw0vrohmpT3ZT
         xIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TvfnUAY1SgI03Kuiug6GUBwACUdLjnyIVSBnyZjSUXM=;
        b=FOws5d1K+Frt1KNpA1NoohBJkll21yyApF7BT82S9Vh7Uy8dfUnXJ67YtStMZYiQUV
         zaUXrmEQr8nKiGXFsBdFHPwpkqsZfUssc5yZBmNxbNHeAmL33A1K6xwQKEq9lQpBxG/p
         +r6cfZnm2/YHxbKHFa9kVbU7LvwFFg5rgPmLX+7k8nKZeWRD0FZosBaWazs+kn93GBmf
         ZruVQ6fCavUNqphfzJ8IuEb4BBixWojys4LRvAlUpD2f8Pw64xLD/MT1vpwn84ybUXNJ
         sUVN817vtWSCAIflDXvTg+nXQVSHLZlzu1QsiuEbjB3xT8r7kjT8QpZmM4L97QQvyo5X
         Ipcw==
X-Gm-Message-State: AOAM532oDNRBXEFn8QU7Y3fLDw6g9/GJfO5/hcJxfkQ5jFJf1RcV0stz
        eoyuCwmNHqHffx7b1ufNDFg=
X-Google-Smtp-Source: ABdhPJyPOLejIgK0xeFHge64zWBnhLAUr8UHXScFQLS0eQUhQytyet3GKB7DlUr8RsMlugzREtDhXA==
X-Received: by 2002:a19:8cb:: with SMTP id 194mr32169405lfi.463.1609703420688;
        Sun, 03 Jan 2021 11:50:20 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id u10sm7079549lfm.156.2021.01.03.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 11:50:19 -0800 (PST)
Date:   Sun, 3 Jan 2021 21:50:17 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20210103195017.fim2msuzj3kup6rq@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:53PM +0300, Konstantin Komarov wrote:
 
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c

> +int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
> +{
> +	int err = 0;
> +	struct super_block *sb = sbi->sb;
> +	struct inode *inode = &ni->vfs_inode;
> +	struct MFT_REF ref;
> +
> +	/* Check for 4GB */
> +	if (inode->i_size >= 0x100000000ull) {
> +		ntfs_err(sb, "$LogFile is too big");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	sbi->flags |= NTFS_FLAGS_LOG_REPLAYING;
> +
> +	ref.low = cpu_to_le32(MFT_REC_MFT);
> +	ref.high = 0;
> +	ref.seq = cpu_to_le16(1);
> +
> +	inode = ntfs_iget5(sb, &ref, NULL);
> +
> +	if (IS_ERR(inode))
> +		inode = NULL;
> +
> +	if (!inode) {
> +		/* Try to use mft copy */
> +		u64 t64 = sbi->mft.lbo;
> +
> +		sbi->mft.lbo = sbi->mft.lbo2;
> +		inode = ntfs_iget5(sb, &ref, NULL);
> +		sbi->mft.lbo = t64;
> +		if (IS_ERR(inode))
> +			inode = NULL;
> +	}
> +
> +	if (!inode) {
> +		err = -EINVAL;
> +		ntfs_err(sb, "Failed to load $MFT.");
> +		goto out;
> +	}
> +
> +	sbi->mft.ni = ntfs_i(inode);
> +
> +	err = ni_load_all_mi(sbi->mft.ni);
> +	if (!err)
> +		err = log_replay(ni);

We only get error from log_replay if 

> +
> +	iput(inode);
> +	sbi->mft.ni = NULL;
> +
> +	sync_blockdev(sb->s_bdev);
> +	invalidate_bdev(sb->s_bdev);
> +
> +	/* reinit MFT */
> +	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (sb_rdonly(sb))
> +		goto out;

we get here. Is this a intentional? Probably but I'm just checking.

> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c

> +int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
> +		      const struct cpu_str *uni, umode_t mode, dev_t dev,
> +		      const char *symname, u32 size, int excl,
> +		      struct ntfs_fnd *fnd, struct inode **new_inode)
> +{

> +#ifdef CONFIG_NTFS3_FS_POSIX_ACL

In Kconfig this is NTFS3_POSIX_ACL. This repeat every file.

> +int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
> +{
> +	int err;
> +	struct super_block *sb = dir->i_sb;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct inode *inode = d_inode(dentry);
> +	struct ntfs_inode *ni = ntfs_i(inode);
> +	const struct qstr *name = &dentry->d_name;
> +	struct ntfs_inode *dir_ni = ntfs_i(dir);
> +	struct ntfs_index *indx = &dir_ni->dir;
> +	struct cpu_str *uni = NULL;
> +	struct ATTR_FILE_NAME *fname;
> +	u8 name_type;
> +	struct ATTR_LIST_ENTRY *le;
> +	struct MFT_REF ref;
> +	bool is_dir = S_ISDIR(inode->i_mode);
> +	struct INDEX_ROOT *dir_root;
> +
> +	dir_root = indx_get_root(indx, dir_ni, NULL, NULL);
> +	if (!dir_root)
> +		return -EINVAL;
> +
> +	ni_lock(ni);
> +
> +	if (is_dir && !dir_is_empty(inode)) {
> +		err = -ENOTEMPTY;
> +		goto out1;
> +	}
> +
> +	if (ntfs_is_meta_file(sbi, inode->i_ino)) {
> +		err = -EINVAL;
> +		goto out1;
> +	}
> +
> +	/* allocate PATH_MAX bytes */
> +	uni = __getname();
> +	if (!uni) {
> +		err = -ENOMEM;
> +		goto out1;
> +	}
> +
> +	/* Convert input string to unicode */
> +	err = ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
> +				UTF16_HOST_ENDIAN);
> +	if (err < 0)
> +		goto out4;
> +
> +	le = NULL;

Little bit random place for this. Do we even need to NULL le.

> +
> +	/*mark rw ntfs as dirty. it will be cleared at umount*/
> +	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
> +
> +	/* find name in record */
> +#ifdef NTFS3_64BIT_CLUSTER
> +	ref.low = cpu_to_le32(dir->i_ino & 0xffffffff);
> +	ref.high = cpu_to_le16(dir->i_ino >> 32);
> +#else
> +	ref.low = cpu_to_le32(dir->i_ino & 0xffffffff);
> +	ref.high = 0;
> +#endif
> +	ref.seq = dir_ni->mi.mrec->seq;
> +
> +	fname = ni_fname_name(ni, uni, &ref, &le);

> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c

> +#ifdef CONFIG_PRINTK
> +/*
> + * Trace warnings/notices/errors
> + * Thanks Joe Perches <joe@perches.com> for implementation
> + */
> +void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +	int level;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +
> +	/*should we use different ratelimits for warnings/notices/errors? */
> +	if (!___ratelimit(&sbi->msg_ratelimit, "ntfs3"))
> +		return;
> +
> +	va_start(args, fmt);
> +
> +	level = printk_get_level(fmt);
> +	vaf.fmt = printk_skip_level(fmt);
> +	vaf.va = &args;
> +	printk("%c%cntfs3: %s: %pV\n", KERN_SOH_ASCII, level, sb->s_id, &vaf);
> +
> +	va_end(args);
> +}
> +
> +static char s_name_buf[512];
> +static atomic_t s_name_buf_cnt = ATOMIC_INIT(1); // 1 means 'free s_name_buf'
> +
> +/* print warnings/notices/errors about inode using name or inode number */
> +void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	char *name;
> +	va_list args;
> +	struct va_format vaf;
> +	int level;
> +
> +	if (!___ratelimit(&sbi->msg_ratelimit, "ntfs3"))
> +		return;
> +
> +	if (atomic_dec_and_test(&s_name_buf_cnt)) {
> +		/* use static allocated buffer */
> +		name = s_name_buf;
> +	} else {
> +		name = kmalloc(sizeof(s_name_buf), GFP_NOFS);
> +	}
> +
> +	if (name) {
> +		struct dentry *dentry = d_find_alias(inode);
> +		const u32 name_len = ARRAY_SIZE(s_name_buf) - 1;
> +
> +		if (dentry) {
> +			spin_lock(&dentry->d_lock);
> +			snprintf(name, name_len, "%s", dentry->d_name.name);
> +			spin_unlock(&dentry->d_lock);
> +			dput(dentry);
> +			name[name_len] = 0; /* to be sure*/
> +		} else {
> +			name[0] = 0;
> +		}
> +	}
> +
> +	va_start(args, fmt);
> +
> +	level = printk_get_level(fmt);
> +	vaf.fmt = printk_skip_level(fmt);
> +	vaf.va = &args;
> +
> +	printk("%c%cntfs3: %s: ino=%lx, \"%s\" %pV\n", KERN_SOH_ASCII, level,
> +	       sb->s_id, inode->i_ino, name ? name : "", &vaf);
> +
> +	va_end(args);
> +
> +	atomic_inc(&s_name_buf_cnt);
> +	if (name != s_name_buf)
> +		kfree(name);
> +}
> +#endif

Should these be in debug.c or something? Atleast I do not see point why
they are in super.c.

> +static int __init init_ntfs_fs(void)
> +{
> +	int err;
> +
> +#ifdef NTFS3_INDEX_BINARY_SEARCH
> +	pr_notice("ntfs3: +index binary search\n");
> +#endif
> +
> +#ifdef NTFS3_CHECK_FREE_CLST
> +	pr_notice("ntfs3: +check free clusters\n");
> +#endif
> +
> +#if NTFS_LINK_MAX < 0xffff
> +	pr_notice("ntfs3: max link count %u\n", NTFS_LINK_MAX);
> +#endif
> +
> +#ifdef NTFS3_64BIT_CLUSTER
> +	pr_notice("ntfs3: 64 bits per cluster\n");
> +#else
> +	pr_notice("ntfs3: 32 bits per cluster\n");
> +#endif
> +#ifdef CONFIG_NTFS3_LZX_XPRESS
> +	pr_notice("ntfs3: read-only lzx/xpress compression included\n");
> +#endif
> +
> +	ntfs_inode_cachep = kmem_cache_create(
> +		"ntfs_inode_cache", sizeof(struct ntfs_inode), 0,
> +		(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +		init_once);
> +	if (!ntfs_inode_cachep) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	err = register_filesystem(&ntfs_fs_type);
> +	if (!err)
> +		return 0;

Do we need kmem_cache_destroy() here if err?

> +
> +failed:
> +	return err;
> +}
