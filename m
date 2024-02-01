Return-Path: <linux-fsdevel+bounces-9806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285B845138
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 07:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00D91C23867
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 06:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B45285C4E;
	Thu,  1 Feb 2024 06:07:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF782890;
	Thu,  1 Feb 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767644; cv=none; b=oNtt1FpfbMcBRi2zh3jvVOGeVlxp/cCl9HPTLzBhJri2ecuCjRI43Ecc0vNXrJOV6ZgmV+es3PNY4nL78WjLX1c2SiHosTPswtYs72pnGDbEnBLum1nnTYaE2lpzqamWzrF3OEqUbbjhxzBvMwkDgHrxhGGdfGDV1xlMVO40LCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767644; c=relaxed/simple;
	bh=t3hlth33PSW8gqsOkXVnuXDwZyxnzwJ1Rj0YBhkyM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDiHccYZ5BVawlCaVnRC2tau7p5DVB9ZYQnnbxqegxE7/gvexsjyz0lszK6w0DCZWHbqVW6zhVtO95kICx/YWRLrSeuJ0HMsYfjf8bencKUYOsv8/5gp2LAergnJJd58dDDN2BmwV+6EPLB7wIgDxuMfPEmOVAYcUtSxkku22Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2212868AFE; Thu,  1 Feb 2024 07:07:17 +0100 (CET)
Date: Thu, 1 Feb 2024 07:07:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: map multiple blocks per ->map_blocks in iomap writeback
Message-ID: <20240201060716.GA15869@lst.de>
References: <20231207072710.176093-1-hch@lst.de> <20231211-listen-ehrbaren-105219c9ab09@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-listen-ehrbaren-105219c9ab09@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 11, 2023 at 11:45:38AM +0100, Christian Brauner wrote:
> Applied to the vfs.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs.iomap branch should appear in linux-next soon.

So it seems like this didn't make it to Linus for the 6.8 cycle, and
also doesn't appear in current linux-next.  Was that an oversight
or did I miss something?


