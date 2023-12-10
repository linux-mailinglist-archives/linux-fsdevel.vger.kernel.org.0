Return-Path: <linux-fsdevel+bounces-5443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A194480BD6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 22:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A481F20F26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7691D533;
	Sun, 10 Dec 2023 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZmZkcjT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E26F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 13:52:58 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5c85e8fdd2dso36445597b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702245178; x=1702849978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHs8yYlfKwwc89x4m519U5rj021HblXAEEdZWCp+oQg=;
        b=ZmZkcjT5tunvPkX4nvQoJWByoqUed7sRDQju+COgAqyT+ZdM2ATmPB7m3haO2MT3Cq
         wnXuC1iZC8N1N/NclzBRJL4fI7XOpekApZm9cZVbtYy2s8vgzYlKMgIw/HMTzpL/iLll
         R63Htjq5K387U/ECXgDTZyGlpLxpgDXZlbljw5qI5MWOENRVHr7TdHKQyGRzHgHB3VDK
         JlrNXo+qLXmGzIEq7vzk+PrW7tpi5Ed529nKz/C9TxRO81QCheM6cfnuzRfy3i2oFaJk
         ltQQqvs4zFb7Cqh9RdGe0muLLhVLiG1O5WWYsaGtz/25kXYG9G3GdjCbcjOd05CAUwPp
         zqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702245178; x=1702849978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHs8yYlfKwwc89x4m519U5rj021HblXAEEdZWCp+oQg=;
        b=qAnWUCY5eZf1jHS95AIwKaEYvFAXG0AWdCRyWWrBdGGKV0kS0s5zJ1iMipjANyUbEz
         mUrP5rmri/Bkx4sqHsqXDbEng7Ks0+IvbOIxFBpSVOJQU3POHOOwJV5o/ONhsg1a5J9B
         HUI2Zh/M2lgAtYVB7c1+RYXtpbKcffmHs0jf9K+0dqUIkxApvos0OHCXbAzOfX4gDd6B
         8EIrJ3KeiakPda9imoUpZ0sRzoh/7hAXpNftzK4giE30aYcrBhrZuFQJawQWUQCr4/0Y
         6xW9kXQ08958C4GFdGQIUoMRaTjhUvvH/AwRT1xa5H4tZ+MWEGfUYA5YRbOyqFcLbR1j
         f34A==
X-Gm-Message-State: AOJu0Yx6Q/pWoclkb4VqwBsE76JGv+h6ni4+xVfpCd29+/2F2X2gqjMt
	nt4x7pBCIE8TiZtyJ+PERZ/6XdnxaIyjzyqImDz0
X-Google-Smtp-Source: AGHT+IGjAgIJw0+ofxr1CkfN2OUCHhIbXuEeCEd0GxdjHa6T/w9f7V05cm0Sqc+uSUVNVEaf9mLLkdEPN+AH2TRjzCg=
X-Received: by 2002:a81:d541:0:b0:5d3:37fe:54bb with SMTP id
 l1-20020a81d541000000b005d337fe54bbmr2445844ywj.15.1702245177921; Sun, 10 Dec
 2023 13:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSiyZ_keXs7s9Me19YWrdb7hcRY7XecMPdEcj7Den9Cbw@mail.gmail.com>
 <20231209211743.194275-1-kamatam@amazon.com>
In-Reply-To: <20231209211743.194275-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 10 Dec 2023 16:52:47 -0500
Message-ID: <CAHC9VhRyBeKPiy=BX+vm+_a7qcM5Pd-Svaw-kQbLpG-HbQOkVw@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, casey@schaufler-ca.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 4:17=E2=80=AFPM Munehisa Kamata <kamatam@amazon.com>=
 wrote:
> On Sat, 2023-12-09 10:10:32 -0800, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 8:11=E2=80=AFPM Munehisa Kamata <kamatam@amazon.=
com> wrote:
> > > On Sat, 2023-12-09 00:24:42 +0000, Casey Schaufler wrote:
> > > > On 12/8/2023 3:32 PM, Paul Moore wrote:
> > > > > On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@sch=
aufler-ca.com> wrote:
> > > > >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > > > >>> On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam=
@amazon.com> wrote:
> > > > >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > > > >>> ..
> > > > >>>
> > > > >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" =
comment
> > > > >>>>> at the top.  However, before we go too much further on this, =
can we
> > > > >>>>> get clarification that Casey was able to reproduce this on a =
stock
> > > > >>>>> upstream kernel?  Last I read in the other thread Casey wasn'=
t seeing
> > > > >>>>> this problem on Linux v6.5.
> > > > >>>>>
> > > > >>>>> However, for the moment I'm going to assume this is a real pr=
oblem, is
> > > > >>>>> there some reason why the existing pid_revalidate() code is n=
ot being
> > > > >>>>> called in the bind mount case?  From what I can see in the or=
iginal
> > > > >>>>> problem report, the path walk seems to work okay when the fil=
e is
> > > > >>>>> accessed directly from /proc, but fails when done on the bind=
 mount.
> > > > >>>>> Is there some problem with revalidating dentrys on bind mount=
s?
> > > > >>>> Hi Paul,
> > > > >>>>
> > > > >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@Ze=
nIV.linux.org.uk/
> > > > >>>>
> > > > >>>> After reading this thread, I have doubt about solving this in =
VFS.
> > > > >>>> Honestly, however, I'm not sure if it's entirely relevant toda=
y.
> > > > >>> Have you tried simply mounting proc a second time instead of us=
ing a bind mount?
> > > > >>>
> > > > >>>  % mount -t proc non /new/location/for/proc
> > > > >>>
> > > > >>> I ask because from your description it appears that proc does t=
he
> > > > >>> right thing with respect to revalidation, it only becomes an is=
sue
> > > > >>> when accessing proc through a bind mount.  Or did I misundersta=
nd the
> > > > >>> problem?
> > > > >> It's not hard to make the problem go away by performing some sim=
ple
> > > > >> action. I was unable to reproduce the problem initially because =
I
> > > > >> checked the Smack label on the bind mounted proc entry before do=
ing
> > > > >> the cat of it. The problem shows up if nothing happens to update=
 the
> > > > >> inode.
> > > > > A good point.
> > > > >
> > > > > I'm kinda thinking we just leave things as-is, especially since t=
he
> > > > > proposed fix isn't something anyone is really excited about.
> > > >
> > > > "We have to compromise the performance of our sandboxing tool becau=
se of
> > > > a kernel bug that's known and for which a fix is available."
> > > >
> > > > If this were just a curiosity that wasn't affecting real developmen=
t I
> > > > might agree. But we've got a real world problem, and I don't see ig=
noring
> > > > it as a good approach. I can't see maintainers of other LSMs thinki=
ng so
> > > > if this were interfering with their users.
> > >
> > > We do bind mount to make information exposed to the sandboxed task as=
 little
> > > as possible. We also create a separate PID namespace for each sandbox=
, but
> > > still want to bind mount even with it to hide system-wide and pid 1
> > > information from the task.
> > >
> > > So, yeah, I see this as a real problem for our use case and want to s=
eek an
> > > opinion about a possibly better fix.
> >
> > First, can you confirm that this doesn't happen if you do a second
> > proc mount instead of a bind mount of the original /proc as requested
> > previously?
>
> Mounting the entire /proc was considered and this doesn't happen with it.
> Although we still prefer to do bind mount for the reasons above and then
> seek a solution.

Ah, I had forgotten that you aren't bind mounting all of /proc, only a
PID specific directory.  I guess I'm not surprised this is behaving a
little odd in some corner cases and I'm even less inclined to support
a hack patch to handle this case; if we're going to fully support
this, the patch will need to be pretty clean.

--=20
paul-moore.com

