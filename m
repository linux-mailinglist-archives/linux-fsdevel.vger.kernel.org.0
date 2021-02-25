Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE87832508E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBYNdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBYNda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:33:30 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2AC061574;
        Thu, 25 Feb 2021 05:32:50 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id w19so5513620qki.13;
        Thu, 25 Feb 2021 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/HozBozd0HS9TGCZ8dbG2UcJHoDOsGOVwFw4J3/77Mw=;
        b=FJRSm9IFwgxNVM9WCaw1zLyhGOQsFXkh7vBL0Z0AHV/PqwRVaRlmqXix2ah4NrtaTL
         +sQTEKS6U8a3Z4f7sqcOmXM2oNE3BK6mBG8gmh3un6BqFDcUm88SkydJb//xJU3fdkvN
         Dx2GGtqJDKUZnBjY/iquV1NVtICIzFgegLTSeIDsVNOSo3vvTJB4kiNT68K+Os0AoSnq
         1e40Xe/ubLeksCnry23XtuPT6sXPgIMZjaUTF5lqnmUPJpqlS29b7LqlXQypUCPlLUSZ
         wNK1n+WifB4Lu5/3d3UHWi679e7aEouJmhkvener4O8P6YdCUEsJc9bG39YZokhP7YcY
         aMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/HozBozd0HS9TGCZ8dbG2UcJHoDOsGOVwFw4J3/77Mw=;
        b=cJLyFazbJmCbvVSiJOtZSKgSkfSebl3J3nUtie6dFcalM1GjLqHOz/vUvoHLI1NhwL
         /+0LlU86IMIdrkPHTRqGfF9+3b1/Tc2Lk1GBFGPK+iH6czk6DmLRBADSBVLEPoFjYHna
         QgP6MO4KXJUg2Nx7bIlyKuaG4dPemeKCk97phwGeZmUs8OB5rg2/s8xBNdbdKshLX8kw
         gf2HTR3bvQIeSXbfMd+tM/h2A7ygpcy5iHoCkX8X+pKbj4cMKhFy6J0yHLR9QOVvcrT2
         grsbJa0FSomS7VxvGSFNHeYm9TeR/TGpJ1/4TucmPJYn+lMZBYpxjG1CB2WL+OEKN1jn
         diFw==
X-Gm-Message-State: AOAM53081dJ5wZchAQnjMQhC/aYP4eHBzmOMBHgnxV0kOYdHWCoN5cYU
        maG6MlxQCPZ/FUFEnfYsdidr7q2jAs2/2Gc8aoU=
X-Google-Smtp-Source: ABdhPJw6E3Or11svH8GhUTKrjsCjzoCy4xqe+Yu0x1sVcoakG4LJvysmWudeFkbVD//UDzAE2NOMyLkGBp30g0Ny4bA=
X-Received: by 2002:a37:65d8:: with SMTP id z207mr2553122qkb.479.1614259969559;
 Thu, 25 Feb 2021 05:32:49 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
In-Reply-To: <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 25 Feb 2021 13:32:38 +0000
Message-ID: <CAL3q7H6H0gokXic_-st71zcyzoegeUbRR86pc2hpXF30Ow_Sxg@mail.gmail.com>
Subject: Re: Adding LZ4 compression support to Btrfs
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 1:23 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> On Wed, Feb 24, 2021 at 11:10 PM Amy Parker <enbyamy@gmail.com> wrote:
> >
> > The compression options in Btrfs are great, and help save a ton of
> > space on disk. Zstandard works extremely well for this, and is fairly
> > fast. However, it can heavily reduce the speed of quick disks, does
> > not work well on lower-end systems, and does not scale well across
> > multiple cores. Zlib is even slower and worse on compression ratio,
> > and LZO suffers on both the compression ratio and speed.
> >
> > I've been laying out my plans for a backup software recently, and
> > stumbled upon LZ4. Tends to hover around LZO compression ratios.
> > Performs better than Zstandard and LZO slightly for compression - but
> > significantly outpaces them on decompression, which matters
> > significantly more for users:
> >
> > zstd 1.4.5:
> >  - ratio 2.884
> >  - compression 500 MiB/s
> >  - decompression 1.66 GiB/s
> > zlib 1.2.11:
> >  - ratio 2.743
> >  - compression 90 MiB/s
> >  - decompression 400 MiB/s
> > lzo 2.10:
> >  - ratio 2.106
> >  - compression 690 MiB/s
> >  - decompression 820 MiB/s
> > lz4 1.9.2:
> >  - ratio 2.101
> >  - compression 740 MiB/s
> >  - decompression 4.5 GiB/s
> >
> > LZ4's speeds are high enough to allow many applications which
> > previously declined to use any compression due to speed to increase
> > their possible space while keeping fast write and especially read
> > access.
> >
> > What're thoughts like on adding something like LZ4 as a compression
> > option in btrfs? Is it feasible given the current implementation of
> > compression in btrfs?
>
> This is definitely possible. I think the only reason lz4 isn't enabled
> for Btrfs has been the lack of interest in it. I'd defer to some of
> the kernel folks (I'm just a user and integrator myself), but I think
> that's definitely worth having lz4 compression supported.

This has been brought up over and over for many years:

https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F

Things have to be evaluated in btrfs' context, i.e. how it uses compression=
.
More details there anyway.

>
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
