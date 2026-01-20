Return-Path: <linux-fsdevel+bounces-74574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685AD3BF78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 765C44F5489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBF339857;
	Tue, 20 Jan 2026 06:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D41374173;
	Tue, 20 Jan 2026 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891339; cv=none; b=JlYOf888UHJUg7LQkUOfZR2bZb4qzGrzN2btt/hf1CBhnG0zjNAQ2GyGl7g88Hw6E3UWRSPHvHT0Gvp/DJSaDtnRu0wzR2oimEIqTplO2eHlfnGI0yi5pgKh/9fIv3zHIpToV+Ryw/MyoPGK4bA3lAdrtbcHkSxaMcQkqckxQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891339; c=relaxed/simple;
	bh=CXv4d6sqe6C9YI+1wBpoebFR6jyppW7WV3IMJ3zWh6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOcT/DGaHbblHFNnO/u5ywXtBbJsV4Vsx/vWZ8aqAd3nvRwdLeM+/p7H6l00Sm8euSRcZ3lCfvdWq6x5OsRnnk/vVO3VehOM5noJ8X1zdlmBbudDud0m1vsVlcbHPI0ZKjw811/BrZdoHWEBbDztlMdidkPC/1yv4/PtjUCAY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37802227AA8; Tue, 20 Jan 2026 07:42:07 +0100 (CET)
Date: Tue, 20 Jan 2026 07:42:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 06/14] ntfs: update file operations
Message-ID: <20260120064207.GB3350@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-7-linkinjeon@kernel.org> <20260116085359.GD15119@lst.de> <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com> <20260119071038.GC1480@lst.de> <CAKYAXd8R=mPVR_ezDHRZqiKL9n-i5QRuDZnaK+poipBtCJtE=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd8R=mPVR_ezDHRZqiKL9n-i5QRuDZnaK+poipBtCJtE=g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 20, 2026 at 02:11:24PM +0900, Namjae Jeon wrote:
> By modifying iomap_begin, it seems possible to implement it using
> iomap_seek_hole/data without introducing a new IOMAP_xxx type.

Note that you can also use different iomap ops for different operations
if needed.

> Since NTFS does not support multiple unwritten extents, all
> pre-allocated regions must, in principle, be treated as DATA, not
> HOLE. However, in the current implementation, region #2 is mapped as
> IOMAP_UNWRITTEN, so iomap_seek_data incorrectly interprets this region
> as a hole. It would be better to map region #2 as IOMAP_MAPPED for the
> seek operation.

So basically it optimizes for the case of appending on the end.

Can you add the above to a code comment where you set IOMAP_UNWRITTEN?


