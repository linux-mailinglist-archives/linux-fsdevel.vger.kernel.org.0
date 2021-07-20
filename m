Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376B3CF530
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhGTGh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhGTGhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:37:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66563C061574;
        Tue, 20 Jul 2021 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VxNbZaNjB0CRznNXnc7D3jjayjOpZialjKDkzppTwVw=; b=fmf9l6NKLWd2ZwxFIWdfpOgPlz
        LqHpwUj3kE8g7INE6Jra0qgtvgo0WuEHaHH9k2zavGKSkwXIrt/F+aYbEXQjUHci/9ELAXslFFynI
        D7Iro302HnvSYGmj5lMHdop7G2/blcsq9+jTudz59BEJyuBV9OD2T9vBAdzEr0EcRPTcnpHG0YELa
        wZL9IcrYJV9U5/S86l0JvvB3E34hElHAjvEyRDlFfXRX/Cxew6rPL4ZeaTyiV635I8FL7mQzOZMa0
        H1JOBJVmbng/8+wPZPzpdS12y+g+jQEiYe54MOuBb3y6h2qTMkZsqce3KyHnnaZNKGLjVX77VRMw8
        Y3Ls5x1g==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5k0Z-007rax-7b; Tue, 20 Jul 2021 07:17:51 +0000
Date:   Tue, 20 Jul 2021 09:17:38 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 15/17] iomap: Convert iomap_write_end_inline to take
 a folio
Message-ID: <YPZ4kt7fKPd0tej1@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:59PM +0100, Matthew Wilcox (Oracle) wrote:
> Inline data only occupies a single page, but using a folio means that
> we don't need to call compound_head() in PageUptodate().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
