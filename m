Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5727AA2AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjIUVaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjIUV3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:29:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297F658C2A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-573e67cc6eeso869117a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316784; x=1695921584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wslRTtw+4/fLaAKBVbSAPM+NQB0g7NXm9H72v9XdQM=;
        b=gtLbEdCRYqwne6SnEE+uDzIcZLkpEYAaHSnL9ejp0Q6atd+HfLjjVvwpTctUfsAeU7
         ReHDeUMNCQuRRs76W7nkY+Po0uRX23TIKqqtiY0SxeiQXiVkPBwMV1yXEtKaCoZ1pAa8
         x++Wo7n7VRp+F/XEU0bCQ0awgRGa+rAPRIuZjdX70RXkOSrNluHhxi0czcuBWtkHJSO+
         AOBF9yo8ebIgT7SIblFeeukdauvUu9jaiseRfroggfIRPZS57ZYbjqeKvsOWBgVYWOxN
         x92/bHLILLjOhjMVU3LaBlJ19lypuHHaqFXywel41g4xBlr+/01vSSavpHgpVhU7x7tt
         v4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316784; x=1695921584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wslRTtw+4/fLaAKBVbSAPM+NQB0g7NXm9H72v9XdQM=;
        b=d4Gdxp+R9Jk6pZwx0wDlkC+84Xe72YtGesVNPiP5B2J45bCoIZCqbWD0hoj4AOH0ME
         uGZTX4rOBKrXxVeMCL+FG7j75DxEVuOzWnhf2I8NpiExzW5CrRt6KrPlBqPJzB2IYEWB
         Hu2kblFCKHgvRrB69jPh/7bBcesDK4J6HMoTqf93wS1RbUSaE3PYI5BMVnw+OSGRWzh5
         AK6eRtZZQNAV0K2piTN5H/zZs0Xkf7nWfnUUXvKxnxaorNy5yF0Cy0BnZOgBb1r4i1vC
         4VUurc5ldMsk/YkBvQJHqNOSrPrXiYGWNABhRVamQ5B0doThedNy07BrCHyVSVO+8VhD
         BhoA==
X-Gm-Message-State: AOJu0YwaMKl2JKb6T0OG1vWwBkbyfqZIK2/ZuNOUxw/yQtBkxPqh+A4n
        he/mO098pQCZ/l4cKrvL0c2w8LM4EOu19Gji/bG8l/lhaio=
X-Google-Smtp-Source: AGHT+IFxz1p/p99n3Damsj9izfC//wwzJb0b5VK3Y00nHI43TWY2UhEjRPEe907ElYvQvPFoiXz7Fx2Cl7dfaSRidgU=
X-Received: by 2002:a1f:d881:0:b0:496:1ad2:9d0f with SMTP id
 p123-20020a1fd881000000b004961ad29d0fmr4544536vkg.1.1695277007139; Wed, 20
 Sep 2023 23:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230920173445.3943581-1-bschubert@ddn.com> <20230920173445.3943581-5-bschubert@ddn.com>
In-Reply-To: <20230920173445.3943581-5-bschubert@ddn.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 09:16:35 +0300
Message-ID: <CAOQ4uxjsfjEBo3obU9EPZuwkHXu_aPo+BJgVCOdN7V6bSRGXvA@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:48=E2=80=AFAM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> This was suggested by Miklos based on review from the previous
> patch that introduced atomic open for positive dentries.
> In open_last_lookups() the dentry was not used anymore when atomic
> revalidate was available, which required to release the dentry,
> then code fall through to lookup_open was done, which resulted
> in another d_lookup and also d_revalidate. All of that can
> be avoided by the new atomic_revalidate_open() function.
>
> Another included change is the introduction of an enum as
> d_revalidate return code.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/namei.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index f01b278ac0ef..8ad7a0dfa596 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3388,6 +3388,44 @@ static struct dentry *atomic_open(struct nameidata=
 *nd, struct dentry *dentry,
>         return dentry;
>  }
>
> +static struct dentry *atomic_revalidate_open(struct dentry *dentry,
> +                                            struct nameidata *nd,
> +                                            struct file *file,
> +                                            const struct open_flags *op,
> +                                            bool *got_write)
> +{
> +       struct mnt_idmap *idmap;
> +       struct dentry *dir =3D nd->path.dentry;
> +       struct inode *dir_inode =3D dir->d_inode;
> +       int open_flag =3D op->open_flag;
> +       umode_t mode =3D op->mode;
> +
> +       if (unlikely(IS_DEADDIR(dir_inode)))
> +               return ERR_PTR(-ENOENT);
> +
> +       file->f_mode &=3D ~FMODE_CREATED;
> +
> +       if (unlikely(open_flag & O_CREAT)) {
> +               WARN_ON(1);

      if (WARN_ON_ONCE(open_flag & O_CREAT)) {

is more compact and produces a nicer print

> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
> +               *got_write =3D !mnt_want_write(nd->path.mnt);
> +       else
> +               *got_write =3D false;
> +
> +       if (!got_write)
> +               open_flag &=3D ~O_TRUNC;
> +
> +       inode_lock_shared(dir->d_inode);
> +       dentry =3D atomic_open(nd, dentry, file, open_flag, mode);
> +       inode_unlock_shared(dir->d_inode);
> +
> +       return dentry;
> +
> +}
> +
>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -3541,8 +3579,10 @@ static const char *open_last_lookups(struct nameid=
ata *nd,
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
>                 if (dentry && unlikely(atomic_revalidate)) {
> -                       dput(dentry);
> -                       dentry =3D NULL;
> +                       BUG_ON(nd->flags & LOOKUP_RCU);

The assertion means that someone wrote bad code
it does not mean that the kernel internal state is hopelessly corrupted.
Please avoid BUG_ON and use WARN_ON_ONCE and if possible
(seems to be the case here) also take the graceful error path.
It's better to fail an open than to crash the kernel.

Thanks,
Amir.

> +                       dentry =3D atomic_revalidate_open(dentry, nd, fil=
e, op,
> +                                                       &got_write);
> +                       goto drop_write;
>                 }
>                 if (likely(dentry))
>                         goto finish_lookup;
> @@ -3580,6 +3620,7 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>         else
>                 inode_unlock_shared(dir->d_inode);
>
> +drop_write:
>         if (got_write)
>                 mnt_drop_write(nd->path.mnt);
>
> --
> 2.39.2
>
