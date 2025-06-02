Return-Path: <linux-fsdevel+bounces-50366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C022ACB6BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70613A27068
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF322E004;
	Mon,  2 Jun 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlHluu4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B4224247;
	Mon,  2 Jun 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876452; cv=none; b=fFh4wy3bSoDk2iIqTyEzTpGSxu66Is3vD4B0nfRCsHUEWyWeO2pQx1d4x2hYu545knlCNKjwbONtIJtoWcdQSIzT8FvfZT/EAx9Fj1O7HJwqIYeN8tk9Fxf1ExultforFCZMzwZqhOzASlx6K+AlcOcr7rPavkwND5ry62EEEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876452; c=relaxed/simple;
	bh=w8eq0Kfn6BFhNkvfT7XygEyQsOCSaNrSDB+GhUQYFSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UAY5TTGrqQqpRXVuGK3kRDhRHQ44xktiQY8RDbnL4hfMdVPxhqUGvGBt2SUz1Cr3t1NgFQ26LwuvjYq1GFwYpaGB6HD1cmVOXA9Be+OafsM3P6bb6vYb+KAO+55dgM3HjqQFjeHodDo0MyvIhGryuWAKvIs2mJDKpWGdLwFBy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XlHluu4d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M/x/2t2Kx+g+vjGkWXYKWBCl3dNU64A8n1tVJEG0ynY=; b=XlHluu4dwkJTzQRCK0mFuwUq3G
	2PpM7VN2iZt8BSE2fJUc9HvPiGw6NhHEtBTW60h2df8TXcExnCV/+FJQe4V4KDyp1UGBM61U8hzgd
	4cSzN4AvuxPb6kP+hqP1f3zkWgQkhBG9eDQvS5EQF7GiZBHNEDgd6cxTLrox+FTb0wIeijfR6AiIf
	Iw1xQCNFcWT2hKzs5GNx/Ce0BLiDe+W74xyc2FMrKwFoNLTt/iRKA5ENOJSzNkNtQRctzgfTanmlJ
	KVysxVpTnvAdwYjmNuF9nTk/UUCWcvehtdb3BO1PIAo04ioFv9R7WbFYyTRNk0gWG4WtMPSvI/SA1
	DEw/T6Xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM6eg-00000007hUJ-1fmM;
	Mon, 02 Jun 2025 15:00:50 +0000
Date: Mon, 2 Jun 2025 08:00:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: RWF_DONTCACHE documentation
Message-ID: <aD28onWyzS-HgNcB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

I just tried to reference RWF_DONTCACHE semantics in a standards
discussion, but it doesn't seem to be documented in the man pages
or in fact anywhere else I could easily find.  Could you please write
up the semantics for the preadv2/pwritev2 man page?

