Return-Path: <linux-fsdevel+bounces-5411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04F80B5CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 19:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F50E1F2107A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202C199D4;
	Sat,  9 Dec 2023 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KcM8ubeZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CEE1
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Dec 2023 10:09:10 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b9df0a6560so1878499b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Dec 2023 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702145349; x=1702750149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9fd3nK4gaKj/m4ObcGfIc63MHpKE1xTE/ZO9yPs86o=;
        b=KcM8ubeZk4oRYvN2EtsfYT6qvOWrP3tK0d6hyeWNpcIYz265kjNQ+xnqOShzy4aBiI
         Yfhpo9C8+yraqup27UDDSMoUvnCpSxekcViHor7krGQi7JMNz6hBLkLovvJw2bBzJ0Fe
         oCRsMcD1cqsr/K9O+o9XeCl252517GPuz/jEkZ6Qj7UQUr/DNiIXKXuzpQNyis1HO2y1
         09YGKvgv8tnyHad7szn9uydoWlkSe2C/7YFZ6fCLbO18Z7dpSiIGTIUTIRSRqQRdaSIC
         OsOBOsMzU6DUDUEQdS0Z+gPLuC7CjDBL6T+80X1PRQjkFFMcs9ktwD0lasIBsm2aRkDZ
         kr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702145349; x=1702750149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9fd3nK4gaKj/m4ObcGfIc63MHpKE1xTE/ZO9yPs86o=;
        b=A5GPzBk0opCfpK4t3xfcpveWm1NW03ZX3QC+Ta31Hc3RfcAB931cvk6bTXKlYYFYV5
         742XOT/lEJVzgEyQTe47Kcb9IaJPB0rS/6jqc7FGIn2EvBFTYmFfNwKRoXtp48YZxh3r
         loqsXzJEeR/S2FNCNOB5KvxSHFx9oVnYDYbb+dNABw84dGWdI0wrAzNJwlIUVBfmE9+6
         gE7gNPBq7c4QvF/IFfnHMBIPE9nOebK2AuH1Z4x0ZV4e6maY31+yGRXaDWhxJHGqgbJ0
         AJxwVpNbItRP9At+QpqJV06rRmQfdvgo4kcQBypU/edZJd0c+uPmbz2wUFkqfjorLnWz
         B+jQ==
X-Gm-Message-State: AOJu0Yza4Rm4EO4OGi1nLeopGRhAlGJKd5fX7j3pdR1dsKDHWdM/9Fjt
	b+iLBk3AANCp3xRrb9w9IjpDWuQJpI11LdCumxao8Fdzcmoy7LQ=
X-Google-Smtp-Source: AGHT+IEtigvySps8OW7w1FF3Y2wIbCYHAisp7E1ogUPkLKd2u2PmC9Fhcvbx3W7++Cn9O8EVSsOUaZ3DlhJ0WALLLCE=
X-Received: by 2002:a05:6808:22a4:b0:3b9:e33a:8b2d with SMTP id
 bo36-20020a05680822a400b003b9e33a8b2dmr2101568oib.0.1702145349399; Sat, 09
 Dec 2023 10:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com> <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
 <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com> <CAHC9VhQyziaxvbCCfb4YWQ0-L0qASa-yHG4tuNfbnNLecKDG0A@mail.gmail.com>
 <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com>
In-Reply-To: <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 9 Dec 2023 13:08:58 -0500
Message-ID: <CAHC9VhT_m6+a2fOCJcdjhx0dUdWDxtZEu3yXCyy+1cSr6GFBag@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Munehisa Kamata <kamatam@amazon.com>, adobriyan@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 7:24=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 12/8/2023 3:32 PM, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> >>> On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@amazo=
n.com> wrote:
> >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> >>> ..
> >>>
> >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" commen=
t
> >>>>> at the top.  However, before we go too much further on this, can we
> >>>>> get clarification that Casey was able to reproduce this on a stock
> >>>>> upstream kernel?  Last I read in the other thread Casey wasn't seei=
ng
> >>>>> this problem on Linux v6.5.
> >>>>>
> >>>>> However, for the moment I'm going to assume this is a real problem,=
 is
> >>>>> there some reason why the existing pid_revalidate() code is not bei=
ng
> >>>>> called in the bind mount case?  From what I can see in the original
> >>>>> problem report, the path walk seems to work okay when the file is
> >>>>> accessed directly from /proc, but fails when done on the bind mount=
.
> >>>>> Is there some problem with revalidating dentrys on bind mounts?
> >>>> Hi Paul,
> >>>>
> >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.li=
nux.org.uk/
> >>>>
> >>>> After reading this thread, I have doubt about solving this in VFS.
> >>>> Honestly, however, I'm not sure if it's entirely relevant today.
> >>> Have you tried simply mounting proc a second time instead of using a =
bind mount?
> >>>
> >>>  % mount -t proc non /new/location/for/proc
> >>>
> >>> I ask because from your description it appears that proc does the
> >>> right thing with respect to revalidation, it only becomes an issue
> >>> when accessing proc through a bind mount.  Or did I misunderstand the
> >>> problem?
> >> It's not hard to make the problem go away by performing some simple
> >> action. I was unable to reproduce the problem initially because I
> >> checked the Smack label on the bind mounted proc entry before doing
> >> the cat of it. The problem shows up if nothing happens to update the
> >> inode.
> > A good point.
> >
> > I'm kinda thinking we just leave things as-is, especially since the
> > proposed fix isn't something anyone is really excited about.
>
> "We have to compromise the performance of our sandboxing tool because of
> a kernel bug that's known and for which a fix is available."
>
> If this were just a curiosity that wasn't affecting real development I
> might agree. But we've got a real world problem, and I don't see ignoring
> it as a good approach. I can't see maintainers of other LSMs thinking so
> if this were interfering with their users.

While the reproducer may be written for Smack, there are plenty of
indications that this applies to all LSMs and my comments have taken
that into account.

If you're really that upset, try channeling that outrage into your
editor and draft a patch for this that isn't awful.

--=20
paul-moore.com

