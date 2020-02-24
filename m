Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9098416B27F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBXVcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:32:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=emtDgV24Eo0XKJNO3XWaY50cgCvPe4AajCupipZ+mFM=; b=faavxfwYgJ6BV4aMG0yBGMTdvs
        FIHOEugMta99lUrJ1bnzTZ/FRNYp6SPEABIaJ5EtGCi+eQP8a0kjK0ZbLdgXYa/37U/swNDVC13km
        Va5rLvps0hefygpoSkbchuXiH08P6MV/rAg7EcSCaaM7QZSEw0JsM/CNamhza4du/dvIO9YVBTlnB
        RoHdf0GoNG+qOIjDajjFjogi72piGjB1CilX1d9marpYm2pZ/fzynRHB+WFG63bofIN3ZLXSOH6JY
        ttUElXB1HnhGmHknkGtgPrvb11HJuWiiU/SslxTdDxTUKWpXvJpAQegm1IrAR6sPxW+YVNdZRQbOd
        Gj+d14cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LKu-0003kl-Dd; Mon, 24 Feb 2020 21:32:20 +0000
Date:   Mon, 24 Feb 2020 13:32:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 01/24] mm: Move readahead prototypes from mm.h
Message-ID: <20200224213220.GA13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:40PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The readahead code is part of the page cache so should be found in the
> pagemap.h file.  force_page_cache_readahead is only used within mm,
> so move it to mm/internal.h instead.  Remove the parameter names where
> they add no value, and rename the ones which were actively misleading.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
