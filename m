Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E2A408631
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhIMIPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 04:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235824AbhIMIPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631520871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkNUwYkXs03qs9D8gN6MpGAP2R3uhq/MtDxqk5USWa8=;
        b=iA6iinDhj6kacDk1VB93orHV/cpdaUMOnSIEIUspVdQyv5E1CqeF7+GW5bfXQpFiQRDQcO
        88+4cFSY1HfNyPOJaOzPibnKeYkVV9y+Iba3x90bIiF2aJEpD51naCuwxPLY91b0yc/m7B
        6HNArDvMCJkHFB9U8wTf7sAuFQXtEkg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-7bJlxYfOMLKL1mQig5kKSQ-1; Mon, 13 Sep 2021 04:14:30 -0400
X-MC-Unique: 7bJlxYfOMLKL1mQig5kKSQ-1
Received: by mail-ej1-f70.google.com with SMTP id s11-20020a170906060b00b005be824f15daso3314085ejb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 01:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XkNUwYkXs03qs9D8gN6MpGAP2R3uhq/MtDxqk5USWa8=;
        b=6AdoUsCdDIaSnabOuVubm0RHrdPM0TW+/vJx3xaX06Joe8m8gMoPSoHSzbgRoLBzep
         W5ge5boEXw9qYR1na13xeNjjD+396LIcXpNEPqlMufzPIq0ijRXYotB3kDTVghhV/n1U
         T6Qr2ZuLZqQfokuwV+LtIhRA3SqnagPITBqEBRUWg5oxJD8VIAgouFsMoW1GAqnnhaVm
         XsDnHxq7Ulv0bndFTltSy2T0+2RH1+RGhndN0Yw6I4MA4TSQNQ4Tb9KsiXqUiJXHgtIQ
         IjAUqYsgsWYQCLGHwfQRP7Vx2wU+CPQfWYQvNr0O4o9LeL35XiaSbIKI6wxvGRcFfscH
         +QTA==
X-Gm-Message-State: AOAM532GBdxlkDbrdjRdYiv9OjmOxlI+sKrNki5O6pEz19jMi7vUgzpj
        Ml3eEf2rJegPghVDeqjIAR88VW4RsycWFRi/3HcHqX73h/GrT4nt3RbhJawqdelzygGBeFL5mwn
        A1sxO+sWiocnmDwGEX9jmi8FIsg==
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr12053317edy.170.1631520868607;
        Mon, 13 Sep 2021 01:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlXDgN7yuZRn9iOmQlULTHGXROdIry6q1fTo5DGXov2v0TF9//Rk2xoyYsHiWB3JCfLDvqxg==
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr12053291edy.170.1631520868275;
        Mon, 13 Sep 2021 01:14:28 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id dh16sm3464174edb.63.2021.09.13.01.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:14:27 -0700 (PDT)
Date:   Mon, 13 Sep 2021 10:14:25 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     =?utf-8?B?0J/QsNCy0LXQuyDQodCw0LzRgdC+0L3QvtCy?= 
        <pvsamsonov76@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Pavel Samsonov <pvsamsonov76@gmail.com>
Message-ID: <20210913081425.bnrc2jtq3bmv4hvn@andromeda.lan>
References: <0189aeb1-75f1-1e8b-71a8-ea6a7641518b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0189aeb1-75f1-1e8b-71a8-ea6a7641518b@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 06:57:13PM +0300, Павел Самсонов wrote:
> From 07b6f881080fa18ac404054d43b99433275fe966 Mon Sep 17 00:00:00 2001
> From: Pavel Samsonov <pvsamsonov76@gmail.com>
> Date: Fri, 10 Sep 2021 14:53:39 +0300
> Subject: [PATCH] Signed-off-by: Pavel Samsonov <pvsamsonov76@gmail.com>
> 
> The patch changes the argument of chown_ok(), chgrp_ok() ...
> functions from *inode to *dentry. The setattr_prepare() function
> has an argument * dentry; it is logical to work with the dentry
> structure in the condition checking functions as well.

Hmmm.

I particularly don't see how this is useful in any way, both chown_ok() and
chgrp_ok() works on the inode itself, not in the dentry. Same goes for
inode_owner_or_capable().

So, you are adding a lot of boiler plate code to each function (and adding a new
extra helper function), just to extract the inode from the dentry on each
helper, instead of just pass the inode directly as how it's ok.
IMHO, just because setattr_prepare() receives a dentry, doesn't mean it needs to
pass the same dentry to the helpers, because, as I said, the helpers itself acts
on the inodes, not in the dentry, so, this patch just adds a lot of unnecessary
code.
But, well, this is my own personal opinion.


Also, for the next time/patches, the patch's subject needs to have the patch
subject, not your SoB.


> ---
>  fs/attr.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 473d21b3a86d..de1898c19bde 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -21,7 +21,7 @@
>  /**
>   * chown_ok - verify permissions to chown inode
>   * @mnt_userns:    user namespace of the mount @inode was found from
> - * @inode:    inode to check permissions on
> + * @dentry:    dentry to check permissions on
>   * @uid:    uid to chown @inode to
>   *
>   * If the inode has been found through an idmapped mount the user namespace
> of
> @@ -31,9 +31,11 @@
>   * performed on the raw inode simply passs init_user_ns.
>   */
>  static bool chown_ok(struct user_namespace *mnt_userns,
> -             const struct inode *inode,
> +             const struct dentry *dentry,
>               kuid_t uid)
>  {
> +    struct inode *inode = d_inode(dentry);
> +
>      kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
>      if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
>          return true;
> @@ -48,7 +50,7 @@ static bool chown_ok(struct user_namespace *mnt_userns,
>  /**
>   * chgrp_ok - verify permissions to chgrp inode
>   * @mnt_userns:    user namespace of the mount @inode was found from
> - * @inode:    inode to check permissions on
> + * @dentry:    dentry to check permissions on
>   * @gid:    gid to chown @inode to
>   *
>   * If the inode has been found through an idmapped mount the user namespace
> of
> @@ -58,8 +60,10 @@ static bool chown_ok(struct user_namespace *mnt_userns,
>   * performed on the raw inode simply passs init_user_ns.
>   */
>  static bool chgrp_ok(struct user_namespace *mnt_userns,
> -             const struct inode *inode, kgid_t gid)
> +             const struct dentry *dentry, kgid_t gid)
>  {
> +    struct inode *inode = d_inode(dentry);
> +
>      kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
>      if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) &&
>          (in_group_p(gid) || gid_eq(gid, kgid)))
> @@ -72,6 +76,27 @@ static bool chgrp_ok(struct user_namespace *mnt_userns,
>      return false;
>  }
> 
> +/**
> + * fowner_ok - verify permissions to chmod inode
> + * @mnt_userns:    user namespace of the mount @inode was found from
> + * @dentry:    dentry to check permissions on
> + *
> + * If the inode has been found through an idmapped mount the user namespace
> of
> + * the vfsmount must be passed through @mnt_userns. This function will then
> + * take care to map the inode according to @mnt_userns before checking
> + * permissions. On non-idmapped mounts or if permission checking is to be
> + * performed on the raw inode simply passs init_user_ns.
> + */
> +static bool fowner_ok(struct user_namespace *mnt_userns,
> +            const struct dentry *dentry)
> +{
> +    struct inode *inode = d_inode(dentry);
> +
> +    if (inode_owner_or_capable(mnt_userns, inode))
> +        return true;
> +    return false;
> +}
> +
>  /**
>   * setattr_prepare - check if attribute changes to a dentry are allowed
>   * @mnt_userns:    user namespace of the mount the inode was found from
> @@ -114,27 +139,31 @@ int setattr_prepare(struct user_namespace *mnt_userns,
> struct dentry *dentry,
>          goto kill_priv;
> 
>      /* Make sure a caller can chown. */
> -    if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode,
> attr->ia_uid))
> +    if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, dentry,
> attr->ia_uid))
>          return -EPERM;
> 
>      /* Make sure caller can chgrp. */
> -    if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode,
> attr->ia_gid))
> +    if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, dentry,
> attr->ia_gid))
>          return -EPERM;
> 
>      /* Make sure a caller can chmod. */
>      if (ia_valid & ATTR_MODE) {
> -        if (!inode_owner_or_capable(mnt_userns, inode))
> +        if (!fowner_ok(mnt_userns, dentry))
>              return -EPERM;
>          /* Also check the setgid bit! */
>                 if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
>                                  i_gid_into_mnt(mnt_userns, inode)) &&
>                      !capable_wrt_inode_uidgid(mnt_userns, inode,
> CAP_FSETID))
>              attr->ia_mode &= ~S_ISGID;
> +        /* Also check the setuid bit! */
> +        if (!(capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID) ||
> +             uid_eq(current_fsuid(), inode->i_uid)))
> +            attr->ia_mode &= ~S_ISUID;
>      }
> 
>      /* Check for setting the inode time. */
>      if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
> -        if (!inode_owner_or_capable(mnt_userns, inode))
> +        if (!fowner_ok(mnt_userns, dentry))
>              return -EPERM;
>      }
> 
> -- 
> 2.30.2
> 
> 

-- 
Carlos

