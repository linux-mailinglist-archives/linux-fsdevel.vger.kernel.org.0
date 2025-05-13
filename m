Return-Path: <linux-fsdevel+bounces-48790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B1AB48A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 03:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B17B8C217B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A2155A4D;
	Tue, 13 May 2025 01:09:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF817578;
	Tue, 13 May 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747098582; cv=none; b=Fh85yjv9ijBVaft8UPe5Ad2qa/d2xM+KHsamnPGtJpK8xlm6yuKWruDBemy6ubafhD9vNouAS/rXZCB5lznYzYJYyNv55UUO2d86NpQWpNC0m8gYmXMRVC5j7q1cHolKPLujiwYC5Qdbp8O5eCmdbZgko59fv1SPt3DVphA9vDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747098582; c=relaxed/simple;
	bh=SG/YViUkyBwrhFQyKyVZ3Wk0+pzRi6MUsztHHTAF0gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYCBvo9Hq8wJYygOzZxWFdnpYkGtCxNEKUNKvGuRWiKGvUZfjUDEWKuVeao9JAySBjG1o/fLusx19cp1/ybjNNADODJIvcdbJzvPcm6IuVA4EhekyzADwHH9nHrt20opaTJuQLvfAgO6zI+CKyrDXG1qNcPAEvTiUJXn/z3Qqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70b75ba2fb5so7616087b3.3;
        Mon, 12 May 2025 18:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747098579; x=1747703379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkQhVgJr7h8TPveGCpoRpOKDTkSjQGpLfeQdA1BoGdc=;
        b=ZkVjkrP+6L5dygBYMCk0BTPdUnlrXIQOYm8wEqHGkZje3bBxhY3za253OwBpBEEAnW
         ErUX+0HhMvjXmkgaOuHrP2HOy8xTWQFgysWPoaR3eWxpLfZVkKk8VwoNDGeg0vuV8w+7
         MKO+ilYjmnqdQf/12Z4nklz2fVCf2gr/qtPPM14wkohm0Bc5/FW0ymZLB+qPNW1+elrP
         KiR1rSx3G6ZjzKaLU0PLBO1F0B/D2siNkwS0T/zg+AvAm5pOswvQ7siGioUyBm2VDPIb
         RAG+1SglcJ8WagKEHelS4LSCcGewHO1LGgSqzKA1ChJQBA5itQJHak34PsSQn5NsAFti
         kazA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6jcL3kvNSq5IaFkiHM8vGbAvXNtYJUEjYrPcQtimsLs1YmJGQMeC40hNyj/iQGEb1Bk16jbm@vger.kernel.org, AJvYcCXNHYtYWhHxhsnkxjdkoplvbADX7yx9ejgpEviyroUqtZMKFNiHxmD1Ij5RNwXmvObRP3D/77fnZsW547lm@vger.kernel.org, AJvYcCXR14Dz3hHXCIEaelak6Odjsrwmp4OfqOuVjydrBHzEOCrF1Odgh85m//CH3OvrRI7Xym0+h4Udcka8jz4Y@vger.kernel.org, AJvYcCXx6f3nMA9L/rfxgQMWtqB3Hu4wA/GHJzweG+xpCJ8iWP5jq5PXqDS6Mriq3jBTlrW1VHpwleUdBSbglEybPYoRi1PQzYSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz079DN+XcRLtWje4N6S+cYg4lIE4QqGNPj5cv2dtZk8XCRBJj3
	2G2olpnH2DMyEjXxWl+aLouoNaSg2O5Sh33vIDb4xkMtrBpej8SnqNIVa4Zs
X-Gm-Gg: ASbGncsR83CjRr6PkMOyj1dYzOkFu1hE+12ydvLkj5bWu7LJ6BuAgZ8fSI2cO7lmy7G
	/VwxxTVHwtp5KfuTYanATSoC8ape3CPOKTwoNLoFA/hK+pwI7Vmknrg0JZQ6OzdfGrui/mCiRc/
	uZrnpbJEENYglkHeBze9l4oQottaUi0hmFbiETfvgNvCpHdqZvjk4PKjQuBBbRV1ADw/4AajMvY
	L4PmiHkFpR3/6Fzj26u55VkkcU29XMS7tD95bfhRTQ7b2xEpxb3z5BIr2yWZ6oSPhYg1V35WVji
	SGBhuJr9QqcZR7hBgcsW4pdWnW8on85WNi5uZWio73Z9ORtqqeMkVXrsXL07h4H3ItI+fScSlwh
	Y8x9PXkh4QVHe
X-Google-Smtp-Source: AGHT+IGLNB6+r9VnoVU3wkH8njgFSSxGWEhk0JcU6xml9eotMPThDxsT3iukIHkSPMSgMnGPVtSegA==
X-Received: by 2002:a05:690c:25c3:b0:6fe:b701:6403 with SMTP id 00721157ae682-70a3fa21321mr244607737b3.11.1747098578582;
        Mon, 12 May 2025 18:09:38 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d9cb5ccsm22009417b3.90.2025.05.12.18.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 18:09:36 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70960e0b4d5so38662247b3.0;
        Mon, 12 May 2025 18:09:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHuxlZAWa5e2QIbqBYZrOfpyc8OaOiNEqIj6bEWrfkdxz9x4qc80FDIa9VUn/28gD6QFON9LHjt7K4TJR3PlZ+WpSb9VfF@vger.kernel.org, AJvYcCUdCy7qkmAs1s82iN8O0/jW0m3bBkiH6pXcfl6M6Nhrya631e325tKvkyI1a2SPCHVdPShOWqef@vger.kernel.org, AJvYcCVXKat4GGCjAP0luZJD6jUQX2WGZELzNpzvBSgXcU3gEyzm0L9/j4vpbQtUgoDREkPXZwfV/qLXBgtlhVAo@vger.kernel.org, AJvYcCXtVACCc7VXFwyePUCvDlHWei7L8eii6MmJYoBCXS9maOlPXtQer0cT2NhHs3BCKU0hxdgL1UdXim7Qt9Yb@vger.kernel.org
X-Received: by 2002:a05:690c:3749:b0:6fb:b2c0:71da with SMTP id
 00721157ae682-70a3fb9e266mr189394767b3.36.1747098575410; Mon, 12 May 2025
 18:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMw=ZnTF9EVV+E+bXTz1je3VT+OwDPAzbbFy7G02zBjeCpqxFA@mail.gmail.com>
 <20250513001751.71660-1-kuniyu@amazon.com>
In-Reply-To: <20250513001751.71660-1-kuniyu@amazon.com>
From: Luca Boccassi <bluca@debian.org>
Date: Tue, 13 May 2025 02:09:24 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRC7Okmew=rrEocFuFn8hhrcergHciPjxFPuG4c6qH_Bw@mail.gmail.com>
X-Gm-Features: AX0GCFvarODoVcsay6yLHR6Hm3jXrrbNzB7ccsvL4RM1vKQaBLIYPCZgUoVMaKk
Message-ID: <CAMw=ZnRC7Okmew=rrEocFuFn8hhrcergHciPjxFPuG4c6qH_Bw@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] coredump: add coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, brauner@kernel.org, daan.j.demeyer@gmail.com, 
	daniel@iogearbox.net, davem@davemloft.net, david@readahead.eu, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, jannh@google.com, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 01:18, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Luca Boccassi <bluca@debian.org>
> Date: Mon, 12 May 2025 11:58:54 +0100
> > On Mon, 12 May 2025 at 09:56, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Coredumping currently supports two modes:
> > >
> > > (1) Dumping directly into a file somewhere on the filesystem.
> > > (2) Dumping into a pipe connected to a usermode helper process
> > >     spawned as a child of the system_unbound_wq or kthreadd.
> > >
> > > For simplicity I'm mostly ignoring (1). There's probably still some
> > > users of (1) out there but processing coredumps in this way can be
> > > considered adventurous especially in the face of set*id binaries.
> > >
> > > The most common option should be (2) by now. It works by allowing
> > > userspace to put a string into /proc/sys/kernel/core_pattern like:
> > >
> > >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> > >
> > > The "|" at the beginning indicates to the kernel that a pipe must be
> > > used. The path following the pipe indicator is a path to a binary that
> > > will be spawned as a usermode helper process. Any additional parameters
> > > pass information about the task that is generating the coredump to the
> > > binary that processes the coredump.
> > >
> > > In the example core_pattern shown above systemd-coredump is spawned as a
> > > usermode helper. There's various conceptual consequences of this
> > > (non-exhaustive list):
> > >
> > > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> > >   connected to the read-end of the pipe. All other file descriptors are
> > >   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
> > >   already caused bugs because userspace assumed that this cannot happen
> > >   (Whether or not this is a sane assumption is irrelevant.).
> > >
> > > - systemd-coredump will be spawned as a child of system_unbound_wq. So
> > >   it is not a child of any userspace process and specifically not a
> > >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> > >   upcall which are difficult for userspace to control correctly.
> > >
> > > - systemd-coredump is spawned with full kernel privileges. This
> > >   necessitates all kinds of weird privilege dropping excercises in
> > >   userspace to make this safe.
> > >
> > > - A new usermode helper has to be spawned for each crashing process.
> > >
> > > This series adds a new mode:
> > >
> > > (3) Dumping into an abstract AF_UNIX socket.
> > >
> > > Userspace can set /proc/sys/kernel/core_pattern to:
> > >
> > >         @address SO_COOKIE
> > >
> > > The "@" at the beginning indicates to the kernel that the abstract
> > > AF_UNIX coredump socket will be used to process coredumps. The address
> > > is given by @address and must be followed by the socket cookie of the
> > > coredump listening socket.
> > >
> > > The socket cookie is used to verify the socket connection. If the
> > > coredump server restarts or crashes and someone recycles the socket
> > > address the kernel will detect that the address has been recycled as the
> > > socket cookie will have necessarily changed and refuse to connect.
> >
> > This dynamic/cookie prefix makes it impossible to use this with socket
> > activation units. The way systemd-coredump works is that every
> > instance is an independent templated unit, spawned when there's a
> > connection to the private socket. If the path was fixed, we could just
> > reuse the same mechanism, it would fit very nicely with minimal
> > changes.
>
> Note this version does not use prefix.  Now it requires users to
> just pass the socket cookie via core_pattern so that the kernel
> can verify the peer.

Exactly - this means the pattern cannot be static in a sysctl.d early
on boot anymore, and has to be set dynamically by <something>. This is
a severe degradation over the status quo.

> > But because you need a "server" to be permanently running, this means
> > socket-based activation can no longer work, and systemd-coredump must
> > switch to a persistently-running mode.
>
> The only thing for systemd to do is assign a cookie after socket creation.
>
> As long as systemd hold the file descriptor of the socket, you don't need
> a dedicated "server" running permanently, and the fd can be passed around
> to a spawned/activated process.

There is no such facility, a socket is just a socket and there's no
infrastructure to randomly extract random information from one and
write it to some other random file in procfs, and I don't see why we
should add some super-special-case just for this, it sounds really
messy.
Also sockets can be and in fact are routinely restarted (eg: on
package upgrades), which would invalidate this whole scheme, and
result in a very racy setup. When packages are upgraded it's one of
the most complex workflows in modern distros, and it's very likely
that things start crashing exactly at that point, and with this
workflow it would mean we'll lose core files due to the race between
restarting the socket unit and <something> updating the pattern
accordingly.
Also we very much want to be able to spawn as many core handlers at
the same time as needed, which I don't see how can work with a cookie
that has to be unique per socket.

Sorry, but this particular approach seems completely unnecessary and
over-complicated, and doesn't seem to fit very well with how modern
userspace is set up today, and I don't see what actual problem it
would solve? If you need it for some particular use case that's
absolutely fine, but please add it later as another optional mode, so
that we don't have to degrade our use cases for it. That way everyone
gets what they want, and everyone's happy.

v5 was super nice and had everything we needed to massively improve
the status quo, with easy and straightforward changes and no real
drawbacks, so it would be really great if we could just go back to
that version, please. Thanks.

