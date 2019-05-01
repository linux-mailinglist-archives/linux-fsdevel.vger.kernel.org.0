Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2442410A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEAPeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:34:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45255 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEAPeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:34:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id b3so20315222qtc.12;
        Wed, 01 May 2019 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7BVof8zcWOlmgfoNNTzY2OrKwZHtJkNJJ/tVCOczZQ=;
        b=LJOCQpTuAOMonbbFd+HFYKhAdfAuYbz/YN7leE+vqtSDSU77hZTmtUm3kYo7OdSMgM
         bH+Uv1E5hNu61ylGEuBOy/k+G8bWfbgx1x4bt1RyzeeGPtU4wtJFqhNrbXKVLmh94P5W
         H3JUZA9DgRHA5jzjjyiyGIQ0AqNMI6bzImj/vOm9YVV4oR/FGuBfYGCrY5ue21OVzIdv
         oBsJuDbw1wtIi+98ifSfhjY4bQJVSklHmKuSmnCSGb3iwN/kbnqBhhGyP68b00fF+kuh
         9J7hQkjNfqRKZOp//X4aLOdG0KSktlZqMG5xgHHuyoM6+AgFw6h7NDcSqZqnr21zte0i
         lb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7BVof8zcWOlmgfoNNTzY2OrKwZHtJkNJJ/tVCOczZQ=;
        b=h/hTBNedrkrOUCYqYHNM3Hz5ikRud9Y+DDk9KA3nMGtuk0I72PxcfSox2YUZa/5B6a
         TIAxMHHCc27k+1JWAKABlAlEVBVc1qNN9CNHwvtdO4Pd520Dss19xU5PcugQWLqwEY53
         zWyIeyvFthmVU9JSOACAwQ0wd0LkykfHn53VJtAeZuS/mDnYIWszJNhcrMturReP1Z54
         Ofh/l3hhyvVBEqblpPl5XC/HMUtfu1PA044wJVUE2JGkjPQCrtVg3dH5IvVJjUrql8cn
         mGpoSlkYbz/qQFyLr2V/3K7b+uPFu+n1wVtXPwQUzq+jiDJ/rc23QoXyZBk1mcTIoyGE
         Q/dw==
X-Gm-Message-State: APjAAAVvSGkRn8x3AoslH4uKx+46P4aO/6Ul0habDp9qpxwuBQCZcrni
        C8aurwo4OEVDnI1mapL2N4kLUw96fo04gJGHxYQAd6f/
X-Google-Smtp-Source: APXvYqzROLS7CvGrZASPPcvG/dxihfU9bAmIpDLNRjhMKwZG33h79JY5/Yot97nB/NsbR3Hm3m6NGf/lJdTltx6q0ic=
X-Received: by 2002:ac8:25b8:: with SMTP id e53mr24425025qte.194.1556724849335;
 Wed, 01 May 2019 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220448.7219-1-gpiccoli@canonical.com> <CAPhsuW4k5zz2pJBPL60VzjTcj6NTnhBh-RjvWASLcOxAk+yDEw@mail.gmail.com>
 <b39b96ea-2540-a407-2232-1af91e3e6658@canonical.com>
In-Reply-To: <b39b96ea-2540-a407-2232-1af91e3e6658@canonical.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 1 May 2019 08:33:58 -0700
Message-ID: <CAPhsuW65EW8JgjE8zknPQPXYcmDhX9LEhTKGb0KHywqKuZkUcA@mail.gmail.com>
Subject: Re: [RFC] [PATCH V2 0/1] Introduce emergency raid0 stop for mounted arrays
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     axboe@kernel.dk, linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>, kernel@gpiccoli.net,
        NeilBrown <neilb@suse.com>, dm-devel@redhat.com,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, gavin.guo@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 3:41 PM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> > On 19/04/2019 14:08, Song Liu wrote:
> > [...]
> > I read through the discussion in V1, and I would agree with Neil that
> > current behavior is reasonable.
> >
> > For the following example:
> >
> > fd = open("file", "w");
> > write(fd, buf, size);
> > ret = fsync(fd);
> >
> > If "size" is big enough, the write is not expected to be atomic for
> > md or other drives. If we remove the underlining block device
> > after write() and before fsync(), the file could get corrupted. This
> > is the same for md or NVMe/SCSI drives.
> >
> > The application need to check "ret" from fsync(), the data is safe
> > only when fsync() returns 0.
> >
> > Does this make sense?
> >
>
> Hi Song, thanks for your quick response, and sorry for my delay.
> I've noticed after v4.18 kernel started to crash when we remove one
> raid0 member while writing, so I was investigating this
> before perform your test (in fact, found 2 issues [0]), hence my delay.
>
> Your test does make sense; in fact I've tested your scenario with the
> following code (with the patches from [0]):
> https://pastebin.ubuntu.com/p/cyqpDqpM7x/
>
> Indeed, fsync returns -1 in this case.
> Interestingly, when I do a "dd if=<some_file> of=<raid0_mount>" and try
> to "sync -f <some_file>" and "sync", it succeeds and the file is
> written, although corrupted.

I guess this is some issue with sync command, but I haven't got time
to look into it. How about running dd with oflag=sync or oflag=direct?

>
> Do you think this behavior is correct? In other devices, like a pure
> SCSI disk or NVMe, the 'dd' write fails.
> Also, what about the status of the raid0 array in mdadm - it shows as
> "clean" even after the member is removed, should we change that?

I guess this is because the kernel hasn't detect the array is gone? In
that case, I think reducing the latency would be useful for some use
cases.

Thanks,
Song

>
>
> > Also, could you please highlight changes from V1 (if more than
> > just rebase)?
>
> No changes other than rebase. Worth mentioning here that a kernel bot
> (and Julia Lawall) found an issue in my patch; I forgot a
> "mutex_lock(&mddev->open_mutex);" in line 6053, which caused the first
> caveat (hung mdadm and persistent device in /dev). Thanks for pointing
> this silly mistake from me! in case this patch gets some traction, I'll
> re-submit with that fixed.
>
> Cheers,
>
>
> Guilherme
>
> [0] https://marc.info/?l=linux-block&m=155666385707413
>
> >
> > Thanks,
> > Song
> >
