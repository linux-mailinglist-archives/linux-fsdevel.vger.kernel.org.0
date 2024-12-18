Return-Path: <linux-fsdevel+bounces-37734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436BB9F6722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 14:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224E87A02BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71031B0414;
	Wed, 18 Dec 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ8tAXMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354A1A23B5;
	Wed, 18 Dec 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528095; cv=none; b=YYn7J4UzogMk66PA2lvIAet2indiCzEBIsvcybsKfCDZY9eTh+V7e4+jXG2DD36QZcIW/Y3jOOx0SmhMpCqFh7A0vDlqpFurPl48KEMZhZwg3tqIRLrN552Msxg0vPELWd6VBVXEDd8SB77KrpC623WUV2JFKu2flYzeVUrFbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528095; c=relaxed/simple;
	bh=71mLjnZCvW8VxXrySXtk1e5ySCMygN7QMJy9B3FWeeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7vnt5naYYFgw7fSNLyT6l2HWEs03ghzBmDYp5BxljjbfYL5iRegv2PpEgnzRxYo/cEeR+OUtLZWdxxT4kqtYT1rIUSo0bZA/rN5L2hdZYiew0wIDpVFplvhmfJzfihJhlx5Lqd0iMXwCqgAIae8bL2Npkre3Ppy0Sm8kefhp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ8tAXMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A6C4CECE;
	Wed, 18 Dec 2024 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734528094;
	bh=71mLjnZCvW8VxXrySXtk1e5ySCMygN7QMJy9B3FWeeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ8tAXMoIh1pGzzZ/JYlaGsQwppy0bRokQ3qy5kFED2pARYcQruXgGiY5QhqLd2uH
	 pGx673Vvcvirb1LA10RZjz+mqX0GD4Quy40ezWm/Q8+I7+utj3fi2WFDvkeQDRyrXe
	 dQcUw7d0SnKNzegar0fHkKdF2EdSQqVTzTOoY84XoFiQGQ25RYB2Jd28rVdOVgKmqx
	 AXSq66XKM0rZ22ZtcE2Foqj5nKvaIqQk+jsUrl11UV591YSTlj+xdaXCoIpSO8sZoQ
	 qY9hwlIzrcE6hRvsyBnKNsK/Gmo2k6mmAph4i3IOaeSCQ7QI8FpKXhEh93eeqESZ62
	 PgW5mDEAktBYg==
Date: Wed, 18 Dec 2024 14:21:29 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Re: [PATCH v2 2/3] sysctl: Fix underflow value setting risk in
 vm_table
Message-ID: <lfdhvbnqhzrnu4efozlr3qydmrzbykvya3cb4lfpkdyacfkvac@j7eij7pvqhlu>
References: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
 <20241114162638.57392-3-nicolas.bouchinet@clip-os.org>
 <4ietaibtqwl4xfqluvy6ua6cr3nkymmyzzmoo3a62lf65wtltq@s6imawclrht6>
 <2d5447b7-c185-4ce9-852e-b56a28b0306a@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5447b7-c185-4ce9-852e-b56a28b0306a@clip-os.org>

On Tue, Dec 10, 2024 at 03:58:41PM +0100, Nicolas Bouchinet wrote:
> Hi Joel,
> 
> 
> Thank's for your reply.
> 
> I apologize for the reply delay, I wasn't available late weeks.
> 
> On 11/20/24 1:53 PM, Joel Granados wrote:
> > On Thu, Nov 14, 2024 at 05:25:51PM +0100, nicolas.bouchinet@clip-os.org wrote:
> >> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >>
> >> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
> >> vm_table") fixes underflow value setting risk in vm_table but misses
> >> vdso_enabled sysctl.
> >>
> >> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> >> avoid negative value writes but the proc_handler is proc_dointvec and not
> >> proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> >>
> >> The following command thus works :
> >>
> >> `# echo -1 > /proc/sys/vm/vdso_enabled`
> > It would be interesting to know what happens when you do a
> > # echo (INT_MAX + 1) > /proc/sys/vm/vdso_enabled
> 
> Great question, I'll check that.
> 
> >
> > This is the reasons why I'm interested in such a test:
> >
> > 1. Both proc_dointvec and proc_dointvec_minmax (calls proc_dointvec) have a
> >     overflow check where they will return -EINVAL if what is given by the user is
> >     greater than (unsiged long)INT_MAX; this will evaluate can evaluate to true
> >     or false depending on the architecture where we are running.
> 
> Indeed, I'll run tests to avouch behaviors of proc handlers bound checks 
> with
> different architectures.
> 
> >
> > 2. I noticed that vdso_enabled is an unsigned long. And so the expectation is
> >     that the range is 0 to ULONG_MAX, which in some cases (depending on the arch)
> >     would not be the case.
> Yep, it is. As I've tried to explain in the cover letter
> (https://lore.kernel.org/all/20241112131357.49582-1-nicolas.bouchinet@clip-os.org/),
> there are numerous places where sysctl data type differs from the proc 
> handler
> return type.
> 
> AFAIK, for proc_dointvec there is more than 10 different sysctl where it
> happens. The three I've patched represents three common mistakes using
> proc_handlers.
It would be useful to analyze the others. Do you have more outstanding
patches for these?

> 
> >
> > So my question is: What is the expected range for this value? Because you might
> > not be getting the whole range in the cases where int is 32 bit and long is 64
> > bit.
> >
> >> This patch properly sets the proc_handler to proc_dointvec_minmax.
> >>
> >> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> >> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >> ---
> >>   kernel/sysctl.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index 79e6cb1d5c48f..37b1c1a760985 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -2194,7 +2194,7 @@ static struct ctl_table vm_table[] = {
> >>   		.maxlen		= sizeof(vdso_enabled),
> >>   #endif
> >>   		.mode		= 0644,
> >> -		.proc_handler	= proc_dointvec,
> >> +		.proc_handler	= proc_dointvec_minmax,
> >>   		.extra1		= SYSCTL_ZERO,
> > Any reason why extra2 is not defined. I know that it was not defined before, but
> > this does not mean that it will not have an upper limit. The way that I read the
> > situation is that this will be bounded by the overflow check done in
> > proc_dointvec and will have an upper limit of INT_MAX.
> 
> Yes, it is bounded by the overflow checks done in proc_dointvec, I've not
> changed the current sysctl behavior but we should bound it between 0
> and 1 since it seems vdso compat is not supported anymore since
> Commit b0b49f2673f011cad ("x86, vdso: Remove compat vdso support").
I think you have already done this in your V3

> 
> This is the behavior of vdso32_enabled exposed under the abi sysctl
> node.
> 
> >
> > Please correct me if I have read the situation incorrectly.
> You perfectly understood the problematic of it, thanks a lot for your 
> review.
> 
> I'll reply to above questions after I've run more tests.
> 
> I saw GKH already merged the third commit of this patchset and 
> backported it to stable branches.
> Should I evict it from future version of this patchset ?
Yes. You should remove what has already been merged into main
line. thx.

Best 

-- 

Joel Granados

