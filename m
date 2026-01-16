Return-Path: <linux-fsdevel+bounces-74107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4BD2FD18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91D1B3023A01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3110C36212F;
	Fri, 16 Jan 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0mRq6Rxl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCQ2Vfii";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0mRq6Rxl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCQ2Vfii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C68362131
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560394; cv=none; b=bbWIf0Z9d8sqhEu7tRs3POVmotTdGgEyogFv2uELvss220zOIbUc4cDcLWCGVpBERsSxHVNVvKavLw20DwA510boLtLNKdwghHc25Qb8P4RlGxZd7lUshewViG2ysLb80GayQdJ9OvaQv/nOBNX68UB/aMdQPWz5ckgwyG8Zonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560394; c=relaxed/simple;
	bh=lEF5q/7TalMbEeyu1lJ7N3do7XGDzZfxZyxOjYiDWZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMuxxfFJ+mwUmwGNjDsM7GnzAM2eqJFamxnKnJyfLN+//7WqR1A9p94f8KV0Oo+aQgYM3Xktpj2lb6aW9KXNveZEic2ZQbh63Qgj6knjyE7+AxC29gX/BLOKKLzf8ButjIy/RV1OjRQNYw9FpBbbStsNqZX97DaJbLwwGKvfgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0mRq6Rxl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCQ2Vfii; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0mRq6Rxl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCQ2Vfii; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39394336B9;
	Fri, 16 Jan 2026 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768560390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP1q9Ovfy/E+Cb02Q5R0pXn9SOKljKsu1y7iUqVaCJg=;
	b=0mRq6RxlS041cU28r/V0rH2liCE+HXIRHLEQk7V6v25qkNoSrSb95EvqfcEYtA70/qpPXn
	XqE5rgqfKQ9BlV11BMkJemRBF9ahXFNjYlxtCMXyREmBTv+S0pi2hgcekcP8ARBR3Wz5CS
	rWCkiSDOxS+pn7MUFzee2xtcJiv43Rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768560390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP1q9Ovfy/E+Cb02Q5R0pXn9SOKljKsu1y7iUqVaCJg=;
	b=kCQ2VfiicHiIqbHfnNCsi7dmRDgCLtDQumWsVhBj1o/P/fPEg/QLxVCwJPbocJYikftmzf
	MNjNjJFwZUJp0iDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768560390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP1q9Ovfy/E+Cb02Q5R0pXn9SOKljKsu1y7iUqVaCJg=;
	b=0mRq6RxlS041cU28r/V0rH2liCE+HXIRHLEQk7V6v25qkNoSrSb95EvqfcEYtA70/qpPXn
	XqE5rgqfKQ9BlV11BMkJemRBF9ahXFNjYlxtCMXyREmBTv+S0pi2hgcekcP8ARBR3Wz5CS
	rWCkiSDOxS+pn7MUFzee2xtcJiv43Rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768560390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP1q9Ovfy/E+Cb02Q5R0pXn9SOKljKsu1y7iUqVaCJg=;
	b=kCQ2VfiicHiIqbHfnNCsi7dmRDgCLtDQumWsVhBj1o/P/fPEg/QLxVCwJPbocJYikftmzf
	MNjNjJFwZUJp0iDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 220E63EA65;
	Fri, 16 Jan 2026 10:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gEjhBwYXamk/CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 Jan 2026 10:46:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9E10A091D; Fri, 16 Jan 2026 11:46:29 +0100 (CET)
Date: Fri, 16 Jan 2026 11:46:29 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/29] ext2: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Message-ID: <bvcnfrf4kg3md6b3kvklrisa4tuwlszr6fjakfmudtiwq4uy2d@5rfpe3unm5tm>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <20260115-exportfs-nfsd-v1-4-8e80160e3c0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-exportfs-nfsd-v1-4-8e80160e3c0c@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,oracle.com,brown.name,redhat.com,talpey.com,gmail.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,infradead.org,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.samba.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 15-01-26 12:47:35, Jeff Layton wrote:
> Add the EXPORT_OP_STABLE_HANDLES flag to ext2 export operations to indicate
> that this filesystem can be exported via NFS.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 121e634c792ab625d7a07251e572e5844242fc2a..936675f06806d268ded5a3ba5306575c437ca9ce 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -426,6 +426,7 @@ static const struct export_operations ext2_export_ops = {
>  	.fh_to_dentry = ext2_fh_to_dentry,
>  	.fh_to_parent = ext2_fh_to_parent,
>  	.get_parent = ext2_get_parent,
> +	.flags = EXPORT_OP_STABLE_HANDLES,
>  };
>  
>  enum {
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

