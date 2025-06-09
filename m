Return-Path: <linux-fsdevel+bounces-51044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EFCAD22F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB8916A232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D25211A00;
	Mon,  9 Jun 2025 15:50:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5513D544
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484230; cv=none; b=WUf2293e+OHC1to+xHOGat/G+InWQIzkHEM9c6Ax462awPJnMwtAsM8YJ2ALyfy0Yd5P3kcqbN5MypSEUhiPbX3YErU7Fr8gxTlgE9tnwv9C58p3QgiXnJsalqIv8So/5KkM695ERBAdoTV0OKlVU2El5wDUVxzJ0SzuEwk4teY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484230; c=relaxed/simple;
	bh=q/HVzu3xh0tbj8uX5nOUVhLwwndUJp7L13jHtc8Bo1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMX0Ag+f6zS1Fl6TkbpEX6s/vBf9ssjrHPbPHks8GKZEm2lexdBML/cZBfNkRTL/IUGfAK3vKH08qdhI0R9U+p8a7RWr0tm6hmJwpbkCC0/PEzjYhWxYldNgh+Ek4hpGVoipsafu7HBgLFwpBGqY52Bkhmdzs/4oVeAGVoWWPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-37-19-198-84.datapacket.com [37.19.198.84] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 559FoC45027413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Jun 2025 11:50:15 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 70EB2346600; Mon, 09 Jun 2025 11:50:10 -0400 (EDT)
Date: Mon, 9 Jun 2025 14:50:10 -0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
Message-ID: <20250609155010.GE784455@mit.edu>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <20250607223951.GB784455@mit.edu>
 <643072ba-3ee6-4e5b-832a-aac88a06e51d@oracle.com>
 <20250608205244.GD784455@mit.edu>
 <a44ebcd9-436b-436f-a6f5-dea8958aaf2f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ebcd9-436b-436f-a6f5-dea8958aaf2f@oracle.com>

On Sun, Jun 08, 2025 at 05:52:36PM -0400, Chuck Lever wrote:
> NFSD currently asserts that all exported file systems are case-sensitive
> and case-preserving (either via NFSv3 or NFSv4). There is very likely
> some additional work necessary.

If the underlying file system on the server side does do case
insensitive lookups, how badly would it confuse the NFS client if a
lookup of "MaDNeSS" and "maddness" both worked and returned the same
file, even though readdir(2) only showed the existence of "MaDNeSS"
--- despite the fact that the nfsd asserted that file system was
case-sensitive?

> Ted, do you happen to know if there are any fstests that exercise case-
> insensitive lookups? I would not regard that simple test as "job done!
> put pencil down!" :-)

There are.   See:

common/casefold
tests/f2fs/012
tests/generic/453
tests/generic/454
tests/generic/556

You'll need to make some adjustments in common/casefold for NFS,
though.  The tests also assume that case insensivity can be adjusted
on a per-directory basis, using chattr +F and chattr -F, and that
probably isn't going to port over to NFS, so you might need to adjust
the tests as well.

Note that some of these tests also are checking Unicode case-folding
rules, which is a bit different from the ASCII case-folding which FAT
implemented.  It also might be interesting/amsuing to see what happens
if you ran these tests where the NFS server was exporting, say, a
case-folded file system from a MacOS server, or a Windows NFS server,
and the client was running Linux NFS.  Or what might happen if you
tried to do the same thing using, say, CIFS.   :-)

Cheers,

       	       	    	 	     	- Ted

