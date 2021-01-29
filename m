Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3F308580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 07:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhA2GIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhA2GIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:08:38 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5C4C061573;
        Thu, 28 Jan 2021 22:07:57 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z18so7338115ile.9;
        Thu, 28 Jan 2021 22:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSMECV3esitGF7SoTH5ZSvyrofHyqxLrUOwc0nwKDZg=;
        b=lfoedfgpPKqTdp+Bi4CfR3TLngUx+rgjXEmO1XUI0kUKFrd5kpE1684PiF+b7tijIv
         hZ//L6xU3FsLdGjlGgpHut3/JiYrTxbe63DYLiV5c8cWqtIP42xHa4cbjsCnAsKo+JdA
         o7ncZa+kxYApdu4pfRJGNc7PLIA7ebhckn+mdOAj1DArPymqQq1XUmPyjuM+Xg13j5B+
         trv5mWakvDNX/GDUun74mZF1yv8F2mqS9X7qRttRIXjX50YQgh+QCE/PSm6Nq6y6z/Nv
         cuqya5/yyx22E1OwemJJq20iW1TL60iFpsBNSVwziRKcjKtELGqFyml0YvoT1sXgVljg
         3i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSMECV3esitGF7SoTH5ZSvyrofHyqxLrUOwc0nwKDZg=;
        b=Eg+y/Fd5G+WAmGLGZmiUqRMV59XHSeWiXkRk0nfyztfjVSYMcEM0iKfUjxN/+YBSQ8
         vq0fURQq9QA/m+m0OodKnlL70jnqHkBReEYZQZdl9yHTpm9/NKWUQR5MleRfl5OQXnFT
         r48lM0fa3TuVIiqCr6zi4eEoOmdT8CdjHgJIlZOXw53JvppWz3g53D+kjQ/BIluil03n
         axjx7dhr6cKdA2LUVxbXXgRP9ReOjxp6TMXo55Xo9o2Xky+1CJj/PLDmx3aW5VGCJyZk
         3Uvm2rATKJwgg5IrNvnS/8QjYHLY3J8i3dqTo8afmuUlyCpvAhHEDBm2aPqEtm8lrY6X
         bEzA==
X-Gm-Message-State: AOAM532nyar5qWdHAbTdYQgxaoOeUdiEz2ho8ETpgJ/0r6bL/zjutCT0
        q4EeUlxBNp8LDnMLFoJKAnMpt+9VBSVoXFEKLIGxm9nWalwQew==
X-Google-Smtp-Source: ABdhPJzlVxghmhTq5y989GBcCRqNLVnFNeht1dy96750qJfRfAX21Yeiywv5LKrS/GnAgp+ZDxMbrz2I/MS970gNIuE=
X-Received: by 2002:a92:6511:: with SMTP id z17mr167202ilb.232.1611900476921;
 Thu, 28 Jan 2021 22:07:56 -0800 (PST)
MIME-Version: 1.0
References: <1611817983-2892-1-git-send-email-bingjingc@synology.com>
 <9e867a74-89c0-e0da-b166-e9824372e181@infradead.org> <6862f3e8-5eb6-4364-a05e-d4ad23d1d37d@Mail>
In-Reply-To: <6862f3e8-5eb6-4364-a05e-d4ad23d1d37d@Mail>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Fri, 29 Jan 2021 14:07:46 +0800
Message-ID: <CAMmgxWEm-yLzxjFrnvjjtDMtim2FDrqxJQucgs40nBSW6Hj_1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] parser: add unsigned int parser
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cccheng@synology.com, robbieko@synology.com,
        Matthew Wilcox <willy@infradead.org>,
        bingjingc <bingjingc@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

Thank you for talking to me the correct kernel-doc format. :)

I also split the cleanup of kernel doc comments into an independent
patch due to Jan's comments and submitted it. Thank you.

bingjingc <bingjingc@synology.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [loop bxxxjxxg@gmail.com] in order to reply in plain-text
> Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2021-01-29 05:26 =E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 1/27/21 11:13 PM, bingjingc wrote:
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > Will be used by fs parsing options & fix kernel-doc typos
> >
> > Reviewed-by: Robbie Ko<robbieko@synology.com>
> > Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> You should drop my Reviewed-by: also, until I explicitly
> reply with that.
>
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > ---
> >  include/linux/parser.h |  1 +
> >  lib/parser.c           | 44 +++++++++++++++++++++++++++++++++---------=
--
> >  2 files changed, 34 insertions(+), 11 deletions(-)
>
> The kernel-doc changes do look good. :)
>
> thanks.
> --
> ~Randy
>

Thanks,
BingJing
