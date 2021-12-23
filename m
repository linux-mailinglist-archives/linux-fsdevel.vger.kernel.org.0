Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85E47DF49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbhLWHER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWHEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:04:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA25C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=QVYhdhahebn08mCRgNLgL7CuQL
        BaMYVMuIAK0PcGW12PstLs4xj9c/vpOwEZ9H0hGT73h6pr9ksXmAux30u6DB8XLZbi4edv+Lilwj4
        LXN7zKUnW9dXuAEg/2nkIixIVy6h2+XExmYPzMf/xBP3JmNDQZtZ4oa3ga+eHnuUwBbSdJi+3nU9e
        ZXnYqL/cNRZ98VvOfR3Gk7JbNQEE3shV7nCBgxjJqwOrWzXpHklEAKmrnnfLjjrBL9kG6CAXVB9WT
        VTXa11OT/zM1XLekc8GADDY/kjTYZLteQxfQoGCA0KhUcwD6vjOKUZ/qruW5eR/PuT4v8ppgoJuIl
        L4fnl0aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I98-00BxDT-47; Thu, 23 Dec 2021 07:04:14 +0000
Date:   Wed, 22 Dec 2021 23:04:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/48] filemap: Convert tracing of page cache operations
 to folio
Message-ID: <YcQfbmK72S2rzvDa@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
