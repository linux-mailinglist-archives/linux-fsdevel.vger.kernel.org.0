Return-Path: <linux-fsdevel+bounces-4426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905ED7FF662
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F0280718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D854FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D31703
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 07:47:44 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11A4421AAE;
	Thu, 30 Nov 2023 15:47:43 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EECE1138E5;
	Thu, 30 Nov 2023 15:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gfgAOp6uaGUvCAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 15:47:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 491A4A07E0; Thu, 30 Nov 2023 16:47:38 +0100 (CET)
Date: Thu, 30 Nov 2023 16:47:38 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single
 filesystem
Message-ID: <20231130154738.rcdkvqhuztp5pz5y@quack3>
References: <20231118183018.2069899-1-amir73il@gmail.com>
 <20231118183018.2069899-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118183018.2069899-3-amir73il@gmail.com>
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.39 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 4.39
X-Rspamd-Queue-Id: 11A4421AAE

On Sat 18-11-23 20:30:18, Amir Goldstein wrote:
> So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> non-uniform fsid (e.g. btrfs non-root subvol).
> 
> When group is watching inodes all from the same filesystem (or subvol),
> allow adding inode marks with "weak" fsid, because there is no ambiguity
> regarding which filesystem reports the event.
> 
> The first mark added to a group determines if this group is single or
> multi filesystem, depending on the fsid at the path of the added mark.
> 
> If the first mark added has a "strong" fsid, marks with "weak" fsid
> cannot be added and vice versa.
> 
> If the first mark added has a "weak" fsid, following marks must have
> the same "weak" fsid and the same sb as the first mark.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks mostly good to me, some small comments below.

> @@ -1192,11 +1192,68 @@ static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>  	return recalc;
>  }
>  
> +struct fan_fsid {
> +	struct super_block *sb;
> +	__kernel_fsid_t id;
> +	bool weak;
> +};
> +
> +static int fanotify_check_mark_fsid(struct fsnotify_group *group,
> +				    struct fsnotify_mark *mark,
> +				    struct fan_fsid *fsid)

I'd call this fanotify_set_mark_fsid() because that's what it does and
as part of that it also checks whether it can actually set the fsid...

> @@ -1564,20 +1622,25 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	return fd;
>  }
>  
> -static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
> +static int fanotify_test_fsid(struct dentry *dentry, unsigned int flags,
> +			      struct fan_fsid *fsid)
>  {
> +	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
>  	__kernel_fsid_t root_fsid;
>  	int err;
>  
>  	/*
>  	 * Make sure dentry is not of a filesystem with zero fsid (e.g. fuse).
>  	 */
> -	err = vfs_get_fsid(dentry, fsid);
> +	err = vfs_get_fsid(dentry, &fsid->id);
>  	if (err)
>  		return err;
>  
> -	if (!fsid->val[0] && !fsid->val[1])
> -		return -ENODEV;
> +	/* Allow weak fsid when marking inodes */
> +	fsid->sb = dentry->d_sb;
> +	fsid->weak = mark_type == FAN_MARK_INODE;
> +	if (!fsid->id.val[0] && !fsid->id.val[1])
> +		return fsid->weak ? 0 : -ENODEV;
>  
>  	/*
>  	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
> @@ -1587,10 +1650,10 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
>  	if (err)
>  		return err;
>  
> -	if (root_fsid.val[0] != fsid->val[0] ||
> -	    root_fsid.val[1] != fsid->val[1])
> -		return -EXDEV;
> +	if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
> +		return fsid->weak ? 0 : -EXDEV;
>  
> +	fsid->weak = false;
>  	return 0;
>  }

So the handling of 'weak' confuses me here as it combines determining
whether fsid is weak with determining whether we accept it or not. Maybe my
brain is just fried... Can we maybe simplify to something like:

	fsid->sb = dentry->d_sb;
	if (!fsid->id.val[0] && !fsid->id.val[1]) {
		fsid->weak = true;
		goto check;
	}

	... fetch root_fsid ...

	if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
		fsid->weak = true;

check:
	/* Allow weak fsids only for inode marks... */
	if (fsid->weak && mark_type != FAN_MARK_INODE)
		return -EXDEV;
	return 0;

This is how I understand the logic from your description but I'm not 100%
sure this is equivalent to your code above ;).

Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

