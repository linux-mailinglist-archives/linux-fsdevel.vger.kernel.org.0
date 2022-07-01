Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A6562F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 11:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiGAJCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 05:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiGAJCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:02:02 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5C1C92E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 02:02:00 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 59D7DC020; Fri,  1 Jul 2022 11:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656666119; bh=qzRJwy51cgcRjfESdR0bMEIjDdBaPiu0nkRIy+QHq7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2/TtTxTJ4YWArrv5B6MSOKF69vTgmr3Zt1i+duxPePHm22B/iqClHCehYxLi8zcE
         5hyayiTapBgnLXrQuJaRTgdnZqR3h4/q+b4N1kuspdCQtS8tsmh03s8cbczDIXReLe
         EJbH5q0e3ieeW38at9t3eCa0oiYc0eVhlFB9pYuY7cnBZQPpKgeke1athQF/jHCIB6
         8NCxXwx4v3cQHlk915Sap5UFXpVJ7eHe7AbI/NXqYBeEMj4VFwe+I8zJ8QVCcXgKvl
         Nt+iWGzUAaCedh2U0MG9jBWn5+ToEwYZBHrRuzU3EWoPmU8ZLNdjKrDSsDsPb+EGZ7
         xVlzZfkdGDZJg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 64389C009;
        Fri,  1 Jul 2022 11:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656666118; bh=qzRJwy51cgcRjfESdR0bMEIjDdBaPiu0nkRIy+QHq7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbbWiFVkvl8QGMV1LW+Ni6ReYESmDdBPcXvf4Eq4krrdGMAxeL7vlLNcB4lG9cVH1
         lYscvtY8DKYcCnO0o+cY4GdvWVvHR/eT54Y16MS1a9B0levLy4Ypq+lIVbdHthKroO
         aa9D+PIOWTzh2D+mWna2I3RZrhedrltAIBodLLHgwJ7SQmX9w+IFUO8+G3gAnEzlgN
         D597iNv5xLSRQxwJKgNvJv7pcQeUT7pWIGyOpUZIPE0FR1hyapC0O5N506uZmbTaeG
         9iuUA+C7yJLsk9op3/MoMDrRDosUxxwXgPmnYnqNFJx6dNPZikVb9QMsCawvj8Cp1g
         ADdZNCCGiH1Tw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5e20e5f3;
        Fri, 1 Jul 2022 09:01:50 +0000 (UTC)
Date:   Fri, 1 Jul 2022 18:01:35 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 40/44] 9p: convert to advancing variant of
 iov_iter_get_pages_alloc()
Message-ID: <Yr6378ZegVTynxym@codewreck.org>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-40-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-40-viro@zeniv.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro wrote on Wed, Jun 22, 2022 at 05:15:48AM +0100:
> that one is somewhat clumsier than usual and needs serious testing.

code inspection looks good to me, we revert everywhere I think we need
to revert for read/write and readdir doesn't need any special treatment.
I had a couple of nitpicks on debug messages, but that aside you can add
my R-b:

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>


Now for tests though I'm not quite sure what I'm supposed to test to
stress the error cases, that'd actually let me detect a failure... Basic
stuff seems to work but I don't think I ever got into an error path
where that matters -- forcing short reads perhaps?

> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  net/9p/client.c       | 39 +++++++++++++++++++++++----------------
>  net/9p/protocol.c     |  3 +--
>  net/9p/trans_virtio.c |  3 ++-
>  3 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index d403085b9ef5..cb4324211561 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1491,7 +1491,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  	struct p9_client *clnt = fid->clnt;
>  	struct p9_req_t *req;
>  	int count = iov_iter_count(to);
> -	int rsize, non_zc = 0;
> +	int rsize, received, non_zc = 0;
>  	char *dataptr;
>  
>  	*err = 0;
> @@ -1520,36 +1520,40 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  	}
>  	if (IS_ERR(req)) {
>  		*err = PTR_ERR(req);
> +		if (!non_zc)
> +			iov_iter_revert(to, count - iov_iter_count(to));
>  		return 0;
>  	}
>  
>  	*err = p9pdu_readf(&req->rc, clnt->proto_version,
> -			   "D", &count, &dataptr);
> +			   "D", &received, &dataptr);
>  	if (*err) {
> +		if (!non_zc)
> +			iov_iter_revert(to, count - iov_iter_count(to));
>  		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_tag_remove(clnt, req);
>  		return 0;
>  	}
> -	if (rsize < count) {
> -		pr_err("bogus RREAD count (%d > %d)\n", count, rsize);
> -		count = rsize;
> +	if (rsize < received) {
> +		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
> +		received = rsize;
>  	}
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", count);

This probably should be updated to received; we know how much we asked
to read already what we want to see here is what the server replied.

>  
>  	if (non_zc) {
> -		int n = copy_to_iter(dataptr, count, to);
> +		int n = copy_to_iter(dataptr, received, to);
>  
> -		if (n != count) {
> +		if (n != received) {
>  			*err = -EFAULT;
>  			p9_tag_remove(clnt, req);
>  			return n;
>  		}
>  	} else {
> -		iov_iter_advance(to, count);
> +		iov_iter_revert(to, count - received - iov_iter_count(to));
>  	}
>  	p9_tag_remove(clnt, req);
> -	return count;
> +	return received;
>  }
>  EXPORT_SYMBOL(p9_client_read_once);
>  
> @@ -1567,6 +1571,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  	while (iov_iter_count(from)) {
>  		int count = iov_iter_count(from);
>  		int rsize = fid->iounit;
> +		int written;
>  
>  		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
>  			rsize = clnt->msize - P9_IOHDRSZ;
> @@ -1584,27 +1589,29 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  					    offset, rsize, from);
>  		}
>  		if (IS_ERR(req)) {
> +			iov_iter_revert(from, count - iov_iter_count(from));
>  			*err = PTR_ERR(req);
>  			break;
>  		}
>  
> -		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &count);
> +		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &written);
>  		if (*err) {
> +			iov_iter_revert(from, count - iov_iter_count(from));
>  			trace_9p_protocol_dump(clnt, &req->rc);
>  			p9_tag_remove(clnt, req);
>  			break;
>  		}
> -		if (rsize < count) {
> -			pr_err("bogus RWRITE count (%d > %d)\n", count, rsize);
> -			count = rsize;
> +		if (rsize < written) {
> +			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
> +			written = rsize;
>  		}
>  
>  		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", count);

likewise, please make it dump written.

--
Dominique
>  
>  		p9_tag_remove(clnt, req);
> -		iov_iter_advance(from, count);
> -		total += count;
> -		offset += count;
> +		iov_iter_revert(from, count - written - iov_iter_count(from));
> +		total += written;
> +		offset += written;
>  	}
>  	return total;
>  }
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 3754c33e2974..83694c631989 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -63,9 +63,8 @@ static size_t
>  pdu_write_u(struct p9_fcall *pdu, struct iov_iter *from, size_t size)
>  {
>  	size_t len = min(pdu->capacity - pdu->size, size);
> -	struct iov_iter i = *from;
>  
> -	if (!copy_from_iter_full(&pdu->sdata[pdu->size], len, &i))
> +	if (!copy_from_iter_full(&pdu->sdata[pdu->size], len, from))
>  		len = 0;
>  
>  	pdu->size += len;
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 2a210c2f8e40..1977d33475fe 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -331,7 +331,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  			if (err == -ERESTARTSYS)
>  				return err;
>  		}
> -		n = iov_iter_get_pages_alloc(data, pages, count, offs);
> +		n = iov_iter_get_pages_alloc2(data, pages, count, offs);
>  		if (n < 0)
>  			return n;
>  		*need_drop = 1;
> @@ -373,6 +373,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  				(*pages)[index] = kmap_to_page(p);
>  			p += PAGE_SIZE;
>  		}
> +		iov_iter_advance(data, len);
>  		return len;
>  	}
>  }
