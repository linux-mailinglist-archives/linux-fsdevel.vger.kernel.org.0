Return-Path: <linux-fsdevel+bounces-69047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01FEC6CD18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 93D2A2D2CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E203101BA;
	Wed, 19 Nov 2025 05:43:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128E234964
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531011; cv=none; b=G4+IwRRV4mzLXslhuSrzuLQPHwLpAy7zyP0ug+5nYt4Ysg/G4kuYXq3ZJPVPcx+ze1HLLz/WsPN5r1fHhXVLVaB4kIaXv4VsDsmfxMgZw/j2qF4JRPCxQascvoDD4FroJLa9C0RzDhlWWG0RnlIwNyJOaUssJMsbIo/4IjanXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531011; c=relaxed/simple;
	bh=qXvNYIpcfaCaNJ4lzIL/F0kFd7bwQPoDTDqxZxtgt6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euujvQ33+k6D8qjQyzP84HgeShvV4Xsr6sOkCxuR64nd1ij0wu1Ze45BO8v+7p313BEzqaI64IgAyXdmcjN7bEwjZN6Ry8PXjYuLwZilGD7GLPARP9QnyX2qrLH/Z7Ls+psrvIKU0aUN7IPthtNWNZ0YgB2CRrjQcXhQ03Vo2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A76468B05; Wed, 19 Nov 2025 06:43:26 +0100 (CET)
Date: Wed, 19 Nov 2025 06:43:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119054325.GB19925@lst.de>
References: <20251118070941.2368011-1-hch@lst.de> <20251119003004.GK2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119003004.GK2441659@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 12:30:04AM +0000, Al Viro wrote:
> On Tue, Nov 18, 2025 at 08:09:41AM +0100, Christoph Hellwig wrote:
> > No modular users, nor should there be any for a dispatcher like this.
> 
> ... and AFAICS there never had been any, so it shouldn't have been
> exported in the first place.

Good question.  It looks like Andrey added them when moving to the
code to a new file despite that commit claiming to be pure refactoring.

