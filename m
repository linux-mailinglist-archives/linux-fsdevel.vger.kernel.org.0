Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C3C288994
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgJINHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 09:07:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:57737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388153AbgJINHh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:07:37 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 09:07:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602248855;
        bh=fZmlBl+lNn5TpmcFS4ptgIjr3xO6EXVK9ZX1TPguxhg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FZZdaPThMCpZk686xYPb50dlXx2LfRBdPUxO7bNXwK/MpohywDEOpSmPEeenNoiEL
         lwz7EzEhfYKhcQwRIVfSX5BdKjkdtdTO4cbJA6OXZh5cye92yQIENd08CEKimoY6pV
         rB7N+gm8/bnWnL9IjfJ+PtoRZFWE1xGW2tDYtrv8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1kOTTo1mTv-0167iv; Fri, 09
 Oct 2020 15:02:19 +0200
Date:   Fri, 9 Oct 2020 12:44:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        tytso@mit.edu, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
In-Reply-To: <87eem8hfrp.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010091219480.50@tvgsbejvaqbjf.bet>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-3-avarab@gmail.com> <xmqqv9gcs91k.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2010081012490.50@tvgsbejvaqbjf.bet> <87eem8hfrp.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1671604778-1602240278=:50"
X-Provags-ID: V03:K1:wdWnPyaEsATVpuSlL6/9AdbDM366ZdlXcGblcp3j3EAOf0DZUMQ
 E9JKWjSASdhwq2yczSynJ/SPAVkzjK4TlbY/sPXyLnCnh08PjdMIJL5IfZAle37PVCBuXYR
 6wQO+p6p2/kjUj9Udeg0WAcEo8RhJlgGiZWFxbchtbANBMvAvD65aA3zI4MlD23rZMFYkGb
 YDo02nIxiW3x27R9BBBpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlHaw0sqBTU=:nvhiHHKgw1Gte1DxF/S6CL
 s+Nb5LdhcEe7IlfHK+hVatgxpeWjIPCw88a8DTcBWAco3gw8Ari08DzlDc5kXepvtY/kmX0V6
 rNrPVHZbzj4eeBb6esof65OSPRrwmOtiosoBl+wrdsRnqjsYigG3lJZYZBaoZKYe8o4Zo4qVK
 SzsYa1nHWFBEaQzPgpCzaXvmrFO7dEV7JM0b99Xnf1IlU7pS3RXPY5lnSlhh3aIWrKaSggFq7
 kYCB/Bp+1U+5ebO/vhsqwJqCFlJW5NDW49DCVXi0Pc0c5rkHKCNlRxJIq8LSClLCijcyMgzO+
 nOlyVdBadUDPt9rxkwtBxm2c67/94zmg8BFJwhII+hie+muHsKUPrz2RFTcbZ3shRu84CTpoV
 DX87vq+7r9nwm7wPDpFVcO+9ngTT39Qrel3cxhAW/bbgoaccF5AYNxpDomvbkjQXoK1r09p5N
 5lgnKBMDOdXy3CZBlycoGcZ73rigCpHB+fFvFpF5Z5+9tKxBt5UZDFSX+4VzWQPM3IfDYM8Bo
 DD7aSb8FxawVdFOkQnNv3j+8JUzx7t0T9RUrUPbbJLvYLBqZON003mxYTF/XDSaqEd/X1YDVi
 SXaSUNZEIqhmJBiZIU0KAeiIP+iXDqx7H2IVjCNkUvlPi7B45U7Zfypkgxc5mOR6f9ycYHVjd
 fcnfU2fMCrCY5+9Wb9rPZNFnmIfa3//2bg437dgSwr6ffTClMZjZvF5q3qXEi6ePJtkk8vtj2
 I3QOgwjlm5s4gksp2S20CAePTzV+zQh3IRXOfqR/NdqUuSOVdaEHAWHTXTilkP2muKxhu/Ryp
 UgOtjQsxiMBx8wdJn5nr8Snpww0DCtHnYD/SYZmsRv1ciF0Rlr8VZf67AD7gZrN9iC2tGPC7c
 3iFue8u5RfHQ7PrTjaZc3w8kuzXfW8U2zpfKyxnUv8hnX+kK6Ozc4OZlc/d3E19p62EdeOMEP
 AkBgNAivEyjt/KimlqOrEX2LwDhwj+I80ZqHrpgwW+hAURBwIi+dikpW8LH1p9o1d72/3B7MB
 rEAtQtcZgomopyvVdMkm0oTReTGREEZ9SvASENX5Trhsuf5a1+zdrHZPMFxtvltYhhhGz0G4c
 VodG9XL/TFBOpHSgeBb6M6zBJ1PfTCkstB9nG0rObOrCQR+sttyvUWFZrRVQpet2e20YsoqfN
 yJyrbU4aE9r83BBCMT6WX2csfSkISUgdH/YnApuQA3yFcWeCe74aH5WCdBnonY7DMdh+t5Y3J
 58DcyQhBDc8j0VLilyuKRCHE3TurW6L4CXw1aXw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1671604778-1602240278=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 8 Oct 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Oct 08 2020, Johannes Schindelin wrote:
>
> > On Thu, 17 Sep 2020, Junio C Hamano wrote:
> >
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> >>
> >> > As amusing as Linus's original prose[1] is here it doesn't really e=
xplain
> >> > in any detail to the uninitiated why you would or wouldn't enable
> >> > this, and the counter-intuitive reason for why git wouldn't fsync y=
our
> >> > precious data.
> >> >
> >> > So elaborate (a lot) on why this may or may not be needed. This is =
my
> >> > best-effort attempt to summarize the various points raised in the l=
ast
> >> > ML[2] discussion about this.
> >> >
> >> > 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
> >> >     files", 2008-06-18)
> >> > 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
> >> >
> >> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
> >> > ---
> >> >  Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-=
----
> >> >  1 file changed, 36 insertions(+), 6 deletions(-)
> >>
> >> When I saw the subject in my mailbox, I expected to see that you
> >> would resurrect Christoph's updated text in [*1*], but you wrote a
> >> whole lot more ;-) And they are quite informative to help readers to
> >> understand what the option does.  I am not sure if the understanding
> >> directly help readers to decide if it is appropriate for their own
> >> repositories, though X-<.
> >
> > I agree that it is an improvement, and am therefore in favor of applyi=
ng
> > the patch.
>
> Just the improved docs, or flipping the default of core.fsyncObjectFiles
> to "true"?

I am actually also in favor of flipping the default. We carry
https://github.com/git-for-windows/git/commit/14dad078c28159b250be599c0890=
ece2d6f4d635
in Git for Windows for over three years. The commit message:

	mingw: change core.fsyncObjectFiles =3D 1 by default

	From the documentation of said setting:

		This boolean will enable fsync() when writing object files.

		This is a total waste of time and effort on a filesystem that
		orders data writes properly, but can be useful for filesystems
		that do not use journalling (traditional UNIX filesystems) or
		that only journal metadata and not file contents (OS X=E2=80=99s HFS+,
		or Linux ext3 with "data=3Dwriteback").

	The most common file system on Windows (NTFS) does not guarantee that
	order, therefore a sudden loss of power (or any other event causing an
	unclean shutdown) would cause corrupt files (i.e. files filled with
	NULs). Therefore we need to change the default.

	Note that the documentation makes it sound as if this causes really bad
	performance. In reality, writing loose objects is something that is done
	only rarely, and only a handful of files at a time.

	Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

The patch itself limits this change to Windows, but if this becomes a
platform-independent change, all the better for me!

> I've been meaning to re-roll this. I won't have time anytime soon to fix
> git's fsync() use, i.e. ensure that we run up & down modified
> directories and fsync()/fdatasync() file/dir fd's as appropriate but I
> think documenting it and changing the core.fsyncObjectFiles default
> makes sense and is at least a step in the right direction.

Agreed.

> I do think it makes more sense for a v2 to split most of this out into
> some section that generally discusses data integrity in the .git
> directory. I.e. that says that currently where we use fsync() (such as
> pack/commit-graph writes) we don't fsync() the corresponding
> director{y,ies), and ref updates don't fsync() at all.
>
> Where to put that though? gitrepository-layout(5)? Or a new page like
> gitrepository-integrity(5) (other suggestions welcome..).

I think `gitrepository-layout` is probably the best location for now.

> Looking at the code again it seems easier than I thought to make this
> right if we ignore .git/refs (which reftable can fix for us). Just:
>
> 1. Change fsync_or_die() and its callsites to also pass/sync the
>    containing directory, which is always created already
>    (e.g. .git/objects/pack/)...).
>
> 2. ..Or in the case where it's not created already such as
>    .git/objects/??/ (or .git/objects/pack/) itself) it's not N-deep like
>    the refs hierarchy, so "did we create it" state is pretty simple, or
>    we can just always do it unconditionally.
>
> 3. Without reftable the .git/refs/ case shouldn't be too hard if we're
>    OK with redundantly fsyncing all the way down, i.e. to make it
>    simpler by not tracking the state of exactly what was changed.
>
> 4. Now that I'm writing this there's also .git/{config,rr-cache} and any
>    number of other things we need to change for 100% coverage, but the
>    above 1-3 should be good enough for repo integrity where repo =3D ref=
s
>    & objects.

I fear that the changes to `fsync` also the directory need to be guarded
behind a preprocessor flag, though: if you try to `open()` a directory on
Windows, it fails (our emulated `open()` sets `errno =3D EISDIR`).

Ciao,
Dscho

--8323328-1671604778-1602240278=:50--
