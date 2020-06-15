Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6B1F8C34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 04:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgFOCKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFOCKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:10:42 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C7C061A0E;
        Sun, 14 Jun 2020 19:10:40 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id b10so5141106uaf.0;
        Sun, 14 Jun 2020 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dMBK5oYEMgHflOO7BRyl4WGKXVxa2jtMA+k/vhWciKk=;
        b=qu8bssB48g/cVVJ8F2DTNqF3V0Ic9yaWaKNT7tW4xiOQcfUu8as+lhhv2YK2wNZRt8
         HC5NH1n+MFLu1cqWf063DRiph/3/xNgL2thVA7s5Mzq1/1zTV5qM8uAHV7n9PcoDcMb5
         OKsj0fZ6ASWyZNmFOaPBP4IUeelL2yq0SYj2Zc8HUm+7Y2QnjqULmR46uq7s15HrvfXg
         n+ewKODa/xzB0ULIemz/CQ/cuW+uT+UssMD1KwGmA4LRTPrfAzZcCZgL9RlkuD+yowQN
         rTFj3fDLnRAJ/ILZ+FY9XoH2zRTi286WLU1VpH3WoWeKT3Swh/y9N8R/7vl+wtLRA0px
         uXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dMBK5oYEMgHflOO7BRyl4WGKXVxa2jtMA+k/vhWciKk=;
        b=sES4NETx1vhQCm/siIE8AroqyhcwNJHOIsMMGf5fBgZYDMJSckkHgsV74TCJkk5kH2
         ebSRFFqJy4trIW+Zs0auDtacnPjsIdYlHXrWP4PRSmCzlqn4JBxAK4Ts4mHPFU2A0c5C
         OvJEF9dLw271SKos8X08lX8kdSCxWmzqhpmcGbibMkeesYWoWaLSnpLcVUrIc7jGyFYS
         K3qPADLkIQaJRipQCAJiUwc75vri0KfY49/++DtMGTi+/72CPWhj+zFsM0NftokJkKGq
         /zIy8NCr/zOnd9q/lwT8x2nLRIGlZSqn3bFmEH00qn+RzOLMYf8KIKQ7ddNRsIyUlr8a
         YrEw==
X-Gm-Message-State: AOAM530N/P263W5c0qwkSoLDNHdPsqZIDF2wO0nGgmSp0+cdtUyP+svi
        jBMsrZ+a59bKFlfuaCmvOcFm+ftglaoKvFNpCeCNjQ==
X-Google-Smtp-Source: ABdhPJxKSsOsF7vODEPKWVZc+RtdcZXBOfN170fA8+ddivd4Y9QLoFPMFbUucL032J2BEkZPOJfoaLrfIqkV7IN5CaE=
X-Received: by 2002:ab0:7244:: with SMTP id d4mr16854925uap.60.1592187039792;
 Sun, 14 Jun 2020 19:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200612094312epcas1p1d8be51e8ab6e26b622e3c8437a20cfcf@epcas1p1.samsung.com>
 <20200612094250.9347-1-hyc.lee@gmail.com> <001401d642a9$f74c3040$e5e490c0$@samsung.com>
In-Reply-To: <001401d642a9$f74c3040$e5e490c0$@samsung.com>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Mon, 15 Jun 2020 11:10:24 +0900
Message-ID: <CANFS6bYm_yCLG2kKfn8wYBJ4bO+Z+2+R-gHQ6dTwiP9Ut3yy5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] exfat: call sync_filesystem for read-only remount
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae,

2020=EB=85=84 6=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:14, N=
amjae Jeon <namjae.jeon@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Hyunchul,
> > We need to commit dirty metadata and pages to disk before remounting ex=
fat as read-only.
> >
> > This fixes a failure in xfstests generic/452
> Could you please elaborate more the reason why generic/452 in xfstests fa=
iled ?

xfstests generic/452 does the following.
cp /bin/ls <exfat>/
mount -o remount,ro <exfat>

the <exfat>/ls file is corrupted, because while exfat is remounted as read-=
only,
exfat doesn't have a chance to commit metadata and vfs invalidates page
caches in a block device.

I will put this explanation in a commit message.

> >
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> > ---
> >  fs/exfat/super.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/fs/exfat/super.c b/fs/exfat/super.c index e650e65536f8..61=
c6cf240c19 100644
> > --- a/fs/exfat/super.c
> > +++ b/fs/exfat/super.c
> > @@ -693,10 +693,29 @@ static void exfat_free(struct fs_context *fc)
> >       }
> >  }
> >
> > +static int exfat_reconfigure(struct fs_context *fc) {
> > +     struct super_block *sb =3D fc->root->d_sb;
> > +     int ret;
> int ret =3D 0;
> > +     bool new_rdonly;
> > +
> > +     new_rdonly =3D fc->sb_flags & SB_RDONLY;
> > +     if (new_rdonly !=3D sb_rdonly(sb)) {
> If you modify it like this, would not we need new_rdonly?
>         if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb))
>
This condition means that mount options are changed from "rw" to "ro",
or "ro" to "rw".

> > +             if (new_rdonly) {

And this condition means these options are changed from "rw" to "ro".
It seems better to change two conditions to the one you suggested, or
remove those. because sync_filesystem returns 0 when the filesystem is
mounted as read-only.

> > +                     /* volume flag will be updated in exfat_sync_fs *=
/
> > +                     ret =3D sync_filesystem(sb);
> > +                     if (ret < 0)
> > +                             return ret;
> I think that this ret check can be removed by using return ret; below ?

Okay, I will apply this.
Thank you for your comments!


> > +             }
> > +     }
> > +     return 0;
> return ret;
> > +}
> > +
> >  static const struct fs_context_operations exfat_context_ops =3D {
> >       .parse_param    =3D exfat_parse_param,
> >       .get_tree       =3D exfat_get_tree,
> >       .free           =3D exfat_free,
> > +     .reconfigure    =3D exfat_reconfigure,
> >  };
> >
> >  static int exfat_init_fs_context(struct fs_context *fc)
> > --
> > 2.17.1
>
>
