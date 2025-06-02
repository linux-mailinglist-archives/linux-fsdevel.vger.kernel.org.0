Return-Path: <linux-fsdevel+bounces-50315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A4ACAD7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3825C40049C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B7198845;
	Mon,  2 Jun 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc6thGF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08221A83E8
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864707; cv=none; b=sxQjsNGsFI76etz1lLqCZjRHCGeD7Y7W+DjngxpE0CHjE3d6jEc992MUUZDXA9WJTsGm9hIEyY0k4NJ13WSgGexMQG5z2h8w8tifzLGTvi94nLViEGyu8aVB4B2tiHNepCddoqWD6BYn0Kmc2b/Dtpau+veQEs2NxI1GuCvCxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864707; c=relaxed/simple;
	bh=LgDIG5LA9E9jp/GYP2ZViTJu/mfo1NAasbGmI8PaIjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkNbQhVmu04nCQLmjXUKKTKGqUo9p0GmMuOMrIks48s9iLgKdJuQtePXY8o9qGxaJDYIVRSyRRiywoTROqSx8MRDqT0KJVvzXsT5fb2eVWAdHa+EdkLSQf8gk03yTCvEt8z6vHuK2a/uFe2IwjD4gxrfiL4MOJCeZm1J0jOQwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc6thGF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A304C4CEEB;
	Mon,  2 Jun 2025 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748864706;
	bh=LgDIG5LA9E9jp/GYP2ZViTJu/mfo1NAasbGmI8PaIjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rc6thGF4j6UcSML7sloFr0R5PT6viCqWqxKoBXnKuJSb6LTAYe91OQhvvA95VMj02
	 rb/bii1V2nxIPYxj6kQX7Lqb8L9JOQAOFe8RFBTakEIfg2x/JtjyBDxVQyyQETZXwq
	 Vs6zZfygFcT10iVY6LMhlYuCj7qjyDbaVEUrPwVPY9mU0byVA+6dJISeg57EOrEnL+
	 xgrf0htlgQk9ZCWnZM8cTjZ2L3OYbSRss5510UdaNDiaOQj7OybVv1as+f4uieYZIt
	 h5ITasRmkNo+8qJTWrLTaDQ8wnhFkbUKZuEhD2UPIwuLLqGviqfVZESyNfGa1urhVQ
	 phIbIzBhcurkw==
Date: Mon, 2 Jun 2025 13:45:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <20250602-eilte-experiment-4334f67dc5d8@brauner>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
 <2025060211-egotistic-overnight-9d10@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025060211-egotistic-overnight-9d10@gregkh>

On Mon, Jun 02, 2025 at 11:32:44AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 02, 2025 at 11:09:05AM +0200, Christian Brauner wrote:
> > On Fri, May 30, 2025 at 10:44:16AM +0100, Luca Boccassi wrote:
> > > Dear stable maintainer(s),
> > > 
> > > The following series was merged for 6.16:
> > > 
> > > https://lore.kernel.org/all/20250414-work-coredump-v2-0-685bf231f828@kernel.org/
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c57f07b235871c9e5bffaccd458dca2d9a62b164
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95c5f43181fe9c1b5e5a4bd3281c857a5259991f
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea
> > > 
> > > This allows the userspace coredump handler to get a PIDFD referencing
> > > the crashed process.
> > > 
> > > We have discovered that there are real world exploits that can be used
> > > to trick coredump handling userspace software to act on foreign
> > > processes due to PID reuse attacks:
> > > 
> > > https://security-tracker.debian.org/tracker/CVE-2025-4598
> > > 
> > > We have fixed the worst case scenario, but to really and
> > > comprehensively fix the whole problem we need this new %F option. We
> > > have backported the userspace side to the systemd stable branch. Would
> > > it be possible to backport the above 3 patches to at least the 6.12
> > > series, so that the next Debian stable can be fully covered? The first
> > > two are small bug fixes so it would be good to have them, and the
> > > third one is quite small and unless explicitly configured in the
> > > core_pattern, it will be inert, so risk should be low.
> > 
> > I agree that we should try and backport this if Greg agrees we can do
> > this. v6.15 will be easy to do. Further back might need some custom work
> > though. Let's see what Greg thinks.
> 
> Yes, seems like a good thing to backport to at least 6.12.y if possible.
> 
> Is it just the above 3 commits?

Yes, just those three:

b5325b2a270f ("coredump: hand a pidfd to the usermode coredump helper")
95c5f43181fe ("coredump: fix error handling for replace_fd()")
c57f07b23587 ("pidfs: move O_RDWR into pidfs_alloc_file()")

That should apply cleanly to v6.15 but for the others it requires custom
backports. So here are a couple of trees all based on linux-*.*.y from
the stable repo. You might need to adjust to your stable commit message
format though:

v6.12:
https://github.com/brauner/linux-stable/tree/vfs-6.12.coredump.pidfd

v6.6:
https://github.com/brauner/linux-stable/tree/vfs-6.6.coredump.pidfd

v6.1:
https://github.com/brauner/linux-stable/tree/vfs-6.1.coredump.pidfd

v5.14
https://github.com/brauner/linux-stable/tree/vfs-5.14.coredump.pidfd

v5.10
https://github.com/brauner/linux-stable/tree/vfs-5.10.coredump.pidfd

v5.4
https://github.com/brauner/linux-stable/tree/vfs-5.4.coredump.pidfd

