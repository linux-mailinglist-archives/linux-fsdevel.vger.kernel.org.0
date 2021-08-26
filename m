Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684373F8205
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhHZF0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 01:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhHZF0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 01:26:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF81C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 22:25:22 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e18so1391783qvo.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 22:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKBrxUM2uN+IW3IWdkU6xesjnbdKzY4oE1V74/9Tmrc=;
        b=FrxgrA4kx0uCin5xJlNpb5BNuooEjN8Gf/gA5Hrw+viPxRregGfEVcpgcCJRv1cEx8
         7EAAuYSk8rz51YRKGQY+kmQ1L9MdFfbNtINbhS2Hy+MiT8tqBecVf4Lbqy5KoZW9ZPkH
         bgkLL98rqDNJInfkJ2z/AlfsrcvNRf4y4QS0S0OMNbi7wYfV1Bno8Vp3D8Ma4go2t4m3
         OxmamTA4b9RtyTav1eXIXM1YgWLROWoZH2Q+I+3TuuoHG6Bhi9t9FB+u4d77ppXIWwdS
         eujkTblKNhqrlfUNdS9AyzgISZFalU15vgPaOfzce/6gsFwf/JVz836JMPSwjO1gCyRP
         jz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKBrxUM2uN+IW3IWdkU6xesjnbdKzY4oE1V74/9Tmrc=;
        b=JrA85IIj4mBHoCrw61zff6v2HUeOMLnJL52pwd8nZiqBmPbyGY1VzFF6IqxJGqn+Vf
         avzbxAt6USFvWgmWnlEpqJtlXChrx7r/6ktT1iXZHlOKDWU09bISeiB9yEkbGQHGDGRL
         YJDJE6ArgwFn+gHorWhmVnzSzKvlfMPjSgVi10RxQP3IQ8pviRPapQmQIJfUEcDx+kuk
         A3i1ZGsf+aXin0o8TJ9sur4zygemnB3Y30IyiiH5yEH/sCGv0PsGYn/ByxWa02oOp1Ga
         ck6HFjr699njSWASOQT2ESbbqNpJBVxLzdl0yK/mM1V9E5KmcsjN/CZZY6eVcp6JLxab
         Rs0A==
X-Gm-Message-State: AOAM5321iN4kKCNGGGvIbC44NkKVENj9mMZFIVmrNa+f0qtE+dUyKMQ2
        UFMCWcNrctvxLyEE4fjlcpa+02vrCoQgEC+o4pN6jiFZoc8UkSNv
X-Google-Smtp-Source: ABdhPJxgI91eLsC43ltFWf2RKcoGW2R8le8/fC7RJC+XLVAY/f59vTWKnjGIMIjoVP4SyDEpn2lObcHr/kV/Rj3TIcc=
X-Received: by 2002:a05:6214:ca2:: with SMTP id s2mr2340671qvs.35.1629955521528;
 Wed, 25 Aug 2021 22:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210826031451.611-1-adrianhuang0701@gmail.com> <eb28d8e8-3e7d-0120-a1a7-6e43b0bb05bb@infradead.org>
In-Reply-To: <eb28d8e8-3e7d-0120-a1a7-6e43b0bb05bb@infradead.org>
From:   Huang Adrian <adrianhuang0701@gmail.com>
Date:   Thu, 26 Aug 2021 13:25:10 +0800
Message-ID: <CAHKZfL1H2LKnOw1EfNA-xri0EPDF-hYwXa1u_39ttoMZHvSOGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] exec: fix typo and grammar mistake in comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/25/21 8:14 PM, Adrian Huang wrote:
> > From: Adrian Huang <ahuang12@lenovo.com>
> >
> > 1. backwords -> backwards
> > 2. Remove 'and'
>
>    3. correct the possessive form of "process"
>
> >
> > Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> > ---
> >   fs/exec.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 38f63451b928..7178aee0d781 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -533,7 +533,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
> >               if (!valid_arg_len(bprm, len))
> >                       goto out;
> >
> > -             /* We're going to work our way backwords. */
>
> That could just be a pun. Maybe Al knows...

Another comment in line 615 has the same sentence with 'backwards'.
(https://github.com/torvalds/linux/blob/master/fs/exec.c#L615).

So, one of them should be corrected.

>
> > +             /* We're going to work our way backwards. */
> >               pos = bprm->p;
> >               str += len;
> >               bprm->p -= len;
> > @@ -600,7 +600,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
> >   }
> >
> >   /*
> > - * Copy and argument/environment string from the kernel to the processes stack.
> > + * Copy argument/environment strings from the kernel to the processe's stack.
>
> Either process's stack or process' stack. Not what is typed there.
> I prefer process's, just as this reference does:
>    https://forum.wordreference.com/threads/process-or-processs.1704502/

Oh, my bad. I should have deleted the letter 'e'. Thanks for this.

After Al confirms 'backwords', I'll also change "processes's" to
"process's" in v2.
(https://github.com/torvalds/linux/blob/master/fs/exec.c#L507)

> >    */
> >   int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
> >   {
> >
>
>
> --
> ~Randy
>
