Return-Path: <linux-fsdevel+bounces-4280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017377FE352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C0DB20F77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F847A58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="K3EUNDrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB4AB6;
	Wed, 29 Nov 2023 14:20:15 -0800 (PST)
Message-ID: <03c9be922f4aa266fa74f44c21027e50@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701296414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAhLSQiYSgh1S91e8MfKxtWrN+vewtZutl2e/zqiHg4=;
	b=K3EUNDrhp73skkmFRZ6csfp3ZsSDmFJFVXdpLP4zLVF0AX/7rtH804wmQhaw1tjeztGY+P
	IM4lOStnXpMVP0xW23/qVdazWC4x0EeKmhNEMKWWyVWsTymTTdEXN4hc13lwdJCSwh4HfM
	vc6kQzQsnsTQUWiH+WgJLiavpUrzp1OxaM9+ADd5v4CaUu2GmfPftFPcf7CQAloXj+bBA+
	lnM/WKxKtnUFhJ5R7+g5T8Kq/kzh6LzTsnDb3bWidI9cU8aeSggKXRxvlPwL/k/LEj2W1z
	FRcguIsxDgxsLokR3CQS06n7B+XCuOh8zsJQ9nhxePRtWgDIe42XqkBUmF7Itw==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1701296414; a=rsa-sha256;
	cv=none;
	b=TfelgFgAT+x+A2MOAp/U96xwT6RnZINU39mv8glRyDV/HSGHywYJx3vL7cdObp3BzzIqi5
	Tih8nUHbnPiilODl3lPXmhLSioWajZ1U+t6T26wqrWDPK7Tlc7yKVIjbnV/vYVuoUITXKu
	1i0yXYOmPNU+OXGIMgeVhc+R9G2osiYshjnUqGi0F2dM0F8m0E5fDcSKz635J3UcwB4P5v
	6dEKQCGRF+Y6CJ2seWD7fsCFCi42R60WSxmx6ARDro3q65WXKNWytyXd933nXArvG9Xbhv
	F/7uK66st1/SJo4lTk9MYIKrgjctd1/2NLzP+Rr+28dKaKy8yD4XGFixu+iAeA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701296414; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAhLSQiYSgh1S91e8MfKxtWrN+vewtZutl2e/zqiHg4=;
	b=rkx/YODpkyl84yTIbM4EqxSwYg6PJmh5s8cOAlI3GoT6rx4TYFIwi0fso/k3bh5H4Jt4sf
	NF7Fgp+qqv1/E0R7//VRN1GZRIzNhCclsWuzbnfEeKRMhf18EaOI+frRyZd3c4UXBQY2Oy
	6PCOaF5H0cRjZN9Bd01wiZ3GNvqSmHRYb6m5tljrfCRx+iMlog2JkfJnZY/bfEETH/17SM
	Z8Qd5jqLEpGeQJV0pbQPFtpMrq3GWNfTk+o+9hf6yl1I8baG8Xc3IwEmluw+7MlzeGz3V9
	sfLOt1WnMKVZdUCcYrOhZDhNaBi9P1k3KQXw5+11R4Ao6bG6zDYnj1MapBJ7ZQ==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>, Shyam Prasad N
 <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size
 after EOF moved
In-Reply-To: <20231129165619.2339490-3-dhowells@redhat.com>
References: <20231129165619.2339490-1-dhowells@redhat.com>
 <20231129165619.2339490-3-dhowells@redhat.com>
Date: Wed, 29 Nov 2023 19:20:10 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Fix the cifs filesystem implementations of FALLOC_FL_INSERT_RANGE, in
> smb3_insert_range(), to set i_size after extending the file on the server
> and before we do the copy to open the gap (as we don't clean up the EOF
> marker if the copy fails).
>
> Fixes: 7fe6fe95b936 ("cifs: add FALLOC_FL_INSERT_RANGE support")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/smb/client/smb2ops.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks good,

Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>

