Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3C15A249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgBLHmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:42:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=82EodlKuCknFubPlazoaaoo08ucUaCOA9raKEHjSDBA=; b=iBbRS6G6qS2/LTufAsTYzqHMbf
        uigmhmf5+X8fLxrf6nTWqDMnwKUWfWuoVMF5+ApWeA7BDsIGxD9DmImZ2NKl2S15AxZl5yBC9mAok
        jXYSaj6QCdPMEGReGhvZ1JA2IrZegFWVbRfPM15eUYQZbFET8T4CQWzPY/HsIweDfboTTvLOmWKZH
        kgPtQrgW6Y+jLYQW6VzN0s44uHVTVK7WGSy3Q3uxL0ljYRi3HYBgLmPkg3uS3OSH4xmlOvjwxXyNl
        Xv7eU71QbxvVtss4Z/uovlUyU/ZhS8n01b5d90MeHJnttRUhQL6RAbycAd2xMU4Y0HKjp7NtXRt8Y
        vghym1tA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mf1-0008Qj-9r; Wed, 12 Feb 2020 07:42:15 +0000
Date:   Tue, 11 Feb 2020 23:42:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Message-ID: <20200212074215.GF7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:25PM -0800, Matthew Wilcox wrote:
> - * @fgp_flags: PCG flags
> + * @fgp_flags: FGP flags
>   * @gfp_mask: gfp mask to use for the page cache data page allocation
>   *
>   * Looks up the page cache slot at @mapping & @offset.
>   *
> - * PCG flags modify how the page is returned.
> + * FGP flags modify how the page is returned.

This still looks weird.  Why not just a single line:

	* @fgp_flags: FGP_* flags that control how the page is returned.
