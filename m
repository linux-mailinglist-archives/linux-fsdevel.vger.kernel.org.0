Return-Path: <linux-fsdevel+bounces-71332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC2CBDE94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A5C306801B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94BF332918;
	Mon, 15 Dec 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tyx+BBtj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7LhCb5v3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kze3Z+iX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LB1huboI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CE332911
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802643; cv=none; b=aSeCY/zyu2cpivO6LxwkWoAB6klLqBxzXviY07/s1881bhIevQuEGRFI8XQUqvYYwEErcX1OIIcJSKuWJPiIszI734SYTC2jHrj86eRgSGmIVN02LExEfhEl8ZZPPBfbH9pfJLDeTvxOD61M9V++ta3+wpxnEhibpmpgNNwOb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802643; c=relaxed/simple;
	bh=qg1nFezL6rsVHp2pgwwxIJ3NdTIsaEN5hE9JEYbaHbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT33WIcQh2Yz0WnKB79gcoJIpCMpgN8mmExvX76qlk/aSp2xO+gOC85LZ35VNd37fULYLixTwqIcImXk3aHQNmmOMuHHKtYyC1obpo8Jd3cORzS9Kzu4t+cweU+zTSv4tJhQo5IcbDrHR+K5YgdCznKTtZLDUOqwjj1a2zVtQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tyx+BBtj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7LhCb5v3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kze3Z+iX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LB1huboI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFF8A5BDCA;
	Mon, 15 Dec 2025 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765802640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iBPOZxtc9mWU+S05eBwzi8Kq0XkSS70VksoZJFXfd2k=;
	b=Tyx+BBtjrJdOVbED048ihGoAtAydaaaA50V8ouQY64HxnJiqiI+z4ATvFwYV/HiVwUfOkt
	qjBtph+RdJErxTvZIIeioLnFcD4w9JO5Ec4CtclAMH7Uyk8gFvCC11gNy5qyqL0GHjcrDY
	74xVPHswEzTt862B09byMCAv66pPRsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765802640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iBPOZxtc9mWU+S05eBwzi8Kq0XkSS70VksoZJFXfd2k=;
	b=7LhCb5v3IrcWteeM3ncIO+maoBXSDHJtUSxTg7rlUdZ8YF/7yBxqlNGXIw9IQjkuObXTbf
	6eOc4hOWRt8oSGDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765802638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iBPOZxtc9mWU+S05eBwzi8Kq0XkSS70VksoZJFXfd2k=;
	b=kze3Z+iXGc8GqD61KFRDWXHyUsHEpNoAiQH0lzsoBUUKdzj/riZKeX3lHdbaIdKuomgzFS
	C+hSlZyqMuSAnZHxwQKYj2nXq9J8jjTskjMzBq9M+noIGXnM8R+lpWESQAN/Gn8whse9Yn
	OXx48Iqoy3Hi8cjBniy+1z/joBQ1gSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765802638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iBPOZxtc9mWU+S05eBwzi8Kq0XkSS70VksoZJFXfd2k=;
	b=LB1huboIZIP/HMtDd1WaC2eQgeJ0irgbzZ/eyIqoEsY4SF/4QpLipssAjYRvF75rhu5ukU
	QicPqGXZ3Rlw6pBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6DA53EA63;
	Mon, 15 Dec 2025 12:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f+hWOI4CQGmxPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Dec 2025 12:43:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E6C7A0951; Mon, 15 Dec 2025 13:43:50 +0100 (CET)
Date: Mon, 15 Dec 2025 13:43:50 +0100
From: Jan Kara <jack@suse.cz>
To: chen zhang <chenzhang@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, chenzhang_0901@163.com
Subject: Re: [PATCH v2] chardev: Switch to guard(mutex) and __free(kfree)
Message-ID: <v2y34qyxaz2foko67wsrfudqzvmplukb6sck7maij2r7a3xhv2@jy2f5hjwgqk3>
References: <20251215111500.159243-1-chenzhang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215111500.159243-1-chenzhang@kylinos.cn>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]

On Mon 15-12-25 19:15:00, chen zhang wrote:
> Instead of using the 'goto label; mutex_unlock()' pattern use
> 'guard(mutex)' which will release the mutex when it goes out of scope.
> Use the __free(kfree) cleanup to replace instances of manually
> calling kfree(). Also make some code path simplifications that this
> allows.
> 
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/char_dev.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c9..74d4bdfaa9ae 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -10,6 +10,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/cleanup.h>
>  
>  #include <linux/major.h>
>  #include <linux/errno.h>
> @@ -97,7 +98,8 @@ static struct char_device_struct *
>  __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  			   int minorct, const char *name)
>  {
> -	struct char_device_struct *cd, *curr, *prev = NULL;
> +	struct char_device_struct *cd __free(kfree) = NULL;
> +	struct char_device_struct *curr, *prev = NULL;
>  	int ret;
>  	int i;
>  
> @@ -117,14 +119,14 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  	if (cd == NULL)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mutex_lock(&chrdevs_lock);
> +	guard(mutex)(&chrdevs_lock);
>  
>  	if (major == 0) {
>  		ret = find_dynamic_major();
>  		if (ret < 0) {
>  			pr_err("CHRDEV \"%s\" dynamic allocation region is full\n",
>  			       name);
> -			goto out;
> +			return ERR_PTR(ret);
>  		}
>  		major = ret;
>  	}
> @@ -144,7 +146,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  		if (curr->baseminor >= baseminor + minorct)
>  			break;
>  
> -		goto out;
> +		return ERR_PTR(ret);
>  	}
>  
>  	cd->major = major;
> @@ -160,12 +162,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  		prev->next = cd;
>  	}
>  
> -	mutex_unlock(&chrdevs_lock);
> -	return cd;
> -out:
> -	mutex_unlock(&chrdevs_lock);
> -	kfree(cd);
> -	return ERR_PTR(ret);
> +	return_ptr(cd);
>  }
>  
>  static struct char_device_struct *
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

