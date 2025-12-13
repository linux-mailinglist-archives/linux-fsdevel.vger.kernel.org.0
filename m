Return-Path: <linux-fsdevel+bounces-71248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A3CBA835
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 11:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6F423014DD2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E262FF65C;
	Sat, 13 Dec 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m953ILED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06191FDA;
	Sat, 13 Dec 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765622961; cv=none; b=OxS381ZN9eVYI4XZGRFPKJwwxl6WgjWngmhvxJofyh7Jy3/x22ggbLjzkqgPQ84kwmnIkwXtI0hP7cp3w4BWWeT/H+OTcF1ZD+1HOubEfR8V5dmLd5txwP1eZsa2Jye4BTSP/9WlWWCSuk6FWb4nAD7OenAlGuTOI1H6QFyN6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765622961; c=relaxed/simple;
	bh=iAQBFbRw5K72ddB3OWXDtL04ccf869ucsls0AmgMOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH+EpCs/sUloLE77aDUu9Mf+PD8Kjv/YnroSP4ipbPeJ1or1x9wxNV5pa3sLJqIJA8b8FIgFkiw7S+MEaHrJ61w7dOfiCV3TvzIAioK+jPr4AaBDCanWTrOkfiwGoC+a5jJbJFoDtwXxOZSeN/UZgWceeYTJVFhIlMjpHcF/T/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m953ILED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1020EC4CEFB;
	Sat, 13 Dec 2025 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765622961;
	bh=iAQBFbRw5K72ddB3OWXDtL04ccf869ucsls0AmgMOIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m953ILEDsnU4qRyLVZTRyZDEK+3/WpmSfFQZrLy8HrYhIs7no1Jz93hvifWak1i8q
	 xTN/WyrI/MWi+OqGNkChXs5GPN9AkMD1Pnzl2Nd3tMcxZsb2XvLKBN9opPqSbeiVSr
	 5RjnJ03JtNyVePXV6WlgXSOfGIWM+1BYuzbT124jxsz5CzvW6oJOqJCl/km0wPcC6n
	 WbQdyRQr9jANH+lEEKbWmMQ18Wu0IpXjn051vECVziJ73lMstqOl9tqG3Oc9MzM6Ju
	 lhfmxjQdjEjwZX5Q2Ko63ORKboqlprTjrCFY7ZIYqcPrVx/qNZWc/Qg5nvVm8Clr9B
	 FWc9YyS4YkMZw==
Date: Sat, 13 Dec 2025 11:49:16 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Dan Klishch <danilklishch@gmail.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
	viro@zeniv.linux.org.uk, keescook@chromium.org,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <aT1ErArrTmp-sAiO@example.org>
References: <cover.1626432185.git.legion@kernel.org>
 <20251213050639.735940-1-danilklishch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213050639.735940-1-danilklishch@gmail.com>

On Sat, Dec 13, 2025 at 12:06:38AM -0500, Dan Klishch wrote:
> Hello Alexey,
> 
> Would it be possible to revive this patch series?
> 
> I wanted to add an additional downstream use case that would benefit
> from this work. In particular, I am trying to run the sandbox
> sunwalker-box [1] without root privileges and/or inside a container.
> 
> The sandbox aims to prevent cross-run communication via side channels,
> and PID allocation is one such channel. Therefore, it creates a new PID
> namespace and mounts the corresponding procfs instance inside of the
> sandbox. This currently works without a real root when procfs is fully
> accessible, but obviously fails otherwise.
> 
> Thanks,
> Dan Klishch
> 
> [1] https://github.com/purplesyringa/sunwalker-box/
> 

Overmounting "dangerous" files in procfs is an incorrect and potentially
dangerous practice. I know that many programs (docker, podman, etc.) use
this method, but it is not the correct way to isolate dangerous files in
procfs.

In particular, this is one of the reasons why this patchset was abandoned.

It is quite difficult to implement these checks in procfs correctly and
not break anything. It is much easier to implement file access
restrictions in procfs using an ebpf controller. Some time ago, I tried to
implement such a controller [1], and it seemed to me that it was much
easier than adding complex checks to the kernel.

If I'm wrong and missing a use case, let me know and we can go back to
the patches.

[1] https://github.com/legionus/proc-bpf-controller

-- 
Rgrds, legion


