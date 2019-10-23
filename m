Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E949E25E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407638AbfJWV4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 17:56:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407604AbfJWV4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:56:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so23171550wrt.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Z2J+OCsJ9J8GYRYP9VQk8i6HI7mT3NHckK0lvlxuI4=;
        b=l6bwIwJ3biJkrPmNiuGo80Nm0jZey9kll9szDwNec9TDA59C2XDR1D84O8dbnkbDMP
         u1Q8evbum0reaA/9R3fDw8lDb2N/SK5e3x0Gekj+qhlkLpmKTcNwZQ5Cn8J5o/+NCaQi
         rVwk+A5DRDgXw1JMOxFoiliUG57vjl9u+jJGMiqYZzaU+Zzuz13A1G1XsMKlJKO647M2
         IvHFnroigX1S9Yab9xb6LoeziUH/s4MV26h8MEDKcqaynEPWHRlrAYpibRLKm5qA7NjF
         au8m5gOGHn2w25JzMJ27sGjXCyEmVJriyprvIHvYPAWVmKO3jY5TkvTlsK9kcL7bja2U
         c1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Z2J+OCsJ9J8GYRYP9VQk8i6HI7mT3NHckK0lvlxuI4=;
        b=jYeSEvWFM81DaM58CR/Enn6rhbNGOlpYzua+ewAbBy1ljL+fa/puG8eo7sZ9FQVds+
         B50C9YNZCqhWEvnbAJ9v4KMBABk27ZUEoAza3sl6yMSqEktS693/rUq/cws0BmUwnvjj
         OcQg4BgisLgB6+hdMY5hPOfuGFslk4j6a9GnO0uynKIfaj9zV1xMCoqPEcYbbo2AMsMb
         4Fbd8UBU+V7HWhuv3At6VmgAgRlhbTYuSaTw/pmYohXzpNR0f+4wnMywZfegnqxdwkKB
         Nyux2Uz6RAY07ZoNoa6kVtRCJhtJ7gzlYhaIndNiB8bPaDJvTc19kbNlLJjyfTDd/uTl
         BTxw==
X-Gm-Message-State: APjAAAWJ3EgIqeWdLJaNvCRZwKdgaNCMvzTRF3gT75T4sVInaNyS16ck
        jBJ8zASI6Vr7G2gO85MDYMI2YJp3qm+86kMgSsI4pg==
X-Google-Smtp-Source: APXvYqw+N6XxHFJDmHNhiFTSaQvHQjQ7L+pa4/p8ZF0PEanBE5Mz8rq8OKZTnCkJfGg3xZZ3BDAOBmNR7FLJ6toT+mU=
X-Received: by 2002:a5d:6281:: with SMTP id k1mr769702wru.69.1571867792739;
 Wed, 23 Oct 2019 14:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
In-Reply-To: <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 23 Oct 2019 23:56:12 +0200
Message-ID: <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:21 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Wed, Oct 23, 2019 at 7:16 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> > On Wednesday 23 October 2019 16:21:19 Chris Murphy wrote:
> > > On Wed, Oct 23, 2019 at 1:50 PM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > > I do not think that kernel guarantee for any filesystem that rename
> > > > operation would be atomic on underlying disk storage.
> > > >
> > > > But somebody else should confirm it.
> > >
> > > I don't know either or how to confirm it.
> >
> > Somebody who is watching linuxfs-devel and has deep knowledge in this
> > area... could provide more information.
>
> This is filesystem specific.
> For example on UBIFS we make sure that the rename operation is atomic.
> Changing multiple directory entries is one journal commit, so either it h=
appened
> completely or not at all.
> On JFFS2, on the other hand, rename can degrade to a hard link.
>
> I'd go so far and claim that any modern Linux filesystem guarantees
> that rename is atomic.

Any atomicity that depends on journal commits cannot be considered to
have atomicity in a boot context, because bootloaders don't do journal
replay. It's completely ignored.

If a journal is present, is it appropriate to consider it a separate
and optional part of the file system? I don't know for sure but I can
pretty much guess any of the bootloader upstreams would say: we are
not file system experts, if file system developers consider the
journal inseparable from the file system, and that journal replay is
non-optional when indicated that it should be performed, then we
welcome patches from file system developers to add such support in
bootladers X, Y, and Z.

And having already asked about bootloaders doing journal replay on XFS
list, and maybe a while ago on ext4 list (I forget) that was sorta
taken as a bit of comedy. Like, how would that work? And it'd
inevitably lead to a fork in journal replay code. Possibly more than
one to account for the different bootloader limitations and memory
handling differences, etc. So it's not very realistic. Probably. And
more realistic if they aren't separable is, if you care about atomic
guarantees for things related to bootloading, don't use journaled file
systems. Proscribed.

Which is why this thread exists to see what can be done about FAT
since it's really the only file system we have to be able to boot
from.

---
Chris Murphy

--=20
Chris Murphy
