Return-Path: <linux-fsdevel+bounces-3669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A87F767C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488B8282348
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98342D631;
	Fri, 24 Nov 2023 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDesW49T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B719A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 06:39:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso21875a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700836739; x=1701441539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qT9ijJ1bpTu4n/ZbJUawbOnA+vfnCrxXXqloSbnIeQ=;
        b=yDesW49T0+1evvm89TEnbWe/ZJLfnelZU76CL2gT+DrlXkFsU8RJ9HXX7T4xBS3nqG
         YWvsclM5ILHTglF4+l518OLadzDDUjzfi0cwS0+rRB+kzOrai1+Ovgyb3G5TJFIba6H1
         m9822nmo4TsdOkRtMaEfcpUlX1CgNMFRhmRNLpQsvNVrJjA/9hco8fRTkBs7v70cXe5r
         OjnqoxQ22Kdrr+091RVsrfNbDXrOrLgdhxYzn7a1MuSpkQ5lNR9UmGK5HBx90kGv72RW
         tX94HqQfSjb/6rLy7V6LkgrKhSNkA+Wlr+bv2DHqly7Xz3JUm71fCb3c4Cy++mbMmlfo
         T4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836739; x=1701441539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qT9ijJ1bpTu4n/ZbJUawbOnA+vfnCrxXXqloSbnIeQ=;
        b=ooMUnNPWHztgTfaiuPjTv/BYhRkGVwH+BcfSk3DnfEWpQb/1EmvHy3M8CQ4Zt7cOqk
         b43zzKIVAkun20NPTpeIepv9VBT0g4gV3OcgNSPZX9BVIRP92D0FX7ClMzFVZIyksYH0
         mIDU602wEso4OLIcpttAul/wcOzsEV3tHNAS/sxoymAWPL8lGsjG3+hHe5NADA7UqqzQ
         efVJq2CaiolaIZIB96ipVf3zNP+jCoz3dKrTgMI5rIK8z/+ISeQMz7IjZk57Etoas5Sr
         F3VjMZouuxMzMwMwYr1DQEmDH63W5LlV72y1zXBkf0w5ck5GDe91FQVsYRmZpEe0O6Pw
         rpbw==
X-Gm-Message-State: AOJu0YzWpGgJ6B4bwOK8/NK94rcK+z/JJomfTjes29r1P2jczpTN62rc
	XJMHG44QT1GCio4rBLMfRz2JnPOpnixWzdTkPpEYrwHGMcNqhpqXHmJXAPss
X-Google-Smtp-Source: AGHT+IEwCRCbej1gpkzx1rDgRxtOawzgZqRxAM9eZ4PKnqgFfodjGkhCziVIgeTfKfYyIu0AX68Mln+3VK3DNpzt/f4=
X-Received: by 2002:a05:6402:11c6:b0:54a:ee8b:7a8c with SMTP id
 j6-20020a05640211c600b0054aee8b7a8cmr102165edw.0.1700836738829; Fri, 24 Nov
 2023 06:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000778f1005dab1558e@google.com> <CAG48ez2AAk6JpZAA6GPVgvCmKimXHJXO906e=r=WGU06k=HB3A@mail.gmail.com>
 <1037989.1647878628@warthog.procyon.org.uk> <CAG48ez1+4dbZ9Vi8N4NKCtGwuXErkUs6bC=8Pf+6jiZbxrwR7g@mail.gmail.com>
In-Reply-To: <CAG48ez1+4dbZ9Vi8N4NKCtGwuXErkUs6bC=8Pf+6jiZbxrwR7g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Nov 2023 15:38:21 +0100
Message-ID: <CAG48ez3AazYzfJCFgu2MKSoxMEpJXz0td+rbeCOhsM38i78m3A@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in pipe_write
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2022 at 5:17=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Mon, Mar 21, 2022 at 5:03 PM David Howells <dhowells@redhat.com> wrote=
:
> > Jann Horn <jannh@google.com> wrote:
> >
> > > The syz reproducer is:
> > >
> > > #{"threaded":true,"procs":1,"slowdown":1,"sandbox":"","close_fds":fal=
se}
> > > pipe(&(0x7f0000000240)=3D{<r0=3D>0xffffffffffffffff, <r1=3D>0xfffffff=
fffffffff})
> > > pipe2(&(0x7f00000001c0)=3D{0xffffffffffffffff, <r2=3D>0xfffffffffffff=
fff}, 0x80)
> > > splice(r0, 0x0, r2, 0x0, 0x1ff, 0x0)
> > > vmsplice(r1, &(0x7f00000006c0)=3D[{&(0x7f0000000080)=3D"b5", 0x1}], 0=
x1, 0x0)
> > >
> > > That 0x80 is O_NOTIFICATION_PIPE (=3D=3DO_EXCL).
> > >
> > > It looks like the bug is that when you try to splice between a normal
> > > pipe and a notification pipe, get_pipe_info(..., true) fails, so
> > > splice() falls back to treating the notification pipe like a normal
> > > pipe - so we end up in iter_file_splice_write(), which first locks th=
e
> > > input pipe, then calls vfs_iter_write(), which locks the output pipe.
> > >
> > > I think this probably (?) can't actually lead to deadlocks, since
> > > you'd need another way to nest locking a normal pipe into locking a
> > > watch_queue pipe, but the lockdep annotations don't make that clear.
> >
> > Is this then a bug/feature in iter_file_splice_write() rather than in t=
he
> > watch queue code, per se?
>
> I think at least when you call splice() on two normal pipes from
> userspace, it'll never go through this codepath for real pipes,
> because pipe-to-pipe splicing is special-cased? And sendfile() bails
> out in that case because pipes don't have a .splice_read() handler.
>
> And with notification pipes, we don't take that special path in
> splice(), and so we hit the lockdep warning. But I don't know whether
> that makes it the fault of notification pipes...
>
> Maybe it would be enough to just move the "if (pipe->watch_queue)"
> check in pipe_write() up above the __pipe_lock(pipe)?

[coming back to this thread 1.5 years later...]
I've turned that idea into a fix, let's have syzbot try it out before
I submit the fix patch:

#syz test: https://github.com/thejh/linux.git 56c486e68166

