Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF4B6EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfIRVUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 17:20:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50850 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbfIRVUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:20:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ILFwLj028166;
        Wed, 18 Sep 2019 21:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SHIr7v5/VhsvE1HrP26cNJDt2q5w3JJJSs8BfYB3edo=;
 b=JatzXqCMUzo29NRn8U2IWi1EPuA2hDrG9Gg7/law6+GgLnVQ8EMEmfUdYCPnslgld0ne
 Q8AyBxam+JFB6zwGP1GegAqW00t07Kgqgeg7KgPcph7nVeNI1eBEeN4zhsRldPOKiEQp
 XCPqvhaq/OHSclgYC/OcubVuNEamJOJscvS4dYU4vYHkgobkvZv+h3jXhHpQ5d4jtllb
 9uVaIYiMgljV8kHgyyDuMa8vUv6BlohM84NbwKm8coSmQT/w2wWhtbAHNG3rbV6vpNxW
 733vDsdS5aoXzy23h0UuQURaT6ghFI2fAwc4zzo84AwZAS3SDTYaFVHD1oQMu2lDHx0l 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v3vb4g0jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 21:19:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ILGTPo032449;
        Wed, 18 Sep 2019 21:17:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v3vbqr1be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 21:17:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8ILHuBA006285;
        Wed, 18 Sep 2019 21:17:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 14:17:56 -0700
Date:   Wed, 18 Sep 2019 14:17:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/5] mm: Add file_offset_of_ helpers
Message-ID: <20190918211755.GC2229799@magnolia>
References: <20190821003039.12555-1-willy@infradead.org>
 <20190821003039.12555-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821003039.12555-3-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:30:36PM -0700, Matthew Wilcox wrote:
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

No SOB?

Looks fine to me, and I appreciate the much less confusing name.  I was
hoping for a page_offset conversion for fs/iomap/ (and not a treewide
change because yuck), but I guess that can be done if and when this
lands.

--D

> ---
>  include/linux/pagemap.h | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2728f20fbc49..84f341109710 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -436,14 +436,33 @@ static inline pgoff_t page_to_pgoff(struct page *page)
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
> +}
> +
>  static inline loff_t page_file_offset(struct page *page)
>  {
>  	return ((loff_t)page_index(page)) << PAGE_SHIFT;
> -- 
> 2.23.0.rc1
> 
