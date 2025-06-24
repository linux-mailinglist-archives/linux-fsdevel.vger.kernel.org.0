Return-Path: <linux-fsdevel+bounces-52775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D41AE66FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAE316F9F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE7288AD;
	Tue, 24 Jun 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZauqZgry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE402C326B;
	Tue, 24 Jun 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772867; cv=none; b=e8QlP4U8IdRGTrmky85isKFtn9JqTMEqia9pS2xGYz1BNjXBGvhpEVZRoAZdIoizXYezaQkffgEvDirS1eVTpa7kUTEs8jywRVOZ4M4AQyoYJ4f8Vr9gs7bK134rVx5iO0srwKIsMkaxDhjT3e5oZSZFd1k7qwEuFZ6/61XHkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772867; c=relaxed/simple;
	bh=FtwLIqO5woVkdBDQacpEPpHRl/PJ8wMIPZSvRk1rwOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYpm5VLkSax0XPv73mO3ChmWFeOfjmofpHqyC7GUKUEapitZvEJJ/9x8rPBZ3RdSim4RCw0OBShP7hL2wIRByYqtWJ9G4JUf4f5c1exU/fBlOtZIH2bantP8V+pzK4EsmI37Cusqz8qjowD0SbIRwyL3X5BEi62Vd9oI2+7gfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZauqZgry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8443C4CEEE;
	Tue, 24 Jun 2025 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750772866;
	bh=FtwLIqO5woVkdBDQacpEPpHRl/PJ8wMIPZSvRk1rwOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZauqZgryz2N6y7vMj+PHLgP3hybIyizU3GhZ7kBikbkazwxPIHGkQWnoEvtjYGOyf
	 YBqUvzX0n7YkELkR79eGrEYNfLphVrdEwq7/3yfhS1ADvjXSPXdbTW5XipGg0N2ZN/
	 C65O27vpYzQ+BD0gEZF2o35sSEA4Gh6cnWIMgB72nwXkgLi+CI3peU0M16r8wlA1kb
	 BIzOs+sVHOAf11H4nIziKGb5AtAu9nYHzfL8PTjGwOdP+2ZVidI6os7LLN+Pfs1qw3
	 G27Ee5pW/SdBJp+QRNUSR2Kbjmr+ObhExCTlXKQYpCLMuB+cou5lyr2qXt4wdfUl7/
	 otaHZiXU2H33A==
Date: Tue, 24 Jun 2025 15:47:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 06/11] uapi/fcntl: mark range as reserved
Message-ID: <20250624-abwinken-gefragt-32ece86ae381@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-6-d02a04858fe3@kernel.org>
 <CAOQ4uxjiys1gHWy5eOMzwRqWzNJ-Tb8t+g3F0FFkmhVM3=ju0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjiys1gHWy5eOMzwRqWzNJ-Tb8t+g3F0FFkmhVM3=ju0w@mail.gmail.com>

On Tue, Jun 24, 2025 at 12:57:06PM +0200, Amir Goldstein wrote:
> On Tue, Jun 24, 2025 at 10:29 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Mark the range from -10000 to -40000 as a range reserved for special
> > in-kernel values. Move the PIDFD_SELF_*/PIDFD_THREAD_* sentinels over so
> > all the special values are in one place.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  include/uapi/linux/fcntl.h            | 16 ++++++++++++++++
> >  include/uapi/linux/pidfd.h            | 15 ---------------
> >  tools/testing/selftests/pidfd/pidfd.h |  2 +-
> >  3 files changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index a15ac2fa4b20..ba4a698d2f33 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -90,10 +90,26 @@
> >  #define DN_ATTRIB      0x00000020      /* File changed attibutes */
> >  #define DN_MULTISHOT   0x80000000      /* Don't remove notifier */
> >
> > +/* Reserved kernel ranges [-100], [-10000, -40000]. */
> >  #define AT_FDCWD               -100    /* Special value for dirfd used to
> >                                            indicate openat should use the
> >                                            current working directory. */
> >
> > +/*
> > + * The concept of process and threads in userland and the kernel is a confusing
> > + * one - within the kernel every thread is a 'task' with its own individual PID,
> > + * however from userland's point of view threads are grouped by a single PID,
> > + * which is that of the 'thread group leader', typically the first thread
> > + * spawned.
> > + *
> > + * To cut the Gideon knot, for internal kernel usage, we refer to
> > + * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
> > + * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
> > + * group leader...
> > + */
> > +#define PIDFD_SELF_THREAD              -10000 /* Current thread. */
> > +#define PIDFD_SELF_THREAD_GROUP                -10001 /* Current thread group leader. */
> > +
> >
> >  /* Generic flags for the *at(2) family of syscalls. */
> >
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > index c27a4e238e4b..957db425d459 100644
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -42,21 +42,6 @@
> >  #define PIDFD_COREDUMP_USER    (1U << 2) /* coredump was done as the user. */
> >  #define PIDFD_COREDUMP_ROOT    (1U << 3) /* coredump was done as root. */
> >
> > -/*
> > - * The concept of process and threads in userland and the kernel is a confusing
> > - * one - within the kernel every thread is a 'task' with its own individual PID,
> > - * however from userland's point of view threads are grouped by a single PID,
> > - * which is that of the 'thread group leader', typically the first thread
> > - * spawned.
> > - *
> > - * To cut the Gideon knot, for internal kernel usage, we refer to
> > - * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
> > - * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
> > - * group leader...
> > - */
> > -#define PIDFD_SELF_THREAD              -10000 /* Current thread. */
> > -#define PIDFD_SELF_THREAD_GROUP                -20000 /* Current thread group leader. */
> > -
> >  /*
> >   * ...and for userland we make life simpler - PIDFD_SELF refers to the current
> >   * thread, PIDFD_SELF_PROCESS refers to the process thread group leader.
> > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > index efd74063126e..5dfeb1bdf399 100644
> > --- a/tools/testing/selftests/pidfd/pidfd.h
> > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > @@ -56,7 +56,7 @@
> >  #endif
> >
> >  #ifndef PIDFD_SELF_THREAD_GROUP
> > -#define PIDFD_SELF_THREAD_GROUP                -20000 /* Current thread group leader. */
> > +#define PIDFD_SELF_THREAD_GROUP                -10001 /* Current thread group leader. */
> 
> The commit message claims to move definions between header files,
> but the value of PIDFD_SELF_THREAD_GROUP was changed.
> 
> What am I missing?

I've split that into two patches.

