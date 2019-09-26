Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69F4BF71E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfIZQut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 12:50:49 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39149 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZQut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:50:49 -0400
Received: by mail-yw1-f65.google.com with SMTP id n11so954868ywn.6;
        Thu, 26 Sep 2019 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI6RC3Inct0631A1o1WOoOjfgl/ixIhrcQv5jgmCiq4=;
        b=Y2kjBKQAVG7dYE9BZ0V3kBWqC7j0vBLWeTwoAcDdyq2fJHFOw2ajdO4CqMUsv9+L2P
         10ZKZlGLxzGpERbL3sDKqS7wx4bLmsOAOPgC+9xwVdgu4iIR0Q/hvMOSKqx4VJCfR8Y1
         u/jUzT5yOvok+Xq2jHcWqX2wzh4JrShTP670YW6fyzriBw0jXFO2PFa0ZxqLZpuUZv4q
         VhpnprD0icnPHTT9Cm5U0vwITZqLoVkpJ1wGdxVxydtejORVH+wv3JNkgWDLt79+N0kD
         Yp8KDsWyeCSCutqhtZkPrcggd6E1adj3D1b1IXbpXT8oWDKZVZIPoAORlUbMwnlMF90e
         Pz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI6RC3Inct0631A1o1WOoOjfgl/ixIhrcQv5jgmCiq4=;
        b=oaa68IYVkMaa24zqyOikUNwUZtu6Pfl0TTP3m4lL8ZsmvXVRrcKT99CsXWIR57mBJe
         kHbW0EeaL+fFFwUSjPCrTM3+9/gsAsKCacSawstDsk49eyH0Yw4rnmpKf2Qg148W4a3D
         xCkxjLjUqUtAIEuKro903ls61IacgpY9wXS3h0UwXbidOBrSE0Vl3zsAK5OE4uGep+Ug
         96Lee1Gg5A7NQVTfFp1lEdAv4W269N40hFI7pryeEcHaKU5KEO75enAP5JdZYmRz8e33
         NbTsidYvaUSJ/jKtwnV42bIFA6LC4tY1hv3pYjKfATzH9vB4gOsZfGIZK+ZUINoP43PZ
         irBw==
X-Gm-Message-State: APjAAAVOOJ/L1FywwvVUBMsTty/CRySqqkgPNQykSSx0vAtKbjOR70HV
        FS552nNk98qwQD1sQb0Bq3y2LNEL96C9De5zago=
X-Google-Smtp-Source: APXvYqwg/xY2N8drh8fC+vtaaiTMEFh4yHbgklJlsq/NLjm9JK2ZFceRxoGZZm0zLIoKmjIdEEbDC3Cum4tPBwO3Ako=
X-Received: by 2002:a81:6c8:: with SMTP id 191mr3323748ywg.181.1569516648028;
 Thu, 26 Sep 2019 09:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510> <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Sep 2019 19:50:36 +0300
Message-ID: <CAOQ4uxhpiLyhJ4Tu75V3yC7zjU5THw86V6FCbUC7bHC8RsyAEA@mail.gmail.com>
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
To:     Petr Vorel <pvorel@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 7:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 26, 2019 at 7:19 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi Darrick,
> >
> > > On Thu, Sep 26, 2019 at 05:56:08PM +0200, Petr Vorel wrote:
> > > > Hi Amir,
> >
> > > > I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
> > > > There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
> > > > ("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
> > > > These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?
> >
> > > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
>
> Started to return EXDEV?? quite the opposite.
> But LTP tests where already adapted to that behavior AFAICT:
> 15cac7b46 syscalls/copy_file_range01: add cross-device test
>
>
> > > > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.
> >
> > > I'm not Amir, but by my recollection, yes, those are intentional. :)
> > Thanks for a quick confirmation.
> >
>
> Which reminds me - I forgot to send the man pages patch out to maintainer:
> https://lore.kernel.org/linux-fsdevel/20190529174318.22424-15-amir73il@gmail.com/
>
> At least according to man page -EACCES is also possible.
>

But it looks like man page update is wrong.
I'll fix it and post.

Thanks,
Amir.
