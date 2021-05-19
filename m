Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEF389994
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhESXII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESXII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 19:08:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C97BC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 16:06:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s25so17455695ljo.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jwk0saAKOxxux1qLucTjT7RVUUV0SrqEWvSDUW8ts5s=;
        b=b4urCb4opB54xSjva7L2H57Jbu48k96U331P316PVRjEdePqn9pQtL38RCqXXfwwTg
         M7WaUampS0T6oF+Nh0Y6etHwfIbeFbAMkgd6r2H+CQ1m3Hui7gPuoFuL2yHxdXfZu5/N
         5aTknzhPLs3O3IGgRg+qiCZb7GOBJh+UNu4kfY8dRzxpcoK2GblbePyp5XxppIGTWVrz
         2T4Ju9PlCeiLbBVhPIA+CrrL4oYFpLDpOMOfBUy61inJs8Si6oL2ay/jybH4gZX3yCYW
         yWRlIowiss/ADAI2og7lUtuDea0Ch0rCVZl9kWsqEJDFmxAc6yunyitFB1h96vDobdma
         LCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jwk0saAKOxxux1qLucTjT7RVUUV0SrqEWvSDUW8ts5s=;
        b=qI+JFJ7VVNfv0hdR5d3BFQCWBb2iEsc/05npyl4kq/Es+Jeo7OTE8+jNGwyyWLV/aE
         KEiArAHjX0LaQ3vgOER2fL+xVzIYfa6f75c/g8XOBPSEZpXAxV8mbU8rhK7+cX7vWiOy
         pv59IGt0/eb90/xZXTaz+jqc1POiDtSZ70vuvV8oZZaz51gtn+2FRAIwy52OBZZWr0oV
         IpbSGAaSRBEBokbppxaIPKnOt2aDpyopeUkQ1LVIn4xORX5Kxzv5Er6KEWDUsAArKDpn
         tZ0lILid8udKTmF/aSBnl6uV52RQY6CTUW02ruEPHBzbNAI+YzQL4EaBklAUCvPrsb6U
         K4yQ==
X-Gm-Message-State: AOAM531wETcDWcgU2lSRlDPAEgln9s4egtvl/KSaY6nHKW4VO+2qhF2z
        EHEhN/yMcUoOUzNOi3hikiiBLKzCxBrCFk/7jpzIOA==
X-Google-Smtp-Source: ABdhPJylqqYaO0m7SAS9trWbWvqpRQsbqTFEQBjRkjumnO4TwW0FwkUKpoVF6sDI6C3TqVp06SXSsIya5drVjSk12Pg=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr1048011ljc.116.1621465604566;
 Wed, 19 May 2021 16:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <212218590.13874.1621431781547@office.mailbox.org>
In-Reply-To: <212218590.13874.1621431781547@office.mailbox.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 May 2021 16:06:33 -0700
Message-ID: <CAKwvOd=Z1ia4ZufDbRsEUkumwkz15TtSb2V1aBT7SN8w86RKYw@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: make ntfs3 compile with clang-12
To:     torvic9@mailbox.org
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "almaz.alexandrovich@paragon-software.com" 
        <almaz.alexandrovich@paragon-software.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 6:43 AM <torvic9@mailbox.org> wrote:
>
> Some of the ccflags in the fs/ntfs3 Makefile are for gcc only.
> Replace them with clang alternatives if necessary.
>
> Signed-off-by: Tor Vic <torvic9@mailbox.org>

Thanks for the patch. +clang-built-linux; please make sure to cc the
lists from ./scripts/get_maintainer.pl <patch file>.  It should
recommend our mailing list of the words clang or llvm appear anywhere
in the patch file. This helps spread around the review burden.

> ---
>  fs/ntfs3/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
> index b06a06cc0..dae144033 100644
> --- a/fs/ntfs3/Makefile
> +++ b/fs/ntfs3/Makefile
> @@ -4,7 +4,9 @@
>  #
>
>  # to check robot warnings
> -ccflags-y += -Wunused-but-set-variable -Wold-style-declaration -Wint-to-pointer-cast
> +ccflags-y += -Wint-to-pointer-cast \
> +       $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
> +       $(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)

I think it would be better to leave off the second parameter of both
of these, which is the fallback.

>
>  obj-$(CONFIG_NTFS3_FS) += ntfs3.o
>
> --
> 2.31.1

-- 
Thanks,
~Nick Desaulniers
