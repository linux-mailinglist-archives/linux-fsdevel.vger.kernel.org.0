Return-Path: <linux-fsdevel+bounces-40507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA999A24185
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A07164029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAE81EE7AA;
	Fri, 31 Jan 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9+Dmayg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3DF38DF9;
	Fri, 31 Jan 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343146; cv=none; b=t50hQYjePJE1SQbSFzqZGSbtdqonNySrW90DABlKoINufQj5WJNIYMfeeFT9m0SjuaOCbanNbfm1CKToEuty7x+hy7K844D/dQ85ZhDl4j+8iEAROfMhqBmK72mzCX7H9mN8LH9WssLUn9+IPOQbHzjimgIeMssovha37L0DIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343146; c=relaxed/simple;
	bh=GzNm+yNw+pdzz2orVudQOrEVeefnZ5aaovRcTdm0BGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyL9FFqNiG1vSL6t0lEt5BZ9LTu767qzL5wimPPmxC3I6Xg4H6mlbvZJYigarNRI405QK1CQpTKwRYkndjpNLf/3FYWtWE63Ai9mz0ZFVapR1vrRdyqy7LUUz9YcwjffGK35kshv/syF9nlEI3ty9JelUEwcE0aHD8+tpnetfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9+Dmayg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04D9C4CED1;
	Fri, 31 Jan 2025 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738343145;
	bh=GzNm+yNw+pdzz2orVudQOrEVeefnZ5aaovRcTdm0BGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9+Dmayg8UpBzjZETE4+Ds8Q5ZSCUQfFG1/PFVqiRbHaR5xhzIA+m736rsvI/MJ/o
	 9j1V7KhnNmBUOZ7ThlmFQkzt8fTZgw8gB/+qToP1kQufHd/m55wAIgwJirLmGcpEpX
	 siVUD7bvN3YIwh+mEFCMXjI/Fo/xkdOX8X1gXLRHBBvI47fEQPblELnoVMVReHDmNr
	 wu4uzXcIM5yzgt0rStG05cGvbW0xZkAHim4eeIOEjeSbkGS0KgzAdAK54lblUzbDAZ
	 goHZjStxHi0DG4EApxed+DgiM0zIgZaGIbi7VlQZ9EnwkNkIVbsKX0cRh9k+JO5N14
	 3ZQhk2NLOcBqg==
Date: Fri, 31 Jan 2025 14:57:40 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, 
	Ashutosh Dixit <ashutosh.dixit@intel.com>, Baoquan He <bhe@redhat.com>, 
	Bill O'Donnell <bodonnel@redhat.com>, Corey Minyard <cminyard@mvista.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Re: [GIT PULL] sysctl constification changes for v6.14-rc1
Message-ID: <iay2bmkotede6c5xkxnfvxwgxg2drmcc6az3eeiijkkz3ftie7@co4cir66ksz2>
References: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
 <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>

On Wed, Jan 29, 2025 at 10:48:02AM -0800, Linus Torvalds wrote:
> On Wed, 29 Jan 2025 at 00:14, Joel Granados <joel.granados@kernel.org> wrote:
> >
> >   All ctl_table declared outside of functions and that remain unmodified after
> >   initialization are const qualified.
> 
> Hmm. A quick grep shows
> 
>     static struct ctl_table alignment_tbl[5] = {

Very good catch!

I missed this one because it defines the size of the ctl_table array and
my spatch did not account for that case.

It turns out that the number in the square brackets does not coincide
with the number of elements in the array. I would expect this results in
a failure in the sysctl_check_table function; I dont have a csky system
to test though.

In any case there is an easy untested fix:

From 431abf6c9c11a8b7321842ed0747b3200d43ef34 Mon Sep 17 00:00:00 2001
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 31 Jan 2025 14:10:57 +0100
Subject: [PATCH] csky: Remove the size from alignment_tbl declaration

Having to synchronize the number of ctl_table array elements with the
size in the declaration can lead to discrepancies between the two
values. Since commit d7a76ec87195 ("sysctl: Remove check for sentinel
element in ctl_table arrays"), the calculation of the ctl_table array
size is done solely by the ARRAY_SIZE macro removing the need for the
size in the declaration.

Remove the size for the aligment_tbl declaration and const qualify the
array for good measure.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 arch/csky/abiv1/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index e5b8b4b2109a..aee904833dec 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -300,7 +300,7 @@ void csky_alignment(struct pt_regs *regs)
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
 }
 
-static struct ctl_table alignment_tbl[5] = {
+static const struct ctl_table alignment_tbl[] = {
 	{
 		.procname = "kernel_enable",
 		.data = &align_kern_enable,
-- 
2.44.2

I'll queue this up for the next release unless you take it in now.
> 
> in arch/csky/abiv1/alignment.c that didn't get converted.
> 
> And a couple of rdma drivers (iwcm_ctl_table and ucma_ctl_table), but
These two are accounted for. I'll get to them eventually.

> maybe those weren't converted due to being in the "net" address space?
> 
> Anyway, taken as-is, I'm just noting the lacking cases.
> 
>             Linus

-- 

Joel Granados

