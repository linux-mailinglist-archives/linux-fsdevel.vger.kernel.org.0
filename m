Return-Path: <linux-fsdevel+bounces-52959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA3AE8C03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B8A4A502B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBA2D6624;
	Wed, 25 Jun 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="OQ1+Qsaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1229CB42;
	Wed, 25 Jun 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874848; cv=none; b=MPZJJXM3a36HKXcGicwjevlcM6djLhwgAxFngxxf1OExi2jvDS82ux2jsHORWIH20FzNsyF43zvgnk6KID25lkgQR7jvqczeOG6YLMwZjxjcWK/ml9QNXm30dftCYWBBvUwguQWVhzC6GtNNMerXdA6q6UstlHMkOMqNiZgeg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874848; c=relaxed/simple;
	bh=bE/voGnQ/VKY0szR3gwEYRxnH6ixXCw4kP3jtvDKH+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG9qGAIEUL9Rk5wJu+GoJcEWuRRU1KJezNAx/vREjqhVqqSsSrz3R0UVn2m7RksrWbVWIIH4I491/mktNm2IigLWDanS4GRa8rNbuqFJ64kF9WAK7Ynj3uts7uByjCoPwCK9O8H6gn1cGaE/c5Tgtqx0O0UtdNefJbX5g9syH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=OQ1+Qsaf; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=CNyNxcy4KrbDquitkCRDoXyOFzeMKzZ0SneX0FF2MbI=; b=OQ1+QsafI2EfAjeax0eEvZVIkt
	4OL9orQZWVLh5NZJ5+LIOJJEAyATbcpxVL9lkqFqaZz/N63yyCON2vYxrEBWUgyyETP/31btM+2mx
	Qp2XmqwL4Y5ZFTB/+/QMdwyqfRuj+AaPIdRWWQgjDOtVuLyDGSunVJZzlGAaOdZRtwa5cIOb9+P/v
	thmEpSUVTaeA61+L0rpCv15iff4tvTJUwza3L39vFI7IU+WQ7Edpoa2zqD+HdXKI3nnYq6YBOB20C
	pkZtZaANnvpTwAMeHfRFzVQuyFWIBQlsxMLH9hiAv5leJB3qDnIfBQhlcstofFxJflEtJfy8DVt+P
	gu2GO7QEuxhsgI/Fr4kG3dbYjmDz352kizUpY7KFCgu9HRdJcHzF8RTjgLm3wDD9ENwtaSak7PLaz
	dcJFsytALIqjBvatutj5+wZPfeYRcfo7muIhZ0Iktxai37fPQKQEECxM3g21OXESKC5yYXltmTDmV
	0ogXySW3mm37ujJ9hpj7Qu2e;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUUWp-00CSmz-0G;
	Wed, 25 Jun 2025 18:07:23 +0000
Message-ID: <eba15803-5afa-4805-8d6c-f0ff514d3424@samba.org>
Date: Wed, 25 Jun 2025 20:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/16] cifs: Fix reading into an ITER_FOLIOQ from the
 smbdirect code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French
 <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve French <stfrench@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Matthew Wilcox <willy@infradead.org>
References: <658c6f4f-468b-4233-b49a-4c39a7ab03ab@samba.org>
 <20250625164213.1408754-1-dhowells@redhat.com>
 <20250625164213.1408754-13-dhowells@redhat.com>
 <1422741.1750874135@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <1422741.1750874135@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 25.06.25 um 19:55 schrieb David Howells:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>>>    read_rfc1002_done:
>>> +		/* SMBDirect will read it all or nothing */
>>> +		msg->msg_iter.count = 0;
>>
>> I think we should be remove this.
>>
>> And I think this patch should come after the
>> CONFIG_HARDENED_USERCOPY change otherwise a bisect will trigger the problem.
> 
> Okay, done.  I've attached the revised version here.  I've also pushed it to
> my git branch and switched patches 12 & 13 there.

reviewed-by and tested-by: Stefan Metzmacher <metze@samba.org>

> David
> ---
> cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
> 
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
>   fs/smb/client/smbdirect.c |  112 ++++++----------------------------------------
>   1 file changed, 17 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index 0a9fd6c399f6..754e94a0e07f 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -1778,35 +1778,39 @@ struct smbd_connection *smbd_get_connection(
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
> @@ -1844,7 +1848,10 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
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
> @@ -1853,10 +1860,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
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
> @@ -1921,90 +1927,6 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   	goto again;
>   }
>   
> -/*
> - * Receive a page from receive reassembly queue
> - * page: the page to read data into
> - * to_read: the length of data to read
> - * return value: actual data read
> - */
> -static int smbd_recv_page(struct smbd_connection *info,
> -		struct page *page, unsigned int page_offset,
> -		unsigned int to_read)
> -{
> -	struct smbdirect_socket *sc = &info->socket;
> -	int ret;
> -	char *to_address;
> -	void *page_address;
> -
> -	/* make sure we have the page ready for read */
> -	ret = wait_event_interruptible(
> -		info->wait_reassembly_queue,
> -		info->reassembly_data_length >= to_read ||
> -			sc->status != SMBDIRECT_SOCKET_CONNECTED);
> -	if (ret)
> -		return ret;
> -
> -	/* now we can read from reassembly queue and not sleep */
> -	page_address = kmap_atomic(page);
> -	to_address = (char *) page_address + page_offset;
> -
> -	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
> -		page, to_address, to_read);
> -
> -	ret = smbd_recv_buf(info, to_address, to_read);
> -	kunmap_atomic(page_address);
> -
> -	return ret;
> -}
> -
> -/*
> - * Receive data from transport
> - * msg: a msghdr point to the buffer, can be ITER_KVEC or ITER_BVEC
> - * return: total bytes read, or 0. SMB Direct will not do partial read.
> - */
> -int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
> -{
> -	char *buf;
> -	struct page *page;
> -	unsigned int to_read, page_offset;
> -	int rc;
> -
> -	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
> -		/* It's a bug in upper layer to get there */
> -		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
> -			 iov_iter_rw(&msg->msg_iter));
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	switch (iov_iter_type(&msg->msg_iter)) {
> -	case ITER_KVEC:
> -		buf = msg->msg_iter.kvec->iov_base;
> -		to_read = msg->msg_iter.kvec->iov_len;
> -		rc = smbd_recv_buf(info, buf, to_read);
> -		break;
> -
> -	case ITER_BVEC:
> -		page = msg->msg_iter.bvec->bv_page;
> -		page_offset = msg->msg_iter.bvec->bv_offset;
> -		to_read = msg->msg_iter.bvec->bv_len;
> -		rc = smbd_recv_page(info, page, page_offset, to_read);
> -		break;
> -
> -	default:
> -		/* It's a bug in upper layer to get there */
> -		cifs_dbg(VFS, "Invalid msg type %d\n",
> -			 iov_iter_type(&msg->msg_iter));
> -		rc = -EINVAL;
> -	}
> -
> -out:
> -	/* SMBDirect will read it all or nothing */
> -	if (rc > 0)
> -		msg->msg_iter.count = 0;
> -	return rc;
> -}
> -
>   /*
>    * Send data to transport
>    * Each rqst is transported as a SMBDirect payload
> 


