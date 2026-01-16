Return-Path: <linux-fsdevel+bounces-74167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 286EBD333D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFFC83011990
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493B33A9FE;
	Fri, 16 Jan 2026 15:38:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464533A9EA;
	Fri, 16 Jan 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577915; cv=none; b=bv0wW01sIxiR1OgSu6wPNKhlnJJD5Y0ayLswmnnGpRu5XTdKHMQVTZ4yhOA+Y6iwpQoDVCl49p6KInmwiOcbB5p/cE0PuT0or3ciPZU+yB0ZKljNuNx21A/yN2YdR3H+8KGc+4Iwyt4qRHRpX7RPJliGSHK0IkJ/xUPUBOcNJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577915; c=relaxed/simple;
	bh=Nzs6x7QPR5GNcCNExIMK/JOS3Pv5Lx31mu3s0iXcI9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMSrNXr/ytaL9WqZRJQs6Qkdkqm3zVvoxzV52x66zYqVBRpkAZtqcZC7AM7uwMFSMx1iitFR3IId1u0ITizN353IqxS++V9zV3ctJa9K+NkwZy4GIiFqjF3W+YLMGwbkDKuJhowdaY1cme8NF2mZDEcvUadaCKaRTTUucylk2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43D60227AAE; Fri, 16 Jan 2026 16:38:30 +0100 (CET)
Date: Fri, 16 Jan 2026 16:38:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
Message-ID: <20260116153829.GB21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-3-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116095550.627082-3-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +#if defined(CONFIG_EROFS_FS_ONDEMAND)

Normally this would just use #ifdef.


