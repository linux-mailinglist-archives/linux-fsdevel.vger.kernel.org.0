Return-Path: <linux-fsdevel+bounces-65404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 803BDC04691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2DD94E1EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2706242D62;
	Fri, 24 Oct 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OA824IzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672F7083C;
	Fri, 24 Oct 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284429; cv=none; b=r3VtlXzi8hcVu1oMvC+rmirDrdlfJtpGKiZzSYTMQALFa1cdYZdAwverQHKDsjGMNMYF4+IVe3b9iWVcy4pj2xS6KcpZhqzx3fPLuHh9noJSWqCZj1t8cS3MD9oJEalvumdLrLYDz7BxDnxYbyeM5ydc/aswPNpcdI9oY1S16UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284429; c=relaxed/simple;
	bh=PBexvuG5zM7cTb8CI5RdfANzh/lurTmljF2v2AKjtC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLfhw6qFIX3vUSDgysakEZuu69vvonDR2QQXwciCeHvJ3YoJDsQHarcJONIq3T3vKw6ha69dEK3urJ5tK8Tz+NEK/LUrVdC+m9+Yh521/J70vKFB0FAecsvoQN28hXQ5hwJYa6DPZIEfvR+S0bI3DwMBBY/SEBGMPMZDkdNsVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OA824IzM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PBexvuG5zM7cTb8CI5RdfANzh/lurTmljF2v2AKjtC8=; b=OA824IzMNexdPd0JJZLkJDWJVS
	giQ9LfIZUGtUoCOzu78JhfxwTh854ryEdtu0K98UVOiGAR1Hf4y3jyllzG6+W89fufd/y0VGwHxKo
	i6CngskkKms1rxvr4KXz1gu4XxvyfEfomuK9WvZaaBpSxcru5f7ay/sUgzLKQbAGPaUFaupicdLn/
	hfL6vltno4uB0hfE4ZB81Z1VigHgdodJ2yBvHMGNs+MD5AngJit9xHsmhDW/Zd5sL9bl4O8WFdfn3
	ayG6aYH026zT4PYMyYOq3QBX/KXJDN0hvku6J0s4cR6/njJJJc0z0LrrO4ibVCCEpDSQ2JiNvDTs3
	lZVMI3/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCAXI-00000008I0T-3esL;
	Fri, 24 Oct 2025 05:40:24 +0000
Date: Thu, 23 Oct 2025 22:40:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/19] docs: remove obsolete links in the xfs online
 repair documentation
Message-ID: <aPsRSFaxLNSxuDY4@infradead.org>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
 <176117744519.1025409.3383109218141770569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176117744519.1025409.3383109218141770569.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Maybe expedite this for 6.18-rc?


