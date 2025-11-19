Return-Path: <linux-fsdevel+bounces-69056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EAC6D8CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7F2A82D6E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA2E330335;
	Wed, 19 Nov 2025 09:01:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04C32E72A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542865; cv=none; b=sjejzPg2t1Wo2/ymZz7ExtCUf5ONdP0FfM9Bs6Q8ts6JhO4YQChXtzveVklQhY81Rj6jt9zDsZP3bca/jPh+E0nz79gztqaCw3BXcuIJk6lVAo6xeBprJ/hSfDL1aWL3FlHYrOccB30KscHpRYDNuWLZ4BfvkX/90ALuXNvyqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542865; c=relaxed/simple;
	bh=Q9mjZvm6bk5XNA0xh9n+9vsYyCIHmC6kJTw6Jyt8Tv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwFu4/9GG7SaoqR38Lmnzq7nDxPELzaMIiCHrFmAqX3HEbnxRa6lrW+O75Cjn3o6wlfuEOf3haejP58+iIyVf/zZSkbdH9CxFgIM8C/CEAZ7o9wzoNVWjxWnIYiw7YszUZ2AYrldWCzy5tka8ssmHRKh5De+yIoLJ5hm9b11pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67F056732A; Wed, 19 Nov 2025 10:01:00 +0100 (CET)
Date: Wed, 19 Nov 2025 10:01:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119090100.GB24598@lst.de>
References: <20251118070941.2368011-1-hch@lst.de> <20251119-kampagne-baumhaus-275e14d62e2f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-kampagne-baumhaus-275e14d62e2f@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 09:42:53AM +0100, Christian Brauner wrote:
> On Tue, 18 Nov 2025 08:09:41 +0100, Christoph Hellwig wrote:
> > No modular users, nor should there be any for a dispatcher like this.
> > 
> > 

I was going to send a patch doing all the exports in file_attr.c in one
go.  I can do that incrementally, but I think it would be a tad
cleaner.


