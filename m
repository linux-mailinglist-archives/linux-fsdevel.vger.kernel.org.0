Return-Path: <linux-fsdevel+bounces-10264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1399849930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFFD28128A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39418EB9;
	Mon,  5 Feb 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD3RssUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2118EAF
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133727; cv=none; b=XZqJWPh+ZeFnlZEhrxw1X4L5HojtpYHp+YoBB2k8a9Jp0YgGF9KZZLLsDojFUQ7C9GgHCHeconG6pVkSEbCoaq1DQqDgQEmW7DkKVJQ/szpFsE8hkb84P7k06g5AYp0c6O2SdEaP2uhSpxTodH45B728oqYkWHCeD71AlGRfM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133727; c=relaxed/simple;
	bh=l5CX4MUSpNODrG+pghWnWssiLgNUXRT1YW1tv9NA8ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkYAaSNc/AL0dRLW5odSsqEiv3id+IuENC0OgMnb6QlsPDcvfnhSLhOhdYyWvN28DUz0QPjP23FcujswkzfqZ1hJliwXQS3pGESgerfx7So53wh6t4/+9J5imbKp40OVzStNnVcMOQOXdMbrDfMu8ZBwheITu0mORRLeA8jJE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD3RssUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F74C433C7;
	Mon,  5 Feb 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707133726;
	bh=l5CX4MUSpNODrG+pghWnWssiLgNUXRT1YW1tv9NA8ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lD3RssUxgW/kqIF8GcwvdCM9e0GuFdNlqvWqfAzd61XSwGYLjuZ9uQstbKmRoX87O
	 frzkfGL8WmVVFESqBQNF1K8HBT5ie4CnBzqTPzdms3da3GxZUo9iL1qNE/K40dFcNJ
	 jvUGdhS5hCapm5V1CMlj4AQgQ87G0HK6PYqwVtHFE/bt775kvZ7QkxY1IoTHw1y2Tc
	 I9sAI64IH02tNBOHCvHpk2FVhe9XyKnBu09eAJAHrDsd9r2IjOWIk6phNkLvRvQ7Ef
	 1G5uHufLnXMrvNnxwMzQxki2viSIxrclURNF5GqoCz9SV+Gxs2Em7fq+V+5d1wEvZp
	 Bur3VbKe/7iEQ==
Date: Mon, 5 Feb 2024 12:48:42 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Re: [PATCH RESEND 0/3] Add support for tmpfs quotas
Message-ID: <eqiv6nlgvn2v5ttdcmg4uqr7wpl4qlasgmothqmjjqcfwdm2zt@r6xvh5eyafbm>
References: <20240126180225.1210841-1-cem@kernel.org>
 <Tb_UQz5UisKRZbczrlN2L0xsKfHFFywIcojx1fVIPiioQwRHgNAhhV3Ciu8twF73Q_b90wrkMHHlLYVlqaYxtg==@protonmail.internalid>
 <20240129115949.5pqeskav7jkvvxuv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129115949.5pqeskav7jkvvxuv@quack3>

On Mon, Jan 29, 2024 at 12:59:49PM +0100, Jan Kara wrote:
> Hi Carlos!
> 
> On Fri 26-01-24 19:02:08, cem@kernel.org wrote:
> > From: Carlos Maiolino <cem@kernel.org>
> >
> > Sending again with Jan's correct email address.
> >
> > This series add suport for quota management on tmpfs filesystems. Support for
> > quotas in tmpfs has been added to Linux 6.6, so, give enable users to manage it.
> >
> > This series add 2 new helpers, one named do_quotactl(), which switches between
> > quotactl() and quotactl_fd(), and the quotactl_handle() helper within quotaio,
> > which passes quota_handle data to do_quotactl() depending on the filesystem
> > associated with the mountpoint.
> >
> > The first patch is just a cleanup.
> 
> Thanks for the patches! I did a few small tweaks (e.g. renamed
> tmpfs_fstype() to nodev_fstype(), included nfs_fstype() in that function
> and used it where appropriate; fixed up compilation breakage with RPC
> configured on quotastats) and merged everything. Thanks again.

Thanks Honza, much appreciated. I didn't test different configurations, I'll try
that next time I deal with quota-tools.
Thanks again!

Carlos
> 
> 								Honza
> 
> > Carlos Maiolino (3):
> >   Rename searched_dir->sd_dir to sd_isdir
> >   Add quotactl_fd() support
> >   Enable support for tmpfs quotas
> >
> >  Makefile.am       |  1 +
> >  mntopt.h          |  1 +
> >  quotacheck.c      | 12 +++----
> >  quotaio.c         | 19 +++++++++--
> >  quotaio.h         |  2 ++
> >  quotaio_generic.c | 11 +++----
> >  quotaio_meta.c    |  3 +-
> >  quotaio_v1.c      | 11 +++----
> >  quotaio_v2.c      | 11 +++----
> >  quotaio_xfs.c     | 21 ++++++------
> >  quotaon.c         |  8 ++---
> >  quotaon_xfs.c     |  9 +++---
> >  quotastats.c      |  4 +--
> >  quotasync.c       |  2 +-
> >  quotasys.c        | 82 ++++++++++++++++++++++++++++++++++++-----------
> >  quotasys.h        |  3 ++
> >  16 files changed, 134 insertions(+), 66 deletions(-)
> >
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

