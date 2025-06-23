Return-Path: <linux-fsdevel+bounces-52546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B31ABAE3FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34EC27A2BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07523F409;
	Mon, 23 Jun 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTzACbp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDF5579E;
	Mon, 23 Jun 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681550; cv=none; b=hPGQiCoRjYqzq1aO3oBaiAmIhMGE/DyN/p6Bs2doSk8VsXUDebkMvUEJa+fmcbDUF2bt6/pkP0LhHuRk5PyYooWhun1oNkZBD3SFgtjTj1gmdPMU72f2uwR9B8c7tUasPlVfUF1eZiPHCtfTJxwOAyoAwxuOBF22x+gak/6CxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681550; c=relaxed/simple;
	bh=NEpi/7jbMxlgA/Ip3kFmF6fyk2NnVHnyuKnlcrk3VP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMMvKnKEcFrFr7/Af+VK+CVk3yuVmvDammno74XoL7VBkzubBBzadGCPdFAqvNOvvRNKe/nqb8u2xo7uj9SDso9ZZK00UtfLSxc0eFa2p95u5lZhYBldWJaGVr7s2cN04H4tp/09noY5zusJqNsfxeHjjuaTe73b8ZJwSZ0gS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTzACbp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AB2C4CEEA;
	Mon, 23 Jun 2025 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750681549;
	bh=NEpi/7jbMxlgA/Ip3kFmF6fyk2NnVHnyuKnlcrk3VP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTzACbp6s++Eu5qs6WDi+DYNT9yNIgHydyOWqF5GNCL5Z0w/BI/NXxP6fLJc39tmu
	 oo51dVdttN4gXPMX1+CefwGLgqI9IPijqLYm7xJyPK1/Z4O7t4AJI9uz3r9Ns/7emL
	 sm+yry36VOY/lIR5oK4ni42YSDlCjMgP2D4bs4Pa1kCdNi1mf1lGWmI+rTy0FeeOoB
	 z2r79FZ7zhNyeT/vlOS6gNxNgYl6o4zBPKGc6TtB/RcS2Fq226nL/1By6cteZk7WYX
	 xICDdSCoGRCcLzPibNp9wA6OtyBs8EPQuWlKfcc9OtnERxFCTC5PhotehWSvncJT3f
	 BPrhAiB1ntgbw==
Date: Mon, 23 Jun 2025 14:25:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
Message-ID: <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
 <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>

On Mon, Jun 23, 2025 at 02:06:43PM +0200, Jan Kara wrote:
> On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> > Various filesystems such as pidfs (and likely drm in the future) have a
> > use-case to support opening files purely based on the handle without
> > having to require a file descriptor to another object. That's especially
> > the case for filesystems that don't do any lookup whatsoever and there's
> > zero relationship between the objects. Such filesystems are also
> > singletons that stay around for the lifetime of the system meaning that
> > they can be uniquely identified and accessed purely based on the file
> > handle type. Enable that so that userspace doesn't have to allocate an
> > object needlessly especially if they can't do that for whatever reason.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Hmm, maybe we should predefine some invalid fd value userspace should pass
> when it wants to "autopick" fs root? Otherwise defining more special fd
> values like AT_FDCWD would become difficult in the future. Or we could just

Fwiw, I already did that with:

#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */

I think the correct thing to do would have been to say anything below

#define AT_FDCWD		-100    /* Special value for dirfd used to

is reserved for the kernel. But we can probably easily do this and say
anything from -10000 to -40000 is reserved for the kernel.

I would then change:

#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */

since that's very very new and then move
PIDFD_SELF_THREAD/PIDFD_SELF_THREAD_GROUP to include/uapi/linux/fcntl.h

and add that comment about the reserved range in there.

The thing is that we'd need to enforce this on the system call level.

Thoughts?

> define that FILEID_PIDFS file handles *always* ignore the fd value and
> auto-pick the root.

I see the issue I don't think it's a big deal but I'm open to adding:

#define AT_EBADF -10009 /* -10000 - EBADF */

and document that as a stand-in for a handle that can't be resolved.

Thoughts?

