Return-Path: <linux-fsdevel+bounces-52956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D6AE8B70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F9E174931
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B72D1F59;
	Wed, 25 Jun 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="rQXRw887"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502D3074AC;
	Wed, 25 Jun 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872210; cv=none; b=vGHxIaKiaCytOP+daMzBEdT25W/HzpFC3/8b1QlnSvFeltV6RuyfEOyvMMur7qxrc+o0Bvf9zX1A78QrXmy90BMVbChf7kGojSjIlGGbOvxJOQpDTrnbIGLHjliA5zjPkxOM/1GU6q3ITORW3Ra4ykSkbhwIOGrYRt0EY+J45kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872210; c=relaxed/simple;
	bh=BEDzEKt9JSATmJp5cnYe1NQYMywsbvi4ikfwEf/X8gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U01+g88ava7Jw7cF4NHIMhmBQAD9sJoUk7JAayhPK7kzMhObMnXDbwt6cd0T4XShGsGg6v44ahzcMo1a/eLeUQYu5U3gIw8lw69zy9Pi/IBYbINdpYuGMfObOvJzMG5jtmmR+WJeMUPFhKPWfOEUfQkyp4o6GxTOBhrpVwm3GxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=rQXRw887; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=ZzWLo9F9RRZ6p3rOhQwF3R/YNmHPFvLGy60aTy/R4e0=; b=rQXRw887unOlqhD20dY3n74CFn
	cPllOiKm2gLr0zvdv9nh/Ln03hde+M1gDZ7LRDhQl+k7SaHEv3dmgEHq6RJPztVtdsZ5XZaVIntMe
	WBNa2LOeD5Mm+FI62EJ4LtcWsbQhELyGfgQ0H9xWkin1ZWicV5raotbicacJScBi43/Sw4qHtNojE
	SpB6GXuCtPrg/2e7S87B2butjGKOtGokCSUmnUSoWAkORbXvw2tfRW2bYggNI0u65SEtNFeZIsYSf
	sSSQWFPQdsswTfqsWCSYlP8qv2m8RA0TMfLCJVx5I6wsszGeEBuoyyqNqDGFwp2l7u25BZvj7HEGb
	04ez/0bzmVIWvAa7zCyMthB/BSXjt9WNNYB5Pxla+ho6wID3+MU5wtHOl2TXyMGYwUV7iVLfVItJp
	RHqrbhd4s94H52DhkHZFkXcAl3VQUxXBFhGR5oRXBsMwNyOPSjCCU5kLzWaWM7OMVJBn8KCwmKTg+
	BpFYd9ErcxEKf/cC96aUT0Sa;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUTqB-00CSQA-1x;
	Wed, 25 Jun 2025 17:23:19 +0000
Message-ID: <658c6f4f-468b-4233-b49a-4c39a7ab03ab@samba.org>
Date: Wed, 25 Jun 2025 19:23:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] cifs: Fix reading into an ITER_FOLIOQ from the
 smbdirect code
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve French <stfrench@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250625164213.1408754-1-dhowells@redhat.com>
 <20250625164213.1408754-13-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250625164213.1408754-13-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 25.06.25 um 18:42 schrieb David Howells:
> When performing a file read from RDMA, smbd_recv() prints an "Invalid msg
> type 4" error and fails the I/O.  This is due to the switch-statement there
> not handling the ITER_FOLIOQ handed down from netfslib.
> 
> Fix this by collapsing smbd_recv_buf() and smbd_recv_page() into
> smbd_recv() and just using copy_to_iter() instead of memcpy().  This
> future-proofs the function too, in case more ITER_* types are added.
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smbdirect.c | 114 +++++++-------------------------------
>   1 file changed, 19 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index a976bcf61226..5fa46b2e682c 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -1770,35 +1770,39 @@ struct smbd_connection *smbd_get_connection(
>   }
>   
>   /*
> - * Receive data from receive reassembly queue
> + * Receive data from the transport's receive reassembly queue
>    * All the incoming data packets are placed in reassembly queue
> - * buf: the buffer to read data into
> + * iter: the buffer to read data into
>    * size: the length of data to read
>    * return value: actual data read
> - * Note: this implementation copies the data from reassebmly queue to receive
> + *
> + * Note: this implementation copies the data from reassembly queue to receive
>    * buffers used by upper layer. This is not the optimal code path. A better way
>    * to do it is to not have upper layer allocate its receive buffers but rather
>    * borrow the buffer from reassembly queue, and return it after data is
>    * consumed. But this will require more changes to upper layer code, and also
>    * need to consider packet boundaries while they still being reassembled.
>    */
> -static int smbd_recv_buf(struct smbd_connection *info, char *buf,
> -		unsigned int size)
> +int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
>   {
>   	struct smbdirect_socket *sc = &info->socket;
>   	struct smbd_response *response;
>   	struct smbdirect_data_transfer *data_transfer;
> +	size_t size = iov_iter_count(&msg->msg_iter);
>   	int to_copy, to_read, data_read, offset;
>   	u32 data_length, remaining_data_length, data_offset;
>   	int rc;
>   
> +	if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) == WRITE))
> +		return -EINVAL; /* It's a bug in upper layer to get there */
> +
>   again:
>   	/*
>   	 * No need to hold the reassembly queue lock all the time as we are
>   	 * the only one reading from the front of the queue. The transport
>   	 * may add more entries to the back of the queue at the same time
>   	 */
> -	log_read(INFO, "size=%d info->reassembly_data_length=%d\n", size,
> +	log_read(INFO, "size=%zd info->reassembly_data_length=%d\n", size,
>   		info->reassembly_data_length);
>   	if (info->reassembly_data_length >= size) {
>   		int queue_length;
> @@ -1836,7 +1840,10 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   			if (response->first_segment && size == 4) {
>   				unsigned int rfc1002_len =
>   					data_length + remaining_data_length;
> -				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
> +				__be32 rfc1002_hdr = cpu_to_be32(rfc1002_len);
> +				if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
> +						 &msg->msg_iter) != sizeof(rfc1002_hdr))
> +					return -EFAULT;
>   				data_read = 4;
>   				response->first_segment = false;
>   				log_read(INFO, "returning rfc1002 length %d\n",
> @@ -1845,10 +1852,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   			}
>   
>   			to_copy = min_t(int, data_length - offset, to_read);
> -			memcpy(
> -				buf + data_read,
> -				(char *)data_transfer + data_offset + offset,
> -				to_copy);
> +			if (copy_to_iter((char *)data_transfer + data_offset + offset,
> +					 to_copy, &msg->msg_iter) != to_copy)
> +				return -EFAULT;
>   
>   			/* move on to the next buffer? */
>   			if (to_copy == data_length - offset) {
> @@ -1893,6 +1899,8 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   			 data_read, info->reassembly_data_length,
>   			 info->first_entry_offset);
>   read_rfc1002_done:
> +		/* SMBDirect will read it all or nothing */
> +		msg->msg_iter.count = 0;

I think we should be remove this.

And I think this patch should come after the
CONFIG_HARDENED_USERCOPY change otherwise a bisect will trigger the problem.

metze

