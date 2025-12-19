Return-Path: <linux-fsdevel+bounces-71726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C32CCF8AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0393303A195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC83081B0;
	Fri, 19 Dec 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QUu/BlPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AF274670;
	Fri, 19 Dec 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142625; cv=none; b=pWKzuciHfkZueT4uSkz32vdCq6SuQwLoJsGdHFegs7TS8oQIq/JPSOgnaJg6uvq3yw8Ur5v26i85oJ0+Dm8ZgV6LE4HTgRkowUcN5d+ytPaH42yY2JOhRtnoGH3TrCX8AO9N3UJTnK1STsgUEmlmVq7BIjVTqpbU0BGEtONQxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142625; c=relaxed/simple;
	bh=ymHDycBiD3cdlOsRLJpMzh+CAe7R8FTNqUi6noJRgc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaBPMQvQigmB/JBroCKCu4mGLTCFZBsC4fWN4aROP6M+J92vlMGEW/BBaZz28GAm04zsIJrvPOiBZCr+dHwkujFmb0UcxTcSffQaQFbdOPxJOE/0TBouZmz5SBnYU4xbXko/td6o0o6lyQ2HKyJFLpJMbMiQRavfLjfE2Zt4jAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QUu/BlPP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=77glmLHUn38+bjFwaQX0aUFqGU278qbMfSMlpnIXh9Q=; b=QUu/BlPPopOOjJPBENVYe9e2zd
	Rwwa1KOm6AX0D8t7dMX8AgblxZ+f/bvv0wzvCBIJbzxaVu4RVeBTNwolVuNdS0PbtI5u3PuDHZYwv
	PUbmh8AWksaiStR/VhSELAEcYgwsr7cEYvP2RQTJ81H99ZXltiGAw8A3W3wM1ueDVIO8VuxnH6MgH
	dPbDdiCB1q3UmHcWvTu6LAaFOLwhbiRkY1jQF7G9zzNeb4m6wNYTYByMRqlLlGFK1ccWeD8dRSIp1
	GtXK46QkPVV5s6Bb4xEiJ43xjdwmR0eh5u6pi4ccIhHQY/sCMtnuCcZGC2VYt6TPnwZqhTRqKeTFj
	JXm29eVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWYNG-0000000AAoe-3YGk;
	Fri, 19 Dec 2025 11:10:18 +0000
Date: Fri, 19 Dec 2025 03:10:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Chang <joannechien@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] generic/735: disable for f2fs
Message-ID: <aUUymqMO4RfK8thK@infradead.org>
References: <20251218071717.2573035-1-joannechien@google.com>
 <aUOuMmZnw3tij2nj@infradead.org>
 <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
 <aUTi5KPgn1fqezel@infradead.org>
 <CACQK4XCmq2_nSJA7jLz+TWiTgyZpVwnZZmG-NbNOkB2JjrCSeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACQK4XCmq2_nSJA7jLz+TWiTgyZpVwnZZmG-NbNOkB2JjrCSeA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 19, 2025 at 04:53:04PM +0800, Joanne Chang wrote:
> Thanks for the reply. To clarify, I meant testing the architectural
> limit of blocks per file, not the current free blocks. Sorry for any
> confusion in my previous reply.
> 
> The limit is indeed the maximum file size. However, since both the F2FS
> file size limit and the test's requirements are calculated as
> (block_number * block_size), I believe it is simpler to just test the
> block number.

Well, for the file size you can test by doing a truncate to the expected
size and _notrun if not supported.  I can't really think of a way that
easy to directly check for the number of supported blocks.


