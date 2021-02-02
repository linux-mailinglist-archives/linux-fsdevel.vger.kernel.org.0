Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27130C723
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 18:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhBBRM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 12:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbhBBRKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:10:38 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC6C061573;
        Tue,  2 Feb 2021 09:09:58 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y128so21113203ybf.10;
        Tue, 02 Feb 2021 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H7We7nevqNftUly3vcXbxtEGDvOrtRapJVlAsFJE+No=;
        b=ZnUdF8+AQpY8l/i+msa+xitm3gGy4shd1Lhqlf3rHRJXUmP1FXRjk7eko/HNyZXi/s
         0GhqCSC4wf16D8aNbthHCSnzx3EVO1kJNJVS99y61YTYX29Y1D5HsmQL1VwTWX43AQ7t
         QO5o7biF1hIQCzzHObzaJge9uCsh6G5EIgdtGTiuQEYpC5Y3cVnogmjeOJ/ZYKGh+2cK
         eTGVYTqqXqIatrrNB4B/2WMKmH3IfmW8ZqLiRf7+LiM8OtGhzJxSKU40lpei6do1jrou
         vr6ox3Ydm2ruIodly7BWPUVfBDfHRYgym14A2Mllf0hKzZkmvQOIEKawYZWPPBV+57cg
         a9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H7We7nevqNftUly3vcXbxtEGDvOrtRapJVlAsFJE+No=;
        b=W8UWNscAoXUgbmgJ7d0q6uHnl+8RU3XD4Jv0cOf5fJkKj83pF1XLKUaLj50ajgMV9W
         CGMJvIB8DMTb/OmY6GrhSNKaKC0G76FyJaV9m0fOU0atxhz7qLOFFcoVGXbEGD0tASoD
         IA3mC9FVMXQNW9p+//PoCziIx5fCdQPmLi07Qk7lH4ZKb5Jo2xdlvyPNCFEvxPzaMraH
         CXHqlThYeaqzOXJe97DSDp2ys9+YvIb3Q6d0HNEruZXhW0UDut0LDXqnKVaHGXBSoo6O
         El75K0F+dc4vro5pm22tpju04nUOmc8bW2d900k75cBw56IrRD3Brc6hR0r3iwrSXXYG
         q4PQ==
X-Gm-Message-State: AOAM5316g0OrWbhVi8QZsIxLivZmvHZWvbYUTEZ13f5FgOx5x/ih7tmj
        C8HzR9Gg8BEVoI3uMdOojCY69eG2e0mMRL0VR/U=
X-Google-Smtp-Source: ABdhPJy6gNNFMOG7MZSgft71GSDCXnXRvwxRnAWJibVGo9GXer8iQYSJlgLnxnFksGoZvl1v95vG2cRtbnAP4ybECsc=
X-Received: by 2002:a25:c605:: with SMTP id k5mr22965540ybf.34.1612285797983;
 Tue, 02 Feb 2021 09:09:57 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
 <20210202111607.16372-1-aaptel@suse.com>
In-Reply-To: <20210202111607.16372-1-aaptel@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 2 Feb 2021 22:39:47 +0530
Message-ID: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: report error instead of invalid when
 revalidating a dentry fails
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

What does cifs_revalidate_dentry return when the dentry is no longer exists=
?
I'm guessing that it'll return some error (ENOENT?). Do we need to
treat that as a special case and return 0 (invalid)?

Regards,
Shyam

On Tue, Feb 2, 2021 at 4:46 PM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
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
> 0 (invalid) when cifs_revalidate_dentry() fails.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> Suggested-by: Shyam Prasad N <nspmangalore@gmail.com>
> ---
>  fs/cifs/dir.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 68900f1629bff..4174f35590e62 100644
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
> +                       return rc;
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
