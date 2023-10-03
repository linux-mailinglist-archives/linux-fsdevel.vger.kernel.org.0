Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3B7B6A49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjJCNUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjJCNUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:20:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626FCE5;
        Tue,  3 Oct 2023 06:20:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72B761F45B;
        Tue,  3 Oct 2023 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696339222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xl5gigzuD0h4X4xgTTFSoyDOAJ3zte6LU/Pt2TNQDWg=;
        b=LX7yAnk1oFogEakJ4UHCjeq0tRQkgtClQkAz2L218mA4W5MaFHK5++w73biAtN7mLUZLQh
        H1G5Y8oJuNw+5BiS5tbhhHMLlntTaxDJFDcF0bjuDxeQQ6+XufPpBK6qi9Ei/uKKPGoJKa
        c4hhc3YhvPPAQ1B8qlIoIoVldkZcA7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696339222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xl5gigzuD0h4X4xgTTFSoyDOAJ3zte6LU/Pt2TNQDWg=;
        b=AMJn+HCPklbH3ujzNdvTB6dcLMkRthFI+c3eRtyAOoRXDNzqOrANM7D0QYVcUCtDmAGzAk
        sBOIgKQk37IlsoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 627A5132D4;
        Tue,  3 Oct 2023 13:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 65EJGBYVHGXMNAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 13:20:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E8C1CA07CC; Tue,  3 Oct 2023 15:20:21 +0200 (CEST)
Date:   Tue, 3 Oct 2023 15:20:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/8] shmem: trivial tidyups, removing extra blank lines,
 etc
Message-ID: <20231003132021.3l3xe2wjtatwoell@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <b3983d28-5d3f-8649-36af-b819285d7a9e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3983d28-5d3f-8649-36af-b819285d7a9e@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:28:50, Hugh Dickins wrote:
> Mostly removing a few superfluous blank lines, joining short arglines,
> imposing some 80-column observance, correcting a couple of comments.
> None of it more interesting than deleting a repeated INIT_LIST_HEAD().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Autumn cleaning ;). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 56 ++++++++++++++++++++----------------------------------
>  1 file changed, 21 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5501a5bc8d8c..caee8ba841f7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -756,7 +756,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  /*
> - * Like filemap_add_folio, but error if expected item has gone.
> + * Somewhat like filemap_add_folio, but error if expected item has gone.
>   */
>  static int shmem_add_to_page_cache(struct folio *folio,
>  				   struct address_space *mapping,
> @@ -825,7 +825,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
>  }
>  
>  /*
> - * Like delete_from_page_cache, but substitutes swap for @folio.
> + * Somewhat like filemap_remove_folio, but substitutes swap for @folio.
>   */
>  static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>  {
> @@ -887,7 +887,6 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>  			cond_resched_rcu();
>  		}
>  	}
> -
>  	rcu_read_unlock();
>  
>  	return swapped << PAGE_SHIFT;
> @@ -1213,7 +1212,6 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  	if (i_uid_needs_update(idmap, attr, inode) ||
>  	    i_gid_needs_update(idmap, attr, inode)) {
>  		error = dquot_transfer(idmap, inode, attr);
> -
>  		if (error)
>  			return error;
>  	}
> @@ -2456,7 +2454,6 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	if (err)
>  		return ERR_PTR(err);
>  
> -
>  	inode = new_inode(sb);
>  	if (!inode) {
>  		shmem_free_inode(sb, 0);
> @@ -2481,11 +2478,10 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  		shmem_set_inode_flags(inode, info->fsflags);
>  	INIT_LIST_HEAD(&info->shrinklist);
>  	INIT_LIST_HEAD(&info->swaplist);
> -	INIT_LIST_HEAD(&info->swaplist);
> -	if (sbinfo->noswap)
> -		mapping_set_unevictable(inode->i_mapping);
>  	simple_xattrs_init(&info->xattrs);
>  	cache_no_acl(inode);
> +	if (sbinfo->noswap)
> +		mapping_set_unevictable(inode->i_mapping);
>  	mapping_set_large_folios(inode->i_mapping);
>  
>  	switch (mode & S_IFMT) {
> @@ -2697,7 +2693,6 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  	}
>  
>  	ret = shmem_get_folio(inode, index, &folio, SGP_WRITE);
> -
>  	if (ret)
>  		return ret;
>  
> @@ -3229,8 +3224,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	error = simple_acl_create(dir, inode);
>  	if (error)
>  		goto out_iput;
> -	error = security_inode_init_security(inode, dir,
> -					     &dentry->d_name,
> +	error = security_inode_init_security(inode, dir, &dentry->d_name,
>  					     shmem_initxattrs, NULL);
>  	if (error && error != -EOPNOTSUPP)
>  		goto out_iput;
> @@ -3259,14 +3253,11 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  	int error;
>  
>  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> -
>  	if (IS_ERR(inode)) {
>  		error = PTR_ERR(inode);
>  		goto err_out;
>  	}
> -
> -	error = security_inode_init_security(inode, dir,
> -					     NULL,
> +	error = security_inode_init_security(inode, dir, NULL,
>  					     shmem_initxattrs, NULL);
>  	if (error && error != -EOPNOTSUPP)
>  		goto out_iput;
> @@ -3303,7 +3294,8 @@ static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
>  /*
>   * Link a file..
>   */
> -static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
> +static int shmem_link(struct dentry *old_dentry, struct inode *dir,
> +		      struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(old_dentry);
>  	int ret = 0;
> @@ -3334,7 +3326,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>  	inode_inc_iversion(dir);
>  	inc_nlink(inode);
>  	ihold(inode);	/* New dentry reference */
> -	dget(dentry);		/* Extra pinning count for the created dentry */
> +	dget(dentry);	/* Extra pinning count for the created dentry */
>  	d_instantiate(dentry, inode);
>  out:
>  	return ret;
> @@ -3354,7 +3346,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>  					     inode_set_ctime_current(inode));
>  	inode_inc_iversion(dir);
>  	drop_nlink(inode);
> -	dput(dentry);	/* Undo the count from "create" - this does all the work */
> +	dput(dentry);	/* Undo the count from "create" - does all the work */
>  	return 0;
>  }
>  
> @@ -3464,7 +3456,6 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  
>  	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
>  				VM_NORESERVE);
> -
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -3518,8 +3509,7 @@ static void shmem_put_link(void *arg)
>  	folio_put(arg);
>  }
>  
> -static const char *shmem_get_link(struct dentry *dentry,
> -				  struct inode *inode,
> +static const char *shmem_get_link(struct dentry *dentry, struct inode *inode,
>  				  struct delayed_call *done)
>  {
>  	struct folio *folio = NULL;
> @@ -3593,8 +3583,7 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
>   * Callback for security_inode_init_security() for acquiring xattrs.
>   */
>  static int shmem_initxattrs(struct inode *inode,
> -			    const struct xattr *xattr_array,
> -			    void *fs_info)
> +			    const struct xattr *xattr_array, void *fs_info)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> @@ -3778,7 +3767,6 @@ static struct dentry *shmem_find_alias(struct inode *inode)
>  	return alias ?: d_find_any_alias(inode);
>  }
>  
> -
>  static struct dentry *shmem_fh_to_dentry(struct super_block *sb,
>  		struct fid *fid, int fh_len, int fh_type)
>  {
> @@ -4362,8 +4350,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  #endif /* CONFIG_TMPFS_QUOTA */
>  
> -	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL, S_IFDIR | sbinfo->mode, 0,
> -				VM_NORESERVE);
> +	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL,
> +				S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
>  	if (IS_ERR(inode)) {
>  		error = PTR_ERR(inode);
>  		goto failed;
> @@ -4666,11 +4654,9 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
>  
>  	for (i = 0; i < ARRAY_SIZE(values); i++) {
>  		len += sysfs_emit_at(buf, len,
> -				     shmem_huge == values[i] ? "%s[%s]" : "%s%s",
> -				     i ? " " : "",
> -				     shmem_format_huge(values[i]));
> +				shmem_huge == values[i] ? "%s[%s]" : "%s%s",
> +				i ? " " : "", shmem_format_huge(values[i]));
>  	}
> -
>  	len += sysfs_emit_at(buf, len, "\n");
>  
>  	return len;
> @@ -4767,8 +4753,9 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
>  #define shmem_acct_size(flags, size)		0
>  #define shmem_unacct_size(flags, size)		do {} while (0)
>  
> -static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb, struct inode *dir,
> -					    umode_t mode, dev_t dev, unsigned long flags)
> +static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
> +				struct super_block *sb, struct inode *dir,
> +				umode_t mode, dev_t dev, unsigned long flags)
>  {
>  	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
>  	return inode ? inode : ERR_PTR(-ENOSPC);
> @@ -4778,8 +4765,8 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct supe
>  
>  /* common code */
>  
> -static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, loff_t size,
> -				       unsigned long flags, unsigned int i_flags)
> +static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> +			loff_t size, unsigned long flags, unsigned int i_flags)
>  {
>  	struct inode *inode;
>  	struct file *res;
> @@ -4798,7 +4785,6 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
>  				S_IFREG | S_IRWXUGO, 0, flags);
> -
>  	if (IS_ERR(inode)) {
>  		shmem_unacct_size(flags, size);
>  		return ERR_CAST(inode);
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
