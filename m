Return-Path: <linux-fsdevel+bounces-14802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87187F7DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 07:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4331C21935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A650A97;
	Tue, 19 Mar 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGQmPCVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14D4438A;
	Tue, 19 Mar 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831492; cv=none; b=uuJ7g/Nq/wvra0AbeguJQSmDFPuqRtFmIIdhtJlNfT+iR8ZxQZWciJcdT84R1YO0b4WECc92z8GKfleLRQZ8NQ5TUyRuubN082gau/MHVRAWgI89ULBsnNmsmazXHTQzQMFRaJDZJblRPgiD8mBuaHhs9rcvoNsWY+kE8eoPI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831492; c=relaxed/simple;
	bh=hmsk6AHRpVBb2U+cRbYLU+mLvD6WW/eHrcNrsOEF3RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwZ5zM0d22hWDFJFoRyuwQ0z7NsyIjnMr3cNctBL4FXrR6S3uoptDApuImcM59nxqmClPYZdQIufwikdT7EeXoQb2naWi1E7wXDmtvPSOQyB7esG1cRGi/tQAGvfbyLAL3kSVTYd3SbgQujCOEpLR+/Ua6JhnSxFqgc599VTEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGQmPCVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787DDC433C7;
	Tue, 19 Mar 2024 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710831492;
	bh=hmsk6AHRpVBb2U+cRbYLU+mLvD6WW/eHrcNrsOEF3RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGQmPCVi2Ba2+IfTWlFC9SJV3UDzZREF11kMCEfOVNXjeArN9btlDZ0we1hrnCAXe
	 WOgHiZ5IdH1RU7oVnom/oxDlTRyKUkyC6AeFHaE8z5dbdWybl0JAcoeBfEj+2vqHYP
	 icQSdif6TiNcptenGQnMoEK1JTxrQmqI2Se1QlG154OUTCttKlk17DyNNxCIYZKLpG
	 WGm3HKyNWS9uO2F1dpxNANwwS75QVuIK01Zi+iF2tW0MZdnVKHkX7XrSXQh/ene9bj
	 ZetbujCiEDRS8fGnpwe85KaVik0VgRKK/XLcf+TeMCr6F9f4qXyRWmwGe4AECwKKy9
	 lPsZmR9Mbh+mg==
Date: Tue, 19 Mar 2024 07:58:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20240319-sobald-reagenzglas-d4c5b1c644ad@brauner>
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
 <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
 <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>

On Mon, Mar 18, 2024 at 12:41:49PM -0700, Linus Torvalds wrote:
> On Mon, 18 Mar 2024 at 12:14, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > IOW, isn't the 'get()' always basically paired with the mounting? And
> > the 'put()' would probably be best done iin kill_block_super()?
> 
> .. or alternative handwavy approach:
> 
>  The fundamental _reason_ for the ->get/put seems to be to make the
> 'holder' lifetime be at least as long as the 'struct file' it is
> associated with. No?
> 
> So how about we just make the 'holder' always *be* a 'struct file *'? That
> 
>  (a) gets rid of the typeless 'void *' part
> 
>  (b) is already what it is for normal cases (ie O_EXCL file opens).
> 
> wouldn't it be lovely if we just made the rule be that 'holder' *is*
> the file pointer, and got rid of a lot of typeless WTF code?
> 
> Again, this comment (and the previous email) is more based on "this
> does not feel right to me" than anything else.
> 
> That code just makes my skin itch. I can't say it's _wrong_, but it
> just FeelsWrongToMe(tm).

So, initially I think the holder ops were intended to be generic by
Christoph but I agree that it's probably not needed. I just didn't
massage that code yet. Now on my todo for this cycle!

