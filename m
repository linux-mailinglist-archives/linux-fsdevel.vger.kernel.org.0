Return-Path: <linux-fsdevel+bounces-52910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CCAE8521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF376189B68C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1A263C91;
	Wed, 25 Jun 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="DhjeCQpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756241DE4E1;
	Wed, 25 Jun 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859295; cv=none; b=SNuYcGgh1XhIz9ZA+NomFvXndh/GWXlyz8Xi/0q99sbG0jPCTwmZl8wY6FcyrR3TmH/vCH5EnRXx5kJo8Jy5NfIzyN6YBPpn3Tp3UO61yT6odPxsABNCJBkPLIEuEb5JhOeiiCz3N5K95te7uAdozd2ITPmfOTTtExMwbpHaM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859295; c=relaxed/simple;
	bh=WoUpDUkQ52ehBV8XR5bPssSjnfa1NUBpYCJH/wmVneA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdJRu4PpA6gLSdcUoaXAyvNAsHo927jpJziC+IeeQjSQpuwNrkVmLs7pgZzui3iA6MlanBCP0JQA8O5mFlaEiz2FXwgLklzJWkhrztdE74Pl2QWWWisq+GPoQi+kdgaV4shI9/yEc6kPprSa9/DS/hLEL6JwtFm91VMxrowDeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=DhjeCQpR; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=aWs4XPxVga8Db+MVfW593X9forR+xNmAeKVqvSTkGfY=; b=DhjeCQpRtERFlWTWARYo1MkdH8
	1o+le+U4JsFue+5IGYTwb7A9+M70w0a2w31MRi56/eWR5dCrrDN8Oxq+qR1KP3MTsB2cr6trDqhTm
	crgSwVWNTd6o0y59rMFIualSjUbNilNcoEsfVRwTYZYE6KhjO1UuWJTkTze6mFRnNCyhpZxVH7IvR
	KkOXFct/rK+o1bg5N79/YEmaiURRxfj2z82dNDHydUg6BhqJp5Q4Rb553pnhCp2NHrR2lYgleLtvR
	N5HosDdtlRsZPGSQXlxAsrXNU2abOdr2P6vmujeeQ/k1XgnlU7CiMn8/Rw8vyWjSOUNh5iK1KT8/K
	T1czNf66OLtlR7cacmrnwBeEIsgtVzNmyUOPMzXj3O3KXqsvVYaHu8hJmT0OtSncG86kMG59bQ2aP
	Uiu79rP1fkxdXB0sTBpxYpBroubXB6QWA22bwAmMSzeSDYVTsANeatGimMNjqp6ZybcRhrHzWXOEQ
	Z2LhlMF1SVHSq/rZmxjj8u1w;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUQTy-00CQN2-0C;
	Wed, 25 Jun 2025 13:48:10 +0000
Message-ID: <cc2483e7-88cd-40d1-92a5-f5040b09b662@samba.org>
Date: Wed, 25 Jun 2025 15:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Fix the smbd_request and smbd_reponse slabs to
 allow usercopy
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1372501.1750858644@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <1372501.1750858644@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 25.06.25 um 15:37 schrieb David Howells:
> The handling of received data in the smbdirect client code involves using
> copy_to_iter() to copy data from the smbd_reponse struct's packet trailer
> to a folioq buffer provided by netfslib that encapsulates a chunk of
> pagecache.
> 
> If, however, CONFIG_HARDENED_USERCOPY=y, this will result in the checks
> then performed in copy_to_iter() oopsing with something like the following:
> 
>   CIFS: Attempting to mount //172.31.9.1/test
>   CIFS: VFS: RDMA transport established
>   usercopy: Kernel memory exposure attempt detected from SLUB object 'smbd_response_0000000091e24ea1' (offset 81, size 63)!
>   ------------[ cut here ]------------
>   kernel BUG at mm/usercopy.c:102!
>   ...
>   RIP: 0010:usercopy_abort+0x6c/0x80
>   ...
>   Call Trace:
>    <TASK>
>    __check_heap_object+0xe3/0x120
>    __check_object_size+0x4dc/0x6d0
>    smbd_recv+0x77f/0xfe0 [cifs]
>    cifs_readv_from_socket+0x276/0x8f0 [cifs]
>    cifs_read_from_socket+0xcd/0x120 [cifs]
>    cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
>    kthread+0x396/0x830
>    ret_from_fork+0x2b8/0x3b0
>    ret_from_fork_asm+0x1a/0x30
> 
> The problem is that the smbd_response slab's packet field isn't marked as
> being permitted for usercopy.
> 
> Fix this by passing parameters to kmem_slab_create() to indicate that
> copy_to_iter() is permitted from the packet region of the smbd_response
> slab objects.
> 
> Further, do the same thing for smbd_request slab objects and their packet
> field.
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Stefan Metzmacher <metze@samba.org>
> Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@samba.org/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smbdirect.c |   21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index ef6bf8d6808d..5915273636ad 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -1476,12 +1476,17 @@ static int allocate_caches_and_workqueue(struct smbd_connection *info)
>   	int rc;
>   
>   	scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
> +	struct kmem_cache_args request_args = {
> +		.align		= __alignof__(struct smbd_request),
> +		.useroffset	= offsetof(struct smbd_request, packet),
> +		.usersize	= sizeof(struct smbdirect_data_transfer),

This looks wrong, the smbdirect_data_transfer header itself
should be written by userspace.

So I guess we don't need this at all.

> +	};
>   	info->request_cache =
>   		kmem_cache_create(
>   			name,
>   			sizeof(struct smbd_request) +
>   				sizeof(struct smbdirect_data_transfer),
> -			0, SLAB_HWCACHE_ALIGN, NULL);
> +			&request_args, SLAB_HWCACHE_ALIGN);
>   	if (!info->request_cache)
>   		return -ENOMEM;
>   
> @@ -1492,12 +1497,16 @@ static int allocate_caches_and_workqueue(struct smbd_connection *info)
>   		goto out1;
>   
>   	scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
> +
> +	struct kmem_cache_args response_args = {
> +		.align		= __alignof__(struct smbd_response),
> +		.useroffset	= offsetof(struct smbd_response, packet),
> +		.usersize	= sp->max_recv_size,

This should be have + sizeof(struct smbdirect_data_transfer) for useroffset
and - sizeof(struct smbdirect_data_transfer) for usersize

As the smbdirect_data_transfer header should not accessed by userspace.

My attempt looks like this:

-               kmem_cache_create(
+               kmem_cache_create_usercopy(
                         name,
                         sizeof(struct smbd_response) +
                                 sp->max_recv_size,
-                       0, SLAB_HWCACHE_ALIGN, NULL);
+                       __alignof__(struct smbd_response),
+                       SLAB_HWCACHE_ALIGN,
+                       /*
+                        * only the payload should be exposed
+                        */
+                       offsetof(struct smbd_response, packet) +
+                                sizeof(struct smbdirect_data_transfer),
+                       sp->max_recv_size -
+                               sizeof(struct smbdirect_data_transfer),
+                       NULL);

But I noticed that kmem_cache_create_usercopy is a legacy wrapper.



