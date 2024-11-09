Return-Path: <linux-fsdevel+bounces-34109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38D9C289F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E6A28530D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2C10E0;
	Sat,  9 Nov 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VyW2hDRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04A8C07
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111052; cv=none; b=kDnxnvysQTZ2+3RNaObfV1k9IHiVq5Y25MQAxXu4BlG+Y+9YiOOqgJb+7n3VGU1BoXXHA8Mqa3V1qH+B2t4nAPnSFZT2LRf6H5CWv9giRZa7DSy0VwUVoX93A3vFpl3icUkcV0ZlHc3K2B2ZYAQ2kgnB7M7TMf60sGbsZDTEGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111052; c=relaxed/simple;
	bh=ny5ei5J21TXlLEnJ4R0Ck98BRqZedUJT1LxRtCU3HOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cExzQHy6WtxgjYe5UwsRxJg1zIUVSw4Hb2B6YRc+/9ZagHBCKdyNvNQHzguf98MF+/VbI3HKtfnttwU1C73xP03hfiDu5qiU6+2ZH/ma1+xwG5mV3Ddv/qYd+PVL9/VYeVjFIzqwsR9tEmKuzLl5kZh1hIUfNTiStIB9g/oCmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VyW2hDRo; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 16:10:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731111047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrQanqbPpQyKiIMyYJ0PtHNqBGe5LNGGRxlqicnu90=;
	b=VyW2hDRoQWMyhLtHniXOzXOWKZTxK6Fg4mEmdzjaN7cUz1KEiTNuu86tUqFTP+mMfjRUSG
	1qstZaW0MJndz3oD1RS1lWcAVjKBqESgObMU+r6IaS3/NcW+1l+MxAwQ4E6B2r+e7WeGar
	qXLgDRoXRZnLMp6GvvD4dJdlRDN5rHA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v4 1/6] mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
Message-ID: <lbwgnktuip4jf5yqqgkgopddibulf5we6clmitt5mg3vff53zq@feyj77bk7pdt>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107235614.3637221-2-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 07, 2024 at 03:56:09PM -0800, Joanne Koong wrote:
> Add a new mapping flag AS_WRITEBACK_MAY_BLOCK which filesystems may set
> to indicate that writeback operations may block or take an indeterminate
> amount of time to complete. Extra caution should be taken when waiting
> on writeback for folios belonging to mappings where this flag is set.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/pagemap.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 68a5f1ff3301..eb5a7837e142 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>  				   folio contents */
>  	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
> +	AS_WRITEBACK_MAY_BLOCK = 9, /* Use caution when waiting on writeback */

To me 'may block' does not feel right. For example in reclaim code,
folio_wait_writeback() can get blocked and that is fine. However with
non-privileged fuse involved, there are security concerns. Somehow 'may
block' does not convey that. Anyways, I am not really pushing back but
I think there is a need for better name here.

>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
>  	return test_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
>  
> +static inline void mapping_set_writeback_may_block(struct address_space *mapping)
> +{
> +	set_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> +}
> +
> +static inline bool mapping_writeback_may_block(struct address_space *mapping)
> +{
> +	return test_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>  	return mapping->gfp_mask;
> -- 
> 2.43.5
> 

