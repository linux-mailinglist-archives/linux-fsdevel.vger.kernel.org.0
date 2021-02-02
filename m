Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0030C9D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 19:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhBBSaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 13:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbhBBS2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:28:18 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36C7C0613ED;
        Tue,  2 Feb 2021 10:27:10 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id w204so18561043ybg.2;
        Tue, 02 Feb 2021 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2m+4pyELxLE13nsixgO1GZFaxwadXVMCGTsY4w3OVJY=;
        b=iH/hjlSTcK/WUrScRZ1W4uKC/2RW7YgB2I67slCiw+J7L74m92cTOCFUEhYt6GPPYJ
         TNrVi9YOPsXDEe1q0M3jzm0BbUK9YvhQEQ0iDXS8RlECMaTnWvZ8G+MiUvMTLzZ94rGY
         uCxHE6ynRkaSzQlvjKoAsvHjjMefNDJOUomB2Xy54sCOcUeRP/Q7eQ+zAIBgws9LCVEI
         4DJc7v0k6hbWdrnNrNjXNQfZhtBEgPnmSkgiXjdY2QOqUsiEv1Lfllkii2XkJ5f32EZA
         KzZA2bR83F+/Zwrhat3pyq7wv4YcgtlLs4im8V7I1HnY3IzW+irqD7yt/l373H3+kBKL
         5REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2m+4pyELxLE13nsixgO1GZFaxwadXVMCGTsY4w3OVJY=;
        b=Q+RBZsfI5jtJrcJrHrOVYcsTtkGxTAn694174s4tAr0KjvscaX9ASc1b8gDDctbPFJ
         f6nLCvhs6+NRv4xfNfOJr/ORez3N/MqU2SlVjp44MC7srl9ZPpANFtIYeIVOf8ze1kKj
         ODXRa+ZoTcOQ2qYAtz+AAGHLNz68tuYWY/6cdWVn0hEd5bPhEmjo3nF+7GvNeeueXujo
         bAKOd0+M0MlZNkbnvp5MvdiaXlyHRtmypq9i2e8Tg1kc0etBwQO+qEGgKAk/d9Q7enSp
         P/WnDlMNvptTTVQtHf1TOLsUJpZPzI+pbEhAyq2guPUEno/TN5ER3ojxPD0wJwSzF6jw
         MrJw==
X-Gm-Message-State: AOAM5339Fejg9ZyEBZxtNvgUGEkxz8dmFIZKe9XRpUQL1ym0SHiT6TCi
        v8B/lwObOW7PvkpSt62e6YSxzevC1Ik+aO6B51A=
X-Google-Smtp-Source: ABdhPJztICRpjgAeo6h64EPn9Ac6G58x7ZYmJHnfsUg329dBjTiOByo9yfCXxe2/kgukd88fYDdN9lO+ZDVjzOmmpxA=
X-Received: by 2002:a25:aa70:: with SMTP id s103mr25192741ybi.131.1612290429960;
 Tue, 02 Feb 2021 10:27:09 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
 <20210202174255.4269-1-aaptel@suse.com>
In-Reply-To: <20210202174255.4269-1-aaptel@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 2 Feb 2021 23:56:58 +0530
Message-ID: <CANT5p=qpnLH_3UrOv9wKGbxa6D8RUSzbY+uposEbAeVaObjbHg@mail.gmail.com>
Subject: Re: [PATCH v3] cifs: report error instead of invalid when
 revalidating a dentry fails
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks good to me.
Let me know if you get a chance to test it out. If not, I'll test it
on my setup tomorrow.

Regards,
Shyam

On Tue, Feb 2, 2021 at 11:13 PM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
> From: Aurelien Aptel <aaptel@suse.com>
>
> Assuming
> - //HOST/a is mounted on /mnt
> - //HOST/b is mounted on /mnt/b
>
> On a slow connection, running 'df' and killing it while it's
> processing /mnt/b can make cifs_get_inode_info() returns -ERESTARTSYS.
>
> This triggers the following chain of events:
> =3D> the dentry revalidation fail
> =3D> dentry is put and released
> =3D> superblock associated with the dentry is put
> =3D> /mnt/b is unmounted
>
> This patch makes cifs_d_revalidate() return the error instead of
> 0 (invalid) when cifs_revalidate_dentry() fails, except for ENOENT
> where that error means the dentry is invalid.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> Suggested-by: Shyam Prasad N <nspmangalore@gmail.com>
> ---
>  fs/cifs/dir.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 68900f1629bff..868c0b7263ec0 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -737,6 +737,7 @@ static int
>  cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
>  {
>         struct inode *inode;
> +       int rc;
>
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
> @@ -746,8 +747,11 @@ cifs_d_revalidate(struct dentry *direntry, unsigned =
int flags)
>                 if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(ino=
de)))
>                         CIFS_I(inode)->time =3D 0; /* force reval */
>
> -               if (cifs_revalidate_dentry(direntry))
> -                       return 0;
> +               rc =3D cifs_revalidate_dentry(direntry);
> +               if (rc) {
> +                       cifs_dbg(FYI, "cifs_revalidate_dentry failed with=
 rc=3D%d", rc);
> +                       return rc =3D=3D -ENOENT ? 0 : rc;
> +               }
>                 else {
>                         /*
>                          * If the inode wasn't known to be a dfs entry wh=
en
> --
> 2.29.2
>


--=20
Regards,
Shyam
