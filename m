Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1882658DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 07:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKFgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKFgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:36:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635BC061573;
        Thu, 10 Sep 2020 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gQphWQCU5VjNrWDqCFqtQ550fk5he6cvU1opUnwp6c8=; b=TtW8Tw/Awwjlz9gH0OBnuKs1qy
        7ZLv4Qt3qKqoCfvga77I2/h5nvdFdHI9hpnYnu3Z9U0gdWLfS1wccy9ndxj/OGxCCy/w3dZm2/NqO
        VBRvwCWm9c4caIpKq4MW1M7BaX3GTDleILIrKUDRZ0AcDLXqQF5ylxpch3CePtqA4upeRwm5bOsLk
        KZDpL5J5/9rWDAwBp4mxpxL/QZmDvVgkeWDKlKnz9xZX3nOsZJ9I5AHk24TzOsfwvm6bR1TOM+lqP
        MOvya4XR6dE4YqtiRtFIdMEbjVNKiKFuCaoVeooODCme9uI8WHd++HAXBJSwGBh9hrkT1UoibW9nQ
        G7J6otAA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGbjv-00040M-0T; Fri, 11 Sep 2020 05:36:51 +0000
Date:   Fri, 11 Sep 2020 06:36:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 6/9] iomap: Convert read_count to read_bytes_pending
Message-ID: <20200911053650.GB15114@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:47:04AM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of counting bio segments, count the number of bytes submitted.
> This insulates us from the block layer's definition of what a 'same page'
> is, which is not necessarily clear once THPs are involved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
