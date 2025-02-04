Return-Path: <linux-fsdevel+bounces-40778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD4A27717
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1231884386
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832232153E5;
	Tue,  4 Feb 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2pPWBAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B81215196;
	Tue,  4 Feb 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686364; cv=none; b=etaWw7IPUbkwZClwXfVwsXUowcWSz1PwfIaskCs7CDkaKMkobLMwU6b9p5ODkII4SjSSFeNW57SotWtj+aKvTabX2u53R6eg8BEJ6XlRNbM0pyRfSHfS5jWUC9DZjMkdi4XnE9tSB7YX3FWVFhMS0F8wt+3XjReCTpwR8CMNI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686364; c=relaxed/simple;
	bh=L54LXQnOXWaBaK5VCO3A3bjxwgajDXv30wjGTPt+098=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrCdwDVEA4XGat2GPSvNaUtUqwyE6GEhwYCs8dJ2ppdKlTAYDLMNGNjB4ccECpjtWNME649rPyoYv/kXteMGC5DqSD4sJGeH8h0zgJGJLY83fvsD0hmeqPZIaTiMHqZZZVhw3mMATgcQHRbJe1rdS7Do0zo4zjKoSgSvsnEk+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2pPWBAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA35C4CEDF;
	Tue,  4 Feb 2025 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686363;
	bh=L54LXQnOXWaBaK5VCO3A3bjxwgajDXv30wjGTPt+098=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2pPWBAh1vII7IozOG5m4s4KE4imJgEszqsdtJdsekdCwiDT/t2ls283r81dquCQy
	 gB1rTpS+CFvmUFelHBeZoYpCEh89ao9CHqq3XOIYDoPOEqj3+CuEcEERLhpzkoyjWB
	 HUWB5UH+krcTGZNezD1SBnuhzPkUJZ+Gu/SSKlXOzUKJLizTPVox1e2h5VKIKl83Ty
	 IJFA93WwuupUf57V/AjeGQSPMM9b2fbMA/1a3qU06TSqWQToSwJG8RdikVMJweUYcl
	 KPRnZC0kmQh2NWWMqLbmehulmnBU4qVT4rtOJHvwmyvOlvTAIkWKDB79cpO+H5cnJ9
	 XStY6fB0R/a8Q==
Date: Tue, 4 Feb 2025 16:26:01 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6I_mb7Y0QSWqtro@google.com>
References: <20250131222914.1634961-1-jaegeuk@kernel.org>
 <Z6GqbJxJAsRPQ4uQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6GqbJxJAsRPQ4uQ@infradead.org>

On 02/03, Christoph Hellwig wrote:
> On Fri, Jan 31, 2025 at 10:27:55PM +0000, Jaegeuk Kim wrote:
> > Note, let me keep improving this patch set, while trying to get some feedbacks
> > from MM and API folks from [1].
> 
> Please actually drive it instead of only interacting once after
> I told you to.  The feedback is clearly that it is a MM thing, so please
> drive it forward instead of going back to the hacky file system version.

I keep saying working in parallel for production. And, no worries, I won't
merge this to -next until I get the feedback from the MM folks. I was
waiting for a couple of weeks before bothering them, so will ping there.

> 
> > 
> > If users clearly know which file-backed pages to reclaim in system view, they
> > can use this ioctl() to register in advance and reclaim all at once later.
> > 
> > I'd like to propose this API in F2FS only, since
> > 1) the use-case is quite limited in Android at the moment. Once it's generall
> > accepted with more use-cases, happy to propose a generic API such as fadvise.
> > Please chime in, if there's any needs.
> > 
> > 2) it's file-backed pages which requires to maintain the list of inode objects.
> > I'm not sure this fits in MM tho, also happy to listen to any feedback.
> > 
> > [1] https://lore.kernel.org/lkml/Z4qmF2n2pzuHqad_@google.com/
> > 
> > Change log from v7:
> >  - change the sysfs entry to reclaim pages in all f2fs mounts
> > 
> > Change log from v6:
> >  - change sysfs entry name to reclaim_caches_kb
> > 
> > Jaegeuk Kim (2):
> >   f2fs: register inodes which is able to donate pages
> >   f2fs: add a sysfs entry to request donate file-backed pages
> > 
> > Jaegeuk Kim (2):
> >   f2fs: register inodes which is able to donate pages
> >   f2fs: add a sysfs entry to request donate file-backed pages
> > 
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++
> >  fs/f2fs/debug.c                         |  3 +
> >  fs/f2fs/f2fs.h                          | 14 +++-
> >  fs/f2fs/file.c                          | 60 +++++++++++++++++
> >  fs/f2fs/inode.c                         | 14 ++++
> >  fs/f2fs/shrinker.c                      | 90 +++++++++++++++++++++++++
> >  fs/f2fs/super.c                         |  1 +
> >  fs/f2fs/sysfs.c                         | 63 +++++++++++++++++
> >  include/uapi/linux/f2fs.h               |  7 ++
> >  9 files changed, 258 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.48.1.362.g079036d154-goog
> > 
> > 
> ---end quoted text---

