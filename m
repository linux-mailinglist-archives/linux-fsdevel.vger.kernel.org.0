Return-Path: <linux-fsdevel+bounces-72603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A1DCFCF69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 10:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F23ED3081E2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F092D8DB9;
	Wed,  7 Jan 2026 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R185CZO0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMS0ybXf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R185CZO0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMS0ybXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5E2FCC1D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778604; cv=none; b=ND4AwbDlcXhiJFr24tc0Iv/pozLmSqus/yI8Uj6mzjf3vZ9fgmbjcS/TR1W7Dq64vaf+BjHAe5QH3rrnJYOvnJYGNLdmSZvx+lWbiXSsL/uHJD4SU5x7WQ4kbfI6uvXJOd6X3Z1WWIkQguwqWXLnyfFOYEsb1hErG3HYEXeabxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778604; c=relaxed/simple;
	bh=jce5ScO0LnvGr5+Kv87gA1uFGF5C9+MVJDqGRlT44Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNmyiCDzqmxOd5stq4A21UYZPqAD0/3s3TFqohYJ+B6sE0SqfXrIUhq8ytdXJh6EtSCMK+WuOhiaLEXynye8l5IUlfiUD423mJKR5XwIozdaWOaG+YOyNEGy0QWmUFq04upnD3bjsPXaWjMonwN7MfkrK/xUt2TnSxiudOvIIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R185CZO0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kMS0ybXf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R185CZO0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kMS0ybXf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CD0D5BE25;
	Wed,  7 Jan 2026 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767778599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9lQHMFl8PoNFKO8xwkwBz5acwZAuaw9fGsbZJ4xGL8=;
	b=R185CZO0F/e7yf8zbuUrU9V2fqeNX+A4qSqjiPK0TKs2mf8xAJQjyuQGzUsUa7V1dGxs0d
	6jOvC45QdzR4jl97q+dTiQ7cyhAhQfrm4SymiBxsMnpCJwRkj0D9aoVeyArOTJicr+CyiD
	vq7ZGNhRf4QWWfQkVZYJbKqJfMyY0pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767778599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9lQHMFl8PoNFKO8xwkwBz5acwZAuaw9fGsbZJ4xGL8=;
	b=kMS0ybXfiVFuXb39nqH7TpW4WTFC73AOkMwNk/Zm5C6tip9QkevvzRWBrFDYNQo0+bArgB
	6YRfWYYRNf/6MoBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R185CZO0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kMS0ybXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767778599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9lQHMFl8PoNFKO8xwkwBz5acwZAuaw9fGsbZJ4xGL8=;
	b=R185CZO0F/e7yf8zbuUrU9V2fqeNX+A4qSqjiPK0TKs2mf8xAJQjyuQGzUsUa7V1dGxs0d
	6jOvC45QdzR4jl97q+dTiQ7cyhAhQfrm4SymiBxsMnpCJwRkj0D9aoVeyArOTJicr+CyiD
	vq7ZGNhRf4QWWfQkVZYJbKqJfMyY0pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767778599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9lQHMFl8PoNFKO8xwkwBz5acwZAuaw9fGsbZJ4xGL8=;
	b=kMS0ybXfiVFuXb39nqH7TpW4WTFC73AOkMwNk/Zm5C6tip9QkevvzRWBrFDYNQo0+bArgB
	6YRfWYYRNf/6MoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 670EA3EA63;
	Wed,  7 Jan 2026 09:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRoiGScpXmnOIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Jan 2026 09:36:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25AEAA09E9; Wed,  7 Jan 2026 10:36:35 +0100 (CET)
Date: Wed, 7 Jan 2026 10:36:35 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, 
	brauner@kernel.org, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mark@fasheh.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
Message-ID: <57qlrwjb2kxgolx4yim3jsdflunh2gvqhsqq5ttsfenbjfl4vu@3nliqvyxsnhb>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
 <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
 <afaeed87-66bd-4203-ae81-842ca4619db9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afaeed87-66bd-4203-ae81-842ca4619db9@I-love.SAKURA.ne.jp>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[d222f4b7129379c3d5bc];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,syzkaller.appspotmail.com,kernel.org,evilplan.org,linux.alibaba.com,vger.kernel.org,fasheh.com,lists.linux.dev,samsung.com,googlegroups.com,oracle.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 7CD0D5BE25
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Tue 06-01-26 19:10:41, Tetsuo Handa wrote:
> On 2025/12/10 19:09, Jan Kara wrote:
> > On Wed 10-12-25 18:45:26, Tetsuo Handa wrote:
> >> syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> >> introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
> >> handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
> >> to S_IFREG. Since make_bad_inode() might be called after an inode is fully
> >> constructed, make_bad_inode() should not needlessly change file type.
> >>
> >> Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > 
> > No. make_bad_inode() must not be called once the inode is fully visible
> > because that can cause all sorts of fun. That function is really only good
> > for handling a situation when read of an inode from the disk failed or
> > similar early error paths.
> I'm surprised to hear that.
> 
> But since commit 58b6fcd2ab34 ("ocfs2: mark inode bad upon validation
> failure during read") is a bug fix, we want to somehow prevent this bug
> from re-opening.

Since Jens has picked up
https://lore.kernel.org/all/20251217190040.490204-2-rpthibeault@gmail.com/
yesterday I suspect the original reproducer for OCFS2 will not cause issue
anymore even without 58b6fcd2ab34 because as far as I had a look the
original problem was caused by the loop device getting messed up under a
mounted OCFS2 filesystem. It would be good to verify my analysis is correct
but I think just reverting 58b6fcd2ab34 might be the best option at this
point.

								Honza

> 
> Minimal change for this release cycle might look like
> 
> ----------
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index b5fcc2725a29..2c97c8b4013f 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1715,8 +1715,13 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
>  	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
>  			       1, &tmp, flags, ocfs2_validate_inode_block);
>  
> -	if (rc < 0)
> +	if (rc < 0) {
> +		/* Preserve file type while making operations no-op. */
> +		umode_t	mode = inode->i_mode & S_IFMT;
> +
>  		make_bad_inode(inode);
> +		inode->i_mode = mode;
> +	}
>  	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
>  	if (!rc && !*bh)
>  		*bh = tmp;
> ----------
> 
> but what approach do you prefer?
> 
> Introduce a copy of bad_{inode,file}_ops for ocfs2 and replace
> a call to make_bad_inode() with updating only {inode,file}_ops ?
> 
> Or, modify existing {inode,file}_ops for ocfs2 to check whether
> an I/O error has occurred in the past?
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

