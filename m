Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48A3E5339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 08:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhHJGEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 02:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhHJGEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:04:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8CAC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 23:04:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so31565126pjv.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pm7OZpNwBM/I/rYViZvoLXFEyoJzcZzyFcFs3YiM0JA=;
        b=uMy56T8UltvsP0wzhV7gkTCr5916DdDkQ/zuiqWFso5nbX+WehdBSueAqRtAkYurnE
         uLPpOvr8FnHtQIonlfcgF49qcUSIvDWTLuv4JiyFk8gp4ALrWipAxPk7gPcp4siAX5wt
         miJyN046VXhy5YN9llXCywMJoYEmBPLdNJVxxcH+YUQfrEJ+2xeKA81KWGhpDg4DDC7Q
         2GAUPGq0N5/QUmiL8OnD/8jcoA3p0OwcOVihCu+79JJJF3lz06/i01qBNN/Zlj9dEPsP
         P6Qgn2X8NoGdk3xmATZ22BXn+XJ3r5BgjHQnTFSlI1IfWsRJ7oZgj9X7PZi3ARCtMxsu
         HpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pm7OZpNwBM/I/rYViZvoLXFEyoJzcZzyFcFs3YiM0JA=;
        b=krSsCtmr1/Ij11CYzjvV1sFaRZ4RgSV2h66MS0oKUJFN2+4LBCg9I1f0R/4cpyOOxE
         qP03PMvUyaocmoKZ3p5YWJCTl75cP4prmf7vNl3xQ6XG2MTZNf1PjxiPfRw1UY2YjCJA
         JaIc/vnz4b/br/9qWw7wFCziqv08512tkI/j/2jJ0TVDHpHjeAEyePwnsYYlJ4SilW63
         0/fh4EkpDVS91shiwnpxaGyad0XJ9Tyjp0Hqxf1aAg6ggwTdHAiyb6ojq496/xC3iC5n
         GS8KhibCTXkfoGVcB5NbWK4bSyu9KBklg3W85WkVav3sAJmWtLwCCLyFXbm2oafzhOya
         Bekg==
X-Gm-Message-State: AOAM532cd3jZlxlxlibPzSn095P/jIbFnCYcEjxErNNEpgIyYEzbneCP
        6mKziEaq0S5ovFyY2qiDMXKS6JFep5SPoA==
X-Google-Smtp-Source: ABdhPJxe1A5dFGZDAzoPqMHrdTv+p7OJAlFaOOBInW1adzi/DEFgFGtr3FogjcNEOIb9tBRQv4EeFg==
X-Received: by 2002:a62:e50c:0:b029:2f9:b9b1:d44f with SMTP id n12-20020a62e50c0000b02902f9b9b1d44fmr28129579pff.42.1628575442192;
        Mon, 09 Aug 2021 23:04:02 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id g2sm3786851pfi.211.2021.08.09.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:04:01 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:03:50 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fsnotify: count s_fsnotify_inode_refs for attached
 connectors
Message-ID: <YRIWxr0gP9+HlXuN@google.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
 <20210803180344.2398374-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180344.2398374-3-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:03:42PM +0300, Amir Goldstein wrote:
> Instead of incrementing s_fsnotify_inode_refs when detaching connector
> from inode, increment it earlier when attaching connector to inode.
> Next patch is going to use s_fsnotify_inode_refs to count all objects
> with attached connectors.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

LGTM.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  fs/notify/mark.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 80459db58f63..2d8c46e1167d 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -169,6 +169,21 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
>  	}
>  }
>  
> +static void fsnotify_get_inode_ref(struct inode *inode)
> +{
> +	ihold(inode);
> +	atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
> +}
> +
> +static void fsnotify_put_inode_ref(struct inode *inode)
> +{
> +	struct super_block *sb = inode->i_sb;
> +
> +	iput(inode);
> +	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
> +		wake_up_var(&sb->s_fsnotify_inode_refs);
> +}
> +
>  static void *fsnotify_detach_connector_from_object(
>  					struct fsnotify_mark_connector *conn,
>  					unsigned int *type)
> @@ -182,7 +197,6 @@ static void *fsnotify_detach_connector_from_object(
>  	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
>  		inode = fsnotify_conn_inode(conn);
>  		inode->i_fsnotify_mask = 0;
> -		atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
>  	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>  		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
>  	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
> @@ -209,19 +223,12 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
>  /* Drop object reference originally held by a connector */
>  static void fsnotify_drop_object(unsigned int type, void *objp)
>  {
> -	struct inode *inode;
> -	struct super_block *sb;
> -
>  	if (!objp)
>  		return;
>  	/* Currently only inode references are passed to be dropped */
>  	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
>  		return;
> -	inode = objp;
> -	sb = inode->i_sb;
> -	iput(inode);
> -	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
> -		wake_up_var(&sb->s_fsnotify_inode_refs);
> +	fsnotify_put_inode_ref(objp);
>  }
>  
>  void fsnotify_put_mark(struct fsnotify_mark *mark)
> @@ -495,7 +502,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	}
>  	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
>  		inode = fsnotify_conn_inode(conn);
> -		ihold(inode);
> +		fsnotify_get_inode_ref(inode);
>  	}
>  
>  	/*
> @@ -505,7 +512,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	if (cmpxchg(connp, NULL, conn)) {
>  		/* Someone else created list structure for us */
>  		if (inode)
> -			iput(inode);
> +			fsnotify_put_inode_ref(inode);
>  		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
>  	}
>  
> -- 
> 2.25.1
> 
/M
