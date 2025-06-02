Return-Path: <linux-fsdevel+bounces-50300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E5ACAB31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D6E17909C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFD41DF270;
	Mon,  2 Jun 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO2E+1/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDAC1DEFDB
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748855350; cv=none; b=DSxmZnW/NDKioTeYm2OkyAki4esGCgjOSzY6UWFcnWkrBB+e7Rl29Xa4C4RhxZTjig/E8ZhjxqyLpWVosexJDYZihPngLoSUbwnBKaB4QycXxhxz3uZvLymBeCFZP+tRmsCrQMyViAdlMLS3xN7AyJhDFqwPDQfTLq2qFgAANaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748855350; c=relaxed/simple;
	bh=eUcuZR2zqQuUq9Z/1+bg2Z9tcdcJqil0+4y8/bgIuRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdgXjz5aRMYCO5wXC1u2baU8HNufBLpo4pXgISgh9OFXG+zc2D0AwyXyDp6qQ4YLLOLrCWY9EiXCfsg0L9h2J9yU6wnlMg8NKQXMVp9QXBnCcbTaKCJZ0zQh2TjIO9zQMwuwcvD/K+TIbokfwVs0K8bcauzwMW5nH1S8QCiyEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO2E+1/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA55C4CEF1;
	Mon,  2 Jun 2025 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748855349;
	bh=eUcuZR2zqQuUq9Z/1+bg2Z9tcdcJqil0+4y8/bgIuRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aO2E+1/iYNVteq2kYczGqK4VG0bi0IR34z8QSfHoNJTbv8++rOipVhdLnl+romxfj
	 QnBFgK+LiQ6/eVqv9fy7d3ORddpMgJmHKeBCpYA01Yvm6NRwY1Zk2ZYkM3wQBctXFr
	 2QAdCY+wHtSOYFVEGDrtXXnxOVJdgv8pkLuYT/Kz9mZ5h0ZLx3hXN0zkZ8mgzpIOe9
	 cBTZ7ABQOVr3KzBxJjuZwEIolTBfrV97IfIC4C9adezPbyPPGDKsLViq3ugJqIpvK+
	 +pKgQuobFc4rO2AQY0nikUKD42929sz5fR5Mrz3TbPJ1M5WmfCR9bUSDRavlajnV1j
	 himzcV3+lA5fA==
Date: Mon, 2 Jun 2025 11:09:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luca Boccassi <bluca@debian.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>

On Fri, May 30, 2025 at 10:44:16AM +0100, Luca Boccassi wrote:
> Dear stable maintainer(s),
> 
> The following series was merged for 6.16:
> 
> https://lore.kernel.org/all/20250414-work-coredump-v2-0-685bf231f828@kernel.org/
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c57f07b235871c9e5bffaccd458dca2d9a62b164
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95c5f43181fe9c1b5e5a4bd3281c857a5259991f
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea
> 
> This allows the userspace coredump handler to get a PIDFD referencing
> the crashed process.
> 
> We have discovered that there are real world exploits that can be used
> to trick coredump handling userspace software to act on foreign
> processes due to PID reuse attacks:
> 
> https://security-tracker.debian.org/tracker/CVE-2025-4598
> 
> We have fixed the worst case scenario, but to really and
> comprehensively fix the whole problem we need this new %F option. We
> have backported the userspace side to the systemd stable branch. Would
> it be possible to backport the above 3 patches to at least the 6.12
> series, so that the next Debian stable can be fully covered? The first
> two are small bug fixes so it would be good to have them, and the
> third one is quite small and unless explicitly configured in the
> core_pattern, it will be inert, so risk should be low.

I agree that we should try and backport this if Greg agrees we can do
this. v6.15 will be easy to do. Further back might need some custom work
though. Let's see what Greg thinks.

