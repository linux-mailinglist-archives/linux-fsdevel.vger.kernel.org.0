Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF10376D50B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjHBRXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHBRXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:23:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DDEA
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:23:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B50A421A53;
        Wed,  2 Aug 2023 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690996981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNZ4G4j6FBfvG4h4fDSOaEwxTRcJnv5opvj3AWqgSxU=;
        b=veB7UhXDFqAO/wAwKEUCI+ImVM7IaBBboS2qaVTXGjXFbDjsmVDOyNaez/ghgmi54zJj/P
        sXxa7EsVu8kc6wPa2yf+2EmJQ1M6SjIKml6Yi31uvI0xvW2S2fAlN5VG3AgZcvc020aka1
        vEYgPqlpYIYRpA2Z/LFOzogEvnu89Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690996981;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNZ4G4j6FBfvG4h4fDSOaEwxTRcJnv5opvj3AWqgSxU=;
        b=spqyjNNOt5MAYfYWBHsY2JQpO+gBXAZXRLk1lNgOlXjyaKL+7u1xL3taJwlMLCE/IMvDi8
        wTqDhUlXtbnNYGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A73A913919;
        Wed,  2 Aug 2023 17:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N9HQKPWQymQyZAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 17:23:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35A3AA076B; Wed,  2 Aug 2023 19:23:01 +0200 (CEST)
Date:   Wed, 2 Aug 2023 19:23:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] quota: mark dquot_load_quota_sb static
Message-ID: <20230802172301.bnrk4up3457bdqdi@quack3>
References: <20230802115439.2145212-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802115439.2145212-1-hch@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 13:54:38, Christoph Hellwig wrote:
> dquot_load_quota_sb is only used in dquot.c, so mark it static.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the cleanups! I've merged both into my tree.

								Honza

> ---
>  fs/quota/dquot.c         | 5 ++---
>  include/linux/quotaops.h | 2 --
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index e3e4f40476579c..a0c577ab2b7b26 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2352,8 +2352,8 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
>  	return 0;
>  }
>  
> -int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
> -	unsigned int flags)
> +static int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
> +		unsigned int flags)
>  {
>  	struct quota_format_type *fmt = find_quota_format(format_id);
>  	struct quota_info *dqopt = sb_dqopt(sb);
> @@ -2429,7 +2429,6 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
>  
>  	return error;
>  }
> -EXPORT_SYMBOL(dquot_load_quota_sb);
>  
>  /*
>   * More powerful function for turning on quotas on given quota inode allowing
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index 11a4becff3a983..671fd306ccf01c 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -95,8 +95,6 @@ int dquot_mark_dquot_dirty(struct dquot *dquot);
>  
>  int dquot_file_open(struct inode *inode, struct file *file);
>  
> -int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
> -	unsigned int flags);
>  int dquot_load_quota_inode(struct inode *inode, int type, int format_id,
>  	unsigned int flags);
>  int dquot_quota_on(struct super_block *sb, int type, int format_id,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
