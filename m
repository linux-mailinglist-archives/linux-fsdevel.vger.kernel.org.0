Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C24D70A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfJOH65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 03:58:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfJOH65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DGzk9bu4iJkTZYSdysUagPW8O
        JG+5MKHlveboji4f1g4/isS0uN1s4HvXCWxoXk7HJb6sHRLqC7+ckPAskjIoavbQ85EXX9kjgoft6
        jTIMrUBWVDGYbTG5vDPSzKRGF6KvThP+7zCG7OHj9rzO20L/9mbZBsdzrvqv+7lmsv1L22wRwf/Tz
        BzpPeLTy57/+PYv0hzSeYFipGnlipajxrxOJ9+/xsI2Cz4YFKlPjdiGqZybM9ulX2bp1SuZgZCodo
        Qn6hQ0gR2PO81G/tU+DTxRVVB+1neyW0608bVey+8nCWtQMzswW+RFXy7BsCpGcxiDKkbjyWbosSd
        n0Iomx21w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHjM-0000s2-2U; Tue, 15 Oct 2019 07:58:56 +0000
Date:   Tue, 15 Oct 2019 00:58:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v3] loop: fix no-unmap write-zeroes request behavior
Message-ID: <20191015075856.GA3055@infradead.org>
References: <20191010170239.GC13098@magnolia>
 <20191014155030.GS13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014155030.GS13108@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
