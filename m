Return-Path: <linux-fsdevel+bounces-71821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C75CD5A85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 11:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7058D302C8C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CA3148C7;
	Mon, 22 Dec 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eh7LnRVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QKoN2jDv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eh7LnRVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QKoN2jDv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A5313E14
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400501; cv=none; b=bOSa0lVWG6qA9G5Ahb0Zfb9YQJ0Rsv12M9v1ajoraTgJHfkgQDBDLKAASkGbSV9TwA2pPHW7/PN0LuHJQyX/pH2j3ssfb+nRdWVolIk4rsr/kLiWIZJSIjfPR0+Ow6sBsPajw4KZKQX9c/cfb06bvbU334IrdiEg2y/bW4yz2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400501; c=relaxed/simple;
	bh=peSjBXclAYGfvscpw9KaL2NBBwoS2BjO7mjWGZv0ZCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+WPT8lQg+JFlvBgMcdCfchduMRh6YUo/T14dDTFA4OMNJr0DYkZxb7SXbyEjmlYzEZdGElNhspTHdJ9fIhyWz3hWHvarkoyMdus2LAOzJCFxBpv5xEB3+lo6g16RBs+e5e3iDJWQvl45p8aD8o1VeKK3zNo+/dIwVL5NdmuzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eh7LnRVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QKoN2jDv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eh7LnRVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QKoN2jDv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80B7F5BCE2;
	Mon, 22 Dec 2025 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766400492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU/DlRaIrxFQbb2VYGudXuXbvw/N2T0qOfiEg1I4q1s=;
	b=Eh7LnRVc8KhUbZ6iE9jqt09/ex+eY/FS5REFiRkT0sQgPOC3dIgSg+YTangFRI6l6v8ikC
	LxqQIMMas8maKB10qWA4z3YC7Ss/3nVfo4U6Oaj6QsL7HrA9nVIthStvBBPTYNvBt4pF9x
	Kjtwca+PULDe54lYk2VKI+wStI9vqfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766400492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU/DlRaIrxFQbb2VYGudXuXbvw/N2T0qOfiEg1I4q1s=;
	b=QKoN2jDv3xrBfJF6oqLIf26kYBTcBJ5jDdnwQ0Zo6l1z76CbgCmy7pyCAVSehxz45GVns5
	RPleYHqhU2Sd/BCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766400492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU/DlRaIrxFQbb2VYGudXuXbvw/N2T0qOfiEg1I4q1s=;
	b=Eh7LnRVc8KhUbZ6iE9jqt09/ex+eY/FS5REFiRkT0sQgPOC3dIgSg+YTangFRI6l6v8ikC
	LxqQIMMas8maKB10qWA4z3YC7Ss/3nVfo4U6Oaj6QsL7HrA9nVIthStvBBPTYNvBt4pF9x
	Kjtwca+PULDe54lYk2VKI+wStI9vqfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766400492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MU/DlRaIrxFQbb2VYGudXuXbvw/N2T0qOfiEg1I4q1s=;
	b=QKoN2jDv3xrBfJF6oqLIf26kYBTcBJ5jDdnwQ0Zo6l1z76CbgCmy7pyCAVSehxz45GVns5
	RPleYHqhU2Sd/BCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75BFA1364B;
	Mon, 22 Dec 2025 10:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dti5HOwhSWnxVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Dec 2025 10:48:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36AC8A09CB; Mon, 22 Dec 2025 11:48:12 +0100 (CET)
Date: Mon, 22 Dec 2025 11:48:12 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH] ext4: don't order data when zeroing unwritten or delayed
 block
Message-ID: <iih22kuucq6s2pdkhdcdosaaclfapmpanuikbvvzw4zf45pqw2@23kqz7drc6pr>
References: <20251222013136.2658907-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222013136.2658907-1-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]

On Mon 22-12-25 09:31:36, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When zeroing out a written partial block, it is necessary to order the
> data to prevent exposing stale data on disk. However, if the buffer is
> unwritten or delayed, it is not allocated as written, so ordering the
> data is not required. This can prevent strange and unnecessary ordered
> writes when appending data across a region within a block.
> 
> Assume we have a 2K unwritten file on a filesystem with 4K blocksize,
> and buffered write from 3K to 4K. Before this patch,
> __ext4_block_zero_page_range() would add the range [2k,3k) to the
> ordered range, and then the JBD2 commit process would write back this
> block. However, it does nothing since the block is not mapped, this
							^^^ by this you
mean that the block is unwritten, don't you?

> folio will be redirtied and written back agian through the normal write
> back process.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fa579e857baf..fc16a89903b9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4104,9 +4104,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	if (ext4_should_journal_data(inode)) {
>  		err = ext4_dirty_journalled_data(handle, bh);
>  	} else {
> -		err = 0;
>  		mark_buffer_dirty(bh);
> -		if (ext4_should_order_data(inode))
> +		/*
> +		 * Only the written block requires ordered data to prevent
> +		 * exposing stale data.
> +		 */
> +		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
> +		    ext4_should_order_data(inode))
>  			err = ext4_jbd2_inode_add_write(handle, inode, from,
>  					length);
>  	}
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

