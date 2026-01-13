Return-Path: <linux-fsdevel+bounces-73376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F2D1735B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8A61300BBEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C23793B1;
	Tue, 13 Jan 2026 08:09:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C535C1BA;
	Tue, 13 Jan 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291797; cv=none; b=VUEj7QN+r+0i7WA4xZ+Ks99HdCdaXCp8pj9pNCWls7CFxxiAyABQojvRP4K11PY3NlKcF/8FUoGyH7QYGFyrfZiMC6DfYOmYNfRZCWfFCTFOUuRM/Lq5cPBvx8l83VgleWm57o9lvoLH4SLhPP9gPBi9W14vfT5PkSDBfbGfGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291797; c=relaxed/simple;
	bh=IRoiLNoPO2ubmJAqEOYZiunvMTMRSIUYHUnc2Zc+eaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfKku6puJ2jKFWrcNCfOpX259XN7HQdN18XLn0LN0DAbWvkkLQBGG/69JQgOpRFOrebgi/+XAcZFHlWA2r0fWwJQCcmVMWog2Um9SYyXOr0BQqHAU2YYSMHe08/CBbig8pGQOd/IiIEZ0VGrVZU/hbI/U8HABVyRWbrfOcfk1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 207A1227AA8; Tue, 13 Jan 2026 09:09:53 +0100 (CET)
Date: Tue, 13 Jan 2026 09:09:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Darrick J. Wong" <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 1/22] fsverity: report validation errors back to the
 filesystem
Message-ID: <20260113080952.GA30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <dx6z2f5lrnevosqoqr4a2aa5bmxldmishn6ln22hvdkuxxmjqa@rddd4kri6bce> <20260113012911.GU15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113012911.GU15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 05:29:11PM -0800, Darrick J. Wong wrote:
> > To: "Darrick J. Wong" <aalbersh@redhat.com>
> 
> Say    ^^^^^^^ what?

Heh.  Looks like somehow your patches being resent all got messed up.


