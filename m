Return-Path: <linux-fsdevel+bounces-38630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71252A052C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 06:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95B73A60B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE61A2545;
	Wed,  8 Jan 2025 05:51:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057E153836;
	Wed,  8 Jan 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315495; cv=none; b=HHcdwnzrSv6pAykw4leoL/7DgJVGpDSHsUPdlAzgrt350fyrGuyNZ4urI/d9vLDMSKBQ/GYVvijIWw+HyITJB6YojR+V7p6vgg2V8t33RKGPE6m2XuFbWWVzX4pBZZvTtgrCI14o7UKYlFvTGrfO9XrmsJMKX5ETcM/3CJMnelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315495; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDkL27hqYg9xAH43HhWhP/NgnfhoY7ZejCzHSEZADOWJhaFn+1out9bnOogD+fuPjJCtNUphtVhmx4YZA3++ky+y5bwy57phTs0tuuUv7y34YxXxutggjqAMvEGAFc9ttXBkqDrSxhMN2OW8qkqqGoyJY8TKrq5T4QcUZYrA5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A0DC68BEB; Wed,  8 Jan 2025 06:51:27 +0100 (CET)
Date: Wed, 8 Jan 2025 06:51:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com,
	jgg@ziepe.ca, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de
Subject: Re: [RFC 1/4] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Message-ID: <20250108055127.GB20341@lst.de>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com> <106d22a58b4971a2e41ca65d9ceb30ed81fcf727.1736299058.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106d22a58b4971a2e41ca65d9ceb30ed81fcf727.1736299058.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


