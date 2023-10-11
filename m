Return-Path: <linux-fsdevel+bounces-127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6267C5E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 22:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9041C20FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320F18E29;
	Wed, 11 Oct 2023 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="RbGIrcqH";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="vfhkdV19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DB1F17F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 20:40:14 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7B90
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 13:40:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4D83E6016E;
	Wed, 11 Oct 2023 22:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697056809; bh=strMZvH1IMVii7Hfq/wYlEHSdjrFHR/u2D2qZnbztqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RbGIrcqHvV3xAQKRi8kgFBI/hiNa6j6Fq4TG9RBWbPoJSYJVEhPhXc8QSxr7Ruv5b
	 K/bSfWkjhu1l1j9wTDRFHoMmns/VEiUPqZtFV+pqs0DB5+LdNBv/z4Li/sphWc09I6
	 FSOJ8+Mp4D1snxGexB/3eWPKa4UZkJrsYt71nRdM8+y48rSIe5kCXArNvNDGzK2Yor
	 zAjSARNbh1/bys8zuA42ybQpjpu8aXix15B9Mxip/QGnrGFVYIp1ESkffe1iJEO+XC
	 UWiWnf9PMj366/WCFf1gmIxoT3Jo1PAEXFPpLc1hwpGQ5dREon+3ZMIymlxvfBELcd
	 Qlewqer11E+qg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_qepxg1GFHT; Wed, 11 Oct 2023 22:40:06 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-43.adsl.net.t-com.hr [78.1.184.43])
	by domac.alu.hr (Postfix) with ESMTPSA id 4733160155;
	Wed, 11 Oct 2023 22:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697056806; bh=strMZvH1IMVii7Hfq/wYlEHSdjrFHR/u2D2qZnbztqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vfhkdV19tS6z+powblMDPDdHtdqK5l1NECmUbBGoVhMDTQpL3HtlENvU9EZuDlp+P
	 9Mper7iOuHePLTVeoNiWbq6CrCmoR+yUgtnJTeZmXQjJ8WwUg81uU8l1XypqoXEBgT
	 BkMZV1JBobuUq0oS6VAlda/QT7wSXX/lo/hSrwTJMAiHH6rha/B0aZD16NiVQychcI
	 JzoIs1//AnLNbyUl/koIfEu4fWQaEg/qk5uUU1MqN+bOauXAnMzq7Tckbm3aw+Ldlv
	 iJRDFDSTI75PqvOOx1T4+IS2aEsY5zLwyIaBZ9x3Vgx9HwdT6EzcWNgFmeD541XMT5
	 qxh2418ffTiWw==
Message-ID: <1f0a9ce8-7fc3-41e8-b414-6ae2ad6ba74c@alu.unizg.hr>
Date: Wed, 11 Oct 2023 22:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
To: Jan Kara <jack@suse.cz>, Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231011150252.32737-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 17:02, Jan Kara wrote:
> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Some users of lib/find functions can operate on bitmaps that change
> while we are looking at the bitmap. For example xarray code looks at tag
> bitmaps only with RCU protection. The xarray users are prepared to
> handle a situation were tag modification races with reading of a tag
> bitmap (and thus we get back a stale information) but the find_*bit()
> functions should return based on bitmap contents at *some* point in time.
> As UBSAN properly warns, the code like:
> 
> 	val = *addr;
> 	if (val)
> 		__ffs(val)
> 
> prone to refetching 'val' contents from addr by the compiler and thus
> passing 0 to __ffs() which has undefined results.
> 
> Fix the problem by using READ_ONCE() in all the appropriate places so
> that the compiler cannot accidentally refetch the contents of addr
> between the test and __ffs(). This makes the undefined behavior
> impossible. The generated code is somewhat larger due to gcc tracking
> both the index and target fetch address in separate registers (according
> to GCC folks the volatile cast confuses their optimizer a bit, they are
> looking into a fix). The difference in performance is minimal though.
> Targetted microbenchmark (in userspace) of the bit searching loop shows
> about 2% regression on some x86 microarchitectures so for normal kernel
> workloads this should be in the noise and not worth introducing special
> set of bitmap searching functions.
> 
> [JK: Wrote commit message]
> 
> CC: Yury Norov <yury.norov@gmail.com>
> Link: https://lore.kernel.org/all/20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   include/linux/find.h | 40 ++++++++++++++++++++++++----------------
>   lib/find_bit.c       | 39 +++++++++++++++++++++++----------------
>   2 files changed, 47 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5e4f39ef2e72..5ef6466dc7cc 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -60,7 +60,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>   		if (unlikely(offset >= size))
>   			return size;
>   
> -		val = *addr & GENMASK(size - 1, offset);
> +		val = READ_ONCE(*addr) & GENMASK(size - 1, offset);
>   		return val ? __ffs(val) : size;
>   	}
>   
> @@ -90,7 +90,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>   		if (unlikely(offset >= size))
>   			return size;
>   
> -		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
> +		val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
> +						GENMASK(size - 1, offset);
>   		return val ? __ffs(val) : size;
>   	}
>   
> @@ -121,7 +122,8 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>   		if (unlikely(offset >= size))
>   			return size;
>   
> -		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
> +		val = READ_ONCE(*addr1) & ~READ_ONCE(*addr2) &
> +						GENMASK(size - 1, offset);
>   		return val ? __ffs(val) : size;
>   	}
>   
> @@ -151,7 +153,8 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
>   		if (unlikely(offset >= size))
>   			return size;
>   
> -		val = (*addr1 | *addr2) & GENMASK(size - 1, offset);
> +		val = (READ_ONCE(*addr1) | READ_ONCE(*addr2)) &
> +						GENMASK(size - 1, offset);
>   		return val ? __ffs(val) : size;
>   	}
>   
> @@ -179,7 +182,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>   		if (unlikely(offset >= size))
>   			return size;
>   
> -		val = *addr | ~GENMASK(size - 1, offset);
> +		val = READ_ONCE(*addr) | ~GENMASK(size - 1, offset);
>   		return val == ~0UL ? size : ffz(val);
>   	}
>   
> @@ -200,7 +203,7 @@ static inline
>   unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = *addr & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
>   
>   		return val ? __ffs(val) : size;
>   	}
> @@ -229,7 +232,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
>   		return size;
>   
>   	if (small_const_nbits(size)) {
> -		unsigned long val =  *addr & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
>   
>   		return val ? fns(val, n) : size;
>   	}
> @@ -255,7 +258,8 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
>   		return size;
>   
>   	if (small_const_nbits(size)) {
> -		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2)
> +							& GENMASK(size - 1, 0);
>   
>   		return val ? fns(val, n) : size;
>   	}
> @@ -282,7 +286,8 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
>   		return size;
>   
>   	if (small_const_nbits(size)) {
> -		unsigned long val =  *addr1 & (~*addr2) & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr1) & ~READ_ONCE(*addr2) &
> +							GENMASK(size - 1, 0);
>   
>   		return val ? fns(val, n) : size;
>   	}
> @@ -312,7 +317,8 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
>   		return size;
>   
>   	if (small_const_nbits(size)) {
> -		unsigned long val =  *addr1 & *addr2 & (~*addr3) & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
> +				~READ_ONCE(*addr3) & GENMASK(size - 1, 0);
>   
>   		return val ? fns(val, n) : size;
>   	}
> @@ -336,7 +342,8 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
>   				 unsigned long size)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
> +							GENMASK(size - 1, 0);
>   
>   		return val ? __ffs(val) : size;
>   	}
> @@ -358,7 +365,7 @@ static inline
>   unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = *addr | ~GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr) | ~GENMASK(size - 1, 0);
>   
>   		return val == ~0UL ? size : ffz(val);
>   	}
> @@ -379,7 +386,7 @@ static inline
>   unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = *addr & GENMASK(size - 1, 0);
> +		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
>   
>   		return val ? __fls(val) : size;
>   	}
> @@ -505,7 +512,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
>   		long size, unsigned long offset)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = *(const unsigned long *)addr;
> +		unsigned long val = READ_ONCE(*(const unsigned long *)addr);
>   
>   		if (unlikely(offset >= size))
>   			return size;
> @@ -523,7 +530,8 @@ static inline
>   unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = swab(*(const unsigned long *)addr) | ~GENMASK(size - 1, 0);
> +		unsigned long val = swab(READ_ONCE(*(const unsigned long *)addr))
> +						| ~GENMASK(size - 1, 0);
>   
>   		return val == ~0UL ? size : ffz(val);
>   	}
> @@ -538,7 +546,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>   		long size, unsigned long offset)
>   {
>   	if (small_const_nbits(size)) {
> -		unsigned long val = *(const unsigned long *)addr;
> +		unsigned long val = READ_ONCE(*(const unsigned long *)addr);
>   
>   		if (unlikely(offset >= size))
>   			return size;
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 32f99e9a670e..6867ef8a85e0 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -98,7 +98,7 @@ out:										\
>    */
>   unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>   {
> -	return FIND_FIRST_BIT(addr[idx], /* nop */, size);
> +	return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
>   }
>   EXPORT_SYMBOL(_find_first_bit);
>   #endif
> @@ -111,7 +111,8 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
>   				  const unsigned long *addr2,
>   				  unsigned long size)
>   {
> -	return FIND_FIRST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
> +	return FIND_FIRST_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
> +				/* nop */, size);
>   }
>   EXPORT_SYMBOL(_find_first_and_bit);
>   #endif
> @@ -122,7 +123,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
>    */
>   unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
>   {
> -	return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
> +	return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), /* nop */, size);
>   }
>   EXPORT_SYMBOL(_find_first_zero_bit);
>   #endif
> @@ -130,28 +131,30 @@ EXPORT_SYMBOL(_find_first_zero_bit);
>   #ifndef find_next_bit
>   unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
>   {
> -	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
> +	return FIND_NEXT_BIT(READ_ONCE(addr[idx]), /* nop */, nbits, start);
>   }
>   EXPORT_SYMBOL(_find_next_bit);
>   #endif
>   
>   unsigned long __find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
>   {
> -	return FIND_NTH_BIT(addr[idx], size, n);
> +	return FIND_NTH_BIT(READ_ONCE(addr[idx]), size, n);
>   }
>   EXPORT_SYMBOL(__find_nth_bit);
>   
>   unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>   				 unsigned long size, unsigned long n)
>   {
> -	return FIND_NTH_BIT(addr1[idx] & addr2[idx], size, n);
> +	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
> +			    size, n);
>   }
>   EXPORT_SYMBOL(__find_nth_and_bit);
>   
>   unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>   				 unsigned long size, unsigned long n)
>   {
> -	return FIND_NTH_BIT(addr1[idx] & ~addr2[idx], size, n);
> +	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]),
> +			    size, n);
>   }
>   EXPORT_SYMBOL(__find_nth_andnot_bit);
>   
> @@ -160,7 +163,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
>   					const unsigned long *addr3,
>   					unsigned long size, unsigned long n)
>   {
> -	return FIND_NTH_BIT(addr1[idx] & addr2[idx] & ~addr3[idx], size, n);
> +	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]) &
> +			    ~READ_ONCE(addr3[idx]), size, n);
>   }
>   EXPORT_SYMBOL(__find_nth_and_andnot_bit);
>   
> @@ -168,7 +172,8 @@ EXPORT_SYMBOL(__find_nth_and_andnot_bit);
>   unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>   					unsigned long nbits, unsigned long start)
>   {
> -	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
> +	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
> +			     /* nop */, nbits, start);
>   }
>   EXPORT_SYMBOL(_find_next_and_bit);
>   #endif
> @@ -177,7 +182,8 @@ EXPORT_SYMBOL(_find_next_and_bit);
>   unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>   					unsigned long nbits, unsigned long start)
>   {
> -	return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
> +	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]),
> +			     /* nop */, nbits, start);
>   }
>   EXPORT_SYMBOL(_find_next_andnot_bit);
>   #endif
> @@ -186,7 +192,8 @@ EXPORT_SYMBOL(_find_next_andnot_bit);
>   unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>   					unsigned long nbits, unsigned long start)
>   {
> -	return FIND_NEXT_BIT(addr1[idx] | addr2[idx], /* nop */, nbits, start);
> +	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) | READ_ONCE(addr2[idx]),
> +			     /* nop */, nbits, start);
>   }
>   EXPORT_SYMBOL(_find_next_or_bit);
>   #endif
> @@ -195,7 +202,7 @@ EXPORT_SYMBOL(_find_next_or_bit);
>   unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
>   					 unsigned long start)
>   {
> -	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
> +	return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), /* nop */, nbits, start);
>   }
>   EXPORT_SYMBOL(_find_next_zero_bit);
>   #endif
> @@ -208,7 +215,7 @@ unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
>   		unsigned long idx = (size-1) / BITS_PER_LONG;
>   
>   		do {
> -			val &= addr[idx];
> +			val &= READ_ONCE(addr[idx]);
>   			if (val)
>   				return idx * BITS_PER_LONG + __fls(val);
>   
> @@ -242,7 +249,7 @@ EXPORT_SYMBOL(find_next_clump8);
>    */
>   unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
>   {
> -	return FIND_FIRST_BIT(~addr[idx], swab, size);
> +	return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), swab, size);
>   }
>   EXPORT_SYMBOL(_find_first_zero_bit_le);
>   
> @@ -252,7 +259,7 @@ EXPORT_SYMBOL(_find_first_zero_bit_le);
>   unsigned long _find_next_zero_bit_le(const unsigned long *addr,
>   					unsigned long size, unsigned long offset)
>   {
> -	return FIND_NEXT_BIT(~addr[idx], swab, size, offset);
> +	return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), swab, size, offset);
>   }
>   EXPORT_SYMBOL(_find_next_zero_bit_le);
>   #endif
> @@ -261,7 +268,7 @@ EXPORT_SYMBOL(_find_next_zero_bit_le);
>   unsigned long _find_next_bit_le(const unsigned long *addr,
>   				unsigned long size, unsigned long offset)
>   {
> -	return FIND_NEXT_BIT(addr[idx], swab, size, offset);
> +	return FIND_NEXT_BIT(READ_ONCE(addr[idx]), swab, size, offset);
>   }
>   EXPORT_SYMBOL(_find_next_bit_le);
>   

Works like charm. Nothing in KCSAN.

Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Best regards,
Mirsad

