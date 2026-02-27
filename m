Return-Path: <linux-fsdevel+bounces-78722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN3kHKexoWmMvgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:00:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B091B95F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CEA330217E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6542EEC7;
	Fri, 27 Feb 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOLJEFuP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Zg0hZbS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7ZJMDi6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kiq1gZkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFE42982D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204446; cv=none; b=npoH9qZmKwGu79Dz2wdSJAuM7A5pz6CvDZG3sDPCD1ZH7dSxnccfB2BbSt5QJnkulZh4nP3T2xwUnsyNW8pAd2Ezac63kZG5/FdThyLxdPVCUcr5THcAf+6AGVQyRmUN/DuYEhS/nwBLSUPBCu9ntvBgTtojo6nXK7fuJBR4R8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204446; c=relaxed/simple;
	bh=QPveIje7+4fjwO64UgxbflsOGVbhrFLPp1RlTXeNJkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT2+pdFFuFGyhHOs1OoCh4TqT+ZBv88dB10jIrS34ZRy22c3uhrr/iYhKey2U3LSOET+Ym+OPngZLCOVGTYScsipTT39ZQwUA1GEHy5ENTJaTogP2Rj8Xe04WrTIwHJAwlG2afVi0v0dDRWiRg2tF2cxiM9GukRBWmpfBO/FI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOLJEFuP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Zg0hZbS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7ZJMDi6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kiq1gZkH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E6D05D050;
	Fri, 27 Feb 2026 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772204443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YNa9VbblGOYweoA7bNUqLw4ueQtOdJWihgMEEJuMI4=;
	b=DOLJEFuPIC16vEbxIGuupy9DHG/corFZNPnenZy1j1j7NMqvoT1/9mQda8uvzQW/Y2DgfQ
	zZQCJ1ILFmbFIDp0aobj0ahw3XUUhD/JjCz4zYvpvdFPvD6wctwoKZc2vxbiO+gfGBE2DH
	p2ekwPYeWNniPQgbDy53qTREqMuZxmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772204443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YNa9VbblGOYweoA7bNUqLw4ueQtOdJWihgMEEJuMI4=;
	b=6Zg0hZbSlxLC5ASoVl7eTX8pOspi90GHPRBxl19nFvuN4HlSeZZjgI0h/0wEZBCt+uS+Lg
	pHjTQi4vuPxQBnAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772204438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YNa9VbblGOYweoA7bNUqLw4ueQtOdJWihgMEEJuMI4=;
	b=V7ZJMDi69Q/Hdeq9tLefvDyOTmVqEiO6CtG6hmBZ52L5njImrJmF2h9dtGBmIvmTsxyjya
	Lht22QeznVsztUP4mDzyBuCQ6ePHP4CxFukiTIXVaQAsJTr00Rup16ndeW3e9RIiK2T29Q
	TG41S1GO4PnJ8CJ7Q0cvMmLAuCLhunc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772204438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YNa9VbblGOYweoA7bNUqLw4ueQtOdJWihgMEEJuMI4=;
	b=Kiq1gZkH2Da8WdXkaXCk74+yBeGcw+ypIhnhB3xLf/ciO/9QH9aU/VxAhLN/qOYUQzCsII
	EfGxjUsn5UTZ4UDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EBCB3EA69;
	Fri, 27 Feb 2026 15:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPJiC5axoWkaDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:00:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DEADDA06D4; Fri, 27 Feb 2026 16:00:37 +0100 (CET)
Date: Fri, 27 Feb 2026 16:00:37 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 04/14] kernfs: adapt to rhashtable-based simple_xattrs
 with lazy allocation
Message-ID: <3cnmtqmakpbb2uwhenrj7kdqu3uefykiykjllgfbtpkiwhaa4s@sghkevv7jned>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-4-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-4-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78722-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B2B091B95F5
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:00, Christian Brauner wrote:
> Adapt kernfs to use the rhashtable-based xattr path and switch from an
> embedded struct to pointer-based lazy allocation.
> 
> Change kernfs_iattrs.xattrs from embedded 'struct simple_xattrs' to a
> pointer 'struct simple_xattrs *', initialized to NULL (zeroed by
> kmem_cache_zalloc). Since kernfs_iattrs is already lazily allocated
> itself, this adds a second level of lazy allocation specifically for
> the xattr store.
> 
> The xattr store is allocated on first setxattr. Read paths
> check for NULL and return -ENODATA or empty list.
> 
> Replaced xattr entries are freed via simple_xattr_free_rcu() to allow
> concurrent RCU readers to finish.
> 
> The cleanup paths in kernfs_free_rcu() and __kernfs_new_node() error
> handling conditionally free the xattr store only when allocated.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...

> @@ -584,6 +582,12 @@ void kernfs_put(struct kernfs_node *kn)
>  	if (kernfs_type(kn) == KERNFS_LINK)
>  		kernfs_put(kn->symlink.target_kn);
>  
> +	if (kn->iattr && kn->iattr->xattrs) {
> +		simple_xattrs_free(kn->iattr->xattrs, NULL);
> +		kfree(kn->iattr->xattrs);
> +		kn->iattr->xattrs = NULL;
> +	}
> +
>  	spin_lock(&root->kernfs_idr_lock);
>  	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
>  	spin_unlock(&root->kernfs_idr_lock);

This is a slight change in the lifetime rules because previously kernfs
xattrs could be safely accessed only under RCU but after this change you
have to hold inode reference *and* RCU to safely access them. I don't think
anybody would be accessing xattrs without holding inode reference so this
should be safe but it would be good to mention this in the changelog.
Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> @@ -682,7 +686,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  
>   err_out4:
>  	if (kn->iattr) {
> -		simple_xattrs_free(&kn->iattr->xattrs, NULL);
> +		if (kn->iattr->xattrs) {
> +			simple_xattrs_free(kn->iattr->xattrs, NULL);
> +			kfree(kn->iattr->xattrs);
> +		}
>  		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
>  	}
>   err_out3:
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index a36aaee98dce..dfc3315b5afc 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -45,7 +45,6 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
>  	ret->ia_mtime = ret->ia_atime;
>  	ret->ia_ctime = ret->ia_atime;
>  
> -	simple_xattrs_init(&ret->xattrs);
>  	atomic_set(&ret->nr_user_xattrs, 0);
>  	atomic_set(&ret->user_xattr_size, 0);
>  
> @@ -146,7 +145,8 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
>  	if (!attrs)
>  		return -ENOMEM;
>  
> -	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
> +	return simple_xattr_list(d_inode(dentry), READ_ONCE(attrs->xattrs),
> +				 buf, size);
>  }
>  
>  static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
> @@ -298,27 +298,38 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
>  		     void *value, size_t size)
>  {
>  	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
> +	struct simple_xattrs *xattrs;
> +
>  	if (!attrs)
>  		return -ENODATA;
>  
> -	return simple_xattr_get(&attrs->xattrs, name, value, size);
> +	xattrs = READ_ONCE(attrs->xattrs);
> +	if (!xattrs)
> +		return -ENODATA;
> +
> +	return simple_xattr_get(xattrs, name, value, size);
>  }
>  
>  int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
>  		     const void *value, size_t size, int flags)
>  {
>  	struct simple_xattr *old_xattr;
> +	struct simple_xattrs *xattrs;
>  	struct kernfs_iattrs *attrs;
>  
>  	attrs = kernfs_iattrs(kn);
>  	if (!attrs)
>  		return -ENOMEM;
>  
> -	old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
> +	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
> +	if (IS_ERR_OR_NULL(xattrs))
> +		return PTR_ERR(xattrs);
> +
> +	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
>  	if (IS_ERR(old_xattr))
>  		return PTR_ERR(old_xattr);
>  
> -	simple_xattr_free(old_xattr);
> +	simple_xattr_free_rcu(old_xattr);
>  	return 0;
>  }
>  
> @@ -376,7 +387,7 @@ static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
>  
>  	ret = 0;
>  	size = old_xattr->size;
> -	simple_xattr_free(old_xattr);
> +	simple_xattr_free_rcu(old_xattr);
>  dec_size_out:
>  	atomic_sub(size, sz);
>  dec_count_out:
> @@ -403,7 +414,7 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
>  
>  	atomic_sub(old_xattr->size, sz);
>  	atomic_dec(nr);
> -	simple_xattr_free(old_xattr);
> +	simple_xattr_free_rcu(old_xattr);
>  	return 0;
>  }
>  
> @@ -415,6 +426,7 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
>  {
>  	const char *full_name = xattr_full_name(handler, suffix);
>  	struct kernfs_node *kn = inode->i_private;
> +	struct simple_xattrs *xattrs;
>  	struct kernfs_iattrs *attrs;
>  
>  	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR))
> @@ -424,11 +436,15 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
>  	if (!attrs)
>  		return -ENOMEM;
>  
> +	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
> +	if (IS_ERR_OR_NULL(xattrs))
> +		return PTR_ERR(xattrs);
> +
>  	if (value)
> -		return kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
> +		return kernfs_vfs_user_xattr_add(kn, full_name, xattrs,
>  						 value, size, flags);
>  	else
> -		return kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
> +		return kernfs_vfs_user_xattr_rm(kn, full_name, xattrs,
>  						value, size, flags);
>  
>  }
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 6061b6f70d2a..1324ed8c0661 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -26,7 +26,7 @@ struct kernfs_iattrs {
>  	struct timespec64	ia_mtime;
>  	struct timespec64	ia_ctime;
>  
> -	struct simple_xattrs	xattrs;
> +	struct simple_xattrs	*xattrs;
>  	atomic_t		nr_user_xattrs;
>  	atomic_t		user_xattr_size;
>  };
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

