Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9203E5390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 08:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHJGcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 02:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHJGcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:32:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC34C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 23:32:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so3818947pjl.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8IVZ0Kj9AV3K3qH2x82l4kvS3lYosPqoF2f+Ebifv8=;
        b=b3lMSkq4Mz4hAV87OA9imXtate/v5mnBGVhtk2TzJQMJgEhf966DQBG0PRGpzna8n9
         154Src3qFTwoSJrEoPAhRX4irn0ZeAjxZPKF3zRAkdnNa9j2riuAh0gYxADWebEAldu3
         klhk2LcKOrovSDhJ37t8DUHGOFI4GSK5w9bTU6zII66SOkrks7J48BrzEMTqhQb04dY4
         Sl5hk4+QCZ8DGhJZvPnhbxJPcyr4nwiWBmUjjBj72zxc89rlic65hQZzHOCOMqnvPDpL
         GHSzzf6GQY5ulhpcI5f56J5cGVqMTuSjkKPuxguTPLR+Tz4BTsZAL/BIYbmeTfDjFqh4
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8IVZ0Kj9AV3K3qH2x82l4kvS3lYosPqoF2f+Ebifv8=;
        b=peOYcOnEMjnKao4Iale3Dnu4axFltufcSoHvCaUNHxHFRIrymG9NEzupnlahzF0/zd
         BCH0qqczF6qGMAlU87e2dNQWecpl8tMdlxQUP7dpUjr06BwTe3caAcTkj5mS9iY/Wj60
         eRnfRVJy2ze0wr28RnSmqR6Z20m5mJkFXp094pwZfp2MT6NekKecp6zVdJgARwBndg+X
         N6rW6Xh61wXRB8HqWC0IWv3PcynCwmNi6uR0MjSIWQaq4iUWBx2RBmdAU8x5npHlIbj4
         /o6NcnO1vBszPi4+joef5hxfmxQJ+HJ4Nbod+IJXs03T0ELVT1YND7ObszuuzV+imfIY
         V5OA==
X-Gm-Message-State: AOAM5323e3/qG9op2h3kCxEfR7eZMb6/xpM5AnBZSYF7KvG+dEHSHpmE
        qPyclyKm6IO6gu2E+m+XIeCLhQ==
X-Google-Smtp-Source: ABdhPJxJw/eaL5bCALMrPvbf1DdPNUzX/rh6evc6P6yi0k213J5FFVJr8f04G42Yyas2afvPjbam7A==
X-Received: by 2002:aa7:85cf:0:b029:3bc:9087:a94f with SMTP id z15-20020aa785cf0000b02903bc9087a94fmr21370396pfn.78.1628577119682;
        Mon, 09 Aug 2021 23:31:59 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id e12sm26017250pgv.51.2021.08.09.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:31:59 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:31:48 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fsnotify: count all objects with attached connectors
Message-ID: <YRIdVGmgAY+HOJYY@google.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
 <20210803180344.2398374-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180344.2398374-4-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:03:43PM +0300, Amir Goldstein wrote:
> Rename s_fsnotify_inode_refs to s_fsnotify_conectors and count all

s/s_fsnotify_conectors/s_fsnotify_connectors ;)

> objects with attached connectors, not only inodes with attached
> connectors.
> 
> This will be used to optimize fsnotify() calls on sb without any
> type of marks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Have one question below.

> ---
>  fs/notify/fsnotify.c |  6 +++---
>  fs/notify/mark.c     | 45 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/fs.h   |  4 ++--
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 30d422b8c0fc..a5de7f32c493 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -87,9 +87,9 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  
>  	if (iput_inode)
>  		iput(iput_inode);
> -	/* Wait for outstanding inode references from connectors */
> -	wait_var_event(&sb->s_fsnotify_inode_refs,
> -		       !atomic_long_read(&sb->s_fsnotify_inode_refs));
> +	/* Wait for outstanding object references from connectors */
> +	wait_var_event(&sb->s_fsnotify_connectors,
> +		       !atomic_long_read(&sb->s_fsnotify_connectors));
>  }
>  
>  void fsnotify_sb_delete(struct super_block *sb)
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 2d8c46e1167d..622bcbface4f 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -172,7 +172,7 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
>  static void fsnotify_get_inode_ref(struct inode *inode)
>  {
>  	ihold(inode);
> -	atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
> +	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
>  }
>  
>  static void fsnotify_put_inode_ref(struct inode *inode)
> @@ -180,8 +180,45 @@ static void fsnotify_put_inode_ref(struct inode *inode)
>  	struct super_block *sb = inode->i_sb;
>  
>  	iput(inode);
> -	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
> -		wake_up_var(&sb->s_fsnotify_inode_refs);
> +	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> +		wake_up_var(&sb->s_fsnotify_connectors);
> +}
> +
> +static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
> +{
> +	struct super_block *sb;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
> +		return;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> +		sb = fsnotify_conn_inode(conn)->i_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
> +		sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
> +		sb = fsnotify_conn_sb(conn);

I noticed that you haven't provided an explicit case when no conditions are
matched, however this scenario appears to be handled in
fsnotify_put_sb_connectors() below. Why is this the case here and not in
fsnotify_put_sb_connectors()?

Also, I'm wondering if these blocks of code would be better expressed in a
switch statement. Alternatively, if these conditionals are shared across
the two helpers, why not factor out the super_block retrieval into an
inline helper just to simplify the callsite and not duplicate code? That's
of course if there is commonality between the two helpers.

> +
> +	atomic_long_inc(&sb->s_fsnotify_connectors);
> +}
> +
> +static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
> +{
> +	struct super_block *sb;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
> +		return;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> +		sb = fsnotify_conn_inode(conn)->i_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
> +		sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
> +		sb = fsnotify_conn_sb(conn);
> +	else
> +		return;
> +
> +	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> +		wake_up_var(&sb->s_fsnotify_connectors);
>  }
>  
>  static void *fsnotify_detach_connector_from_object(
> @@ -203,6 +240,7 @@ static void *fsnotify_detach_connector_from_object(
>  		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
>  	}
>  
> +	fsnotify_put_sb_connectors(conn);
>  	rcu_assign_pointer(*(conn->obj), NULL);
>  	conn->obj = NULL;
>  	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
> @@ -504,6 +542,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  		inode = fsnotify_conn_inode(conn);
>  		fsnotify_get_inode_ref(inode);
>  	}
> +	fsnotify_get_sb_connectors(conn);
>  
>  	/*
>  	 * cmpxchg() provides the barrier so that readers of *connp can see
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640574294216..d48d2018dfa4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1507,8 +1507,8 @@ struct super_block {
>  	/* Number of inodes with nlink == 0 but still referenced */
>  	atomic_long_t s_remove_count;
>  
> -	/* Pending fsnotify inode refs */
> -	atomic_long_t s_fsnotify_inode_refs;
> +	/* Number of inode/mount/sb objects that are being watched */
> +	atomic_long_t s_fsnotify_connectors;
>  
>  	/* Being remounted read-only */
>  	int s_readonly_remount;
> -- 
> 2.25.1

/M
