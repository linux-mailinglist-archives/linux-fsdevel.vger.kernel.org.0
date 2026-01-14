Return-Path: <linux-fsdevel+bounces-73797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E107D20BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BDBF3050CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0AE43AA4;
	Wed, 14 Jan 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iS7tUH/Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MR0/rtm6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OZSxcWIV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y7oOVPk1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14F275AF0
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414317; cv=none; b=FAVQMOTAOUPpid+cgm5uyDPv5zAc3d7JjNEoC4wPNu2986uUax3esYVXGqu2E4Zi0KqZ42Rj4Q9L7MFNx0zXt55pz1+lcCpCe/y/B9VyyUP0zl8OmuT9mfnOdq8bkKtUcJW5lHwCN09XLen74wZFZu2IzWJeqNhlvBJvw265FlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414317; c=relaxed/simple;
	bh=Ew1704AjUhIBECUWZm25+SYbyVxT3VpjR93JUzjFUHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWTKLli8CEMPOSUia1JOovZWLdfueMjOqGWZeOUbESYZ+iYQuzRJd+F3292DBS5FFve+bNuGcUARoOHxnnLEzQ1hWu8hYcq7dqsNvbavyxcO8APmj8ZcNQ3jifCy3T7qZ0+IIxjJIjnXDYXaxtb+TrRNP1yeIxPBxjeqI1MSqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iS7tUH/Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MR0/rtm6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OZSxcWIV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y7oOVPk1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEBCD34A19;
	Wed, 14 Jan 2026 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768414314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo9ryw1mNS44QarmajvRPRZ+yW3faNEvj358UoC9dhs=;
	b=iS7tUH/YOVxSh4z+OZrakGrtN6XHw3nBLnAxQyGHRRcDkM9IJTXs0s5ERNzTD6pyF+L0bH
	uSwLh8J0cyq2Y3TKi3vc81qxNL+XqtOL8oOo9PESeiRBI5D2uoB2rm2OYnKgIMquzPTPku
	viZbKCQe/6B8VMRSLiKTNd7yHPf761I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768414314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo9ryw1mNS44QarmajvRPRZ+yW3faNEvj358UoC9dhs=;
	b=MR0/rtm67S7zK5Gaw2gaKMuuUuFkv6QZraFcDAoZA5Iyg3WJ+BCDish25xa0np61mTVPhT
	gt/CmQlc/UXyiXCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768414313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo9ryw1mNS44QarmajvRPRZ+yW3faNEvj358UoC9dhs=;
	b=OZSxcWIVOJ/2w7sK+y/z5zIQ4PTncZsxIyA7Z1YcAx5jHdw5b0w73Z9rstYZxjhVWtpkZx
	VXES6xbnfRccGtJbARuNNvoDgBEVKRgwZfHU/f3cndhwktoKlpInCRciG6TCeECY1YavoG
	2QPdcHpY+IXIAb7NOF4NqZYhpJWFkbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768414313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo9ryw1mNS44QarmajvRPRZ+yW3faNEvj358UoC9dhs=;
	b=Y7oOVPk11qf+qOKc4Tcuncg8zBkZeMC3EpyXNrm5aqSn07P/vM7bNZOq0IlEYcRShrW60k
	GHs2RrDmzRIu7tCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBFCA3EA63;
	Wed, 14 Jan 2026 18:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LB0CNWncZ2nsLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 18:11:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 982DAA0BFB; Wed, 14 Jan 2026 19:11:49 +0100 (CET)
Date: Wed, 14 Jan 2026 19:11:49 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: vira@imap.suse.de, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 01/16] fs: Add case sensitivity info to file_kattr
Message-ID: <3kq2tbdcoxxw3y2gseg7vtnhnze5ee536fu4rnsn22yjrpsmb4@fpfueqqiji5q>
References: <20260114142900.3945054-1-cel@kernel.org>
 <20260114142900.3945054-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114142900.3945054-2-cel@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLmzfjx67n53eyz9asjm8u3pcw)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[imap.suse.de,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 14-01-26 09:28:44, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Enable upper layers such as NFSD to retrieve case sensitivity
> information from file systems by adding case_insensitive and
> case_nonpreserving boolean fields to struct file_kattr.
> 
> These fields default to false (POSIX semantics: case-sensitive and
> case-preserving), allowing filesystems to set them only when
> behavior differs from the default.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
...
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 66ca526cf786..07286d34b48b 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -229,10 +229,20 @@ struct file_attr {
>  	__u32 fa_nextents;	/* nextents field value (get)   */
>  	__u32 fa_projid;	/* project identifier (get/set) */
>  	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
> +	/* VER1 additions: */
> +	__u32 fa_case_behavior;	/* case sensitivity (get) */
> +	__u32 fa_reserved;
>  };
>  
>  #define FILE_ATTR_SIZE_VER0 24
> -#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
> +#define FILE_ATTR_SIZE_VER1 32
> +#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
> +
> +/*
> + * Case sensitivity flags for fa_case_behavior
> + */
> +#define FS_CASE_INSENSITIVE	0x00000001	/* case-insensitive lookups */
> +#define FS_CASE_NONPRESERVING	0x00000002	/* case not preserved */

This is a matter of taste so not sure what others think about it but
file_attr already have fa_xflags field and there is already one flag which
doesn't directly correspond to on-disk representation (FS_XFLAG_HASATTR) so
we could also put the two new flags in there... I have hard time imagining
fa_case_behavior would grow past the two flags you've introduced so u32
seems a bit wasteful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

