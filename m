Return-Path: <linux-fsdevel+bounces-39702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E58A1712C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEFE1884EC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9E1EF080;
	Mon, 20 Jan 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAPV259H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76B1EC012;
	Mon, 20 Jan 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393428; cv=none; b=tPAj+zYqkEnWlU7jchyAqIcMEpe5YUJDCwkhgV0aXAQzuiT1E2bJWaH97YGhAQo5oIXI1aQP6tYp/+uMbKlkysZDkEdKmxQXamnkkb+hD97f+RsH/SlyNrepwUaE9wKewQdSU8iw4ihC9IFvLVRUg8KyZSnehy5EC5nboQ5FaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393428; c=relaxed/simple;
	bh=91msOSdphe2y2ZT3cyG9Bzg3ubA969IG4m2JYPG5gCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxdjMLUPWeOZol8lkcWegiNto/i0c1cIqpcjc85pzLEtEdLvnpT5xCfgvVtz7B9Udy2BDCgGDfKElZBR0R986Aebe1aldJdYHN7hawHYg7C+XsuNlAs17wKliZ5D/MMBKfWVIDA42ZOqHS79nnObdjs2vXG6EmDznq7z3WWaCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAPV259H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30157C4CEDD;
	Mon, 20 Jan 2025 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737393427;
	bh=91msOSdphe2y2ZT3cyG9Bzg3ubA969IG4m2JYPG5gCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAPV259HGrR72AzhsCkee8nXAfW7xeziRsijXdS7896cPjuhr5QUA4yjkkUkegYif
	 g6CObNWVqpW9Q9Ht+9aP5WjyT5gigJrFThkhWWpaaasBgoD19v2mrCOK2HexdX0Jn8
	 pU722wDNQJKg7hd0XVWp2/2H4SH8EMQYZQDG+7hjwlIa9+6xh+tZ5TSebGEjR7IFJg
	 O9ndsGefv/JEPoD+xUhnBk6J6iDueQ4i6dpZz9Vzq4soATYglvKiJEenoZ4iFFi1iD
	 sW8NcdUaRqBMDN8Eh+0II9sy6WgvXAVBHuONFXp1GJXZqQ45P7SRQrY0QeG8vLfRSH
	 IKBbLgbbXqQWg==
Date: Mon, 20 Jan 2025 09:17:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, fstests@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Error in generic/397 test script?
Message-ID: <20250120171705.GA1159@sol.localdomain>
References: <1113699.1737376348@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113699.1737376348@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 12:32:28PM +0000, David Howells wrote:
> Hi Eric,
> 
> In the generic/397 test script, you placed:
> 
> 	$XFS_IO_PROG -f $SCRATCH_MNT/edir/newfile |& _filter_scratch
> 	$XFS_IO_PROG -f $SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch
> 
> but neither of those lines actually has a command on it, and when I run it,
> I'm seeing xfs_io hang just waiting endlessly for someone to type commands on
> stdin.
> 
> Would it be better to do:
> 
> 	echo >$SCRATCH_MNT/edir/newfile |& _filter_scratch
> 	echo >$SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch

Those commands try to create new files and are supposed to fail with ENOKEY
because the directory's encryption key is not present, as is explained in the
comment just above them and can also be seen from 397.out.

First, I'm guessing the context here is that you're testing some (not yet
upstream) kernel patches that introduce a bug where creating these files does
not in fact fail?  That bug will need to be fixed before your patches are
merged, of course.

Second, yes it would be a good idea to replace these with something that don't
hang in the case of a kernel bug that allows the creation of these files.  This
could be done using a shell redirection as you've proposed, but it would have to
go in a subshell for the stderr to be filtered by _filter_scratch.  Feel free to
send a patch after you've fixed that and tested it with upstream.

- Eric

