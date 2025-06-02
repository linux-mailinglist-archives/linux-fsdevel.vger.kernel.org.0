Return-Path: <linux-fsdevel+bounces-50318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C02ACADC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77C117FD01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB3202F60;
	Mon,  2 Jun 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pt+SGZOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBF207DFD
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866019; cv=none; b=s/qhLJKKFTr+7dEWjv/mdN5M1JtT01Ko+4A/SgiLLmDP11xChkUfJCdQo7txLCbNDD7RXjUa31ewe9NO2Af/cyKNgB4XLohzq1LU4XHNfpRr/VxC9Wbpj1Azc6K2Ne8kMTWaRfqe2grtBDDax3vskTDIGOXSL4Un70OOUe5Q+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866019; c=relaxed/simple;
	bh=iFjoOiRea/cyUJUWuIzZu8qR4+Zu8+3Plu+BtG55aSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU99hLOQq7crtZOpLM5HrblGdmPYP4bwicHq8IxEZhyfQQQRLOOuj6X3ZaQjZemEHjIvGc/PHDBVAhLR98XX3yL4KwlbmOZdD6fDYd9ZgEQEXJmrZH4Nr/xmTiSEwdin4VcWdl4KQrDYn0w90HTQjE19NZf8KFdeHjloe3IlgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pt+SGZOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E46C4CEF2;
	Mon,  2 Jun 2025 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748866018;
	bh=iFjoOiRea/cyUJUWuIzZu8qR4+Zu8+3Plu+BtG55aSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt+SGZOhtVmJZSVNCFelxTF/6+7XbjLsI8v5yBhUVDaJKtJJMubC0Oi2TKBbzLpIL
	 ifJO1+9UghBU6PWw+mZVJZz4SqQWoXLTJ35SS6anh6dnwkn0LiJSGSXJaFFj2leZg7
	 skbwWqg6g6bR++YAzQk0hvDke4Rce/14EV5covg8=
Date: Mon, 2 Jun 2025 14:06:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <2025060256-talcum-repave-92be@gregkh>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
 <2025060211-egotistic-overnight-9d10@gregkh>
 <20250602-eilte-experiment-4334f67dc5d8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-eilte-experiment-4334f67dc5d8@brauner>

On Mon, Jun 02, 2025 at 01:45:02PM +0200, Christian Brauner wrote:
> On Mon, Jun 02, 2025 at 11:32:44AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 02, 2025 at 11:09:05AM +0200, Christian Brauner wrote:
> > > On Fri, May 30, 2025 at 10:44:16AM +0100, Luca Boccassi wrote:
> > > > Dear stable maintainer(s),
> > > > 
> > > > The following series was merged for 6.16:
> > > > 
> > > > https://lore.kernel.org/all/20250414-work-coredump-v2-0-685bf231f828@kernel.org/
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c57f07b235871c9e5bffaccd458dca2d9a62b164
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95c5f43181fe9c1b5e5a4bd3281c857a5259991f
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea
> > > > 
> > > > This allows the userspace coredump handler to get a PIDFD referencing
> > > > the crashed process.
> > > > 
> > > > We have discovered that there are real world exploits that can be used
> > > > to trick coredump handling userspace software to act on foreign
> > > > processes due to PID reuse attacks:
> > > > 
> > > > https://security-tracker.debian.org/tracker/CVE-2025-4598
> > > > 
> > > > We have fixed the worst case scenario, but to really and
> > > > comprehensively fix the whole problem we need this new %F option. We
> > > > have backported the userspace side to the systemd stable branch. Would
> > > > it be possible to backport the above 3 patches to at least the 6.12
> > > > series, so that the next Debian stable can be fully covered? The first
> > > > two are small bug fixes so it would be good to have them, and the
> > > > third one is quite small and unless explicitly configured in the
> > > > core_pattern, it will be inert, so risk should be low.
> > > 
> > > I agree that we should try and backport this if Greg agrees we can do
> > > this. v6.15 will be easy to do. Further back might need some custom work
> > > though. Let's see what Greg thinks.
> > 
> > Yes, seems like a good thing to backport to at least 6.12.y if possible.
> > 
> > Is it just the above 3 commits?
> 
> Yes, just those three:
> 
> b5325b2a270f ("coredump: hand a pidfd to the usermode coredump helper")
> 95c5f43181fe ("coredump: fix error handling for replace_fd()")
> c57f07b23587 ("pidfs: move O_RDWR into pidfs_alloc_file()")
> 
> That should apply cleanly to v6.15 but for the others it requires custom
> backports. So here are a couple of trees all based on linux-*.*.y from
> the stable repo. You might need to adjust to your stable commit message
> format though:
> 
> v6.12:
> https://github.com/brauner/linux-stable/tree/vfs-6.12.coredump.pidfd

So that would be:
	git pull https://github.com/brauner/linux-stable.git vfs-6.12.coredump.pidfd
?

Can I get a signed tag so I know that I can trust a github.com account?

Also, 6.14.y didn't work all that well, let me see if I can get that to
work on my own like I did for 6.15.y (the pidfs patch needed to be
manually applied...)

thanks,

greg k-h

