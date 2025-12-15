Return-Path: <linux-fsdevel+bounces-71304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F6CBD514
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51E83014A05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AF32C935;
	Mon, 15 Dec 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6AcqTkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B232AADA;
	Mon, 15 Dec 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793435; cv=none; b=n2gLHfZeFE0hRXx9oTcF/o6hM6SX/NiorukQ7kUo1DtUsDpca+iO1ihVE+89FseuY0ZhzlDOjCVBiEV3HwEvrJA9N/3K92/M8N1yhgejK2iQbjDk1zCyt5W4yqx3qeQ20IK8y/B7NqnOvYbFL8WwMNst9FqJ9+4Wlw/PhyYrZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793435; c=relaxed/simple;
	bh=Q8aUgCK3qUVzxftEIXSI765gX1wZABO69d3NEZOhSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXzxPo+W2tn1DEzMk8sYIn9MD9wKPPnjYPH/3n1VwpMnnw6LGbLaNoVYgXmg+fJpD0ZTpVe81/oPxfmg1te3Stf1xJhJQRsEwXJZxqH2NOPUXTbd1WUZ5NqKV87egDNOrHuasXkMwHmdEe4oXPoRW66v05H6ydbADFq0R1b+cXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6AcqTkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB3C4CEF5;
	Mon, 15 Dec 2025 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765793435;
	bh=Q8aUgCK3qUVzxftEIXSI765gX1wZABO69d3NEZOhSVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6AcqTkrGNkGvAsK16P6V+1JZHeOOg1n2Q2SDBOqtqu13ZXBhfvDndAvfeBgfke5d
	 TzuQ6+/NthEA9ia27lWIDVw58i5AbOxM93P8xERV/tBl7hGeylcy0ausEAfx3WoZaT
	 xTb+bHzYZ+DnVR6lFHy94pDWQOvtfV3ujU9rAakwKA4f6hNng4tnKC4s6Tyn1GZ/Fd
	 oNnlpaoaoUwgF2wBfxHyVvCfg0S1R60mIpPJEvYFmxiT3sOFsLn635gS4bG4YgsO6i
	 VkNl2+jgx/eyMD22A/4Kx8+zYsaBou6OdmwavT5oE/MwN6NHbQ2CzxJK4ezuczCUpL
	 PTKnud9t//P6g==
Date: Mon, 15 Dec 2025 11:10:29 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Dan Klishch <danilklishch@gmail.com>
Cc: containers@lists.linux-foundation.org, ebiederm@xmission.com,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <aT_elfmyOaWuJRjW@example.org>
References: <aT7ohARHhPEmFlW9@example.org>
 <20251214180254.799969-1-danilklishch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214180254.799969-1-danilklishch@gmail.com>

On Sun, Dec 14, 2025 at 01:02:54PM -0500, Dan Klishch wrote:
> On 12/14/25 11:40 AM, Alexey Gladkov wrote:
> > But then, if I understand you correctly, this patch will not be enough
> > for you. procfs with subset=pid will not allow you to have /proc/meminfo,
> > /proc/cpuinfo, etc.
> 
> Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
> tree to the sandboxed programs (empirically, this is enough for most of
> programs you want sandboxing for). With that in mind, this patch and a
> FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
> /proc/cpuinfo / a small kernel patch with a new mount option for procfs
> to expose more static files still look like a clean solution to me.

I don't think you'll be able to do that. procfs doesn't allow itself to
be overlayed [1]. What should block mounting overlayfs and fuse on top
of procfs.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/proc/root.c#n274

> >> Also, correct me if I am wrong, installing ebpf controller requires
> >> CAP_BPF in initial userns, so rootless podman will not be able to mask
> >> /proc "properly" even if someone sends a patch switching it to ebpf.
> > 
> > You can turn on /proc/sys/kernel/unprivileged_bpf_disabled.
> 
> $ cat /proc/sys/kernel/unprivileged_bpf_disabled
> 0
> $ unshare -pfr --mount-proc
> $ ./proc-controller -p deny /proc/cpuinfo
> libbpf: prog 'proc_access_restrict': BPF program load failed: Operation not permitted
> libbpf: prog 'proc_access_restrict': failed to load: -1
> libbpf: failed to load object './proc-controller.bpf.o'
> proc-controller: ERROR: loading BPF object file failed
> 
> I think only packet filters are allowed to be installed by non-root.

I probably forgot about that. I wrote this code a long time ago, and
to be honest, I forgot whether it can be used for rootless.

-- 
Rgrds, legion


