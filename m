Return-Path: <linux-fsdevel+bounces-45901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32FA7E660
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA113BBD89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89420FA91;
	Mon,  7 Apr 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfZyCI4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD420F095;
	Mon,  7 Apr 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042623; cv=none; b=V0+E5gxDXeq0T2WwmAYao62QUIfko+7En7Bfgxko+4IVHfuW86yr8WG3yPbwmGoOOoyh6FS0NB8OuxfaR+vjLtvk+uoKvSJhFGMKvCrRk1f5A2EaR3Uqhi3NMWhPXone9vsfq5euMa2S7ayzW3mhxt7wBFDFdQllraCEKKR4BjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042623; c=relaxed/simple;
	bh=BXrLO5yKzMgDUbVsQGRi9KITArqhYtQx46GfiI37PtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNzTdE/bb/XITyFyUgY5JaoE9fFhXHcGYPsLSoqFYwtEp3H2GZcuLZ+jGft4ruCg8kxQlWpbE4qBqBBtER6JBhC37iZ77tJyfTS+nDFdDCUQCsSpzWIjblPop56MUV4eEk2vEqfzhDW3lQ55hJY8dsTt/mGLop33/S14LmV2vWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfZyCI4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324D1C4CEDD;
	Mon,  7 Apr 2025 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042623;
	bh=BXrLO5yKzMgDUbVsQGRi9KITArqhYtQx46GfiI37PtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfZyCI4lx6nYAXJUkALyBttaMmBOPB9Vmy4RS+PRKpkC6GVeELQzSb238HvmTnnRW
	 u2WXPkRdDF0l/Lh4RnGwJx7JHVHJY2CAyfTT5x/+35rd9glGht3f6mxYJFuubjJQrP
	 Y9g/20zXlHzgRU8dLCzn8w+ozYfz04JNCAsq97wbwk77yeWFBJ50EDjVhAbvKNw4Zq
	 s91N4a4wCWaA2XhbehXGkbF02g9zxZHJtmwyPTFZWO1yECcrgPjMV394zUQOQJD8Mo
	 V9K9vFt0599p1HFvzx0R8CinkK4abnuDLLC1TT/+pN1vnh1ErSf/0Og7D1KXnnF44U
	 Y77W9gGZ92rzQ==
Date: Mon, 7 Apr 2025 09:17:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
Message-ID: <20250407161702.GB6266@frogsfrogsfrogs>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
 <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>

On Fri, Apr 04, 2025 at 10:36:32AM +0100, John Garry wrote:
> On 03/04/2025 19:22, Ritesh Harjani (IBM) wrote:
> 
> IMHO, This document seems to be updated a lot, to the point where I think
> that it has too much detail.

The goal of this document is to capture the designers' mental models of
how the iomap code solves specific problems.  In other words, it's a
human language description of what the author thinks the code should be
doing to solve the problem.  The documentation should be written at one
conceptual level higher than the code itself to help newcomers grok the
iomap APIs without having to reverse-guess our intent from the existing
clients (ext4/xfs/etc).

I don't know if that helps, but "too much" is subjective.

> > Let's document the use of these flags in iomap design doc where other
> > flags are defined too -
> > 
> > - IOMAP_F_BOUNDARY was added by XFS to prevent merging of ioends
> >    across RTG boundaries.
> > - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
> >    for filesystems to inform the iomap that it needs HW-offload based
> >    mechanism for torn-write protection
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> >   Documentation/filesystems/iomap/design.rst | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> > index e29651a42eec..b916e85bc930 100644
> > --- a/Documentation/filesystems/iomap/design.rst
> > +++ b/Documentation/filesystems/iomap/design.rst
> > @@ -243,6 +243,11 @@ The fields are as follows:
> >        regular file data.
> >        This is only useful for FIEMAP.
> > +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
> > +     for this iomap must never be merged with the mapping before it.
> 
> This is just effectively the same comment as in the code - what's the use in
> this?

Specific terms like "IOMAP_F_BOUNDARY" need to be defined before they
can be discussed.  Yes, it's redundant with the more terse description
in the C header.  No, we should not make people cross reference two
separate documents for basic definitions.

If you know how to do the magic sphinx stuff to auto-merge the C
comments into the rst then I'm all ears.

> > +     Currently XFS uses this to prevent merging of ioends across RTG
> > +     (realtime group) boundaries.

I think this sentence should go farther in capturing why the flag is
used --

"Zone XFS uses this flag to prevent an ioend from being combined with a
previously generated ioend because writes cannot span a zone boundary."

and later for the ext2 iomap port:

"ext2 uses this flag as an IO submission boundary when an indirect
mapping block comes immediately after a file data extent to try to
submit IOs in linear order."

Though now that I've written that, I'm not so sure IOMAP_F_BOUNDARY is
the right flag for this -- for zns xfs it's a completion boundary, for
ext2 it's a submission boundary.

> > +
> >      * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> >        be set by the filesystem for its own purposes.
> 
> Is this comment now out of date according to your change in 923936efeb74?

I wish you'd quote subject lines so I could search them in my mailbox.
You might have a mental index of commit ids, but I do not.

923936efeb74b3 ("iomap: Fix conflicting values of iomap flags")

So, yes.

> > @@ -250,6 +255,11 @@ The fields are as follows:
> >        block assigned to it yet and the file system will do that in the bio
> >        submission handler, splitting the I/O as needed.
> > +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
> > +     with the ``REQ_ATOMIC`` flag set in the bio.
> 
> This is effectively the same comment as iomap.h
> 
> > Filesystems need to set
> > +     this flag to inform iomap that the write I/O operation requires
> > +     torn-write protection based on HW-offload mechanism.
> 
> Personally I think that this is obvious.

The purpose of documentation is to help someone who knows their
filesystem well and iomap less well to construct a mental model of how
iomap works so they can make their filesystem use the IO path without
implementing their own.  Yes, it's obvious and redundant to all of us
who have spent time wrangling iomap, but so are the signs that tell you
what street you're on.  They're not for the people who live there,
they're for people who are lost and want to get somewhere.

> If not, the reader should check the
> xfs and ext4 example in the code.

No.  Someone who's unfamiliar with iomap should not have to learn
*another filesystem's codebase* to grok the infrastructure.  That's how
buffer heads are and struct pages were, which is to say a drag on
everyone getting anything done.

--D

> 
> > +
> >      These flags can be set by iomap itself during file operations.
> >      The filesystem should supply an ``->iomap_end`` function if it needs
> >      to observe these flags:
> 
> 

