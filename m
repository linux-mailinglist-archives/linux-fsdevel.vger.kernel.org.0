Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9143BBA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 22:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhJZUja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhJZUja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:39:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0FBC061570;
        Tue, 26 Oct 2021 13:37:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p16so1448703lfa.2;
        Tue, 26 Oct 2021 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oI5Ood+ax8/bXSOkMdkot2htI6P0pPz1aqt3AiMoPto=;
        b=NIRqSixj0TpI/WWovPTLYLHD+Mzi+g1nIgYyynsJCRWXR8UCvvASOEuccE2ZIPv3j7
         vlv8CXjMxyc7d+RV8QOhJLU4KpUkf9bB02uzDZnHFfIw9gGe7mUDrLJpnjd+Ec9Gc2Q6
         pC1gN1YixBg7f39+ICn7VqLJpJxsswoqNa4QqvKuhZQvR60tawfldfFyqi4v/lGt8kxw
         oK0Ng+fdlf9er7ko89GgE4tznGVXvs6K5T5ZXJKBv8JOKkIWfBLZ+XVl6YZATHsT6NiG
         oiFCfuETRfYt9+9S7cJx2okol3ADGb4l3pcwdhKM2OvApvPti9qhAVv/V6XcrkUqGczh
         ioew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oI5Ood+ax8/bXSOkMdkot2htI6P0pPz1aqt3AiMoPto=;
        b=EgL2HObmoj+1Jppo992xEPLh/B6FJU8+SPxnwPnm2u2Yzj6OyV3rfgR+dO1cSj3O2n
         o0k6yL0ZoPVXBFrboV2oZdIZhgBgRdNA+mRENBk2exejzCf5LxkGEwKK/293YG9aV0iK
         HSBxqAnFiFiePUsLQQ5arZ4GRCJXX5vxqdlP5vSkbFei3zP0+qWqlANmlYxACcDy5VXB
         7Es75ctUruiE5QjBuCe09RKAz7PRWaF4+ZFziUQ1im92rree8nWEeUEBmiwrwu4lpOnZ
         oEW3EQ8Wg3bISK0xZwXy4lfoOxZVYxv1KON+d0oR8A8kkGwVSTrcvg/jC6Q3+U/RFA0m
         TL8Q==
X-Gm-Message-State: AOAM532PW7VwLsEJ0e1NqC43T8R8pZzcRxLXR9UhRtcmaE2aaxfMj6Wx
        8halRLQwXLv/tMq1JHXLF67p4pHtILY=
X-Google-Smtp-Source: ABdhPJxztJyc7jlP4BkFEvWpIBBmKu1N4jUjOCTvgqS0KbFVN01kkiuuyrN4q5VYlqd49BiyioDCJg==
X-Received: by 2002:ac2:5f5c:: with SMTP id 28mr11677274lfz.238.1635280623667;
        Tue, 26 Oct 2021 13:37:03 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id n7sm2021856lft.309.2021.10.26.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:37:02 -0700 (PDT)
Date:   Tue, 26 Oct 2021 23:37:01 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/ntfs3: Restore ntfs_xattr_get_acl and
 ntfs_xattr_set_acl functions
Message-ID: <20211026203701.hqg2ihyuoyc7emr3@kari-VirtualBox>
References: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
 <ada6d126-e5b0-fe9e-2596-34f6550ad7a7@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada6d126-e5b0-fe9e-2596-34f6550ad7a7@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 07:41:27PM +0300, Konstantin Komarov wrote:
> Apparently we need to maintain these functions with
> ntfs_get_acl_ex and ntfs_set_acl_ex.
> This commit fixes xfstest generic/099

I like how you phrase this in one other patch

Fixes generic/099

but no need to change

> Fixes: 95dd8b2c1ed0 ("fs/ntfs3: Remove unnecessary functions")
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/xattr.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 2143099cffdf..3ccdb8c2ac0b 100644
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
> +	acl = ntfs_get_acl(inode, type);
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
