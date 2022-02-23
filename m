Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6364C0F8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbiBWJuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiBWJuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:50:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B985973;
        Wed, 23 Feb 2022 01:49:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1F3AB212B8;
        Wed, 23 Feb 2022 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nnloXaiMP3v41jRheLMtPFTQPPJndIfeoLQbvILEju0=;
        b=m8/cwZZg44TMdxTTUif6ug2yJhwuD/tLZZhUovOc7P56RT+JisOBpLBULbP9jaC20wucgV
        y/xbKoTcLOniqjRe58/4uZJQ+7rKa5xkVGGgVB2SVE2zQaNg82/zRoI/BRiEC8O0niBvEz
        MuD+lsTEsisuYvpBO+DHQXvGxlHkKLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nnloXaiMP3v41jRheLMtPFTQPPJndIfeoLQbvILEju0=;
        b=4a/qbldYbcWBpHdCmrmJhNXVwdfXNH6Yrlwlg/ZB3sO27UKHEncX59L0xm7BHbeGYp3YMM
        0bv+yVhG/4FE7MAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0E5C0A3B84;
        Wed, 23 Feb 2022 09:49:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B137FA0605; Wed, 23 Feb 2022 10:49:34 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:49:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 8/9] ext4: Convert ext4_fc_track_dentry type events to use
 event class
Message-ID: <20220223094934.wfcmceilhjtnbxjq@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <bf55f9a22a67f8619ffe5f1af47bebb43f5ed372.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf55f9a22a67f8619ffe5f1af47bebb43f5ed372.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:16, Ritesh Harjani wrote:
> One should use DECLARE_EVENT_CLASS for similar event types instead of
> defining TRACE_EVENT for each event type. This is helpful in reducing
> the text section footprint for e.g. [1]
> 
> [1]: https://lwn.net/Articles/381064/
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/ext4.h | 57 +++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 233dbffa5ceb..33a059d845d6 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2783,33 +2783,40 @@ TRACE_EVENT(ext4_fc_stats,
>  		  __entry->fc_numblks)
>  );
>  
> -#define DEFINE_TRACE_DENTRY_EVENT(__type)				\
> -	TRACE_EVENT(ext4_fc_track_##__type,				\
> -	    TP_PROTO(struct inode *inode, struct dentry *dentry, int ret), \
> -									\
> -	    TP_ARGS(inode, dentry, ret),				\
> -									\
> -	    TP_STRUCT__entry(						\
> -		    __field(dev_t, dev)					\
> -		    __field(int, ino)					\
> -		    __field(int, error)					\
> -		    ),							\
> -									\
> -	    TP_fast_assign(						\
> -		    __entry->dev = inode->i_sb->s_dev;			\
> -		    __entry->ino = inode->i_ino;			\
> -		    __entry->error = ret;				\
> -		    ),							\
> -									\
> -	    TP_printk("dev %d:%d, inode %d, error %d, fc_%s",		\
> -		      MAJOR(__entry->dev), MINOR(__entry->dev),		\
> -		      __entry->ino, __entry->error,			\
> -		      #__type)						\
> +DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
> +
> +	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),
> +
> +	TP_ARGS(inode, dentry, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(int, ino)
> +		__field(int, error)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->ino = inode->i_ino;
> +		__entry->error = ret;
> +	),
> +
> +	TP_printk("dev %d,%d, inode %d, error %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino, __entry->error
>  	)
> +);
> +
> +#define DEFINE_EVENT_CLASS_TYPE(__type)					\
> +DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,		\
> +	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),	\
> +	TP_ARGS(inode, dentry, ret)					\
> +)
> +
>  
> -DEFINE_TRACE_DENTRY_EVENT(create);
> -DEFINE_TRACE_DENTRY_EVENT(link);
> -DEFINE_TRACE_DENTRY_EVENT(unlink);
> +DEFINE_EVENT_CLASS_TYPE(create);
> +DEFINE_EVENT_CLASS_TYPE(link);
> +DEFINE_EVENT_CLASS_TYPE(unlink);
>  
>  TRACE_EVENT(ext4_fc_track_inode,
>  	    TP_PROTO(struct inode *inode, int ret),
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
