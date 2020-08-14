Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4145E2444C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 08:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgHNGCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 02:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgHNGCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:02:08 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48BC061757;
        Thu, 13 Aug 2020 23:02:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cs12so3840754qvb.2;
        Thu, 13 Aug 2020 23:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDwq2jLH7Z/8I2tVmA1pXnX4UVfXpdExIQSA7o0Az28=;
        b=nw4z1jgEC+ZzG2yfevMqbWbUdDugX9izk6zIU0VDMcgUVAXdqS5teoigKYCmqW+7/d
         tj32jRdBP6c/Q6Au1/lwwcRnf4yJDlQUO666o6eWrro6nCs60+ZGeIhDzVH1wrCWR8GY
         67AzBv4Nh2mWzufDLgfth/bsonmWu7Q/6cBqYVZKXrxk7qLZge/jHOlS/fHXw1m1ywB/
         lpRwpEHnapN4ER9EcGjjOmy8zXsUT7u+3RaF9zaiTr8/ImrVdDva36GMfD24KesnShI2
         VueENmhq1TBP/LEmD7CBxotEZ8mmkXTEZ9L+4yYBLtjAZaVv8dmmD3KwhTea1Bt/54+f
         qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDwq2jLH7Z/8I2tVmA1pXnX4UVfXpdExIQSA7o0Az28=;
        b=C26CNepb7+dDF/GnEAcLG74ucgF3IJFzXRjfzOCbOu3LLK+J58W5/YOA8PAuthX0lC
         +MS3UQMQiMiqaZXQYnfXH1ll+2M2HQ4dyIDibIIs7yntBbh6393zai4c7wrFQ7kIcZV6
         CaeeXdWva6g9+VltkG+UnqIzXBKuVI2jkzdEd/uKdF+qln27Na4cw0NnCy7AQ8VFjLch
         OosBRtu8XT3px53mla+8d5WMPyDiVR2r16M87GXxPMfDjRgJ1gkoxBcFbbB0EAVodW34
         TlAhShI0ELu2aPS10a/DcM+j0eWu1qfIu3pRZzlVyNZF4fMH3cwmVrsdhenwNI0iOlIC
         2oIw==
X-Gm-Message-State: AOAM532hwdm8NT8wV2SavOUpkVPCLQkYL0XeqQLGlCic4P6gFkMBpN9f
        MLDMbWbGh4UM49e0HplASWy8Ef9UE4TzGCakaj/Gx49CYuQ=
X-Google-Smtp-Source: ABdhPJxad+N2kXs2XjZ/LDHd6mg9yVzq7AQ8BoLlcxJpRIIythu0do6WVVNT+TE+1u4HkGlYPa1U8nC0vsq1yizeOQk=
X-Received: by 2002:a05:6214:3e8:: with SMTP id cf8mr1331214qvb.74.1597384927120;
 Thu, 13 Aug 2020 23:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200729151740.GA3430@haolee.github.io>
In-Reply-To: <20200729151740.GA3430@haolee.github.io>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Fri, 14 Aug 2020 14:01:50 +0800
Message-ID: <CA+PpKP=cz4n2zzv4NrJ_Yg=PHqpfCHYnAhgUD2BLTUJmQSrizg@mail.gmail.com>
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more clear
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping

On Wed, Jul 29, 2020 at 11:21 PM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> The dentry local variable is introduced in 'commit 84d17192d2afd ("get
> rid of full-hash scan on detaching vfsmounts")' to reduce the length of
> some long statements for example
> mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
> inode_lock(dentry->d_inode) to do the same thing now, and its length is
> acceptable. Furthermore, it seems not concise that assign path->dentry
> to local variable dentry in the statement before goto. So, this function
> would be more clear if we eliminate the local variable dentry.
>
> The function logic is not changed.
>
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  fs/namespace.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4a0f600a3328..fcb93586fcc9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2187,20 +2187,19 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  static struct mountpoint *lock_mount(struct path *path)
>  {
>         struct vfsmount *mnt;
> -       struct dentry *dentry = path->dentry;
>  retry:
> -       inode_lock(dentry->d_inode);
> -       if (unlikely(cant_mount(dentry))) {
> -               inode_unlock(dentry->d_inode);
> +       inode_lock(path->dentry->d_inode);
> +       if (unlikely(cant_mount(path->dentry))) {
> +               inode_unlock(path->dentry->d_inode);
>                 return ERR_PTR(-ENOENT);
>         }
>         namespace_lock();
>         mnt = lookup_mnt(path);
>         if (likely(!mnt)) {
> -               struct mountpoint *mp = get_mountpoint(dentry);
> +               struct mountpoint *mp = get_mountpoint(path->dentry);
>                 if (IS_ERR(mp)) {
>                         namespace_unlock();
> -                       inode_unlock(dentry->d_inode);
> +                       inode_unlock(path->dentry->d_inode);
>                         return mp;
>                 }
>                 return mp;
> @@ -2209,7 +2208,7 @@ static struct mountpoint *lock_mount(struct path *path)
>         inode_unlock(path->dentry->d_inode);
>         path_put(path);
>         path->mnt = mnt;
> -       dentry = path->dentry = dget(mnt->mnt_root);
> +       path->dentry = dget(mnt->mnt_root);
>         goto retry;
>  }
>
> --
> 2.24.1
>
