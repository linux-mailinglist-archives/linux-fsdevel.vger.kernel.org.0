Return-Path: <linux-fsdevel+bounces-49264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F41AB9D66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B265066D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D524CE08;
	Fri, 16 May 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6HHrehK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01827200A3;
	Fri, 16 May 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402284; cv=none; b=PHJ38oOU24WOCPoLmAWqyzJt6/sj2NLOaYX0U+aabKF9yom4dVO52/VSdQYVS+QstqZ5bzxWmlArlliCffiS7ataALeJvELNme7m8ZcfF/6l7frDOPZd0V3cQivG5ySXdZ4QXqPLY6dmID6bb+s1oOLZN62n03Vx54yGnWCBLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402284; c=relaxed/simple;
	bh=FGd8bepUBzfLX1wAoFs6yA0luJDxIop9FqXGXLTNWxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF0lCnvjLc0hKu4XXFBUrs/ScMCZxcCfllWDIkxbGi+x7ZoL5W24SwjXJlKNp6mtlZbR/l7Te6fZIjzNVFxrpD7vRnC358q3kE/o8BSVEyLY4gCLJcUiYg1Acrzl8Qs+f+A3gw1sIbxVUtYa1KkkxDB8Fg9EqGDgEe35yfHVqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6HHrehK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E81C4CEE4;
	Fri, 16 May 2025 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747402283;
	bh=FGd8bepUBzfLX1wAoFs6yA0luJDxIop9FqXGXLTNWxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6HHrehKxIOOmx6NxQXbumygquHzEhuQlQSPI4OxP3ppg55TMT46+gn7Pmzfszqkb
	 iP9UGQc+FWJNvY09+HN3Fcs93pBEJIF7jTMj8Rg1YZCMDY4CK7cjYmMskh1nQt/aIR
	 Y47+PyBrH0823wq620QB1PAVdAFxuoBMfzj0/ndts4tjnYQtDRDaymFgfuEVP3haDO
	 E04qb0griVKp45aSQ+0h+2fyuCrgumNUkEFJsKm1+rC9OjQWew+rIt/4+n8Nb8PBVa
	 wHfmCsK3hpr0yVHidWkr4UWgJE42x/y42j3Yj5axnfPGbGr4GgxGhsAK9Ff91oOJ1J
	 PAPWBwaDMWnIw==
Date: Fri, 16 May 2025 15:31:17 +0200
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
Message-ID: <cuyujo64iykwa2axim2jj5fisqnc4xhphasxm5n6nsim5qxvkg@rvtkxg6fj6ni>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
 <20250516121938.GA7158@mit.edu>
 <6zGxoHeq5U6Wkycb78Lf1YqD2UZ_6HbHKjIylyTu1s2iRplyxIkQL9FOimJbx_qlfo2fer1wwGQ-5r8i9M91ng==@protonmail.internalid>
 <920cd126-7cee-4fe5-a4ab-b2c826eb8b8c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920cd126-7cee-4fe5-a4ab-b2c826eb8b8c@oracle.com>

On Fri, May 16, 2025 at 02:05:05PM +0100, John Garry wrote:
> On 16/05/2025 13:19, Theodore Ts'o wrote:
> 
> + Carlos
> 
> > On Fri, May 16, 2025 at 09:55:09AM +0100, John Garry wrote:
> >> Or move this file to a common location, and have separate sections for ext4
> >> and xfs? This would save having scattered files for instructions.
> > What is the current outook for the xfs changes landing in the next
> > merge window?
> 
> The changes have been queued, please see:
> 
> https://lore.kernel.org/linux-xfs/174665351406.2683464.14829425904827876762.stg-ugh@frogsfrogsfrogs/

Hi Ted,

XFS changes are here:

https://web.git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=xfs-6.16-merge

> 
> > I haven't been tracking the latest rounds of reviews
> > for the xfs atomic writes patchset.
> >
> > If the xfs atomic writes patchset aren't going to land this window,
> > then we can land them as ext4 specific documentation, and when the xfs
> > patches land, we can reorganize the documentation at that point.  Does
> > that make sense?
> 

They have been also in xfs/for-next for a while now.

This is likely the final state for XFS merge-window and I hope to send it to
Linus as soon as the merge window opens.

Hope this helps.

> So I figure that we can organise the documentation now to cover both
> ext4 and xfs.
> 
> Thanks,
> John
 

