Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD14382A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJWJhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhJWJhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:37:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D7C061764;
        Sat, 23 Oct 2021 02:35:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so386301lfu.5;
        Sat, 23 Oct 2021 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6ON3Zyd38dVy3J5eWV++FHn36HNb79c0btCWx3Q2tL8=;
        b=V7ZIyk67Xdk+NSLH4w8wxFqfN1H/d6AsN9xKYkTQq7Ue8h2b9Mj5UV6LJpgl37roWI
         fuNfwKv/fxgtTvHBpHphRq3gyXo55ncvmrxtYDhshcU5fsmsYtIBqhZwrvYvRsoI3JZr
         efzmJyFdkorGP1Aw1Pz2zAtFQBqpSgbF5B/Rney/Dk3wvpR+j8s/nxNKCpkbWcoPOrRc
         hhpjWcPCafbg2PYC7GHvNIjjEzT0DUivZxrAutf4oDkP29B5gAcAQAg2I9WSVaKL2ASq
         dWJHLIH/+xYEjJNzRdLNMo7X8z0rV58EmYrmc9e2bUGbPCz/8FQ2k0riwXuSsEIXrIoX
         Cf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6ON3Zyd38dVy3J5eWV++FHn36HNb79c0btCWx3Q2tL8=;
        b=E7ryO5Kb8MK/fuMaLco13cbOGAl/RsYcZy4ByyGoXKHUfa/5zBx+chj0SfMKnr5mZv
         gF6JdyNbCZOHW0TAx3eiA2K0FL67sgIvzR2lvS+4TZTJfd98ydViZEk46rlzeVRuoPEg
         iZoV0AQrXQDQTQB2mLzKQNc//N0d5FgkF+A8z0rfB3IvbbYmMl4Sx7kfIhNqtkQ+z9St
         qEKfc+3L/7p6jEJuTt7uKaPMAKKE57tqt3V57dDxtRHfnYsq4NvLvRCntSNyWFCI9EDb
         /cukMVthIe/UkNZLYn21dWrUwyWe+rIm24vH1dCVqyOQy0k9Ea7vL4wvEzKA7QkjjZZW
         zdFQ==
X-Gm-Message-State: AOAM533K+GLYrGeygOjatDUDKfQm584O1+x+zXZ6aexPu3pGYDPEzWjD
        qjOyhJDYfL0khSjmLUYzp0ZVTsm/BsE=
X-Google-Smtp-Source: ABdhPJyfpzOgcdrfjEOiA+SknsMCgYBNpxu821BJTfnr5DT/J3prfLJDZKqoU5JQaHReZAK08YaBrA==
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr4733255lfb.517.1634981699960;
        Sat, 23 Oct 2021 02:34:59 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id r30sm975137lfp.298.2021.10.23.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 02:34:59 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:34:57 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/ntfs3: Restore ntfs_xattr_get_acl and
 ntfs_xattr_set_acl functions
Message-ID: <20211023093457.lelto5esrjvncah2@kari-VirtualBox>
References: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
 <0aad4d9e-983b-6a79-15c1-61743081a1b3@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aad4d9e-983b-6a79-15c1-61743081a1b3@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 06:55:09PM +0300, Konstantin Komarov wrote:
> Apparently we need to maintain these functions with
> ntfs_get_acl_ex and ntfs_set_acl_ex.
> This commit fixes xfstest generic/099
> Fixes: 95dd8b2c1ed0 ("fs/ntfs3: Remove unnecessary functions")

I get build error with patch 1&2 applied.

fs/ntfs3/xattr.c: In function ‘ntfs_xattr_get_acl’:
fs/ntfs3/xattr.c:631:8: error: too many arguments to function ‘ntfs_get_acl’
  631 |  acl = ntfs_get_acl(inode, type, false);
      |        ^~~~~~~~~~~~
fs/ntfs3/xattr.c:533:19: note: declared here
  533 | struct posix_acl *ntfs_get_acl(struct inode *inode, int type)

> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/xattr.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 2143099cffdf..62605781790b 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -112,7 +112,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
>  		return -ENOMEM;
>  
>  	if (!size) {
> -		;
> +		/* EA info persists, but xattr is empty. Looks like EA problem. */
>  	} else if (attr_ea->non_res) {
>  		struct runs_tree run;
>  
> @@ -616,6 +616,67 @@ int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
>  }
>  
> +static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
> +			      struct inode *inode, int type, void *buffer,
> +			      size_t size)
> +{
> +	struct posix_acl *acl;
> +	int err;
> +
> +	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
> +		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	acl = ntfs_get_acl(inode, type, false);
> +	if (IS_ERR(acl))
> +		return PTR_ERR(acl);
> +
> +	if (!acl)
> +		return -ENODATA;
> +
> +	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
> +	posix_acl_release(acl);
> +
> +	return err;
> +}
> +
> +static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
> +			      struct inode *inode, int type, const void *value,
> +			      size_t size)
> +{
> +	struct posix_acl *acl;
> +	int err;
> +
> +	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
> +		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!inode_owner_or_capable(mnt_userns, inode))
> +		return -EPERM;
> +
> +	if (!value) {
> +		acl = NULL;
> +	} else {
> +		acl = posix_acl_from_xattr(mnt_userns, value, size);
> +		if (IS_ERR(acl))
> +			return PTR_ERR(acl);
> +
> +		if (acl) {
> +			err = posix_acl_valid(mnt_userns, acl);
> +			if (err)
> +				goto release_and_out;
> +		}
> +	}
> +
> +	err = ntfs_set_acl(mnt_userns, inode, acl, type);
> +
> +release_and_out:
> +	posix_acl_release(acl);
> +	return err;
> +}
> +
>  /*
>   * ntfs_init_acl - Initialize the ACLs of a new inode.
>   *
> @@ -782,6 +843,23 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
>  		goto out;
>  	}
>  
> +#ifdef CONFIG_NTFS3_FS_POSIX_ACL
> +	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
> +	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
> +		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
> +	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
> +	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
> +		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
> +		/* TODO: init_user_ns? */
> +		err = ntfs_xattr_get_acl(
> +			&init_user_ns, inode,
> +			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
> +				? ACL_TYPE_ACCESS
> +				: ACL_TYPE_DEFAULT,
> +			buffer, size);
> +		goto out;
> +	}
> +#endif
>  	/* Deal with NTFS extended attribute. */
>  	err = ntfs_get_ea(inode, name, name_len, buffer, size, NULL);
>  
> @@ -894,6 +972,22 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>  		goto out;
>  	}
>  
> +#ifdef CONFIG_NTFS3_FS_POSIX_ACL
> +	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
> +	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
> +		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
> +	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
> +	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
> +		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
> +		err = ntfs_xattr_set_acl(
> +			mnt_userns, inode,
> +			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
> +				? ACL_TYPE_ACCESS
> +				: ACL_TYPE_DEFAULT,
> +			value, size);
> +		goto out;
> +	}
> +#endif
>  	/* Deal with NTFS extended attribute. */
>  	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
>  
> -- 
> 2.33.0
> 
> 
