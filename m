Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44C5261D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgIHTe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbgIHP5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:57:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9412C0612A5;
        Tue,  8 Sep 2020 06:06:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so8257754pjb.4;
        Tue, 08 Sep 2020 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HhJcpAM1sVTshyBaZ8DqM82F52ye06r+Vvl0X2hVcWg=;
        b=XuW99k4dYGsFdgmEUUEsLFwx1KigPLt2dJlA7ZkVksTOQQy22ILceeLCzANYHRnNIU
         7leZtuDfb1Ts3bg0g2Df1SQw2lLMQvu0mIy84RxNiRGYVStyZiv+KiQKTp+AoUOPOZQU
         lfuEL8MyBMJCUO2rIluMXL8lWslBK2HnPxQD4v9sxuia0/xXiYcKa/3K78xmzxn6h2dp
         QAyMt5JR0Vs1VUf5S6nSoFo0uCah2siU9L0RG63uURRc2XyL/I0DIOWn+I8Ki5OiAt/1
         Ybzc4/rm8+T77s9rLeIQHUhVe9peVJrPvkEtyo2BSX26WVEOpdcpfucvbiv/LPE0EU7D
         IdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HhJcpAM1sVTshyBaZ8DqM82F52ye06r+Vvl0X2hVcWg=;
        b=NH2ZmAzkYzh2gRegwVfNlZ02D/jsJ8LHjJkXF+SDlCee/7p3u7itVavFwfG6TC/JtO
         k0xYFyqDlDEKuu/3Ijx5JcJg/4hLFC4jKAk/Za5FckKf1uZIAxykAinU0UxZn+Pi7s0R
         WvymA2yyATyEHUvN0SB5kmOJmC81JiztxOalVNah6cH3UV5XNhKSgOeRjF0kFGZazn5I
         AVqjomb1Knuf39g4XcuJObEhfotx5HgwROsDxy0gj2fYN0rdc52DmFFTtjeLkMhjTv5q
         pVkxhkzjh43rh3xRsg43va1Klq6rv29oxGXV1jc1fGjo9f75N/sK6GAkepW+d9CEi1zJ
         F/Sw==
X-Gm-Message-State: AOAM532lUYzCKqwYV/TZcq0ANGqwFDXNSwcrngQO3jS0JSMGbEOv3nwR
        QiO422eGPE3tAbI+Gk49KggFLwnKAu0OFG8R
X-Google-Smtp-Source: ABdhPJzvwq5L6QdMnyzEAjubzxihNYyRFloIuvT+kbZTTjPyszhhTLEBecg0Q+TjP/DLjV1G3oemFw==
X-Received: by 2002:a17:90b:208:: with SMTP id fy8mr3958774pjb.153.1599570418913;
        Tue, 08 Sep 2020 06:06:58 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id 13sm18498146pfp.3.2020.09.08.06.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:06:58 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:06:56 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more
 clear
Message-ID: <20200908130656.GC22780@haolee.github.io>
References: <20200729151740.GA3430@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729151740.GA3430@haolee.github.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping

On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
> The dentry local variable is introduced in 'commit 84d17192d2afd ("get
> rid of full-hash scan on detaching vfsmounts")' to reduce the length of
> some long statements for example
> mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
> inode_lock(dentry->d_inode) to do the same thing now, and its length is
> acceptable. Furthermore, it seems not concise that assign path->dentry
> to local variable dentry in the statement before goto. So, this function
> would be more clear if we eliminate the local variable dentry.
> 
> The function logic is not changed.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  fs/namespace.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4a0f600a3328..fcb93586fcc9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2187,20 +2187,19 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  static struct mountpoint *lock_mount(struct path *path)
>  {
>  	struct vfsmount *mnt;
> -	struct dentry *dentry = path->dentry;
>  retry:
> -	inode_lock(dentry->d_inode);
> -	if (unlikely(cant_mount(dentry))) {
> -		inode_unlock(dentry->d_inode);
> +	inode_lock(path->dentry->d_inode);
> +	if (unlikely(cant_mount(path->dentry))) {
> +		inode_unlock(path->dentry->d_inode);
>  		return ERR_PTR(-ENOENT);
>  	}
>  	namespace_lock();
>  	mnt = lookup_mnt(path);
>  	if (likely(!mnt)) {
> -		struct mountpoint *mp = get_mountpoint(dentry);
> +		struct mountpoint *mp = get_mountpoint(path->dentry);
>  		if (IS_ERR(mp)) {
>  			namespace_unlock();
> -			inode_unlock(dentry->d_inode);
> +			inode_unlock(path->dentry->d_inode);
>  			return mp;
>  		}
>  		return mp;
> @@ -2209,7 +2208,7 @@ static struct mountpoint *lock_mount(struct path *path)
>  	inode_unlock(path->dentry->d_inode);
>  	path_put(path);
>  	path->mnt = mnt;
> -	dentry = path->dentry = dget(mnt->mnt_root);
> +	path->dentry = dget(mnt->mnt_root);
>  	goto retry;
>  }
>  
> -- 
> 2.24.1
> 
