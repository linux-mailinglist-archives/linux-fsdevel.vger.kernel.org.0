Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8412271F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLQIzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 03:55:01 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:55:00 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXop2-1iBKX82BI4-00YBbm; Tue, 17 Dec 2019 09:54:58 +0100
Received: by mail-qk1-f171.google.com with SMTP id x129so174943qke.8;
        Tue, 17 Dec 2019 00:54:58 -0800 (PST)
X-Gm-Message-State: APjAAAXNG2+9NUH4Fcy7Or18esGaQdcU/0HUKwazUmvLn9WIJropDTPy
        znb/Iw88weMWhDetMx/fRco63HDyaVmLehppnTA=
X-Google-Smtp-Source: APXvYqzKiLsbZVrfvGk9+cg1ubafjtbflqD9p/VamlqKp16D5EdmeX1UgRWAb1NnN5heyvsziKaivNRpaH1iYITOlvM=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr3750201qkh.3.1576572897205;
 Tue, 17 Dec 2019 00:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
 <20191217015001.sp6mrhuiqrivkq3u@wittgenstein> <CAMp4zn8fzeiJVSn6EtRi6UAGh6AL3QWu=PZxw+=TAYJORjn_Sw@mail.gmail.com>
In-Reply-To: <CAMp4zn8fzeiJVSn6EtRi6UAGh6AL3QWu=PZxw+=TAYJORjn_Sw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 09:54:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3G-W8s0G2-XKuDw9dRmupZSyiF6FRRAnvDt9=kMMzS8w@mail.gmail.com>
Message-ID: <CAK8P3a3G-W8s0G2-XKuDw9dRmupZSyiF6FRRAnvDt9=kMMzS8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, Florian Weimer <fweimer@redhat.com>,
        jld@mozilla.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HRAACjC5zp8lxNpo/BksdLlwiLLHqEgHh0jsn+k4S+2Eh5Uv53p
 C9bFh5wXL+Ju5zWDstGOtRlYMtrjwfZ8garW/jHChtuDow7fI3r16tRRGedKQpUV3L18ETu
 yI1dmiiZG89YnQ/Uh+YEoa6qfcpPzo5agoss9tX7MfCVL13uPPYcSa0HevOPwcq5CO2DeV+
 rvBWzQVDBrRIzj8OofEEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ewGeybDoAh4=:QfLyBhyd5Jll7i1z3Q7vNn
 1kgevxEMDqrLzxfQVkK9qVir47KyAfs1CrUroOSId9jmjVWLXxIR417SaAm9fCsrUDNkshAhl
 JCZicW9jpmJ3wUnMCnvWGavQYEK9pFw/FLcKckTHs9Hz7SfzKkRT5oEUP55T6ucuenLlLgds7
 xJvOgc1Wf5MryhB0Hq3+1cOZHgZ/wwkSU9L3SpvoLYABbzHNn7pvMYkJkb7K9TJdT21krgD4Y
 4YFZAI0veXXh1COcA/JwwHg9SpoXBr+Yk7PldiIiBOyya6NooxZn56uywBuXQ6ksU/I+wsgs1
 mXHGQ/J9oqSook9Fg2c7xDeSja55fq6mE/On0sj5Xb3MhoRbtLPUkuupUrqBhewpgxdA/zOFr
 rTGYOniuUQI5kd8T2WyoOTaFuQS/Afe3mOjQiVDqmS7cO6qgZiFUygRFq17sHHiNmRaDxmBSD
 MZ/VOMCKA/+xjvZrJBjvT4DOWPjBQl1cdMIwBVAJQf0R4OaF/xcHR3BAO1qDH3txyVLLcVuaI
 2li9HRDNuK/pMBIAfUvb3L0bAEFbSzc0Zhtb4ZpJDhBspN/wR+lC2iuUIwQzL9LJ//9unnxYt
 sABx7gtMdv0SIU4KKQOkIp56VK3TtLCp9/HnH0TAT1eQ6kPn1JH7ByaUwCjwec1ryzvHReOBh
 n97qVTTU5W8sKOoEBgTQqGiQ4FISnzK+ltko21PTuCwrzjTfT91EwGSlVDT+8rUA/HZCYymid
 2d2sgCkAeALEf4JQHena2ky5zu/87i2wNp1NVICd8drY72i6S4D6JnhFp5MYM84fGjfOzUDEF
 HBM8RGxK0atTnFC1BPpEgvRmKOjfFlQSyvojNuFxv29a6cF044YHkdodF7e49TgFCyu6Q9mpk
 B2dCO8sC42gON0AMrVGg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 3:50 AM Sargun Dhillon <sargun@sargun.me> wrote:
> On Mon, Dec 16, 2019 at 5:50 PM Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/ioctl.h>
> > > +
> > > +/* options to pass in to pidfd_getfd_args flags */
> > > +#define PIDFD_GETFD_CLOEXEC (1 << 0) /* open the fd with cloexec */
> >
> > Please, make them cloexec by default unless there's a very good reason
> > not to.
> >
> For now then, should I have flags, and just say "reserved for future usage",
> or would you prefer that I drop flags entirely?

There is no need for adding reserved fields in an ioctl, just add a new ioctl
number if you need it later.

> > > +
> > > +struct pidfd_getfd_args {
> > > +     __u32 size;             /* sizeof(pidfd_getfd_args) */
> > > +     __u32 fd;       /* the tracee's file descriptor to get */
> > > +     __u32 flags;
> > > +};
> >
> > I think you want to either want to pad this
> >
> > +struct pidfd_getfd_args {
> > +       __u32 size;             /* sizeof(pidfd_getfd_args) */
> > +       __u32 fd;       /* the tracee's file descriptor to get */
> > +       __u32 flags;
> >         __u32 reserved;
> > +};
> >
> > or use __aligned_u64 everywhere which I'd personally prefer instead of
> > this manual padding everywhere.

No, don't make ioctl structures extensible. If there is no 64-bit member
in it, 32-bit alignment is sufficient.

Also, having implicit padding is dangerous because it makes it easier to
leave it uninitialized, leaking kernel stack information on the copy_to_user().

Please drop the '__u32 size' argument, too: the size is fixed by definition
(through the _IOWR macro) and if you need to extend it you get a new
command anyway.

> Wouldn't __attribute__((packed)) achieve a similar thing of making sure
> the struct is a constant size across all compilers?
>
> I'll go with __aligned_u64 instead of packed, if you don't want to use packed.

__attribute__((packed)) is worse because it forces compilers to use byte
access on architectures that have no fast unaligned 32-bit load/store.
Basically you should never put __packed on a structure, but instead add
it to members that need to be unaligned within a sturct for compatibility
reasons.

> > > +
> > > +#define PIDFD_IOC_MAGIC                      'p'
> > > +#define PIDFD_IO(nr)                 _IO(PIDFD_IOC_MAGIC, nr)
> > > +#define PIDFD_IOR(nr, type)          _IOR(PIDFD_IOC_MAGIC, nr, type)
> > > +#define PIDFD_IOW(nr, type)          _IOW(PIDFD_IOC_MAGIC, nr, type)
> > > +#define PIDFD_IOWR(nr, type)         _IOWR(PIDFD_IOC_MAGIC, nr, type)

Drop these macros, they just make it harder to grep or script around the use
of _IOWR/_IOR/_IOW

> > > +#define PIDFD_IOCTL_GETFD            PIDFD_IOWR(0xb0, \
> > > +                                             struct pidfd_getfd_args)

Without the size and flag members, this can become the simpler

#define PIDFD_IOCTL_GETFD  _IOWR('p', 0xb0, __u32)

> > > +
> > >  const struct file_operations pidfd_fops = {
> > >       .release = pidfd_release,
> > >       .poll = pidfd_poll,
> > > +     .unlocked_ioctl = pidfd_ioctl,

This needs

+    .compat_ioctl = compat_ptr_ioctl,

To work on compat tasks.

Finally, there is the question whether this should be an ioctl
operation at all, or
if it would better be done as a proper syscall. Functionally the two
are the same
here, but doing such a fundamental operation as an ioctl doesn't feel
quite right
to me. As a system call, this could be something like

int pidfd_get_fd(int pidfd, int their_fd, int flags);

along the lines of dup3().

        Arnd
