Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC74BD33B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfIXUCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:02:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41951 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfIXUCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:02:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id g13so2634138otp.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9abJ/1xoSxpgTwp+8HM2HUU0djE7WmuKLE9JBXrrZg=;
        b=tnF7bloc9weToXfl0j8qBvkiONR1e24XaVsByBxtm7vFIaj64Tgo06gjAhfgegfdK1
         zvnKsU/N6UUViGtxk3cdwSLa9EuP+rSS80XCHwWWpxnyYSeKmEXlV/4H1dfPLMrkiJ/m
         X9qgrqUhim7sHmqqNhIguJxj9cuBm8zSsfmy03kwtrEIT34i7kXXzRZXW44zqpuIFIQN
         jtglwIqZBrTZpndC43ho6Hk3zSV8IdCHQ5Z2Uv7IlEkMcp6rEmlEIojyuEZJLXHNAnfZ
         FV5wIZ0jiQBcSF02MLgrpULBumwYM7+PX240/Lm0yxcKfPiimMe4yyAU0IqqPUoMMTCf
         easQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9abJ/1xoSxpgTwp+8HM2HUU0djE7WmuKLE9JBXrrZg=;
        b=k+nXzJ5dsaYJVkDbW9dghI49Ke9mZ8avEi1sTW3auw5zHN0vL053ptOqpgGjYOB0Vf
         5ibneWHj2RSSkzbr7YDZGBDgVNwO1A8pt/PwaAD+N5RjsnEISHYwB5843xmOSwulqL+p
         VlMKfx+3uch65kFL+YTptTJkEKPVXOvPFxjTNXMWuEXD1WGqFPkdNISCLJX5W3tGcSJy
         PyB7twIa1GkHk8R590zMXhCXLOhDZQX6seQqUmDqJhdEYOj6MCqTAVS8ouodiItub/DY
         2XfIRBuBLQVOBFnscpvA1uIhiSqSuZ23wMO/4RJsrYYSq9qnnQBSqOJNNLylRIKpXpid
         FkJg==
X-Gm-Message-State: APjAAAXhChi+tbtPRtYs3lIF9EqoNwWlpoEC9wgVw/rmV0MZxH7mpd8S
        ykHuq2A401yWEGTz/S2DtYI8ZUMOG+I12knIyLH7PA==
X-Google-Smtp-Source: APXvYqzIUkFuP6L7NYPYMHrWVgtDQx1+8kwkK4qepjNPppu/5vycU49HkcYIljgKmIht1SEUi3auP0WGnP6hKm7fLnM=
X-Received: by 2002:a9d:7251:: with SMTP id a17mr3645461otk.110.1569355328313;
 Tue, 24 Sep 2019 13:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568875700.git.osandov@fb.com> <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader> <20190924193513.GA45540@vader>
In-Reply-To: <20190924193513.GA45540@vader>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Sep 2019 22:01:41 +0200
Message-ID: <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
To:     Omar Sandoval <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 9:35 PM Omar Sandoval <osandov@osandov.com> wrote:
> On Tue, Sep 24, 2019 at 10:15:13AM -0700, Omar Sandoval wrote:
> > On Thu, Sep 19, 2019 at 05:44:12PM +0200, Jann Horn wrote:
> > > On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > > Btrfs can transparently compress data written by the user. However, we'd
> > > > like to add an interface to write pre-compressed data directly to the
> > > > filesystem. This adds support for so-called "encoded writes" via
> > > > pwritev2().
> > > >
> > > > A new RWF_ENCODED flags indicates that a write is "encoded". If this
> > > > flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > > contains metadata about the write: namely, the compression algorithm and
> > > > the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> > > > must be set to sizeof(struct encoded_iov), which can be used to extend
> > > > the interface in the future. The remaining iovecs contain the encoded
> > > > extent.
> > > >
> > > > A similar interface for reading encoded data can be added to preadv2()
> > > > in the future.
> > > >
> > > > Filesystems must indicate that they support encoded writes by setting
> > > > FMODE_ENCODED_IO in ->file_open().
> > > [...]
> > > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > > > +                        struct iov_iter *from)
> > > > +{
> > > > +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > > > +               return -EINVAL;
> > > > +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > > > +               return -EFAULT;
> > > > +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > > > +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> > > > +               iocb->ki_flags &= ~IOCB_ENCODED;
> > > > +               return 0;
> > > > +       }
> > > > +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > > +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > > +               return -EINVAL;
> > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > +               return -EPERM;
> > >
> > > How does this capable() check interact with io_uring? Without having
> > > looked at this in detail, I suspect that when an encoded write is
> > > requested through io_uring, the capable() check might be executed on
> > > something like a workqueue worker thread, which is probably running
> > > with a full capability set.
> >
> > I discussed this more with Jens. You're right, per-IO permission checks
> > aren't going to work. In fully-polled mode, we never get an opportunity
> > to check capabilities in right context. So, this will probably require a
> > new open flag.
>
> Actually, file_ns_capable() accomplishes the same thing without a new
> open flag. Changing the capable() check to file_ns_capable() in
> init_user_ns should be enough.

+Aleksa for openat2() and open() space

Mmh... but if the file descriptor has been passed through a privilege
boundary, it isn't really clear whether the original opener of the
file intended for this to be possible. For example, if (as a
hypothetical example) the init process opens a service's logfile with
root privileges, then passes the file descriptor to that logfile to
the service on execve(), that doesn't mean that the service should be
able to perform compressed writes into that file, I think.

I think that an open flag (as you already suggested) or an fcntl()
operation would do the job; but AFAIK the open() flag space has run
out, so if you hook it up that way, I think you might have to wait for
Aleksa Sarai to get something like his sys_openat2() suggestion
(https://lore.kernel.org/lkml/20190904201933.10736-12-cyphar@cyphar.com/)
merged?
