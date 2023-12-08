Return-Path: <linux-fsdevel+bounces-5391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FC80B09B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 00:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7831F213D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A435ABB5;
	Fri,  8 Dec 2023 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aH6QkAia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2E91716
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 15:33:00 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b9df0a6560so1419599b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702078379; x=1702683179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay9wzyB12eYmmiTWgs4BAuKgS+CO3Zor3St/DrG4wss=;
        b=aH6QkAia0Uw+lQbwy21kv67GPDlfkILD9fWKk1/Vf9ctxuQQGi2pRTifnfz2NyfJ61
         dx7a22Uos1y8AXwYY1Y7srM+Z1oZYRnjC97hBbN3Z61o3lAmYKy+gYvCIES6Wl24AUbc
         Z+4tYs3lkz5Tas4GvVc23bv1LYT/zcVbPqOpJ8itcfvIBLdCRHbh2kMV6LvZmr90i3WK
         sKxWrdHYbSCVDqO0lXbHmOoPIQjPBvG0b7m6i5jMi1LHnm9vBm0LzpHFSjpKA49NQOdc
         7NRYujojcf01eERWF+u7piL2xoyCKkgInHSNx1EWk3GbtUtNnLNSi0LaVCe1ds+zt30l
         3Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078379; x=1702683179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay9wzyB12eYmmiTWgs4BAuKgS+CO3Zor3St/DrG4wss=;
        b=KTk2ZwOjHE80FrHbfDMhsmWBeyu73hanTp84aPqgDtn76NAz4qQiNlnYr8edgviEjh
         joYCbMUBHdNuOnsUCJGDFllUyTKAvF67PCwf8CKVxhTF4E7Tg2OOkpBVY7ZX4ojOUKg3
         c2EUDMUiq4UYytu6ezqtcuHtkbssGKs1jny02k2JCpyALc77ZedR0kfKbDO7FM99F+RQ
         eyKhIGNraP9tilulOwNR9VV5tbDWcUOx+y+g7esqqCswNzgMa9WptkSyQWoRLQbA7vMf
         DoKZCs2RcR6fI5dlf+USwDr3ayZ0pSmPZ3/8LHZa6RaMn++KBuvNL3bKGuVWIh9s4S3f
         u/rw==
X-Gm-Message-State: AOJu0YxRxiWNxNgKQElnTnN52Qj7nxHaw75Ef+Oyb2BsWk9VuusfVHFN
	Cu3TkmgSEkLnwpRK1tDBSL2JGsc/+2/P3p0v3rrd
X-Google-Smtp-Source: AGHT+IHJl/+ondJPVs0gGGmSvsUl8CrKv64MLNnqkYioPScNbfM0E6qX9prlhdXXEkzFMove8N2M/8b0Bs5ZpedsDzo=
X-Received: by 2002:a05:6808:2e92:b0:3b8:b45f:29cf with SMTP id
 gt18-20020a0568082e9200b003b8b45f29cfmr840344oib.114.1702078379457; Fri, 08
 Dec 2023 15:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com> <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
 <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com>
In-Reply-To: <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 18:32:48 -0500
Message-ID: <CAHC9VhQyziaxvbCCfb4YWQ0-L0qASa-yHG4tuNfbnNLecKDG0A@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Munehisa Kamata <kamatam@amazon.com>, adobriyan@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@amazon.=
com> wrote:
> >> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > ..
> >
> >>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> >>> at the top.  However, before we go too much further on this, can we
> >>> get clarification that Casey was able to reproduce this on a stock
> >>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> >>> this problem on Linux v6.5.
> >>>
> >>> However, for the moment I'm going to assume this is a real problem, i=
s
> >>> there some reason why the existing pid_revalidate() code is not being
> >>> called in the bind mount case?  From what I can see in the original
> >>> problem report, the path walk seems to work okay when the file is
> >>> accessed directly from /proc, but fails when done on the bind mount.
> >>> Is there some problem with revalidating dentrys on bind mounts?
> >> Hi Paul,
> >>
> >> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linu=
x.org.uk/
> >>
> >> After reading this thread, I have doubt about solving this in VFS.
> >> Honestly, however, I'm not sure if it's entirely relevant today.
> > Have you tried simply mounting proc a second time instead of using a bi=
nd mount?
> >
> >  % mount -t proc non /new/location/for/proc
> >
> > I ask because from your description it appears that proc does the
> > right thing with respect to revalidation, it only becomes an issue
> > when accessing proc through a bind mount.  Or did I misunderstand the
> > problem?
>
> It's not hard to make the problem go away by performing some simple
> action. I was unable to reproduce the problem initially because I
> checked the Smack label on the bind mounted proc entry before doing
> the cat of it. The problem shows up if nothing happens to update the
> inode.

A good point.

I'm kinda thinking we just leave things as-is, especially since the
proposed fix isn't something anyone is really excited about.

--=20
paul-moore.com

