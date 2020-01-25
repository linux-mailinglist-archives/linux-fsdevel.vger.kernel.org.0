Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A130C1492CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgAYBxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:53:40 -0500
Received: from sonic316-55.consmr.mail.gq1.yahoo.com ([98.137.69.31]:39079
        "EHLO sonic316-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387566AbgAYBxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579917218; bh=OSF/YZenuXTg1qFTi8ZYIQJDfr1uhEPEs+4F4QHiI5E=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=WrMXvB2lMELCodxUGngV8nvB/aC3Qj0QuK9MforNrQhadL3kIPSsWEIB6gy/0PSTEvPmxtPeSz6S6tW2UI5nAhF3A1nV+dP6CAzSyZplvjD2fWNtXR/SPZ6Wmh4Z1O/Xp13OX/CuMNeDIPgQx4GbGs7YSQvdBDdQFlkX7wgA1yNTT7Wn0Wm/2SNCZ5v0lllgSXvTgwg6GfZq+O+jDHQtri9IPSlGH8RysyeddHffWgTzqgb9aAzwnyUohDyioZady8RNtcOSuWtB8SdR2miFyO2Ox1CSkYfugRAWZw1mDBU8Bv2XUwfG6fM2pmy4tkAdvd63W3Kf9r9LbL6AF+7Dkw==
X-YMail-OSG: aYXMQNEVM1nDz4Kv4vEmGo7L7ozmjTrkNHVTBZW_gfGXEql0FXsFaMFi5CaIP41
 m1kh5xSBDb6DXU8Y4i5bCcSR2lFOedaWIfmluPpACNF9SgG2HrkAE1Qy0iYNJrDgEkUSswOGCdJD
 8K4ZM4D5Ajt2DGSBNHKBqPExeREMRzGjD.7mMMnTElrRZZ9sJonC1HNaZpjt3x9WUsYBQn4oWW6y
 fIo3JRWaSgUkFb_qwzj9rWFefpDjsmi3FDAPKlJwKDTkRCaHS_b9tiX5ymqIzzg82TfD62MLFOBu
 IdjTbO2WaqyO6FQT1SFOEJMYE.j4crxixcd7V5HW.Q5pAQP3nk3IFLF1r3PRxyTEujldVZ2Qt4lI
 vLn07740c_VWDPRbO20Wf45pTV_I.W68.VFxTJ8SlzJmgrWBQ6JpJ6HmLDVH9dgydFfdV0AcJAnf
 C2uVKNEShiKRdS7eBA2D1idCPtXfqD4iytiPefw8RFaXqlSDMGqiXco6tQzcCJgHpGyXdG9e8PL3
 RyCfQGEGv1YllzYc7BF2NBAmjqoEaFeLBiqDXVVC_DoTJS9TNNcrWrYqY1Pj8yCOhUM5brRl52rV
 lI7Lix6dujIgp8qYsH1l.S2oRxXBDY7VcImL7rK6D4V.bRHDxkSGU5m3Rh8qg4x3A9YQGWct1bmz
 aTS.Y5SPMItW1EjDwWRa6_Kefo9KaQYRm2unFqVBElJUcX0jgAtJQYSEja4enP7Nb6Y1k2rtY69k
 BI0gD_NbYHdQsx5EDrwanL9m1FsuAf9HR5rtB6ZRjlzmfVGQFnzUfwcKEkVD1Y8YOhjLgejxEcLw
 0Nsn4ixBV8MFrKa7ca7WH5wQdhZuxOD3v9BnivN5BsQa5ToFeLae4uQYTIM4zvyF9myduUJyZCok
 CraPU7KpsxaazsEe7yGRvkr.ljTublOLnM.n.DyLexYEeQXKcYfTIbJR62TJRSQzacCDodTpKtwu
 Vgjtp3wa9vvRaHm5LNvqGkUMkscdh3MH8pO6WKt47cLkG8ftsJ7HAtlJANLdCVNcMUhdLL5tj6i3
 XXY0NAHSxOZXTZvmbjPHGTM_71QoOexBXQ0rKWwxF7ahZcameQs7JERbifss6ZVmnfVj7wjTSY7q
 feSBdX4TD7SK_3NNJEfKKvllMG1dXIYTVMrKlQOlaGo.B7T467aMxrqZUfxP_kiEw.HLCGjFFS9B
 LXJD0tohnZroYTSPfo.D2LD3b5JItc_znVc895b49t65MHZHF.o_25bKNHz1ADr6tN4SCm1vPzVD
 ruHq84YD5QHjm8AP1Pu47pH3ELNwnXsqL91w.awNy7r8XKIF0tkQi2_h.a88el32VVZlnlDVE3x0
 KR5EYZBMRzGcNaabuqaAyuWSR1_pjPEv4w5HSb.DYJ7SPFtb6aHZDjsWYK5sw4gHf22NytsyoaBO
 64e4eHg_76BOYlABM.otWHAZM39kqrml1kGugqT_LxHsbkkI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 25 Jan 2020 01:53:38 +0000
Received: by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d56121dea07e775f13fa3ee1b8543b78;
          Sat, 25 Jan 2020 01:53:34 +0000 (UTC)
Date:   Sat, 25 Jan 2020 09:53:29 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200125015323.GA9918@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-8-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Fri, Jan 24, 2020 at 05:35:48PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in erofs.  Fix what I believe to be
> a refcounting bug in the error case.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-erofs@lists.ozlabs.org
> ---
>  fs/erofs/data.c              | 34 ++++++++++++++--------------------
>  fs/erofs/zdata.c             |  2 +-
>  include/trace/events/erofs.h |  6 +++---
>  3 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fc3a8d8064f8..335c1ab05312 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -280,42 +280,36 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
>  	return 0;
>  }
>  
> -static int erofs_raw_access_readpages(struct file *filp,
> +static unsigned erofs_raw_access_readahead(struct file *file,
>  				      struct address_space *mapping,
> -				      struct list_head *pages,
> +				      pgoff_t start,
>  				      unsigned int nr_pages)
>  {
>  	erofs_off_t last_block;
>  	struct bio *bio = NULL;
> -	gfp_t gfp = readahead_gfp_mask(mapping);
> -	struct page *page = list_last_entry(pages, struct page, lru);
>  
> -	trace_erofs_readpages(mapping->host, page, nr_pages, true);
> +	trace_erofs_readpages(mapping->host, start, nr_pages, true);
>  
>  	for (; nr_pages; --nr_pages) {
> -		page = list_entry(pages->prev, struct page, lru);
> +		struct page *page = readahead_page(mapping, start++);
>  
>  		prefetchw(&page->flags);
> -		list_del(&page->lru);
>  
> -		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
> -			bio = erofs_read_raw_page(bio, mapping, page,
> -						  &last_block, nr_pages, true);
> +		bio = erofs_read_raw_page(bio, mapping, page, &last_block,
> +				nr_pages, true);
>  
> -			/* all the page errors are ignored when readahead */
> -			if (IS_ERR(bio)) {
> -				pr_err("%s, readahead error at page %lu of nid %llu\n",
> -				       __func__, page->index,
> -				       EROFS_I(mapping->host)->nid);
> +		/* all the page errors are ignored when readahead */
> +		if (IS_ERR(bio)) {
> +			pr_err("%s, readahead error at page %lu of nid %llu\n",
> +			       __func__, page->index,
> +			       EROFS_I(mapping->host)->nid);
>  
> -				bio = NULL;
> -			}
> +			bio = NULL;
> +			put_page(page);

Out of curiously, some little question... Why we need put_page(page) twice
if erofs_read_raw_page returns with error...

One put_page(page) is used as a temporary reference count for this request,
we could put_page(page) in advance since pages are still locked before endio.

Another put_page(page) is used for page cache xarray. I think in this case
the page has been successfully inserted to the page cache anyway, after erroring
out it will trigger .readpage again... so probably we need to keep this
refcount count for page cache xarray?

If I'm missing something, kindly correct me if I'm wrong....

Thanks,
Gao Xiang

>  		}
>  
> -		/* pages could still be locked */
>  		put_page(page);
>  	}
> -	DBG_BUGON(!list_empty(pages));
>  
>  	/* the rare case (end in gaps) */
>  	if (bio)
> @@ -358,7 +352,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  /* for uncompressed (aligned) files and raw access for other files */
>  const struct address_space_operations erofs_raw_access_aops = {
>  	.readpage = erofs_raw_access_readpage,
> -	.readpages = erofs_raw_access_readpages,
> +	.readahead = erofs_raw_access_readahead,
>  	.bmap = erofs_bmap,
>  };
>  
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index ca99425a4536..d3dd8cf1fc01 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1340,7 +1340,7 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
>  	struct page *head = NULL;
>  	LIST_HEAD(pagepool);
>  
> -	trace_erofs_readpages(mapping->host, lru_to_page(pages),
> +	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
>  			      nr_pages, false);
>  
>  	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index 27f5caa6299a..bf9806fd1306 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -113,10 +113,10 @@ TRACE_EVENT(erofs_readpage,
>  
>  TRACE_EVENT(erofs_readpages,
>  
> -	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage,
> +	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
>  		bool raw),
>  
> -	TP_ARGS(inode, page, nrpage, raw),
> +	TP_ARGS(inode, start, nrpage, raw),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t,		dev	)
> @@ -129,7 +129,7 @@ TRACE_EVENT(erofs_readpages,
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->nid	= EROFS_I(inode)->nid;
> -		__entry->start	= page->index;
> +		__entry->start	= start;
>  		__entry->nrpage	= nrpage;
>  		__entry->raw	= raw;
>  	),
> -- 
> 2.24.1
> 
