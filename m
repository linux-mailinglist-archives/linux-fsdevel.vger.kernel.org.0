Return-Path: <linux-fsdevel+bounces-50322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161AACAE18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1430F189E628
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F01DE4C5;
	Mon,  2 Jun 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeOWpwZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F8139D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867548; cv=none; b=LgL3NZcBbduXHr0SSpcPbJPanSxEha6NlDJLb4LNmJQT4PV9DhKWD5w/eO+vYQDHSc20JkQ3T41uc9wqKf9yOy5KOuhZOjepczda5TVVvqsv/udCs1ZY45WpmeIxwj5DrhCEw04Ngs/DEUhnnzDFK5655IlAccOJZFsdk2vea1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867548; c=relaxed/simple;
	bh=khWV9IyPcHNkI7bX3mMaeCN9XsBky7AKKyjJ/i+NtCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuZu3OrdLxrte5g/U2gzj9k2nzkQANBTyBFQb0DNmdsOV65wl6p3UjZZ8ANsCVkwKx/47LKxef6adrTEO7k7VYvEVhjrrdQ4umht6BpfPDzlztVEW/GZ/IcWtd6HtvLzR0H9vkp3YPK98n9NHBdaPHDPGprCQIKKaMImbNSEx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeOWpwZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A91C4CEEB;
	Mon,  2 Jun 2025 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748867548;
	bh=khWV9IyPcHNkI7bX3mMaeCN9XsBky7AKKyjJ/i+NtCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeOWpwZ/CjOpxOJug5w3CtOy0U/oarnT3lCCS8t3ou2A6Tlwyv7uEVPp+LoK9eAC1
	 PQ3NsX6ma57FJRIKDhjwxLTuZSjFuJfXCHOTpQmt5OlySOVS9jUPc8BV5fxlppVah/
	 8tOXrTOv+tSDpmXbXhuifaCygKGLz5YlmcQg/cGHzN/dKXDZND9TWGqUa6HAVSqpQi
	 4luqhvuuLes9hrHw3l1BVqDFg2qBfSwe5F+sXNul2MoIuAu5nhw1EWRy6m6AvwIIar
	 RwWbTQF51g0rteRDCBzIyOASRPSL9elY8Z1HxEfng4rAztE3MzqvuKPywJSaexAowd
	 p9beZW9QSm+jA==
Date: Mon, 2 Jun 2025 14:32:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <20250602-analphabeten-darmentleerung-a49c4a8e36ee@brauner>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
 <2025060211-egotistic-overnight-9d10@gregkh>
 <20250602-eilte-experiment-4334f67dc5d8@brauner>
 <2025060256-talcum-repave-92be@gregkh>
 <20250602-substantiell-zoologie-02c4dfb4b35d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250602-substantiell-zoologie-02c4dfb4b35d@brauner>

On Mon, Jun 02, 2025 at 02:13:35PM +0200, Christian Brauner wrote:
> On Mon, Jun 02, 2025 at 02:06:55PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 02, 2025 at 01:45:02PM +0200, Christian Brauner wrote:
> > > On Mon, Jun 02, 2025 at 11:32:44AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jun 02, 2025 at 11:09:05AM +0200, Christian Brauner wrote:
> > > > > On Fri, May 30, 2025 at 10:44:16AM +0100, Luca Boccassi wrote:
> > > > > > Dear stable maintainer(s),
> > > > > > 
> > > > > > The following series was merged for 6.16:
> > > > > > 
> > > > > > https://lore.kernel.org/all/20250414-work-coredump-v2-0-685bf231f828@kernel.org/
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c57f07b235871c9e5bffaccd458dca2d9a62b164
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95c5f43181fe9c1b5e5a4bd3281c857a5259991f
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea
> > > > > > 
> > > > > > This allows the userspace coredump handler to get a PIDFD referencing
> > > > > > the crashed process.
> > > > > > 
> > > > > > We have discovered that there are real world exploits that can be used
> > > > > > to trick coredump handling userspace software to act on foreign
> > > > > > processes due to PID reuse attacks:
> > > > > > 
> > > > > > https://security-tracker.debian.org/tracker/CVE-2025-4598
> > > > > > 
> > > > > > We have fixed the worst case scenario, but to really and
> > > > > > comprehensively fix the whole problem we need this new %F option. We
> > > > > > have backported the userspace side to the systemd stable branch. Would
> > > > > > it be possible to backport the above 3 patches to at least the 6.12
> > > > > > series, so that the next Debian stable can be fully covered? The first
> > > > > > two are small bug fixes so it would be good to have them, and the
> > > > > > third one is quite small and unless explicitly configured in the
> > > > > > core_pattern, it will be inert, so risk should be low.
> > > > > 
> > > > > I agree that we should try and backport this if Greg agrees we can do
> > > > > this. v6.15 will be easy to do. Further back might need some custom work
> > > > > though. Let's see what Greg thinks.
> > > > 
> > > > Yes, seems like a good thing to backport to at least 6.12.y if possible.
> > > > 
> > > > Is it just the above 3 commits?
> > > 
> > > Yes, just those three:
> > > 
> > > b5325b2a270f ("coredump: hand a pidfd to the usermode coredump helper")
> > > 95c5f43181fe ("coredump: fix error handling for replace_fd()")
> > > c57f07b23587 ("pidfs: move O_RDWR into pidfs_alloc_file()")
> > > 
> > > That should apply cleanly to v6.15 but for the others it requires custom
> > > backports. So here are a couple of trees all based on linux-*.*.y from
> > > the stable repo. You might need to adjust to your stable commit message
> > > format though:
> > > 
> > > v6.12:
> > > https://github.com/brauner/linux-stable/tree/vfs-6.12.coredump.pidfd
> > 
> > So that would be:
> > 	git pull https://github.com/brauner/linux-stable.git vfs-6.12.coredump.pidfd
> > ?
> > 
> > Can I get a signed tag so I know that I can trust a github.com account?
> 
> Sure, give me a minute.

v6.12
=====

The following changes since commit df3f6d10f353de274cc7c87f52dba5d26f185393:

  Linux 6.12.31 (2025-05-29 11:03:27 +0200)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-6.12.stable.coredump.pidfd

for you to fetch changes up to d4b6fd4951d0c73c0ab1a900d924959eec81d542:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 14:16:49 +0200)

----------------------------------------------------------------
vfs-6.12.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (2):
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c            | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/coredump.h |  1 +
 2 files changed, 60 insertions(+), 6 deletions(-)


v6.6
====
The following changes since commit ffaf6178137b9cdcc9742d6677b70be164dfeb8c:

  Linux 6.6.92 (2025-05-22 14:12:26 +0200)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-6.6.stable.coredump.pidfd

for you to fetch changes up to 05d1f1d0c42b0d5ecdffbaa986d053f9024b6b19:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 14:17:54 +0200)

----------------------------------------------------------------
vfs-6.6.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (2):
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c            | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/coredump.h |  1 +
 2 files changed, 76 insertions(+), 6 deletions(-)


v6.1
====
The following changes since commit da3c5173c55f7a0cf65c967d864386c79dcba3f7:

  Linux 6.1.140 (2025-05-22 14:10:11 +0200)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-6.1.stable.coredump.pidfd

for you to fetch changes up to 9c3383683cf521ac19f2d6a1f0001020cbdef5ea:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 14:19:57 +0200)

----------------------------------------------------------------
vfs-6.1.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (4):
      coredump: fix error handling for replace_fd()
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c            | 81 ++++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/coredump.h |  1 +
 include/linux/pid.h      |  1 +
 kernel/fork.c            | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 kernel/pid.c             | 19 +++++--------
 5 files changed, 171 insertions(+), 29 deletions(-)


v5.14
=====
The following changes since commit 545728d9e08593767dd55192b0324dd4f9b71151:

  Linux 5.14.21 (2021-11-21 13:49:09 +0100)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-5.14.stable.coredump.pidfd

for you to fetch changes up to 2ffdb0f69836082c1ef8a1736df5ab68da56a1c7:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 14:21:43 +0200)

----------------------------------------------------------------
vfs-5.14.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (4):
      coredump: fix error handling for replace_fd()
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c           | 80 ++++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/binfmts.h |  1 +
 include/linux/pid.h     |  1 +
 kernel/fork.c           | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 163 insertions(+), 17 deletions(-)

v5.10
=====
The following changes since commit 024a4a45fdf87218e3c0925475b05a27bcea103f:

  Linux 5.10.237 (2025-05-02 07:41:22 +0200)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-5.10.stable.coredump.pidfd

for you to fetch changes up to 7cbb4d10e81aeefe15fd9fea6723d331156f64d0:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 14:22:31 +0200)

----------------------------------------------------------------
vfs-5.10.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (4):
      coredump: fix error handling for replace_fd()
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c           | 81 +++++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/binfmts.h |  1 +
 include/linux/pid.h     |  1 +
 kernel/fork.c           | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 164 insertions(+), 17 deletions(-)

v5.4
====
The following changes since commit 2c8115e4757809ffd537ed9108da115026d3581f:

  Linux 5.4.293 (2025-05-02 07:39:30 +0200)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-5.4.stable.coredump.pidfd

for you to fetch changes up to b8e412e55db1729d182a471fb83273bbcbd18325:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 14:23:49 +0200)

----------------------------------------------------------------
vfs-5.4.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (5):
      coredump: fix error handling for replace_fd()
      pidfd: check pid has attached task in fdinfo
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c           |  80 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/binfmts.h |   1 +
 include/linux/pid.h     |   5 +++
 kernel/fork.c           | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 175 insertions(+), 19 deletions(-)

