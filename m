Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5333037BF68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhELOKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhELOKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 10:10:54 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5DC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 07:09:46 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id v188so12032314vsb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yniG3HuKY/NTfByFN5hTaqoF9CIToavZscJkHlokFWk=;
        b=QwyjxBxcdpZpBnLRoxF9WvzQX2qtkbZxRoNgJtvSo1AhIh9Z6+5GlVm99ts6hmd8OE
         ewhOei4QUxt7zRkctEgA+YElM/F+nx+UYYQdPa1Miu5+lNt06vRUCTG4uzMVq1JqzraI
         UB1LgDVKx7jKsi1KrgVBjutwyIfGU3R3eTMXK8T8CTrnIPaSv4FnHSBjau+XVw4fceZs
         M0RT6IA+5Gn/bES+/oAjXuS6eij2K9YRvgngZq7XcWvRDmdfCFSpTsi53LVwwM4GrFND
         IxwxhEFDD45Hg8wmK5yo2TRjOzrlvSmjLJ7vFp/mJRgesCQhE+U/nKUI1aRfZAGYMJCl
         OzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yniG3HuKY/NTfByFN5hTaqoF9CIToavZscJkHlokFWk=;
        b=CZTQpoUfd+iTe+KTpKxSGppgyGQ/F3zIp08iIyKboosOz37MhazTfdVGPBAfVXEBzL
         VRUJaUPwroPF6qiYox6QUYv3+SI3uOVyrAwftfKRmIYt1JNkpH1D9DO44cMQkINyLiQW
         6pI620HkhMGePFayoamvC5kjJUXeuI1wgY7R89Ipv+2VpJ667h9yurmudr+r+I2pF4iF
         WTy9T5zDnqiRqyvopMKAQZF5JLfQ6YQ+F1hcp0cBxtFE0wAIUjzff2Ry+m6lx8Mi+3Yw
         HcRuvT3r1X+IvSN8oUJYaMVgXgBrE0rOXGY4FTx2hPU9I92uQaeTP3saRhgq3Tz3bReu
         cAcw==
X-Gm-Message-State: AOAM5313OXVeL+VkhZUaLTkuYjr4UMWwnZ5NJ6reeLAKmRP2nK90aOaV
        XPZQKJ8h+gBbEtIcN1pNdy0iRrk3sEPLBIVsf+g=
X-Google-Smtp-Source: ABdhPJywG/PgyIZnC1+1KeKot18py1B7lgzTZaDne/JptVWOpVxhyUH2Vi/1cGYVpXKtGjp8cyvVNkCTvM8rUj4CgXw=
X-Received: by 2002:a05:6102:a89:: with SMTP id n9mr32200343vsg.45.1620828585904;
 Wed, 12 May 2021 07:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
 <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
 <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
 <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net> <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
 <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
In-Reply-To: <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Wed, 12 May 2021 23:09:34 +0900
Message-ID: <CANFS6bZs3bDQdKH-PYnQqo=3iDUaVy5dH8VQ+JE8WdeVi4o0NQ@mail.gmail.com>
Subject: Re: problem with exfat on 4k logical sector devices
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Reichl <preichl@redhat.com>,
        chritophe.vu-brugier@seagate.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

2021=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:57, E=
ric Sandeen <sandeen@sandeen.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 5/11/21 6:53 PM, Namjae Jeon wrote:
>
> >> One other thing that I ran across is that fsck seems to validate an im=
age against the sector size of
> >> the device hosting the image rather than the sector size found in the =
boot sector, which seems like
> >> another issue that will come up:
> >>
> >> # fsck/fsck.exfat /dev/sdb
> >> exfatprogs version : 1.1.1
> >> /dev/sdb: clean. directories 1, files 0
> >>
> >> # dd if=3D/dev/sdb of=3Dtest.img
> >> 524288+0 records in
> >> 524288+0 records out
> >> 268435456 bytes (268 MB) copied, 1.27619 s, 210 MB/s
> >>
> >> # fsck.exfat test.img
> >> exfatprogs version : 1.1.1
> >> checksum of boot region is not correct. 0, but expected 0x3ee721 boot =
region is corrupted. try to
> >> restore the region from backup. Fix (y/N)? n
> >>
> >> Right now the utilities seem to assume that the device they're pointed=
 at is always a block device,
> >> and image files are problematic.
> > Okay, Will fix it.
>
> Right now I have a hack like this.
>
> 1) don't validate the in-image sector size against the host device size
> (maybe should only skip this check if it's not a bdev? Or is it OK to hav=
e
> a 4k sector size fs on a 512 device? Probably?)
>
> 2) populate the "bd" sector size information from the values read from th=
e image.
>
> It feels a bit messy, but it works so far. I guess the messiness stems fr=
om
> assuming that we always have a "bd" block device.
>

I think we need to keep the "bd" sector size to avoid confusion between
the device's sector size and the exfat's sector size.

> -Eric
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 85d5101..30ec8cb 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -100,6 +100,9 @@ static int exfat_show_ondisk_all_info(struct exfat_bl=
k_dev *bd)
>                 goto free_ppbr;
>         }
>
> +       bd->sector_size_bits =3D pbsx->sect_size_bits;
> +       bd->sector_size =3D 1 << pbsx->sect_size_bits;
> +
>         if (pbsx->sect_per_clus_bits > 25 - pbsx->sect_size_bits) {
>                 exfat_err("bogus sectors bits per cluster : %u\n",
>                                 pbsx->sect_per_clus_bits);
> @@ -107,13 +110,6 @@ static int exfat_show_ondisk_all_info(struct exfat_b=
lk_dev *bd)
>                 goto free_ppbr;
>         }
>
> -       if (bd->sector_size !=3D 1 << pbsx->sect_size_bits) {
> -               exfat_err("bogus sector size : %u (sector size bits : %u)=
\n",
> -                               bd->sector_size, pbsx->sect_size_bits);
> -               ret =3D -EINVAL;
> -               goto free_ppbr;
> -       }
> -
>         clu_offset =3D le32_to_cpu(pbsx->clu_offset);
>         total_clus =3D le32_to_cpu(pbsx->clu_count);
>         root_clu =3D le32_to_cpu(pbsx->root_cluster);
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 747a771..5ea8278 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -682,6 +682,9 @@ static int read_boot_region(struct exfat_blk_dev *bd,=
 struct pbr **pbr,
>                 goto err;
>         }
>
> +       bd->sector_size_bits =3D bs->bsx.sect_size_bits;
> +       bd->sector_size =3D 1 << bs->bsx.sect_size_bits;
> +

Is it better to add a sector size parameter to read_boot_region
function? This function
is also called to read the backup boot region to restore the corrupted
main boot region.
During this restoration, we need to read the backup boot region with
various sector sizes,
Because we don't have a certain exfat sector size.

>         ret =3D boot_region_checksum(bd, bs_offset);
>         if (ret < 0)
>                 goto err;
>
>

I sent the pull request to fix these problems. Could you check this request=
?
https://github.com/exfatprogs/exfatprogs/pull/167

Thanks,
Hyunchul.
