Return-Path: <linux-fsdevel+bounces-2894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE07EC3CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F942813FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8651EB2B;
	Wed, 15 Nov 2023 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUDSUGT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04F1A707
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 13:35:52 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B441AB;
	Wed, 15 Nov 2023 05:35:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso436107a91.2;
        Wed, 15 Nov 2023 05:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700055349; x=1700660149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WKLA67sckG/YxYt7nxdmB+FITyFUdNI9L+yvzeaUZ4=;
        b=SUDSUGT0aKJe/EmIsf3ZebP4ZipQ5aqjTUt9tP2hs67ED/FWpDYL8fXOcuihO7svSl
         nOZB2rmi6Zg55KmbL8Rm3o8dd7VuNhQWLtK3Y05xQxoY7GC10ndaxA6FGgucqjk9Lc1E
         ycnnK/7LaMmnrG2F/m6ZjKCJyJUB76N4sKTUyE820IsfOhsqWhJIcNAU7j274Cs9nEvk
         7UqsqyCS2QAIdn2PtAU/CIczfSGLd+0NTh1xISWKYdvBENe+t0PYbT+7Hr5Mvh98a+hv
         bdA83hp8N2T7VmPYfmyszPhVO6dx5xbCGVGLZ79/KqVJ2qcq3r3Yeet7xYyzEY1BxiaC
         BROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055349; x=1700660149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WKLA67sckG/YxYt7nxdmB+FITyFUdNI9L+yvzeaUZ4=;
        b=XorpKxbI5sd2rTP8ZsFz/HJTmIzmc0TF0PaQr79wOxxKUXOin5sxYDQrAwlWzOARD2
         IhIFOvihgbTjku/KewyuaW/XRPjAgOvMy75l+l52AmbHMs4gGkjhoISN9QSpqWK+gAuZ
         s+OfUWQ5YwS/0/0es6D4IxpIgVLKmrsu8c2DDeSfr9EWFvZ3HqlaHkCkPhuCvbS+TEo6
         z5aaWBj9F2IDRtsLlVfTOqXEI4yD2BFuFCsR1P8eGl7w9E9kY65w58aXzmnsUNc1AJj5
         KNJv6E9LfJV1Dkp+dwrvFw2G6Ae2I1S7KX+OcTqVC2nxHJozBMQPzCLlvTBOs5orKctz
         Tqug==
X-Gm-Message-State: AOJu0YzkLyisCdkyxCLRwYe6AuRjM/knbGl9nSG5nAGx4y1ydZkWOMBC
	NQk4ri9zgbQUeUvhFpL5tlj2kmygMCIO8+haBJbUuD6p
X-Google-Smtp-Source: AGHT+IHsW/+/RQcJaPtz9YmStyH1m3JrokCYGV97FpHsXKKuIJTXz+RKtv3usxVyKuYVKymTl5DGitQMEAnLIh4Nvzk=
X-Received: by 2002:a17:90b:4ad1:b0:27d:375a:e322 with SMTP id
 mh17-20020a17090b4ad100b0027d375ae322mr10972703pjb.31.1700055349133; Wed, 15
 Nov 2023 05:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com> <CAHC9VhQQ-xbV-dVvTm26LaQ8F+0iW+Z0SMXdZ9MeDBJ7z2x4xg@mail.gmail.com>
In-Reply-To: <CAHC9VhQQ-xbV-dVvTm26LaQ8F+0iW+Z0SMXdZ9MeDBJ7z2x4xg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 15 Nov 2023 08:35:37 -0500
Message-ID: <CAEjxPJ5YiW62qQEfpEDfSrav_43J7SeYYbBqV8YPRdpqBizAQw@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Nov 14, 2023 at 3:57=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Nov 13, 2023 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org=
.uk> wrote:
> > > >
> > > > [
> > > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > > lock_rename()-related followups in another branch, so a pull would =
be more
> > > > convenient for me than cherry-pick.  NOTE: testing and comments wou=
ld
> > > > be very welcome - as it is, the patch is pretty much untested beyon=
d
> > > > "it builds".
> > > > ]
> > >
> > > Hi Al,
> > >
> > > I will admit to glossing over the comment above when I merged this
> > > into the selinux/dev branch last night.  As it's been a few weeks, I'=
m
> > > not sure if the comment above still applies, but if it does let me
> > > know and I can yank/revert the patch in favor of a larger pull.  Let
> > > me know what you'd like to do.
> >
> > Seeing this during testsuite runs:
> >
> > [ 3550.206423] SELinux:  Converting 1152 SID table entries...
> > [ 3550.666195] ------------[ cut here ]------------
> > [ 3550.666201] WARNING: CPU: 3 PID: 12300 at fs/inode.c:330 drop_nlink+=
0x57/0x70
>
> How are you running the test suite Stephen?  I haven't hit this in my
> automated testing and I did another test run manually to make sure I
> wasn't missing it and everything ran clean.
>
> I'm running the latest selinux-testsuite on a current Rawhide system
> with kernel 6.7.0-0.rc1.20231114git9bacdd89.17.1.secnext.fc40 (current
> Rawhide kernel + the LSM, SELinux, and audit dev trees).

Technically this was with a kernel built from your dev branch plus
Ondrej's selinux: introduce an initial SID for early boot processes
patch, but I don't see how the latter could introduce such a bug. Will
retry without it.

