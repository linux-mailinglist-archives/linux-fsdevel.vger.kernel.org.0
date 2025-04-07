Return-Path: <linux-fsdevel+bounces-45904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7BDA7E731
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702433B5FAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1D20FA8F;
	Mon,  7 Apr 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hygnjSkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A392120E024;
	Mon,  7 Apr 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044202; cv=none; b=M/QsMgqZYhSO6nEYedh8YRAghPQip/OOhanB+upwEsttKHqaVhxOvm4Aq5r23d5RPwn1Xus8wZtTfyVIhp8GF7GOOXe/2cD2N9iDghXzWVcejQciMgzTYFEZ3FCdmbxNr2B438G8SxxdGqG6q0UEStpcgnBwzazb/Szk2bEs54I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044202; c=relaxed/simple;
	bh=j0/uZG8pR8l8gEcjOhin3TS18avmWQvepa/nVBrdipI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfX1ZW+YjxBljFbJ3b6PCRMnBxR8jsfTnPMn1JtMVKYtEeDEPA1R6kv01JOf4BE168uuFNcQKhnhyXEwB4KZgAfBJLkQlaVw1osj+hi/YrVQ7yU5nQANSbPLnjtTHK7deqIU+RXnZHyseTESgYyFMVnLkIL2cp9lNj4Jr0vHtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hygnjSkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743AFC4CEDD;
	Mon,  7 Apr 2025 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044202;
	bh=j0/uZG8pR8l8gEcjOhin3TS18avmWQvepa/nVBrdipI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hygnjSkhX1mwIwLYAUkDmG+87Kmz0zcdmJdcqzXtLFV4ZBxnvZ1Uo4zht0vJjf269
	 kyKu3VeWv58qx+NFrX5vZpJFfylmk3/kfFuBz4pT1uM+/+7urkE39lplcd79eUvF7h
	 uZj2jscF5dkj1jj3e6LUnqmH1m4i6fUKTdqKKM01+MKbRAWmFEcI8qUrutMTLNuDXi
	 9Q/8LNf0o3Dna0iAed/2WsfsuLqNh/hA4RzRMS5WrO8KPjCw51MiaTF5oNfsw3q8Rr
	 R8OngS7ywZjV1ibFo+lHevZXUOR00sHvQ9sBmZGdC3WmLFWXr73R3S0mlh6942H5RT
	 mRyZ/ElnEc3xg==
Date: Mon, 7 Apr 2025 09:43:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
Message-ID: <20250407164321.GE6266@frogsfrogsfrogs>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
 <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
 <Z_ORuFqb-KErLgEG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ORuFqb-KErLgEG@infradead.org>

On Mon, Apr 07, 2025 at 01:50:00AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 04, 2025 at 10:36:32AM +0100, John Garry wrote:
> > > @@ -243,6 +243,11 @@ The fields are as follows:
> > >        regular file data.
> > >        This is only useful for FIEMAP.
> > > +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
> > > +     for this iomap must never be merged with the mapping before it.
> > 
> > This is just effectively the same comment as in the code - what's the use in
> > this?
> 
> Darrick asked for this file to have full comments.  I'm more on your
> side here as a lot of this seem redundant.

Yes, some of it duplicates iomap.h's more terse comments.  I'm willing
to be flexible about some of this, so long as the documentation helps
the /next/ person to understand iomap and how to use it.

> > > +     Currently XFS uses this to prevent merging of ioends across RTG
> > > +     (realtime group) boundaries.
> > > +
> > >      * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> > >        be set by the filesystem for its own purposes.
> > 
> > Is this comment now out of date according to your change in 923936efeb74?
> 
> Also we probably should not detail file system behavior here, but a
> high level description of what it is useful.

Agreed (now).

--D

