Return-Path: <linux-fsdevel+bounces-5381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DF80AF3A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9CB281BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74F758AD8;
	Fri,  8 Dec 2023 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yr2TB4rA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D931BE1
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 13:58:12 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1fb71880f12so1575459fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 13:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702072692; x=1702677492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XdTauwQnJn/usd+gP9F/Q41agpmKDU73FQORLroO8Y=;
        b=Yr2TB4rA14PVmn5QoN3pY9GxRyXvlLkQ6CF7N+KZoHgqNJhLQTpVhCWKOB6d6MxbsF
         AT8MrIeA1cWYCPlsH9ecas6qTn6Di1209XrQOnfHiRPDhrcf2148BJjCqiILjZyAW4h7
         XL56u92+tkaT/sJM7uG84hj4F80c5Ukwu0Ihk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072692; x=1702677492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XdTauwQnJn/usd+gP9F/Q41agpmKDU73FQORLroO8Y=;
        b=eiCc9ydSwbI4FAQnn0lbOtZQ0cia+dZAwFFF96SUdAyMVEm1UmX+N3jVTqK2tQowQX
         wzUEhNX5IfNQ4FoGLCyXhGy0LVoUAcP3hCTGp/AHZmWrf1HQGXGhz92YsrWaoSpsBc0T
         yzs07PNi8JRrGK+wtS9h3PCtFXqcVZOyGOAroWw5DeytAZCsbBycBnu9RYX3idfFHasB
         JH3B8L5b0D9ia+0vZgK4ZBlDVKO590zI6knB99lVxMBZnNfRBq16UD2PHBDv2YR10iq0
         xRJRnxLlv76PH6Bp/4+4bIeBqWtzUuYlZHnyHy0SJ9Imtt28Bp5VtiwLeDqgfbavegCe
         PPBA==
X-Gm-Message-State: AOJu0Yw24UnjRvM/Ala8VKGb9y3cKqXOiEWaXd7DhARbyS9W4Lhsumdq
	lytmVavn9qKq0A+pEowx560YTN94q/7lPRSpwD7ZXg==
X-Google-Smtp-Source: AGHT+IGajzN9oKKGmFkf+vWwD8eZFOYLubpVb9mzv1HXSiEf1fjI7rDsNVdcScv16C538G4At+IlFPVHnYTHno7LKKw=
X-Received: by 2002:a05:6870:1711:b0:1fa:f387:e0ab with SMTP id
 h17-20020a056870171100b001faf387e0abmr827203oae.46.1702072692203; Fri, 08 Dec
 2023 13:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-10-gnoack@google.com>
 <CABi2SkULCFBK0eBZen6Z7YSLnm_EcZqbmPN2fQ64bBbmX77uRw@mail.gmail.com> <ZXMQdqeGH6i5aJd8@google.com>
In-Reply-To: <ZXMQdqeGH6i5aJd8@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 8 Dec 2023 13:58:00 -0800
Message-ID: <CABi2SkXoJN6tEaM_=kKPQVmQ3+xROkNGb0XotwM9xSyTZr1FGA@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] landlock: Document IOCTL support
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:48=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Hello Jeff!
>
> On Fri, Dec 01, 2023 at 11:55:03AM -0800, Jeff Xu wrote:
> > On Fri, Dec 1, 2023 at 6:41=E2=80=AFAM G=C3=BCnther Noack <gnoack@googl=
e.com> wrote:
> > > +Rights associated with file descriptors
> > > +---------------------------------------
> > > +
> > > +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TR=
UNCATE`` and
> > > +``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly cre=
ated file
> > > +descriptor and will be used for subsequent truncation and ioctl atte=
mpts using
> > > +:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is si=
milar to
> > > +opening a file for reading or writing, where permissions are checked=
 during
> > > +:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)`=
 and
> > >  :manpage:`write(2)` calls.
> > >
> > > -As a consequence, it is possible to have multiple open file descript=
ors for the
> > > -same file, where one grants the right to truncate the file and the o=
ther does
> > > -not.  It is also possible to pass such file descriptors between proc=
esses,
> > > -keeping their Landlock properties, even when these processes do not =
have an
> > > -enforced Landlock ruleset.
> > > +As a consequence, it is possible to have multiple open file descript=
ors
> > > +referring to the same file, where one grants the truncate or ioctl r=
ight and the
> > > +other does not.  It is also possible to pass such file descriptors b=
etween
> > > +processes, keeping their Landlock properties, even when these proces=
ses do not
> > > +have an enforced Landlock ruleset.
> > >
> > I understand the "passing fd between process ", but not the " multiple
> > open fds referring to the same file, with different permission", are
> > those fds all opened within the same domain ?
> >
> > Can we have a pseudocode to help understanding ?
>
> It's a little bit expanding the scope here, as the documentation existed =
alredy
> prior to the patch set, but it's a fair comment that this paragraph is no=
t clear
> enough.  I tried to rephrase it.  Maybe this is better:
>
>   As a consequence, it is possible that a process has multiple open file
>   descriptors referring to the same file, but Landlock enforces different=
 things
>   when operating with these file descriptors.  This can happen when a Lan=
dlock
>   ruleset gets enforced and the process keeps file descriptors which were=
 opened
>   both before and after the enforcement.  It is also possible to pass suc=
h file
>   descriptors between processes, keeping their Landlock properties, even =
when
>   some of the involved processes do not have an enforced Landlock ruleset=
.
>
> Some example code to clarify:
>
> One way that this can happen is:
>
>   (1) fd1 =3D open("foobar.txt", O_RDWR)
>   (2) enforce_landlock(forbid all ioctls)
>   (3) fd2 =3D open("foobar.txt", O_RDWR)
>
>   =3D=3D> You now have fd1 and fd2 referring to the same file on disk,
>       but you can only do ioctls on it through fd1, but not through fd2.
>
> Or, using SCM_RIGHTS (unix(7)):
>
>   (1) Process 1: Listen on Unix socket
>   (2) Process 2: Enforce Landlock so that ioctls are forbidden
>   (3) Process 2: fd =3D open("foobar.txt", O_RDWR)
>   (4) Process 2: send fd to Process 1
>   (5) Process 1: receive fd
>
>   =3D=3D> Process 1 can not do ioctls on the received fd,
>       as configured by the Landlock policy enforced in Process 2
>
> Or, simply by inheriting file descriptors through execve:
>
>   (1) Parent process/main thread: Spawn thread t
>     (t.1) Enforce Landlock so that ioctls are forbidden
>           (This policy is local to the thread)
>     (t.2) fd =3D open("foobar.txt", O_RDWR)
>   (2) Parent process/main thread: join (exit) thread t
>   (3) Parent process/main thread: execve and inherit fd!
>
>   =3D=3D> The child process can not use ioctls with the inherited fd,
>       as configured by the Landlock policy before
>
> The same is also possible with the truncation right.
>
Very helpful. Thanks!
-Jeff

> =E2=80=94G=C3=BCnther

