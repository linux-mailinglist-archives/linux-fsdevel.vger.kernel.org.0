Return-Path: <linux-fsdevel+bounces-71351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D19DFCBE73A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C49F2301AB23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD831576C;
	Mon, 15 Dec 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/8uG09n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB88313263;
	Mon, 15 Dec 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810728; cv=none; b=crmzIxKkMuQVE6+8ZTa8vCH1wIOZz1+smP2AMR3ltuq0lwgI3rdxpNoLZG1QVskqnZmESo7YJaR/Z00qXFMEcaBNk7FYCKpjPiOr3qoL6sMeBTv8rIOFoGiPnOsk0Uq1bfvg7zKWCSTXOb8MiHSdLHhHH4PHJExoJ3XrLZBrkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810728; c=relaxed/simple;
	bh=PCV8sd44c/5aFC/WUSRWenozpYDDIq0lVJk8xWbAOpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfLNFoDtdmx+/6IJxla2gmaM6Q/HlUS9Y+IDiDR0dSMWeOIx/QGXNuCr9K6YU/ySJCzndQSlfbPYtm83fudfZ2NObV7y3s2q8uyxJxQlmzV5Ohrol6gSPGYzWC7dFu7oAJWS8OuI7xfbrArl7rjpRm5NiJvygzRqdVx7410aQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/8uG09n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB115C4CEF5;
	Mon, 15 Dec 2025 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810727;
	bh=PCV8sd44c/5aFC/WUSRWenozpYDDIq0lVJk8xWbAOpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/8uG09n3GqrHPuGLyYc3q1dqzmBBEOTWCd9i+FnKQOMMSTjeJDwE0L+0b1adnIy2
	 w775w+vPDAm6FxAOTA492Wcfd6FJUWdj+XqdiUms/PTdMQz5pj4E6J3s4lx8C/GHsD
	 KYQ2jdPdvviwKYVNk1oPbdqxNnDhVB98ACJhWBv/7ZMdyd3Osk8xkqbFLCZXD/F6V6
	 7y33ugbbqHElrv1q3L1jBQHWqyUaGlRW2WmvoCDA+rMKiGBpqP0AF1FrIfvZ1sxpvy
	 Q2ZsdrvstU60EfX4Pavx2np7OwKQPHAKTzeU86IyH3JxlBgUnNwyvl6kTe/7ja1hkO
	 J/euzD4p8MOGA==
Date: Mon, 15 Dec 2025 15:58:42 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Dan Klishch <danilklishch@gmail.com>
Cc: brauner@kernel.org, containers@lists.linux-foundation.org,
	ebiederm@xmission.com, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <aUAiIkNPgied0Tyf@example.org>
References: <aT_elfmyOaWuJRjW@example.org>
 <20251215144600.911100-1-danilklishch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215144600.911100-1-danilklishch@gmail.com>

On Mon, Dec 15, 2025 at 09:46:00AM -0500, Dan Klishch wrote:
> On 12/15/25 5:10 AM, Alexey Gladkov wrote:
> > On Sun, Dec 14, 2025 at 01:02:54PM -0500, Dan Klishch wrote:
> >> On 12/14/25 11:40 AM, Alexey Gladkov wrote:
> >>> But then, if I understand you correctly, this patch will not be enough
> >>> for you. procfs with subset=pid will not allow you to have /proc/meminfo,
> >>> /proc/cpuinfo, etc.
> >>
> >> Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
> >> tree to the sandboxed programs (empirically, this is enough for most of
> >> programs you want sandboxing for). With that in mind, this patch and a
> >> FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
> >> /proc/cpuinfo / a small kernel patch with a new mount option for procfs
> >> to expose more static files still look like a clean solution to me.
> > 
> > I don't think you'll be able to do that. procfs doesn't allow itself to
> > be overlayed [1]. What should block mounting overlayfs and fuse on top
> > of procfs.
> > 
> > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/proc/root.c#n274
> 
> This is why I have been careful not to say overlayfs. With [2] (warning:
> zero-shot ChatGPT output), I can do:
> 
> $ ./fuse-overlay target --source=/proc
> $ ls target
> 1   88   194   1374    889840  908552
> 2   90   195   1375    889987  908619
> 3   91   196   1379    890031  908658
> 4   92   203   1412    890063  908756
> 5   93   205   1590    890085  908804
> 6   94   233   1644    890139  908951
> 7   96   237   1802    890246  909848
> 8   97   239   1850    890271  909914
> 10  98   240   1852    894665  909924
> 13  99   243   1865    895854  909926
> 15  100  244   1888    895864  910005
> 16  102  246   1889    896030  acpi
> 17  103  262   1891    896205  asound
> 18  104  263   1895    896508  bus
> 19  105  264   1896    896544  driver
> 20  106  265   1899    896706  dynamic_debug
> <...>
> 
> [2] https://gist.github.com/DanShaders/547eeb74a90315356b98472feae47474
> 
> This requires a much more careful thought wrt magic symlinks
> and permission checks. The fact that I am highly unlikely to 100%
> correctly reimplement the checks and special behavior of procfs makes me
> not want to proceed with the FUSE route.
> 
> On 12/15/25 6:30 AM, Christian Brauner wrote:
> > The standard way of making it possible to mount procfs inside of a
> > container with a separate mount namespace that has a procfs inside it
> > with overmounted entries is to ensure that a fully-visible procfs
> > instance is present.
> 
> Yes, this is a solution. However, this is only marginally better than
> passing --privileged to the outer container (in a sense that we require
> outer sandbox to remove some protections for the inner sandbox to work).
> 
> > The container needs to inherit a fully-visible instance somehow if you
> > want nesting. Using an unprivileged LSM such as landlock to prevent any
> > access to the fully visible procfs instance is usually the better way.
> > 
> > My hope is that once signed bpf is more widely adopted that distros will
> > just start enabling blessed bpf programs that will just take on the
> > access protecting instead of the clumsy bind-mount protection mechanism.
> 
> These are big changes to container runtimes that are unlikely to happen
> soon. In contrast, the patch we are discussing will be available in 2
> months after the merge for me to use on ArchLinux, and in a couple more
> months on Ubuntu.
> 
> So, is there any way forward with the patch or should I continue trying
> to find a userspace solution?

I still consider these patches useful. I made them precisely to remove
some of the restrictions we have for procfs because of global files in
the root of this filesystem.

I can update and prepare a new version of patchset if Christian thinks
it's useful too.

-- 
Rgrds, legion


