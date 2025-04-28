Return-Path: <linux-fsdevel+bounces-47484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7660A9E6E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 06:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C020E3B6540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46119DF6A;
	Mon, 28 Apr 2025 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG8o1cN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590778F4A;
	Mon, 28 Apr 2025 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745813249; cv=none; b=TPB9E0kP8bpWnL/E1YTn6mUc39Pu9tI4zzLILHHxrroyywC8ZRMgE0t2cTXPmGbBe92ti50G8Vgvufvwg7cudQOl60jE5Ej5BDGquxijG29VHiW0VHB889tb8ogs05eHtcVyRiS08D6/VvVVnz7gWWvgZJqJQx/pPgSvOGMM/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745813249; c=relaxed/simple;
	bh=FDa3IY0GgwpkF7KII9NWs+I70tvBHTz6uJWecx+X7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1TewGrICPa+D6fRCJM5NuerCNGYXaqeOnJ7tiVFipt/WIKifMtSBd+T6TnVqX/DgYW7SOnehyH3gnjWfV0c9k5zAWUwR1SMs1F84yWdOwI8jJFYQcbjLsTbl8s0K1va50FPZOLB+OrzfuTzy624BQWqAuD9vnDsPVAT/E3oYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG8o1cN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A25C4CEE4;
	Mon, 28 Apr 2025 04:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745813248;
	bh=FDa3IY0GgwpkF7KII9NWs+I70tvBHTz6uJWecx+X7OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IG8o1cN67tq0dKLWnlT8s7Rf5RBJGfD+afA9CvH08IgW3loK4I000b6fHyuDln+Cn
	 LOJSjOaWvLAZnq7OLRbB9R64rQJRSzBRcw1qhaCa9rFjRJhIiLcnBKWcwpL61b2jaT
	 P3qi621fZSrczSR3en4WDWOb47csHNloUZDK+/fHryFgRDvtoQ60ZxKSO7R1Rlf/RU
	 k2MO9A1obwx7MydCXj6lbC/x5jCFTIskDmIDcbwkPVUPPDPFcjdVUL5IEo0fh2AvLd
	 FhZTd5lBnrh8XV+615p+LTS96cmw+H4A9vYsS78PcCyZPrmVWOH2CeDrmwXHWvJ+nK
	 6hZwRGzAHxFpw==
Date: Sun, 27 Apr 2025 21:07:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	netdev@vger.kernel.org
Cc: Zach Brown <zab@zabbo.net>, Matthew Wilcox <willy@infradead.org>
Subject: Re: Call for Proposals for fossy.us 2025
Message-ID: <20250428040728.GA1035866@frogsfrogsfrogs>
References: <20250422033344.GI25700@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422033344.GI25700@frogsfrogsfrogs>

On Mon, Apr 21, 2025 at 08:33:44PM -0700, Darrick J. Wong wrote:
> Hi folks,
> 
> I'd like to (very belatedly) invite you all to the 2025 fossy.us
> conference that's being put on by Software Freedom Conservancy:
> 
> https://2025.fossy.us/
> 
> This is their third year of operation, and this time they've added a
> track for Linux kernel topics!  Originally the track was going to be run
> by willy and I, but he had to drop out for various reasons.  zab has
> stepped up to fill the gap.
> 
> We're looking for people to propose sessions for the track.  These can
> be informal presentations, discussion sections, or even a panel.  In the
> past two editions, the attendees have ranged from technical folks from
> userspace projects to free software advocates who operate in the
> political and legal spheres.  I think the most interesting topics would
> involve the kernel <-> userspace barrier, or technical deep-dives into
> how do the more complex parts of the kernel actually work, but I
> obviously have kernel-tinted glasses and welcome any strong proposal.
> 
> Anyhow, the CfP deadline is April 28th, so please lob whatever proposals

...and has now been extended until May 5th.  We've gotten a few
proposals and look forward to the rest! ;)

--D

> you have soon.  The conference is in Portland, Oregon (USA) at the end
> of July, which ... I know is going to be problematic for a lot of
> people.  This is a tough year for conferences (both planning and
> attending) so if you have questions, please feel free to ask them here
> or privately.
> 
> --Darrick (and Zach)
> 

