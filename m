Return-Path: <linux-fsdevel+bounces-73703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC1D1EFDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E0D1300B375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53139A802;
	Wed, 14 Jan 2026 13:11:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67D395258;
	Wed, 14 Jan 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396300; cv=none; b=ew5nyOY0FtrIFSn9PQtfSbYSe6KqYfHhlL/0KIFeI5FWn9AJf+WA5Fmct9bmU8PncvK0mAsUhoIiBp/aBzkkJ0ODk5AL8GQyD+fH9+a35uIfNRJnvGQDbNqs8kQryo8UrWl2BZx0ylO8Flr0Z5DGfjNWipVtAjWJEZIUKKrGcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396300; c=relaxed/simple;
	bh=nGwwqYJxl+g/pUXafEirWSZUjEO28AN4wMRhrLA7NMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJjBl9KR9Gt44qLRwFxsFgQq27dD4VknCGmEd7Qw18YlvJa2jkev/qrVJkqbjSqqsJ3+hI3rOF2689DZZSsVJK0t8FChinWP8rEsAkfDR9MWdf5vi5h9ncGA5RJCvlRlajvvzWOclBCKEuAQPE8lGGnbN+8XYe14yjiq6S4piYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD70F227AAA; Wed, 14 Jan 2026 14:11:31 +0100 (CET)
Date: Wed, 14 Jan 2026 14:11:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
Message-ID: <20260114131130.GA6967@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com> <20260114061028.GF15551@frogsfrogsfrogs> <20260114062424.GA10805@lst.de> <CAOQ4uxjUKnD3-PHW5fOiTCeFVEvLkbVuviLAQc7tsKrN36Rm+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjUKnD3-PHW5fOiTCeFVEvLkbVuviLAQc7tsKrN36Rm+A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 11:12:17AM +0100, Amir Goldstein wrote:
> In the context of overlayfs index and "origin" xattr, this is exactly what is
> needed - to validate that the object's copy up source is reliable for
> the generation of a unique overlayfs object id.

And that's what is in sb->s_uuid.  And it better be persistent.

> TBH, I am not sure if the file handle domain is invariant to XFS admin
> change of uuid. How likely it is to get an identical file handles for two
> different objects, with XFS fs which have diverged by an LVM clone?
> I think it's quite likely.

Of course it is, unlike you explicitly change it using xfs_admin.  Note
that to even mount two clones/snapshots you need to mount with nouuid,
so it doesn't happen accidentally.

> Whether or not we should repurpose the existing get_uuid() I don't
> know - that depends whether pNFS expects the same UUID from an
> "xfs clone" as overlayfs would.

That method does not just return an uuid, but in fact a uniqueue
identifier of the file systems choice and the offset/len where to
look for it on disk, as that is how pnfs/block finds the matching
device.  It is a dangerous concept and should not spread further.


