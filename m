Return-Path: <linux-fsdevel+bounces-71290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9BCBC974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 326133011FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD26326D77;
	Mon, 15 Dec 2025 06:00:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555926F2BD;
	Mon, 15 Dec 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778423; cv=none; b=Edt3yijprroQ9Bu/EP8Tdc1FcV1oRUeLf2wuzkJ78ZA0Qpsgc5pf0Z6i6cTDBze/Ak0d8Hgh17EJxf3zT6ctSGFYeOGy9xQz/fv3lAwotyphoABpaPH0GdRPTkPoPRf/vbZHvOFwWcDN+SeUzSOUvyXRxN635O4tscjNwWW7tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778423; c=relaxed/simple;
	bh=crb2AzElbnJVddrzCJzgmyQbMlL6OQcZxrs1Wk9JQNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opJf55ZEOw2y4zbjevPlY86SqRjJHhPjUy640EPTUJ87RutFra06e2VfpFg/9vXy56lpN6AbuiJ5vkx663cf4QRjIWwyDcVzp+jF44EvH6sIxBIhjNdpbtfVvZ7GvX0GvSlhRUrREXGtcDdafRN09YNre9jBsIUmBPz2YOUWLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50433227A87; Mon, 15 Dec 2025 07:00:17 +0100 (CET)
Date: Mon, 15 Dec 2025 07:00:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/9] block: merge bio_split_rw_at into bio_split_io_at
Message-ID: <20251215060016.GA31097@lst.de>
References: <20251210152343.3666103-1-hch@lst.de> <20251210152343.3666103-4-hch@lst.de> <20251213003108.GA2696@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213003108.GA2696@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 12, 2025 at 04:31:08PM -0800, Eric Biggers wrote:
> So this commit actually removes the alignment check for bv_len and
> leaves just the one for bv_offset.  Does that make sense?  The commit
> message doesn't really explain the actual change.

This turned out to be broken and a wrong idea, I've dropped it entirely.


