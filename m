Return-Path: <linux-fsdevel+bounces-38485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE52A03351
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 00:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8842D3A4CD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4111E32C3;
	Mon,  6 Jan 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOzwseFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FC1E0DF5
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206273; cv=none; b=AvYTwt/ymqeNbPGF2XGC5NeMqAHdcv1CgDZxJfKkagUJHSJlGmr617GGGzwAcO2HT+noyIX0xb/OxVbl0Z2r+8hvZ+4pkURMKcsnFmzr8VhJO6nmqC1i0a1tBNUhwBMFcbfVCaq7OLM3OmVOj3kdvEuhz5rSpQZxp009gFWOQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206273; c=relaxed/simple;
	bh=Y+NsO9GQZIWweHnpmWcsHghRmqoyiSWViVJTo6TIxbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7RCvosRzYVqvk4HK2LX7jWC2HCyPRlEc3LX89cXTOdK9/ukiwMHlzS03Mfn0IMtP6mCv3hx4VZ0aNBkQckzE6jjVXiSy6fQ0iCr9QpECI/i94a1g6ZlWiW7LDUYJ/pVDT+WgH7clXz5Xmmt1UyDg/LDvUr26T6JgViaTPJDfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOzwseFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB3FC4CEDD;
	Mon,  6 Jan 2025 23:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736206272;
	bh=Y+NsO9GQZIWweHnpmWcsHghRmqoyiSWViVJTo6TIxbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOzwseFxD4/2OL2Vb09eV4LP9WJQLAAE20PilTccKdpOi3VgSPpDn6qvLj4EGwKET
	 vjKMnxm9hTYuNRy1h264i5M44GxPeSCXwriLoqOVCpf9y8rNxXhufWgBN0bkZb54bz
	 K7nVfA7CEnLHI/MBDM6BHcN8Mgv+HkABDz13/vU/C8j0kLS5CU9pRWegwu+qfdlzoE
	 pQcwAdcraXlhUIiKoBEk0PUm6jvmsDq6gVHHY0ig3GlMM9bquLqrtRbAXqwnoz1CRs
	 sBQQkQpdOfTcoh4ncJ6vX58o5bqEFQxJrH7MSklhNR9Avd+orLMaBinalwA4+7h4P/
	 Nk908nCelm/dQ==
Date: Mon, 6 Jan 2025 15:31:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <20250106233112.GI6156@frogsfrogsfrogs>
References: <20250106162401.21156-1-jack@suse.cz>
 <b4a292ba5a33cc5d265a46824057fe001ed2ced6.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a292ba5a33cc5d265a46824057fe001ed2ced6.camel@kernel.org>

On Mon, Jan 06, 2025 at 02:52:11PM -0500, Jeff Layton wrote:
> On Mon, 2025-01-06 at 17:24 +0100, Jan Kara wrote:
> > Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> > rwlock") the sysv filesystem was doing IO under a rwlock in its
> > get_block() function (yes, a non-sleepable lock hold over a function
> > used to read inode metadata for all reads and writes).  Nobody noticed
> > until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> > Just drop it.
> > 
> > [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  What do people think about this? Or should we perhaps go through a (short)
> >  deprecation period where we warn about removal?
> > 
> 
> FWIW, it was orphaned in 2023:
> 
>     commit a8cd2990b694ed2c0ef0e8fc80686c664b4ebbe5
>     Author: Christoph Hellwig <hch@lst.de>
>     Date:   Thu Feb 16 07:29:22 2023 +0100
> 
>         orphan sysvfs
>     
>         This code has been stale for years and I have no way to test it.
> 
> 
> Given how long this was broken with no one noticing, and since it's not
> being adequately tested, I vote we remove it.

I concur, if someone really wants this we can always add it back (after
making them deal with the bugs):

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 

