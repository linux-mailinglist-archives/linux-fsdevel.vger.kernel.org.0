Return-Path: <linux-fsdevel+bounces-5442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2580BD66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 22:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE401C208BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628F1D52D;
	Sun, 10 Dec 2023 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cyj0z9Pm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E48F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 13:45:45 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so4000272276.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702244744; x=1702849544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgomHD3GVYM/kyyJWAACzgD5VBx9Vq1cbJY4IH6lIlQ=;
        b=Cyj0z9PmbV/M83OzIwMsNTabn79jIC1Nx9dvEvKm3tZ773qG6qR+kYtg3TVhVbmSvY
         oAM7+ZhIDyWHGZdi1gs3YLuAb0/rIO159Gld+hgMy5f9Mucl2dqqloqtg8sTn49XlaNK
         ojRyW0RvW/dbwk3dWsnvTAR3+Y0mWnXfH3Lu6S+XKuaiL/5WnRS+7NhBm6Pr34IYhiGO
         XkCtUvYvQSR5H+mEETpj5/RqUt729rhJK/83fjMa27hSOSU4X7vv6KnH0mt2Au0cijLN
         jw0/CL7PcT9vF6GZNKfu2e6ZTsM/BuWcJENqOWuRASgCpj3sAD8I4wY2ALdNNqFR40+G
         vWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702244744; x=1702849544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgomHD3GVYM/kyyJWAACzgD5VBx9Vq1cbJY4IH6lIlQ=;
        b=hn4g1rZUs7p2eNqygTlQFxEo4Y62Sz5AWM8UhtuS7ufC4jrIiMbjcJ2NMvZ5xl7isb
         5IAhow9n6X/pf+QanJh2BqLHgPNToZal0BXxJTvSkTeojw+iXin63Ddx1e+vVJDJme84
         IsYyto7LRn6zWll4FodB0TN9kVoSvajrAiWtqIGKRU2J3PE59cU1l/ZwHMsuhXWnjuIq
         IALAu6BpOIC5fs8n8BxVJRbHLPTXdDxiAk+i6bdcJVUP9WVCwo8dNcYsirXCzCe5EHxn
         /Apxo4vu6AuAP2fMVce8JF/G7S4QNyj9ztxgdMITIn7ha97lrrxtBZK5baCVzejauJrK
         mw7w==
X-Gm-Message-State: AOJu0YycrO2S3/LZjmuRwIMqPvIADfc4Vwd5LeKlowgDCalqFRSYj5QP
	XdadybJjmaanphueA6jWEEjPlogShesmb+Mpekw9
X-Google-Smtp-Source: AGHT+IH7sTbNy4Vf1JdDrdGxEGhP0CD8OmrdLsv/F71llTCrgL1k+iOXuUpoxPOfab5fNmw9SS30LcP15EoKlxW9rKY=
X-Received: by 2002:a25:260c:0:b0:db7:dad0:60ea with SMTP id
 m12-20020a25260c000000b00db7dad060eamr1919382ybm.119.1702244744319; Sun, 10
 Dec 2023 13:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com> <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
 <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com> <CAHC9VhQyziaxvbCCfb4YWQ0-L0qASa-yHG4tuNfbnNLecKDG0A@mail.gmail.com>
 <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com> <CAHC9VhT_m6+a2fOCJcdjhx0dUdWDxtZEu3yXCyy+1cSr6GFBag@mail.gmail.com>
 <5b61d1a4-89a0-4ec3-9832-9cb84552fba7@schaufler-ca.com>
In-Reply-To: <5b61d1a4-89a0-4ec3-9832-9cb84552fba7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 10 Dec 2023 16:45:33 -0500
Message-ID: <CAHC9VhR2Y08sMHSuqP8AONP9KFyRhRizPDgvt9pxLTtKS9Jzfw@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Munehisa Kamata <kamatam@amazon.com>, adobriyan@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 1:35=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 12/9/2023 10:08 AM, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 7:24=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 12/8/2023 3:32 PM, Paul Moore wrote:
> >>> On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >>>> On 12/8/2023 2:43 PM, Paul Moore wrote:
> >>>>> On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@ama=
zon.com> wrote:
> >>>>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> >>>>> ..
> >>>>>
> >>>>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comm=
ent
> >>>>>>> at the top.  However, before we go too much further on this, can =
we
> >>>>>>> get clarification that Casey was able to reproduce this on a stoc=
k
> >>>>>>> upstream kernel?  Last I read in the other thread Casey wasn't se=
eing
> >>>>>>> this problem on Linux v6.5.
> >>>>>>>
> >>>>>>> However, for the moment I'm going to assume this is a real proble=
m, is
> >>>>>>> there some reason why the existing pid_revalidate() code is not b=
eing
> >>>>>>> called in the bind mount case?  From what I can see in the origin=
al
> >>>>>>> problem report, the path walk seems to work okay when the file is
> >>>>>>> accessed directly from /proc, but fails when done on the bind mou=
nt.
> >>>>>>> Is there some problem with revalidating dentrys on bind mounts?
> >>>>>> Hi Paul,
> >>>>>>
> >>>>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.=
linux.org.uk/
> >>>>>>
> >>>>>> After reading this thread, I have doubt about solving this in VFS.
> >>>>>> Honestly, however, I'm not sure if it's entirely relevant today.
> >>>>> Have you tried simply mounting proc a second time instead of using =
a bind mount?
> >>>>>
> >>>>>  % mount -t proc non /new/location/for/proc
> >>>>>
> >>>>> I ask because from your description it appears that proc does the
> >>>>> right thing with respect to revalidation, it only becomes an issue
> >>>>> when accessing proc through a bind mount.  Or did I misunderstand t=
he
> >>>>> problem?
> >>>> It's not hard to make the problem go away by performing some simple
> >>>> action. I was unable to reproduce the problem initially because I
> >>>> checked the Smack label on the bind mounted proc entry before doing
> >>>> the cat of it. The problem shows up if nothing happens to update the
> >>>> inode.
> >>> A good point.
> >>>
> >>> I'm kinda thinking we just leave things as-is, especially since the
> >>> proposed fix isn't something anyone is really excited about.
> >> "We have to compromise the performance of our sandboxing tool because =
of
> >> a kernel bug that's known and for which a fix is available."
> >>
> >> If this were just a curiosity that wasn't affecting real development I
> >> might agree. But we've got a real world problem, and I don't see ignor=
ing
> >> it as a good approach. I can't see maintainers of other LSMs thinking =
so
> >> if this were interfering with their users.
> > While the reproducer may be written for Smack, there are plenty of
> > indications that this applies to all LSMs and my comments have taken
> > that into account.
> >
> > If you're really that upset, try channeling that outrage into your
> > editor and draft a patch for this that isn't awful.
>
> We could "just" wait for the lsm_set_self_attr() syscall to land, and
> suggest that it be used instead of the buggy /proc interfaces.

You didn't like the "as-is" approach before, I'm a little surprised
with the change in heart in less than 24 hours ...

> I would love to propose a patch that's less sucky, but have not come
> up with one. My understanding of VFS internals isn't up to the task,
> I fear.

I'm not convinced we've properly identified the root cause of the
problem, once we have it might be easier to identify a solution.

--=20
paul-moore.com

