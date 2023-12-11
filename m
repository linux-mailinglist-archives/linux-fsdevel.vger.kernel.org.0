Return-Path: <linux-fsdevel+bounces-5474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FDB80C9BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E2281B42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D953B2B7;
	Mon, 11 Dec 2023 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GC+Uu/e/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xb1u/opL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GC+Uu/e/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xb1u/opL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B1FD;
	Mon, 11 Dec 2023 04:27:45 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 981E01FB89;
	Mon, 11 Dec 2023 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702297663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRp5JZOLaDGIt1euLIzxVzZlF40hG272GOIIjwjFT+w=;
	b=GC+Uu/e/ocPNXrJ5Y2r2iM32Qj731uQfxibv5fq4OCZTA5j1SBMbbPYCH4LSHrZp+aJYEm
	URMznUUTapY+IqmN2me8hJjcXfb2NR/kWVsMeeEJVlMHNnnc2LaAnl8zhtuEs0E0qRt7b2
	UfMQpwORK3uvSn6hv/9Togbiphh7ALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702297663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRp5JZOLaDGIt1euLIzxVzZlF40hG272GOIIjwjFT+w=;
	b=Xb1u/opLXlXIvKx3qOo/Zc0tuR3IDvCm9PUSMa1Bkg3ULtpm8xgT4I0m7+gVM8yxBuEhKe
	3neZWdlpXvEUhtAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702297663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRp5JZOLaDGIt1euLIzxVzZlF40hG272GOIIjwjFT+w=;
	b=GC+Uu/e/ocPNXrJ5Y2r2iM32Qj731uQfxibv5fq4OCZTA5j1SBMbbPYCH4LSHrZp+aJYEm
	URMznUUTapY+IqmN2me8hJjcXfb2NR/kWVsMeeEJVlMHNnnc2LaAnl8zhtuEs0E0qRt7b2
	UfMQpwORK3uvSn6hv/9Togbiphh7ALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702297663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRp5JZOLaDGIt1euLIzxVzZlF40hG272GOIIjwjFT+w=;
	b=Xb1u/opLXlXIvKx3qOo/Zc0tuR3IDvCm9PUSMa1Bkg3ULtpm8xgT4I0m7+gVM8yxBuEhKe
	3neZWdlpXvEUhtAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 886E9138FF;
	Mon, 11 Dec 2023 12:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DRtNIT8Ad2UbRQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 12:27:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06FB7A07E3; Mon, 11 Dec 2023 13:27:43 +0100 (CET)
Date: Mon, 11 Dec 2023 13:27:42 +0100
From: Jan Kara <jack@suse.cz>
To: Chao Yu <chao@kernel.org>
Cc: jack@suse.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] quota: convert dquot_claim_space_nodirty() to return void
Message-ID: <20231211122742.xnubwtret5za2mc2@quack3>
References: <20231210025028.3262900-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210025028.3262900-1-chao@kernel.org>
X-Spam-Level: 
X-Spam-Score: -3.80
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sun 10-12-23 10:50:28, Chao Yu wrote:
> dquot_claim_space_nodirty() always return zero, let's convert it
> to return void, then, its caller can get rid of handling failure
> case.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Nice. I've added the patch to my tree. Thanks!

								Honza

> ---
>  fs/quota/dquot.c         |  6 +++---
>  include/linux/quotaops.h | 15 +++++----------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 58b5de081b57..44ff2813ae51 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1787,7 +1787,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
>  /*
>   * Convert in-memory reserved quotas to real consumed quotas
>   */
> -int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
> +void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  {
>  	struct dquot **dquots;
>  	int cnt, index;
> @@ -1797,7 +1797,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  		*inode_reserved_space(inode) -= number;
>  		__inode_add_bytes(inode, number);
>  		spin_unlock(&inode->i_lock);
> -		return 0;
> +		return;
>  	}
>  
>  	dquots = i_dquot(inode);
> @@ -1822,7 +1822,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  	spin_unlock(&inode->i_lock);
>  	mark_all_dquot_dirty(dquots);
>  	srcu_read_unlock(&dquot_srcu, index);
> -	return 0;
> +	return;
>  }
>  EXPORT_SYMBOL(dquot_claim_space_nodirty);
>  
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index 4fa4ef0a173a..06cc8888199e 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -74,7 +74,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags);
>  
>  int dquot_alloc_inode(struct inode *inode);
>  
> -int dquot_claim_space_nodirty(struct inode *inode, qsize_t number);
> +void dquot_claim_space_nodirty(struct inode *inode, qsize_t number);
>  void dquot_free_inode(struct inode *inode);
>  void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number);
>  
> @@ -257,10 +257,9 @@ static inline void __dquot_free_space(struct inode *inode, qsize_t number,
>  		inode_sub_bytes(inode, number);
>  }
>  
> -static inline int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
> +static inline void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  {
>  	inode_add_bytes(inode, number);
> -	return 0;
>  }
>  
>  static inline int dquot_reclaim_space_nodirty(struct inode *inode,
> @@ -358,14 +357,10 @@ static inline int dquot_reserve_block(struct inode *inode, qsize_t nr)
>  				DQUOT_SPACE_WARN|DQUOT_SPACE_RESERVE);
>  }
>  
> -static inline int dquot_claim_block(struct inode *inode, qsize_t nr)
> +static inline void dquot_claim_block(struct inode *inode, qsize_t nr)
>  {
> -	int ret;
> -
> -	ret = dquot_claim_space_nodirty(inode, nr << inode->i_blkbits);
> -	if (!ret)
> -		mark_inode_dirty_sync(inode);
> -	return ret;
> +	dquot_claim_space_nodirty(inode, nr << inode->i_blkbits);
> +	mark_inode_dirty_sync(inode);
>  }
>  
>  static inline void dquot_reclaim_block(struct inode *inode, qsize_t nr)
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

