Return-Path: <linux-fsdevel+bounces-7866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814782BF08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 12:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7A71C21354
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDEE67E7A;
	Fri, 12 Jan 2024 11:11:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8767E64;
	Fri, 12 Jan 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd8bd6ce1bso17371891fa.1;
        Fri, 12 Jan 2024 03:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705057903; x=1705662703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SBHLbp3sL8hAzWSZQUe86EmKU8Kk9eLpOGMHJxmd/0=;
        b=c9LiBBgmw4IycKKk9daj38nfDs//UZX7g7N7/GFECYILs2u+Nrke9O9g193ZvueXrY
         bkMI7rblLGpLzgAwxSoVi6gw9HzzeRe8RFgkckTN1GzI3jo5eIFtVJ0QA1Z1W3l1rrbf
         +rFHvYvHKLjKuIdg1rLq7Bi6/PTyefR/3dB9K58JesPspFAi8APWv8sqwrPZjRmAF8xj
         MhqGhQ6P/XeWLizQYEDwtmGv/Z50Qrh7oa3CF3CkMHtkgqfwJsctENO3bG/pVy7//VYV
         qCRxroY488VgW8f9CGNWdGGoc9rHxTPxQ7b44XC83JIFsAacvN5InWRI99ZeItOL92mJ
         Rj9Q==
X-Gm-Message-State: AOJu0YwQOMMkMqd1gUMpjE3PKnctlXSWPhZe793Sd3wO0yc++8cYlw0c
	Sw5J9UtdpB2Ye9aoC8H0i+Wp5Z2kP1gGVg==
X-Google-Smtp-Source: AGHT+IEho1GEPZWGXPLG3FNR5ZqpQkfEuSCLHvMZ2zplw1U5MS+LQWzzeVM2vrizouunaP/gB+/+aw==
X-Received: by 2002:a2e:b7d4:0:b0:2cd:1e40:2902 with SMTP id p20-20020a2eb7d4000000b002cd1e402902mr375669ljo.1.1705057902824;
        Fri, 12 Jan 2024 03:11:42 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id n14-20020a056402060e00b0055344b92fb6sm1671040edv.75.2024.01.12.03.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 03:11:42 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so756738066b.1;
        Fri, 12 Jan 2024 03:11:42 -0800 (PST)
X-Received: by 2002:a17:906:802:b0:a2c:34e8:6422 with SMTP id
 e2-20020a170906080200b00a2c34e86422mr338753ejd.178.1705057901747; Fri, 12 Jan
 2024 03:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook> <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook> <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk> <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk> <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
In-Reply-To: <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 12 Jan 2024 06:11:04 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
Message-ID: <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:11=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Jan 11, 2024 at 09:47:26PM +0000, Mark Brown wrote:
> > On Thu, Jan 11, 2024 at 12:38:57PM -0500, Kent Overstreet wrote:
> > > On Thu, Jan 11, 2024 at 03:35:40PM +0000, Mark Brown wrote:
> >
> > > > IME the actually running the tests bit isn't usually *so* much the
> > > > issue, someone making a new test runner and/or output format does m=
ean a
> > > > bit of work integrating it into infrastructure but that's more usua=
lly
> > > > annoying than a blocker.
> >
> > > No, the proliferation of test runners, test output formats, CI system=
s,
> > > etc. really is an issue; it means we can't have one common driver tha=
t
> > > anyone can run from the command line, and instead there's a bunch of
> > > disparate systems with patchwork integration and all the feedback is =
nag
> > > emails - after you've finished whan you were working on instead of
> > > moving on to the next thing - with no way to get immediate feedback.
> >
> > It's certainly an issue and it's much better if people do manage to fit
> > their tests into some existing thing but I'm not convinced that's the
> > big reason why you have a bunch of different systems running separately
> > and doing different things.  For example the enterprise vendors will
> > naturally tend to have a bunch of server systems in their labs and focu=
s
> > on their testing needs while I know the Intel audio CI setup has a bunc=
h
> > of laptops, laptop like dev boards and things in there with loopback
> > audio cables and I think test equipment plugged in and focuses rather
> > more on audio.  My own lab is built around on systems I can be in the
> > same room as without getting too annoyed and does things I find useful,
> > plus using spare bandwidth for KernelCI because they can take donated
> > lab time.
>
> No, you're overthinking.
>
> The vast majority of kernel testing requires no special hardware, just a
> virtual machine.
>
> There is _no fucking reason_ we shouldn't be able to run tests on our
> own local machines - _local_ machines, not waiting for the Intel CI
> setup and asking for a git branch to be tested, not waiting for who
> knows how long for the CI farm to get to it - just run the damn tests
> immediately and get immediate feedback.
>
> You guys are overthinking and overengineering and ignoring the basics,
> the way enterprise people always do.
>

As one of those former enterprise people that actually did do this
stuff, I can say that even when I was "in the enterprise", I tried to
avoid overthinking and overengineering stuff like this. :)

Nobody can maintain anything that's so complicated nobody can run the
tests on their machine. That is the root of all sadness.

> > > And it's because building something shiny and new is the fun part, no
> > > one wants to do the grungy integration work.
> >
> > I think you may be overestimating people's enthusiasm for writing test
> > stuff there!  There is NIH stuff going on for sure but lot of the time
> > when you look at something where people have gone off and done their ow=
n
> > thing it's either much older than you initially thought and predates
> > anything they might've integrated with or there's some reason why none
> > of the existing systems fit well.  Anecdotally it seems much more commo=
n
> > to see people looking for things to reuse in order to save time than it
> > is to see people going off and reinventing the world.
>
> It's a basic lack of leadership. Yes, the younger engineers are always
> going to be doing the new and shiny, and always going to want to build
> something new instead of finishing off the tests or integrating with
> something existing. Which is why we're supposed to have managers saying
> "ok, what do I need to prioritize for my team be able to develop
> effectively".
>
> >
> > > > > example tests, example output:
> > > > > https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/singl=
e_device.ktest
> > > > > https://evilpiepirate.org/~testdashboard/ci?branch=3Dbcachefs-tes=
ting
> >
> > > > For example looking at the sample test there it looks like it needs
> > > > among other things mkfs.btrfs, bcachefs, stress-ng, xfs_io, fio, md=
adm,
> > > > rsync
> >
> > > Getting all that set up by the end user is one command:
> > >   ktest/root_image create
> > > and running a test is one morecommand:
> > > build-test-kernel run ~/ktest/tests/bcachefs/single_device.ktest
> >
> > That does assume that you're building and running everything directly o=
n
> > the system under test and are happy to have the test in a VM which isn'=
t
> > an assumption that holds universally, and also that whoever's doing the
> > testing doesn't want to do something like use their own distro or
> > something - like I say none of it looks too unreasonable for
> > filesystems.
>
> No, I'm doing it that way because technically that's the simplest way to
> do it.
>
> All you guys building crazy contraptions for running tests on Google
> Cloud or Amazon or whatever - you're building technical workarounds for
> broken procurement.
>
> Just requisition the damn machines.
>

Running in the cloud does not mean it has to be complicated. It can be
a simple Buildbot or whatever that knows how to spawn spot instances
for tests and destroy them when they're done *if the test passed*. If
a test failed on an instance, it could hold onto them for a day or two
for someone to debug if needed.

(I mention Buildbot because in a previous life, I used that to run
tests for the dattobd out-of-tree kernel module before. That was the
strategy I used for it.)

> > Some will be, some will have more demanding requirements especially whe=
n
> > you want to test on actual hardware rather than in a VM.  For example
> > with my own test setup which is more focused on hardware the operating
> > costs aren't such a big deal but I've got boards that are for various
> > reasons irreplaceable, often single instances of boards (which makes
> > scheduling a thing) and for some of the tests I'd like to get around to
> > setting up I need special physical setup.  Some of the hardware I'd lik=
e
> > to cover is only available in machines which are in various respects
> > annoying to automate, I've got a couple of unused systems waiting for m=
e
> > to have sufficient bandwidth to work out how to automate them.  Either
> > way I don't think the costs are trival enough to be completely handwave=
d
> > away.
>
> That does complicate things.
>
> I'd also really like to get automated performance testing going too,
> which would have similar requirements in that jobs would need to be
> scheduled on specific dedicated machines. I think what you're doing
> could still build off of some common infrastructure.
>
> > I'd also note that the 9 hour turnaround time for that test set you're
> > pointing at isn't exactly what I'd associate with immediate feedback.
>
> My CI shards at the subtest level, and like I mentioned I run 10 VMs per
> physical machine, so with just 2 of the 80 core Ampere boxes I get full
> test runs done in ~20 minutes.
>

This design, ironically, is way more cloud-friendly than a lot of
testing system designs I've seen in the past. :)


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

