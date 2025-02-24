Return-Path: <linux-fsdevel+bounces-42421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B42A424C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F360E442AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D98218CC1C;
	Mon, 24 Feb 2025 14:45:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1A27701;
	Mon, 24 Feb 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408318; cv=none; b=uiGycJW9k0fHYc9I8bNfE7B8dkJXDTFUmpiVrVZVbu/3Jh+HWKWKHu2HAWlAVRa1/BG5CsSamTUFE05kltWKsVV1SRbgu3FZE8PoCQpl8cvB/cqKQ8Sus/rahGqfF66C14/PX6ANBKqZvB2vUPrSARb5/j3zi5nvHBflktIz+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408318; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbDHVEsu5yXOxaVXe7mA3A6SQeq+aF0OqSzP4p6coDYiZYTg7Gids19nibJ8qtvBggBN8ePoLHtfZC6Ob4QZ9yqgNE5Ru/PXSzrhfCErw0c0hNrwzqu3D0GsvjqTaDLLcyWR240ARWWWHa9NS7QLyhzIdSO/EIX5tybcAtkDup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF75868BFE; Mon, 24 Feb 2025 15:45:10 +0100 (CET)
Date: Mon, 24 Feb 2025 15:45:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>, hch@lst.de,
	willy@infradead.org
Subject: Re: [PATCH v3] mm: Fix error handling in __filemap_get_folio()
 with FGP_NOWAIT
Message-ID: <20250224144510.GA2141@lst.de>
References: <20250224143700.23035-1-raphaelsc@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143700.23035-1-raphaelsc@scylladb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


