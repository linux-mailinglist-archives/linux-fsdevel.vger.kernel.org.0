Return-Path: <linux-fsdevel+bounces-51451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7AAD704D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E4D7AF2A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314722FDEC;
	Thu, 12 Jun 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7dmY/19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D99246778;
	Thu, 12 Jun 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731095; cv=none; b=U+OhtwZxuKuHw43H07qfBU8nCxzGL5wntel45MVf8eTJ5PyBHJkjqRpP4O6IEOTD5SeCqYaDdWQwEMlvfGuKY8UBzQEErN8JhPU5W34TVgZXtabPONIQ2FOewou/OXStaf8KegzWkX53WvTeQhH/zCyKoif4xH1FtDaBM8RQLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731095; c=relaxed/simple;
	bh=Kh0BauZCv2szn+k+sksxRHBW6YDi8uQ2kLg7HMon5o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih3+M7XWEMfZTWdu29RNW1QXzLkjM+jEE+oR3Cr4/YTi7R6FwishdXWtYz+6r4Dif/KU6uOfqyXcGPNIdHDAK+yDALwD20FN+X31wKPQ0K3O5wN/KTg+IjTEsVPaa7i3I+x8Tyw2Caakq0vNCxFa/lGJGs1ILatwob+jcdA6UzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7dmY/19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC58AC4CEED;
	Thu, 12 Jun 2025 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731094;
	bh=Kh0BauZCv2szn+k+sksxRHBW6YDi8uQ2kLg7HMon5o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7dmY/19DJlvo17pq5dXNQ+0pzFczuG5+XQnYIuz0GcB5ETkA+Sh92Y8773hYgF0q
	 zVzZagzB1iC1vb2YquNmmVBw9QoBnjOOrO46NdcO8VrsgfXY45ZCeDUOaZ8j+/B0oF
	 kkdPMgttOWGt+SRz/4F++0nK3msPhau+Q0eNH9I0cZ5SuCbn/w7DQeYP/cE3vf8BlX
	 56O50FSewropP1rldr/1rWBN8vLprGDLWZpwQwukREFudY1m474VnfY8qZRhX6jQGE
	 U1mUy4326vP6VBk/BSolCI3BN9lCueNRdexyq3hyd+o5vlVHFBcUlulnR5a3zw0/Rr
	 FREE8bFhbu75g==
Date: Thu, 12 Jun 2025 14:24:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com, 
	jack@suse.cz, anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	martin.petersen@oracle.com, ebiggers@kernel.org, adilger@dilger.ca, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v3 2/2] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <20250612-umfassen-visite-00afcaa151b1@brauner>
References: <20250610132254.6152-1-anuj20.g@samsung.com>
 <CGME20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7@epcas5p4.samsung.com>
 <20250610132254.6152-3-anuj20.g@samsung.com>
 <20250611-saufen-wegfielen-487ca3c70ba6@brauner>
 <aEpieXeQ-ow3k1ke@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEpieXeQ-ow3k1ke@infradead.org>

On Wed, Jun 11, 2025 at 10:15:37PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 12:23:00PM +0200, Christian Brauner wrote:
> > > +struct logical_block_metadata_cap {
> > > +	__u32	lbmd_flags;
> > > +	__u16	lbmd_interval;
> > > +	__u8	lbmd_size;
> > > +	__u8	lbmd_opaque_size;
> > > +	__u8	lbmd_opaque_offset;
> > > +	__u8	lbmd_pi_size;
> > > +	__u8	lbmd_pi_offset;
> > > +	__u8	lbmd_guard_tag_type;
> > > +	__u8	lbmd_app_tag_size;
> > > +	__u8	lbmd_ref_tag_size;
> > > +	__u8	lbmd_storage_tag_size;
> > > +	__u8	lbmd_rsvd[17];
> > 
> > Don't do this hard-coded form of extensiblity. ioctl()s are inherently
> > extensible because they encode the size. Instead of switching on the
> > full ioctl, switch on the ioctl number. See for example fs/pidfs:
> 
> Umm, yes and no.  The size encoding in the ioctl is great.  But having
> a few fields in a structure that already has flags allows for much
> easier extensions for small amounts of data.  Without the reserved
> fields, this structure is 15 bytes long.  So we'll need at least 1
> do pad to a natural alignment.  I think adding another 16 (aka
> two u64s) seems pretty reasonable for painless extensions.

I'm really against having structures that can't simply grow as needed in
2025. That has bitten us so often I don't see the point in perpetuating
this fixed-size stuff especially since userspace is very very used to
this extensibility by now. And also because you don't have to
pointlessly copy data you don't need in and out of the kernel on
principle alone.

