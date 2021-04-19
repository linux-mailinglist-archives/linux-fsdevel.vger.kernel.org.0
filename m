Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7C363AA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 06:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhDSEtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSEty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:49:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003EC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Apr 2021 21:48:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso26693771otv.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Apr 2021 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jL7hJvT0imTo74BlTYm8q4MTMOtukYZw45XfWryvQaI=;
        b=R+jJbKSrFD+iwzFs4bfj+8LPnEV3qlAhl0OO2efaY5kk96+n1kHZqZ2AIMg1QuZ0HQ
         DzwIwcXkRWjgVxn9eHG0fM3zA67R0gYtOcfisL0r2ZIKcBpe0VvRD1dE4rBbx/zP/Mia
         GjRuRHcQRFdqZ7YWictj3Kd4yPAfwto3VctNhXfdYLmSxIcbKd0v6TgOaX8faD+7HAB9
         +6HJ2kJrYkAsMKZ+TiJM9PpER9/hfZjaZiSZRCTz7V9lnJYGjZjpVlEMoCQwB9yVsco+
         inz0peGREMf1Ui8WOF/X7sWq40yH9Gekn78rNiXqM4zwSQUd+v8AOFUgK0ajC4x0lSVZ
         RAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jL7hJvT0imTo74BlTYm8q4MTMOtukYZw45XfWryvQaI=;
        b=LQN9kqFkP+fHJTNvq+ZNoVpJVdWeaZhSNyZuCpyCRaEEGD5h5bIxyJYO9PYISVqx+L
         wqWpwyKvPsvDwMbdBQYtZXN7DK2vNiCKp+1a1Qwbu6kpHiPY2/a8JmDM7H2J7nNfb+ce
         2YMSyFre4q4wEmpA/0NnuN0obl6jeDRJET+zk8rwahqEON6UNyQBE3EPZNFSpL6Vf5mr
         8i20otY2WBk93kshV38YXjv8fDiEQdCALAWHkKgglH8nJ05z1iDZFzKX8ngKSIc5C+m/
         S3P+yC8B1YyGvVSDIzqSnCA1XicsZ3Fw0CkxQXuw50VBwP18nXCxnkr/pXS1N6TC1waf
         YMVw==
X-Gm-Message-State: AOAM531iaefdmJNPCGNxIC4GfEJHHuNppUyTwNhOF6XPlCkX0nXNur+B
        3qvHzacX8ltGl/jVU1qkofTtmA==
X-Google-Smtp-Source: ABdhPJzGJD7WgxIzMQKjh6m9uj4cx5zsqGe3mkvIZ82d8zPKT7f7NGGd37eM9aK3h8QZKBe3TkVvwQ==
X-Received: by 2002:a9d:2033:: with SMTP id n48mr202399ota.84.1618807732025;
        Sun, 18 Apr 2021 21:48:52 -0700 (PDT)
Received: from elm (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id v26sm174198ott.4.2021.04.18.21.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 21:48:51 -0700 (PDT)
Date:   Sun, 18 Apr 2021 23:48:50 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] ecryptfs: remove unused helpers
Message-ID: <20210419044850.GF398325@elm>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409162422.1326565-2-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-09 18:24:20, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Remove two helpers that are unused.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: ecryptfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

I'll pick this patch up now as it looks like it didn't make it into your
v2 of the port to private mounts. I'll review those patches separately.

Thanks!

Tyler

> ---
>  fs/ecryptfs/ecryptfs_kernel.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index e6ac78c62ca4..463b2d99b554 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -496,12 +496,6 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
>  	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
>  }
>  
> -static inline struct ecryptfs_dentry_info *
> -ecryptfs_dentry_to_private(struct dentry *dentry)
> -{
> -	return (struct ecryptfs_dentry_info *)dentry->d_fsdata;
> -}
> -
>  static inline void
>  ecryptfs_set_dentry_private(struct dentry *dentry,
>  			    struct ecryptfs_dentry_info *dentry_info)
> @@ -515,12 +509,6 @@ ecryptfs_dentry_to_lower(struct dentry *dentry)
>  	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
>  }
>  
> -static inline struct vfsmount *
> -ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
> -{
> -	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt;
> -}
> -
>  static inline struct path *
>  ecryptfs_dentry_to_lower_path(struct dentry *dentry)
>  {
> -- 
> 2.27.0
> 
