Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7303B873F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhF3Qv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 12:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhF3Qv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:51:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ECEC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 09:49:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 11so3794950oid.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rrCOm25/wEcGs4N+ignfWeXZ6vUmh9jcEMLQbvJ5br4=;
        b=eeQo4foSw6TAL6FybAfTFXaZWU/NCyKYkJO4+IOMa4MbGuIZpeRjBq3Qm0T552EbpO
         wTBJ2SukQsb0mP4tJ93zV3BYWnc9E7eqTqld7VYYhhw3nonsoA+Zqz9zyT1s6GhK9E7G
         0dSoemF1Zm3Q3U6Fym+KRbHg0yu/Sk5dyzkrfr/3Lmh1xYQpFkFVx40LroJ0tO0paIcP
         5hjTunf7Q7KwPNPmx7Tubjo0sUdQxInBItfmm//y2ISs+CvVl5wAoCuJiTZSDGv+pwc0
         Kmo4oyuwT+0vC0T5yf7mzVMwO+D8r9RgXBarR72UO8D2F1RPczkORPEA7qUdAuDmBe4c
         Jukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rrCOm25/wEcGs4N+ignfWeXZ6vUmh9jcEMLQbvJ5br4=;
        b=aXsdqqfaPTFz7uaD2bHT5N9x+7T7PpWaVDQp4Ft40y23YYuf4OOE/7h2I9Nqm7ORrG
         vf+OW6MqDDmnlEz/zuCPgsGr8o/5tdSA/EXM81VTf+pUu+GWhNVF/ivbJ4YzgL240ROG
         K7YEwmH4TsSOpjV07vHh9Bxull/5KfzEn2wJL6RpD9Jnkq2sDsokK4ChNvQYSsGGAOPT
         F6O7P+6XCuMlPOV/2YT5REt/v1UFQbpZahcNvx8nm2yH3RS1G4q3VvNpYrB3kuZdRt0z
         n54hBH+Qd5e+65jAR+a+0iI8fNEPkQSWp+jnk5ieActDupoAN+Let5D8i7JM0dBJS/6H
         SQTA==
X-Gm-Message-State: AOAM53258vP09FHh0883Nf97wY1FqbJvzCdf+LGlMQxf4x+AMBf/B9vX
        /nT1A+2PWPsFTXw8TytMzWEKiA==
X-Google-Smtp-Source: ABdhPJxzKp7MPSvpUosyPw5bxagc2IEryBNpRdMq/F2UACoqPB/rE/kwSb4EjaFzgOBjtcGJoNJJIQ==
X-Received: by 2002:a54:408b:: with SMTP id i11mr3666320oii.67.1625071768326;
        Wed, 30 Jun 2021 09:49:28 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:f8e3:a853:8646:6bc8])
        by smtp.gmail.com with ESMTPSA id o25sm4650028ood.20.2021.06.30.09.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 09:49:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/3] hfs: add missing clean-up in hfs_fill_super
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <6c6d6cd8-b8b3-54a9-f0bd-b36220caba26@gmail.com>
Date:   Wed, 30 Jun 2021 09:49:26 -0700
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19A0D984-2817-44C5-87AE-6C2BF2310671@dubeyko.com>
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
 <20210629144803.62541-2-desmondcheongzx@gmail.com>
 <28CCF4E3-51D1-43BE-A2BA-4708175A59C0@dubeyko.com>
 <6c6d6cd8-b8b3-54a9-f0bd-b36220caba26@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 29, 2021, at 9:50 PM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:

<skipped>

> Thanks for the suggestion. Since the bail and bail_no_root error paths =
are used before hfs_find_init and after hfs_find_exit are called in the =
normal execution case, moving hfs_find_exit under the bail label =
wouldn't work.
>=20
> Perhaps this can be done by introducing another goto label. Any =
thoughts on the following?
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 44d07c9e3a7f..12d9bae39363 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -420,14 +420,12 @@ static int hfs_fill_super(struct super_block =
*sb, void *data, int silent)
>        if (!res) {
>                if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) =
{
>                        res =3D  -EIO;
> -                       goto bail;
> +                       goto bail_hfs_find;
>                }
>                hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, =
fd.entrylength);
>        }
> -       if (res) {
> -               hfs_find_exit(&fd);
> -               goto bail_no_root;
> -       }
> +       if (res)
> +               goto bail_hfs_find;
>        res =3D -EINVAL;
>        root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
>        hfs_find_exit(&fd);
> @@ -443,6 +441,8 @@ static int hfs_fill_super(struct super_block *sb, =
void *data, int silent)
>        /* everything's okay */
>        return 0;
>=20
> +bail_hfs_find:
> +       hfs_find_exit(&fd);
> bail_no_root:
>        pr_err("get root inode failed\n");
> bail:

Makes sense. Looks good.

Thanks,
Slava.

