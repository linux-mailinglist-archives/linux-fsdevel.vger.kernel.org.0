Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149B5ED083
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 00:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiI0Wzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 18:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI0Wzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:55:51 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99C7B289
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 15:55:49 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1278a61bd57so15205890fac.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pXQ78AAdTDST6MN/uNB1/oNlC/v7qf73J3QFhqE0a5c=;
        b=E4c8aKWYKso8wa6FTMwrNgu6HFyldja58tHb7CzLi/zwt52W/+8NzrirDp0f/NrA3m
         1PEs5epYzbJmIuav8aDN/UELqO221JSNjCXDyV6JiIuEerf9PC4m5VKPzsOElmpZbP1S
         Bs+m9nseTNUmow5uOplR1ftvM8YArOz5gFW49smYbod1R7DwQbGGSqfjSDWYivzbRX7Y
         8i/ni1khLdGUxUSarS2FezlNEgK+BFQonfVFUzsAxsfz50tkqm3b1UMNelAhtJ0xIMaK
         V5nG2H1DXv2ly0VYRaBYH9YaOyUC2fEdiqHOOC28/xc11peGO3SprZpApdnLogWjMOWS
         993g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pXQ78AAdTDST6MN/uNB1/oNlC/v7qf73J3QFhqE0a5c=;
        b=di9S2tNu2nJAsYooAWYb+CJyvUMSQ2EM7STcMSEsnjOJoKo/PZK+rKv04RuCQOsvU+
         yjWiFX288+eQmo0IEddey2KPt3K0p9zfbUzZiDBXowyG2D7PlAvyZGmzfi72OS+9/GS5
         7OaP16cdpLSzd7CCcfbPwKCvk/LpslnEEi+x76eYzCSixdVEwHHoNfn1Vt4McbY6zXu8
         GfrWBOyN027IHLKDEHWPQh+6FDsdgPeXXXmlvRVTWiD3h1bJgyYKXj4uspAUu0Tgv7Eb
         cREO5o+yMCu99WTkEYbq33Pt4W5ZD3iZvbp12IHOfQkbwroGySDQByg0mNkBGScCMstc
         hxZA==
X-Gm-Message-State: ACrzQf2eMYHDM3qSVn3Jxy7l/4a/r3ncWG3ygf4UXIwBZMOQjgFsr1Zo
        gQHkLwtmHG328UijpkFHwfniwyv/tRBcRXmh1GEewXEhhQ==
X-Google-Smtp-Source: AMsMyM4NZT9ybIQF9aJDYlc6OPNxFaRDSPfUeGDU1tHk5YMuKgVIpWIMG4Mql0Q+bayYM8SsL7xity8y9hA1C/dhJPE=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr1655732oac.51.1664319348918; Tue, 27
 Sep 2022 15:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-18-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-18-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:55:37 -0400
Message-ID: <CAHC9VhRZBP6fXtBseJJ_zHy+yoHMkVkSUbAFXmer7bKpt1Qvow@mail.gmail.com>
Subject: Re: [PATCH v2 17/30] acl: add vfs_remove_acl()
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> In previous patches we implemented get and set inode operations for all
> non-stacking filesystems that support posix acls but didn't yet
> implement get and/or set acl inode operations. This specifically
> affected cifs and 9p.
>
> Now we can build a posix acl api based solely on get and set inode
> operations. We add a new vfs_remove_acl() api that can be used to set
> posix acls. This finally removes all type unsafety and type conversion
> issues explained in detail in [1] that we aim to get rid of.
>
> After we finished building the vfs api we can switch stacking
> filesystems to rely on the new posix api and then finally switch the
> xattr system calls themselves to rely on the posix acl api.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  fs/posix_acl.c            | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/posix_acl.h |  8 +++++
>  2 files changed, 73 insertions(+)

...

> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 18873be583a9..40038851bfe1 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1484,3 +1484,68 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
>         return acl;
>  }
>  EXPORT_SYMBOL(vfs_get_acl);
> +
> +/**
> + * vfs_remove_acl - remove posix acls
> + * @mnt_userns: user namespace of the mount
> + * @dentry: the dentry based on which to retrieve the posix acls
> + * @acl_name: the name of the posix acl
> + *
> + * This function removes posix acls.
> + *
> + * Return: On success 0, on error negative errno.
> + */
> +int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +                  const char *acl_name)
> +{
> +       int acl_type;
> +       int error;
> +       struct inode *inode = d_inode(dentry);
> +       struct inode *delegated_inode = NULL;
> +
> +       acl_type = posix_acl_type(acl_name);
> +       if (acl_type < 0)
> +               return -EINVAL;
> +
> +retry_deleg:
> +       inode_lock(inode);
> +
> +       /*
> +        * We only care about restrictions the inode struct itself places upon
> +        * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
> +        */
> +       error = xattr_permission(mnt_userns, inode, acl_name, MAY_WRITE);
> +       if (error)
> +               goto out_inode_unlock;
> +
> +       error = security_inode_removexattr(mnt_userns, dentry, acl_name);
> +       if (error)
> +               goto out_inode_unlock;

Similar to my comments in patch 16/30 for vfs_get_acl(), I would
suggest a dedicated ACL remove hook here.  Yes, it's still a little
bit silly, but if we are going to make one dedicated hook, we might as
well do them all.


> +       error = try_break_deleg(inode, &delegated_inode);
> +       if (error)
> +               goto out_inode_unlock;
> +
> +       if (inode->i_opflags & IOP_XATTR)
> +               error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
> +       else if (unlikely(is_bad_inode(inode)))
> +               error = -EIO;
> +       else
> +               error = -EOPNOTSUPP;
> +       if (!error) {
> +               fsnotify_xattr(dentry);
> +               evm_inode_post_removexattr(dentry, acl_name);
> +       }
> +
> +out_inode_unlock:
> +       inode_unlock(inode);
> +
> +       if (delegated_inode) {
> +               error = break_deleg_wait(&delegated_inode);
> +               if (!error)
> +                       goto retry_deleg;
> +       }
> +
> +       return error;
> +}
> +EXPORT_SYMBOL(vfs_remove_acl);

--
paul-moore.com
