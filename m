Return-Path: <linux-fsdevel+bounces-54618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E68B01A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792C34A580D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99828B4EB;
	Fri, 11 Jul 2025 11:20:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7699288C3D;
	Fri, 11 Jul 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232828; cv=none; b=RBTSYgIh1qMTWApMroO0fBGLy2HPz+E9QRF+I/Il8gKkPDl/EccGEwTbo9lMK51EYsSWSb9nifvkb0/g2PuV1N/AaH2vaTNh0UZh2qV3jQQwlOeG+7ZeKoHFaE1FpOoMd3IyUGld4Pg1RfTrfN0l8CD4ddVfSZawuagRmszPcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232828; c=relaxed/simple;
	bh=wlP3/M2M4/F3Ll9L0tiVoF9qkFIfVU+4huPD1wTAU1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOhI5sQPkyJoG0q/dAzdVkCygCZ+qzo1leXXFqpeua1HJMvOtTPTf7qxgBIyT36M+ArPbKBXBj06zsb2AhhpddR+d/SFx3RDOmz2k/DKw4IB8v5ERph1dsXM2lVIYM2QmaMOiQ+TLla1caqNqtRhbdEPecViv8Wy1p4YoOUpluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EE0668C4E; Fri, 11 Jul 2025 13:20:22 +0200 (CEST)
Date: Fri, 11 Jul 2025 13:20:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: refactor the iomap writeback code v5
Message-ID: <20250711112022.GA16329@lst.de>
References: <20250710133343.399917-1-hch@lst.de> <20250711-arten-randlage-1a867323e2ce@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-arten-randlage-1a867323e2ce@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 11:50:22AM +0200, Christian Brauner wrote:
> On Thu, Jul 10, 2025 at 03:33:24PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this is an alternative approach to the writeback part of the
> > "fuse: use iomap for buffered writes + writeback" series from Joanne.
> > It doesn't try to make the code build without CONFIG_BLOCK yet.
> 
> I'm confused, the last commit in the series makes the code built with
> !CONFIG_BLOCK? So this is ready to go?

It's ready.  That last sentence should have been dropped a few iterations
ago.


