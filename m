Return-Path: <linux-fsdevel+bounces-59177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22248B357BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED92F16A218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF92FCC1F;
	Tue, 26 Aug 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptYc2VPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D827A919
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198576; cv=none; b=YXkRyAbonrDJrepd1fmPn+ZjtEUTc2E93QhvCHfeg1jWkhZsptqwmsc9fK7Gw/moKB0X8Wm4i7QBpujoXVMaCLnecgIcQ4zI7YIYMcdqS1AF+BotzPdzGR12EMoeE0ExusafrXoBNoBgpeuSUozK5u8ysq8ue1NwASmrQHSxCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198576; c=relaxed/simple;
	bh=vLeRLPB4MTp8eW9tLgAtVfVYbrwht27648XnW9iF7UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFRIFekPfiloKVBC1JIybWOtS+tlCzCfF95JeuJzca1QuaTlV8jMQ5+PhOJXu/xni0nmZcxHsLUVmSWl7tZPlzDLr2UCquttGMcsTiB9tuJJgzF4k6u14RR+mIoQxl/fguvEiPdh3ZZBSEbdkoSdK+E0BB7d44J2iYFCF6k49kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptYc2VPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A9EC4CEF1;
	Tue, 26 Aug 2025 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756198575;
	bh=vLeRLPB4MTp8eW9tLgAtVfVYbrwht27648XnW9iF7UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptYc2VPySoCgNuXxSK78AP5wbrg1f1BB+fCTUiPE8km+7McSSknuOw0JzUHh1eGum
	 JY5cLXHWg32z5sWAZ/AGoX53VZKK/q7eVH3QgGXlxuMZjIyjWe8NbsuLCJL6b9+G2k
	 0ZezCHPd8ia6DHB+Q7XaoGsDc+yjPZDPTYDFo4Hybd/nr5r0I6MGrqF5Gp/eeQRyVY
	 yg+AwMRVF6jLRgoCC8mbPt4CAETK0ODm/UvC7P11TeTRxW+X/n/0ihZH9bh4cqQFj3
	 5E19wN+1lFcS8x8AK0HXUSz9zwktMomGsX7njMGtvgL9aveNXQDs9A2Qtk+nL+/UWy
	 PxE0u2LBf8cfw==
Date: Tue, 26 Aug 2025 10:56:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825174312.GQ39973@ZenIV>

On Mon, Aug 25, 2025 at 06:43:12PM +0100, Al Viro wrote:
> On Mon, Aug 25, 2025 at 05:11:14PM +0100, Al Viro wrote:
> > On Mon, Aug 25, 2025 at 02:43:43PM +0200, Christian Brauner wrote:
> > > On Mon, Aug 25, 2025 at 05:40:46AM +0100, Al Viro wrote:
> > > > 	Most of this pile is basically an attempt to see how well do
> > > > cleanup.h-style mechanisms apply in mount handling.  That stuff lives in
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> > > > Rebased to -rc3 (used to be a bit past -rc2, branched at mount fixes merge)
> > > > Individual patches in followups.
> > > > 
> > > > 	Please, help with review and testing.  It seems to survive the
> > > > local beating and code generation seems to be OK, but more testing
> > > > would be a good thing and I would really like to see comments on that
> > > > stuff.
> > > 
> > > Btw, I just realized that basically none of your commits have any lore
> > > links in them. That kinda sucks because I very very often just look at a
> > > commit and then use the link to jump to the mailing list discussion for
> > > more context about a change and how it came about.
> > > 
> > > So pretty please can you start adding lore links to your commits when
> > > applying if it's not fucking up your workflow too much?
> > 
> > Links to what, at the first posting?  Confused...
> 
> I mean, this _is_ what I hope would be a discussion of that stuff -
> that's what request for comments stands for, after all.  How is that
> supposed to work?  Going back through the queue and slapping lore links
> at the same time as the reviewed-by etc. are applied?  I honestly have
> no idea what practice do you have in mind - ~95% of the time I'm sitting
> in nvi - it serves as IDE for me; mutt takes a large part of the rest.
> Browser is something that gets used occasionally when I have to...

You misunderstand.
Once you apply your series to the tree that you intend to merge simply
add the lore links to the patches of the last version. I don't give a
single damn whether someone _sends_ patches with lore links. That is not
what this is about. I care that I can git log at mainline and figure out
where that patch was discussed, pull down the discussion via b4 or other
tooling, without having to search lore.

IOW, what I asked you about is once the patches end up in mainline they
please have links to the discussion where they came from. I do it for
all patches no matter if I pick them up from someone else or if I'm
applying my own:

commit c237aa9884f238e1480897463ca034877ca7530b
Author:     Christian Brauner <brauner@kernel.org>

    kernfs: don't fail listing extended attributes

<snip>

    Link: https://lore.kernel.org/20250819-ahndung-abgaben-524a535f8101@brauner

^^^^^^^^^^^^^^^^^
    Signed-off-by: Christian Brauner <brauner@kernel.org>

I'm not doing that for my own personal wellness cure but for every other
poor bastard (granted, including me because one year later it's all
swapped out) who looks at commits in the git tree and wants to either
jump to a link in the browser or wants to use tooling to just pull the
whole discussion from the list.

