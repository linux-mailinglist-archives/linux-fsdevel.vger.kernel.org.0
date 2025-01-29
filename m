Return-Path: <linux-fsdevel+bounces-40305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE6A220C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97EB18850C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6755C96;
	Wed, 29 Jan 2025 15:43:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D71B040B;
	Wed, 29 Jan 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165423; cv=none; b=caAvF6TGdzahspM579fWtvxPkHwJbMGT/EobuSHzb0SfK0Bf/hzFdRCir16du7X4onGHBdDte0/koQq4x2iDYfVel/q106HT9uqdpwx/3N2v20iajcDz/JfakKKwdRgaEPibprhsgBz5oZ+Ye2aHqVw5hvWNp6J4n5Ad47dhgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165423; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULu2pehIaTZqspNGkUhAVs0FID6ClsMrQiAT9Ty1w1tZy0kWdZ1IYpREl+nLh4owUsEdqSvVeJuQnhQARGySnCK/uoshsPLg5x7U9NhW3vL+sQyQbBNtw+DEaz2Z9ui3ln9DBsxrCYnLzYYImtaOvtZYg372KZh0IKoY+iqYzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6C5AF68D0D; Wed, 29 Jan 2025 16:43:38 +0100 (CET)
Date: Wed, 29 Jan 2025 16:43:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] gfs2: use lockref_init for gl_lockref
Message-ID: <20250129154338.GC7369@lst.de>
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-2-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143353.1892423-2-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

