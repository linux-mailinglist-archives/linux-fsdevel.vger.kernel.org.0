Return-Path: <linux-fsdevel+bounces-32066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61709A0204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FFF1C2173F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE818C920;
	Wed, 16 Oct 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bp1GeTbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D4FC0C;
	Wed, 16 Oct 2024 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062047; cv=none; b=sksM4Aa7S3R4822bXXm39k6ZN9cpMcrZyR1JEtlAGpYe8eGpxELcM1uAYztXry8btq7szJvCgE04wGYpfVXPIO5Okl8oeugQZFFBUTSFxe0A4Fm5ay1bwOWI8nJh6ucDmA+3h8MYpMz3F8ESTmY2J9WNPgptn+68soIrLwliPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062047; c=relaxed/simple;
	bh=3G4HKc0AElPjZ/Lh8bA17t0DqAVtp8trD3Hap4zH1pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh1HIEeyaOHETBeNsVRp8yavuX3xj0c46HSnVcv+SzSiiRfSYElJIiX84/+QGwujRiG1jzIhWLfeAPewTE/DmiF00aSsROQRWZe71qS+ihptF3GmejVHv3PYhtVcFx5h/95H8mDLaoMxfk5Z4BR4nFWj3Dp+oawu9G0QNXaBx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bp1GeTbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226A3C4CEC5;
	Wed, 16 Oct 2024 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729062046;
	bh=3G4HKc0AElPjZ/Lh8bA17t0DqAVtp8trD3Hap4zH1pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bp1GeTbvtx4fxl/SytSbAd6A71Vi1d3KA9ZFcHUBxciHqQlI8mLlDJ2eMJQ0i7glr
	 QgOVUqEchf2YFv2TXORgRLbQg9B3dfEvRjCuYfDh5QjAbNB74V6H9Gp4D/t5zvi37a
	 5IpHeweHg2qnf4gUiJxwxCruwgCS+IcnolThjPNY=
Date: Wed, 16 Oct 2024 09:00:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] bcachefs: Fix sysfs warning in fstests generic/730,731
Message-ID: <2024101637-approval-repossess-7a3a@gregkh>
References: <20241012184239.3785089-1-kent.overstreet@linux.dev>
 <20241014061019.GA20775@lst.de>
 <2024101421-panning-challenge-c159@gregkh>
 <xboxb6r7ggimmzvwpfxqbzt3gsocwujbzkolostwhe777yo4mt@5uo65x6hh6qb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xboxb6r7ggimmzvwpfxqbzt3gsocwujbzkolostwhe777yo4mt@5uo65x6hh6qb>

[meta comment, Kent, I'm not getting your emails sent to me at all, they
aren't even showing up in the gmail spam box, so something is really off
on your server such that google is just rejecting them all?]

On Mon, Oct 14, 2024 at 02:51:23AM -0400, Kent Overstreet wrote:
> On Mon, Oct 14, 2024 at 08:34:06AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 14, 2024 at 08:10:19AM +0200, Christoph Hellwig wrote:
> > > On Sat, Oct 12, 2024 at 02:42:39PM -0400, Kent Overstreet wrote:
> > > > sysfs warns if we're removing a symlink from a directory that's no
> > > > longer in sysfs; this is triggered by fstests generic/730, which
> > > > simulates hot removal of a block device.
> > > > 
> > > > This patch is however not a correct fix, since checking
> > > > kobj->state_in_sysfs on a kobj owned by another subsystem is racy.
> > > > 
> > > > A better fix would be to add the appropriate check to
> > > > sysfs_remove_link() - and sysfs_create_link() as well.
> > > 
> > > The proper fix is to not link to random other subsystems with
> > > object lifetimes you can't know.  I'm not sure why you think adding
> > > this link was ever allowed.
> > > 
> > 
> > Odd, I never got the original patch that was sent here in the first
> > place...
> > 
> > Anyway, Christoph is right, this patch isn't ok.  You can't link outside
> > of the subdirectory in which you control in sysfs without a whole lot of
> > special cases and control.  The use of sysfs for filesystems is almost
> > always broken and tricky and full of race conditions (see many past
> > threads about this.)  Ideally we would fix this up by offering common
> > code for filesystems to use for sysfs (like we do for the driver
> > subsystems), but no one has gotten around to it for various reasons.
> 
> There was already past precedent with the block/holder.c code, and
> userspace does depend on that for determining the topology of virtual
> block devices.

What tools use that?  What sysfs links are being created for it?

And yes, filesystems do poke around in sysfs, but they almost always do
so in a racy way, see this old link for examples of common problems:
	https://lore.kernel.org/all/20230406120716.80980-1-frank.li@vivo.com/#r

> And that really is what sysfs is for, determining the actual topology
> and relationships between various devices - so if there's a relationship
> between devices we need to be able to expose that.

I totally agree, that is what sysfs is for, but at the filesystem layer
you all are having to deal with "raw" kobjects and doing that gets
tricky and is easy to get wrong.

> Re: the safety issues, I don't agree - provided you have a stable
> reference to the underlying kobject, which we do, since we have the
> block device open. The race is only w.r.t. kobj->state_in_sysfs, and
> that could be handled easily within the sysfs/kobject code.

Handled how?

> > The only filesystem that I can see that attempts to do much like what
> > bcachefs does in sysfs is btrfs, but btrfs only seems to have one
> > symlink, while you have multiple ones pointing to the same block device.
> 
> Not sure where you're seeing that? It's just a single backreference from
> the block device to the filesystem object.

I see multiple symlinks being created in the code, I don't know what it
looks like on a running system, sorry.

> > I can't find any sysfs documentation in Documentation/ABI/ so I don't
> > really understand what it's attempting to do (and why isn't the tools
> > that check this screaming about that lack of documentation, that's
> > odd...)  Any hints as to what you are wishing to show here?
> 
> Basically, it's the cleanest way (by far) for userspace to look up the
> filesystem from the block device: given a path to a block device, stat
> it to get the major:minor, then try to open
> /sys/dev/block/major:minor/bcachefs/.

Can you document this properly in Documentation/ABI/ which is where all
sysfs files and symlinks are supposed to be documented?  We have a tool
that you can run at runtime to show all missing documentation entries,
scripts/get_abi.pl

> The alternative would be scanning through /proc/mounts, which is really
> nasty - the format isn't particularly cleanly specified, it's racy, and
> with containers systems are getting into the thousands of mounts these
> days.

How does all other filesystems do this?  Surely we are not relying on
each filesystem to create these symlinks, that's just not going to
work...

thanks,

greg k-h

