Return-Path: <linux-fsdevel+bounces-39434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AEAA141E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B401699AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF28A22E409;
	Thu, 16 Jan 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="foxODhDy";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="C1Qt9+hQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3415530B;
	Thu, 16 Jan 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053743; cv=none; b=rkCrMD5kDFROpS2Unx32lKgz/EsychJogQHjbVf45dMSHKRNb2WirRytFM1+xM3rJG2gakrNTmVfXxgNeAg0vlNJaR5qhT3KdTdeLP9U/2m3RaSP+OK9OzAIBUv/KNnFWMp7+aAAEqDr7EW3VjuF+/oYRBAgkOycaltztd0HKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053743; c=relaxed/simple;
	bh=sBFuJzl+a7h7iWApaLJJn6tGrI5x8B2qaTEM0xOvXNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEZ7m6+KyYyyzRfCkOKjHpf2dMFCZfxlB/HZO88WLumUaYC7+XJPtQiXXosdgY1W6+mZPZdt4eM2AS0BRgwIyYEo/T3xQ5LonToGMJlI7KSdaqJZQjoQgM0+hKE12Tpinhn0JoKU5alNqcCkJSbf4WlP84wSJFdaDuYFptBEDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=foxODhDy; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=C1Qt9+hQ; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737053741;
	bh=sBFuJzl+a7h7iWApaLJJn6tGrI5x8B2qaTEM0xOvXNo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=foxODhDysHKHOw11wL/Tt0I46E/z4CRSBn14fj23ngmBAE9xMbEmTmAYJs50aPADH
	 DhiX1yFPqQGJog/kngXUcXP26zQCA16pcvmnuufFB2LJp9rkfG/2jvPpHl1IFO00XU
	 lN41uHOEfTWrTVU/v0FrWbKWMm5uig55fvN5yq80=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0B5BC128708E;
	Thu, 16 Jan 2025 13:55:41 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id bNuGOIYvkWuR; Thu, 16 Jan 2025 13:55:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737053740;
	bh=sBFuJzl+a7h7iWApaLJJn6tGrI5x8B2qaTEM0xOvXNo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=C1Qt9+hQ3rJDf02j1IFDqFG9EmeUaoOjmnKQQZAT1PdpETZ91OvNVLVhYZHz4Bntj
	 FjfjGop8BI1CqlvFqUoO2n0egpUOEC2VIS5tg6aGpr2+vgWpYobwMpYfty/9w40NQR
	 /eLfLJMYOMXBDpUenIuZVcUo2cIH9BhEu6XUcmIo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4C5E61287074;
	Thu, 16 Jan 2025 13:55:40 -0500 (EST)
Message-ID: <bfe634a92085b4aaaf91ad0081334a158d82bfab.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 5/6] efivarfs: remove unused efivarfs_list
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Thu, 16 Jan 2025 13:55:39 -0500
In-Reply-To: <20250116184223.GJ1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-6-James.Bottomley@HansenPartnership.com>
	 <20250116184223.GJ1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-01-16 at 18:42 +0000, Al Viro wrote:
> On Mon, Jan 06, 2025 at 06:35:24PM -0800, James Bottomley wrote:
> > Remove all function helpers and mentions of the efivarfs_list now
> > that all consumers of the list have been removed and entry
> > management goes exclusively through the inode.
> 
> BTW, do we need efivarfs_callback() separation from efivar_init()?
> As minimum, what's the point of callback argument?

This one's simply historical reasons.  The original code had the
callback so for ease of reviewing it seemed easier to keep it.

Regards,

James


