Return-Path: <linux-fsdevel+bounces-29034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D34973B57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8331C24ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82019F461;
	Tue, 10 Sep 2024 15:17:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BE199958;
	Tue, 10 Sep 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981468; cv=none; b=b6ebPRXGk6DAifaDnEpE6/C5LfU1OUUnPdpYfaCdiPNjaaO5NzEVdqPZYLUMPCcNnYN6mf72iE+gKVlO7umsKq56SiPK2tEVFRvyXKFB0pQ7cWtIEs3qUzbTD10Vbs97nIvzilLcGD2H8FHeKJCxE06gB6t8Efv+G6I3wXA5S60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981468; c=relaxed/simple;
	bh=g+SdAB7+Am8NYRxItmR+SaYHfmxIPmgPfQaomRbWu5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCaKXjSkH/EE53lDJziTSkSXH7zco0c48tgYvVJ81GQlxhQlYfkNUDu/53LYXXw4KhHAwLH1NXSYFw/L62xhs4nj1F7TA/WvGQzYh5yFR5p3XaEoG0tkqDmFmBmdvWAQRjuf/yigYu6OtlPoYhI76pVH5WAMBTy93+GmfEBgWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF1D2227AA8; Tue, 10 Sep 2024 17:17:43 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:17:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: (subset) fix stale delalloc punching for COW I/O v2
Message-ID: <20240910151743.GB22893@lst.de>
References: <20240910043949.3481298-1-hch@lst.de> <20240910-parallel-abtropfen-b166de2c9058@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-parallel-abtropfen-b166de2c9058@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 11:22:20AM +0200, Christian Brauner wrote:
> Christoph, could you double-check that things look good to you? I had to
> resolve a minor merge conflict.

I compared the end result and the touched areas are exactly the same
in your tree as locally, so it must be perfect.


