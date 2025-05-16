Return-Path: <linux-fsdevel+bounces-49290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3FABA297
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC835020B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949227A136;
	Fri, 16 May 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tak05Tzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E242750FC;
	Fri, 16 May 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419212; cv=none; b=JMXhBQaYdGQCFVAfa5y4UM2byQrvFikMiXDL2BeC8GMrdGyZgwRRDhtxXISl6UfDFyxBggXR64FsQVTvuqHuMWqStAX2PYd/J5yGW0FbqabzfevPBTFMmHOaaaiA44p6mcONN6G1zPlD6yoY8mwnMY4PlJX3eoLm3MhupA7ZdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419212; c=relaxed/simple;
	bh=FDzfr2SXPIZlkMJTDoiEPwnOAxtoNKZNxwxZRI5QyEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjwO3bSDaeHo3r+7IIQHa5fz3dMSV9M+VcfRgz2pkNkSBM3nigG8IUznbDpgIXzdxvTRgbZhiJRqOwsaN7QtNg9W6CKmJPwCHNT0Qotrm6GjoDGLfGbr1ErSaXeqeigkWTSlgnSXmD3c9vPUENb45ltJp8m82KBJenjkDGfaT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tak05Tzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026F0C4CEE4;
	Fri, 16 May 2025 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747419212;
	bh=FDzfr2SXPIZlkMJTDoiEPwnOAxtoNKZNxwxZRI5QyEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tak05Tzbg6DkyLWHedmDxiRSJ8LVaAAYtBDAZsWcorDeULXeFIX0hhepzJnGU2SpN
	 XxkAn+0IxSSyR8mB1QBDIiwAuUtWCoh+VC7ENU5+aCe9PSYImQ1KoZH75TKaeiev8e
	 oaaMqeYOJvXYbbgH+Wi2b55idrdkxl5aNZhFv1WPAOfcLRmarGidVnJuZGflkbqPVt
	 f+jYjFdKs9P48K/f6rJHtjPlmuOFXGU9tG+FFvtwh4KjHpuQ15F3ljatBhjJzWmvux
	 hRbv2LWaMoXrekVBaq1yeLu+OPXR3i+cg/hMEu7rIbIrYEwOxyRQWJWHtsuvaEU98h
	 rBtOxsgo+zsIQ==
Date: Fri, 16 May 2025 20:13:26 +0200
From: Carlos Maiolino <cem@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
Message-ID: <h6wsijwvwjwynsb3ecmg3aanih5lijpyq22acbqcheszltixiw@3iz4nwhao4cd>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
 <20250516121938.GA7158@mit.edu>
 <6zGxoHeq5U6Wkycb78Lf1YqD2UZ_6HbHKjIylyTu1s2iRplyxIkQL9FOimJbx_qlfo2fer1wwGQ-5r8i9M91ng==@protonmail.internalid>
 <920cd126-7cee-4fe5-a4ab-b2c826eb8b8c@oracle.com>
 <cuyujo64iykwa2axim2jj5fisqnc4xhphasxm5n6nsim5qxvkg@rvtkxg6fj6ni>
 <20250516144817.GB21503@mit.edu>
 <DYrUzQxaooJtkUF4rTnYMQSaY0MqNgKMFGweP_aj6jWh7P6ZGScT25sAvZz_8Z5Hc26zgJoTC0g1DuxYY-FS7w==@protonmail.internalid>
 <20250516151005.GS25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516151005.GS25655@frogsfrogsfrogs>

On Fri, May 16, 2025 at 08:10:05AM -0700, Darrick J. Wong wrote:
> On Fri, May 16, 2025 at 10:48:17AM -0400, Theodore Ts'o wrote:
> > On Fri, May 16, 2025 at 03:31:17PM +0200, Carlos Maiolino wrote:
> > >
> > > This is likely the final state for XFS merge-window and I hope to
> > > send it to Linus as soon as the merge window opens.
> >
> > Very cool!
> >
> > I've taken a quick peek, and it looks like the only XFS-specific
> > atomic writes is an XFS mount option.  Am I missing anything?
> >
> > I want to keep merging the ext4 and xfs atomic write patchsets simple,
> > so I'd prefer not to have any git-level dependencies on the branches.
> > If we're confident that the xfs changes are going to land at the next
> > merge window,
> 
> /I/ for one hope that the xfs changes land this time around.

Yes, so far everything looks good, and we've atomic writes on for-next for a
while as I mentioned too (although a rebase yesterday required to have those
patches re-introduced with different hashes, the content is still the same).

Ted, I'm not exactly sure what kind of git-level dependency you have in mind,
but just to play safe here, bear in mind the atomic writes in merged on top of
Axboe's block-6.15.

> 
> > given that the ext4 patch set is pretty much ready to
> > land in the ext4 tree, how about updating the documentation in a
> > follow-up patch.
> >
> > I can either append the commit which generalizes the documentation to
> > the ext4 tree, or if it turns out that there is a v6 needed of the
> > ext4 atomic write patchset, we can fold the documentation update into
> > the "ext4: add atomic block write documentation" commit and rename it
> > to "Documentation: add atomic write block documentation."
> >
> > Does that seem reasonable?
> 
> I think it's ok to combine them after the merge.  It would be useful to
> have a single programmer's guide that takes a person through the whole
> process of determining the block device's atomic write capabilities,
> formatting either an XFS or ext4 filesystem appropriately, and then
> presents a toy program to discover the atomic write limits on an open
> file and uses that to queue a single IO.

This sounds indeed good to me too.

Have a nice weekend all.

Carlos

> 
> --D
> 
> >
> > Cheers,
> >
> > 					- Ted
> >
> 

