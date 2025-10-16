Return-Path: <linux-fsdevel+bounces-64364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20902BE3426
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD04FE6CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E873277B1;
	Thu, 16 Oct 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="w84ba/9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F131DD82;
	Thu, 16 Oct 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616620; cv=none; b=lEIc8tglNuwwmzLUk1RQ/rFKS4YFdDKQCD7hT0pXPEmFP97wGM+AIrW33RkGPioKUjuDVHWrFDcoB4ngxas3DZpZGDqIqlO/at5FRd3YLIzQw/b8zhAp2B+FBwYilvFOq0e0y+a7YsJ7PQR2N2cZJwl1I1ve+ansLajBe2lyCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616620; c=relaxed/simple;
	bh=4Qt/jrGVmj3vADbRLp0h2/WSd8+bNzzpsqAfrkcvno0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6kCV0lJbavP23ohCc11XL5VhdxeilHgFheGrOJfeWnRanp177AhemcxF6U5pmV9gMZf75rIVQDQ8OLbujdaL1tF9pB6EOGB/5l+fvCWl11wEO1AqEGl6vroOqxJptRpcYNXX5jve3dPwUIZ4rjZUNPH+Rc+0qnkkNNS6fR9SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=w84ba/9G; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cnRbn6y0qz9tTc;
	Thu, 16 Oct 2025 14:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1760616614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTBsBVcdYneguqY7H2XP4BmfLiHWNCMUbN9tOOocbPk=;
	b=w84ba/9G+wBfuZTsDm0winUj7q7U2ke14hditeFI1v3kd6anmKHTwrzDY2otBvUD2GaaRA
	bTf5ybwxsgKuhtbrjOoQIGkJSVxkxCTNwaNIifqMMh/lJeEM8JMbFjH4KuiPiEoV8k2MDu
	YC9zvYRCE3SWDll03bRYXiuO1wG3NvN0VYzvXFq51QEuKZW/qic9D5sQxulZWwAOlZ7/IO
	IZ4hbJG+tFwea34RRRNo2R2Yb/nhoi3akrpZSgZaf6mZGPYBc1joUBOs8wpZdjiNHukWga
	5BxqvfHj4r3udrSsTbWV5OFaKHEteL0Bc2rOUBEjSznViG/n+14/y+uLHamimw==
Date: Thu, 16 Oct 2025 14:10:05 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <khcpybd4adk4y5cc2k3ovdvuesv5lxyb6foo5r7dkgoiuyb5as@voqvrezskk42>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>

On Mon, Oct 13, 2025 at 07:35:16PM +1030, Qu Wenruo wrote:
> Btrfs requires all of its bios to be fs block aligned, normally it's
> totally fine but with the incoming block size larger than page size
> (bs > ps) support, the requirement is no longer met for direct IOs.
> 
> Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> requiring alignment to be bdev_logical_block_size().
> 
> In the real world that value is either 512 or 4K, on 4K page sized
> systems it means bio_iov_iter_get_pages() can break the bio at any page
> boundary, breaking btrfs' requirement for bs > ps cases.
> 
> To address this problem, introduce a new public iomap dio flag,
> IOMAP_DIO_FSBLOCK_ALIGNED.
> 
> When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
> inherit that new flag, and iomap_dio_bio_iter() will take fs block size
> into the calculation of the alignment, and pass the alignment to
> bio_iov_iter_get_pages(), respecting the fs block size requirement.
> 
> The initial user of this flag will be btrfs, which needs to calculate the
> checksum for direct read and thus requires the biovec to be fs block
> aligned for the incoming bs > ps support.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Looks good.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
-- 
Pankaj

