Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8675414FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhIVSZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbhIVSZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:25:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A89C061574;
        Wed, 22 Sep 2021 11:23:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i4so15465516lfv.4;
        Wed, 22 Sep 2021 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKRwU9c+/pSkhmvdQwO2DPV9Q3SZon6fkbx8oBC8l1g=;
        b=LEoLv+U1//8JcyzFn3DpD/I2BUc/E2ldSsQdrzSYBYjVSdztxjniRdFePUDBUhKJa7
         Gfqycnonsb7pav9/IPFNt+1mg5Op1xL5NgIwaHNHmxLjXd9h3boGhuxQfWNIzul/Ecah
         ztQHhgfEMExp4nV4gym0n+3Sb8HwEt7Q55wlkS5Adj1OQdBLT5hcgStknO+kj0M8e4yt
         aRM/YefMB2V5/BY7mGe74BanUupiPfbI96aRVBx5C4KUSZzB+XEeehZx9MD25V23H+Yw
         FDpzPvAf3w284n8Lz+TPefKyvdKpArTOSMkYaKrEIqPkYIweQsUv96Skhm9zuSmLJMBv
         NEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKRwU9c+/pSkhmvdQwO2DPV9Q3SZon6fkbx8oBC8l1g=;
        b=ciCvyfuU/Cc90qOnOXRPBwI9doqEogJ9ayfSJy+MBGenflw1Mtl4ff0iwbSoJUII/b
         ffH76lM+KyAGCiLynfWxM7t9LV4dNEoSh4LcMzQz3azLpHQKSpJ2L4WU3BziNh+d9s/1
         6nrL/8WrXw7lqsosWR0VvbwJk0MdaPEQf3v3Rrpoi65YbKwxKG6sI09kWVy+gnrtTBBl
         zJOaeE18tmJfHJVw1r5kV22qEbjpB5L6ZTNJmoWnwHx3TsS1UJA0U6zf52ZHkDiSxdca
         /Rn9MBtWXLtfhgyV6ugSDzree+VDxp310eqsx/VRiUq+/DleUMhCJfL7bCLHXmiCIwH+
         tt6A==
X-Gm-Message-State: AOAM5308q0Hb9hFP3x+zdEiLbI1gYAGc03TLaV1CvgCTpC2pW7dEYcrA
        lNkK8eAgMA22tAwDFb67FiY=
X-Google-Smtp-Source: ABdhPJw0ar4WYCQsQMIEXySCREhX0gOjWrAnByoMEycfOFe0yVzzH+jeZZFKy7YcxQZOs1PN9uxhkA==
X-Received: by 2002:a05:651c:170c:: with SMTP id be12mr746530ljb.230.1632335029441;
        Wed, 22 Sep 2021 11:23:49 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id w13sm235378lft.94.2021.09.22.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:23:49 -0700 (PDT)
Date:   Wed, 22 Sep 2021 21:23:47 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fs/ntfs3: Change posix_acl_equiv_mode to
 posix_acl_update_mode
Message-ID: <20210922182347.yp4gxxoljc3vfnuu@kari-VirtualBox>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
 <18250134-b9a0-c2af-ce7f-9ec01ddfdb9a@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18250134-b9a0-c2af-ce7f-9ec01ddfdb9a@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:20:05PM +0300, Konstantin Komarov wrote:
> Right now ntfs3 uses posix_acl_equiv_mode instead of
> posix_acl_update_mode like all other fs.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/xattr.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 70f2f9eb6b1e..59ec5e61a239 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -559,22 +559,15 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  		if (acl) {
>  			umode_t mode = inode->i_mode;
>  
> -			err = posix_acl_equiv_mode(acl, &mode);
> -			if (err < 0)
> -				return err;
> +			err = posix_acl_update_mode(mnt_userns, inode, &mode,
> +						    &acl);
> +			if (err)
> +				goto out;
>  
>  			if (inode->i_mode != mode) {
>  				inode->i_mode = mode;
>  				mark_inode_dirty(inode);
>  			}
> -
> -			if (!err) {
> -				/*
> -				 * ACL can be exactly represented in the
> -				 * traditional file mode permission bits.
> -				 */
> -				acl = NULL;
> -			}
>  		}
>  		name = XATTR_NAME_POSIX_ACL_ACCESS;
>  		name_len = sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1;
> -- 
> 2.33.0
> 
> 
> 
