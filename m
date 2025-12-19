Return-Path: <linux-fsdevel+bounces-71713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D1CCE88B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 06:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADFA3037CFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 05:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0A2D130B;
	Fri, 19 Dec 2025 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxoP4dEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20E2D0C66;
	Fri, 19 Dec 2025 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122222; cv=none; b=BrW5m56y5lybwbcb/JevstFoqnULvStwcavYp0OTXJgSHRXG/mgOZDTQ5+HKLB+WMBDwIYGdCtwN2BGfYWpOmoIw+53sajWaQV1THtSlZf0N1JY3TQR2uU8GA5R2ULUGFPtQCLL9A3FTV9BooCoOLw2Qmr0jfgFpzE5rbHbwbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122222; c=relaxed/simple;
	bh=3uLlaz4Cn7+HUm7Xt16u1J4mpkJgct757cwKa4FuZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVdszgVJrhlzoXyQ9Nn44Ldp9vbAApt50ixur3lfmB8dOIUhRF12fI9Z9MbP2mNk/3A9yZm4SMwpQAP+NtqBsrBbLyHgAqc2VciDcQkjpwZjtTRcNlecsqu60icti8mxzNsxb0gSKoDqk2LdSyggKK9EnoKBqlk2HNEKRT5rVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rxoP4dEM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yBdvfHBasrnEFTF070cSt/emoT+E7CbdyD7j8s+6u7Q=; b=rxoP4dEMkOJwSZVmdT3KZhBcDW
	aSF7Qi1XqLcC2/Yx3sl5HWOKYAQVVhU3uvM3w+Ip8tmcMEXMVGuhWugrpmaL72N/J41wlmDy1QPU3
	BiKLIXXqMGXHhAxWhdJ7jVZpraDMX98s1V4DAnonFCx6OIrElZlP8/io7XXoxleY+JdPYDtCAJ99j
	vJtX+r4/VtBxD+qfe6H7i8Scu0isQrNe3xMMTrMMUaffDLtLL9ST4BXMLMFF8lziCUtS9KNFNW0/X
	vl7rWBCBd+/LXSw4q66w4f+J0fDmRrL8LPNcuaiKiqDYUyxxPZ8s5hwPufIX2miSKipo4VxanK3SP
	hfSxbYHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWT48-00000009eLX-0v3v;
	Fri, 19 Dec 2025 05:30:13 +0000
Date: Thu, 18 Dec 2025 21:30:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Chang <joannechien@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] generic/735: disable for f2fs
Message-ID: <aUTi5KPgn1fqezel@infradead.org>
References: <20251218071717.2573035-1-joannechien@google.com>
 <aUOuMmZnw3tij2nj@infradead.org>
 <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 18, 2025 at 08:02:48PM +0800, Joanne Chang wrote:
> Thank you for the feedback. I will implement a
> _require_blocks_in_file helper in the next version. As far as I
> know, there isn't a generic way to query the block number limit
> across filesystems, so I plan to hardcode the known limit for
> F2FS within the helper for now.

Oh, the limits is not the file size per se, so the number of blocks?
I.e. you can have a 64-bit i_size, but if the file isn't spare it
eventually can't fill holes?  That really does seem like behavior
applications would not not expect, aka a bug.


