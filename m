Return-Path: <linux-fsdevel+bounces-18060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78D8B5098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9671C211D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34195DDB1;
	Mon, 29 Apr 2024 05:12:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E4D28D;
	Mon, 29 Apr 2024 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367535; cv=none; b=Ia+Dz2OIHjb149GwHIZLnRMLfJNBLJe07VnYR6ot+FG7UVf+Vtwi+UwjXsx0cagRsKWC9HKIlZarDit9ULRwQbLmmb5kBdfOmLtxAo0+R4nMilQEtisGWrXGFtpdInnrV1C+K0kqNiiyfv/K1OYdPMTweRmcAFvCIfvjNVY3H7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367535; c=relaxed/simple;
	bh=JNtX7pRzwhdr5vqwIyAe/9GDglU1CxUD6Y7F/AqZDq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmcpogDT7dgnlYYF4HLZwI7mKqJAisjTF56mf3giTH8/3cu9rfHPJTAENFLdXWrlEvFK/zhUStUIfyppzAMnSTS6fVtmnFIseRY3MoMLNrv5jYhzPVjcVrBWFtcIfHgdTZXme8OOD4Fz0KARoje0eFMMECj5BBocCDlGtlxQ0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB838227A87; Mon, 29 Apr 2024 07:12:11 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:12:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/7] set_blocksize(): switch to passing struct file *,
 fail if it's not opened exclusive
Message-ID: <20240429051211.GH32416@lst.de>
References: <20240427210920.GR2118490@ZenIV> <20240427211305.GG1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427211305.GG1495312@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

Please turn the second half of your subject and move it to the actual
commit message..


