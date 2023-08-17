Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9977F999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352210AbjHQOrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352232AbjHQOrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:47:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262610E
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:46:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03A9C1F385;
        Thu, 17 Aug 2023 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rps4ITWrfEzQi52WVgd2BuML/gttZJTXZRQ2jdmrJ3M=;
        b=aN0Jh+OKeBWkVgjrrwC8OFU073nr7P6XCH2oXEIMzwzhRnyILKszTtkcwuI06BG8vMwHu0
        WsDd1DJzstSyhP7WZw/x4u+I9OFK4zEXbtbAAS9qiiOmWXmVjWjxdGk/ztFdQzsdkBqvQ9
        8lXx09fSUZRPpbdI1aXzMWtDttJVrfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rps4ITWrfEzQi52WVgd2BuML/gttZJTXZRQ2jdmrJ3M=;
        b=PkFrdD1u4FXxvtDavsEKnygbUfSIf/iu9Z8/qJWjWWgDhUhgBZSyRXNDzV6Wq/zUreXx0J
        yv8/jcUtYR36KsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA17A1392B;
        Thu, 17 Aug 2023 14:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5+gcOd8y3mT7LwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:46:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 90526A0769; Thu, 17 Aug 2023 16:46:55 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:46:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] fs: add kerneldoc to file_{start,end}_write()
 helpers
Message-ID: <20230817144655.4ikfmhdhmhqtk7ld@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-3-amir73il@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:32, Amir Goldstein wrote:
> and use sb_end_write() instead of open coded version.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b2adee67f9b2..ced388aff51f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2545,6 +2545,13 @@ static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
>  	return (inode->i_mode ^ mode) & S_IFMT;
>  }
>  
> +/**
> + * file_start_write - get write access to a superblock for regular file io
> + * @file: the file we want to write to
> + *
> + * This is a variant of sb_start_write() which is a noop on non-regualr file.
> + * Should be matched with a call to file_end_write().
> + */
>  static inline void file_start_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
> @@ -2559,11 +2566,17 @@ static inline bool file_start_write_trylock(struct file *file)
>  	return sb_start_write_trylock(file_inode(file)->i_sb);
>  }
>  
> +/**
> + * file_end_write - drop write access to a superblock of a regular file
> + * @file: the file we wrote to
> + *
> + * Should be matched with a call to file_start_write().
> + */
>  static inline void file_end_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
> -	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +	sb_end_write(file_inode(file)->i_sb);
>  }
>  
>  /*
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
