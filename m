Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B541500A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhIVSms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIVSmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:42:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D4DC061574;
        Wed, 22 Sep 2021 11:41:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b20so15830776lfv.3;
        Wed, 22 Sep 2021 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UgTnUajNxhQv1bSX+L1qSLXHcGp1ndN6rNMXC6wSsEI=;
        b=CtVAn9D+YM9Vnvy+1+BtULuJyZyJKCEph3eYUCFDduRHUrzDP9b/YFQTpvFz6u5S+b
         N8w7DARSL3InG4KhOdhx3S+qqr/korqSCYwetJyHPjo/1sUh4J0Kbvkc3tezaTH0rk3c
         CQzyHWrE2LHsHBg5485CkijaXn2ephH29HozLQvw4odr6voMjEPSVc8NP7aNh7lpnxTJ
         kODPEC+57jENJVuq6p0JJZaPw+941POgg5BM0BafdVas1RSzWwXFXZkfDMrIGIxqzxSt
         ZKk7akk3TSOIatvY8LLd5fMdDtmjIyGpXG/emLwiGSF2VY2QRew2+TLI3g/+eT1TbfeU
         qSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UgTnUajNxhQv1bSX+L1qSLXHcGp1ndN6rNMXC6wSsEI=;
        b=kqWWp+O5GryQWt8Aa47zW4dCNQLLoiHqETxgjNu4j8BR1DI5kKIebk9s7iI2LXjT7s
         E4DROabeTS/e+9Y2t+UrE6I3chLrYe5H40gigpRYUJeSjrp8p49CM0cHPFzzqzhoaBgv
         twGeLdOU4msX/R/wNMwaPIHD7PaOElScSBt8C+e0BV3nq0OmuOKZt3bZ3GdJqLiuylxq
         lA7uZ5BI9gK2oOZLIpMeq+6KD3qbyFRPnnDye7fit0eY8jS8rdUr0d2CQaCgvyaPdcIe
         yS78Jm7me/WnDMh+PT3UvLTyqdHvGbr91rd0wNj1bXeCfZBprJZiHMlJLtSL0msKP/jd
         PcuQ==
X-Gm-Message-State: AOAM531GJQGTSeEPCzXW6BCOCkFjPqMHZtKHp3SIDSl3yyOxZFoFc2wZ
        lb2pAhnqRrPcZkqeXka+7xsXXeJLrSo=
X-Google-Smtp-Source: ABdhPJwegIF5Vau8XaRZHRp5eAFJumV1Po63gcC4JGip15grFPwVzAVKh7wYhAzYSozAVaaILh2IAw==
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr375857lfg.617.1632336074338;
        Wed, 22 Sep 2021 11:41:14 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id i10sm237802lfu.71.2021.09.22.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:41:13 -0700 (PDT)
Date:   Wed, 22 Sep 2021 21:41:12 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/ntfs3: Refactoring lock in ntfs_init_acl
Message-ID: <20210922184112.r7ljydxc3rb3xifm@kari-VirtualBox>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
 <ed6426f4-a579-86ce-a54f-ac356991a797@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6426f4-a579-86ce-a54f-ac356991a797@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:20:49PM +0300, Konstantin Komarov wrote:
> This is possible because of moving lock into ntfs_create_inode.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Looks good.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/xattr.c | 55 ++++++++++++------------------------------------
>  1 file changed, 14 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 59ec5e61a239..83bbee277e12 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -693,54 +693,27 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  	struct posix_acl *default_acl, *acl;
>  	int err;
>  
> -	/*
> -	 * TODO: Refactoring lock.
> -	 * ni_lock(dir) ... -> posix_acl_create(dir,...) -> ntfs_get_acl -> ni_lock(dir)
> -	 */
> -	inode->i_default_acl = NULL;
> -
> -	default_acl = ntfs_get_acl_ex(mnt_userns, dir, ACL_TYPE_DEFAULT, 1);
> -
> -	if (!default_acl || default_acl == ERR_PTR(-EOPNOTSUPP)) {
> -		inode->i_mode &= ~current_umask();
> -		err = 0;
> -		goto out;
> -	}
> -
> -	if (IS_ERR(default_acl)) {
> -		err = PTR_ERR(default_acl);
> -		goto out;
> -	}
> -
> -	acl = default_acl;
> -	err = __posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
> -	if (err < 0)
> -		goto out1;
> -	if (!err) {
> -		posix_acl_release(acl);
> -		acl = NULL;
> -	}
> -
> -	if (!S_ISDIR(inode->i_mode)) {
> -		posix_acl_release(default_acl);
> -		default_acl = NULL;
> -	}
> +	err = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
> +	if (err)
> +		return err;
>  
> -	if (default_acl)
> +	if (default_acl) {
>  		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
>  				      ACL_TYPE_DEFAULT, 1);
> +		posix_acl_release(default_acl);
> +	} else {
> +		inode->i_default_acl = NULL;
> +	}
>  
>  	if (!acl)
>  		inode->i_acl = NULL;
> -	else if (!err)
> -		err = ntfs_set_acl_ex(mnt_userns, inode, acl, ACL_TYPE_ACCESS,
> -				      1);
> -
> -	posix_acl_release(acl);
> -out1:
> -	posix_acl_release(default_acl);
> +	else {
> +		if (!err)
> +			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
> +					      ACL_TYPE_ACCESS, 1);
> +		posix_acl_release(acl);
> +	}
>  
> -out:
>  	return err;
>  }
>  #endif
> -- 
> 2.33.0
> 
> 
> 
