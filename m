Return-Path: <linux-fsdevel+bounces-78735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLppONO3oWm+vwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:27:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1C1B9C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B057A305D532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589C43635F;
	Fri, 27 Feb 2026 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dINi8une";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSTI1aHB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dINi8une";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSTI1aHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386943D4F1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205925; cv=none; b=dRda5BF79E2K/pGvPFXI0NgIJpzucDuxS97qaWKmGLFIaphbj/zWcunzSNCf49Y0EtGbwZ77TEV0AoYH0teHatLLNA86o4FiYGKb4xYXr2Vn3oZ2XwkQE5+HIUuwY+0bAvXDx8TPvd6dATuKNXH5nyOuK8t3RmeTnDDGIqdM7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205925; c=relaxed/simple;
	bh=/isemzo6xva7gyTrOlIzU59+B0mzlBJn2S8L6/hIz8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwwViHaZ//IZwYqDjUGKgXhjtESH7SnYZvAaTYQf+KOfz/t0K2Blpt2wuzJZRi3k47l5A8ZZ9hbjxzsDoaNfarlrJ51yxCy1iIedFbpU02VXLKROQVZw9Iq2E5W/PQ4gNM4RIPT5MiqCw6fKpRTR9W/43x+X6dG6b4Tjj6lanYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dINi8une; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSTI1aHB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dINi8une; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSTI1aHB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B1275BE3C;
	Fri, 27 Feb 2026 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Lj+MCFwQ65SeHnvmQaDCdaKKYNg9T/G8p+sWH2qz8=;
	b=dINi8uneytLlfwiLDZTKCU0VnXhcm0QxVjxx3aQqVR9fRNI5Ys4CVeOeecY0KVOpnXBj7h
	wJnqsPM+OCq7uRiL4ESlyzFzMOCZ5id9+v07SLlDfdWU36PShgpuLyYZ5KqW7VU7H2ZudX
	ufkyCxFpSBcZ/yti4B2QsF9nOLN/nT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Lj+MCFwQ65SeHnvmQaDCdaKKYNg9T/G8p+sWH2qz8=;
	b=HSTI1aHByYN8VeVIe6kfQqDDdzzJQeaTr6tBk9A7sh2zMqb6qXaC3/+A2/l7XDARcvCR6D
	dpoYpEhZ5rvMGgAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dINi8une;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HSTI1aHB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Lj+MCFwQ65SeHnvmQaDCdaKKYNg9T/G8p+sWH2qz8=;
	b=dINi8uneytLlfwiLDZTKCU0VnXhcm0QxVjxx3aQqVR9fRNI5Ys4CVeOeecY0KVOpnXBj7h
	wJnqsPM+OCq7uRiL4ESlyzFzMOCZ5id9+v07SLlDfdWU36PShgpuLyYZ5KqW7VU7H2ZudX
	ufkyCxFpSBcZ/yti4B2QsF9nOLN/nT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Lj+MCFwQ65SeHnvmQaDCdaKKYNg9T/G8p+sWH2qz8=;
	b=HSTI1aHByYN8VeVIe6kfQqDDdzzJQeaTr6tBk9A7sh2zMqb6qXaC3/+A2/l7XDARcvCR6D
	dpoYpEhZ5rvMGgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47D283EA6A;
	Fri, 27 Feb 2026 15:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NTGIEV+3oWnKJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:25:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 077C4A06D4; Fri, 27 Feb 2026 16:25:14 +0100 (CET)
Date: Fri, 27 Feb 2026 16:25:14 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 10/14] xattr,net: support limited amount of extended
 attributes on sockfs sockets
Message-ID: <nvbbdg5v2o5tzyzhzfpj2cyldsstgxsnwr7qfr36vwsyks7qjv@ey4qw2ut6q7z>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-10-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-10-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78735-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1BB1C1B9C18
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:06, Christian Brauner wrote:
> Now that we've generalized the infrastructure for user.* xattrs make it
> possible to set up to 128 user.* extended attributes on a sockfs inode
> or up to 128kib. kernfs (cgroupfs) has the same limits and it has proven
> to be quite sufficient for nearly all use-cases.
> 
> This will allow containers to label sockets and will e.g., be used by
> systemd and Gnome to find various sockets in containers where
> high-privilege or more complicated solutions aren't available.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  net/socket.c | 119 +++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 92 insertions(+), 27 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 136b98c54fb3..7aa94fce7a8b 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -315,45 +315,70 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
>  
>  static struct kmem_cache *sock_inode_cachep __ro_after_init;
>  
> +struct sockfs_inode {
> +	struct simple_xattrs *xattrs;
> +	struct simple_xattr_limits xattr_limits;
> +	struct socket_alloc;
> +};
> +
> +static struct sockfs_inode *SOCKFS_I(struct inode *inode)
> +{
> +	return container_of(inode, struct sockfs_inode, vfs_inode);
> +}
> +
>  static struct inode *sock_alloc_inode(struct super_block *sb)
>  {
> -	struct socket_alloc *ei;
> +	struct sockfs_inode *si;
>  
> -	ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
> -	if (!ei)
> +	si = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
> +	if (!si)
>  		return NULL;
> -	init_waitqueue_head(&ei->socket.wq.wait);
> -	ei->socket.wq.fasync_list = NULL;
> -	ei->socket.wq.flags = 0;
> +	si->xattrs = NULL;
> +	simple_xattr_limits_init(&si->xattr_limits);
> +
> +	init_waitqueue_head(&si->socket.wq.wait);
> +	si->socket.wq.fasync_list = NULL;
> +	si->socket.wq.flags = 0;
> +
> +	si->socket.state = SS_UNCONNECTED;
> +	si->socket.flags = 0;
> +	si->socket.ops = NULL;
> +	si->socket.sk = NULL;
> +	si->socket.file = NULL;
>  
> -	ei->socket.state = SS_UNCONNECTED;
> -	ei->socket.flags = 0;
> -	ei->socket.ops = NULL;
> -	ei->socket.sk = NULL;
> -	ei->socket.file = NULL;
> +	return &si->vfs_inode;
> +}
> +
> +static void sock_evict_inode(struct inode *inode)
> +{
> +	struct sockfs_inode *si = SOCKFS_I(inode);
> +	struct simple_xattrs *xattrs = si->xattrs;
>  
> -	return &ei->vfs_inode;
> +	if (xattrs) {
> +		simple_xattrs_free(xattrs, NULL);
> +		kfree(xattrs);
> +	}
> +	clear_inode(inode);
>  }
>  
>  static void sock_free_inode(struct inode *inode)
>  {
> -	struct socket_alloc *ei;
> +	struct sockfs_inode *si = SOCKFS_I(inode);
>  
> -	ei = container_of(inode, struct socket_alloc, vfs_inode);
> -	kmem_cache_free(sock_inode_cachep, ei);
> +	kmem_cache_free(sock_inode_cachep, si);
>  }
>  
>  static void init_once(void *foo)
>  {
> -	struct socket_alloc *ei = (struct socket_alloc *)foo;
> +	struct sockfs_inode *si = (struct sockfs_inode *)foo;
>  
> -	inode_init_once(&ei->vfs_inode);
> +	inode_init_once(&si->vfs_inode);
>  }
>  
>  static void init_inodecache(void)
>  {
>  	sock_inode_cachep = kmem_cache_create("sock_inode_cache",
> -					      sizeof(struct socket_alloc),
> +					      sizeof(struct sockfs_inode),
>  					      0,
>  					      (SLAB_HWCACHE_ALIGN |
>  					       SLAB_RECLAIM_ACCOUNT |
> @@ -365,6 +390,7 @@ static void init_inodecache(void)
>  static const struct super_operations sockfs_ops = {
>  	.alloc_inode	= sock_alloc_inode,
>  	.free_inode	= sock_free_inode,
> +	.evict_inode	= sock_evict_inode,
>  	.statfs		= simple_statfs,
>  };
>  
> @@ -417,9 +443,48 @@ static const struct xattr_handler sockfs_security_xattr_handler = {
>  	.set = sockfs_security_xattr_set,
>  };
>  
> +static int sockfs_user_xattr_get(const struct xattr_handler *handler,
> +				 struct dentry *dentry, struct inode *inode,
> +				 const char *suffix, void *value, size_t size)
> +{
> +	const char *name = xattr_full_name(handler, suffix);
> +	struct simple_xattrs *xattrs;
> +
> +	xattrs = READ_ONCE(SOCKFS_I(inode)->xattrs);
> +	if (!xattrs)
> +		return -ENODATA;
> +
> +	return simple_xattr_get(xattrs, name, value, size);
> +}
> +
> +static int sockfs_user_xattr_set(const struct xattr_handler *handler,
> +				 struct mnt_idmap *idmap,
> +				 struct dentry *dentry, struct inode *inode,
> +				 const char *suffix, const void *value,
> +				 size_t size, int flags)
> +{
> +	const char *name = xattr_full_name(handler, suffix);
> +	struct sockfs_inode *si = SOCKFS_I(inode);
> +	struct simple_xattrs *xattrs;
> +
> +	xattrs = simple_xattrs_lazy_alloc(&si->xattrs, value, flags);
> +	if (IS_ERR_OR_NULL(xattrs))
> +		return PTR_ERR(xattrs);
> +
> +	return simple_xattr_set_limited(xattrs, &si->xattr_limits,
> +					name, value, size, flags);
> +}
> +
> +static const struct xattr_handler sockfs_user_xattr_handler = {
> +	.prefix = XATTR_USER_PREFIX,
> +	.get = sockfs_user_xattr_get,
> +	.set = sockfs_user_xattr_set,
> +};
> +
>  static const struct xattr_handler * const sockfs_xattr_handlers[] = {
>  	&sockfs_xattr_handler,
>  	&sockfs_security_xattr_handler,
> +	&sockfs_user_xattr_handler,
>  	NULL
>  };
>  
> @@ -572,26 +637,26 @@ EXPORT_SYMBOL(sockfd_lookup);
>  static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
>  				size_t size)
>  {
> -	ssize_t len;
> -	ssize_t used = 0;
> +	struct sockfs_inode *si = SOCKFS_I(d_inode(dentry));
> +	ssize_t len, used;
>  
> -	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
> +	len = simple_xattr_list(d_inode(dentry), READ_ONCE(si->xattrs),
> +				buffer, size);
>  	if (len < 0)
>  		return len;
> -	used += len;
> +
> +	used = len;
>  	if (buffer) {
> -		if (size < used)
> -			return -ERANGE;
>  		buffer += len;
> +		size -= len;
>  	}
>  
> -	len = (XATTR_NAME_SOCKPROTONAME_LEN + 1);
> +	len = XATTR_NAME_SOCKPROTONAME_LEN + 1;
>  	used += len;
>  	if (buffer) {
> -		if (size < used)
> +		if (size < len)
>  			return -ERANGE;
>  		memcpy(buffer, XATTR_NAME_SOCKPROTONAME, len);
> -		buffer += len;
>  	}
>  
>  	return used;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

