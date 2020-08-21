Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9B24DE71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHURad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgHURaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:30:14 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040CC061574;
        Fri, 21 Aug 2020 10:30:13 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u15so752695uau.10;
        Fri, 21 Aug 2020 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rh7xLCAFfleIa8pPqcTaoRaDlX4V25hxmH4Sbeg/vds=;
        b=t5pOFv5QTlbBpaqJAdCYgdyeeMd6awPZ11FxQMjz2/GVQprLEq0KpSuttjNzkaqfUv
         xRV4ieSVkGyM5WCfY+N3000Ri4/UK558FeCr0yD2usQrwrbC6lZn2XaMbf+iRMrWCC37
         mcl8DUal4PMgGoEuuuf81ZnW8eyG4aFFYhMAifPcKhtx6rgQqHeesT7i//vx6tSI6qOV
         Sn72Zp4o/qwmsisMb0Neg+kTb46aNE0adC4DUzTSGiOLuWRB9uhTSLAH9OEQQ6smUeN9
         z0Z+jCVGn5qyQ14ZCUP49t5KZAdtz8l23ySb0QPgLHZLEbSCrcIgL3Sq4gP5POjgAbK1
         d/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rh7xLCAFfleIa8pPqcTaoRaDlX4V25hxmH4Sbeg/vds=;
        b=KpOAK5omOc+xwenwTDMgLseV6FMSN4yjj80+EwGlehP8SK1VFJxTvh7qOJZSE+DzMP
         E8LZlcUzATT5NYINUb5wbzybjS7V2IUsnCIE3FT1Eb/8vS7sxcI8Jyx8A229gwTRoNgA
         KPHHmotZI6H1W5ShAqr2Bdah82INGhbAbXlGlUgoo4WDNf2m7HHJ0GyNxnTQzzZRDm9z
         78JI5Fx/P1Lint74/74SAZPNJTZqOuLhpt1J4FzOsCMUd7bwpBqsS730XY3PPeQ/peuq
         WNTtderkoLOXoeJ7xHgkPvWCw9uz3uZ4Hx6aM9jml++exEZEdmao+lXodYQGgCpP9zsn
         +DNg==
X-Gm-Message-State: AOAM530FL/GM/tGvdbM8FJxnDaItKUiOTbw3YN3y6LzZ0iP0VncDEkiC
        Zi4EzGeWtKo1VgPTxrUBtg+iudKon4TeD4YTecQsPruyaV4=
X-Google-Smtp-Source: ABdhPJymVYcLv/QhaWTxFmfKBxIdrcuj5Op31Mm0FUcB2HmBTDCM6Qdd3zOjHyK26hbydMIP0/7Jsym9UPl2ePbY7Ec=
X-Received: by 2002:ab0:650a:: with SMTP id w10mr2340769uam.123.1598031013191;
 Fri, 21 Aug 2020 10:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597994106.git.osandov@osandov.com> <af4ae9204aa3d36a2703dc1aaeb365b7340ed238.1597994106.git.osandov@osandov.com>
In-Reply-To: <af4ae9204aa3d36a2703dc1aaeb365b7340ed238.1597994106.git.osandov@osandov.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 21 Aug 2020 18:30:02 +0100
Message-ID: <CAL3q7H49XQb-UaKmO0QR8V5F7onyCvVB4nYbMgoUfWJE8gJcug@mail.gmail.com>
Subject: Re: [PATCH 3/9] btrfs: send: use btrfs_file_extent_end() in send_write_or_clone()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:42 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> send_write_or_clone() basically has an open-coded copy of
> btrfs_file_extent_end() except that it (incorrectly) aligns to PAGE_SIZE
> instead of sectorsize. Fix and simplify the code by using
> btrfs_file_extent_end().
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, and it passed some long duration tests with both full and
incremental sends here (with and without compression, no-holes, etc).

Thanks.

> ---
>  fs/btrfs/send.c | 44 +++++++++++---------------------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index e70f5ceb3261..37ce21361782 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5400,51 +5400,29 @@ static int send_write_or_clone(struct send_ctx *s=
ctx,
>                                struct clone_root *clone_root)
>  {
>         int ret =3D 0;
> -       struct btrfs_file_extent_item *ei;
>         u64 offset =3D key->offset;
> -       u64 len;
> -       u8 type;
> +       u64 end;
>         u64 bs =3D sctx->send_root->fs_info->sb->s_blocksize;
>
> -       ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
> -                       struct btrfs_file_extent_item);
> -       type =3D btrfs_file_extent_type(path->nodes[0], ei);
> -       if (type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> -               len =3D btrfs_file_extent_ram_bytes(path->nodes[0], ei);
> -               /*
> -                * it is possible the inline item won't cover the whole p=
age,
> -                * but there may be items after this page.  Make
> -                * sure to send the whole thing
> -                */
> -               len =3D PAGE_ALIGN(len);
> -       } else {
> -               len =3D btrfs_file_extent_num_bytes(path->nodes[0], ei);
> -       }
> -
> -       if (offset >=3D sctx->cur_inode_size) {
> -               ret =3D 0;
> -               goto out;
> -       }
> -       if (offset + len > sctx->cur_inode_size)
> -               len =3D sctx->cur_inode_size - offset;
> -       if (len =3D=3D 0) {
> -               ret =3D 0;
> -               goto out;
> -       }
> +       end =3D min(btrfs_file_extent_end(path), sctx->cur_inode_size);
> +       if (offset >=3D end)
> +               return 0;
>
> -       if (clone_root && IS_ALIGNED(offset + len, bs)) {
> +       if (clone_root && IS_ALIGNED(end, bs)) {
> +               struct btrfs_file_extent_item *ei;
>                 u64 disk_byte;
>                 u64 data_offset;
>
> +               ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
> +                                   struct btrfs_file_extent_item);
>                 disk_byte =3D btrfs_file_extent_disk_bytenr(path->nodes[0=
], ei);
>                 data_offset =3D btrfs_file_extent_offset(path->nodes[0], =
ei);
>                 ret =3D clone_range(sctx, clone_root, disk_byte, data_off=
set,
> -                                 offset, len);
> +                                 offset, end - offset);
>         } else {
> -               ret =3D send_extent_data(sctx, offset, len);
> +               ret =3D send_extent_data(sctx, offset, end - offset);
>         }
> -       sctx->cur_inode_next_write_offset =3D offset + len;
> -out:
> +       sctx->cur_inode_next_write_offset =3D end;
>         return ret;
>  }
>
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
