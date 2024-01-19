Return-Path: <linux-fsdevel+bounces-8346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9625832FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34D8B21F92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B15733C;
	Fri, 19 Jan 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEUmxWi1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793B1DFCB;
	Fri, 19 Jan 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697381; cv=none; b=JfCDAF7N4sdi0MjLxN8Vjkgmm/g/bjVgHUWDEHKFwIupZLzbB7YBH67lsTmY7oQaOWTtopqhnczQka4D2sz2JIS3t0vOl2f+oGRLgCked26mluqz2D49V7WrB/QUn6cun+sQ0dgZGMuk7f1iikKyBeelVOIJ/MJ9VZ5ME8FpTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697381; c=relaxed/simple;
	bh=ULOIRBPrMeDfSN1D3IxraZwLRBgSo/f7XWxfB6Eofxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+cNibjmS/ecgOjY34jQjJUCRnNzlg77P5c+UqnHLZr8oNx33mNjD6N27tZCQprihhmznp+hN3xU5vEX04Te0NTN5DlvDwQcvOhUvH6z7hO8jyvLx7a6p4bYArIxJ5fu4vVFGREYAJl0A6rnmtjMIjFZane/hCFg93vjCilQytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEUmxWi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B34C433F1;
	Fri, 19 Jan 2024 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705697380;
	bh=ULOIRBPrMeDfSN1D3IxraZwLRBgSo/f7XWxfB6Eofxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEUmxWi1MMVwOTWVYgyanV5UKKbnmqb37c28J6+QUSNp8xwj6WqpkrhqFFIqoKuA5
	 8hShNIsHBy5UY9KBXm7JGR2R0f9/s/tTj7Xxcy634pVXDb/YVbPeEYFSsowwjh5Fdf
	 QQVJdNyVRMFWSm/hfm81Cctw+tJRE22PrHvJWXPFMAWBg0VCnPdGdhpNHRAiiZTh0s
	 kUmywlWgXOxT5bKFR9EpU0ALlAOzrCyyVJqgJCvo16FN0ZblbLp5IurgVhJpPk3BAr
	 Y5ZIPkcZX2w8rj+Y4hNukwUGkl90mLkvpPOb5z42i6x7H9Y2L7TwDi3/58m/RsKR0m
	 4B79Qe+aBxbcw==
Date: Fri, 19 Jan 2024 13:49:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	lsf-pc@lists.linux-foundation.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <ZargYTc8HE47a0s7@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
 <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
 <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
 <ZahL6RKDt/B8O2Jk@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZahL6RKDt/B8O2Jk@dread.disaster.area>

On Thu, Jan 18, 2024 at 08:51:37AM +1100, Dave Chinner wrote:
> On Wed, Jan 17, 2024 at 12:58:12PM +0100, Javier González wrote:
> > On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
> > > > On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
> > > > > How FDP technology can improve efficiency and reliability of
> > > > > kernel-space file system?
> > > > 
> > > > This is an open problem. Our experience is that making data placement
> > > > decisions on the FS is tricky (beyond the obvious data / medatadata). If
> > > > someone has a good use-case for this, I think it is worth exploring.
> > > > F2FS is a good candidate, but I am not sure FDP is of interest for
> > > > mobile - here ZUFS seems to be the current dominant technology.
> > > > 
> > > 
> > > If I understand the FDP technology correctly, I can see the benefits for
> > > file systems. :)
> > > 
> > > For example, SSDFS is based on segment concept and it has multiple
> > > types of segments (superblock, mapping table, segment bitmap, b-tree
> > > nodes, user data). So, at first, I can use hints to place different segment
> > > types into different reclaim units.
> > 
> > Yes. This is what I meant with data / metadata. We have looked also into
> > using 1 RUH for metadata and rest make available to applications. We
> > decided to go with a simple solution to start with and complete as we
> > see users.
> 
> XFS has an abstract type definition for metadata that is uses to
> prioritise cache reclaim (i.e. classifies what metadata is more
> important/hotter) and that could easily be extended to IO hints
> to indicate placement.
>
> We also have a separate journal IO path, and that is probably the
> hotest LBA region of the filesystem (circular overwrite region)
> which would stand to have it's own classification as well.

Filesystem metadata is pretty small spatially in the LBA range, but
seems to have higher overwrite frequency than other data, so this could
be a great fit for FDP. Some of my _very_ early analysis though
indicates REQ_META is too coarse to really get the benefits, so finer
grain separation through new flag or hints should help.
 
> We've long talked about making use of write IO hints for separating
> these things out, but requiring 10+ IO hint channels just for
> filesystem metadata to be robustly classified has been a show
> stopper. Doing nothing is almost always better than doing placement
> hinting poorly.

Yeah, a totally degenerate application could make things worse than just
not using these write hints. NVMe's FDP has a standard defined feedback
mechanism through log pages to see how well you're doing with respect to
write amplification. If we assume applications using this optimization
are acting in good faith, we should be able to tune the use cases. The
FDP abstractions seem appropriate to provide generic solutions that
don't tailor to just any one vendor.

