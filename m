Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECC5FAE1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJKIL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJKILx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:11:53 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB98A1DA;
        Tue, 11 Oct 2022 01:11:49 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id e5so6265067vkg.6;
        Tue, 11 Oct 2022 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=khoAwliUfmbVe9jJ0TRI5HXC75Eo6z8nKSSIMvhWjEw=;
        b=k+GTmsCa3vbz7M2QoxvYV51sGBkNm/NR9TMDFiJA/fqVVYqsaEJuc+j0qtVgu+0E+F
         18zvg7B8cU7qiTB4H4o5Y9lHgRzjRMhYHmli6Ypm/gmRtgQ6I1kSYbZ7m8lKuqYZ8geE
         Au30jt4djVOap3JZOdN/HQ0Sz9kprOVeVOAyXwvDBkSq0IG9qokQQqjpbD8meIFBNzhH
         NW7SxHs6xs969Fj+kq8VmusuQ7UHGOrny6IVwX9emIg2IagAj32xuKm22e4vv5BOOCJK
         BNCo0h4dlV4rD3UXgsKPpkq0J5I3SSD296/gGklKiN1uBSPkDIEc96eVcQNIJcdADLDM
         BWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khoAwliUfmbVe9jJ0TRI5HXC75Eo6z8nKSSIMvhWjEw=;
        b=H8F0fKJ/kX5pjT5WFYeqx1mvH9sCR6BdXdT2sv3rxJVQCv7JnpTdCNV9JyW9zwOF8l
         phCDkCg+1+BTiss7gnQu9aiZu4lICl9HuGvyZluRowD5FHz4RzqeXSAMhBhmQdg0KH5g
         t5bqBQr5tnFhPseAwHlSkAnfwJK6D7ZV33jJpYMAgFbOK3Z0HL1rq35CBs+quL64u389
         UUG9OGNp9wIr0PwXMWW+DZevqhXgcxMx5I3LoQUFBY2fOnEf30WYHdbGvtb/XwzGhd+s
         P4GWnMrerG7/gonXKwj+UWEYq4PY437y2PaeVs6FVOv+Muf69GwVVKvH9GjenbuStXWW
         AHSw==
X-Gm-Message-State: ACrzQf0qNfZQYWBk71NGLSFFf/JuJv9EyrJZvf1JmUzJvAXai8tpPXle
        mf+SsEUwWsM5JS01oQcv/QXQtNiSYh1DJ73Oy+O9TCY6h6s=
X-Google-Smtp-Source: AMsMyM6BeZFZt2fcC63UGkn5qZNSniety9OXr4n1So3NViEZrgwTISvgfAVQyUrmzyemRgfgKkCZJdFhWrpWqDhUUhA=
X-Received: by 2002:ac5:cdd3:0:b0:3ae:ca8b:c954 with SMTP id
 u19-20020ac5cdd3000000b003aeca8bc954mr605427vkn.11.1665475908362; Tue, 11 Oct
 2022 01:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221007140543.1039983-1-brauner@kernel.org> <20221007140543.1039983-2-brauner@kernel.org>
In-Reply-To: <20221007140543.1039983-2-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Oct 2022 11:11:37 +0300
Message-ID: <CAOQ4uxhapYW7nQUEK1b=GQ_E_z_n8d495mSnNo-pC-LuM4GK-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] attr: add setattr_drop_sgid()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 7, 2022 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
>
> In setattr_{copy,prepare}() we need to perform the same permission
> checks to determine whether we need to drop the setgid bit or not.
> Instead of open-coding it twice add a simple helper the encapsulates the
> logic. We will reuse this helpers to make dropping the setgid bit during
> write operations more consistent in a follow up patch.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Looks good.
Some suggestions below - not  a must.

Thanks,
Amir.

> ---
>
> Notes:
>     /* v2 */
>     patch added
>
>  fs/attr.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 1552a5f23d6b..b1cff6f5b715 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -18,6 +18,27 @@
>  #include <linux/evm.h>
>  #include <linux/ima.h>
>
> +/**
> + * setattr_drop_sgid - check generic setgid permissions

Helper name sounds like a directive, where it should sound like a question.
e.g. setattr_should_remove_sgid()

> + * @mnt_userns:        User namespace of the mount the inode was created from
> + * @inode: inode to check
> + * @vfsgid: the new/current vfsgid of @inode
> + *
> + * This function determines whether the setgid bit needs to be removed because
> + * the caller lacks privileges over the inode.
> + *
> + * Return: true if the setgid bit needs to be removed, false if not.

You may want to consider matching the return value to that of
should_remove_sgid(), that is 0 or ATTR_KILL_SGID to make all the family of
those helpers behave similarly.

> + */
> +static bool setattr_drop_sgid(struct user_namespace *mnt_userns,
> +                             const struct inode *inode, vfsgid_t vfsgid)
> +{
> +       if (vfsgid_in_group_p(vfsgid))
> +               return false;
> +       if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               return false;
> +       return true;
> +}
> +
>  /**
>   * chown_ok - verify permissions to chown inode
>   * @mnt_userns:        user namespace of the mount @inode was found from
> @@ -140,8 +161,7 @@ int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
>                         vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
>
>                 /* Also check the setgid bit! */
> -               if (!vfsgid_in_group_p(vfsgid) &&
> -                   !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               if (setattr_drop_sgid(mnt_userns, inode, vfsgid))
>                         attr->ia_mode &= ~S_ISGID;
>         }
>
> @@ -251,9 +271,8 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
>                 inode->i_ctime = attr->ia_ctime;
>         if (ia_valid & ATTR_MODE) {
>                 umode_t mode = attr->ia_mode;
> -               vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
> -               if (!vfsgid_in_group_p(vfsgid) &&
> -                   !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               if (setattr_drop_sgid(mnt_userns, inode,
> +                                     i_gid_into_vfsgid(mnt_userns, inode)))
>                         mode &= ~S_ISGID;
>                 inode->i_mode = mode;
>         }
> --
> 2.34.1
>
