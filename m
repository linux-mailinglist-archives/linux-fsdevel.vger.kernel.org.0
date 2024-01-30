Return-Path: <linux-fsdevel+bounces-9588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A12842F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CB61F24E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A47D3F2;
	Tue, 30 Jan 2024 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="f/lTyC7A";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Jz95UDCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA087D3FC;
	Tue, 30 Jan 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651878; cv=none; b=XtabcM7/OvCk1ym9b032rJm8OCPmZ9QNCV+V2n8a0CJNo98IMdE1hKuSxQyK0m6vdhpH7BIf6d4Uribwn4oiiBKpUXoPCvZAOnZT2WAlzE5FsPNH6id42pKivcycvYZs1HDPgxRmha9WKynX9grkr5PIDF/IQEvELtvAxUMKsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651878; c=relaxed/simple;
	bh=LhastNy1vEGEXwl9qsykeN3HvyBhGxId+V1bFptNfuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+GIcRbPx1KAeo294IwOZSEPaVhAtaMkwfS1aiQKRRBhxiVXL5H2M3Un+9mMKeiNZDZT5H11zp14M+IftPaAjDRddM6UJJXXFdObItLlVLRAl9l8NYuyjuJHaubXOgFb+7J1v+YQk4vvvdRLgJCl//G6gg5lPKqrURs2QA1/vyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=f/lTyC7A; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Jz95UDCB; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id A7224C022; Tue, 30 Jan 2024 22:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706651868; bh=3OM4TbWQ6erHco16GZP6eiXbolJmb1FVgvE2iI59oRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/lTyC7AylluE9U/rrb+EqMMb08YeAv56CHHe1zQ15EqWYC2qNjDv9qB8JyKcrcDi
	 qo+Su4xRp1/QH2BIlOO9yb1sQmzrZDBFiJYn22LcRnLm1jWO3hlouD0PgkXU4htvng
	 V7l1OLr86QG6KCKzFLIrWaXrAR79KCo8Etpqnuvwxvi1v2U3X/G02BaOvDgW/Khphr
	 88j5Z5iqSj+/DNp9D0RLw4ZXfMDZbh0/P9qUDcknOvaIPuLk4S+YgxfK7HjqdxrL1r
	 ZUDUsrWqCVK6ONeNFP1mL470dFi7654rmnqSCC8U1IL9GcUlEUOaAVHM+0fIaQlepN
	 Aa6V/YaBN9fGg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1F1A9C009;
	Tue, 30 Jan 2024 22:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706651867; bh=3OM4TbWQ6erHco16GZP6eiXbolJmb1FVgvE2iI59oRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz95UDCBaCc7DNbBv88Y6UtPW8uWNycCk6cHz5RjFY/3zlaTuCtTXG9Rt3/uY0uG5
	 5TNOGUBtkKibEUm+xkwQt/w1KbKcI8teuo9q4z4hcv1gQpDXQu3sPlKtdi4t9NBtrH
	 8hWZlXkK6p3tF+iLckxAh3vygIMPNOTVSuPOqudJjBmw6OiMkqHk5OCcl2WcxvHU/E
	 +GS0FLMkD8Z+632TihN4Q/JR2fW2x351vGu4dw7Hc7cTA4cBIFIXw61BAOcHBYYp8Y
	 U1yfe1icLInyDTUSSeQ9f+RBg8KbXPYx62fbcRiQ1mEjyt+wrKr6hYWqFX34wlPxGo
	 EPGrBHtPIhA8Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c6e1a942;
	Tue, 30 Jan 2024 21:57:38 +0000 (UTC)
Date: Wed, 31 Jan 2024 06:57:23 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered
 write
Message-ID: <Zblww5O_bRvKx36g@codewreck.org>
References: <20240129094924.1221977-1-dhowells@redhat.com>
 <20240129094924.1221977-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129094924.1221977-3-dhowells@redhat.com>

David Howells wrote on Mon, Jan 29, 2024 at 09:49:19AM +0000:
> Fix netfs_unbuffered_write_iter() to return immediately if
> generic_write_checks() returns 0, indicating there's nothing to write.
> Note that netfs_file_write_iter() already does this.
> 
> Also, whilst we're at it, put in checks for the size being zero before we
> even take the locks.  Note that generic_write_checks() can still reduce the
> size to zero, so we still need that check.
> 
> Without this, a warning similar to the following is logged to dmesg:
> 
> 	netfs: Zero-sized write [R=1b6da]
> 
> and the syscall fails with EIO, e.g.:
> 
> 	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> 
> This can be reproduced on 9p by:
> 
> 	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo
> 
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
> Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dominique Martinet <asmadeus@codewreck.org>

Thanks!

Tested-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

