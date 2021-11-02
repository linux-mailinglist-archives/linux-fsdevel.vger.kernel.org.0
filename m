Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6238442802
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKBHRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhKBHRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:17:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C4C061714;
        Tue,  2 Nov 2021 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=17jV82GGRuV4RFnJi1BgLDyXUof1cVwi4gak/IVmvzA=; b=kqoXP5wHBvqQwo6WU64f16pps5
        TBkUfpXfDcE4UyguSGBJ7PULACrv3ywQNw0LoLB9algM2nf6lw4tR+eBMFQfvVtdicAzJXvKldvOo
        OKuogdFTnAfJqH6T+FbxBseEd37Ta8J/W1qJDzXzjUD2h/tGYXEEh1SEY8muIO2zsNpzey5GIAPfd
        pnxGbnuGgm+iaZ4Kb+lu8fcTn0pjvjqhCQTcXU07CjAaIQM+I0t3x2P88uOyDo1NZO2BffG9Cprli
        0NPVK2Z/wvzzpBQMA+2VmUAGogEY57vIbexesK1gtYrK+ybbvIP/jtztz+57i0q6flQHYXRFhQ51Z
        ZnlR8Aaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho0B-000k2V-Oa; Tue, 02 Nov 2021 07:14:35 +0000
Date:   Tue, 2 Nov 2021 00:14:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 07/21] iomap: Convert iomap_releasepage to use a folio
Message-ID: <YYDlWz8eHOzrQ29Y@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:15PM +0000, Matthew Wilcox (Oracle) wrote:
> This is an address_space operation, so its argument must remain as a
> struct page, but we can use a folio internally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
