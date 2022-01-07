Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3494487D22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiAGTek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 14:34:40 -0500
Received: from mx.cs.msu.ru ([188.44.42.42]:53954 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232688AbiAGTej (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
        s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OCmqg7hdVMRDf9S2TRzQcyQTVURjWWjA2U66wZsX9xE=; b=GZTN5nPrZajSo0Dsw8ti3k+ewF
        w1M5DO8uta92yExxmpRX1irxHJV5CazVnzyUy/i9UXyucK+gf9zJtvBGsOPrIVuPj7Ip48EqV8PBE
        qazaFFVv9YUZnYw0PIDKesYTg2I3YuLVS8PvQZkPGEMHmqbpaEboMRKWIWE4mU++TrxxcN7YXgzgQ
        ouTjjURG2hZtWJyIMWlmT+BlDYSsZgLf88F0m10ZJkuYyXoEcn5Q7IRNgCBR3mWnvTtJcsnbRWoFs
        LM/bPMRKrMRgVRcM9UZNHpJj3bznRqeLBk/YUH54uF9sVNrmZGQwYPNskpZ40XKn4YDGguOE9+l+j
        hNV7XitQ==;
Received: from [37.204.119.143] (port=58122 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1n5um6-000CP7-UJ; Fri, 07 Jan 2022 22:19:44 +0300
Date:   Fri, 7 Jan 2022 22:19:36 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Walt Drummond <walt@drummond.us>, aacraid@microsemi.com,
        viro@zeniv.linux.org.uk, anna.schumaker@netapp.com, arnd@arndb.de,
        bsegall@google.com, bp@alien8.de, chuck.lever@oracle.com,
        bristot@redhat.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Message-ID: <YdiSSGLinhOVqS8a@cello>
References: <20220103181956.983342-1-walt@drummond.us>
 <87iluzidod.fsf@email.froward.int.ebiederm.org>
 <YdSzjPbVDVGKT4km@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qWnueR4sTyTaRsaN"
Content-Disposition: inline
In-Reply-To: <YdSzjPbVDVGKT4km@mit.edu>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [RFC PATCH 0/8] signals: Support more than 64 signals
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qWnueR4sTyTaRsaN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I generally agree with Ted's suggestion that we could merge the
easy-to-design part =E2=80=94 the VSTATUS+kerninfo =E2=80=94 first and deal=
 with the
SIGINFO part later. The only concern I have here is that the "later"
part might never practically arrive... :)

Still, some notes on the SIGINFO/userspace-status
part:

On Tue, Jan 04, 2022 at 03:52:28PM -0500, Theodore Ts'o wrote:
> On Tue, Jan 04, 2022 at 12:00:34PM -0600, Eric W. Biederman wrote:
> > I dug through the previous conversations and there is a little debate
> > about what makes sense for SIGPWR to do by default.  Alan Cox remembered
> > SIGPWR was sent when the power was restored, so ignoring SIGPWR by
> > default made sense.  Ted Tso pointed out a different scenario where it
> > was reasonable for SIGPWR to be a terminating signal.
> >=20
> > So far no one has actually found any applications that will regress if
> > SIGPWR becomes ignored by default.

Some folks from linux-api@ claimed otherwise, but unfortunately didn't elab=
orate.

> > Furthermore on linux SIGPWR is only
> > defined to be sent to init, and init ignores all signals by default so
> > in practice SIGPWR is ignored by the only process that receives it
> > currently.
>=20
> As it turns out, systemd does *not* ignore SIGPWR.  Instead, it will
> initiate the sigpwr target.  From the systemd.special man page:
>=20
>        sigpwr.target
>            A special target that is started when systemd receives the
>            SIGPWR process signal, which is normally sent by the kernel
>            or UPS daemons when power fails.

Not sure what you had in mind; in case you're suggesting that systemd has
to drop the sigpwr.target semantics =E2=80=94 it doesn't.
We don't need to ask systemd to drop sigpwr.target semantics.

To introduce SIGINFO =3D=3D SIGPWR to the kernel, the only "breaking" change
we have to do is to change the default disposition for SIGPWR, i. e. the
behaviour if the signal is set to SIG_DFL. If a process (including PID
1) installs its own signal handler for SIGPWR to do something when PWR
is received (or blocks the signal and handles it via signalfd
notifications), then the default disposition does not matter at all, as
Eric notes further in this thread.

=46rom a quick glance at systemd code, pid1's main() function calls
manager_new() calls manager_setup_signals(); this function, in turn,
blocks a set of signals, including PWR, and sets up a signalfd(2) on
that set. No changes have to be made in systemd, no need to remove the
sigpwr.target semantics.

The target activation does not send SIGPWR to anyone, it results in
systemd services being started and possibly stopped; the exact
consequences are out of scope for systemd.

There could be another concern: a VSTATUS keypress could result in
SIGINFO =3D=3D SIGPWR being sent to pid1. In a correct implementation this
will not ever happen, because a sane PID 1 does not have (and never
acquires) a controlling terminal.

> And child processes of systemd are not ignoring SIGPWR.  Instead, they
> are getting terminated.
>=20
> <tytso@cwcc>
> 41% /bin/sleep 50 &
> [1] 180671
> <tytso@cwcc>
> 42% kill -PWR 180671
> [1]+  Power failure           /bin/sleep 50

All the possible surprises with the SIGINFO =3D=3D SIGPWR approach we might
get stem from here, not from the sigpwr.target.

> > Where I saw the last conversation falter was in making a persuasive
> > case of why SIGINFO was interesting to add.  Given a world of ssh
> > connections I expect a persuasive case can be made.  Especially if there
> > are a handful of utilities where it is already implemented that just
> > need to be built with SIGINFO defined.
>=20
> One thing that's perhaps worth disentangling is the value of
> supporting VSTATUS --- which is a control character much like VINTR
> (^C) or VQUIT (control backslash) which is set via the c_cc[] array in
> termios structure.  Quoting from the termios man page:
>=20
>        VSTATUS
>               (not in POSIX; not supported under Linux; status
>               request: 024, DC4, Ctrl-T).  Status character (STATUS).
>               Display status information at terminal, including state
>               of foreground process and amount of CPU time it has
>               consumed.  Also sends a SIGINFO signal (not supported on
>               Linux) to the foreground process group.
>=20
> The basic idea is that when you type C-t, you can find out information
> about the currently running process.  This is a feature that
> originally comes from TOPS-10's TENEX operating system, and it is
> supported today on FreeBSD and Mac OS.  For example, it might display
> something like this:
>=20
> load: 2.39  cmd: ping 5374 running 0.00u 0.00s
>=20
> The reason why SIGINFO is sent to the foreground process group is that
> it gives the process an opportunity print application specific
> information about currently running process.  For example, maybe the C
> compiler could print something like "parsing 2042 of 5000 header
> files", or some such.  :-)
>=20
> There are people who wish that Linux supported Control-T / VSTATUS,
> for example, just last week, on TUHS, the Unix greybeards list, there
> were two such heartfelt wishes for Control-T support from two such
> greybeards:
>=20
>     "It's my biggest annoyance with Linux that it doesn't [support
>     control-t]
>     - https://minnie.tuhs.org/pipermail/tuhs/2021-December/024849.html
>=20
>     "I personally can't stand using Linux, even casually for a very
>      short sys-admin task, because of this missing feature"
>     - https://minnie.tuhs.org/pipermail/tuhs/2021-December/024898.html
>=20
> I claim, though, that we could implement VSTATUS without implenting
> the SIGINFO part of the feature.  Previous few applications *ever*
> implemented SIGINFO signal handlers so they could give status
> information, it's the hard one, since we don't have any spare signals
> left.  If we were to repurpose some lesser used signal, whether it be
> SIGPWR, SIGLOST, or SIGSTKFLT, the danger is that there might be some
> userspace program (such as a UPS monitoring program which wants to
> trigger power fail handling, or a userspace NFSv4 process that wants
> to signal that it was unable to recover a file's file lock after a
> server reboot), and if we try to take over the signal assignment, it's
> possible that we might get surprised.  Furthermore, all of the
> possibly unused signals that we might try to reclaim terminate the
> process by default, and SIGINFO *has* to have a default signal
> handling action of Ignore, since otherwise typing Control-T will end
> up killing the current foreground application.
>=20
> Personally, I don't care all that much about VSTATUS support --- I
> used it when I was in university, but honestly, I've never missed it.
> But if there is someone who wants to try to implement VSTATUS, and
> make some Unix greybeards happy, and maybe even switch from FreeBSD to
> Linux as a result, go wild.  I'm not convinced, though, that adding
> the SIGINFO part of the support is worth the effort.
>=20
> Not only do almost no programs implement SIGINFO support, a lot of CPU

To be fair, many programs are a lot younger than 4.3BSD, and with the
current ubiquity of Linux without VSTATUS, it's kind of a chicken-egg
problem. :)

> bound programs where this might be actually useful, end up running a
> large number of processes in parallel.  Take the "parsing 2042 of 5000
> header files" example I gave above.  Consider what would happen if gcc
> implemented support for SIGINFO, but the user was running a "make -j
> 16" and typed Control-T.   The result would be chaos!
>=20
> So if you really miss Control-T, and it's the only thing holding back
> a few FreeBSD users from Linux, I don't see the problem with
> implementing that part of the feature.  Why not just do the easy part
> of the feature which is perhaps 5% of the work, and might provide 99%
> of the benefit (at least for those people who care).
>=20
> > Without seeing the persuasive case for more signals I have to say that
> > adding more signals to the kernel sounds like a bad idea.
>=20
> Concur, 100%.
>=20
> 						- Ted

--qWnueR4sTyTaRsaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAmHYkkIACgkQ9dQjyAYL
01CKqw//fRo598+oG7eu1P/GUZQ6vFoTL0kGRWMTenBGAe6d/mxq+VqE65I7oxSp
WuoYr65MDc+0jQxkykcyJonrsLORM1VYyceFSWc8oIaeoLz6Hota5v2mqSZoVouO
shRoPTDm/FfaHd9QEz8goK87gv3SRz/3yzcZMt+Ezt8/5MAry1Hej17EsWeWK+DL
25AgQpnZiqalF/99rUMTxGRoZh2oAE6oUMaaCMj6rgWM/wWgGTiL89gFbz96DVVf
ZRxTVR4/wkU+xGKHu8g9rskEJMPiP96CdQ42ApxgIqGCZHLq5g6TsrS1vB9Kym5Z
tZJettnHQke4IQ8F28i7429Ya7LJuBhc9K27YqoPaRnqbkpH0ULkRR0vHRGMapTr
tVlWaRKrgfOBpo0Ozyd8sMYgwatbO/9avkv4Al/+RDaBYDvkbscL0yidy3d8mFPO
6dzpeuDFlAMX9rZWMd+cGm/GG2VBv6VbKQuFbzY59cfxoXHkQB3RvJCEiE1oZUPk
tPT5hqzF525Sfy9VqnjW9/9lDfl5/n6Ip6uI+3vWiPfFypmmuDHQAH5D5wA5hGJg
615nXgANcr/YxxQ+Tq6ErKbnx+8GzQVinkhMgGuzVpaU5hfnDZ3xOQ1oitTKoTBl
9zNo2aZN1OSddJtCpq0PROCGQOLNnZ45TqEAbWEuDn24fypRBjE=
=ut2q
-----END PGP SIGNATURE-----

--qWnueR4sTyTaRsaN--
