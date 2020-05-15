Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9871D48B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEOImm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgEOIml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:42:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75399C05BD09
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:42:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so1530814edq.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B20IIqgVPN5EsJCsjMuXMwagsi+l/qnqtyAK/Hxxl78=;
        b=Lwj7yc3CLPjGQmlYTvBQB5aNkHaZ/QIaZTuSWArFVmjaAykhy83SZgUHcPxSsLLk2Q
         ieSqvIv2N/mZpP+rvFAtJUe0KDbDqG2xR1bME0yH49vVchjGnGollMSgvNbmMlKvU7Sp
         qd1lchhwW27PJjC2vBT9tJSt7ZTUGg1JO/9nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B20IIqgVPN5EsJCsjMuXMwagsi+l/qnqtyAK/Hxxl78=;
        b=MCp2CS7xTpGRnLQiLR5BqIoys8libEmcwxqBjmltWUmDrzA9NTpekLNvpDA2mqFs6/
         LXOQie9NbIIwd+jQKZs7wEIFjoplbQx+d0hJ/dxx+I+bSxpQJB5lXInrR1DqgV5ufcUc
         g6tBfQmDQ0zc0AUqPx6QOIJYZH3/26omcWSudfyq/38Ixnia37mBuWcIH+BKkOkFUae1
         OSJlRw2f0CIvjp4D4/stW/7U0NuWV2i5hLr3UZPuoaQvmuMKkY9S50aqtu1tiwPeAHXW
         k4VPietaVzCayt1Fa5aJ6ovDb4BxuhI/Sw6JCPJy0iBR9kQIokcmBpq2VxD3FhGD5p90
         KiMA==
X-Gm-Message-State: AOAM530GVFnpSSFCo8evrTVorFZpv8/4U1qA7geKz5PU5Pk/JiCIEQrI
        J+OM1gcukGPEGpGSnkD/2AV1rZ5eSUWnhu72HdzNjiPeXFE=
X-Google-Smtp-Source: ABdhPJwdcrWF3G7Rq+qfYkIVbIazzm/I9qPrWKhfieUqOBMC9ltDEavfEhg2N/npBshJ4yLUirzpyxuS5OLN9w7sghw=
X-Received: by 2002:a50:d785:: with SMTP id w5mr1709907edi.212.1589532160099;
 Fri, 15 May 2020 01:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200515072047.31454-1-cgxu519@mykernel.net> <CAOQ4uxhytw8YPY5WR+txeeHhuO+Hvr0eDFuKOahrN_htXtH_rA@mail.gmail.com>
 <17217706984.f5e20fe88512.8363313618084688988@mykernel.net>
In-Reply-To: <17217706984.f5e20fe88512.8363313618084688988@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 15 May 2020 10:42:29 +0200
Message-ID: <CAJfpegvfEeDkBbgL0SXgZORkd2+eLaosNDG+_o=+qksyHcfurQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 10:26 AM Chengguang Xu <cgxu519@mykernel.net> wrote=
:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-05-15 15:30:27 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Fri, May 15, 2020 at 10:21 AM Chengguang Xu <cgxu519@mykernel.net> =
wrote:
>  > >
>  > > This series adds a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
>  > > to indicate to drop negative dentry in slow path of lookup.
>  > >
>  > > In overlayfs, negative dentries in upper/lower layers are useless
>  > > after construction of overlayfs' own dentry, so in order to
>  > > effectively reclaim those dentries, specify LOOKUP_DONTCACHE_NEGATIV=
E
>  > > flag when doing lookup in upper/lower layers.
>  > >
>  > > Patch 1 adds flag LOOKUP_DONTCACHE_NEGATIVE and related logic in vfs=
 layer.
>  > > Patch 2 does lookup optimazation for overlayfs.
>  > > Patch 3-9 just adjusts function argument when calling
>  > > lookup_positive_unlocked() and lookup_one_len_unlocked().
>  >
>  > Hmm you cannot do that, build must not be broken mid series.
>  > When Miklos said split he meant to patch 1 and 2.
>  > Patch 1 must convert all callers to the new argument list,
>  > at which point all overlayfs calls are with 0 flags.
>  >
>  > Once that's done, you may add:
>  > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>  >
>
> OK, I got it, I'll still wait for a while in case of other feedbacks.
>
> Miklos, AI
>
> I'm not sure this series will go into whose tree in the end,
> so I just rebased on current linus-tree, any suggestion for the code base=
?

Linus' tree is a good base in this case.  I'm happier if VFS changes
go through Al's tree, but simple stuff can go through overlayfs tree
as well.

Thanks,
Miklos
