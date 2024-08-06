Return-Path: <linux-fsdevel+bounces-25169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D494982F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F401C2167A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3D1514E1;
	Tue,  6 Aug 2024 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pU1nIbns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4713C90B;
	Tue,  6 Aug 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972288; cv=none; b=N5YV6cJX5QlxXc/A0b44jSQmtKLD7u2axxr+kr0uLjOyv3SMS/BX+onf2Gc1l4eka4x0xNPsqlxofag2QAnELdGueEl/2IgFX1qRiCx2q77NMSrH535+HWlhxjCAlAu9HWCzT0VH+AIpxM7h5hhjx3iQso8O3csP4pXhpW6PkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972288; c=relaxed/simple;
	bh=4gbTg6sRbIzoCnBVCnT/nCz6ATeU7FH1cjOBD45zYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHIAYCx2umkb1kDIuWDIiZ8eAolNyD6WQbeEWrQfWUhC1CSwoLmvfKk/1SaWDWoJ3sYaAS3Srgs+zUAxkBLHVF9EnAJOaONRZnPGKd5igCz5gUfVulApXA4Oh4s9ljk3Anc9/u5V5R++s54wiqHUAKEeuMjdGYuwE0HbGDowirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pU1nIbns; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722972275;
	bh=4gbTg6sRbIzoCnBVCnT/nCz6ATeU7FH1cjOBD45zYkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pU1nIbnsSAhLR+Qzy0iAXlaj4sF+T1DUdytsrPVbaG9uu5vXUpqXplO+4KUfunisy
	 xv/WmPn4pkdHhn4zrAFr4BZSlhZcG3/sWSExdM2JRbxBdUweej9+xsoztftUd16KIW
	 fhbQ/Wk+8tHXwQEY43UrzcqrHdR2RwtcmH5U1KFE=
Date: Tue, 6 Aug 2024 21:24:33 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Solar Designer <solar@openwall.com>
Cc: Joel Granados <j.granados@samsung.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Kees Cook <keescook@chromium.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <97a52396-3b86-47a5-ae02-8a979f6fc375@t-8ch.de>
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
 <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
 <20240806185736.GA29664@openwall.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806185736.GA29664@openwall.com>

On 2024-08-06 20:57:37+0000, Solar Designer wrote:
> On Tue, Jul 16, 2024 at 04:16:56PM +0200, Joel Granados wrote:
> > sysctl changes for 6.11-rc1
> > 
> > Summary
> > 
> > * Remove "->procname == NULL" check when iterating through sysctl table arrays
> > 
> >     Removing sentinels in ctl_table arrays reduces the build time size and
> >     runtime memory consumed by ~64 bytes per array. With all ctl_table
> >     sentinels gone, the additional check for ->procname == NULL that worked in
> >     tandem with the ARRAY_SIZE to calculate the size of the ctl_table arrays is
> >     no longer needed and has been removed. The sysctl register functions now
> >     returns an error if a sentinel is used.
> > 
> > * Preparation patches for sysctl constification
> > 
> >     Constifying ctl_table structs prevents the modification of proc_handler
> >     function pointers as they would reside in .rodata. The ctl_table arguments
> >     in sysctl utility functions are const qualified in preparation for a future
> >     treewide proc_handler argument constification commit.
> 
> As (I assume it was) expected, these changes broke out-of-tree modules.
> For LKRG, I am repairing this by adding "#if LINUX_VERSION_CODE >=
> KERNEL_VERSION(6,11,0)" checks around the corresponding module changes.
> This works.  However, I wonder if it would possibly be better for the
> kernel to introduce a corresponding "feature test macro" (or two, for
> the two changes above).  I worry that these changes (or some of them)
> could get backported to stable/longterm, which with the 6.11+ checks
> would unnecessarily break out-of-tree modules again (and again and again
> for each backport to a different kernel branch).  Feature test macro(s)
> would avoid such further breakage, as they would (be supposed to be)
> included along with the backports.

I don't see any of these changes being backported.

The removal of the "->procname == NULL" check depends on all in-kernel
tables being registered with an explicit size, which is not the case on
old kernels. So a backport would not only silently fail for external
modules but also for internal code.
The same for the constification patches but with build errors instead of
runtime errors.

My future sysctl constification patches will be backwards compatible at
both compiletime and runtime, for both internal and external code.

So the version checks should be enough here.

