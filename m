Return-Path: <linux-fsdevel+bounces-48022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6487AA8BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 07:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11D2189105A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1D1B043A;
	Mon,  5 May 2025 05:43:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3562EBE;
	Mon,  5 May 2025 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423798; cv=none; b=FOR79X5rcKYLdGWQhWkky3HrLNWfFOrQ8SOuZqJFkS028idmRm/jm8HL2xUx1b5RDU7C4spNsoPCuhsDXhwOYGABuhOlVqqRgl55G1CzRjyhjADTbqdEuFiH1qdoTckk3DoIheo1ItRz/JLwI5fwUgIoHioS87fXnDHjDmT7r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423798; c=relaxed/simple;
	bh=8mdfrRlSo/Nf/5ODSUaylVcC9UZMLnKpHzlArdqV2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okvq++g2/q0T5MCww8gGutkicIVTIPU9Xa2OwDDP5uRL1sNqOdGUqTMXIOIQUQyCU+TMwRNvvL/X4FZoLVDsS4domYu57P25hpPgGVVZ8s089aTGg2cJEmyHgA12l7fs+cl2yLEVRj2+PhsOFrGmYPSWJVQO6WqyQvIlGq51V/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D6E8B68BEB; Mon,  5 May 2025 07:43:10 +0200 (CEST)
Date: Mon, 5 May 2025 07:43:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 06/16] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250505054310.GB20925@lst.de>
References: <20250504085923.1895402-1-john.g.garry@oracle.com> <20250504085923.1895402-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504085923.1895402-7-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I think this subject line here is left from an earlier version and
doesn't quite seem to summarize what this patch is doing now?

> +extern int xfs_configure_buftarg(struct xfs_buftarg *, unsigned int);

Please drop the extern and spell out the parameter name while you're at
it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

