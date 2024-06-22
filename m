Return-Path: <linux-fsdevel+bounces-22183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9D9134F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C8B1C21342
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8D16FF3F;
	Sat, 22 Jun 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCMgpPiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569914B078;
	Sat, 22 Jun 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072304; cv=none; b=nnyXcHW7NKGfvim41GWEtVXB0lnvJD8vn/QCM17MOXyrwpk/+4zscAo05NC6mqwJPtrSrspW1MRkrEScCcwd26creJ6pSEubEvWIfIAd89yRmcB6sFTdtPw4+ahJv//8wjbGz0a3RLuB31S4gm6B1oi5GD80WlUPh7CVrqC9IYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072304; c=relaxed/simple;
	bh=tEDZLL6Z+WtXLuD7COZEEmRQP6uUIpGZfxybF0BjGDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAm6auUjTgAQEuEHyYZZ/CPjFGNBJg9j4VHeBkOqFdhtXYaElHuE06nIOt5GkLD1FLANEZswtEcDxbTuiXGnsPtmmHRvLFzv9TeAIp1FYkBy1ZY76Hc17+vhBHvbf39xlyJU/D8Vy5G6UhRD4UPdRugxge+uYZ8AYSx8TzqsksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCMgpPiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BC0C3277B;
	Sat, 22 Jun 2024 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719072303;
	bh=tEDZLL6Z+WtXLuD7COZEEmRQP6uUIpGZfxybF0BjGDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCMgpPiHO/Nu5DlzcwOywf/h557NLhWpDxClU075++rDc6s1ZBek8mOdowcsVsWRY
	 9etPtir7CQoOMeICr2CCVH/64daqYfYpbeGEg0mSwuhaJ3XC7MVwZyCL7xjsONravR
	 ASd/dhZJ282zbtLgSPmBBHsXUU/HOV5kcjzRYa6aFVqVYVS2ZFimO+kvdOY7Q17J9y
	 NlgzWr+Usso76Mua9T0BewYcdDvbO8GDLKPXHmg4SYj7aTWcKyx+UaHGjre62TE1po
	 8HWXYRzgjNhbNl02HN6yGncDQU4f/dQUr5xa7BFMJr8I24tElxSAydMSvqvp/l1EIX
	 44LHFBPXIt4pw==
Date: Sat, 22 Jun 2024 09:05:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] xfs: bug fix for 6.10
Message-ID: <20240622160502.GA3058325@frogsfrogsfrogs>
References: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240622160058.GZ3058325@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622160058.GZ3058325@frogsfrogsfrogs>

On Sat, Jun 22, 2024 at 09:00:58AM -0700, Darrick J. Wong wrote:
> On Sat, Jun 22, 2024 at 07:05:49PM +0530, Chandan Babu R wrote:
> > Hi Linus,
> 
> Drat, I ran the wrong script, please ignore this email, Linus.
> I guess I now have weekend work to go figure out why this happened.

Wait, no this is Chandan's PR to Linus, not the one I just tried to send
to Chandan.  Sigh.

EVERYONE: ignore this email please.

--D

> 
> > Please pull this branch which contains an XFS bug fix for 6.10-rc5. A brief
> > description of the bug fix is provided below.
> 
> Chandan: Would _you_ mind pulling this branch with 6.10 fixes and
> sending them on to Linus?
> 
> --D
> 
> > 
> > I did a test-merge with the main upstream branch as of a few minutes ago and
> > didn't see any conflicts.  Please let me know if you encounter any problems.
> > 
> > The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:
> > 
> >   Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-4
> > 
> > for you to fetch changes up to 348a1983cf4cf5099fc398438a968443af4c9f65:
> > 
> >   xfs: fix unlink vs cluster buffer instantiation race (2024-06-17 11:17:09 +0530)
> > 
> > ----------------------------------------------------------------
> > Bug fixes for 6.10-rc5:
> > 
> >   * Fix assertion failure due to a race between unlink and cluster buffer
> >     instantiation.
> > 
> > Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
> > 
> > ----------------------------------------------------------------
> > Dave Chinner (1):
> >       xfs: fix unlink vs cluster buffer instantiation race
> > 
> >  fs/xfs/xfs_inode.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> > 
> 

