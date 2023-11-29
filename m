Return-Path: <linux-fsdevel+bounces-4279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B357FE351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606B6282254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877447A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="qygnQJKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4010A3;
	Wed, 29 Nov 2023 14:19:55 -0800 (PST)
Message-ID: <7ccf5315d932b5a628d952af6e8c1460@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701296393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTq2o1qJW8tbvbraXclVNrWBgCIFYure9jsTVRDRcDo=;
	b=qygnQJKXqycrwPfZX91uR9Q6V/Ivfas22DnJzN2ItfbHx5xxCJ5a0iWB7lQeXA+Dl/A2lJ
	Gj8KtlF0dgOej/nHI65XhRqvPTe8EDgXX8ewzPgT4MBliIRVThyFs4zyurPtBqvUTwLDRu
	m6RB9DtXed0Ssm4lVQz6soOdKs0GpdlTKYGugkqc19Grj0iJP8JRdtc/MQVRvwlw39ZXfO
	dSV3D//ioJT3i42zKUp8ZseHyo0g+ajFaBpe3beKsrMj3BRp1QpXbRqmwPkvq5k7FQmxvC
	PonQ/W6O6W50VlOn+0uodf8sbOA3HILLiJddtoz2YqFAqgAVEbiM3xz6TtbxoQ==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1701296393; a=rsa-sha256;
	cv=none;
	b=qoN1/zv1ZjR6Oq+WpjypKc6Bywff/JRtgCKyoXpoq6grWDMI94EnLZwYPTt1AyK6C9oBZN
	ei794EyexFOk79ynA7HH0ySRsGhpL5LjxxP9N9VIfAofw9faQUOmdvT//Pchmd1rvIPFQm
	D33tSbzQHZSUVYPi2IMbQuKuGNXS5yRbGNEzjjrs3kJgDo2j9CkQVcYDccJG/77eOkjF8c
	02ATCf3M8MQ1rk/r7MpJpcDTJcLS9gYklHgzEfVJ6LqAjfrRwaxVt8qAIF92W0A9XgmUUK
	uEic364znqXhynIhTi2j6o9L6ywFzXyOlptSsA8tAVoi/4ZW6uR67y7sSh1Ovw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701296393; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTq2o1qJW8tbvbraXclVNrWBgCIFYure9jsTVRDRcDo=;
	b=TWEQeMx1iL6K/3Ht6TjjtG3hIRLhcU7WtrajdKctWxK4EtKcNNgTfWuQQRBCwgFMKWxLNx
	EkcjiHUBdq+pPfcdAX/+fJy8jF+aovg/LBaKPn0UzFPEysx5/E4FL0CDOwrmuNTLewzALo
	V4ceKGNI3Xgsut4S/xJTYGZig0ckCF8e1mh6+YaU8xP/x0SQRjoayfOeUIyGT9kzUKn479
	hBF7jDOLQVzak2kqVBOkh592mZMUQnA8mAkPXy9D3pFQJLHdByiKoOAmXJ2PzqY7h8PkSX
	0pFsdJ9PuLb+44nBf/9DUN0RhZaLdo+bL/fE0owcw55AkmHCyjHMTE/flxNDmA==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>, Shyam Prasad N
 <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if
 EOF moved
In-Reply-To: <20231129165619.2339490-2-dhowells@redhat.com>
References: <20231129165619.2339490-1-dhowells@redhat.com>
 <20231129165619.2339490-2-dhowells@redhat.com>
Date: Wed, 29 Nov 2023 19:19:49 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> @@ -3307,6 +3307,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
>  	struct inode *inode = file_inode(file);
>  	struct cifsInodeInfo *cifsi = CIFS_I(inode);
>  	struct cifsFileInfo *cfile = file->private_data;
> +	unsigned long long new_size;
>  	long rc;
>  	unsigned int xid;
>  	__le64 eof;
> @@ -3337,10 +3338,15 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
>  	/*
>  	 * do we also need to change the size of the file?
>  	 */

Perhaps remove the comment above as we're now updating the inode size?

> -	if (keep_size == false && i_size_read(inode) < offset + len) {
> -		eof = cpu_to_le64(offset + len);
> +	new_size = offset + len;
> +	if (keep_size == false && (unsigned long long)i_size_read(inode) < new_size) {
> +		eof = cpu_to_le64(new_size);
>  		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
>  				  cfile->fid.volatile_fid, cfile->pid, &eof);
> +		if (rc >= 0) {
> +			truncate_setsize(inode, new_size);
> +			fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
> +		}
>  	}
>  
>   zero_range_exit:

Looks good,

Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>

