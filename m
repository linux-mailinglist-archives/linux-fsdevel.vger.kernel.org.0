Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349DA3C5DEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhGLOHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhGLOHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:07:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2825C0613DD;
        Mon, 12 Jul 2021 07:04:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso98824wmj.0;
        Mon, 12 Jul 2021 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ksfKW9jBcttAT71ywTdCDgVvdhPuwAAMHVVHi6ziTk=;
        b=qv17XwXNn+D+FlRVdPXxv69USzKfsqymUNz3eJtpzZsGJkI7GwNBjXGJwNqMWAbvB3
         JsrmbyVam2Pm0CeE6RTF5WN2++O6bno8IGyIhYMauMUjJOOdfr4wQQGMa1y7YFq2LPA9
         6rJbjoeNbVL9ZouKhGkob1FjD1BdarvauJmKDw7aqU4+2zOYWX3llvL3v6x50KrLwVbj
         rPeeOmKw2i/B40ABgk60ZTZuPE7Ic3Arbr4f9hg6CFKtl3A/ZetvwUuIMvRhXWp1LYT/
         Kn299THwvY+ApUkwvNrTqYhcd/UnUi7tIjPkft9W57odiWzDcGbWU6bSkvXtzAagzyMQ
         vKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ksfKW9jBcttAT71ywTdCDgVvdhPuwAAMHVVHi6ziTk=;
        b=UQh7hAoO7SDjJCQF3denpatCcWYbxnlbgT/mkDJasNdEAjlUdGXjmwvvifczAUisgU
         c8hjba73Pj74wJ2mY5bDB2Bb6laObsxE5LJmKUjVxfkcLHh5NPmiWcJ0nGB2+mZ9fImR
         S5USvEBeY59SYYDvfoqcdthgEILcRl+UKdaogzSTKMFapDedYPZNXD4j8PhWDngStlpT
         neHT+sSXB8ATSJdf/5k8AIvf5Ohi1HiUZQVNimrd5Io+T3JXU333z2BSEUlyxithf4z6
         7UPHppCEHs+hergVtP+fbc2xP8qhb4zF6GmLzuNbCDZxr9kA/f88UdwD7j4pI0/CmgIw
         khXg==
X-Gm-Message-State: AOAM533D0hx/vFHcBHkRZbqbwh94TsJn9emtjWPjxhQkjSSwyDzZrHH3
        +26rYdG7y8UPY0ErN1QQhyWg69TeBB5NbFfFcAE=
X-Google-Smtp-Source: ABdhPJyqjVxz3mZxKxpLTTVUCFpnt5ove+iY6K5nqdu8NPYwjBv6T2SUORoSj6HqVzngfY1mJgNyf1g22yp5AFuhA8M=
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr30283710wme.101.1626098657324;
 Mon, 12 Jul 2021 07:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <162609463116.3133237.11899334298425929820.stgit@warthog.procyon.org.uk>
 <162609465444.3133237.7562832521724298900.stgit@warthog.procyon.org.uk>
In-Reply-To: <162609465444.3133237.7562832521724298900.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Mon, 12 Jul 2021 11:04:06 -0300
Message-ID: <CAB9dFdvV-gEfRY_bsF_hBDErWW=9WUCVsGSmkv6XLE=Y-Lh-Hw@mail.gmail.com>
Subject: Re: [PATCH 3/3] afs: Remove redundant assignment to ret
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 9:57 AM David Howells <dhowells@redhat.com> wrote:
>
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>
> Variable ret is set to -ENOENT and -ENOMEM but this value is never
> read as it is overwritten or not used later on, hence it is a
> redundant assignment and can be removed.
>
> Cleans up the following clang-analyzer warning:
>
> fs/afs/dir.c:2014:4: warning: Value stored to 'ret' is never read
> [clang-analyzer-deadcode.DeadStores].
>
> fs/afs/dir.c:659:2: warning: Value stored to 'ret' is never read
> [clang-analyzer-deadcode.DeadStores].
>
> [DH made the following modifications:
>
>  - In afs_rename(), -ENOMEM should be placed in op->error instead of ret,
>    rather than the assignment being removed entirely.  afs_put_operation()
>    will pick it up from there and return it.
>
>  - If afs_sillyrename() fails, its error code should be placed in op->error
>    rather than in ret also.
> ]
>
> Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> Link: https://lore.kernel.org/r/1619691492-83866-1-git-send-email-jiapeng.chong@linux.alibaba.com
> ---
>
>  fs/afs/dir.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 78719f2f567e..ac829e63c570 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -656,7 +656,6 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
>                 return ret;
>         }
>
> -       ret = -ENOENT;
>         if (!cookie.found) {
>                 _leave(" = -ENOENT [not found]");
>                 return -ENOENT;
> @@ -2020,17 +2019,20 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>
>                 if (d_count(new_dentry) > 2) {
>                         /* copy the target dentry's name */
> -                       ret = -ENOMEM;
>                         op->rename.tmp = d_alloc(new_dentry->d_parent,
>                                                  &new_dentry->d_name);
> -                       if (!op->rename.tmp)
> +                       if (!op->rename.tmp) {
> +                               op->error = -ENOMEM;
>                                 goto error;
> +                       }
>
>                         ret = afs_sillyrename(new_dvnode,
>                                               AFS_FS_I(d_inode(new_dentry)),
>                                               new_dentry, op->key);
> -                       if (ret)
> +                       if (ret) {
> +                               op->error = ret;
>                                 goto error;
> +                       }
>
>                         op->dentry_2 = op->rename.tmp;
>                         op->rename.rehash = NULL;
>
>
>
> _______________________________________________
> linux-afs mailing list
> http://lists.infradead.org/mailman/listinfo/linux-afs

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
