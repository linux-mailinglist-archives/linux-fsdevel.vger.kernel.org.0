Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35C67B2F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjAYNDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjAYNDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:03:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806942DD1;
        Wed, 25 Jan 2023 05:03:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D84AA1FE8C;
        Wed, 25 Jan 2023 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674651814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBKydA/c7e6QhpzyByxg01tKdjQ2ln17ybZrSlmHo0o=;
        b=S/IuhHjEJm4tUZ1mr/XuYzkJqsgnzab6MpUAWJ+4y9VrpCnjHvq3GU+eH78OmusMVYPfyb
        J2j98OeGgrn+YKGGwk+PafwgW4mJXic4MrSw7YiA3VeW9E3Cw0/lgxcAZROvJeg/PAq0XL
        CN++q5uCemBQNKKMmKyBU2fW/nKa+94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674651814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBKydA/c7e6QhpzyByxg01tKdjQ2ln17ybZrSlmHo0o=;
        b=ai4c79hxpAqWLyg7ojlbMxss0cQp8SxPwu1mtpkFwchqzOMMq5duRhU90p89xTQz1ScMan
        PJzz0P2TUYnkpOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C85FF1339E;
        Wed, 25 Jan 2023 13:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JYHhMKYo0WOOGQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 13:03:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B13CA06B1; Wed, 25 Jan 2023 14:03:34 +0100 (CET)
Date:   Wed, 25 Jan 2023 14:03:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/12] ext2: drop posix acl handlers
Message-ID: <20230125130334.offe44nub3js732f@quack3>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
 <20230125-fs-acl-remove-generic-xattr-handlers-v1-6-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-6-6cf155b492b6@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-01-23 12:28:51, Christian Brauner wrote:
> Last cycle we introduced a new posix acl api. Filesystems now only need
> to implement the inode operations for posix acls. The generic xattr
> handlers aren't used anymore by the vfs and will be completely removed.
> Keeping the handler around is confusing and gives the false impression
> that the xattr infrastructure of the vfs is used to interact with posix
> acls when it really isn't anymore.
> 
> For this to work we simply rework the ->listxattr() inode operation to
> not rely on the generix posix acl handlers anymore.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: <linux-ext4@vger.kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/xattr.c | 60 +++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 641abfa4b718..86ba6a33349e 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -98,25 +98,9 @@ static struct buffer_head *ext2_xattr_cache_find(struct inode *,
>  static void ext2_xattr_rehash(struct ext2_xattr_header *,
>  			      struct ext2_xattr_entry *);
>  
> -static const struct xattr_handler *ext2_xattr_handler_map[] = {
> -	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
> -#ifdef CONFIG_EXT2_FS_POSIX_ACL
> -	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &posix_acl_access_xattr_handler,
> -	[EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
> -#endif
> -	[EXT2_XATTR_INDEX_TRUSTED]	     = &ext2_xattr_trusted_handler,
> -#ifdef CONFIG_EXT2_FS_SECURITY
> -	[EXT2_XATTR_INDEX_SECURITY]	     = &ext2_xattr_security_handler,
> -#endif
> -};
> -
>  const struct xattr_handler *ext2_xattr_handlers[] = {
>  	&ext2_xattr_user_handler,
>  	&ext2_xattr_trusted_handler,
> -#ifdef CONFIG_EXT2_FS_POSIX_ACL
> -	&posix_acl_access_xattr_handler,
> -	&posix_acl_default_xattr_handler,
> -#endif
>  #ifdef CONFIG_EXT2_FS_SECURITY
>  	&ext2_xattr_security_handler,
>  #endif
> @@ -125,14 +109,41 @@ const struct xattr_handler *ext2_xattr_handlers[] = {
>  
>  #define EA_BLOCK_CACHE(inode)	(EXT2_SB(inode->i_sb)->s_ea_block_cache)
>  
> -static inline const struct xattr_handler *
> -ext2_xattr_handler(int name_index)
> +static const char *ext2_xattr_prefix(int xattr_index, struct dentry *dentry)
>  {
> +	const char *name = NULL;
>  	const struct xattr_handler *handler = NULL;
>  
> -	if (name_index > 0 && name_index < ARRAY_SIZE(ext2_xattr_handler_map))
> -		handler = ext2_xattr_handler_map[name_index];
> -	return handler;
> +	switch (xattr_index) {
> +	case EXT2_XATTR_INDEX_USER:
> +		handler = &ext2_xattr_user_handler;
> +		break;
> +	case EXT2_XATTR_INDEX_TRUSTED:
> +		handler = &ext2_xattr_trusted_handler;
> +		break;
> +#ifdef CONFIG_EXT2_FS_SECURITY
> +	case EXT2_XATTR_INDEX_SECURITY:
> +		handler = &ext2_xattr_security_handler;
> +		break;
> +#endif
> +#ifdef CONFIG_EXT2_FS_POSIX_ACL
> +	case EXT2_XATTR_INDEX_POSIX_ACL_ACCESS:
> +		if (posix_acl_dentry_list(dentry))
> +			name = XATTR_NAME_POSIX_ACL_ACCESS;
> +		break;
> +	case EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT:
> +		if (posix_acl_dentry_list(dentry))
> +			name = XATTR_NAME_POSIX_ACL_DEFAULT;
> +		break;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +
> +	if (xattr_dentry_list(handler, dentry))
> +		name = xattr_prefix(handler);
> +
> +	return name;
>  }
>  
>  static bool
> @@ -333,11 +344,10 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	/* list the attribute names */
>  	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
>  	     entry = EXT2_XATTR_NEXT(entry)) {
> -		const struct xattr_handler *handler =
> -			ext2_xattr_handler(entry->e_name_index);
> +		const char *prefix;
>  
> -		if (handler && (!handler->list || handler->list(dentry))) {
> -			const char *prefix = handler->prefix ?: handler->name;
> +		prefix = ext2_xattr_prefix(entry->e_name_index, dentry);
> +		if (prefix) {
>  			size_t prefix_len = strlen(prefix);
>  			size_t size = prefix_len + entry->e_name_len + 1;
>  
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
