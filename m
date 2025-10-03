Return-Path: <linux-fsdevel+bounces-63411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98138BB83B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DCD3BE2FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3826E71D;
	Fri,  3 Oct 2025 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrTUJRyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14C33E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528128; cv=none; b=QlWNyLNiSVYP6oHHdReGcfkdgNybhnvXZT/wOuNGE7z6mvP9Mw98XSldzLAtQl3bP7TW/Ngl+0JvVZ/x9DbEdbjkvWBMpOZGtVptNggvXE/UID9xlunPIWlyiDKBKgXgo2DvvIlN8/o9wdR7l4G3Ru+pPsdFJDVN6irfgkFDqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528128; c=relaxed/simple;
	bh=HhWWv5zSFK9LUq2+HHkBfmDKFaw71T9zcSAZpBtgbrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx5m0iWBi0u3dz82LZuDbrKALcV3x4DoHan7CpiFgYkMN1WfO67yPLgl3H5LWiiF8tB6w3AEnt3y312Uih17SXuKTTYukd53StKG1zrZSgD06SA2hFDSOYNLnsps5b9ASvDEcSD6xBzbmckOPlr0rgNXImO14feU92kugwfc14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrTUJRyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B76C4CEF5;
	Fri,  3 Oct 2025 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759528128;
	bh=HhWWv5zSFK9LUq2+HHkBfmDKFaw71T9zcSAZpBtgbrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrTUJRyWbI4y1Fy+NH6vjRdDjsdz3+6D1fhlnxyIcdjfGHmekz4P1FN6IjSG2S2pg
	 WV4es8TaLpSSpErr6PK3UJpjv3GVLqY1br10wFjIxtfiDWmCxlUEqUyecVrig8zes8
	 KUucTLzrKRwsXaUO/72dgp0Jwr/XkALX4R2tHF3OVQQpYzDQ64ndk6/H9roTlADDAZ
	 QMCOlm65ykdtHvteWykIT1mn21MIqRZ3dsKY+NU7Qo7mK9kc+BKN/VyfNkeF/8YiKW
	 qz2NjUT4Xrvk8mbbAvSdB2sV2v0rLUBVx2O1LVqKPieSiREZXAtWg540+ch3dcoMsC
	 3EXJPDV5R9+zQ==
Date: Fri, 3 Oct 2025 11:48:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] udf and quota fixes for 6.18-rc1
Message-ID: <aOBEvrdMHCNSYVEt@slm.duckdns.org>
References: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
 <CAHk-=wicSxaRNJwTJqvCMCQjoL1KozAdVVq55jYcp-PfgsK2QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicSxaRNJwTJqvCMCQjoL1KozAdVVq55jYcp-PfgsK2QQ@mail.gmail.com>

Hello,

On Fri, Oct 03, 2025 at 01:43:20PM -0700, Linus Torvalds wrote:
> On Wed, 1 Oct 2025 at 04:29, Jan Kara <jack@suse.cz> wrote:
> >
> > Shashank A P (1):
> >       fs: quota: create dedicated workqueue for quota_release_work
> 
> I've pulled this, but I do wonder why we have so many of these
> occasional workqueues that seem to make so little sense.
> 
> Could we perhaps just add a system workqueue for reclaim? Instead of
> having tons of individual workqueues that all exist mainly just for
> that single reason (and I think they all end up also getting a
> "rescuer" worker too?)

Usually the problem is that a WQ_MEM_RECLAIM workqueue can only guarantee
forward progress of a single work item at any moment. If there are two work
items where one depends on the other to make forward progress, putting those
two on the same workqueue will lead to deadlocks under memory pressure.

So, two subsystems can share a WQ_MEM_RECLAIM workqueue iff two two are
guaranteed to not stack. If e.g. ext4 uses quota and if an ext4 work item
can wait for quot_release_work() to finish, then putting them on the same
WQ_MEM_RECLAIM will lead to a dead lock.

One thing we can improve is how these workqueues are initialized. Maybe we
can lazy-init the rescuer so that we don't end up with a bunch of rescuer
threads that are never used. A lot of subsystems end up creating
WQ_MEM_RECLAIM workqueues whether it actually ends up getting used or not.
It'd be nice if we can just tie rescuer creation to the first work being
issued but we might already need forward progress guarantee at that point.
Don't see a nice way out yet. Will think more about it.

Thanks.

-- 
tejun

