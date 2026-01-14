Return-Path: <linux-fsdevel+bounces-73612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F9D1CA9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B0BD30B58A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58736C0CA;
	Wed, 14 Jan 2026 06:24:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1136A01A;
	Wed, 14 Jan 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371886; cv=none; b=EBm8dZJvM9DG2Uh6Fu0zK4NtMmz4b8wZHja7wHC8ZYQsCEqo0RqDpiiPZwi3xKg5OG5rql0VZgVvpUi7//j+J4OLW6Lb9TD+f2myPutzuRsomVMbWpK4BkjdkoPXfFZxrD4+NS2e6DTvvStAYIqS/UrAoJWRAQVw/e+DPmQ/fsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371886; c=relaxed/simple;
	bh=dbDwZkiE8c6tNRmN3UTuhszmm+CVdjyMON2Q0PftGp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf0P1E93BxTLbKtcZHKQZXKH0c4yjpLK3TUzEq9MRnEFK/SopRsRMK1pjnjqOAtJStcSgFGC+9LknhlJhFtZwS4teA9sqYQLT0uxeZ0eBHGDEwLVeJAVoUzotw+g3vXN7SjBJcyya8VdAN81yyld6RGldB6Y+RS28zjD0kF41NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DEFD227A8E; Wed, 14 Jan 2026 07:24:25 +0100 (CET)
Date: Wed, 14 Jan 2026 07:24:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
Message-ID: <20260114062424.GA10805@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com> <20260114061028.GF15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114061028.GF15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 10:10:28PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 01:31:41AM -0300, André Almeida wrote:
> > To make clear which UUID is being returned, rename get_uuid() to
> > get_disk_uuid(). Expand the function documentation to note that this
> > function can be also used for filesystem that supports cloned devices
> > that might have different UUIDs for userspace tools, while having the
> > same UUID for internal usage.
> 
> I'm not sure what a "disk uuid" is -- XFS can store two of them in the
> ondisk superblock: the admin-modifiable one that blkid reports, and the
> secret one that's stamped in all the metadata and cannot change.

It isn't.  Totally independent of the rest of the discussion, the
get_uuid exportfs operation is not useful for anything but the original
pNFS block layout.  Which is actually pretty broken and should be slowly
phased out.

> IIRC XFS only shares the user-visible UUID, but they're both from the
> disk.   Also I'm not sure what a non-disk filesystem is supposed to
> provide here?

Yeah.


