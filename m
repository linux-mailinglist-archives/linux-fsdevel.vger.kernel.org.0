Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71F747DF5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346713AbhLWHKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbhLWHKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:10:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21335C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3fIGGQl+2jFHFAVWZgURK025lQeNFdhbr0kpcd2azus=; b=LKFVLtoHGhWMdWz+HT3DqTN1pU
        UhX6wxGugj95ZU2mIFwgxS3/Q0vC6E0/xm2FC9VECruLKhT4eHtFbq8gTwVZTAOqYCkfwBpOknlGH
        D4lk5GQH89AlOpHSKBaf6MbDejC1kzXxkq22cPMr6XwSPrg1ICaWQNDaxNPYYphls7ab0xg28m8yJ
        gCdcakXhP3ydaTQo2i7oGOyrtS4oZVgNeTieyiUxOVbqvBy/CVv01RaYrZ8er4fKm6NRF8ne6hUOw
        /u54uq0K3fcHiDC5jkSACwIx90gZs4ZR9+aWQXm5s4U9BwC4TFOxoozXYL2Ns1voE1tKuyKuYQxrs
        HFrIku7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IFZ-00BxZ0-Oy; Thu, 23 Dec 2021 07:10:53 +0000
Date:   Wed, 22 Dec 2021 23:10:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 16/48] filemap: Convert filemap_get_read_batch to use
 folios
Message-ID: <YcQg/XbzNRXRYtEt@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:24AM +0000, Matthew Wilcox (Oracle) wrote:
> The page cache only stores folios, never tail pages.  Saves 29 bytes
> due to removing calls to compound_head().

Looksgood:

Reviewed-by: Christoph Hellwig <hch@lst.de>
