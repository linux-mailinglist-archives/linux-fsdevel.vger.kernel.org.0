Return-Path: <linux-fsdevel+bounces-3046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 773187EF7C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BBB20AFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330543AC7;
	Fri, 17 Nov 2023 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UbrgR3ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01114D7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 11:22:06 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c8c8f731aaso4668427b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700248926; x=1700853726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/xi7u3Y7qNG9P3BNy4D4RvC184shC/z1SCGNCrHqZ4=;
        b=UbrgR3apl8PHCh55SLTtXSoDPp1A1m3dhuvHeAPnVEiFwoyYjNBUforcAbdxojO+00
         70zGmYA9/UtrAZTCV6xJED4iVbGQpE1fygm/YAHuY48fdDXl7I/tEQQmEW3prd3ZyT8H
         rehDypJO4v5qaPnAqNCI1iiawcCwX/9vgSk1/7g8bRQ1P+aNvkolzkFvtjlJ4s0ktZsK
         N/lhRz1NSnLOIY/YcEbqDBIEIaOR1HPY2lO7bYO97s632iKnlqP/4JatgUwyw2IxvevL
         mdOhdOd85KGK6QK65WQQZ6h12U2Rp0izwGFAd5z9knvJFm2R5gncycOoDI1Z2ngZwR/f
         edtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700248926; x=1700853726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/xi7u3Y7qNG9P3BNy4D4RvC184shC/z1SCGNCrHqZ4=;
        b=i53EUH2qdpFMYKZiuFsTdykcoTZDGDNwMcXYgnfIF7DJwdziBXFGGwuj+ZpIxWDxQO
         C5lWPKKseli80wDi+nTU21Ih+EjtfQw4UjgvxdFi8XHz0ue9q6yeNloEUxDzGfuE0v4O
         pjkpO3MBW51R4HGIGqvBm+iWaWZNhAnICtWI9ba+VQ6OeGXlSVMq+S1PxYQY4Unaya3/
         sSN2k5t5JuITKoQhTlk4/YlkaNN/YKL6T5WQuPwt23lS45uxQaqk57VyquIv/1v5aUZB
         Ae9rD59ZS9tIXexP1ZNad3si2nLe4lyzCHp/hhvDE/FyhafLnVMyrBz0zLPCDyWzI/Bi
         vCBQ==
X-Gm-Message-State: AOJu0YyzawdiXC971TVb8SioR8upmh9ZU/c5cGBrXWgndYtFZ5TmBCkm
	Dbzozmm+wmzlbisaxLSCGqUiWQ==
X-Google-Smtp-Source: AGHT+IFEvlArX22vzpf6YsXfJP8LoJErdLQbn1ROjFSSzzDvJLvdMIX9wYS6bgDIaMuAO/FySma8mQ==
X-Received: by 2002:a81:a24c:0:b0:58e:a9d3:bf98 with SMTP id z12-20020a81a24c000000b0058ea9d3bf98mr587765ywg.27.1700248925882;
        Fri, 17 Nov 2023 11:22:05 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a124-20020a818a82000000b00598d67585d7sm640711ywg.117.2023.11.17.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:22:05 -0800 (PST)
Date: Fri, 17 Nov 2023 14:22:04 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: Return void from folio_start_writeback() and
 related functions
Message-ID: <20231117192204.GB1513185@perftesting>
References: <20231108204605.745109-1-willy@infradead.org>
 <20231108204605.745109-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108204605.745109-5-willy@infradead.org>

On Wed, Nov 08, 2023 at 08:46:05PM +0000, Matthew Wilcox (Oracle) wrote:
> Nobody now checks the return value from any of these functions, so
> add an assertion at the beginning of the function and return void.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/page-flags.h |  4 +--
>  mm/folio-compat.c          |  4 +--
>  mm/page-writeback.c        | 54 ++++++++++++++++++--------------------
>  3 files changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a440062e9386..735cddc13d20 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -772,8 +772,8 @@ static __always_inline void SetPageUptodate(struct page *page)
>  
>  CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
>  
> -bool __folio_start_writeback(struct folio *folio, bool keep_write);
> -bool set_page_writeback(struct page *page);
> +void __folio_start_writeback(struct folio *folio, bool keep_write);
> +void set_page_writeback(struct page *page);
>  
>  #define folio_start_writeback(folio)			\
>  	__folio_start_writeback(folio, false)
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 10c3247542cb..aee3b9a16828 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -46,9 +46,9 @@ void mark_page_accessed(struct page *page)
>  }
>  EXPORT_SYMBOL(mark_page_accessed);
>  
> -bool set_page_writeback(struct page *page)
> +void set_page_writeback(struct page *page)
>  {
> -	return folio_start_writeback(page_folio(page));
> +	folio_start_writeback(page_folio(page));
>  }
>  EXPORT_SYMBOL(set_page_writeback);
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 46f2f5d3d183..118f02b51c8d 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2982,67 +2982,63 @@ bool __folio_end_writeback(struct folio *folio)
>  	return ret;
>  }
>  
> -bool __folio_start_writeback(struct folio *folio, bool keep_write)
> +void __folio_start_writeback(struct folio *folio, bool keep_write)
>  {
>  	long nr = folio_nr_pages(folio);
>  	struct address_space *mapping = folio_mapping(folio);
> -	bool ret;
>  	int access_ret;
>  
> +	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> +

At first I was writing a response asking why it was ok to expect that
folio_test_set_writeback would always return true, but then I noticed this bit.
And then I went looking around and it appears that we expect the folio to be
locked when we call this function, so this is indeed safe.  But I'm stupid and
had to go read a bunch of code to make sure this was actually safe.  Could you
add a comment to that effect, or add a

VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

here as well to make it clear what we expect?  Otherwise the series looks good
to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

