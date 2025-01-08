Return-Path: <linux-fsdevel+bounces-38632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F1A052D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 06:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F083A60DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 05:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45AA1A2622;
	Wed,  8 Jan 2025 05:53:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB5199939;
	Wed,  8 Jan 2025 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315594; cv=none; b=EvPTS9jT6mWhhE/vkXUG5DbKB9t/v9RU5m6b0zaEcGl0iQmUcNqro47nCuSzZCgcmaojAK/ySa9TSPHDQAJPNQJqWkwJkQ4j3au2T0T+3qRHPWV2eN2f2O589Ha0KnnyV3RoosYhoBOri6QObLpCFaF3EBy9opfmgf5UFQgc4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315594; c=relaxed/simple;
	bh=ayfLp4M1/Tltvkil26ubMzwnVgEz5YzfjAqBt5vQtIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBWcW7bvDKevakwxqB6LQZ1TivTMKhiLDkKjw3vHQACXHsJL6pJIsJWVxwTKaIbZbwf36BevIBqPRItj669ti5yOtKJ6RLPKpLoU/aQt9dd995iTG4SnhUZO2VddI/MhS0linbPb0fYOQwA4lGyG0vn+Jsn1LWgK+IdUglqeMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46BC868BEB; Wed,  8 Jan 2025 06:53:09 +0100 (CET)
Date: Wed, 8 Jan 2025 06:53:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com,
	jgg@ziepe.ca, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de
Subject: Re: [RFC 3/4] mm: Remove callers of pfn_t functionality
Message-ID: <20250108055309.GD20341@lst.de>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com> <b5b3b567ce2d1df7186ad79bcda7cec6e82f2a1f.1736299058.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b3b567ce2d1df7186ad79bcda7cec6e82f2a1f.1736299058.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 12:18:47PM +1100, Alistair Popple wrote:
> All PFN_* pfn_t flags have been removed. Therefore there is no longer
> a need for the pfn_t type and all uses can be replaced with normal
> pfns.

Looks good in general:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Would be nice if you'd fix up the created overly long line everywhere
and not just in a few places, though.

