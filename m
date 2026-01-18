Return-Path: <linux-fsdevel+bounces-74315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F98D39894
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD397300B9AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565E2F1FD7;
	Sun, 18 Jan 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LYK8FSDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB612ECD2A;
	Sun, 18 Jan 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768757628; cv=none; b=hbOpSC3fIFUDwLDRNOMIYnZgwlUxOOAbWaDnuQM68ytpeya9SNjqRgzDGuY0cUtcOKvWYYy2YZshJWaeGIJGp2y4/HnVCJ4Qxk8kbu4kKrIQu2c3OwjvfFsabMkHsZfWqJITuMBQ7421R7NxMbJnGIjF+VIKVAOeb0J21tgixOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768757628; c=relaxed/simple;
	bh=5WYncxczVCdYSzffmY7fZ0QwijmB9yzxp46+mzR5XKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPL6g2uC1kbc1jBG+Tv0ejpIxc9yUFRUBfX5nLJ18iUDj3lo1l0nkqWZGepXOSVaQPyb1xYwu6xVs5LNGx1xMebLBvLgcWtyz0PLj+9OnOZVV7bQ3E0xjWl85YoldoVXgK9Rjl3YHJDGAqtsKAqOH1shdXX6nrYgxYG6yyfyS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LYK8FSDr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iiZVfxP7lUgcZnBL6pX70dhtqK4uFbpEL9U/3xy0rNc=; b=LYK8FSDr4qE/eTCn9k2PAD7w6g
	VCrTO7x7SdHBGxBtakBBmlPuPjn8j7sknBCDGHHtJII6B5veNvFd2joqMkkX6ODac4YLwdbr5QE0s
	r0WGcFJNW8DyUrzzhXnOrmIJxeI/SvTiDtQwA9NSYYoq572U25Eu3VRSyxNm7dH4CC1/afeEj2bpc
	EPGxyyOOUerFraE8yBC6+FN/iVk0vWm1QGaolDowKp7wzoXsMvqLO9GCX9OWopB45mHcu8wmdog1Q
	qBwhoED9MEAK8g12z9kf7rzjftsECzAqZu3HTeos6g/EedI7qx4STcZ4bja4ya5BE0x/pbHMkJVW3
	OtMkobAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vhWgI-00000000gWJ-0hN5;
	Sun, 18 Jan 2026 17:35:18 +0000
Date: Sun, 18 Jan 2026 17:35:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jay Winston <jaybenjaminwinston@gmail.com>
Cc: corbet@lwn.net, brauner@kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: escape errant underscore in
 porting.rst
Message-ID: <20260118173518.GC3634291@ZenIV>
References: <20260118131612.21948-1-jaybenjaminwinston@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118131612.21948-1-jaybenjaminwinston@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 18, 2026 at 03:16:12PM +0200, Jay Winston wrote:
> filename_...() seems to be literal text whereas Sphinx thinks filename_ is
> a link. Wrap all with double backticks to quiet Sphinx warning and wrap
> do_{...}() as well for consistency.
> 
> Signed-off-by: Jay Winston <jaybenjaminwinston@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 8bf09b2ea912..86d722ddd40e 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1345,6 +1345,6 @@ implementation should set it to generic_setlease().
>  
>  **mandatory**
>  
> -do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}() are gone; filename_...()
> -counterparts replace those.  The difference is that the former used to consume
> -filename references; the latter do not.
> +``do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}()`` are gone;
> +``filename_...()`` counterparts replace those.  The difference is that the
> +former used to consume filename references; the latter do not.

FWIW, check the current viro/vfs.git#work.filename; that fragment is now

fs/namei.c primitives that consume filesystem references (do_renameat2(),
do_linkat(), do_symlinkat(), do_mkdirat(), do_mknodat(), do_unlinkat()
and do_rmdir()) are gone; they are replaced with non-consuming analogues
(filename_renameat2(), etc.)
Callers are adjusted - responsibility for dropping the filenames belongs
to them now.


