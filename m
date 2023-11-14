Return-Path: <linux-fsdevel+bounces-2875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606887EB948
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 23:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBF281318
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D942E843;
	Tue, 14 Nov 2023 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bJHHFj/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147C2E83A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 22:24:34 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D80DDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 14:24:33 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a822f96aedso72903457b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700000672; x=1700605472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/lLeWt7vOF/PJgPrkSuq9lzzhGIQmGMwr1dnmP0LZ8=;
        b=bJHHFj/uhodv7UHgmR0Gsrb1IfjKIxuzAjbCM+LAoqAndwF8CMwkxhrDzfeCqpmEFa
         EhlJmnan0yp2Y8yevgFkjLzJDjFlxxj2AIeQc9f/aWAsygZl+7oop0Y4QXt/JvxD+k1T
         Cj00CXzGtYpOjBFx8kzEnUrb83Hphxy7xS6kJ0nk7PT610E1FT64Wt/MCJkWz/nws4y7
         0HAQPKKhX59+rrvmuUu3TALXtJfNxyyKwZ6WUUHXd6P+IBTwzBQCQalFUS3+74kD8aGY
         EMOWT9AOTyYxgf54ShLsWqLGvcRI1MKLGLp2RzpVbeTK0BvCLQ4aRjR/hZE52WYnRukQ
         Er9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700000672; x=1700605472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/lLeWt7vOF/PJgPrkSuq9lzzhGIQmGMwr1dnmP0LZ8=;
        b=rOSne0wMBg9jyh4ldW40xa91ai1U3lfUJuFInnJ/AdSj2IdcX2/rnwPTQI2h60x34s
         4j/Gr6Z47gWlq7VB0OJOGXnxWz2K8YbMN6SN2f65cTCYmPQ45UtofZoMr5x6/oc/T070
         LCtscplf8p4GfGwC0pIJTh58HYCMCovjVysBMAugepnj48vddQV9ucNabMJcZhIaMg1E
         Mln/sekVSSdhVLRLL7AG5J+GYjDzSmYQ8+rYRzPaydlHLTqqY6dO8BPgUT6c2W1E9K81
         /eipa3BAo+Yan+PtxsVeYunwJf77ETeRLwA2o+Uks+vSo3pi+oFAPmeSRO3B1N3M4l9p
         1APA==
X-Gm-Message-State: AOJu0Yzhc4gM/+5amT2YdGGy+mstMNMfeB2Izh6bkr7aNzvPXwqZ5n3v
	ZayUxG9WDoRO7Jg6pplZs3JqG3o/WWmgTT3NBA0c
X-Google-Smtp-Source: AGHT+IE4NbSQI/ApmHYg+WezQFmQeL5oHdj3CUGVySbuEVawuQXhWijLxzNAWax1cpVpQp2eRaQj+Y2JS+0I4PAh9KQ=
X-Received: by 2002:a25:df83:0:b0:d9b:e8bf:4703 with SMTP id
 w125-20020a25df83000000b00d9be8bf4703mr11018483ybg.10.1700000672338; Tue, 14
 Nov 2023 14:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Nov 2023 17:24:21 -0500
Message-ID: <CAHC9VhQQ-xbV-dVvTm26LaQ8F+0iW+Z0SMXdZ9MeDBJ7z2x4xg@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 3:57=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Nov 13, 2023 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > [
> > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > lock_rename()-related followups in another branch, so a pull would be=
 more
> > > convenient for me than cherry-pick.  NOTE: testing and comments would
> > > be very welcome - as it is, the patch is pretty much untested beyond
> > > "it builds".
> > > ]
> >
> > Hi Al,
> >
> > I will admit to glossing over the comment above when I merged this
> > into the selinux/dev branch last night.  As it's been a few weeks, I'm
> > not sure if the comment above still applies, but if it does let me
> > know and I can yank/revert the patch in favor of a larger pull.  Let
> > me know what you'd like to do.
>
> Seeing this during testsuite runs:
>
> [ 3550.206423] SELinux:  Converting 1152 SID table entries...
> [ 3550.666195] ------------[ cut here ]------------
> [ 3550.666201] WARNING: CPU: 3 PID: 12300 at fs/inode.c:330 drop_nlink+0x=
57/0x70

How are you running the test suite Stephen?  I haven't hit this in my
automated testing and I did another test run manually to make sure I
wasn't missing it and everything ran clean.

I'm running the latest selinux-testsuite on a current Rawhide system
with kernel 6.7.0-0.rc1.20231114git9bacdd89.17.1.secnext.fc40 (current
Rawhide kernel + the LSM, SELinux, and audit dev trees).

--=20
paul-moore.com

