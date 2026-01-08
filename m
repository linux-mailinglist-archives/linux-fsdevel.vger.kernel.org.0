Return-Path: <linux-fsdevel+bounces-72948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E4D065D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 22:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 627073014E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769733D6C2;
	Thu,  8 Jan 2026 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1uS6mS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C45vZuSU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1uS6mS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C45vZuSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30533D6CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908930; cv=none; b=gJUJpzg9sMsC7WBWH7dh3AH+gYTLmL7VzffHiV5JynxxlFdhTucsf/FX8jgBVbcUhWccSQLYQwTnNsJ1NZVTJ/vSQG54z3iPfwi2HQlBz1LHJFi5fnqrJ1NigHR01qsZWsdAi/wGERH1mV9ihu2CsWxta1ngjIRXyfRW679QFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908930; c=relaxed/simple;
	bh=Rcry9J5usnSiXPjbOOQaLeezzB5KHaSZo4FXz6axXVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGESFKTUepko39GjctsZHM3B0hQpeTTmskBeHo4dRD03+AotxtwoI4Zci1gFyLDiMS/reY0qoIGjDaHiJINRcuSosF4l7rxQ5i4eiQZ19N5v10BnrM5463vRKYqoccntr40JkNKlD7onwn8Mxnw237ud07h0F8Ll/CtUCB7GHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1uS6mS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C45vZuSU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1uS6mS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C45vZuSU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 514EC5CC2B;
	Thu,  8 Jan 2026 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767908920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qsq9/X3/5bf54zy+BAXanhxlqVs+GHOy1qB/vsHTtZQ=;
	b=X1uS6mS9Pt+peS9paiRqv5hXVTdWFOd/Uh/QwJA3hrXIyER8dzDidbwY/nR74Ar2JB0RwT
	b/dwq9LznEZ+aOG4jae68CLUCIw0ScJxuw2iyuSMrOA58KrjhMKqx/kIbUutle16rIct2z
	+fSAlk08gBUSUNpHUTQv8jqF1SKXi38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767908920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qsq9/X3/5bf54zy+BAXanhxlqVs+GHOy1qB/vsHTtZQ=;
	b=C45vZuSU0Fx5uk8kFtRk4jHt8gryo/CQgcB5WG0Dm/VY9v3tD8USlE+sHB8Q4vErZW8z09
	e5Of5O6wq1HS1gBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X1uS6mS9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C45vZuSU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767908920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qsq9/X3/5bf54zy+BAXanhxlqVs+GHOy1qB/vsHTtZQ=;
	b=X1uS6mS9Pt+peS9paiRqv5hXVTdWFOd/Uh/QwJA3hrXIyER8dzDidbwY/nR74Ar2JB0RwT
	b/dwq9LznEZ+aOG4jae68CLUCIw0ScJxuw2iyuSMrOA58KrjhMKqx/kIbUutle16rIct2z
	+fSAlk08gBUSUNpHUTQv8jqF1SKXi38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767908920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qsq9/X3/5bf54zy+BAXanhxlqVs+GHOy1qB/vsHTtZQ=;
	b=C45vZuSU0Fx5uk8kFtRk4jHt8gryo/CQgcB5WG0Dm/VY9v3tD8USlE+sHB8Q4vErZW8z09
	e5Of5O6wq1HS1gBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DA2D3EA63;
	Thu,  8 Jan 2026 21:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id al9ECjgmYGmvbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 21:48:40 +0000
Date: Thu, 8 Jan 2026 22:48:39 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 4/4] btrfs: use may_create_dentry() in btrfs_mksubvol()
Message-ID: <20260108214838.GO21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767801889.git.fdmanana@suse.com>
 <a56191f13dc946951f94ddec1dc714991576d38f.1767801889.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56191f13dc946951f94ddec1dc714991576d38f.1767801889.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,suse.com:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 514EC5CC2B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu, Jan 08, 2026 at 01:35:34PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is no longer the need to use btrfs_may_create(), which was a copy
> of the VFS private function may_create(), since now that functionality
> is exported by the VFS as a function named may_create_dentry(). So change
> btrfs_mksubvol() to use the VFS function and remove btrfs_may_create().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ioctl.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0cb3cd3d05a5..9cf37459ef6d 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -815,19 +815,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>  	return ret;
>  }
>  
> -/* copy of may_create in fs/namei.c() */
> -static inline int btrfs_may_create(struct mnt_idmap *idmap,
> -				   struct inode *dir, const struct dentry *child)
> -{

The difference to the VFS version is lack of audit_inode_child() in
this place, so this may be good to mention in the changelog.
Functionally the audit subsystem missed the event of subvolume creation.

> -	if (d_really_is_positive(child))
> -		return -EEXIST;
> -	if (IS_DEADDIR(dir))
> -		return -ENOENT;
> -	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
> -		return -EOVERFLOW;
> -	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
> -}

