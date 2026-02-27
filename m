Return-Path: <linux-fsdevel+bounces-78720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBUwMvetoWk3vgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:45:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8D1B929B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D0FE30EF69E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2713A4218B5;
	Fri, 27 Feb 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgQomRz0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYKCPPXK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGlBNUG9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWOPGpZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456841C2FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203434; cv=none; b=eyeawqiFCZ9K4sgZuhUHH8rHIF4Ut+89sjk6WrBnP9zBvMvr//Bc/zmxJ5VaMXlButeAXQPDTB48ax5nzqshgPn+RhgC/vyNmHav5nWbnD8cyTh/LgZM2a3X4CKYVZYkr0jnMOmdiffS89z0BZ5cFsr+J58HBEAqCauCps395O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203434; c=relaxed/simple;
	bh=mbSS61NwPWRv/VIdudtXBI5PmLnUKSo903VnFyVbElA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH35c7ZkDNpVyeSgp43cQCbuAjbXPMGUp8Mqb1G4vWuR5qUfwkT5dhZN3TgaTBEhID/2MJzNco4pbvYhtzy9O8y3BiDjhZDwDd6pXAl707Jg54YCIVMLBMUDKxf5xL7SP0d4SunyYhXJq3mxkKNP6ts1516ihArVysPgGj1GGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgQomRz0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYKCPPXK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGlBNUG9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWOPGpZ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E309967FEC;
	Fri, 27 Feb 2026 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772203430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Qm56mg7WdMgLO+ACnpvLqpMB5iei+ds8qmhq92j7g=;
	b=PgQomRz0Mu5bg/41FmpV9hfQZbPwtFQmPcDE6lX0VNUAvTg/zqjUobEKzgUA74j9T+oPtW
	PoQqRlSfzNPn/NqADrxv0y2llWlOaqRvVNeBoPQUH+wpLpBb0txjPqHNYqLBmhE6sVwvsr
	YuJfQ+zQwOcDb9HKiL3ziPG7j+ikdeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772203430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Qm56mg7WdMgLO+ACnpvLqpMB5iei+ds8qmhq92j7g=;
	b=jYKCPPXKQhcfrP3QNZgjj3GOCfEtnbiemv7G9jZUWqQT3f4cGikm8eY50mzzHenWWiz1Cm
	Ci4eh1VhDC7btCAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772203429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Qm56mg7WdMgLO+ACnpvLqpMB5iei+ds8qmhq92j7g=;
	b=kGlBNUG9cEiR1S6df/6XAC84+QcMsWWpT2h37gwQThNxqRVdBlp6gPi4auwoWQGIDlrW70
	WfzEixqx9FMOQhkuQ32aIcEukxswrtiwNNgy5SBOujsIX321B/hy3XzxwjGM16G7Hp9d/n
	UgDX2S6RsGKzj9bXPQXkevvNtuhJe1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772203429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Qm56mg7WdMgLO+ACnpvLqpMB5iei+ds8qmhq92j7g=;
	b=jWOPGpZ2RuTRDDmWMsWs5BSp5waOZEiP0MY10mZ9rfe80mmOokOwd6RGtgxoi197R5hYvl
	gd9+motrpkBJMaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62863EA69;
	Fri, 27 Feb 2026 14:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CjRINKWtoWmXeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 14:43:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4342A06D4; Fri, 27 Feb 2026 15:43:41 +0100 (CET)
Date: Fri, 27 Feb 2026 15:43:41 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 02/14] xattr: add rhashtable-based simple_xattr
 infrastructure
Message-ID: <75sidfn6zjiodrl3uhaqpakapef5nnjhfumawmxyy7gmumy5lt@lsra3hwfh5p6>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-2-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-2-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78720-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 3BE8D1B929B
X-Rspamd-Action: no action

On Mon 16-02-26 14:31:58, Christian Brauner wrote:
> Add rhashtable support to the simple_xattr subsystem while keeping the
> existing rbtree code fully functional. This allows consumers to be
> migrated one at a time without breaking any intermediate build.
> 
> struct simple_xattrs gains a dispatch flag and a union holding either
> the rbtree (rb_root + rwlock) or rhashtable state:
> 
>   struct simple_xattrs {
>       bool use_rhashtable;
>       union {
>           struct { struct rb_root rb_root; rwlock_t lock; };
>           struct rhashtable ht;
>       };
>   };
> 
> simple_xattrs_init() continues to set up the rbtree path for existing
> embedded-struct callers.
> 
> Add simple_xattrs_alloc() which dynamically allocates a simple_xattrs
> and initializes the rhashtable path. This is the entry point for
> consumers switching to pointer-based lazy allocation.
> 
> The five core functions (get, set, list, add, free) dispatch based on
> the use_rhashtable flag.
> 
> Existing callers continue to use the rbtree path unchanged. As each
> consumer is converted it will switch to simple_xattrs_alloc() and the
> rhashtable path. Once all consumers are converted a follow-up patch
> will remove the rbtree code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c            | 439 ++++++++++++++++++++++++++++++++++++++------------
>  include/linux/xattr.h |  25 ++-
>  mm/shmem.c            |   2 +-
>  3 files changed, 357 insertions(+), 109 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 9cbb1917bcb2..1d98ea459b7b 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -22,6 +22,7 @@
>  #include <linux/audit.h>
>  #include <linux/vmalloc.h>
>  #include <linux/posix_acl_xattr.h>
> +#include <linux/rhashtable.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -1228,22 +1229,25 @@ void simple_xattr_free_rcu(struct simple_xattr *xattr)
>   * Allocate a new xattr object and initialize respective members. The caller is
>   * responsible for handling the name of the xattr.
>   *
> - * Return: On success a new xattr object is returned. On failure NULL is
> - * returned.
> + * Return: New xattr object on success, NULL if @value is NULL, ERR_PTR on
> + * failure.
>   */
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  {
>  	struct simple_xattr *new_xattr;
>  	size_t len;
>  
> +	if (!value)
> +		return NULL;
> +
>  	/* wrap around? */
>  	len = sizeof(*new_xattr) + size;
>  	if (len < sizeof(*new_xattr))
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
>  	if (!new_xattr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	new_xattr->size = size;
>  	memcpy(new_xattr->value, value, size);
> @@ -1287,6 +1291,33 @@ static int rbtree_simple_xattr_node_cmp(struct rb_node *new_node,
>  	return rbtree_simple_xattr_cmp(xattr->name, node);
>  }
>  
> +static u32 simple_xattr_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const char *name = data;
> +	return jhash(name, strlen(name), seed);
> +}
> +
> +static u32 simple_xattr_obj_hashfn(const void *obj, u32 len, u32 seed)
> +{
> +	const struct simple_xattr *xattr = obj;
> +	return jhash(xattr->name, strlen(xattr->name), seed);
> +}
> +
> +static int simple_xattr_obj_cmpfn(struct rhashtable_compare_arg *arg,
> +				   const void *obj)
> +{
> +	const struct simple_xattr *xattr = obj;
> +	return strcmp(xattr->name, arg->key);
> +}
> +
> +static const struct rhashtable_params simple_xattr_params = {
> +	.head_offset    = offsetof(struct simple_xattr, hash_node),
> +	.hashfn         = simple_xattr_hashfn,
> +	.obj_hashfn     = simple_xattr_obj_hashfn,
> +	.obj_cmpfn      = simple_xattr_obj_cmpfn,
> +	.automatic_shrinking = true,
> +};
> +
>  /**
>   * simple_xattr_get - get an xattr object
>   * @xattrs: the header of the xattr object
> @@ -1306,22 +1337,41 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size)
>  {
>  	struct simple_xattr *xattr = NULL;
> -	struct rb_node *rbp;
>  	int ret = -ENODATA;
>  
> -	read_lock(&xattrs->lock);
> -	rbp = rb_find(name, &xattrs->rb_root, rbtree_simple_xattr_cmp);
> -	if (rbp) {
> -		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> -		ret = xattr->size;
> -		if (buffer) {
> -			if (size < xattr->size)
> -				ret = -ERANGE;
> -			else
> -				memcpy(buffer, xattr->value, xattr->size);
> +	if (xattrs->use_rhashtable) {
> +		guard(rcu)();
> +		xattr = rhashtable_lookup(&xattrs->ht, name,
> +					  simple_xattr_params);
> +		if (xattr) {
> +			ret = xattr->size;
> +			if (buffer) {
> +				if (size < xattr->size)
> +					ret = -ERANGE;
> +				else
> +					memcpy(buffer, xattr->value,
> +					       xattr->size);
> +			}
> +		}
> +	} else {
> +		struct rb_node *rbp;
> +
> +		read_lock(&xattrs->lock);
> +		rbp = rb_find(name, &xattrs->rb_root,
> +			      rbtree_simple_xattr_cmp);
> +		if (rbp) {
> +			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +			ret = xattr->size;
> +			if (buffer) {
> +				if (size < xattr->size)
> +					ret = -ERANGE;
> +				else
> +					memcpy(buffer, xattr->value,
> +					       xattr->size);
> +			}
>  		}
> +		read_unlock(&xattrs->lock);
>  	}
> -	read_unlock(&xattrs->lock);
>  	return ret;
>  }
>  
> @@ -1355,78 +1405,134 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  				      const char *name, const void *value,
>  				      size_t size, int flags)
>  {
> -	struct simple_xattr *old_xattr = NULL, *new_xattr = NULL;
> -	struct rb_node *parent = NULL, **rbp;
> -	int err = 0, ret;
> +	struct simple_xattr *old_xattr = NULL;
> +	int err = 0;
>  
> -	/* value == NULL means remove */
> -	if (value) {
> -		new_xattr = simple_xattr_alloc(value, size);
> -		if (!new_xattr)
> -			return ERR_PTR(-ENOMEM);
> +	CLASS(simple_xattr, new_xattr)(value, size);
> +	if (IS_ERR(new_xattr))
> +		return new_xattr;
>  
> +	if (new_xattr) {
>  		new_xattr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
> -		if (!new_xattr->name) {
> -			simple_xattr_free(new_xattr);
> +		if (!new_xattr->name)
>  			return ERR_PTR(-ENOMEM);
> -		}
>  	}
>  
> -	write_lock(&xattrs->lock);
> -	rbp = &xattrs->rb_root.rb_node;
> -	while (*rbp) {
> -		parent = *rbp;
> -		ret = rbtree_simple_xattr_cmp(name, *rbp);
> -		if (ret < 0)
> -			rbp = &(*rbp)->rb_left;
> -		else if (ret > 0)
> -			rbp = &(*rbp)->rb_right;
> -		else
> -			old_xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
> -		if (old_xattr)
> -			break;
> -	}
> +	if (xattrs->use_rhashtable) {
> +		/*
> +		 * Lookup is safe without RCU here since writes are
> +		 * serialized by the caller.
> +		 */
> +		old_xattr = rhashtable_lookup_fast(&xattrs->ht, name,
> +						   simple_xattr_params);
> +
> +		if (old_xattr) {
> +			/* Fail if XATTR_CREATE is requested and the xattr exists. */
> +			if (flags & XATTR_CREATE)
> +				return ERR_PTR(-EEXIST);
> +
> +			if (new_xattr) {
> +				err = rhashtable_replace_fast(&xattrs->ht,
> +							     &old_xattr->hash_node,
> +							     &new_xattr->hash_node,
> +							     simple_xattr_params);
> +				if (err)
> +					return ERR_PTR(err);
> +			} else {
> +				err = rhashtable_remove_fast(&xattrs->ht,
> +							    &old_xattr->hash_node,
> +							    simple_xattr_params);
> +				if (err)
> +					return ERR_PTR(err);
> +			}
> +		} else {
> +			/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> +			if (flags & XATTR_REPLACE)
> +				return ERR_PTR(-ENODATA);
> +
> +			/*
> +			 * If XATTR_CREATE or no flags are specified together
> +			 * with a new value simply insert it.
> +			 */
> +			if (new_xattr) {
> +				err = rhashtable_insert_fast(&xattrs->ht,
> +							    &new_xattr->hash_node,
> +							    simple_xattr_params);
> +				if (err)
> +					return ERR_PTR(err);
> +			}
>  
> -	if (old_xattr) {
> -		/* Fail if XATTR_CREATE is requested and the xattr exists. */
> -		if (flags & XATTR_CREATE) {
> -			err = -EEXIST;
> -			goto out_unlock;
> +			/*
> +			 * If XATTR_CREATE or no flags are specified and
> +			 * neither an old or new xattr exist then we don't
> +			 * need to do anything.
> +			 */
>  		}
> -
> -		if (new_xattr)
> -			rb_replace_node(&old_xattr->rb_node,
> -					&new_xattr->rb_node, &xattrs->rb_root);
> -		else
> -			rb_erase(&old_xattr->rb_node, &xattrs->rb_root);
>  	} else {
> -		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> -		if (flags & XATTR_REPLACE) {
> -			err = -ENODATA;
> -			goto out_unlock;
> -		}
> +		struct rb_node *parent = NULL, **rbp;
> +		int ret;
>  
> -		/*
> -		 * If XATTR_CREATE or no flags are specified together with a
> -		 * new value simply insert it.
> -		 */
> -		if (new_xattr) {
> -			rb_link_node(&new_xattr->rb_node, parent, rbp);
> -			rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
> +		write_lock(&xattrs->lock);
> +		rbp = &xattrs->rb_root.rb_node;
> +		while (*rbp) {
> +			parent = *rbp;
> +			ret = rbtree_simple_xattr_cmp(name, *rbp);
> +			if (ret < 0)
> +				rbp = &(*rbp)->rb_left;
> +			else if (ret > 0)
> +				rbp = &(*rbp)->rb_right;
> +			else
> +				old_xattr = rb_entry(*rbp, struct simple_xattr,
> +						     rb_node);
> +			if (old_xattr)
> +				break;
>  		}
>  
> -		/*
> -		 * If XATTR_CREATE or no flags are specified and neither an
> -		 * old or new xattr exist then we don't need to do anything.
> -		 */
> -	}
> +		if (old_xattr) {
> +			/* Fail if XATTR_CREATE is requested and the xattr exists. */
> +			if (flags & XATTR_CREATE) {
> +				err = -EEXIST;
> +				goto out_unlock;
> +			}
> +
> +			if (new_xattr)
> +				rb_replace_node(&old_xattr->rb_node,
> +						&new_xattr->rb_node,
> +						&xattrs->rb_root);
> +			else
> +				rb_erase(&old_xattr->rb_node,
> +					 &xattrs->rb_root);
> +		} else {
> +			/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> +			if (flags & XATTR_REPLACE) {
> +				err = -ENODATA;
> +				goto out_unlock;
> +			}
> +
> +			/*
> +			 * If XATTR_CREATE or no flags are specified together
> +			 * with a new value simply insert it.
> +			 */
> +			if (new_xattr) {
> +				rb_link_node(&new_xattr->rb_node, parent, rbp);
> +				rb_insert_color(&new_xattr->rb_node,
> +						&xattrs->rb_root);
> +			}
> +
> +			/*
> +			 * If XATTR_CREATE or no flags are specified and
> +			 * neither an old or new xattr exist then we don't
> +			 * need to do anything.
> +			 */
> +		}
>  
>  out_unlock:
> -	write_unlock(&xattrs->lock);
> -	if (!err)
> -		return old_xattr;
> -	simple_xattr_free(new_xattr);
> -	return ERR_PTR(err);
> +		write_unlock(&xattrs->lock);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +	retain_and_null_ptr(new_xattr);
> +	return old_xattr;
>  }
>  
>  static bool xattr_is_trusted(const char *name)
> @@ -1467,7 +1573,6 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  {
>  	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
>  	struct simple_xattr *xattr;
> -	struct rb_node *rbp;
>  	ssize_t remaining_size = size;
>  	int err = 0;
>  
> @@ -1487,23 +1592,62 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  	remaining_size -= err;
>  	err = 0;
>  
> -	read_lock(&xattrs->lock);
> -	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
> -		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +	if (!xattrs)
> +		return size - remaining_size;
>  
> -		/* skip "trusted." attributes for unprivileged callers */
> -		if (!trusted && xattr_is_trusted(xattr->name))
> -			continue;
> +	if (xattrs->use_rhashtable) {
> +		struct rhashtable_iter iter;
>  
> -		/* skip MAC labels; these are provided by LSM above */
> -		if (xattr_is_maclabel(xattr->name))
> -			continue;
> +		rhashtable_walk_enter(&xattrs->ht, &iter);
> +		rhashtable_walk_start(&iter);
>  
> -		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
> -		if (err)
> -			break;
> +		while ((xattr = rhashtable_walk_next(&iter)) != NULL) {
> +			if (IS_ERR(xattr)) {
> +				if (PTR_ERR(xattr) == -EAGAIN)
> +					continue;
> +				err = PTR_ERR(xattr);
> +				break;
> +			}
> +
> +			/* skip "trusted." attributes for unprivileged callers */
> +			if (!trusted && xattr_is_trusted(xattr->name))
> +				continue;
> +
> +			/* skip MAC labels; these are provided by LSM above */
> +			if (xattr_is_maclabel(xattr->name))
> +				continue;
> +
> +			err = xattr_list_one(&buffer, &remaining_size,
> +					     xattr->name);
> +			if (err)
> +				break;
> +		}
> +
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +	} else {
> +		struct rb_node *rbp;
> +
> +		read_lock(&xattrs->lock);
> +		for (rbp = rb_first(&xattrs->rb_root); rbp;
> +		     rbp = rb_next(rbp)) {
> +			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +
> +			/* skip "trusted." attributes for unprivileged callers */
> +			if (!trusted && xattr_is_trusted(xattr->name))
> +				continue;
> +
> +			/* skip MAC labels; these are provided by LSM above */
> +			if (xattr_is_maclabel(xattr->name))
> +				continue;
> +
> +			err = xattr_list_one(&buffer, &remaining_size,
> +					     xattr->name);
> +			if (err)
> +				break;
> +		}
> +		read_unlock(&xattrs->lock);
>  	}
> -	read_unlock(&xattrs->lock);
>  
>  	return err ? err : size - remaining_size;
>  }
> @@ -1536,9 +1680,16 @@ static bool rbtree_simple_xattr_less(struct rb_node *new_node,
>  void simple_xattr_add(struct simple_xattrs *xattrs,
>  		      struct simple_xattr *new_xattr)
>  {
> -	write_lock(&xattrs->lock);
> -	rb_add(&new_xattr->rb_node, &xattrs->rb_root, rbtree_simple_xattr_less);
> -	write_unlock(&xattrs->lock);
> +	if (xattrs->use_rhashtable) {
> +		WARN_ON(rhashtable_insert_fast(&xattrs->ht,
> +					       &new_xattr->hash_node,
> +					       simple_xattr_params));
> +	} else {
> +		write_lock(&xattrs->lock);
> +		rb_add(&new_xattr->rb_node, &xattrs->rb_root,
> +		       rbtree_simple_xattr_less);
> +		write_unlock(&xattrs->lock);
> +	}
>  }
>  
>  /**
> @@ -1549,10 +1700,80 @@ void simple_xattr_add(struct simple_xattrs *xattrs,
>   */
>  void simple_xattrs_init(struct simple_xattrs *xattrs)
>  {
> +	xattrs->use_rhashtable = false;
>  	xattrs->rb_root = RB_ROOT;
>  	rwlock_init(&xattrs->lock);
>  }
>  
> +/**
> + * simple_xattrs_alloc - allocate and initialize a new xattr header
> + *
> + * Dynamically allocate a simple_xattrs header and initialize the
> + * underlying rhashtable. This is intended for consumers that want
> + * rhashtable-based xattr storage.
> + *
> + * Return: On success a new simple_xattrs is returned. On failure an
> + * ERR_PTR is returned.
> + */
> +struct simple_xattrs *simple_xattrs_alloc(void)
> +{
> +	struct simple_xattrs *xattrs __free(kfree) = NULL;
> +
> +	xattrs = kzalloc(sizeof(*xattrs), GFP_KERNEL);
> +	if (!xattrs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	xattrs->use_rhashtable = true;
> +	if (rhashtable_init(&xattrs->ht, &simple_xattr_params))
> +		return ERR_PTR(-ENOMEM);
> +
> +	return no_free_ptr(xattrs);
> +}
> +
> +/**
> + * simple_xattrs_lazy_alloc - get or allocate xattrs for a set operation
> + * @xattrsp: pointer to the xattrs pointer (may point to NULL)
> + * @value: value being set (NULL means remove)
> + * @flags: xattr set flags
> + *
> + * For lazily-allocated xattrs on the write path. If no xattrs exist yet
> + * and this is a remove operation, returns the appropriate result without
> + * allocating. Otherwise ensures xattrs is allocated and published with
> + * store-release semantics.
> + *
> + * Return: On success a valid pointer to the xattrs is returned. On
> + * failure or early-exit an ERR_PTR or NULL is returned. Callers should
> + * check with IS_ERR_OR_NULL() and propagate with PTR_ERR() which
> + * correctly returns 0 for the NULL no-op case.
> + */
> +struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
> +					       const void *value, int flags)
> +{
> +	struct simple_xattrs *xattrs;
> +
> +	xattrs = READ_ONCE(*xattrsp);
> +	if (xattrs)
> +		return xattrs;
> +
> +	if (!value)
> +		return (flags & XATTR_REPLACE) ? ERR_PTR(-ENODATA) : NULL;
> +
> +	xattrs = simple_xattrs_alloc();
> +	if (!IS_ERR(xattrs))
> +		smp_store_release(xattrsp, xattrs);
> +	return xattrs;
> +}
> +
> +static void simple_xattr_ht_free(void *ptr, void *arg)
> +{
> +	struct simple_xattr *xattr = ptr;
> +	size_t *freed_space = arg;
> +
> +	if (freed_space)
> +		*freed_space += simple_xattr_space(xattr->name, xattr->size);
> +	simple_xattr_free(xattr);
> +}
> +
>  /**
>   * simple_xattrs_free - free xattrs
>   * @xattrs: xattr header whose xattrs to destroy
> @@ -1563,22 +1784,28 @@ void simple_xattrs_init(struct simple_xattrs *xattrs)
>   */
>  void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space)
>  {
> -	struct rb_node *rbp;
> -
>  	if (freed_space)
>  		*freed_space = 0;
> -	rbp = rb_first(&xattrs->rb_root);
> -	while (rbp) {
> -		struct simple_xattr *xattr;
> -		struct rb_node *rbp_next;
> -
> -		rbp_next = rb_next(rbp);
> -		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> -		rb_erase(&xattr->rb_node, &xattrs->rb_root);
> -		if (freed_space)
> -			*freed_space += simple_xattr_space(xattr->name,
> -							   xattr->size);
> -		simple_xattr_free(xattr);
> -		rbp = rbp_next;
> +
> +	if (xattrs->use_rhashtable) {
> +		rhashtable_free_and_destroy(&xattrs->ht,
> +					    simple_xattr_ht_free, freed_space);
> +	} else {
> +		struct rb_node *rbp;
> +
> +		rbp = rb_first(&xattrs->rb_root);
> +		while (rbp) {
> +			struct simple_xattr *xattr;
> +			struct rb_node *rbp_next;
> +
> +			rbp_next = rb_next(rbp);
> +			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +			rb_erase(&xattr->rb_node, &xattrs->rb_root);
> +			if (freed_space)
> +				*freed_space += simple_xattr_space(xattr->name,
> +								   xattr->size);
> +			simple_xattr_free(xattr);
> +			rbp = rbp_next;
> +		}
>  	}
>  }
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 1328f2bfd2ce..ee4fd40717a0 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -107,8 +107,14 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
>  }
>  
>  struct simple_xattrs {
> -	struct rb_root rb_root;
> -	rwlock_t lock;
> +	bool use_rhashtable;
> +	union {
> +		struct {
> +			struct rb_root rb_root;
> +			rwlock_t lock;
> +		};
> +		struct rhashtable ht;
> +	};
>  };
>  
>  struct simple_xattr {
> @@ -121,6 +127,9 @@ struct simple_xattr {
>  };
>  
>  void simple_xattrs_init(struct simple_xattrs *xattrs);
> +struct simple_xattrs *simple_xattrs_alloc(void);
> +struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
> +					       const void *value, int flags);
>  void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space);
>  size_t simple_xattr_space(const char *name, size_t size);
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
> @@ -137,4 +146,16 @@ void simple_xattr_add(struct simple_xattrs *xattrs,
>  		      struct simple_xattr *new_xattr);
>  int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
>  
> +DEFINE_CLASS(simple_xattr,
> +	     struct simple_xattr *,
> +	     if (!IS_ERR_OR_NULL(_T)) simple_xattr_free(_T),
> +	     simple_xattr_alloc(value, size),
> +	     const void *value, size_t size)
> +
> +DEFINE_CLASS(simple_xattrs,
> +            struct simple_xattrs *,
> +            if (!IS_ERR_OR_NULL(_T)) { simple_xattrs_free(_T, NULL); kfree(_T); },
> +            simple_xattrs_alloc(),
> +            void)
> +
>  #endif	/* _LINUX_XATTR_H */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 063b4c3e4ccb..fc8020ce2e9f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4293,7 +4293,7 @@ static int shmem_initxattrs(struct inode *inode,
>  
>  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
>  		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
> -		if (!new_xattr)
> +		if (IS_ERR(new_xattr))
>  			break;
>  
>  		len = strlen(xattr->name) + 1;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

