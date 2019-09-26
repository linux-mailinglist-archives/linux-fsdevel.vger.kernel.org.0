Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E509FBF493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfIZOCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 10:02:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45431 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfIZOCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:02:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33so2118089edh.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqMZowksWDEmK1Fr1I/qjh+3Z9WA+7ouwIOIARruFCo=;
        b=pGcjRe0CqEgRPI2GwJCc8ude/A8nS4wWSYKUibc51HceIeslgsZiabkoPgLplPtHJm
         GaMZ/xDBVWd7tfnuNdqCz27Da9mzZAcGnRsNVPEQEQNorBp2qk3W1TduAH+8Vdlw7iVs
         oOdf+pH+iYoUgVS1bueqJMeUZx2Q/3PZ0XSGx0I87FlVutpkSKbtd3XdGiCevUeP5Fsa
         icDiWoBt5TaJqGrWIHqKCvrldW73H93QwPr+BKFyN3tXXrQvxXxZ9aLPw3WHaHs47xUG
         lTNC3JCtpjjO4JCQKpua6uhx4ckq+sSEdM7iFj7hoOcR3ArceZx5Bp1wBlMHDiKvXeIK
         BU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqMZowksWDEmK1Fr1I/qjh+3Z9WA+7ouwIOIARruFCo=;
        b=K3ERdReatnMaIw4n6j1YndbZhXDeyMYs6cL3HI8iyy9jczV8va9RCTxZOI49/9/krT
         eEWSf8kC7rICQVxgISvBIvLXC9MF1JNZ9NdwEtO+xwiJSNdTrRQaNGcczTMHKNszOEvn
         wDtTvOoJ+an460RSh+mNmiNvU5+1S0l6kYhH2qyjgJKFr+380z5LEZaAcpYtIFVvA6MA
         wN+QM9LlymlcEUpegaGnhSpFPEeqNXpV2ZfhLvsZJnu1hD+wt6hLN15NXcLBXSkgxnlQ
         PAmLTmiE415T629ej4feG0nk3JrydIiyltSHp3PtuXudm1jZm28fRZqHCC9x+jUfa/dn
         wTwQ==
X-Gm-Message-State: APjAAAXoEjhTTdypcxq0cr9xdIDchqrru5nhyalGA/pxgM9gzyJvA/sO
        dpKZ/LmPXMBOBi7Dle/vroefVw==
X-Google-Smtp-Source: APXvYqxn1DAthLI1mxQooX7Y1Hqazoc6Inpuq0kb1jILQIzkrHHBgKYpH3qDtqldGu+gk9Qi+FqGIQ==
X-Received: by 2002:a17:906:1e57:: with SMTP id i23mr3272680ejj.204.1569506529181;
        Thu, 26 Sep 2019 07:02:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j10sm499205ede.59.2019.09.26.07.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:02:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 71CC1101CFB; Thu, 26 Sep 2019 17:02:11 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:02:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] mm: Add file_offset_of_ helpers
Message-ID: <20190926140211.rm4b6yn2i5rlyvop@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-4-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:02PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The page_offset function is badly named for people reading the functions
> which call it.  The natural meaning of a function with this name would
> be 'offset within a page', not 'page offset in bytes within a file'.
> Dave Chinner suggests file_offset_of_page() as a replacement function
> name and I'm also adding file_offset_of_next_page() as a helper for the
> large page work.  Also add kernel-doc for these functions so they show
> up in the kernel API book.
> 
> page_offset() is retained as a compatibility define for now.

This should be trivial for coccinelle, right?

> ---
>  drivers/net/ethernet/ibm/ibmveth.c |  2 --
>  include/linux/pagemap.h            | 25 ++++++++++++++++++++++---
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index c5be4ebd8437..bf98aeaf9a45 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -978,8 +978,6 @@ static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	return -EOPNOTSUPP;
>  }
>  
> -#define page_offset(v) ((unsigned long)(v) & ((1 << 12) - 1))
> -
>  static int ibmveth_send(struct ibmveth_adapter *adapter,
>  			union ibmveth_buf_desc *descs, unsigned long mss)
>  {
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 750770a2c685..103205494ea0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -428,14 +428,33 @@ static inline pgoff_t page_to_pgoff(struct page *page)
>  	return page_to_index(page);
>  }
>  
> -/*
> - * Return byte-offset into filesystem object for page.
> +/**
> + * file_offset_of_page - File offset of this page.
> + * @page: Page cache page.
> + *
> + * Context: Any context.
> + * Return: The offset of the first byte of this page.
>   */
> -static inline loff_t page_offset(struct page *page)
> +static inline loff_t file_offset_of_page(struct page *page)
>  {
>  	return ((loff_t)page->index) << PAGE_SHIFT;
>  }
>  
> +/* Legacy; please convert callers */
> +#define page_offset(page)	file_offset_of_page(page)
> +
> +/**
> + * file_offset_of_next_page - File offset of the next page.
> + * @page: Page cache page.
> + *
> + * Context: Any context.
> + * Return: The offset of the first byte after this page.
> + */
> +static inline loff_t file_offset_of_next_page(struct page *page)
> +{
> +	return ((loff_t)page->index + compound_nr(page)) << PAGE_SHIFT;

Wouldn't it be more readable as

	return file_offset_of_page(page) + page_size(page);

?

> +}
> +
>  static inline loff_t page_file_offset(struct page *page)
>  {
>  	return ((loff_t)page_index(page)) << PAGE_SHIFT;
> -- 
> 2.23.0
> 
> 

-- 
 Kirill A. Shutemov
