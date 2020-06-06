Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD531F071B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgFFOnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgFFOnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:43:52 -0400
X-Greylist: delayed 41542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Jun 2020 07:43:52 PDT
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E44C03E96A;
        Sat,  6 Jun 2020 07:43:52 -0700 (PDT)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id F063E83B79;
        Sat,  6 Jun 2020 14:43:48 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49fMhh5MVXz44cv;
        Sat,  6 Jun 2020 14:43:48 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
        (Authenticated sender: kevans)
        by smtp.freebsd.org (Postfix) with ESMTPSA id B300126DA6;
        Sat,  6 Jun 2020 14:43:48 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: by mail-qt1-f172.google.com with SMTP id k22so11101560qtm.6;
        Sat, 06 Jun 2020 07:43:48 -0700 (PDT)
X-Gm-Message-State: AOAM532xnNedebAQiT1QeIf61vEi/zG7DEKaReBR5H/TbNGkaUAne1D1
        JgZW1vw2gcw4Ot3+l2nb/iv65B4vulWaESgP/fg=
X-Google-Smtp-Source: ABdhPJw5u2OzhTuoEP5vvDbcC8qGZRAnK6u13FsA//yzZMuHUjWOvqQmor8sq+9BcYt9S/T/OrufE9pQ/lYAXA8t/Aw=
X-Received: by 2002:aed:3169:: with SMTP id 96mr14649066qtg.211.1591454628260;
 Sat, 06 Jun 2020 07:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com> <20200605145549.GC673948@port70.net>
 <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com> <20200606115537.GB871552@port70.net>
In-Reply-To: <20200606115537.GB871552@port70.net>
From:   Kyle Evans <kevans@freebsd.org>
Date:   Sat, 6 Jun 2020 09:43:36 -0500
X-Gmail-Original-Message-ID: <CACNAnaEBgTspsw-yq2gc-9a0+tVfnx+g2z6RH5G6LwPYhaBNXA@mail.gmail.com>
Message-ID: <CACNAnaEBgTspsw-yq2gc-9a0+tVfnx+g2z6RH5G6LwPYhaBNXA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] open: add close_range()
To:     Szabolcs Nagy <nsz@port70.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Victor Stinner <victor.stinner@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 6, 2020 at 6:55 AM Szabolcs Nagy <nsz@port70.net> wrote:
>
> * Kyle Evans <kevans@freebsd.org> [2020-06-05 21:54:56 -0500]:
> > On Fri, Jun 5, 2020 at 9:55 AM Szabolcs Nagy <nsz@port70.net> wrote:
> > > this api needs a documentation patch if there isn't yet.
> > >
> > > currently there is no libc interface contract in place that
> > > says which calls may use libc internal fds e.g. i've seen
> > >
> > >   openlog(...) // opens libc internal syslog fd
> > >   ...
> > >   fork()
> > >   closefrom(...) // close syslog fd
> > >   open(...) // something that reuses the closed fd
> > >   syslog(...) // unsafe: uses the wrong fd
> > >   execve(...)
> > >
> > > syslog uses a libc internal fd that the user trampled on and
> > > this can go bad in many ways depending on what libc apis are
> > > used between closefrom (or equivalent) and exec.
> > >
> >
> > Documentation is good. :-) I think you'll find that while this example
> > seems to be innocuous on FreeBSD (and likely other *BSD), this is an
> > atypical scenario and generally not advised.  You would usually not
> > start closing until you're actually ready to exec/fail.
>
> it's a recent bug https://bugs.kde.org/show_bug.cgi?id=420921
>
> but not the first closefrom bug i saw: it is a fundamentally
> unsafe operation that frees resources owned by others.
>

Yes, close() is an inherently unsafe operation, and they managed this
bug without even having closefrom/close_range. I'm not entirely
convinced folks are going to spontaneously develop a need to massively
close things just because close_range exists. If they have a need,
they're already doing it with what they have available and causing
bugs like the above.

> > > > The code snippet above is one way of working around the problem that file
> > > > descriptors are not cloexec by default. This is aggravated by the fact that
> > > > we can't just switch them over without massively regressing userspace. For
> > >
> > > why is a switch_to_cloexec_range worse than close_range?
> > > the former seems safer to me. (and allows libc calls
> > > to be made between such switch and exec: libc internal
> > > fds have to be cloexec anyway)
> > >
> >
> > I wouldn't say it's worse, but it only solves half the problem. While
> > closefrom -> exec is the most common usage by a long shot, there are
> > also times (e.g. post-fork without intent to exec for a daemon/service
> > type) that you want to go ahead and close everything except maybe a
> > pipe fd that you've opened for IPC. While uncommon, there's no reason
> > this needs to devolve into a loop to close 'all the fds' when you can
> > instead introduce close_range to solve both the exec case and other
> > less common scenarios.
>
> the syslog example shows why post-fork closefrom without
> intent to exec does not work: there is no contract about
> which api calls behave like syslog, so calling anything
> after closefrom can be broken.
>

I think that example shows one scenario where it's not safe, that's
again in firmly "don't do that" territory. You can close arbitrary fds
very early or very late, but not somewhere in the middle of an even
remotely complex application. This problem exists with or without
close_range.

Like I said before, this is already done quite successfully now, along
with other not-even-forked uses. e.g. OpenSSH sshd will closefrom()
just after argument parsing:
https://github.com/openbsd/src/blob/master/usr.bin/ssh/sshd.c#L1582

> libc can introduce new api contracts e.g. that some apis
> don't use fds internally or after a closefrom call some
> apis behave differently, if this is the expected direction
> then it would be nice to propose that on the libc-coord
> at openwall.com list.
>

I suspect it's likely better to document that one should close
arbitrary fds very early or very late instead. Documenting which APIs
are inherently unsafe before/after would seem to be fraught with peril
-- you can enumerate what in libc is a potential problem, but there
are other libs in use by applications that will also use fds
internally and potentially cause problems, but we can't possibly raise
awareness of all of them. We can, however, raise awareness of the
valid and incredibly useful use-cases.

> > Coordination with libc is generally not much of an issue, because this
> > is really one of the last things you do before exec() or swiftly
> > failing miserably. Applications that currently loop over all fd <=
> > maxfd and close(fd) right now are subject to the very same
> > constraints, this is just a much more efficient way and
> > debugger-friendly way to accomplish it. You've absolutely not lived
> > life until you've had to watch thousands of close() calls painfully
> > scroll by in truss/strace.
>
> applications do a 'close all fds' operation because there
> is no alternative. (i think there are better ways to do
> this than looping: you can poll on the fds and only close
> the ones that didnt POLLNVAL, this should be more portable
> than /proc, but it's besides my point) optimizing this
> operation may not be the only way to achive whatever those
> applications are trying to do.

In most cases, those applications really are just trying to close all
fds other than the ones they want to stick around. Polling the fds
before trying to close them would just *double* the current problem
without fixing your other concern at all -- you still can't arbitrary
close open fds without understanding their provenance, and now you've
doubled the number of syscalls required just to close what you don't
need.

fdwalk() + close() is an (IMO) great alternative that's even more
flexible, but that still has its own problems.

Thanks,

Kyle Evans
