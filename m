Return-Path: <linux-fsdevel+bounces-25698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721F94F515
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA981F21B24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF6187332;
	Mon, 12 Aug 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hoQRIyKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE61494B8;
	Mon, 12 Aug 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480815; cv=none; b=P5o+V8LdriEorWc9y09vMpGuB8qrZOpunJTqhpsBY+pjCm9LwsF36t0+yicrpMBQDz8gtIVVp86BTHveAWFUO9OJMUdz2KtFhVXQcaGKvfghmEnWQua597rFHMNRHezQojh7uUkbsWRZW1izfenVzxaVBHJ98ZlrJpIys8XKmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480815; c=relaxed/simple;
	bh=BhuxBHwSqvK3NfpdV6y7jZbOqPnGXVRVotuTD2awFSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRuEAIalEehhpJgq61npSTVzFcdF2M5AtCv1pbFunnNVUMNJufQALk6gksPJCuK7ExvvVH5z1d/o5DbWAO2aVd7XxEnnaiYR/W1dj/XWff3q5U2l5jAkPzsJBYKChHMlrQ4ttseLwWMeUuR/9HbGzf7sYWOonY2KNOdus/NUvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hoQRIyKZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WjKxb0d8yz9t6q;
	Mon, 12 Aug 2024 18:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723480803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJk4Vnl04Aw7j+NDa+iBHRI+DmCBEW0NB+2kLgBa26E=;
	b=hoQRIyKZjG/fYVUmT/agpW2XV974v/vv4+sVRs19uH3+KkIBDIBu7ezLh6wWIF6h76NT16
	TUWz6o/OdRRR5qtGX26SfbxPxDPHIXezFf2yt4cXepvXQkhflwtBgDZBaQX2Zin3x1cric
	uOX6q0jkxexjQOiZ+TdWOL9I6qgRrA0MTbuV8fVELOcPM6qaZv7VsxWodc3v8FObdzWzV1
	D5mVTXKVKlzOLxmMSalVIO9NC50PIi120AWLUn9U/kg5GuwNhctn/C4iA59rJIghlssIvH
	IWdQI2xxs1MYCSkavZDk+RC6mK1ZYUPGklribuB0zSluA0nnpXi8btmrhR3ZlQ==
Date: Mon, 12 Aug 2024 16:39:56 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <20240812163956.xduakibqyzuapfkt@quentin>
References: <20240812063143.3806677-1-hch@lst.de>
 <20240812063143.3806677-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812063143.3806677-3-hch@lst.de>

On Mon, Aug 12, 2024 at 08:31:01AM +0200, Christoph Hellwig wrote:
> diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> index 7e80732cb54708..5efb1e8b4107a9 100644
> --- a/fs/xfs/libxfs/xfs_ag.c
> +++ b/fs/xfs/libxfs/xfs_ag.c
> @@ -46,7 +46,7 @@ xfs_perag_get(
>  	struct xfs_perag	*pag;
>  
>  	rcu_read_lock();
xa_load() already calls rcu_read_lock(). So we can get rid of this I
guess?
> -	pag = radix_tree_lookup(&mp->m_perag_tree, agno);
> -xfs_perag_get_tag(
> -	struct xfs_mount	*mp,
> -	xfs_agnumber_t		first,
> -	unsigned int		tag)
> -{
> -	struct xfs_perag	*pag;
> -	int			found;
> -
> -	rcu_read_lock();
> -	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, first, 1, tag);
> -	if (found <= 0) {
> -		rcu_read_unlock();
> -		return NULL;
> -	}
> -	trace_xfs_perag_get_tag(pag, _RET_IP_);
> -	atomic_inc(&pag->pag_ref);
> -	rcu_read_unlock();
> -	return pag;
> -}
> -
>  /* Get a passive reference to the given perag. */
>  struct xfs_perag *
>  xfs_perag_hold(
> @@ -117,38 +92,13 @@ xfs_perag_grab(
>  	struct xfs_perag	*pag;
>  
>  	rcu_read_lock();
Same here.

