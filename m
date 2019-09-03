Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDAA6A77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfICNwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:52:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38741 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICNwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:52:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so12966474lfh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g2euOzbhuNK7g9XKLpA4C13cCqIJOKkMfXZ8Anqpll8=;
        b=AigMVgvFEUSHDVBa/i+5lkqDEAGVREdhgJJvzSBL/U+HQt+kQnMOE3nDuOGTf/apwo
         p52yiCaJsV/bEZxuwg/K2ple75yS+DDIHlOKTscCI7B2/Kz4c5KsrcqnJKjHgFUHKptV
         yhs8pYweX7RZpXHiXURrisP66Y4zllZ3jw70eASXozYlx1ZYmwbmjzdOVjQPyAHb9ppT
         5TIlSuuq12ryfhbxqQVGsZ1tpduyI3JRInxE/cRRrbzIkyFO8v3jtpIOcJX37N82mirx
         Ca0JGvkGC7zojanFSPMMDrhmr0cEISH04VlmhHKX2OERROew/Lkxv/MSe6GBL0XMWLe3
         abGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g2euOzbhuNK7g9XKLpA4C13cCqIJOKkMfXZ8Anqpll8=;
        b=TuIOoBMZb8fR5ABJUez6wBYnssD1jDLU6SoYPa67He/lVSsWl+5l/2R6lnp45Hn+fY
         O+EgFKyj+j7cXv4qWNBcBaA4uMzTr4g6GPwtHz0Nqz+mSzPGmvYrC0yVtnsHny2aA5zE
         5Jets44aNVA/u0RMIKRYuyB4B6UPFwBPGZDPw0/v3YX0iJUjBopDJsBTbwsccjSqmbS3
         x1R3uXko92xN3XHO75Ayp0W0g98Px/EnU6c4LIXq1uZkPzNK4PrQPsoSAvibXT4+ADIn
         I6nFms1H01Y/XNM55haLytXfOxeHzEKHIsXtEBYKxhhJzyGxwzsv3UdbrFUA6lQeCu84
         5w9A==
X-Gm-Message-State: APjAAAWcKtN+4dp8PO1MnNo0HJxWD9N/8Ta241FZ4glybzHLu/fjYTeS
        RJOnQsv9m2QXuLzhPy1Gg4t6CJszY6BquHkRndIuMA==
X-Google-Smtp-Source: APXvYqzXbbXstoZsJ1pD0/OC7Yb6uxzuiLjL2mqM337AHoyGMIoGY2bUj1X4+V06Ngde7Qx+Rgjqg/LGwW/9SLuKCaw=
X-Received: by 2002:ac2:48af:: with SMTP id u15mr13495069lfg.75.1567518773050;
 Tue, 03 Sep 2019 06:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw> <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903133134.GG1131@ZenIV.linux.org.uk>
In-Reply-To: <20190903133134.GG1131@ZenIV.linux.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Sep 2019 19:22:41 +0530
Message-ID: <CA+G9fYtQLLTWNNqb289Q+tCLgZ72mXeqmUweTMJF69MBh+8GDA@mail.gmail.com>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot panic
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Qian Cai <cai@lca.pw>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

On Tue, 3 Sep 2019 at 19:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 03, 2019 at 01:37:19PM +0100, Al Viro wrote:
> > On Tue, Sep 03, 2019 at 12:21:36AM -0400, Qian Cai wrote:
> > > The linux-next commit "fs/namei.c: keep track of nd->root refcount st=
atus=E2=80=9D [1] causes boot panic on all
> > > architectures here on today=E2=80=99s linux-next (0902). Reverted it =
will fix the issue.
> >
> > <swearing>
> >
> > OK, I see what's going on.  Incremental to be folded in:
>
> ... or, better yet,
>
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 20ce2f917ef4..397a08ade6a2 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -37,7 +37,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST=
_BIND};
>  #define LOOKUP_NO_REVAL                0x0080
>  #define LOOKUP_JUMPED          0x1000
>  #define LOOKUP_ROOT            0x2000
> -#define LOOKUP_ROOT_GRABBED    0x4000
> +#define LOOKUP_ROOT_GRABBED    0x0008
>
>  extern int path_pts(struct path *path);
>

I have applied above patch and tested on arm64 juno-r2 and boot pass [1].
Thanks for the fix patch.

>
> to avoid breaking out-of-tree stuff for now good reason.
> Folded and pushed out.

[1] https://lkft.validation.linaro.org/scheduler/job/898187#L511

- Naresh
