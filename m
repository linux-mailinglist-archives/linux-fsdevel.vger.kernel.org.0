Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1D417080
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbhIXK5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbhIXK5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:57:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AFC061574;
        Fri, 24 Sep 2021 03:55:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y28so38387889lfb.0;
        Fri, 24 Sep 2021 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C1UBVPOiBxrna2psdGW428HQ/0SgnTjldU3JVfQAMiY=;
        b=DZzI1AGDITTPQpxlthD3ayqCJmxAJUiKSO7VEi2DpHZBKHsotDCFkRE6+OAE+uJNBB
         11pghz1YV3RlBEjFwykumFLnhaEsVjrVPWJYNAztZ8lRyGgVfdTpFCHO3S1Pv0/PkAwL
         h/eLoSciW0bYQ0xKc2Q6hRdsyRfFXi6QX2Gabo5yHWJaiXT4ph4L7505uDQctdCvvjZv
         zghzWxzqPpGGwRS7Iz9eFkrhPDI9Ec2uxnSNmfnuSJi38gYd+cREBXN+YWbmKdJSpbFv
         nL7tJwSRhjYiQvg41mxZBhtya6Fv9IGAfMP94Qv34MW+BkBYLqZJ/XbZ4pRhDAWcvn+D
         w8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1UBVPOiBxrna2psdGW428HQ/0SgnTjldU3JVfQAMiY=;
        b=TrcuXl2GEgGo4NkY3Z0ngymA7I26WY2bpC1ZDsxpAickL5QhN7PH2PxUSmCliX5DTC
         7iHqeHkjYd2FD+O4lbgqyFsKw+I2yXyRk2HuFtg7W7zCwd+cTLLnFWWGtqiXyA20rYF0
         tiliSPNxr4xP/nLK/mXmDSipms6r46IkdORfG+phxek22SrS0ck01PluW4V1Jhs6Pkao
         xTbf0LxQlvviGyIFLQRoyJUsTAm7BkAQcqLIYijcJB2F8J/bMC81YQOQtna538K4KXm0
         Y3Zw2L7HLWfInGvrVxzGXqFnN8c2QVPFdKPYAwpxTBQmedS/RUvIGV9cByutTTRYm1pB
         qLAQ==
X-Gm-Message-State: AOAM5317lR3/vmjn2F6OyK9g1go3ziWrZITlH6Q8ZbKhMhJMzJ02akbX
        gtfp9An6wv92IL0ywTPdk0AI5S4RKhY=
X-Google-Smtp-Source: ABdhPJwqm+uYTYU4i9EkoBcCk6+LGCDKH63n5uC3W8iI1OcK2F9rkWW1p8OM+mLLkE+dxZVjJ+1GEw==
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr8785134lfu.54.1632480930437;
        Fri, 24 Sep 2021 03:55:30 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id bj40sm127996ljb.106.2021.09.24.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 03:55:29 -0700 (PDT)
Date:   Fri, 24 Sep 2021 13:55:27 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] fs/ntfs3: Change posix_acl_equiv_mode to
 posix_acl_update_mode
Message-ID: <20210924105527.srf7bimnfwmqb4mp@kari-VirtualBox>
References: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
 <22b8b701-e0c0-9b3f-dd58-0e8ab7c54754@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b8b701-e0c0-9b3f-dd58-0e8ab7c54754@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:44:55PM +0300, Konstantin Komarov wrote:
> Right now ntfs3 uses posix_acl_equiv_mode instead of
> posix_acl_update_mode like all other fs.
> 
> Reviewed-by: Kari Argillander <kari.argillander@gmail.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
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

Small nit. Maybe just straight
				return err;

Put you can choose if you feel changing it.

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
