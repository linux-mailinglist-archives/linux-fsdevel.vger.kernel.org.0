Return-Path: <linux-fsdevel+bounces-75943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP9gKsuzfGm7OQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:36:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D5BB1A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DEE302FA9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D172E6CDE;
	Fri, 30 Jan 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA0nM8Qn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D303C9F;
	Fri, 30 Jan 2026 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780088; cv=none; b=Xr4TD+LuIobndo7TyNNL3eZWETZsZZ0pd9cE2KJH2D2Mzl7hLs1xiT1NAnyk/W8sInNIYu3EaFUll95YAAsa9pX0xMiwPCUsY+HzAw+F8HeurZ3bYQasiQBY5B/tGuv2umF7slzv3pVsMfGhcTuPr+3F/m9tTU1tctVUAUrWAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780088; c=relaxed/simple;
	bh=B3P9f0B+pa1cmU6gFpc0gUraGYenQM/sjeWQeqg4wOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQZHC7CynJ+TxwBswD6aKT4nlUegz5ixBFD2flhWZYT0czsdXbJE8Z/hacO3jsaBKCdPvWsFLDkKcyihrSHaeHrC/fyBEauog2L/5AQELlgw6qkj7LktmtUjWFe6Lk61nW90Z1h5bCRNd+3epnPRysb9C8eznF//FEXizVKqKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA0nM8Qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89556C19425;
	Fri, 30 Jan 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769780088;
	bh=B3P9f0B+pa1cmU6gFpc0gUraGYenQM/sjeWQeqg4wOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vA0nM8Qn8eN5BzIYnZC95+xQBERUbaxoInC1Gd2agsaJKrioI1OeN9odg1tlg1Jbw
	 Uld6XzidPygPBl7sbbCx7wBhz9NTIWiZ8LOGSFQ5P4WVBt8oH7OP4Pjrv1qXpdaUJS
	 qf7zIn14jzlFWs5yTWkJKKs4aMjcQ6flruEe0aqDz5lUoyOvOmG+b30hTmPX38cmTD
	 Wl9o3/w1tNFz+wln9AvHh2VtqrWMfboj7+HX3rvSbCi2D9XFc3MYd/MD3PVPzR8gtV
	 DcH9A00UIMggbUmpY6mkCTrjz6D4SVsE3Oct01FalkFYVWDYYzXFkOg1XWe+m9fGCn
	 NWbl2N0Q8ERjA==
Date: Fri, 30 Jan 2026 14:34:43 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>,
	containers@lists.linux-foundation.org, ebiederm@xmission.com,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <aXyzc6-9OqeZmP8a@example.org>
References: <aT_elfmyOaWuJRjW@example.org>
 <20251215144600.911100-1-danilklishch@gmail.com>
 <aUAiIkNPgied0Tyf@example.org>
 <20251224-glasbruch-mahnmal-ef7e9e10bceb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224-glasbruch-mahnmal-ef7e9e10bceb@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75943-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux-foundation.org,xmission.com,chromium.org,vger.kernel.org,zeniv.linux.org.uk];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legion@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B8D5BB1A9
X-Rspamd-Action: no action

On Wed, Dec 24, 2025 at 01:55:20PM +0100, Christian Brauner wrote:
> On Mon, Dec 15, 2025 at 03:58:42PM +0100, Alexey Gladkov wrote:
> > On Mon, Dec 15, 2025 at 09:46:00AM -0500, Dan Klishch wrote:
> > > On 12/15/25 5:10 AM, Alexey Gladkov wrote:
> > > > On Sun, Dec 14, 2025 at 01:02:54PM -0500, Dan Klishch wrote:
> > > >> On 12/14/25 11:40 AM, Alexey Gladkov wrote:
> > > >>> But then, if I understand you correctly, this patch will not be enough
> > > >>> for you. procfs with subset=pid will not allow you to have /proc/meminfo,
> > > >>> /proc/cpuinfo, etc.
> > > >>
> > > >> Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
> > > >> tree to the sandboxed programs (empirically, this is enough for most of
> > > >> programs you want sandboxing for). With that in mind, this patch and a
> > > >> FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
> > > >> /proc/cpuinfo / a small kernel patch with a new mount option for procfs
> > > >> to expose more static files still look like a clean solution to me.
> > > > 
> > > > I don't think you'll be able to do that. procfs doesn't allow itself to
> > > > be overlayed [1]. What should block mounting overlayfs and fuse on top
> > > > of procfs.
> > > > 
> > > > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/proc/root.c#n274
> > > 
> > > This is why I have been careful not to say overlayfs. With [2] (warning:
> > > zero-shot ChatGPT output), I can do:
> > > 
> > > $ ./fuse-overlay target --source=/proc
> > > $ ls target
> > > 1   88   194   1374    889840  908552
> > > 2   90   195   1375    889987  908619
> > > 3   91   196   1379    890031  908658
> > > 4   92   203   1412    890063  908756
> > > 5   93   205   1590    890085  908804
> > > 6   94   233   1644    890139  908951
> > > 7   96   237   1802    890246  909848
> > > 8   97   239   1850    890271  909914
> > > 10  98   240   1852    894665  909924
> > > 13  99   243   1865    895854  909926
> > > 15  100  244   1888    895864  910005
> > > 16  102  246   1889    896030  acpi
> > > 17  103  262   1891    896205  asound
> > > 18  104  263   1895    896508  bus
> > > 19  105  264   1896    896544  driver
> > > 20  106  265   1899    896706  dynamic_debug
> > > <...>
> > > 
> > > [2] https://gist.github.com/DanShaders/547eeb74a90315356b98472feae47474
> > > 
> > > This requires a much more careful thought wrt magic symlinks
> > > and permission checks. The fact that I am highly unlikely to 100%
> > > correctly reimplement the checks and special behavior of procfs makes me
> > > not want to proceed with the FUSE route.
> > > 
> > > On 12/15/25 6:30 AM, Christian Brauner wrote:
> > > > The standard way of making it possible to mount procfs inside of a
> > > > container with a separate mount namespace that has a procfs inside it
> > > > with overmounted entries is to ensure that a fully-visible procfs
> > > > instance is present.
> > > 
> > > Yes, this is a solution. However, this is only marginally better than
> > > passing --privileged to the outer container (in a sense that we require
> > > outer sandbox to remove some protections for the inner sandbox to work).
> > > 
> > > > The container needs to inherit a fully-visible instance somehow if you
> > > > want nesting. Using an unprivileged LSM such as landlock to prevent any
> > > > access to the fully visible procfs instance is usually the better way.
> > > > 
> > > > My hope is that once signed bpf is more widely adopted that distros will
> > > > just start enabling blessed bpf programs that will just take on the
> > > > access protecting instead of the clumsy bind-mount protection mechanism.
> > > 
> > > These are big changes to container runtimes that are unlikely to happen
> > > soon. In contrast, the patch we are discussing will be available in 2
> > > months after the merge for me to use on ArchLinux, and in a couple more
> > > months on Ubuntu.
> > > 
> > > So, is there any way forward with the patch or should I continue trying
> > > to find a userspace solution?
> > 
> > I still consider these patches useful. I made them precisely to remove
> > some of the restrictions we have for procfs because of global files in
> > the root of this filesystem.
> > 
> > I can update and prepare a new version of patchset if Christian thinks
> > it's useful too.
> 
> Let's see it at least! No need to preemptively dismiss it. :)
> 

So what do you think about these changes?

https://lore.kernel.org/all/cover.1768295900.git.legion@kernel.org/#t

-- 
Rgrds, legion


