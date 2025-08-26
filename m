Return-Path: <linux-fsdevel+bounces-59168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A38B3563A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3D94E2A35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AF2F6571;
	Tue, 26 Aug 2025 07:59:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B442F531C;
	Tue, 26 Aug 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195165; cv=none; b=cmwe7Otx16Yv3Vwf0nkZWplcMbbZyfou4/5n8IsgejvHo61PlyJY/BGS+JpVYZOsGHQFhdCnS+5b0W0FZySwgOkMfEIcBdWvICZMy73cwjlPsKMd+hQejDs14P25SmdHJMFj7B+TvAxMXUCM5ipIFM2GbyAeH6oD5UrUS4Wvt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195165; c=relaxed/simple;
	bh=FlR6m5XS3lP2HXxJR0QkkxXgb+y3kUqmopQCHSP0tD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2E5noAyuZsydhC1Zx10Osi8Q8sYasCXlUXzf5tSZLsNhr9uuKRLOCAr8l/rk+GjIJP7c4WTStjE8TjHXPCk5Nz3NDUFpApRyJhwydXGZ9Jr1KVXPY45ZbBzVXy5xRCcSWE/zivGJmmNWSm7RvH1fqEBgnz3ChiT+T4VZ0JSOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27D7468AFE; Tue, 26 Aug 2025 09:59:11 +0200 (CEST)
Date: Tue, 26 Aug 2025 09:59:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Askar Safin <safinaskar@zohomail.com>
Cc: hch@lst.de, gregkh@linuxfoundation.org,
	julian.stecklina@cyberus-technology.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, Gao Xiang <hsiangkao@linux.alibaba.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250826075910.GA22903@lst.de>
References: <20250321050114.GC1831@lst.de> <20250825182713.2469206-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825182713.2469206-1-safinaskar@zohomail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 25, 2025 at 09:27:13PM +0300, Askar Safin wrote:
> > We've been trying to kill off initrd in favor of initramfs for about
> > two decades.  I don't think adding new file system support to it is
> > helpful.
> 
> I totally agree.
> 
> What prevents us from removing initrd right now?
> 
> The only reason is lack of volunteers?
> 
> If yes, then may I remove initrd?

Give it a spin and see if anyone shouts.


