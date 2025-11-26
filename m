Return-Path: <linux-fsdevel+bounces-69861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C9C884D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 07:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89DDA4E1853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B931618B;
	Wed, 26 Nov 2025 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGBZghQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B15730BB81;
	Wed, 26 Nov 2025 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139386; cv=none; b=r0cWfd9uE5TwActgc9WtnHCd7MQrceB7PX/b27gxSu3OubGpw9/CzreRKLoAEMflBPc6i18fVrkxK0Qe6ZRzvf5BMSzeohan1c7ABgZOptJhwR1p75AMaWnhPIFVvC8IOlq3YvYP2yKdK93LLLUhv3slCWggR1eumJp+6MNWEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139386; c=relaxed/simple;
	bh=kNNYbB8FJdOdajpMyFd8Li9P2mUILwiwomJG/W//mtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9ry3uBuxpe9fy9MvX1elFjBWI//5k6LKyE41+aENXHv5XVRm4n/qiQbsRPEZyKRVDv/zqy1L8X0VUANheTLPPlNi2dfcqblOCqvD8TtI8QP0dSKCdXSUjxl2Ua9o21gRfbdUcDnPAYcGrl3yHUAwxTlqLJvRuPH56WjDsOogqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LGBZghQW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+KpLqQWpwoP6dgtTSo3vmVFRx8im2znM8/RvG+Nzsoo=; b=LGBZghQWj4kWpFGJR+sek5WWzG
	oY0CnF3F8BBV3Q/bzbLOXyXsveMZZ5tzGCh6I5pJIAH/zojt5lBNhfWU/4qQw/MqPBAvkvdxB8vcR
	hoDnDjzIyHXQAaFJHWJazCiijnqwFpww+PfIRGETPXwX0hunUNGIivcLLEbDRu3y8UMDMqGZVLz0X
	0w7sIIwAdp8ITgJlFeTwec4tmjPhmdDHuL0Z7Dv05ImwnOSCYFnxrIICpLb3pWiCySmAf3ZorZvEn
	spsfh3L7xiPQPuMtSAtz2Mr0EY350Cnjp/7q9e5mM2v5e6H9guq/DCXN6B+4bccLCee+3fy0VlKbp
	PmpIK+Sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO9F2-0000000ESG0-1i9S;
	Wed, 26 Nov 2025 06:43:04 +0000
Date: Tue, 25 Nov 2025 22:43:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/22] docs: remove obsolete links in the xfs online
 repair documentation
Message-ID: <aSaheJ-eYvqi3-Um@infradead.org>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
 <176230365709.1647136.9384258714241175193.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176230365709.1647136.9384258714241175193.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 04:48:40PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Online repair is now merged in upstream, no need to point to patchset
> links anymore.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Can we get this queued up for 6.19?  Sending it standalone might be
best, although given that Carlos is on Cc maybe he can directly
pick it up?


