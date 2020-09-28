Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2869827B3DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 20:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1SAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1SAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:00:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F8C061755;
        Mon, 28 Sep 2020 11:00:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 133so1554949ybg.11;
        Mon, 28 Sep 2020 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omNyM76XmDgvZI+KFxBjmJZIpbDw6eudETNMcRJNaF4=;
        b=PwwBtybD8u7cc2QuGRUBVe+E6rm2zwriwnzjCwSK5KpwuQ+zb90p+U+BiY3Vexv+i/
         LD2oEBC/Oyctv3/yDEdyopDnQ2WgHvsm7Ib52lRldRYyCMYaApx+q5dBERupkkTM/N0L
         betOAyChddISzg3/oBEDmb4ne28X63YzPkhN3uu9BEpHH24DSQVRQTydxViXyKncwJnj
         96pnR1d3QPa7627H6mqB9jN93HsBW/jgZQmOD+vVNPzj8kIzsNKSCsfWWt1Ihsl8nW47
         aQLumJpvtN70zdNC04aNdYFeVYtewC44VrkLoB0mJMsGZtNVnrCIF2wawLCn4uz3uGcq
         M8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omNyM76XmDgvZI+KFxBjmJZIpbDw6eudETNMcRJNaF4=;
        b=BRwl6SquhbzgIUBXYDaFSgVRrS4o3iVu+uwgNpmrP0cMIe1jm3VF27B39yDqa3b02O
         D7I9huCqPjgJfyeiaTciEzZOTIRuO7k3+3vZlgRBy7ZkPqC0mnpwp65lFFr0g4jbQT+3
         N/geGiNYQ77OGQmKQ9d0UF0I9Cxp/ohknH95fwj6aN8x0DQ9wsruBJPDmKIrezLR8ff6
         EekF1IhSRj7lUaotcI4lMkn8Z03bZ7zocQL/2vXS1+25aaq7e/bbo46MoZ3WCb9u3uMp
         2VTnwszLzPmaI3+fSNyfbQYQyoyRJyIbkq13XcEif0/X+4jiQePlyFXOxYU7DT1/ROh4
         0u6g==
X-Gm-Message-State: AOAM531HxLsEHo5NrkauaYL3KeWSF6+1kxrogH3qYftaOnpQmK9dOeiA
        PJP/JX2+CISztHJPg4VnZpoL/rgd7D1jwG9F41Y=
X-Google-Smtp-Source: ABdhPJzOzXBoYu4VzeV9BpEDZjaRR8f8pTg/OWvKh7sMINKkbWrnzr3Ks1gkqJTIdeTPEXXJv5KxhMrcUc9Ukhda9T4=
X-Received: by 2002:a25:5088:: with SMTP id e130mr1189164ybb.234.1601316015701;
 Mon, 28 Sep 2020 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACE9dm_eypZ4wn8PpYYCYNuM501_M-8pH7by=U-6hOmJCwuxig@mail.gmail.com>
 <87bb66c2a7f94bd1ab768a8160e48e39@AcuMS.aculab.com>
In-Reply-To: <87bb66c2a7f94bd1ab768a8160e48e39@AcuMS.aculab.com>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Mon, 28 Sep 2020 21:00:54 +0300
Message-ID: <CACE9dm8CPAFSY53Bm+vJvmh2m=Nm0FDe1mCtrwFAQnDE1p-XVw@mail.gmail.com>
Subject: Re: Mount options may be silently discarded
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 28, 2020 at 5:36 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Dmitry Kasatkin
> > Sent: 28 September 2020 15:03
> >
> > "copy_mount_options" function came to my eyes.
> > It splits copy into 2 pieces - over page boundaries.
> > I wonder what is the real reason for doing this?
> > Original comment was that we need exact bytes and some user memcpy
> > functions  do not return correct number on page fault.
> >
> > But how would all other cases work?
> >
> > https://elixir.bootlin.com/linux/latest/source/fs/namespace.c#L3075
> >
> > if (size != PAGE_SIZE) {
> >        if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
> >             memset(copy + size, 0, PAGE_SIZE - size);
> > }
> >
> > This looks like some options may be just discarded?
> > What if it is an important security option?
> >
> > Why it does not return EFAULT, but just memset?
>

> The user doesn't supply the transfer length, the max size
> is a page.
> Since the copy can only start to fail on a page boundary
> reading in two pieces is exactly the same as knowing the
> address at which the transfer started to fail.
>
> Since the actual mount options can be much smaller than
> a page (and usually are) zero-filling is best.
>

Hi David,

Ok. This is now obvious that it is done for "proper" memseting...

But why "we" should allow "discarding" failed part instead of failing
with EFAULT as a whole?

Thanks,

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Thanks,
Dmitry
