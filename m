Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0B6D080B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjC3OVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjC3OVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:21:24 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24311CC21;
        Thu, 30 Mar 2023 07:21:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t19so18546541qta.12;
        Thu, 30 Mar 2023 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680186063; x=1682778063;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNzyLbcT71SZ0Q6C/jWoJ0Cg7eh1oszsRyaIyb92T8k=;
        b=BFe15+bYWhXYvY4GorsLIlwPLJW5nVfpu9uDVTkB7uvDcSzbN8oAcwMjQPN4veK8sw
         fnk9zwpwb8ZqQCzkLIJ54iaS9GTt6ODBlG56Nj6ND12/sMHVKH2mm5bN1eWC4E0jr0rv
         jvvKarogQYQ8FHyPkqW62qjBGVkd7T0+qyGALdadbjwHes9Uh91LCp+hyqNQP8hHzetd
         K7zESzqhh4KL/qfAGuuHkhaqBKo4msp8II7jBfdQuJzmsoyCyHKGEEKpwstulRUrsOU1
         N4Pl1CyEkD+R9a1Fxnbq7F6RxfHm6ep+6URL8bOJpcVKLFlQ2p8Oh6+2ZlXSyY8hByx0
         Jf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186063; x=1682778063;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HNzyLbcT71SZ0Q6C/jWoJ0Cg7eh1oszsRyaIyb92T8k=;
        b=ovQ6Exlmmu58ivQYR3adg8n6+SaS3hTUrmLWcFcYCz3VHhGosSey7KmLinIGstStT/
         R9twUr+Lis7X+TUT9CoJUvYxa/iGUJojluYpm4HzUuLMreiaf2VClP/2fz1ii96SDZRs
         Ne/1diR5f092DLJPKxS5bfUJZeKZaANW3YCOwuDfCeYTNHDikzgtbtFsSssDgHPGg3xV
         DdMAWWKgpPAtfQtlHTTIAUotNK4KwoSBH0kNYZaC3AuIVPhuiUNGW40mUD46AEDOwiIm
         jy3MI4Bopiz46MGQ4CbO6yC3ki7I9oYgX7V/BCW4w4OMDnKIg0/Ae6oXHz2WURWHwogl
         1Pbg==
X-Gm-Message-State: AO0yUKWgG2rpqHF1/uXP9a5lA/9MjrNuDSnMiLaYHGrNQB1cibUqUpD2
        ywRwEPig2liYwmV/jJvwL/UN37TLoPM=
X-Google-Smtp-Source: AK7set/bWzjtAA65AERRinPes69F2ViUXErn9DbBsEtdGoGYHHSER9u9vaEhBqPpA48BKj/KhCrS9A==
X-Received: by 2002:ac8:58c6:0:b0:3e3:9199:d27 with SMTP id u6-20020ac858c6000000b003e391990d27mr38956546qta.53.1680186063638;
        Thu, 30 Mar 2023 07:21:03 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id e16-20020ac86710000000b003ba2a15f93dsm10300408qtp.26.2023.03.30.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:20:59 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:20:58 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <64259aca22046_21883920890@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230329141354.516864-17-dhowells@redhat.com>
References: <20230329141354.516864-1-dhowells@redhat.com>
 <20230329141354.516864-17-dhowells@redhat.com>
Subject: RE: [RFC PATCH v2 16/48] ip, udp: Support MSG_SPLICE_PAGES
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote:
> Make IP/UDP sendmsg() support MSG_SPLICE_PAGES.  This causes pages to be
> spliced from the source iterator if possible (the iterator must be
> ITER_BVEC and the pages must be spliceable).
> 
> This allows ->sendpage() to be replaced by something that can handle
> multiple multipage folios in a single transaction.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: netdev@vger.kernel.org
> ---
>  net/ipv4/ip_output.c | 85 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c

A non-RFC version would require the same for ipv6, of course.

> index 4e4e308c3230..07736da70eab 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -973,11 +973,11 @@ static int __ip_append_data(struct sock *sk,
>  	int hh_len;
>  	int exthdrlen;
>  	int mtu;
> -	int copy;
> +	ssize_t copy;
>  	int err;
>  	int offset = 0;
>  	bool zc = false;
> -	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
> +	unsigned int maxfraglen, fragheaderlen, maxnonfragsize, xlength;

Does x here stand for anything?

>  	int csummode = CHECKSUM_NONE;
>  	struct rtable *rt = (struct rtable *)cork->dst;
>  	unsigned int wmem_alloc_delta = 0;
> @@ -1017,6 +1017,7 @@ static int __ip_append_data(struct sock *sk,
>  	    (!exthdrlen || (rt->dst.dev->features & NETIF_F_HW_ESP_TX_CSUM)))
>  		csummode = CHECKSUM_PARTIAL;
>  
> +	xlength = length;
>  	if ((flags & MSG_ZEROCOPY) && length) {
>  		struct msghdr *msg = from;
>  
> @@ -1047,6 +1048,14 @@ static int __ip_append_data(struct sock *sk,
>  				skb_zcopy_set(skb, uarg, &extra_uref);
>  			}
>  		}
> +	} else if ((flags & MSG_SPLICE_PAGES) && length) {
> +		struct msghdr *msg = from;
> +
> +		if (inet->hdrincl)
> +			return -EPERM;
> +		if (!(rt->dst.dev->features & NETIF_F_SG))
> +			return -EOPNOTSUPP;
> +		xlength = transhdrlen; /* We need an empty buffer to attach stuff to */
>  	}
>  
>  	cork->length += length;
> @@ -1074,6 +1083,50 @@ static int __ip_append_data(struct sock *sk,
>  			unsigned int alloclen, alloc_extra;
>  			unsigned int pagedlen;
>  			struct sk_buff *skb_prev;
> +
> +			if (unlikely(flags & MSG_SPLICE_PAGES)) {
> +				skb_prev = skb;
> +				fraggap = skb_prev->len - maxfraglen;
> +
> +				alloclen = fragheaderlen + hh_len + fraggap + 15;
> +				skb = sock_wmalloc(sk, alloclen, 1, sk->sk_allocation);
> +				if (unlikely(!skb)) {
> +					err = -ENOBUFS;
> +					goto error;
> +				}
> +
> +				/*
> +				 *	Fill in the control structures
> +				 */
> +				skb->ip_summed = CHECKSUM_NONE;
> +				skb->csum = 0;
> +				skb_reserve(skb, hh_len);
> +
> +				/*
> +				 *	Find where to start putting bytes.
> +				 */
> +				skb_put(skb, fragheaderlen + fraggap);
> +				skb_reset_network_header(skb);
> +				skb->transport_header = (skb->network_header +
> +							 fragheaderlen);
> +				if (fraggap) {
> +					skb->csum = skb_copy_and_csum_bits(
> +						skb_prev, maxfraglen,
> +						skb_transport_header(skb),
> +						fraggap);
> +					skb_prev->csum = csum_sub(skb_prev->csum,
> +								  skb->csum);
> +					pskb_trim_unique(skb_prev, maxfraglen);
> +				}
> +
> +				/*
> +				 * Put the packet on the pending queue.
> +				 */
> +				__skb_queue_tail(&sk->sk_write_queue, skb);
> +				continue;
> +			}
> +			xlength = length;
> +
>  alloc_new_skb:
>  			skb_prev = skb;
>  			if (skb_prev)
> @@ -1085,7 +1138,7 @@ static int __ip_append_data(struct sock *sk,
>  			 * If remaining data exceeds the mtu,
>  			 * we know we need more fragment(s).
>  			 */
> -			datalen = length + fraggap;
> +			datalen = xlength + fraggap;
>  			if (datalen > mtu - fragheaderlen)
>  				datalen = maxfraglen - fragheaderlen;
>  			fraglen = datalen + fragheaderlen;
> @@ -1099,7 +1152,7 @@ static int __ip_append_data(struct sock *sk,
>  			 * because we have no idea what fragment will be
>  			 * the last.
>  			 */
> -			if (datalen == length + fraggap)
> +			if (datalen == xlength + fraggap)
>  				alloc_extra += rt->dst.trailer_len;
>  
>  			if ((flags & MSG_MORE) &&
> @@ -1206,6 +1259,30 @@ static int __ip_append_data(struct sock *sk,
>  				err = -EFAULT;
>  				goto error;
>  			}
> +		} else if (flags & MSG_SPLICE_PAGES) {
> +			struct msghdr *msg = from;
> +			struct page *page = NULL, **pages = &page;
> +			size_t off;
> +
> +			copy = iov_iter_extract_pages(&msg->msg_iter, &pages,
> +						      copy, 1, 0, &off);
> +			if (copy <= 0) {
> +				err = copy ?: -EIO;
> +				goto error;
> +			}
> +
> +			err = skb_append_pagefrags(skb, page, off, copy);
> +			if (err < 0)
> +				goto error;
> +
> +			if (skb->ip_summed == CHECKSUM_NONE) {
> +				__wsum csum;
> +				csum = csum_page(page, off, copy);
> +				skb->csum = csum_block_add(skb->csum, csum, skb->len);
> +			}
> +
> +			skb_len_add(skb, copy);
> +			refcount_add(copy, &sk->sk_wmem_alloc);
>  		} else if (!zc) {
>  			int i = skb_shinfo(skb)->nr_frags;
>  
> 

This does add a lot of code to two functions that are already
unwieldy. It may be unavoidable, but it if can use helpers, that would
be preferable.
