Return-Path: <linux-fsdevel+bounces-43641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381BA59B07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAAF1886159
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B022FF21;
	Mon, 10 Mar 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8RHn6OS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4A1E519;
	Mon, 10 Mar 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624192; cv=none; b=DfG/nWoUBCqhH6wQFauLp36HBi/qC6ZNIqeMPr8t1TS92wX9MrLUCiu1UeGDiMgeAClt1Us9iCieC942hLVn70Si5XtAsletSSNLwESP+sDc9awc1NVE/Q1+Hq9UfMvy2mA3McJ+GszwaUDjnlSwFc4k/E0Ct8Hs8+yC3up3asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624192; c=relaxed/simple;
	bh=gABqmGkapmTt2L/4ZtpVO5U5Zj/H+RDxhf8PyL6oVv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meDTA/V7xoF9haRhEnEm3ixbpEkLuT44JLzXCiIj7BtctqEHit8GlU1Sd6fhP3peDa1wIo8p4jRG1RfzPQ//Q8SVhKPm/lnPleVk/PflGtmbK5OHBrQJEaEF1lkO1wUIv/4FESvpH3EpPGRdQ9pbMG7Gcd8rFs61r3HVP/AI1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8RHn6OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA831C4CEE5;
	Mon, 10 Mar 2025 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741624192;
	bh=gABqmGkapmTt2L/4ZtpVO5U5Zj/H+RDxhf8PyL6oVv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z8RHn6OSg2yPaH56yWA0H9dS+yWzzMcHZVmRSW6jgHmOmDrBY/V6BZorZsvNA/EHt
	 9l6XlRW1HF2InIvxoGRx8ZJPOdAI6C09gBtPVZ0j1FNSs8KRRtJQF19qmv1THWCwtz
	 6DR12n5Ny1hUi4+Px8uB3tEExjOpXxWPLlcsOEgQ=
Date: Mon, 10 Mar 2025 17:29:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <2025031039-gander-stamina-4bb6@gregkh>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>

On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
> > On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
> >> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
> >>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
> >>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
> >>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
> >>>>>
> >>>>> There are reports of this commit breaking Chrome's rendering mode.  As
> >>>>> no one seems to want to do a root-cause, let's just revert it for now as
> >>>>> it is affecting people using the latest release as well as the stable
> >>>>> kernels that it has been backported to.
> >>>>
> >>>> NACK. This re-introduces a CVE.
> >>>
> >>> As I said elsewhere, when a commit that is assigned a CVE is reverted,
> >>> then the CVE gets revoked.  But I don't see this commit being assigned
> >>> to a CVE, so what CVE specifically are you referring to?
> >>
> >> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> > 
> > That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory reads
> > for offset dir"), which showed up in 6.11 (and only backported to 6.10.7
> > (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
> > d_children list to iterate simple_offset directories") is in 6.14-rc1
> > and has been backported to 6.6.75, 6.12.12, and 6.13.1.
> > 
> > I don't understand the interaction here, sorry.
> 
> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
> directory offsets to use a Maple Tree"), even though those kernels also
> suffer from the looping symptoms described in the CVE.
> 
> There was significant controversy (which you responded to) when Yu Kuai
> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
> That backport was roundly rejected by Liam and Lorenzo.
> 
> Commit b9b588f22a0c is a second attempt to fix the infinite loop problem
> that does not depend on having a working Maple tree implementation.
> b9b588f22a0c is a fix that can work properly with the older xarray
> mechanism that 0e4a862174f2 replaced, so it can be backported (with
> certain adjustments) to kernels before 0e4a862174f2.
> 
> Note that as part of the series where b9b588f22a0c was applied,
> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
> leaves LTS kernels from v6.6 forward with the infinite loop problem
> unfixed entirely because 64a7ce76fb90 has also now been reverted.
> 
> 
> >> The guideline that "regressions are more important than CVEs" is
> >> interesting. I hadn't heard that before.
> > 
> > CVEs should not be relevant for development given that we create 10-11
> > of them a day.  Treat them like any other public bug list please.
> > 
> > But again, I don't understand how reverting this commit relates to the
> > CVE id you pointed at, what am I missing?
> > 
> >> Still, it seems like we haven't had a chance to actually work on this
> >> issue yet. It could be corrected by a simple fix. Reverting seems
> >> premature to me.
> > 
> > I'll let that be up to the vfs maintainers, but I'd push for reverting
> > first to fix the regression and then taking the time to find the real
> > change going forward to make our user's lives easier.  Especially as I
> > don't know who is working on that "simple fix" :)
> 
> The issue is that we need the Chrome team to tell us what new system
> behavior is causing Chrome to malfunction. None of us have expertise to
> examine as complex an application as Chrome to nail the one small change
> that is causing the problem. This could even be a latent bug in Chrome.
> 
> As soon as they have reviewed the bug and provided a simple reproducer,
> I will start active triage.

What ever happened with all of this?

thanks,

greg k-h

