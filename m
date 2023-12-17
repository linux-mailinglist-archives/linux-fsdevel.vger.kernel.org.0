Return-Path: <linux-fsdevel+bounces-6340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF511815E51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C65F1F220CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E96FB6;
	Sun, 17 Dec 2023 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYcTHJG4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A363A3;
	Sun, 17 Dec 2023 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77f320ca2d5so168546285a.1;
        Sun, 17 Dec 2023 01:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702805547; x=1703410347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYgbvFbc651hSucNzc13NR4vR18Ijwdd2sBGbj5gCiE=;
        b=aYcTHJG48NZH2IkVoopThsXnbeLSlQ8JALLkVExwTww98AifFv4wCQmQfN6C7PJmXU
         cFUJxeLdehYJHpxeVIqDJSxQD5n/46mCslZCojXJZqwL3a6La2NVAD+biN36BorGOQHe
         WYbYv+odf3YR+eN6mZ++Joy+v/pdjgEVjLtAQh6G+SQngVox4xCTxrVzPJFuo/7BAygi
         nTgdCyTgP1d3ymV8pME/G0tjbCx4l+pV+5WoKMW/PLwZrETZLwQdkEX0QuF9KyIpngQA
         b5wuUoQ3irMheyMrdVtbqg+Qlp66r0Uq1Qt3A4R3MFuZQU/8VedwFoMNNuEU7Rf+Whu5
         PCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702805547; x=1703410347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYgbvFbc651hSucNzc13NR4vR18Ijwdd2sBGbj5gCiE=;
        b=rmj/gK6+nq1qB3iwS7j4Dmx9P7q7/WS4z81nKrKz0LjEFJXOKmStDLSIodC9BD4Kwq
         Xi//hWT98sEv3sQB7DivRNyZ3dODU5liusMyDZ55G81EEizKfu18rm3bldiLSWyFVCTU
         7nX0R04NnNMn+XeB8z5/e2xwsqpi3IvwOB1ZFprmVe+FxAsH7SQ8GPnpovF0DHn7qIxR
         vVYaH/uqpnS3+LpPLH9GbaxhZze1VwugAZ4YEgMvdG8F+ddNSdiH5MLw66vYQLRYOTFE
         avDllb8e2X7RMyW5Kpq20cFrBZqsg+qz2hNUMCrllAbADHhE9qzgSXzNAU6KmJF1EFRX
         OTNw==
X-Gm-Message-State: AOJu0YxrApCWEjLXXNi5eYVoQ6ARchCSjlPceJCc5FVkVCMP69mFjSVT
	1NWFqu1z/a5HxfL/WxdMMn/9XhZPQPJjCOQ5eR0=
X-Google-Smtp-Source: AGHT+IH3PaGiNcaIanZwKUHmvWmiaD6dbQ+VGgW1jriDoXnyIC8pX42JlN6X1eEh0YqPzW10W78T8JV0bY1+1ymerFY=
X-Received: by 2002:a05:620a:4950:b0:77f:89e:986d with SMTP id
 vz16-20020a05620a495000b0077f089e986dmr18486113qkn.78.1702805547194; Sun, 17
 Dec 2023 01:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003362ba060ca8beac@google.com> <tencent_4E2FCFC90D97A5910DFA926DDD945D9B1907@qq.com>
In-Reply-To: <tencent_4E2FCFC90D97A5910DFA926DDD945D9B1907@qq.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Dec 2023 11:32:16 +0200
Message-ID: <CAOQ4uxi+4-jyNY6jzNt1wG5xcYSZiSfU0AtCWtF71PSW160zRw@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix BUG: Dentry still in use in unmount
To: Edward Adam Davis <eadavis@qq.com>, viro@zeniv.linux.org.uk
Cc: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com, chao@kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phillip@squashfs.org.uk, reiserfs-devel@vger.kernel.org, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	terrelln@fb.com, overlayfs <linux-unionfs@vger.kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

Thanks for the quick fix, but it is incorrect.

On Sun, Dec 17, 2023 at 10:11=E2=80=AFAM Edward Adam Davis <eadavis@qq.com>=
 wrote:
>
> workdir and destdir could be the same when copying up to indexdir.

This is not the reason for the bug, the reason is:

    syzbot exercised the forbidden practice of moving the workdir under
    lowerdir while overlayfs is mounted and tripped a dentry reference leak=
.

>
> Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_wr=
iters held")
> Reported-and-tested-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/overlayfs/copy_up.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 4382881b0709..ae5eb442025d 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -731,10 +731,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>                 .rdev =3D c->stat.rdev,
>                 .link =3D c->link
>         };
> +       err =3D -EIO;
> +       /* workdir and destdir could be the same when copying up to index=
dir */
> +       if (lock_rename(c->workdir, c->destdir) !=3D NULL)
> +               goto unlock;

You can't do that. See comment below ovl_copy_up_data().

>
>         err =3D ovl_prep_cu_creds(c->dentry, &cc);
>         if (err)
> -               return err;
> +               goto unlock;
>
>         ovl_start_write(c->dentry);
>         inode_lock(wdir);
> @@ -743,8 +747,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         ovl_end_write(c->dentry);
>         ovl_revert_cu_creds(&cc);
>
> +       err =3D PTR_ERR(temp);
>         if (IS_ERR(temp))
> -               return PTR_ERR(temp);
> +               goto unlock;
>
>         /*
>          * Copy up data first and then xattrs. Writing data after
> @@ -760,10 +765,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>          * If temp was moved, abort without the cleanup.
>          */
>         ovl_start_write(c->dentry);
> -       if (lock_rename(c->workdir, c->destdir) !=3D NULL ||
> -           temp->d_parent !=3D c->workdir) {
> +       if (temp->d_parent !=3D c->workdir) {

                  dput(temp);

here is all that should be needed to fix the leak.


>                 err =3D -EIO;
> -               goto unlock;
> +               goto unlockcd;
>         } else if (err) {
>                 goto cleanup;
>         }

See my suggested fix at https://github.com/amir73il/linux/commits/ovl-fixes

Al,

Heads up.
This fix will have a minor conflict with a8b0026847b8 ("rename(): avoid
a deadlock in the case of parents having no common ancestor")
on your work.rename branch.

I plan to push my fix to linux-next soon, but I see that work.rename
is not in linux-next yet.

Thanks,
Amir.

