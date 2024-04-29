Return-Path: <linux-fsdevel+bounces-18056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F498B5085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CD1F22A49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E2D53C;
	Mon, 29 Apr 2024 05:09:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A75C8E2;
	Mon, 29 Apr 2024 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367370; cv=none; b=C/jIPFWzMwWtqc2FOBmxcmVyMNgLD0rw1Wvh/gmSM2R1SGxWXYfcwPWWRBmNExcrcq7IQwHYs1dDMt7zbBtiZosJ3dnpt5yJ6HTwtGrlGabEga53soqTJrVnGK8YIRUpLqgV52QPm65wTo3Lt3+/8f9KFF6lVfsH3go4lipdp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367370; c=relaxed/simple;
	bh=wCm0pJPqPB6+c9cFevjrZRZcGFFHvrG7db6uryCOpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz4QrTs/GNEI7StfWFsOkW2+Vt+s4qO/pOlIv0t2KPXtlbX14J/8sLclCIIsJontRGqA5akDFXNoKT7cBrwiGjxsCo8Os/8T7H0Z6Ix3Bvm02YkEfB//nFVlboswgT96GtuGeYQZjEy/ybPpsRoE5ZN3nKG6lRjp6uvMOBnRvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D68A67373; Mon, 29 Apr 2024 07:09:25 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:09:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240429050925.GD32416@lst.de>
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427211128.GD1495312@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

> -	swap_file = file_open_name(name, O_RDWR|O_LARGEFILE, 0);
> +	swap_file = file_open_name(name, O_RDWR|O_LARGEFILE|O_EXCL, 0);

Can you add the proper whitespaces here while you touch it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


