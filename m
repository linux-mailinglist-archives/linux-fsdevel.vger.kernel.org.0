Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5C487F06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 23:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiAGWkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 17:40:39 -0500
Received: from mx.cs.msu.ru ([188.44.42.42]:32051 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229538AbiAGWki (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
        s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JxSLfniL/QmogHAVpgVSnfN2HoTm9fUCaIi6jjgWyWg=; b=Kd5s77AJT90yiTustxG8Yt1ddR
        pIQ8Ru4pnoA+KI6LlcomIRcdKXC1Tapcrb0GmuWgdirAbPdbDAWOSXgJzvaTj93JAfO+Ob97ktKeN
        7KiNTbFkCVVIzL+Iok0EHPtn+zC98G03rspltWNd1fPhsXEqYB2YNO+81IPHr7h0Ynl8icoBbzGb2
        v1VK+H2CizyZf7PoQMhT69SNoaPLlpLL9jpMYQQ2+HZsH+i4oZ3W4Co2lm7xNPH95tuPX+N22qnIk
        MMMYx74w2X/zwfA017lqXsY7LkADOYuo7fD9O6mXZkkLWqQ6nKULyIiGL9V4LsfXT++kWCHGQXAZz
        TCcDO5ow==;
Received: from [37.204.119.143] (port=58128 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1n5xtq-000JS7-JJ; Sat, 08 Jan 2022 01:39:56 +0300
Date:   Sat, 8 Jan 2022 01:39:53 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Walt Drummond <walt@drummond.us>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Message-ID: <YdjBOdxWpWbHzJgy@cello>
References: <20220103181956.983342-1-walt@drummond.us>
 <20220103181956.983342-9-walt@drummond.us>
 <Ydi1F3df2JIkDuMN@cello>
 <CADCN6nz5wOmzFExUVJZiXVOJH40852=Q=AimBAiEDXaSvxHwKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QJjN9uQJHssdw4Gu"
Content-Disposition: inline
In-Reply-To: <CADCN6nz5wOmzFExUVJZiXVOJH40852=Q=AimBAiEDXaSvxHwKw@mail.gmail.com>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [RFC PATCH 8/8] signals: Support BSD VSTATUS, KERNINFO and
 SIGINFO
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--QJjN9uQJHssdw4Gu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 01:52:23PM -0800, Walt Drummond wrote:
> On Fri, Jan 7, 2022 at 1:48 PM Arseny Maslennikov <ar@cs.msu.ru> wrote:
> >
> > On Mon, Jan 03, 2022 at 10:19:56AM -0800, Walt Drummond wrote:
> > > Support TTY VSTATUS character, NOKERNINFO local control bit and the
> > > signal SIGINFO, all as in 4.3BSD.
> > >
> > > Signed-off-by: Walt Drummond <walt@drummond.us>
> > > ---
> > >  arch/x86/include/asm/signal.h       |   2 +-
> > >  arch/x86/include/uapi/asm/signal.h  |   4 +-
> > >  drivers/tty/Makefile                |   2 +-
> > >  drivers/tty/n_tty.c                 |  21 +++++
> > >  drivers/tty/tty_io.c                |  10 ++-
> > >  drivers/tty/tty_ioctl.c             |   4 +
> > >  drivers/tty/tty_status.c            | 135 ++++++++++++++++++++++++++=
++
> > >  fs/proc/array.c                     |  29 +-----
> > >  include/asm-generic/termios.h       |   4 +-
> > >  include/linux/sched.h               |  52 ++++++++++-
> > >  include/linux/signal.h              |   4 +
> > >  include/linux/tty.h                 |   8 ++
> > >  include/uapi/asm-generic/ioctls.h   |   2 +
> > >  include/uapi/asm-generic/signal.h   |   6 +-
> > >  include/uapi/asm-generic/termbits.h |  34 +++----
> > >  15 files changed, 264 insertions(+), 53 deletions(-)
> > >  create mode 100644 drivers/tty/tty_status.c
> > >
> > > diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/sig=
nal.h
> > > index d8e2efe6cd46..0a01877c11ab 100644
> > > --- a/arch/x86/include/asm/signal.h
> > > +++ b/arch/x86/include/asm/signal.h
> > > @@ -8,7 +8,7 @@
> > >  /* Most things should be clean enough to redefine this at will, if c=
are
> > >     is taken to make libc match.  */
> > >
> > > -#define _NSIG                64
> > > +#define _NSIG                65
> > >
> > >  #ifdef __i386__
> > >  # define _NSIG_BPW   32
> > > diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/ua=
pi/asm/signal.h
> > > index 164a22a72984..60dca62d3dcf 100644
> > > --- a/arch/x86/include/uapi/asm/signal.h
> > > +++ b/arch/x86/include/uapi/asm/signal.h
> > > @@ -60,7 +60,9 @@ typedef unsigned long sigset_t;
> > >
> > >  /* These should not be considered constants from userland.  */
> > >  #define SIGRTMIN     32
> > > -#define SIGRTMAX     _NSIG
> > > +#define SIGRTMAX     64
> > > +
> > > +#define SIGINFO              65
> > >
> > >  #define SA_RESTORER  0x04000000
> > >
> > > diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> > > index a2bd75fbaaa4..d50ba690bb87 100644
> > > --- a/drivers/tty/Makefile
> > > +++ b/drivers/tty/Makefile
> > > @@ -2,7 +2,7 @@
> > >  obj-$(CONFIG_TTY)            +=3D tty_io.o n_tty.o tty_ioctl.o tty_l=
disc.o \
> > >                                  tty_buffer.o tty_port.o tty_mutex.o \
> > >                                  tty_ldsem.o tty_baudrate.o tty_jobct=
rl.o \
> > > -                                n_null.o
> > > +                                n_null.o tty_status.o
> > >  obj-$(CONFIG_LEGACY_PTYS)    +=3D pty.o
> > >  obj-$(CONFIG_UNIX98_PTYS)    +=3D pty.o
> > >  obj-$(CONFIG_AUDIT)          +=3D tty_audit.o
> > > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > > index 0ec93f1a61f5..b510e01289fd 100644
> > > --- a/drivers/tty/n_tty.c
> > > +++ b/drivers/tty/n_tty.c
> > > @@ -1334,6 +1334,24 @@ static void n_tty_receive_char_special(struct =
tty_struct *tty, unsigned char c)
> > >                       commit_echoes(tty);
> > >                       return;
> > >               }
> > > +#ifdef VSTATUS
> > > +             if (c =3D=3D STATUS_CHAR(tty)) {
> > > +                     /* Do the status message first and then send
> > > +                      * the signal, otherwise signal delivery can
> > > +                      * change the process state making the status
> > > +                      * message misleading.  Also, use __isig() and
> > > +                      * not sig(), as if we flush the tty we can
> > > +                      * lose parts of the message.
> >
> > ...As well as the character input in the canonical mode's built-in line
> > editor.
> >
>=20
> Yes, good catch.  But this is not going to be in the next version of the =
patch.
>=20
> > > +                      */
> > > +
> > > +                     if (!L_NOKERNINFO(tty))
> > > +                             tty_status(tty);
> > > +# if defined(SIGINFO) && SIGINFO !=3D SIGPWR
> > > +                     __isig(SIGINFO, tty);
> > > +# endif
> > > +                     return;
> > > +             }
> > > +#endif       /* VSTATUS */
> > >               if (c =3D=3D '\n') {
> > >                       if (L_ECHO(tty) || L_ECHONL(tty)) {
> > >                               echo_char_raw('\n', ldata);
> > > @@ -1763,6 +1781,9 @@ static void n_tty_set_termios(struct tty_struct=
 *tty, struct ktermios *old)
> > >                       set_bit(EOF_CHAR(tty), ldata->char_map);
> > >                       set_bit('\n', ldata->char_map);
> > >                       set_bit(EOL_CHAR(tty), ldata->char_map);
> > > +#ifdef VSTATUS
> > > +                     set_bit(STATUS_CHAR(tty), ldata->char_map);
> > > +#endif
> > >                       if (L_IEXTEN(tty)) {
> > >                               set_bit(WERASE_CHAR(tty), ldata->char_m=
ap);
> > >                               set_bit(LNEXT_CHAR(tty), ldata->char_ma=
p);
> > > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > > index 6616d4a0d41d..8e488ecba330 100644
> > > --- a/drivers/tty/tty_io.c
> > > +++ b/drivers/tty/tty_io.c
> > > @@ -120,18 +120,26 @@
> > >  #define TTY_PARANOIA_CHECK 1
> > >  #define CHECK_TTY_COUNT 1
> > >
> > > +/* Less ugly than an ifdef in the middle of the initalizer below, ma=
ybe? */
> > > +#ifdef NOKERNINFO
> > > +# define __NOKERNINFO NOKERNINFO
> > > +#else
> > > +# define __NOKERNINFO 0
> > > +#endif
> > > +
> > >  struct ktermios tty_std_termios =3D {  /* for the benefit of tty dri=
vers  */
> > >       .c_iflag =3D ICRNL | IXON,
> > >       .c_oflag =3D OPOST | ONLCR,
> > >       .c_cflag =3D B38400 | CS8 | CREAD | HUPCL,
> > >       .c_lflag =3D ISIG | ICANON | ECHO | ECHOE | ECHOK |
> > > -                ECHOCTL | ECHOKE | IEXTEN,
> > > +                ECHOCTL | ECHOKE | IEXTEN | __NOKERNINFO,
> > >       .c_cc =3D INIT_C_CC,
> > >       .c_ispeed =3D 38400,
> > >       .c_ospeed =3D 38400,
> > >       /* .c_line =3D N_TTY, */
> > >  };
> > >  EXPORT_SYMBOL(tty_std_termios);
> > > +#undef __NOKERNINFO
> > >
> > >  /* This list gets poked at by procfs and various bits of boot up cod=
e. This
> > >   * could do with some rationalisation such as pulling the tty proc f=
unction
> > > diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> > > index 507a25d692bb..b250eabca1ba 100644
> > > --- a/drivers/tty/tty_ioctl.c
> > > +++ b/drivers/tty/tty_ioctl.c
> > > @@ -809,6 +809,10 @@ int tty_mode_ioctl(struct tty_struct *tty, struc=
t file *file,
> > >               if (get_user(arg, (unsigned int __user *) arg))
> > >                       return -EFAULT;
> > >               return tty_change_softcar(real_tty, arg);
> > > +#ifdef TIOCSTAT
> > > +     case TIOCSTAT:
> > > +             return tty_status(real_tty);
> > > +#endif
> > >       default:
> > >               return -ENOIOCTLCMD;
> > >       }
> > > diff --git a/drivers/tty/tty_status.c b/drivers/tty/tty_status.c
> > > new file mode 100644
> >
> > Nitpick: the new functionality is part of n_tty and not the generic tty
> > subsystem, so "tty_status.c" is a misleading name for the new file,
> > unlike e. g. "n_tty_status.c". It has no use in the various modem
> > drivers, for example.
> > Likewise for the tty_status() function.
>=20
> ACK, will do.
>=20
> >
> > > index 000000000000..a9600f5bd48c
> > > --- /dev/null
> > > +++ b/drivers/tty/tty_status.c
> > > @@ -0,0 +1,135 @@
> > > +// SPDX-License-Identifier: GPL-1.0+
> > > +/*
> > > + * tty_status.c --- implements VSTATUS and TIOCSTAT from BSD4.3/4.4
> > > + *
> > > + */
> > > +
> > > +#include <linux/sched.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/tty.h>
> > > +#include <linux/sched/cputime.h>
> > > +#include <linux/sched/loadavg.h>
> > > +#include <linux/pid.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/math64.h>
> > > +
> > > +#define MSGLEN (160 + TASK_COMM_LEN)
> > > +
> > > +inline unsigned long getRSSk(struct mm_struct *mm)
> > > +{
> > > +     if (mm =3D=3D NULL)
> > > +             return 0;
> > > +     return get_mm_rss(mm) * PAGE_SIZE / 1024;
> > > +}
> > > +
> > > +inline long nstoms(long l)
> > > +{
> > > +     l /=3D NSEC_PER_MSEC * 10;
> > > +     if (l < 10)
> > > +             l *=3D 10;
> > > +     return l;
> > > +}
> > > +
> > > +inline struct task_struct *compare(struct task_struct *new,
> > > +                                struct task_struct *old)
> > > +{
> > > +     unsigned int ostate, nstate;
> > > +
> > > +     if (old =3D=3D NULL)
> > > +             return new;
> > > +
> > > +     ostate =3D task_state_index(old);
> > > +     nstate =3D task_state_index(new);
> > > +
> > > +     if (ostate =3D=3D nstate) {
> > > +             if (old->start_time > new->start_time)
> > > +                     return old;
> > > +             return new;
> > > +     }
> > > +
> > > +     if (ostate < nstate)
> > > +             return old;
> > > +
> > > +     return new;
> > > +}
> > > +
> > > +struct task_struct *pick_process(struct pid *pgrp)
> > > +{
> > > +     struct task_struct *p, *winner =3D NULL;
> > > +
> > > +     read_lock(&tasklist_lock);
> > > +     do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
> > > +             winner =3D compare(p, winner);
> > > +     } while_each_pid_task(pgrp, PIDTYPE_PGID, p);
> > > +     read_unlock(&tasklist_lock);
> > > +
> > > +     return winner;
> > > +}
> > > +
> > > +int tty_status(struct tty_struct *tty)
> > > +{
> > > +     char tname[TASK_COMM_LEN];
> > > +     unsigned long loadavg[3];
> > > +     uint64_t pcpu, cputime, wallclock;
> > > +     struct task_struct *p;
> > > +     struct rusage rusage;
> > > +     struct timespec64 utime, stime, rtime;
> > > +     char msg[MSGLEN] =3D {0};
> > > +     int len =3D 0;
> > > +
> > > +     if (tty =3D=3D NULL)
> > > +             return -ENOTTY;
> > > +
> > > +     get_avenrun(loadavg, FIXED_1/200, 0);
> > > +     len +=3D scnprintf((char *)&msg[len], MSGLEN - len, "load: %lu.=
%02lu  ",
> > > +                    LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
> > > +
> > > +     if (tty->ctrl.session =3D=3D NULL) {
> > > +             len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > > +                              "not a controlling terminal");
> > > +             goto print;
> > > +     }
> > > +
> > > +     if (tty->ctrl.pgrp =3D=3D NULL) {
> > > +             len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > > +                              "no foreground process group");
> > > +             goto print;
> > > +     }
> > > +
> > > +     p =3D pick_process(tty->ctrl.pgrp);
> > > +     if (p =3D=3D NULL) {
> > > +             len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > > +                              "empty foreground process group");
> > > +             goto print;
> > > +     }
> > > +
> > > +     get_task_comm(tname, p);
> > > +     getrusage(p, RUSAGE_BOTH, &rusage);
> > > +     wallclock =3D ktime_get_ns() - p->start_time;
> > > +
> > > +     utime.tv_sec =3D rusage.ru_utime.tv_sec;
> > > +     utime.tv_nsec =3D rusage.ru_utime.tv_usec * NSEC_PER_USEC;
> > > +     stime.tv_sec =3D rusage.ru_stime.tv_sec;
> > > +     stime.tv_nsec =3D rusage.ru_stime.tv_usec * NSEC_PER_USEC;
> > > +     rtime =3D ns_to_timespec64(wallclock);
> > > +
> > > +     cputime =3D timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
> > > +     pcpu =3D div64_u64(cputime * 100, wallclock);
> > > +
> > > +     len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > > +                      /* task, PID, task state */
> > > +                      "cmd: %s %d [%s] "
> > > +                      /* rtime,    utime,      stime,      %cpu,  rs=
s */
> > > +                      "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %l=
uk",
> > > +                      tname, task_pid_vnr(p), (char *)get_task_state=
_name(p),
> > > +                      rtime.tv_sec, nstoms(rtime.tv_nsec),
> > > +                      utime.tv_sec, nstoms(utime.tv_nsec),
> > > +                      stime.tv_sec, nstoms(stime.tv_nsec),
> > > +                      pcpu, getRSSk(p->mm));
> > > +
> > > +print:
> > > +     len +=3D scnprintf((char *)&msg[len], MSGLEN - len, "\r\n");
> > > +     tty_write_message(tty, msg);
> >
> > tty_write_message() is quite risky to use; while writing my
> > implementation a couple of years ago I've found it easy to accidentally
> > set up deadlocks with this interface =E2=80=94 in particular if the fun=
ction is
> > called from the tty character receive path.
> > I hope you're testing the functionality with CONFIG_PROVE_LOCKING enabl=
ed.
>=20
> I have not, but I will.
>=20
> Is there a different 'put a message on this tty' api I should be using?

There was none at the time; unfortunately, as of v5.15 it looks like
there's still none.

Please see 6/7 of the following series:
https://lore.kernel.org/lkml/20200430064301.1099452-7-ar@cs.msu.ru/
I had to do that, then use it like this from the line discipline in 7/7
(copy-paste from the series with new notes):

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f72a3fd4b..905cdd985 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2489,6 +2496,21 @@ static int n_tty_ioctl(struct tty_struct *tty, struc=
t file *file,
 	}
 }
=20
+static void n_tty_status_line(struct tty_struct *tty)
+{
+	/* private data! can't move this to another file. */
+	struct n_tty_data *ldata =3D tty->disc_data;
+	char *msg, *buf;
+	msg =3D buf =3D kzalloc(STATUS_LINE_LEN, GFP_KERNEL);
+	tty_sprint_status_line(tty, buf + 1, STATUS_LINE_LEN - 1);
+	/* The only current caller of this takes output_lock for us. */
+	if (ldata->column !=3D 0)
+		*msg =3D '\n';
+	else
+		msg++;
+	/* a call to the new function */
+	do_n_tty_write(tty, NULL, msg, strlen(msg));
+	kfree(buf);
+}
+
 static struct tty_ldisc_ops n_tty_ops =3D {
 	.magic           =3D TTY_LDISC_MAGIC,
 	.name            =3D "n_tty",

The tty_sprint_status_line() is defined in n_tty_status.c, it produces the =
line at a buf+len.
Also, unlike in arguments of tty_write_message() which bypasses the
ldisc, '\n' gets translated by the line discipline to '\r\n'
automatically if relevant termios flags are set.
Also if the cursor is not at the first column of the current row, there
is an automatic newline.

> Thanks.
>=20
> >
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > > index f37c03077b58..eb14306cdde2 100644
> > > --- a/fs/proc/array.c
> > > +++ b/fs/proc/array.c
> > > @@ -62,6 +62,7 @@
> > >  #include <linux/tty.h>
> > >  #include <linux/string.h>
> > >  #include <linux/mman.h>
> > > +#include <linux/sched.h>
> > >  #include <linux/sched/mm.h>
> > >  #include <linux/sched/numa_balancing.h>
> > >  #include <linux/sched/task_stack.h>
> > > @@ -111,34 +112,6 @@ void proc_task_name(struct seq_file *m, struct t=
ask_struct *p, bool escape)
> > >               seq_printf(m, "%.64s", tcomm);
> > >  }
> > >
> > > -/*
> > > - * The task state array is a strange "bitmap" of
> > > - * reasons to sleep. Thus "running" is zero, and
> > > - * you can test for combinations of others with
> > > - * simple bit tests.
> > > - */
> > > -static const char * const task_state_array[] =3D {
> > > -
> > > -     /* states in TASK_REPORT: */
> > > -     "R (running)",          /* 0x00 */
> > > -     "S (sleeping)",         /* 0x01 */
> > > -     "D (disk sleep)",       /* 0x02 */
> > > -     "T (stopped)",          /* 0x04 */
> > > -     "t (tracing stop)",     /* 0x08 */
> > > -     "X (dead)",             /* 0x10 */
> > > -     "Z (zombie)",           /* 0x20 */
> > > -     "P (parked)",           /* 0x40 */
> > > -
> > > -     /* states beyond TASK_REPORT: */
> > > -     "I (idle)",             /* 0x80 */
> > > -};
> > > -
> > > -static inline const char *get_task_state(struct task_struct *tsk)
> > > -{
> > > -     BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_st=
ate_array));
> > > -     return task_state_array[task_state_index(tsk)];
> > > -}
> > > -
> > >  static inline void task_state(struct seq_file *m, struct pid_namespa=
ce *ns,
> > >                               struct pid *pid, struct task_struct *p)
> > >  {
> > > diff --git a/include/asm-generic/termios.h b/include/asm-generic/term=
ios.h
> > > index b1398d0d4a1d..9b080e1a82d4 100644
> > > --- a/include/asm-generic/termios.h
> > > +++ b/include/asm-generic/termios.h
> > > @@ -10,9 +10,9 @@
> > >       eof=3D^D          vtime=3D\0        vmin=3D\1         sxtc=3D\0
> > >       start=3D^Q        stop=3D^S         susp=3D^Z         eol=3D\0
> > >       reprint=3D^R      discard=3D^U      werase=3D^W       lnext=3D^V
> > > -     eol2=3D\0
> > > +     eol2=3D\0         status=3D^T
> > >  */
> > > -#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\=
027\026\0"
> > > +#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\=
027\026\0\024"
> > >
> > >  /*
> > >   * Translate a "termio" structure into a "termios". Ugh.
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index c1a927ddec64..2171074ec8f5 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -70,7 +70,7 @@ struct task_group;
> > >
> > >  /*
> > >   * Task state bitmask. NOTE! These bits are also
> > > - * encoded in fs/proc/array.c: get_task_state().
> > > + * encoded in get_task_state().
> > >   *
> > >   * We have two separate sets of flags: task->state
> > >   * is about runnability, while task->exit_state are
> > > @@ -1643,6 +1643,56 @@ static inline char task_state_to_char(struct t=
ask_struct *tsk)
> > >       return task_index_to_char(task_state_index(tsk));
> > >  }
> > >
> > > +static inline const char *get_task_state_name(struct task_struct *ts=
k)
> > > +{
> > > +     static const char * const task_state_array[] =3D {
> > > +
> > > +             /* states in TASK_REPORT: */
> > > +             "running",              /* 0x00 */
> > > +             "sleeping",             /* 0x01 */
> > > +             "disk sleep",           /* 0x02 */
> > > +             "stopped",              /* 0x04 */
> > > +             "tracing stop",         /* 0x08 */
> > > +             "dead",                 /* 0x10 */
> > > +             "zombie",               /* 0x20 */
> > > +             "parked",               /* 0x40 */
> > > +
> > > +             /* states beyond TASK_REPORT: */
> > > +             "idle",                 /* 0x80 */
> > > +     };
> > > +
> > > +     BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_st=
ate_array));
> > > +     return task_state_array[task_state_index(tsk)];
> > > +}
> > > +
> > > +static inline const char *get_task_state(struct task_struct *tsk)
> > > +{
> > > +     /*
> > > +      * The task state array is a strange "bitmap" of
> > > +      * reasons to sleep. Thus "running" is zero, and
> > > +      * you can test for combinations of others with
> > > +      * simple bit tests.
> > > +      */
> > > +     static const char * const task_state_array[] =3D {
> > > +
> > > +             /* states in TASK_REPORT: */
> > > +             "R (running)",          /* 0x00 */
> > > +             "S (sleeping)",         /* 0x01 */
> > > +             "D (disk sleep)",       /* 0x02 */
> > > +             "T (stopped)",          /* 0x04 */
> > > +             "t (tracing stop)",     /* 0x08 */
> > > +             "X (dead)",             /* 0x10 */
> > > +             "Z (zombie)",           /* 0x20 */
> > > +             "P (parked)",           /* 0x40 */
> > > +
> > > +             /* states beyond TASK_REPORT: */
> > > +             "I (idle)",             /* 0x80 */
> > > +     };
> > > +
> > > +     BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_st=
ate_array));
> > > +     return task_state_array[task_state_index(tsk)];
> > > +}
> > > +
> > >  /**
> > >   * is_global_init - check if a task structure is init. Since init
> > >   * is free to have sub-threads we need to check tgid.
> > > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > > index b77f9472a37c..76bda1a20578 100644
> > > --- a/include/linux/signal.h
> > > +++ b/include/linux/signal.h
> > > @@ -541,6 +541,7 @@ extern bool unhandled_signal(struct task_struct *=
tsk, int sig);
> > >   *   |  non-POSIX signal  |  default action  |
> > >   *   +--------------------+------------------+
> > >   *   |  SIGEMT            |  coredump        |
> > > + *   |  SIGINFO           |  ignore          |
> > >   *   +--------------------+------------------+
> > >   *
> > >   * (+) For SIGKILL and SIGSTOP the action is "always", not just "def=
ault".
> > > @@ -567,6 +568,9 @@ static inline int sig_kernel_ignore(unsigned long=
 sig)
> > >       return  sig =3D=3D SIGCONT  ||
> > >               sig =3D=3D SIGCHLD  ||
> > >               sig =3D=3D SIGWINCH ||
> > > +#if defined(SIGINFO) && SIGINFO !=3D SIGPWR
> > > +             sig =3D=3D SIGINFO  ||
> > > +#endif
> > >               sig =3D=3D SIGURG;
> > >  }
> > >
> > > diff --git a/include/linux/tty.h b/include/linux/tty.h
> > > index 168e57e40bbb..943d85aa471c 100644
> > > --- a/include/linux/tty.h
> > > +++ b/include/linux/tty.h
> > > @@ -49,6 +49,9 @@
> > >  #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
> > >  #define LNEXT_CHAR(tty)      ((tty)->termios.c_cc[VLNEXT])
> > >  #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
> > > +#ifdef VSTATUS
> > > +#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
> > > +#endif
> > >
> > >  #define _I_FLAG(tty, f)      ((tty)->termios.c_iflag & (f))
> > >  #define _O_FLAG(tty, f)      ((tty)->termios.c_oflag & (f))
> > > @@ -114,6 +117,9 @@
> > >  #define L_PENDIN(tty)        _L_FLAG((tty), PENDIN)
> > >  #define L_IEXTEN(tty)        _L_FLAG((tty), IEXTEN)
> > >  #define L_EXTPROC(tty)       _L_FLAG((tty), EXTPROC)
> > > +#ifdef NOKERNINFO
> > > +#define L_NOKERNINFO(tty) _L_FLAG((tty), NOKERNINFO)
> > > +#endif
> > >
> > >  struct device;
> > >  struct signal_struct;
> > > @@ -428,4 +434,6 @@ extern void tty_lock_slave(struct tty_struct *tty=
);
> > >  extern void tty_unlock_slave(struct tty_struct *tty);
> > >  extern void tty_set_lock_subclass(struct tty_struct *tty);
> > >
> > > +extern int tty_status(struct tty_struct *tty);
> > > +
> > >  #endif
> > > diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-gen=
eric/ioctls.h
> > > index cdc9f4ca8c27..baa2b8d42679 100644
> > > --- a/include/uapi/asm-generic/ioctls.h
> > > +++ b/include/uapi/asm-generic/ioctls.h
> > > @@ -97,6 +97,8 @@
> > >
> > >  #define TIOCMIWAIT   0x545C  /* wait for a change on serial input li=
ne(s) */
> > >  #define TIOCGICOUNT  0x545D  /* read serial port inline interrupt co=
unts */
> > > +/* Some architectures use 0x545E for FIOQSIZE */
> > > +#define TIOCSTAT        0x545F       /* display process group stats =
on tty */
> > >
> > >  /*
> > >   * Some arches already define FIOQSIZE due to a historical
> > > diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-gen=
eric/signal.h
> > > index 3c4cc9b8378e..0b771eb1db94 100644
> > > --- a/include/uapi/asm-generic/signal.h
> > > +++ b/include/uapi/asm-generic/signal.h
> > > @@ -4,7 +4,7 @@
> > >
> > >  #include <linux/types.h>
> > >
> > > -#define _NSIG                64
> > > +#define _NSIG                65
> > >  #define _NSIG_BPW    __BITS_PER_LONG
> > >  #define _NSIG_WORDS  ((_NSIG + _NSIG_BPW - 1) / _NSIG_BPW)
> > >
> > > @@ -49,9 +49,11 @@
> > >  /* These should not be considered constants from userland.  */
> > >  #define SIGRTMIN     32
> > >  #ifndef SIGRTMAX
> > > -#define SIGRTMAX     _NSIG
> > > +#define SIGRTMAX     64
> > >  #endif
> > >
> > > +#define SIGINFO              65
> > > +
> > >  #if !defined MINSIGSTKSZ || !defined SIGSTKSZ
> > >  #define MINSIGSTKSZ  2048
> > >  #define SIGSTKSZ     8192
> > > diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-g=
eneric/termbits.h
> > > index 2fbaf9ae89dd..cb4e9c6d629f 100644
> > > --- a/include/uapi/asm-generic/termbits.h
> > > +++ b/include/uapi/asm-generic/termbits.h
> > > @@ -58,6 +58,7 @@ struct ktermios {
> > >  #define VWERASE 14
> > >  #define VLNEXT 15
> > >  #define VEOL2 16
> > > +#define VSTATUS 17
> > >
> > >  /* c_iflag bits */
> > >  #define IGNBRK       0000001
> > > @@ -164,22 +165,23 @@ struct ktermios {
> > >  #define IBSHIFT        16            /* Shift from CBAUD to CIBAUD */
> > >
> > >  /* c_lflag bits */
> > > -#define ISIG 0000001
> > > -#define ICANON       0000002
> > > -#define XCASE        0000004
> > > -#define ECHO 0000010
> > > -#define ECHOE        0000020
> > > -#define ECHOK        0000040
> > > -#define ECHONL       0000100
> > > -#define NOFLSH       0000200
> > > -#define TOSTOP       0000400
> > > -#define ECHOCTL      0001000
> > > -#define ECHOPRT      0002000
> > > -#define ECHOKE       0004000
> > > -#define FLUSHO       0010000
> > > -#define PENDIN       0040000
> > > -#define IEXTEN       0100000
> > > -#define EXTPROC      0200000
> > > +#define ISIG    0000001
> > > +#define ICANON          0000002
> > > +#define XCASE           0000004
> > > +#define ECHO    0000010
> > > +#define ECHOE           0000020
> > > +#define ECHOK           0000040
> > > +#define ECHONL          0000100
> > > +#define NOFLSH          0000200
> > > +#define TOSTOP          0000400
> > > +#define ECHOCTL         0001000
> > > +#define ECHOPRT         0002000
> > > +#define ECHOKE          0004000
> > > +#define FLUSHO          0010000
> > > +#define PENDIN          0040000
> > > +#define IEXTEN          0100000
> > > +#define EXTPROC         0200000
> > > +#define NOKERNINFO 0400000
> > >
> > >  /* tcflow() and TCXONC use these */
> > >  #define      TCOOFF          0
> > > --
> > > 2.30.2
> > >

--QJjN9uQJHssdw4Gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAmHYwTQACgkQ9dQjyAYL
01B2vRAAwfYt9szhb3W2Z2PPx4cV6v7QIqDPN28hNDXFIKyvcvwKdhA+jpDZLfCQ
M4j8TsNcm7C2wMdV1Bx+xecbxBnFuP8pra59hEKA3Ht3cFN7nQ+VUMOGT9Eib/us
2XFd9GeCVDikjneHNAHHKgKF6Feb1GmuA27hEe7chv1hVRJWsGmkgtBXGFF6mcuB
lbA5OyUo3OIbY1xYqzVUiAkdVD5liwB9O89O89XOW+nx1o6aitmeKEHfUhoLcbvM
+u8RDDMgO9pmu3WHts3up0jy8aiFILyZurcDTJx08wq1K4qWj2Nvq3gkbYidrd2Q
/KMJw2wdVKEiqRZVrcLXTGdQYJXNRSHxvDGbpok0unV+upc+ez6mwLOc+3Jl9clC
yuwhsXwnTmOD/SoIBpuhrMRVQd3Shu0pSvwFBht2uh+MrQ1TLnR2iCH+qvlHAWBU
dxRL4cKxbMGbzkEfCwcIxSl/Oe9CC1/36Jso2AFupBJEqu2C2uPDfuWs4D83NoNT
RyLctOTnM5kaHU1MHP2k+cuylANPx1+dILsTMi01KLQb2l8Cbw0tCyvCYaFT6Gky
IeIY9XTCLEufXt+JjPEkQRXwZROupHXR2LVfJ62i+MIs5q+TabG8SNiz43mAOcaS
nm+pWTRwl8j9B0RxzCxmGRiMLblvDWwCbdJaP4ymvZ8S4l9aFO4=
=cC4T
-----END PGP SIGNATURE-----

--QJjN9uQJHssdw4Gu--
