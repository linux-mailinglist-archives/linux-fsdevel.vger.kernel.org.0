Return-Path: <linux-fsdevel+bounces-38744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4FA07B25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571BE188C376
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17D21C9F5;
	Thu,  9 Jan 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIjzOFve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7613BC26
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435118; cv=none; b=cbH83qEGRu4Cn+ADGgLjABdoV0dZzyaeZIi1F3N9A5TKYKcvrXlGIKkykmPa4s7T/dO6pmQ4vI8SC/TSNhgYoalhNj6MuzsfV0nCGK8LQ3FKempiXw4kcTXc5Ys17Unn4QmdIpaJ5GNo4b6VhgG5LqX4kTnRFjPRQtJNgOCGnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435118; c=relaxed/simple;
	bh=fHuL3kU3wosWJ+8PUG74EaI56yUK3TvfC5RTLlwWOEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZXkgzOhagvG6wDg2SSm3s+9E1EgdP95mqRtL6PNhjaHxxHwqO4n9aI2bgkQgyDAyA+HEnhT15kT56ZrF+wU5+ES99/Pd+xEsmxkL2KeczUKvQhqhosU1bo18m25gjYi7RyzEo5h0RH5ft0tRQuIYayDSArJDHuKpZGsu2X5xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIjzOFve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ACBC4CED3;
	Thu,  9 Jan 2025 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736435117;
	bh=fHuL3kU3wosWJ+8PUG74EaI56yUK3TvfC5RTLlwWOEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIjzOFvekreHU5cWSukDPpyYvNZyUF5bRUlhJ/0Y4iMwQxdGlo3f+CYIgxHu3iVKb
	 kD1nAGlCV5qE6DCgaBku1b8UqOrr8hMRMj23zYN/Fm5JXrSnyoS5A2ghqYqbG99OOb
	 RXKbVI+kVnwaCqf+xSnY7YsVuhmawXEHSHGxpFVlAuaUfiXQC5Zso3lPd428pL92uo
	 JXQM841z8ihjAMsu0VG9gAbPUavMbEnnNkIRMgce8wxW7VNpTEPe/Kvn7yaSfrGEtP
	 ESZvi1NrEXQKgrWrTett4CYVeusMyATxV0syz7va8GcKZhUv46kwAgmKeS0bptxXb9
	 bkYoHfBDgapXQ==
Date: Thu, 9 Jan 2025 16:05:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <20250109-bekunden-speck-87912b1860fa@brauner>
References: <20250106162401.21156-1-jack@suse.cz>
 <20250107-wahrt-veredeln-84a1838928e8@brauner>
 <Z379F9ymCnMB2vt2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z379F9ymCnMB2vt2@redhat.com>

On Wed, Jan 08, 2025 at 04:32:55PM -0600, Bill O'Donnell wrote:
> On Tue, Jan 07, 2025 at 03:35:35PM +0100, Christian Brauner wrote:
> > On Mon, Jan 06, 2025 at 05:24:01PM +0100, Jan Kara wrote:
> > > Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> > > rwlock") the sysv filesystem was doing IO under a rwlock in its
> > > get_block() function (yes, a non-sleepable lock hold over a function
> > > used to read inode metadata for all reads and writes).  Nobody noticed
> > > until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> > > Just drop it.
> > > 
> > > [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  What do people think about this? Or should we perhaps go through a (short)
> > >  deprecation period where we warn about removal?
> > 
> > Let's try and kill it. We can always put it back if we have to.
> > 
> So should any work toward converting sysv to the new mount API stop? ;)

So I would suggest we try and remove it for v6.15. If the removal
survives the release of v6.16 I would call it a (qualified) success.

If during this time we find out that we have to keep it and have to
reintroduce it then we may as well spend the time to port it to the new
mount api.

Thoughts?

