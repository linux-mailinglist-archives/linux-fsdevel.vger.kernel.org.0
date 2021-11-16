Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9A453967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhKPSdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 13:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhKPSdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:33:22 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C1C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 10:30:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z26so27323110iod.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ed9/wZVymYnnYiojIGZwOevyoY+M/yDNEGjdzPGY4jE=;
        b=VY3ESefFkzkKJks43mBrEZ8vXoQfKmDKjGbviMx0MI/hBK/0XRabaGRDX7L1pa4dms
         s2AtyfhTO2q69pbQdUslGjD/867B2uQiemR1wZb7pynLRhCz/FQYuXUUl6H8SBQQNnM6
         JfeReamqCq/5xZdkXVSy9Wc7vWXTkps4dFIuRE1SqxxebFSbxmoPWhRs1cKEmltI+yD/
         ibLeC/Lj23g6Uu/3KsKWtfecrbwOIqUyhBdCVWrvUBM2S585nmq/ltHFadqxvU2eeBB3
         ufv5EYtircGUaUCqQBb7MWI+GS6snTYNhA+3ZXTcWJ9XYpRZ+wJhXnpmVI+GkYQcMHnd
         4UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ed9/wZVymYnnYiojIGZwOevyoY+M/yDNEGjdzPGY4jE=;
        b=PnUKb9t5Nje9xN/CC33pg1A2VWPfysMrWhtfoH02kJUOWNh7GJDK4fNlJqn58yUdjN
         O0QXo48EGWr2eA9rR61R2+Wpx1Lz+IJZ3f3M/S/qN0PykX8bv/Dfp6oTrhU8vQ41yHJd
         vFH9qqq67WhVxi4G9aQYM+OLkjGhEM/MTBFx1XoHsepi7hX9+nNl4J4eXML3sov/5d7d
         ik5HVHzZFf6T10no3e4Q8fteIBobMVXGghtElaGi0ihbbQ6GiAZFZPy/tAyR1XuQmMk4
         o5OWqbYIrkRr+4Xq+l5OtAlqh57xS3YHUx+LW85ZjhvMfMHPZeZjkXROm6+Our9h5Fvs
         tY+g==
X-Gm-Message-State: AOAM5318eZYB5Skweeu6rvKXufjMYNqBIbvqii2XEhzXNvHdKNHJmRW9
        0KeDi5wEwVUY5uVzRRmDjBT9q6/vZdhZXY+ujYU=
X-Google-Smtp-Source: ABdhPJwRna+jxHioqu2rQsyIa2Byla1Fy1OOJLVVJdNcTc4kRSglStshi0dWFPkAuUo/3759QG8v6R9WgX1Z1T8c9j0=
X-Received: by 2002:a02:c78e:: with SMTP id n14mr7288308jao.40.1637087424786;
 Tue, 16 Nov 2021 10:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20211116114516.GA11780@kili> <CAOQ4uxhHzoK=MU4Toc3uQSk5HZLZia0=DBBkC2L1ZeVVLTLGXw@mail.gmail.com>
 <20211116175709.GJ27562@kadam> <20211116180146.GK27562@kadam>
In-Reply-To: <20211116180146.GK27562@kadam>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Nov 2021 20:30:13 +0200
Message-ID: <CAOQ4uxjwEp8f-4cnXiFQMuAYr=W+G2jKXDCFFd_BhCYWLehn+g@mail.gmail.com>
Subject: Re: [bug report] fanotify: record name info for FAN_DIR_MODIFY event
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 8:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 16, 2021 at 08:57:09PM +0300, Dan Carpenter wrote:
> > On Tue, Nov 16, 2021 at 05:21:34PM +0200, Amir Goldstein wrote:
> > > On Tue, Nov 16, 2021 at 1:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > Hello Amir Goldstein,
> > > >
> > > > The patch cacfb956d46e: "fanotify: record name info for
> > > > FAN_DIR_MODIFY event" from Mar 19, 2020, leads to the following
> > > > Smatch static checker warning:
> > > >
> > > >         fs/notify/fanotify/fanotify_user.c:401 copy_fid_info_to_user()
> > > >         error: we previously assumed 'fh' could be null (see line 362)
> > > >
> > > > fs/notify/fanotify/fanotify_user.c
> > > >     354 static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> > > >     355                                  int info_type, const char *name,
> > > >     356                                  size_t name_len,
> > > >     357                                  char __user *buf, size_t count)
> > > >     358 {
> > > >     359         struct fanotify_event_info_fid info = { };
> > > >     360         struct file_handle handle = { };
> > > >     361         unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
> > > >     362         size_t fh_len = fh ? fh->len : 0;
> > > >                                 ^^^^^^^^^^^^^
> > > > The patch adds a check for in "fh" is NULL
> > > >
> > > >     363         size_t info_len = fanotify_fid_info_len(fh_len, name_len);
> > > >     364         size_t len = info_len;
> > > >     365
> > > >     366         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
> > > >     367                  __func__, fh_len, name_len, info_len, count);
> > > >     368
> > >
> > > Upstream has these two lines:
> > >        if (!fh_len)
> > >                 return 0;
> > >
> > > Which diffuses the reported bug.
> > > Where did those lines go?
> >
> > I'm not sure, I suspected this might be a merge issue.
>
> Oh, duh.  I'm using linux-next.  Probably that's relevant information.
>

I may be missing something, but I don't see any diff between
linus and linux-next in that file and I don't know any version of that
file in history where this check or another version of it is missing???

Thanks,
Amir.
