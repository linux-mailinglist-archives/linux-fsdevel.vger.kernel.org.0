Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D03496AB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 08:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiAVHpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 02:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiAVHpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:45:07 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3DC06173B;
        Fri, 21 Jan 2022 23:45:07 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id w7so13435672ioj.5;
        Fri, 21 Jan 2022 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEf9kuxtfK6g6ywXgOShXcpDo4hATUcEmxi4FaLoa70=;
        b=DmqilS8lvUSSrQeTKd8ECtxJLZjCSJQoZ4gRS32wLlH9v1a4ACq+XQhTIVWw80oyxa
         NHqDsbuPIOECgXZ400JU9bmA2anrvJi4OSp+TIfGEV2iFTC55t//tQOFtrPoqPday9tf
         FF6T1j8TPN3GGiab+ow2g9t7D1gHfOuq06+OCtDnzSUDMkPOWq+PdLolIETi8CmhHVyP
         tyAzczg7/1cJ3bkG66SkYVMKECp1rPCzP6GAcPAVnKhdHnVck8fxNaUCaMdPZ9FOGCQV
         An0glZWAmwdxc3W9Uwr8f3ruQzO5YDTTHimPifYLJlz5hvVFZrGx7a9iOmzifXArpC8K
         CKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEf9kuxtfK6g6ywXgOShXcpDo4hATUcEmxi4FaLoa70=;
        b=4hpat10jXw3At2UXOvw/70juc5+56VsZnMZisjzl05d+S1ZYjqHdvffBwBRSL3LcWW
         H/aiQ/KByoNr0sDxgs8ahjv97YvlO6VueEklfjjZ8Kw4yasdcv1xztQ//DJGPtj8gQZn
         HKYMz4vfIKAMaUyHIlB+sf0RYmmqHwOS0Ccj7p4yij8oqp4qqLhUENSlb0YFtZnPY46Q
         sb/hqmiZrEWUNwVpC2cU3aVLegpJlBCk+tjhgeZeKMrgMI4hi7J8OAICDFkb6a7dERuR
         nU6xr/k78206VZSbvyGMEhhehmcZaI/JWGU9fv2y9zw5P49+Qz/Y09cQYoOp9vEyi2H/
         rDvA==
X-Gm-Message-State: AOAM533G0c5Uw8rIbygGXflOMbYc+qWxO3ItOXihr6yWT3DaAPVYcHWJ
        zxS7pptBRvnyAlclWekIhpn/uLE25tkxIpMNgOagT5ChgU0=
X-Google-Smtp-Source: ABdhPJzB3PVYUkq5WX3h4+KNsUkQ9PkVnl2PRIgfacRuSEw3+UU4/EpV8+mNg5mQuDcQ6Ppb76X1LrE04bNSb9lsNt8=
X-Received: by 2002:a02:a896:: with SMTP id l22mr3167660jam.69.1642837506811;
 Fri, 21 Jan 2022 23:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20220121080246.459804-1-hch@lst.de>
In-Reply-To: <20220121080246.459804-1-hch@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 22 Jan 2022 09:44:55 +0200
Message-ID: <CAOQ4uxhaM1XpfQBenMLmh2_i9EbwRQ+E9qU8hqbKCbZmibBerA@mail.gmail.com>
Subject: Re: [PATCH] fs: rename S_KERNEL_FILE
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 22, 2022 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> S_KERNEL_FILE is grossly misnamed.  We have plenty of files hold open by
> the kernel kernel using filp_open.  This flag OTOH signals the inode as
> being a special snowflage that cachefiles holds onto that can't be

^^^^^^^^^^^^^^^^snowflake

> unlinked becaue of ..., erm, pixie dust.  So clearly mark it as such.
>
^^^^^^^^^^because

> Signed-off-by: Christoph Hellwig <hch@lst.de>

That's a much better name IMO.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/cachefiles/namei.c | 12 ++++++------
>  fs/namei.c            |  2 +-
>  include/linux/fs.h    |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 9bd692870617c..599dc13a7d9ab 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -20,8 +20,8 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
>         struct inode *inode = d_backing_inode(dentry);
>         bool can_use = false;
>
> -       if (!(inode->i_flags & S_KERNEL_FILE)) {
> -               inode->i_flags |= S_KERNEL_FILE;
> +       if (!(inode->i_flags & S_CACHEFILE)) {
> +               inode->i_flags |= S_CACHEFILE;
>                 trace_cachefiles_mark_active(object, inode);
>                 can_use = true;
>         } else {
> @@ -51,7 +51,7 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
>  {
>         struct inode *inode = d_backing_inode(dentry);
>
> -       inode->i_flags &= ~S_KERNEL_FILE;
> +       inode->i_flags &= ~S_CACHEFILE;
>         trace_cachefiles_mark_inactive(object, inode);
>  }
>
> @@ -742,7 +742,7 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
>                 goto lookup_error;
>         if (d_is_negative(victim))
>                 goto lookup_put;
> -       if (d_inode(victim)->i_flags & S_KERNEL_FILE)
> +       if (d_inode(victim)->i_flags & S_CACHEFILE)
>                 goto lookup_busy;
>         return victim;
>
> @@ -789,11 +789,11 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
>         /* check to see if someone is using this object */
>         inode = d_inode(victim);
>         inode_lock(inode);
> -       if (inode->i_flags & S_KERNEL_FILE) {
> +       if (inode->i_flags & S_CACHEFILE) {
>                 ret = -EBUSY;
>         } else {
>                 /* Stop the cache from picking it back up */
> -               inode->i_flags |= S_KERNEL_FILE;
> +               inode->i_flags |= S_CACHEFILE;
>                 ret = 0;
>         }
>         inode_unlock(inode);
> diff --git a/fs/namei.c b/fs/namei.c
> index d81f04f8d8188..7402277ecc1f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3959,7 +3959,7 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
>
>         error = -EBUSY;
>         if (is_local_mountpoint(dentry) ||
> -           (dentry->d_inode->i_flags & S_KERNEL_FILE))
> +           (dentry->d_inode->i_flags & S_CACHEFILE))
>                 goto out;
>
>         error = security_inode_rmdir(dir, dentry);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c8510da6cc6dc..099d7e03d46e6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2173,7 +2173,7 @@ struct super_operations {
>  #define S_ENCRYPTED    (1 << 14) /* Encrypted file (using fs/crypto/) */
>  #define S_CASEFOLD     (1 << 15) /* Casefolded file */
>  #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
> -#define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
> +#define S_CACHEFILE    (1 << 17) /* In use as cachefile, can't be unlinked */
>
>  /*
>   * Note that nosuid etc flags are inode-specific: setting some file-system
> --
> 2.30.2
>
