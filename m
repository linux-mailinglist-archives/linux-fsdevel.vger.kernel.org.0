Return-Path: <linux-fsdevel+bounces-2972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04587EE62B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20BD1F24EEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204012E62B;
	Thu, 16 Nov 2023 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K+hX561s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F31A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 09:53:30 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so1097860276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700157209; x=1700762009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2Vb+u1RmTRxHX92hIFMVccJ8K66QgR27jKH/mAHwq8=;
        b=K+hX561sF54prOV5JikxWGQzARWdwdTdZPLAsYKJM4oKWKQtlqhuLT0u9j/yiELKCB
         TbWnUxvB5qXYOgcZ2W0XUND8GHQAExtF50GhOWeeUSGpvvqoNa8sfIJeLzw1wAEQGfuo
         bOx8Yo50+0aQMKxPIXEZby3BiGC5qU8ODPBKy47T08F0ccdSf07oxBUeEaiREfcETu/D
         /+hAmwrwyEv0jrYqqPFvyw9IU2QuOD8nUSOqGxINDGmKkBgvivrNWbSoU6Jug4bu88Bn
         /g+031FIcfdFGouvJfWAPW0Mv4vIZhw9HqHVcSHLCNN0ywUWlrZv7LGlSdiFfPJH6hz8
         Jmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157209; x=1700762009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2Vb+u1RmTRxHX92hIFMVccJ8K66QgR27jKH/mAHwq8=;
        b=fgxsLJhP6GCFNsUlfiQCQGzd4VIN5uipvx2fiDDVYTy+VxW5oMrAST1IYONgHTMHVr
         0HcMJXhU2IvuUiFLjdiAhO8kWhB+wG3fgBL+7KqsgAhbXycIAtlF/H1LHTVNzZoARh4W
         W6HnmfGaUGgbDtt1aZz/PwMH3WmMPh5Na3O0mjlIRGP4uEb9MVR4cxfqJzUm6dZaQVxd
         PeuRG0xaFMyqPMlWjmmkRejjMe7TYi0TkZASfn8hlMGbWvCMhZrSOtu1GtwPtQqvDdcJ
         xRgNPQ1DU2o1GpOVNBWfX+K8SIhs3HyxPWFCT5kj9avgtLm7K9rTG7fce8mMPVs8BZX2
         VpJA==
X-Gm-Message-State: AOJu0Yz1dOdklUkJondzu+qDnmq9wSepqDcUa8GqiDDB4PuOktciAJlk
	HqyJNNTFoXqv5Un5VVJMSxNd9LJTRfLqReuDI4h9XqkNUoC168CO6w==
X-Google-Smtp-Source: AGHT+IEvd+6ZHBTCZ5DReJ5Sn8TFMgwYhIYsp56Z8cd+OyxYPkdZeThPKx5ClBlbuILzYDZE1mMrDXY7MXrhuIXzQp4=
X-Received: by 2002:a25:adce:0:b0:db0:3039:2444 with SMTP id
 d14-20020a25adce000000b00db030392444mr5776701ybe.41.1700157209021; Thu, 16
 Nov 2023 09:53:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
 <CAHC9VhQQ-xbV-dVvTm26LaQ8F+0iW+Z0SMXdZ9MeDBJ7z2x4xg@mail.gmail.com>
 <CAEjxPJ5YiW62qQEfpEDfSrav_43J7SeYYbBqV8YPRdpqBizAQw@mail.gmail.com>
 <CAEjxPJ5rL9aYxZq8nbB-gBfmNUM_s6+h8Q7C2jYYyP5M9O6z3Q@mail.gmail.com> <CAEjxPJ7-YtZSpiN63Gjc_zmnSh8yzH-iW_YkOnwbYNF0uNLPCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7-YtZSpiN63Gjc_zmnSh8yzH-iW_YkOnwbYNF0uNLPCA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 12:53:18 -0500
Message-ID: <CAHC9VhS0rRnhXDdD+FHtzZhYO0FS5cP9gZLOp1X0-_N0dhE1Vg@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 9:31=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Nov 16, 2023 at 8:16=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Nov 15, 2023 at 8:35=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Nov 14, 2023 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Tue, Nov 14, 2023 at 3:57=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Mon, Nov 13, 2023 at 11:19=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > > On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.lin=
ux.org.uk> wrote:
> > > > > > >
> > > > > > > [
> > > > > > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > > > > > lock_rename()-related followups in another branch, so a pull =
would be more
> > > > > > > convenient for me than cherry-pick.  NOTE: testing and commen=
ts would
> > > > > > > be very welcome - as it is, the patch is pretty much untested=
 beyond
> > > > > > > "it builds".
> > > > > > > ]
> > > > > >
> > > > > > Hi Al,
> > > > > >
> > > > > > I will admit to glossing over the comment above when I merged t=
his
> > > > > > into the selinux/dev branch last night.  As it's been a few wee=
ks, I'm
> > > > > > not sure if the comment above still applies, but if it does let=
 me
> > > > > > know and I can yank/revert the patch in favor of a larger pull.=
  Let
> > > > > > me know what you'd like to do.
> > > > >
> > > > > Seeing this during testsuite runs:
> > > > >
> > > > > [ 3550.206423] SELinux:  Converting 1152 SID table entries...
> > > > > [ 3550.666195] ------------[ cut here ]------------
> > > > > [ 3550.666201] WARNING: CPU: 3 PID: 12300 at fs/inode.c:330 drop_=
nlink+0x57/0x70
> > > >
> > > > How are you running the test suite Stephen?  I haven't hit this in =
my
> > > > automated testing and I did another test run manually to make sure =
I
> > > > wasn't missing it and everything ran clean.
> > > >
> > > > I'm running the latest selinux-testsuite on a current Rawhide syste=
m
> > > > with kernel 6.7.0-0.rc1.20231114git9bacdd89.17.1.secnext.fc40 (curr=
ent
> > > > Rawhide kernel + the LSM, SELinux, and audit dev trees).
> > >
> > > Technically this was with a kernel built from your dev branch plus
> > > Ondrej's selinux: introduce an initial SID for early boot processes
> > > patch, but I don't see how the latter could introduce such a bug. Wil=
l
> > > retry without it.
> >
> > Reproduced without Ondrej's patch; the trick seems to be accessing
> > selinuxfs files during the testsuite run (likely interleaving with
> > policy reloads).
> > while true; do cat /sys/fs/selinux/initial_contexts/kernel ; done &
> > while running the testsuite seems to trigger.
> > Could also try while true; do sudo load_policy; done & in parallel
> > with the above loop.
> > In any event, will retry with Al's updated branch with the fix he propo=
sed.

Ah ha!  That would definitely explain why I didn't see it in my test
runs, I generally don't do anything on the test system when the test
is running.

> So far not showing up with Al's updated for-selinux branch. Difference
> between that and your dev branch for selinuxfs is what he showed
> earlier in the thread (pardon the whitespace damage) ...

I just updated the selinux/dev branch with the change from Al's tree.
Considering the minor nature of the fix, and the other patches
currently in flight on the list, I just updated the original commit
(with a note) and did a force push; I doubt that will cause issues
with anyone, but as I try to avoid force pushes on the */dev branches
I thought it was worth mentioning.

Thanks everyone!

--=20
paul-moore.com

