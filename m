Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22581414F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhIVSAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbhIVSAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:00:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09822C061574;
        Wed, 22 Sep 2021 10:59:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so15252835lfu.5;
        Wed, 22 Sep 2021 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WgiekJX/9s+5F7cMUsEs7Zs0JsPNW6fpesGls7i7KT8=;
        b=Nail03moQgFVy1/7r6Gq/ckz1aed3mwnw3MlwiU1PQ42OrOdGSlNkpbWD+mWymhTLN
         pkwNGNCLoFG4UhwR8st2sSygtqa7K/QBDCq+8ZDK1QzdEagva/C77QzYbnkJJE3+siu7
         OGJRQ2W/LAvY594y4BDxlEiMZBurWunhDXsMZwHBJzx1dVRWo2gIoO2EuVdAafksAibz
         f1pBlpt1R0qyNqEgvF8/JqrkoCTjILsqUl927jHQul12PzAiWhI/g2i/toUIJ8N810Y4
         KA28WuXjDhTEd2OdefOpdaj+pwjyOl+yF5WZThY/EitbuOYEFBTNEtAc64DpXtKnUEyZ
         aaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgiekJX/9s+5F7cMUsEs7Zs0JsPNW6fpesGls7i7KT8=;
        b=yau3k7iCsSSAqaTmdgAOeh+1p1rFGJmtF2y6ijifCrV5LNwanhQUXCOXQxJsoPLG+Q
         dgjfi/M80zr87CAcjc6mk4Z2gB/OqTG9cMAynBR9e+FwqK+uFVNaAmn8eE3eDI+6JFp6
         QodMDrk6cfnGmppwHB+YN1THuOeXBZs+JvRusA52ddv56ww+xjxXA8uWRafUxHlT10T+
         0RAk9Rngsk6ADebIv75uawf3afxuXEHTOjHhLTcXhryzDLVz/AzqlHZLjoYe8UtAkmbS
         HX0MJDTFmk++zdntFl3pN5mmQ8QrlouKbX+kQQG904KCdaHjWDotDkcaZVrjvZFkeM+Z
         IYWw==
X-Gm-Message-State: AOAM533q4M/FJ3lXprvN6Qvfcda9n5sscPyNtRwLxTReq/QLjpXLF+3M
        5RhIZM7rkC2zbgSYArVkG42UaA6bL6Ifmg==
X-Google-Smtp-Source: ABdhPJz36uCauveUA5oGPy0oAbBIE0SUYcjYHgpKN1npnNyNrwzCY3bAaxCkb0RAIxuuXF56d1+HgQ==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr538140ljj.505.1632333546859;
        Wed, 22 Sep 2021 10:59:06 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id n9sm228733lfh.267.2021.09.22.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:59:06 -0700 (PDT)
Date:   Wed, 22 Sep 2021 20:59:04 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs/ntfs3: Pass flags to ntfs_set_ea in
 ntfs_set_acl_ex
Message-ID: <20210922175904.s5rxwhabnfopjbve@kari-VirtualBox>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
 <fd75b417-f5a0-d0f2-c2d3-35d465e41334@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd75b417-f5a0-d0f2-c2d3-35d465e41334@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:19:19PM +0300, Konstantin Komarov wrote:
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Please tell why we need to pass flags to ntfs_set_ea(). Commit message
is for why we do something. It does not have to have example have any
info what we did. Code will tell that.

> ---
>  fs/ntfs3/xattr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 3795943efc8e..70f2f9eb6b1e 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -549,6 +549,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  	size_t size, name_len;
>  	void *value = NULL;
>  	int err = 0;
> +	int flags;
>  
>  	if (S_ISLNK(inode->i_mode))
>  		return -EOPNOTSUPP;
> @@ -591,20 +592,24 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  	}
>  
>  	if (!acl) {
> +		/* Remove xattr if it can be presented via mode. */
>  		size = 0;
>  		value = NULL;
> +		flags = XATTR_REPLACE;
>  	} else {
>  		size = posix_acl_xattr_size(acl->a_count);
>  		value = kmalloc(size, GFP_NOFS);
>  		if (!value)
>  			return -ENOMEM;
> -
>  		err = posix_acl_to_xattr(mnt_userns, acl, value, size);
>  		if (err < 0)
>  			goto out;
> +		flags = 0;
>  	}
>  
> -	err = ntfs_set_ea(inode, name, name_len, value, size, 0, locked);
> +	err = ntfs_set_ea(inode, name, name_len, value, size, flags, locked);
> +	if (err == -ENODATA && !size)
> +		err = 0; /* Removing non existed xattr. */
>  	if (!err)
>  		set_cached_acl(inode, type, acl);
>  
> -- 
> 2.33.0
> 
> 
> 
