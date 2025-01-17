Return-Path: <linux-fsdevel+bounces-39501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0AA15480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096223A22DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D919D098;
	Fri, 17 Jan 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZH0mcMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D613F434;
	Fri, 17 Jan 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132025; cv=none; b=r4OnYmh7xPdPlHwtEtb7oQmp1YreMNbGz6/kajzMkyOOR/ZYoAkUI6q//3hW7Sf6JZ3IDoRcfEaPkmZMSesAi2fdW+bvVOSBcrgC2Bq+AZHxOifk5yHVh677B9/JlW7MJjt6M5Ldw++Yh5rfCKwyBB1dgfeFIdTq/pXd7b/oicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132025; c=relaxed/simple;
	bh=7ia9QXVnyp6GQ8EnTYC/sW6gQbchfcMyF3uTvTk7F1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT1UUmv1MBLJRWQEmtWLGIdHBLF6hKChgn1DR66AuHoiyPJAEOtLYAoFU+kQhO+ci7bcQQBEP20/gaOJXsxjJcwWIYGng3jim09vk39i362xTx29fJj499+LNgfTvRL3bsTed2o/3RrNoaWSjUq6XIYBOtzkkq16KqgrUfLsrFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZH0mcMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECF2C4CEDD;
	Fri, 17 Jan 2025 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737132025;
	bh=7ia9QXVnyp6GQ8EnTYC/sW6gQbchfcMyF3uTvTk7F1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZH0mcMpvosStXN/9FVC62YciAJGHG2pEJE+0sQO1U9TzysOa7vH00tqs8Jr9o3Ak
	 fKEBgH+wdmobrE8rnLIJwB4lD3YgZ2KWBhTBLCITmGyMHkk0GSMDpdeChrCHUM07Sq
	 rfE8Z9z92DZoE+V4MLQcKHJnN1df2M/GpgyPs8tDP7wZqkynBcwOyIe4RK1xD9bF6e
	 SPKj2v+Y3Xqhru5enmQke4BZ+vCYK0GOBSwgeL0ih+kLtWxwNIeks0/5fcmXAqVS36
	 6JqJSbyeE6du/7Yq5cOuhSQounJEBOscgY4paFrSy511ASq4JdDD8u3lIguYUIkhJj
	 9HGSf90IBMItw==
Date: Fri, 17 Jan 2025 16:40:23 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v5] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z4qH9wD3oa2hfaLY@google.com>
References: <20250116172438.2143971-1-jaegeuk@kernel.org>
 <Z4oNmx2xPkdzvkUd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4oNmx2xPkdzvkUd@infradead.org>

On 01/16, Christoph Hellwig wrote:
> Still NAC for sneaking in an almost undocumented MM feature into
> a file system ioctl.  Especially while a discussion on that is still
> ongoin.
> 
> And it's still bad that you don't even bother to Cc fsdevel on this,
> nor linux-api or in this case the mm list.

Well, I don't want to bother other groups for random APIs, unless I, myself, am
super confident this is feasible for generic API.
But, let me try to listen to other opinions.

> 
> On Thu, Jan 16, 2025 at 05:19:42PM +0000, Jaegeuk Kim wrote:
> > If users clearly know which file-backed pages to reclaim in system view, they
> > can use this ioctl() to register in advance and reclaim all at once later.
> > 
> > Change log from v4:
> >  - fix range handling
> > 
> > Change log from v3:
> >  - cover partial range
> > 
> > Change log from v2:
> >  - add more boundary checks
> >  - de-register the range, if len is zero
> > 
> > Jaegeuk Kim (1):
> >   f2fs: add a sysfs entry to request donate file-backed pages
> > 
> > Yi Sun (1):
> >   f2fs: Optimize f2fs_truncate_data_blocks_range()
> > 
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++++++
> >  fs/f2fs/f2fs.h                          |  2 ++
> >  fs/f2fs/file.c                          | 29 +++++++++++++++++++++----
> >  fs/f2fs/shrinker.c                      | 27 +++++++++++++++++++++++
> >  fs/f2fs/sysfs.c                         |  8 +++++++
> >  5 files changed, 69 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.48.0.rc2.279.g1de40edade-goog
> > 
> > 
> ---end quoted text---

