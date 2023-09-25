Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFBA7AD058
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 08:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjIYGmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjIYGmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:42:00 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9DA2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 23:41:32 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-452527dded1so2155088137.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695624091; x=1696228891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlcrtb3qeH1ek1Fcamcjkx5TxCj0/T2fx6jDLNk3EbQ=;
        b=DcBQGQ16PZHzCpMertGZueloANPCqbo9NXsht9sTfAz5pG46w22KA82EbHpGK0x7oh
         igAe5wtrGd2BWGE5kIqp6xgYhTStSobp+OyrYfw3hHpFxSQbBBH2l9Td2ugWPiw0W83K
         7F5xJ4OnqewnLaF0EZQNNr1MiLoUSU0P8iHAG10InnYHpaypv7/cCwoPkC0yru7YfWhQ
         bf0ilQqOjlmnjHu5YKwhY7xoYes+9E+alinhnjcwBPSMajE4zHS85dL9iFdYkBB8qCDi
         Q8/vv/SYvYUkYLOynguBhvCFpu0rqq0UXSKx5qqIe6TRn/0B/UM7nw5Azqux/7a11Ybn
         6UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695624091; x=1696228891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlcrtb3qeH1ek1Fcamcjkx5TxCj0/T2fx6jDLNk3EbQ=;
        b=B51crqYcl+mlZA0sCmWAIWIj/KQyd2HSRBh+3wuw2aN6ESTdZiLLsql6aCegdw8HXx
         b1Y/Iq8QVsWr3OBQ4nRMILFNgVYkA/ri1dK5FGTWakk5QUxvEd9kIzoYBLCQHZOHNolq
         EVGjanRdP/HGZ++kwXK3/TvlCQuvBoBXXBI2IhmEsdyAJFIKBOUQ0c0zMxwBYu2G0eQN
         jYIuw4q4alndeZvQgfAlw31eYFF/jJPgK67vrcAaIYWwKdPJ/n/4Oqn93jB5fSlvaS5g
         LviRUDOm9nEo1zJvo4hXlgfD9PSlUXAmGSVOtz4nh+BNNv80r/8iLPIGe0pcDbP8Ctsc
         KTMg==
X-Gm-Message-State: AOJu0Yxt0b6lgIKqOOhrsP28t4vKxCF4oRjU6SevO/9PkAYOV0DZMxdx
        xDcs8xMhJdHFEnTGonwUUauJcgyaB4o4WEaVBdgxCQ==
X-Google-Smtp-Source: AGHT+IHedh8V5ZVTA9ReEZK07z868AQAjcRsxzE3XRu4cBa1jMqppOQwepoLx0eW5bPfozhyqAH3ej1LQWgThODkte8=
X-Received: by 2002:a67:f615:0:b0:452:7617:a757 with SMTP id
 k21-20020a67f615000000b004527617a757mr3286012vso.26.1695624091321; Sun, 24
 Sep 2023 23:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-9-amir73il@gmail.com>
In-Reply-To: <20230519125705.598234-9-amir73il@gmail.com>
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
Date:   Mon, 25 Sep 2023 14:41:19 +0800
Message-ID: <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
Subject: Re: [External] [PATCH v13 08/10] fuse: update inode size/mtime after
 passthrough write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 8:59=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Similar to update size/mtime at the end of fuse_perform_write(),
> we need to bump the attr version when we update the inode size.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fuse/passthrough.c | 53 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 10b370bcc423..8352d6b91e0e 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -14,15 +14,42 @@ struct fuse_aio_req {
>         struct kiocb *iocb_fuse;
>  };
>
> -static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
> +static void fuse_file_start_write(struct file *fuse_file,
> +                                 struct file *backing_file,
> +                                 loff_t pos, size_t count)
> +{
> +       struct inode *inode =3D file_inode(fuse_file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       if (inode->i_size < pos + count)
> +               set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> +
> +       file_start_write(backing_file);
> +}
> +
> +static void fuse_file_end_write(struct file *fuse_file,
> +                               struct file *backing_file,
> +                               loff_t pos, ssize_t res)
> +{
> +       struct inode *inode =3D file_inode(fuse_file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       file_end_write(backing_file);
> +
> +       fuse_write_update_attr(inode, pos, res);

Hi Amir,
This function(fuse_file_end_write) will execute in interrupt context, but
fuse_write_update_attr() uses fuse_inode->lock, this will cause soft lockup=
.

So we may have to change all the fuse_inode->lock usage to fixup this bug, =
but
I think this is one ugly resolution.

Or why should we do aio_clearup_handler()? What is the difference between
fuse_passthrough_write_iter() with ovl_write_iter()?

Thanks,
Tianci

> +       clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> +}
> +
> +static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req, long =
res)
>  {
>         struct kiocb *iocb =3D &aio_req->iocb;
>         struct kiocb *iocb_fuse =3D aio_req->iocb_fuse;
> +       struct file *filp =3D iocb->ki_filp;
> +       struct file *fuse_filp =3D iocb_fuse->ki_filp;
>
>         if (iocb->ki_flags & IOCB_WRITE) {
> -               __sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> -                                     SB_FREEZE_WRITE);
> -               file_end_write(iocb->ki_filp);
> +               __sb_writers_acquired(file_inode(filp)->i_sb, SB_FREEZE_W=
RITE);
> +               fuse_file_end_write(fuse_filp, filp, iocb->ki_pos, res);
>         }
>
>         iocb_fuse->ki_pos =3D iocb->ki_pos;
> @@ -35,7 +62,7 @@ static void fuse_aio_rw_complete(struct kiocb *iocb, lo=
ng res)
>                 container_of(iocb, struct fuse_aio_req, iocb);
>         struct kiocb *iocb_fuse =3D aio_req->iocb_fuse;
>
> -       fuse_aio_cleanup_handler(aio_req);
> +       fuse_aio_cleanup_handler(aio_req, res);
>         iocb_fuse->ki_complete(iocb_fuse, res);
>  }
>
> @@ -71,7 +98,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_f=
use,
>                 aio_req->iocb.ki_complete =3D fuse_aio_rw_complete;
>                 ret =3D call_read_iter(passthrough_filp, &aio_req->iocb, =
iter);
>                 if (ret !=3D -EIOCBQUEUED)
> -                       fuse_aio_cleanup_handler(aio_req);
> +                       fuse_aio_cleanup_handler(aio_req, ret);
>         }
>  out:
>         revert_creds(old_cred);
> @@ -87,22 +114,25 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *io=
cb_fuse,
>         struct inode *fuse_inode =3D file_inode(fuse_filp);
>         struct file *passthrough_filp =3D ff->passthrough->filp;
>         struct inode *passthrough_inode =3D file_inode(passthrough_filp);
> +       size_t count =3D iov_iter_count(iter);
>         const struct cred *old_cred;
>         ssize_t ret;
>         rwf_t rwf;
>
> -       if (!iov_iter_count(iter))
> +       if (!count)
>                 return 0;
>
>         inode_lock(fuse_inode);
>
>         old_cred =3D override_creds(ff->passthrough->cred);
>         if (is_sync_kiocb(iocb_fuse)) {
> -               file_start_write(passthrough_filp);
> +               fuse_file_start_write(fuse_filp, passthrough_filp,
> +                                     iocb_fuse->ki_pos, count);
>                 rwf =3D iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_M=
ASK);
>                 ret =3D vfs_iter_write(passthrough_filp, iter, &iocb_fuse=
->ki_pos,
>                                      rwf);
> -               file_end_write(passthrough_filp);
> +               fuse_file_end_write(fuse_filp, passthrough_filp,
> +                                   iocb_fuse->ki_pos, ret);
>         } else {
>                 struct fuse_aio_req *aio_req;
>
> @@ -112,7 +142,8 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *ioc=
b_fuse,
>                         goto out;
>                 }
>
> -               file_start_write(passthrough_filp);
> +               fuse_file_start_write(fuse_filp, passthrough_filp,
> +                                     iocb_fuse->ki_pos, count);
>                 __sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_W=
RITE);
>
>                 aio_req->iocb_fuse =3D iocb_fuse;
> @@ -120,7 +151,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *ioc=
b_fuse,
>                 aio_req->iocb.ki_complete =3D fuse_aio_rw_complete;
>                 ret =3D call_write_iter(passthrough_filp, &aio_req->iocb,=
 iter);
>                 if (ret !=3D -EIOCBQUEUED)
> -                       fuse_aio_cleanup_handler(aio_req);
> +                       fuse_aio_cleanup_handler(aio_req, ret);
>         }
>  out:
>         revert_creds(old_cred);
> --
> 2.34.1
>
