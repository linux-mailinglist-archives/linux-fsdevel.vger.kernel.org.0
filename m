Return-Path: <linux-fsdevel+bounces-78719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMpFE6etoWk3vgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:43:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3631B9265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4227D309D199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372841C31C;
	Fri, 27 Feb 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZoHzfiTE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J901+09n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZoHzfiTE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J901+09n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140241C2EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203419; cv=none; b=rJFfx8BHwiy3hxI/NfGq4ceujfEEJldQ/JJf8Xm996LoEZlTovss+6tiFrnMNng8tLO5fLuOr19XpJ6aih4t25DggdvgxNiW+nCsIbAjveOmDROlpB1iDw/7tGR5OYS5AGBRfbj4i2K8x06wBKe/Xyl2Zhpgc+4J0a/LCsl+YKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203419; c=relaxed/simple;
	bh=zJzCKImqsgZeIOLfYm/UGl6q/lJoADe4Q+Yerq9X/nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBaaM2LCEwZb+G5EbPIb5jg1tL5da4U6k7tKLnZoc/+Xb4hKLGHMlpF+ocQ9dnrpdqZnxDtREofVsq8TqHHghzMNK+PD89bCSqD/a3drVubnWRGZn1O1e7RanAvCjuARgVB9tVVS+J3q0aDlZ1a1mUafyimZdmknVQM0tnne0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZoHzfiTE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J901+09n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZoHzfiTE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J901+09n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2FDE6B025;
	Fri, 27 Feb 2026 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772203416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9LKCiBVL3H1H1O10DFdcwMW83GWaN+Qa6e2JLqtQoM=;
	b=ZoHzfiTEUZFC5kSAbwWL0Xdwus5dTFIKH7DBiFmndaRaiWZedeixp6+B6wSgJmqUU2w3JX
	sOYw0zH20DxH4UMAduA4kIE5kcau3NeCPqz9hgl3wGLRZfU2Wt/YUpIIL5WY/hTY/ZjQHj
	7pH4iGvTPI8u3F6uxyq5eeHMPYUL8pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772203416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9LKCiBVL3H1H1O10DFdcwMW83GWaN+Qa6e2JLqtQoM=;
	b=J901+09n3K5/8bTE8FLKROZyCMy8zTVNsMgbi60qMgdgQcwwUNLd/CDiJV/mRZXWmM8zf3
	9yETEUKOXsb7M8BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZoHzfiTE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J901+09n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772203416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9LKCiBVL3H1H1O10DFdcwMW83GWaN+Qa6e2JLqtQoM=;
	b=ZoHzfiTEUZFC5kSAbwWL0Xdwus5dTFIKH7DBiFmndaRaiWZedeixp6+B6wSgJmqUU2w3JX
	sOYw0zH20DxH4UMAduA4kIE5kcau3NeCPqz9hgl3wGLRZfU2Wt/YUpIIL5WY/hTY/ZjQHj
	7pH4iGvTPI8u3F6uxyq5eeHMPYUL8pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772203416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9LKCiBVL3H1H1O10DFdcwMW83GWaN+Qa6e2JLqtQoM=;
	b=J901+09n3K5/8bTE8FLKROZyCMy8zTVNsMgbi60qMgdgQcwwUNLd/CDiJV/mRZXWmM8zf3
	9yETEUKOXsb7M8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A82CF3EA69;
	Fri, 27 Feb 2026 14:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PVwDKZitoWkJeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 14:43:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6BD42A06D4; Fri, 27 Feb 2026 15:43:28 +0100 (CET)
Date: Fri, 27 Feb 2026 15:43:28 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 01/14] xattr: add rcu_head and rhash_head to struct
 simple_xattr
Message-ID: <vk7mausaumazk6iho7f2z7ld7byeyjhyczietf4rdi3c4dt3ya@ytbqtfdwvmfp>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-1-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-1-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78719-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 9A3631B9265
X-Rspamd-Action: no action

On Mon 16-02-26 14:31:57, Christian Brauner wrote:
> In preparation for converting simple_xattrs from rbtree to rhashtable,
> add rhash_head and rcu_head members to struct simple_xattr. The
> rhashtable implementation will use rhash_head for hash table linkage
> and RCU-based lockless reads, requiring that replaced or removed xattr
> entries be freed via call_rcu() rather than immediately.
> 
> Add simple_xattr_free_rcu() which schedules RCU-deferred freeing of an
> xattr entry.  This will be used by callers of simple_xattr_set() once
> they switch to the rhashtable-based xattr store.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c            | 23 +++++++++++++++++++++++
>  include/linux/xattr.h |  4 ++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 3e49e612e1ba..9cbb1917bcb2 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1197,6 +1197,29 @@ void simple_xattr_free(struct simple_xattr *xattr)
>  	kvfree(xattr);
>  }
>  
> +static void simple_xattr_rcu_free(struct rcu_head *head)
> +{
> +	struct simple_xattr *xattr;
> +
> +	xattr = container_of(head, struct simple_xattr, rcu);
> +	simple_xattr_free(xattr);
> +}
> +
> +/**
> + * simple_xattr_free_rcu - free an xattr object after an RCU grace period
> + * @xattr: the xattr object
> + *
> + * Schedule RCU-deferred freeing of an xattr entry. This is used by
> + * rhashtable-based callers of simple_xattr_set() that replace or remove
> + * an existing entry while concurrent RCU readers may still be accessing
> + * it.
> + */
> +void simple_xattr_free_rcu(struct simple_xattr *xattr)
> +{
> +	if (xattr)
> +		call_rcu(&xattr->rcu, simple_xattr_rcu_free);
> +}
> +
>  /**
>   * simple_xattr_alloc - allocate new xattr object
>   * @value: value of the xattr object
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 64e9afe7d647..1328f2bfd2ce 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/spinlock.h>
>  #include <linux/mm.h>
> +#include <linux/rhashtable-types.h>
>  #include <linux/user_namespace.h>
>  #include <uapi/linux/xattr.h>
>  
> @@ -112,6 +113,8 @@ struct simple_xattrs {
>  
>  struct simple_xattr {
>  	struct rb_node rb_node;
> +	struct rhash_head hash_node;
> +	struct rcu_head rcu;
>  	char *name;
>  	size_t size;
>  	char value[];
> @@ -122,6 +125,7 @@ void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space);
>  size_t simple_xattr_space(const char *name, size_t size);
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
>  void simple_xattr_free(struct simple_xattr *xattr);
> +void simple_xattr_free_rcu(struct simple_xattr *xattr);
>  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size);
>  struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

