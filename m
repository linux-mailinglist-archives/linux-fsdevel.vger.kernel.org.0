Return-Path: <linux-fsdevel+bounces-30198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363C98787A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55341C20C81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83D15B96C;
	Thu, 26 Sep 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FquEoQcK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33C1494AC;
	Thu, 26 Sep 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372455; cv=none; b=q+27NoAzB9L5BVfNIt4lQjO261pTxnY5vKHWXMLs4glc7SkOTG7i585wGGSW9uQ8ZEV3u3mrysWn8btBLWZWOyfl1/tSku0fxJ7R8bJWHV6GEjta8OWI1Y1u1H0ZftbnY/bumtQamJXNAWUJBssCv9d8Qqc9YIGjkJ1S3nU48ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372455; c=relaxed/simple;
	bh=9ur6iHYWetiD1WwXGvoUlLSBJ2gxFjncZHfy2k4W2aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV2tFJSlQSL0BBzvqehr943q0ptGn9peiOTWmMNwbpKggwDWk3il4VSUkw+juSuu6+yfF8q2Rx/inCjKl9ZtfwGwOo9grtfU1mWrvGmzzoktvQEuN88x8UVtqwNMwMww7BIEP5h9vmit6aUoBVxk81qI+voksNYpSUL1QiN8aaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FquEoQcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6A0C4CEC5;
	Thu, 26 Sep 2024 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727372455;
	bh=9ur6iHYWetiD1WwXGvoUlLSBJ2gxFjncZHfy2k4W2aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FquEoQcKPCcXmaNQsul83gic1fwsA+y+T9EUGVFAbGdMOZDLiGkBGN6Va5h4xMKmO
	 aG5zAZgPnTDN7BLEmxtmWvw4NSRQZRHlPsM0Nbr5HFbW3/iWYZLg331WFkPPSnLasS
	 4JXWCyueaTMeVTIMdITz4QsZQkPOMMna145LpYQMGJskVEJN6yBd8f7I3ipVGXNNPz
	 MIQFc606ilLYi2lVTFGTL4jyUTz0HB+brnFrJQ0306SIPqhNEHWaNf+RvcpOWpnJ+F
	 Qgt1T63zAlcs0Xc+S3q1kOj+AeFykUMS5RioeiCfoNYqJHoBsgoVIp22OYEG668jNS
	 OBHJBvyTUGipA==
Date: Thu, 26 Sep 2024 20:40:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Message-ID: <20240926174043.GA2166429@unreal>
References: <20240913-vfs-netfs-39ef6f974061@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913-vfs-netfs-39ef6f974061@brauner>

On Fri, Sep 13, 2024 at 06:56:36PM +0200, Christian Brauner wrote:
> Hey Linus,
>=20
> /* Summary */
>=20
> This contains the work to improve read/write performance for the new
> netfs library.
>=20
> The main performance enhancing changes are:
>=20
>     - Define a structure, struct folio_queue, and a new iterator type,
>       ITER_FOLIOQ, to hold a buffer as a replacement for ITER_XARRAY. See
>       that patch for questions about naming and form.
>=20
>       ITER_FOLIOQ is provided as a replacement for ITER_XARRAY. The
>       problem with an xarray is that accessing it requires the use of a
>       lock (typically the RCU read lock) - and this means that we can't
>       supply iterate_and_advance() with a step function that might sleep
>       (crypto for example) without having to drop the lock between
>       pages. ITER_FOLIOQ is the iterator for a chain of folio_queue
>       structs, where each folio_queue holds a small list of folios. A
>       folio_queue struct is a simpler structure than xarray and is not
>       subject to concurrent manipulation by the VM. folio_queue is used
>       rather than a bvec[] as it can form lists of indefinite size,
>       adding to one end and removing from the other on the fly.

<...>

> David Howells (24):
>       cachefiles: Fix non-taking of sb_writers around set/removexattr
>       netfs: Adjust labels in /proc/fs/netfs/stats
>       netfs: Record contention stats for writeback lock
>       netfs: Reduce number of conditional branches in netfs_perform_write=
()
>       netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
>       netfs: Move max_len/max_nr_segs from netfs_io_subrequest to netfs_i=
o_stream
>       netfs: Reserve netfs_sreq_source 0 as unset/unknown
>       netfs: Remove NETFS_COPY_TO_CACHE
>       netfs: Set the request work function upon allocation
>       netfs: Use bh-disabling spinlocks for rreq->lock
>       mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence =
of folios
>       iov_iter: Provide copy_folio_from_iter()
>       cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SG=
Es
>       netfs: Use new folio_queue data type and iterator instead of xarray=
 iter
>       netfs: Provide an iterator-reset function
>       netfs: Simplify the writeback code
>       afs: Make read subreqs async
>       netfs: Speed up buffered reading
>       netfs: Remove fs/netfs/io.c
>       cachefiles, netfs: Fix write to partial block at EOF
>       netfs: Cancel dirty folios that have no storage destination
>       cifs: Use iterate_and_advance*() routines directly for hashing
>       cifs: Switch crypto buffer to use a folio_queue rather than an xarr=
ay
>       cifs: Don't support ITER_XARRAY

Christian, David,

Do you have fixes for the following issues reported for series?
https://lore.kernel.org/all/20240923183432.1876750-1-chantr4@gmail.com/
https://lore.kernel.org/all/4b5621958a758da830c1cf09c6f6893aed371f9d.camel@=
gmail.com/
https://lore.kernel.org/all/20240924094809.GA1182241@unreal/

In my case, I don't have any other workaround but simply revert these commi=
ts:
 "netfs: Use new folio_queue data type and iterator instead of xarray iter"
 "netfs: Provide an iterator-reset function"
 "netfs: Simplify the writeback code"
 "afs: Make read subreqs async"
 "netfs: Speed up buffered reading"
 "netfs: Remove fs/netfs/io.c"
 "cachefiles, netfs: Fix write to partial block at EOF"
 "netfs: Cancel dirty folios that have no storage destination"
 "cifs: Use iterate_and_advance*() routines directly for hashing"
 "cifs: Switch crypto buffer to use a folio_queue rather than an xarray"
 "cifs: Don't support ITER_XARRAY"
 "cifs: Fix signature miscalculation"
 "cifs: Fix cifs readv callback merge resolution issue"
 "cifs: Remove redundant setting of NETFS_SREQ_HIT_EOF"

Thanks

