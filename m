Return-Path: <linux-fsdevel+bounces-44048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C576A61E43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A93617200F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246161A317D;
	Fri, 14 Mar 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpdZwmGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C5130AC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988298; cv=none; b=qmFuZL/tdILVxXhCmTHQxsE24WlFj15fBsoO7pOQdJ5eMTpUSUDMnNRbLNPrb++usjmQn8wyMacqqHCecm+Xws7l/iMRBmOaFoqxTUKlqhwcGGSW5y21jIdokLnYI8pvPW/EFph02Yz6Hp/aoh1Ak16f746BjPaI8HPHNwYYXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988298; c=relaxed/simple;
	bh=IRXjJzAr7EsTIKu9jsqdnzEQqA3yrEBhqvwHTh/5aWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2hQg1QptiIemYG4RkVTkUsA8VgRGxMG+GWLrc+vVx2cD7dD4O2tdmvgM83til41IxURDl449/LaZfiBkOd4WDCyF4CGwy5uLfl30azNOymDzNtWhhxhlMXURlJFqCrmB3BI4zMi9r8RFbTz5NKjowv9+CSZgunvM4A9GfjrdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpdZwmGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C66C4CEE3;
	Fri, 14 Mar 2025 21:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988297;
	bh=IRXjJzAr7EsTIKu9jsqdnzEQqA3yrEBhqvwHTh/5aWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpdZwmGx7956G3KCAXqk7wnSE0jR0t0HLGZUQcxQppEPPNRD5Lf4RqNN7iHC9egwY
	 9NPv0hTBAUeeADxwlmjHTyPlGEyB6ox6gPS41fooANbgkbGvWlof4bmUZufGvD9hBH
	 ++6u9VJ7c6+Rik6QYDSAm7sGNlmPK8qYd30SHefVUIklvVCDDA12AjQqdc3E1rZZDj
	 tL5E7uMawgSiXHAJhJzJgVG8sTLiyXzSW0YDJ7S3SRzO/ZSrrgb/cSwpz4Sp8pM2PR
	 B6GG8nFUc8KaZgh9E0geBAqfv9+3Qp0+faBZ2wfMHkLtjToIS17zYUrA8XeEgBThL2
	 3nUV3fHoiHg+w==
Date: Fri, 14 Mar 2025 21:38:15 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z9Shx72mSqnQxCh3@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
 <Z9Dh4UL7uTm3cQM3@google.com>
 <Z9RR2ubkS9CafUdE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9RR2ubkS9CafUdE@casper.infradead.org>

On 03/14, Matthew Wilcox wrote:
> On Wed, Mar 12, 2025 at 01:22:41AM +0000, Jaegeuk Kim wrote:
> > On 03/12, Matthew Wilcox wrote:
> > > On Tue, Mar 11, 2025 at 07:50:38PM +0000, patchwork-bot+f2fs@kernel.org wrote:
> > > > Hello:
> > > > 
> > > > This series was applied to jaegeuk/f2fs.git (dev)
> > > > by Jaegeuk Kim <jaegeuk@kernel.org>:
> > > 
> > > Thanks!
> > > 
> > > FWIW, I have a tree with 75 patches in it on top of this that do more
> > > folio conversion work.  It's not done yet; maybe another 200 patches to
> > > go?  I don't think it's worth posting at this point in the cycle, so
> > > I'll wait until -rc1 to post, by which point it'll probably be much
> > > larger.
> > 
> > Ok, thanks for the work! Will keep an eye on.
> 
> Unfortunately, I thnk I have to abandon this effort.  It's only going
> to make supporting large folios harder (ie there would then need to be
> an equivalently disruptive series adding support for large folios).
> 
> The fundamental problem is that f2fs has no concept of block size !=
> PAGE_SIZE.  So if you create a filesystem on a 4kB PAGE_SIZE kernel,
> you can't mount it on a 16kB PAGE_SIZE kernel.  An example:
> 
> int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
> {
>         struct f2fs_inode *ri;
>         ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
>         ri = F2FS_INODE(page);
> 
> so an inode number is an index into the filesystem in PAGE_SIZE units,
> not in filesystem block size units.  Fixing this is a major effort, and
> I lack the confidence in my abilities to do it without breaking anything.
> 
> As an outline of what needs to happen, I think that rather than passing
> around so many struct page pointers, we should be passing around either
> folio + offset, or we should be passing around struct f2fs_inode pointers.
> My preference is for the latter.  We can always convert back to the
> folio containing the inode if we need to (eg to mark it dirty) and it
> adds some typesafety by ensuring that we're passing around pointers that
> we believe belong to an inode and not, say, a struct page which happens
> to contain a directory entry.
> 
> This is a monster task, I think.  I'm going to have to disable f2fs
> from testing with split page/folio.  This is going to be a big problem
> for Android.

I see. fyi; in Android, I'm thinking to run 16KB page kernel with 16KB format
natively to keep block_size = PAGE_SIZE. Wasn't large folio to support a set
of pages while keeping block_size = PAGE_SIZE?

