Return-Path: <linux-fsdevel+bounces-4282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E97FE355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E06B2103C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828B47A63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="WhHz31W2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3C93;
	Wed, 29 Nov 2023 14:28:28 -0800 (PST)
Message-ID: <9704ab96ba04eb3591a62ef5e6a97af6@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701296903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkiCn+ZBHH24INxGvzouPbpLPO6ebH5aGUWUB6yyWcg=;
	b=WhHz31W2aBR0XLcDuNNDfLgL8lrKKa+XEVQeMWaC4/K5MF1HvkxE1V9Ng1FIy59+J5W5/7
	4dsQVdnXif1y3A9s97/osj7MxBpFEuo7S5UdY/GVZoBl0MlhcKDUDXww8NK7/dwbx3OwZS
	oaLLaBMdluTq+jFOliLSl2aYq4KlCs/e+OWXIov3nCTqEqMq6/QVjJN7neRKbWpKW2SxjV
	q+BhPH1cEOaoPceVOpszjmkjcQIwvvgfshb3mMhe+seX1NADnS1n+LtJBVFoNNBrTtpC9d
	WqH4GSRQQfMeZenLRpBNbYYbYo/e8UYIS6evQ2mK8Ms/7bVwWjRYuaJq1zMQdA==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1701296903; a=rsa-sha256;
	cv=none;
	b=TqhJuXPmxilTH3NSJNy68x8csCJmocB2wH1vhLgGtT+pDWSu+zBtqkpG96de9EKPax/HgQ
	h/mt2yZGTqb0RaIcHr0oOSUVtgZaNbycv7CtgrALOe/wAWlm8Up3rYzISLXndrlCgSKIbl
	+DjkmFRRJg+KLPxpaFcwa4W855Mu7ImV/ZsU9EjKseMp+GYNWk0HLAB407EOVMedPwI4iR
	FBhD3Ty2n+MJMul8J/PBXHoUnMiDpR7MHzSuaxnkFWwr4uNP5UnSn7jf7Sy8ClUf7TrG9g
	MixPKAJxb5PNHUP7QfcO6coHI4OJ8shZa6hfLxoHbDLfOPYDUQfswbDPpDQs7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701296903; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkiCn+ZBHH24INxGvzouPbpLPO6ebH5aGUWUB6yyWcg=;
	b=nW4EEQnu49ugaefARUGs4lgqy0B/8qXJLClwgOd8XECMuRCq+fQWS/Av5ALm6mjeRd/oKi
	fA9FmNPzC0w8P3s1aKE+rKbcrTbeSy89zv36AReJpTwKZw/Im/BfVuQlR91zJB5U6H1am4
	ec7vW66HoBI6cHxNb965/txrjmGCAiYZtYwMpML3itbIslH/zs964kA9bsVjHJDOUxw3fP
	whmLm2vU66EmkDwnuFxisot//UtMEmaFd4G5akbWYhm78/RkdnYIVh+wVmkNHeLRHNRtL+
	q+Sx9+Osjl3wCg+A665fSI6SctqtOXD/pzglZFF3VsTtRzhasb0cbU7j3K+YqQ==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>, Shyam Prasad N
 <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] cifs: Fix flushing, invalidation and file size with
 copy_file_range()
In-Reply-To: <20231129165619.2339490-4-dhowells@redhat.com>
References: <20231129165619.2339490-1-dhowells@redhat.com>
 <20231129165619.2339490-4-dhowells@redhat.com>
Date: Wed, 29 Nov 2023 19:28:19 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Fix a number of issues in the cifs filesystem implementation of the
> copy_file_range() syscall in cifs_file_copychunk_range().
>
> Firstly, the invalidation of the destination range is handled incorrectly:
> We shouldn't just invalidate the whole file as dirty data in the file may
> get lost and we can't just call truncate_inode_pages_range() to invalidate
> the destination range as that will erase parts of a partial folio at each
> end whilst invalidating and discarding all the folios in the middle.  We
> need to force all the folios covering the range to be reloaded, but we
> mustn't lose dirty data in them that's not in the destination range.
>
> Further, we shouldn't simply round out the range to PAGE_SIZE at each end
> as cifs should move to support multipage folios.
>
> Secondly, there's an issue whereby a write may have extended the file
> locally, but not have been written back yet.  This can leaves the local
> idea of the EOF at a later point than the server's EOF.  If a copy request
> is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
> (which gets translated to -EIO locally) if the copy source extends past the
> server's EOF.
>
> Fix this by:
>
>  (0) Flush the source region (already done).  The flush does nothing and
>      the EOF isn't moved if the source region has no dirty data.
>
>  (1) Move the EOF to the end of the source region if it isn't already at
>      least at this point.
>
>      [!] Rather than moving the EOF, it might be better to split the copy
>      range into a part to be copied and a part to be cleared with
>      FSCTL_SET_ZERO_DATA.
>
>  (2) Find the folio (if present) at each end of the range, flushing it and
>      increasing the region-to-be-invalidated to cover those in their
>      entirety.
>
>  (3) Fully discard all the folios covering the range as we want them to be
>      reloaded.
>
>  (4) Then perform the copy.
>
> Thirdly, set i_size after doing the copychunk_range operation as this value
> may be used by various things internally.  stat() hides the issue because
> setting ->time to 0 causes cifs_getatr() to revalidate the attributes.
>
> These were causing the generic/075 xfstest to fail.
>
> Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/smb/client/cifsfs.c | 80 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)

Looks good,

Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>

