Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29022A911E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKFIT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:19:59 -0500
Received: from verein.lst.de ([213.95.11.211]:50587 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFIT7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:19:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEF7368B05; Fri,  6 Nov 2020 09:19:56 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:19:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 14/18] mm/filemap: Split filemap_readahead out of
 filemap_get_pages
Message-ID: <20201106081956.GH31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-15-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		if (PageReadahead(page)) {
> +			err = filemap_readahead(iocb, filp, mapping, page,
> +					last_index);
> +			if (err) {
>  				pvec->nr--;
>  				goto err;
>  			}

Not really new in this patch, but don't we need to drop the page refcount
here?
