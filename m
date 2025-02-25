Return-Path: <linux-fsdevel+bounces-42617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FFA450E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDC17AA065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EF3236A62;
	Tue, 25 Feb 2025 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i9kepxy6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pbh4wnki";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eiPiHgKg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEXQ1hA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC51215164
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740525925; cv=none; b=WxFJ9h4K5Ik0a8Eg9Qi7fNKDJuOq6RHsFQHH3YO3WJlEZEn7BLh4SJcAMnIBiOFyj9nTnguHpQ7FaICxzKzMNAmqcB19oXd6YFDb0On1r9P8YnEnT7D22KwsiUfu/wb35AorwqpYRemZF+I2h9YXSgZ0rdjLR3PTbPJsXE+ZiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740525925; c=relaxed/simple;
	bh=drJrXmDLFRS8vAKIy2nm6KKL7+lrCuzJoxTF0zwlT9E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tHpQOEyEyuatJW4VEgja+OyiwMUNae82vhlUFTQzoDsWa0mEwGRIAr+gxuv4lA6++ITHiv09L5pCldvOgAayQjZAR9Ux8IecAo2r4LAArqC3NUbdQMfq0TQ3nn9/zHfodORQvsFXG89XouUpuIDIHspJi4APtrc/GpMEOMeLWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i9kepxy6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pbh4wnki; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eiPiHgKg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEXQ1hA6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFDD51F38D;
	Tue, 25 Feb 2025 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740525922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyM6M9U24TNxZvgG+O7Rg6PnHpfQq7My54tkd7clWM=;
	b=i9kepxy6n8ljQQyZ7oQLFkC8pOxqLZmDP2dHesUk62FE+iw5tZNf6vxDHhiV7OLJqsp3G6
	qXzF1Ibqhuj4Y/16UXNoZDdSAffRT+oIOg+QyV44EIMoFiTm8/npSr+VRtaTKCmuZ6gz0G
	Y2/RJHgr4137XRshiIepuGnlS3V/Yvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740525922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyM6M9U24TNxZvgG+O7Rg6PnHpfQq7My54tkd7clWM=;
	b=Pbh4wnkir0KCsJXUWCHO05cbFnMyByamFYAi5eAOM258H5vzb+foy0vyJ7/BZOvAL1DhWs
	u2cmRPbgmBb3jCAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740525921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyM6M9U24TNxZvgG+O7Rg6PnHpfQq7My54tkd7clWM=;
	b=eiPiHgKg3FXR/QkOECaRcpXADfBBvxo1PZ5JrXq9HDOIyFK5gosgy7HpBigp+Bqpu33z3Y
	pIG9q6pYfz0N4USWreLDAp9xk/ccFiQzf1uwjk/9E499/R92irOvwzv4Xv4TJsb0OPYRbB
	e5jQZcibmD+m1AOqmVdPglBTn+wLQhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740525921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyM6M9U24TNxZvgG+O7Rg6PnHpfQq7My54tkd7clWM=;
	b=TEXQ1hA6/MVaYF2PInS7qDG9wULLPTupv8NuoYo/p9khhsHCxnqX1t+PCKaMDCwOHqCfJN
	I5SVDZKP7e7XWODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99FF013332;
	Tue, 25 Feb 2025 23:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g7AkE19RvmfzMAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Feb 2025 23:25:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 16/21] ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
In-reply-to: <20250224212051.1756517-16-viro@zeniv.linux.org.uk>
References: <>, <20250224212051.1756517-16-viro@zeniv.linux.org.uk>
Date: Wed, 26 Feb 2025 10:25:12 +1100
Message-id: <174052591233.102979.4456239839821136530@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 25 Feb 2025, Al Viro wrote:
> makes simple_lookup() slightly cheaper there.

I think the patch make sense because there is no point keeping negative
dentries for these filesystems - and positive dentries get an extra
refcount so DCACHE_DONTCACHE doesn't apply.

But I don't see how this makes simple_lookup() cheaper.  It means that
if someone repeatedly looks up the same non-existent name then
simple_lookup() will be called more often (because we didn't cache the
result of the previous time) but otherwise I don't see the relevance to
simple_lookup().  Am I missing something?

Thanks,
NeilBrown


>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/hugetlbfs/inode.c | 1 +
>  fs/ramfs/inode.c     | 1 +
>  ipc/mqueue.c         | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 0fc179a59830..205dd7562be1 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1431,6 +1431,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct f=
s_context *fc)
>  	sb->s_blocksize_bits =3D huge_page_shift(ctx->hstate);
>  	sb->s_magic =3D HUGETLBFS_MAGIC;
>  	sb->s_op =3D &hugetlbfs_ops;
> +	sb->s_d_flags =3D DCACHE_DONTCACHE;
>  	sb->s_time_gran =3D 1;
> =20
>  	/*
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 8006faaaf0ec..c4ee67870c4b 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -269,6 +269,7 @@ static int ramfs_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  	sb->s_blocksize_bits	=3D PAGE_SHIFT;
>  	sb->s_magic		=3D RAMFS_MAGIC;
>  	sb->s_op		=3D &ramfs_ops;
> +	sb->s_d_flags		=3D DCACHE_DONTCACHE;
>  	sb->s_time_gran		=3D 1;
> =20
>  	inode =3D ramfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 35b4f8659904..dbd5c74eecb2 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -411,6 +411,7 @@ static int mqueue_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
>  	sb->s_blocksize_bits =3D PAGE_SHIFT;
>  	sb->s_magic =3D MQUEUE_MAGIC;
>  	sb->s_op =3D &mqueue_super_ops;
> +	sb->s_d_flags =3D DCACHE_DONTCACHE;
> =20
>  	inode =3D mqueue_get_inode(sb, ns, S_IFDIR | S_ISVTX | S_IRWXUGO, NULL);
>  	if (IS_ERR(inode))
> --=20
> 2.39.5
>=20
>=20


