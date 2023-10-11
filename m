Return-Path: <linux-fsdevel+bounces-128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035307C5E90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 22:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BD12826B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6ED1C28F;
	Wed, 11 Oct 2023 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="QjQHKfwU";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="bwXejLJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318215AC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 20:40:53 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9856F91
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 13:40:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id BCC9B6016E;
	Wed, 11 Oct 2023 22:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697056849; bh=tN6iM0Oo7lhrkAeTybBxO+/aVxXDVMRbO0xhvawxhWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QjQHKfwU4reVpXLCNm6SHlsCdyFIA2X6uyPaTqfTPaVbkqid2ZO5pgxiWca3SrGtv
	 8hXU/Vc8d+ZhY1WRbwOmH/44jvd8XE+zzK2FOTu9Fwjo+vSSbckP4lVj6PQV0Zp6gm
	 wndjWeU7RyFL8eirhcpJry2dKhivNe4o+Ie2Uo1cP8El5THBIiT9tMTKpS8IRMvSQz
	 5tV7CgbmSbNAysgSCem9ezJKdYcvtT1JJ546ADQ0YMNlBDFfWBYpKiPMe5HvnJORsR
	 hDIM3BXldCbYI1/miR/VAxd2IVdUig4wAbMyKfYM61JbQC33ZsDMZFoFCcB7mi0MaC
	 /LuMTVCquVOKg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUejHYWlJFP5; Wed, 11 Oct 2023 22:40:47 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-43.adsl.net.t-com.hr [78.1.184.43])
	by domac.alu.hr (Postfix) with ESMTPSA id A408A60155;
	Wed, 11 Oct 2023 22:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697056847; bh=tN6iM0Oo7lhrkAeTybBxO+/aVxXDVMRbO0xhvawxhWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bwXejLJzEQWg5tyMduAdMRk/MtWxzeugEt/hEQUP2B+EmIYDAJElSWFHSDMyoD26G
	 X+Q8nX4Y1JLBh0JGkz4ezTDxxWOr9SbuGzL064HiV4PtVu+aJu++i6r9PkILDwu/BB
	 AabDVQptGp8f0Drb6SNZ0nB2R10NU2s0wX/fzXqm5PPeiZajfVjycT+5hW5DmZFRBq
	 y6QlGfD9zey4Ty/K9OQ56c5DVeODGl6C2jt3i8vTPx570V0pYgs0W0b6Y/31n8UPbB
	 lvyRmzWI59+cgyQCElNBcilg/bf2PLAFP2gsErR3MlIA/pxTXyYKWT4Hqtu8zDh6bU
	 ce0VwTFlwvhxQ==
Message-ID: <9e45735a-eb04-45fc-b9f1-6bee9990fdee@alu.unizg.hr>
Date: Wed, 11 Oct 2023 22:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xarray: Fix race in xas_find_chunk()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-2-jack@suse.cz>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231011150252.32737-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 17:02, Jan Kara wrote:
> xas_find_chunk() can be called only under RCU protection and thus tags
> can be changing while it is working. Hence the code:
> 
> 	unsigned long data = *addr & (~0UL << offset);
> 	if (data)
> 		return __ffs(data);
> 
> is prone to 'data' being refetched from addr by the compiler and thus
> calling __ffs() with 0 argument and undefined results.
> 
> Fix the problem by removing XA_CHUNK_SIZE == BITS_PER_LONG special case
> completely. find_next_bit() gets this right and there's no performance
> difference because it is inline and has the very same special branch for
> const-sized bitmaps anyway.
> 
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> CC: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   include/linux/xarray.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index cb571dfcf4b1..07700a2c8870 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1718,15 +1718,6 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>   
>   	if (advance)
>   		offset++;
> -	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> -		if (offset < XA_CHUNK_SIZE) {
> -			unsigned long data = *addr & (~0UL << offset);
> -			if (data)
> -				return __ffs(data);
> -		}
> -		return XA_CHUNK_SIZE;
> -	}
> -
>   	return find_next_bit(addr, XA_CHUNK_SIZE, offset);
>   }
>   

Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Best regards,
Mirsad

