Return-Path: <linux-fsdevel+bounces-44480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B879A69A06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD06F482BA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7921507C;
	Wed, 19 Mar 2025 20:11:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD6214A9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415110; cv=none; b=UGW7pdgL9ALERMo1dTN3jvxW52/KcZU1EDaLoKhKblKc+qvtY++LRyWNtPDJzww/0VurUFEhsitXQf5k+I+161DSCoewZzb1tQlNV5nEyEsJrWfwx7qBffJMKiS9imSIBGjAXN31BmUUR/ZPK4sR0db9R2lzb9yk57IdCVRwkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415110; c=relaxed/simple;
	bh=81nD7saQF+05JrgCYJNAM3QnS25Eq1AdutpQuce0pyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp2d4tEulNYWFXflVmamtUUgytVDqsk1NMxs2SCCB+BgdtNzXE4dfb25eeLaGDJ97VsD8LpQxG92OnvgfYpbHF+L749wG9pduLeTc3Aj1oRzr7Ohe0O/ja1d2wut8J/voDrIiQ6hlW7RPKk8azC7Soi84pxidobeqeRV/bVdgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JKBRZp023955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 16:11:27 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 039CC2E010B; Wed, 19 Mar 2025 16:11:27 -0400 (EDT)
Date: Wed, 19 Mar 2025 16:11:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
        gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mic@digikod.net,
        Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250319201126.GA1079074@mit.edu>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <Z9kC7MKTGS_RB-2Q@dread.disaster.area>
 <Z9rbDdLr0ai-UFE_@itl-email>
 <20250319165931.GD1061595@mit.edu>
 <Z9r_19pcJCbDxPIQ@itl-email>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r_19pcJCbDxPIQ@itl-email>

On Wed, Mar 19, 2025 at 01:32:59PM -0400, Demi Marie Obenour wrote:
> > I suspect that using a kernel file system running in a guest VM and
> > then making it available via 9pfs would be far more performant than
> > something involving FUSE.  But the details would all be in the
> > implementation, and the skill level of the engineer doing the work.
> 
> Why do you suspect this?  I'm genuinely curious, especially because my
> understanding is that virtiofs (which uses the FUSE protocol internally)
> is considered faster than 9pfs.

I was saying that 9pfs is faster than fuse.  Yes, virtiofs would be
faster than 9pfs.  No question.  However, it might be harder to audit
the virtiofs client implementation given the virtiofs ring buffer
interface to make sure it is free of potential security exploits.9pfs
would be simpler to reassure folks that it is safe(tm).

> The need to resort to virtualization as a security boundary makes me
> wonder if Linux is designed for outdated threat models and security
> paradigms.  Sadly, changing the threat model would be extremely
> expensive today.

I wouldn't say that it's specific to Linux; for many, MANY, MANY
decades, the disk drive was considered within the Trusted Computing
Boundary.  This was true for Multics; VMS; Unix, and other operating
systems that were certified to the Trusted Computing System Evaluation
Criteria (aka the "Orange Book") to the B1 and B2 certification

Ejecting the storage device so it is outside the TCB is a huge change
in the threat model, especially given that for a long time people have
made performance, including simultaneous modifications to the same
file, the primary requirement for most file systems.

If we want to make a single, simple file system that is good enough
for file exchange and backup, where we only need to optimize for
sequental, single-threaded I/O, and for low-cost or moderate-cost
flash devices, that's a much simpler sort of file system that we could
secure against this modified threat model.

However, given how much companies have always been massively stingy
about funding file system development (and these days, anything which
isn't AI :-), I suspect a sandbox/VM approach is going to be a much
more cost effective approach.  But I'm happy to be proven wrong, if
some company is willing to fund the effort --- let's see the names and
we can invite them into the relevant collaboration forums, such as the
weekly ext4 video conference if it's appropriate.

However, just having security people kvetching on open source mailing
lists, or raising syzbot bugs for threat models that the file system
maintainers had never agreed to, and then trying to bully or shame
volunteers to do the work for free is, I would argue, not productive.

Cheers,

					- Ted

