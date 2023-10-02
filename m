Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131F37B5885
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjJBQ0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjJBQ0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:26:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977F9E
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 09:26:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E28C21864;
        Mon,  2 Oct 2023 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696263993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPXfWs/Egnr1PM+bfsH3rceOM/NQhnl48aUSwBy/ss0=;
        b=jR1T5gmPChN4/8cJDRhlzFbUVrRbERtPdRcvbqEIEyB41d4QT4X962UFMSdCP+0rA1PsJY
        uDF3AMi9nULgpg68MDAy25Lu8Swctiw8a/npqoLJEs4XVPd+NR7Tu4LxM+zm5V+KpqMOb1
        dnewQOaH/Q/g62luWYNCA5wvmdgwBwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696263993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPXfWs/Egnr1PM+bfsH3rceOM/NQhnl48aUSwBy/ss0=;
        b=/bghFknqUoUVcLqarDw1+STXuncmY0n9XYKR6fTSn4XPSLRQ31RjXfUGND71rajqrGXgJb
        b+nIhqn8WzvdxOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30F6213456;
        Mon,  2 Oct 2023 16:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X1/xCznvGmWiIQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 16:26:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BFA50A07C9; Mon,  2 Oct 2023 18:26:32 +0200 (CEST)
Date:   Mon, 2 Oct 2023 18:26:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 6/7] fs: remove unused helper
Message-ID: <20231002162632.y4nxmwgwnfkz62u4@quack3>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-6-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-6-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 15:21:19, Christian Brauner wrote:
> The grab_super() helper is now only used by grab_super_dead(). Merge the
> two helpers into one.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yeah, nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 44 +++++++-------------------------------------
>  1 file changed, 7 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 181ac8501301..6cdce2b31622 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -517,35 +517,6 @@ void deactivate_super(struct super_block *s)
>  
>  EXPORT_SYMBOL(deactivate_super);
>  
> -/**
> - *	grab_super - acquire an active reference
> - *	@s: reference we are trying to make active
> - *
> - *	Tries to acquire an active reference.  grab_super() is used when we
> - * 	had just found a superblock in super_blocks or fs_type->fs_supers
> - *	and want to turn it into a full-blown active reference.  grab_super()
> - *	is called with sb_lock held and drops it.  Returns 1 in case of
> - *	success, 0 if we had failed (superblock contents was already dead or
> - *	dying when grab_super() had been called).  Note that this is only
> - *	called for superblocks not in rundown mode (== ones still on ->fs_supers
> - *	of their type), so increment of ->s_count is OK here.
> - */
> -static int grab_super(struct super_block *s) __releases(sb_lock)
> -{
> -	bool born;
> -
> -	s->s_count++;
> -	spin_unlock(&sb_lock);
> -	born = super_lock_excl(s);
> -	if (born && atomic_inc_not_zero(&s->s_active)) {
> -		put_super(s);
> -		return 1;
> -	}
> -	super_unlock_excl(s);
> -	put_super(s);
> -	return 0;
> -}
> -
>  static inline bool wait_dead(struct super_block *sb)
>  {
>  	unsigned int flags;
> @@ -559,7 +530,7 @@ static inline bool wait_dead(struct super_block *sb)
>  }
>  
>  /**
> - * grab_super_dead - acquire an active reference to a superblock
> + * grab_super - acquire an active reference to a superblock
>   * @sb: superblock to acquire
>   *
>   * Acquire a temporary reference on a superblock and try to trade it for
> @@ -570,17 +541,16 @@ static inline bool wait_dead(struct super_block *sb)
>   * Return: This returns true if an active reference could be acquired,
>   *         false if not.
>   */
> -static bool grab_super_dead(struct super_block *sb)
> +static bool grab_super(struct super_block *sb)
>  {
> -
>  	sb->s_count++;
> -	if (grab_super(sb)) {
> +	spin_unlock(&sb_lock);
> +	if (super_lock_excl(sb) && atomic_inc_not_zero(&sb->s_active)) {
>  		put_super(sb);
> -		lockdep_assert_held(&sb->s_umount);
>  		return true;
>  	}
> +	super_unlock_excl(sb);
>  	wait_var_event(&sb->s_flags, wait_dead(sb));
> -	lockdep_assert_not_held(&sb->s_umount);
>  	put_super(sb);
>  	return false;
>  }
> @@ -831,7 +801,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>  			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
>  		return ERR_PTR(-EBUSY);
>  	}
> -	if (!grab_super_dead(old))
> +	if (!grab_super(old))
>  		goto retry;
>  	destroy_unused_super(s);
>  	return old;
> @@ -875,7 +845,7 @@ struct super_block *sget(struct file_system_type *type,
>  				destroy_unused_super(s);
>  				return ERR_PTR(-EBUSY);
>  			}
> -			if (!grab_super_dead(old))
> +			if (!grab_super(old))
>  				goto retry;
>  			destroy_unused_super(s);
>  			return old;
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
