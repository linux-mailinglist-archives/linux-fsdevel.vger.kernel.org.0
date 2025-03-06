Return-Path: <linux-fsdevel+bounces-43317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92750A542FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 07:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB61A16CDE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C421A238E;
	Thu,  6 Mar 2025 06:44:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-16.prod.sxb1.secureserver.net (sxb1plsmtpa01-16.prod.sxb1.secureserver.net [188.121.53.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F617583
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243491; cv=none; b=gJqhIbFDbvirZsh7eTlLQz2PmI5W8DzMOIQ1/L9lLysS7SNQ+Cunfk2otLHLOXHZ6UNb2/Ll43EUTyAI5afxSs8iP4+uIw9Mll2HYJMmC9EiAxK/XnKglcPI/fPhzJyueH6ao07523fHbbp6sDuJb1L0a9vmmntGLvSOn7/dshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243491; c=relaxed/simple;
	bh=NMJ+osfRqJ9Ko9bb/igBwfRfaWtfPAvOFBDl/Gzv7Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fPqEbd61BV5JAhNxhjxUjAcEaMK38ILSJ/mbOlTy4xodSAO4avTx09QeEsJPBtD6eMpxxYhjJbwWibhi8PNl44fES4pcvedwK4gLyxcVZpk9N8vnkHM1ZNS5bbZEiMdnAgQu/pXKJoHgm3WAZ28pDDk7v1/NsxuY0x2aA6pOAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id q4fqtVR7PjJ0Pq4frtqiTF; Wed, 05 Mar 2025 23:25:40 -0700
X-CMAE-Analysis: v=2.4 cv=KIugDEFo c=1 sm=1 tr=0 ts=67c93fe4
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=Enu5dpqZAAAA:20 a=SzC7U3xsAAAA:20 a=huSjWlhLAAAA:20
 a=jw-U9q5TAAAA:20 a=gWg2Z6pjBftwJRKaxEsA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <f572d546-95cd-427a-8284-b88a155b53ba@squashfs.org.uk>
Date: Thu, 6 Mar 2025 06:25:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Kernel Bug] BUG: unable to handle kernel paging request in
 squashfs_cache_delete
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>,
 syzkaller <syzkaller@googlegroups.com>, Jan Kara <jack@suse.cz>,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org
References: <CALf2hKvaq8B4u5yfrE+BYt7aNguao99mfWxHngA+=o5hwzjdOg@mail.gmail.com>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CALf2hKvaq8B4u5yfrE+BYt7aNguao99mfWxHngA+=o5hwzjdOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOsNQaSfJvMH5L/0CmaL8yTg3qfms+kV6QcpqpD3ENBBH+VVHme/0ILhZd6/Qq+guRjyGAVIm/2vKvglCkI6LEOdlw+4a09X3fGPtBC79ny0xEDgDwlL
 CUzKtsrWdQfYbrOEc2P9AJMhL3VWXHD4F84bS6ihlKbaIT0BX0TkzYmjWHaZlV0ZY/wN4u0ER4r4z21v98/aI67joCsqzBHD0xWqlRwuJq5cDLkkb+2hXgJc
 /sbTvfLRwpL/nvIkbmJRjk6UhFFqQp3HyXZdKAq6uIOee5OKzpbTD4BjXX79wBvyyTbzdVu1qGisALyq7Wcvq5CF24Bj8cua7lfebOYx8lpkVXOEPCaU8YFE
 7Ji8kqHfOPYq/zSS2Xe1YkLXOiNi8A==



On 04/03/2025 07:50, Zhiyu Zhang wrote:
> Dear Developers and Maintainers,
> 
> We would like to report a Linux kernel bug titled "BUG: unable to
> handle kernel paging request in squashfs_cache_delete" on
> Linux-6.14-rc2, we also reproduce the PoC on the latest 6.14-rc5. Here
> are the relevant attachments:
> 
> kernel config: https://drive.google.com/file/d/1s4fpvYKGRUbOcQsv5XZpzU1SVBvqKDZv/view?usp=sharing
> report: https://drive.google.com/file/d/1nnlAc-_09lCZIL9gSh4llW5jgFIQ2jfO/view?usp=sharing
> syz reproducer:
> https://drive.google.com/file/d/13M44vrewnPesGubj5JspZdpnmsPgrFdG/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/11JZv7wQ7OInDdId6625EyfFw2jSs4UJc/view?usp=sharing
> 
> 
> I assume this vulnerability may be caused by the missing check for
> error pointer *cache in fs/squashfs/cache.c:squashfs_cache_delete.
> When the kernel fail to mount a squashfs (e.g., out of memory), the
> fs/squashfs/super.c:317:squashfs_cache_init will return an error
> pointer (e.g., -ENOMEM) and goto failed_mount. However,
> squashfs_cache_delete only checks if cache is NULL, resulting further
> deference of invalid cache->entries and cache->pages and crash the
> kernel.
> 
> --- fs/squashfs/cache.c
> +++ fs/squashfs/cache.c
> @@ -198,6 +198,8 @@
>   {
>          int i, j;
> +        cache = IS_ERR(cache) ? NULL : cache;
> +
>          if (cache == NULL)
>                  return;
> 
> I tried the patch above, which can avoid kernel panic after SQUASHFS
> error. However, I am not sure if my analysis and patch are
> appropriate. Could you check this issue. With the verification, I
> would like to submit a patch.
> 
> Wish you a nice day!
> 

My mistake.  Please submit a patch.

I would suggest a better fix would be to alter the if (cache == NULL) check to become

if (IS_ERR(cache) || cache == NULL)
	return;

Also please add the following line which identifies the patch that
introduced the error.

Fixes: 49ff29240ebb ("squashfs: make squashfs_cache_init() return ERR_PTR(-ENOMEM)")

Thanks

Phillip


