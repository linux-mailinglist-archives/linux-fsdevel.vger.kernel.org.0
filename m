Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63BF343B46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 09:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVIIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVII3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:08:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB05C061574;
        Mon, 22 Mar 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fLxrHeMl65fqjsOCgbNnDv0fPY2M3xyvPb+aYlr85vs=; b=Wjgyf3wgzoAOXOjs6N6IAvkLRh
        iF1L/lN3yHkjMmDsypfYuuFIzKkxxUzD/f4U/3fViTkQ+1vRTf/XbBtWKLCMH1cGGweXNfNKL7QPg
        A1eliHDe5EBT88OdKzSZdhOFHfVXtyAFUfGAXdFvKZH+SCA3W/XVZ5ca82bi3dF4DK8wPQt4Uhvv8
        QaRt7zspzryaQ2GhhSqe6c88Kzz4Uo0ejrGtqxkaKL8KxGE45hiBteOupjsDCyLFDm1Fmrz1TM0/h
        OIvvqMaTKunPDqYR3rxfZMiHiVO91fXSMkq5204VtWE891pboBVTio1eo3+5PXRbpTgMXiz8gfmOl
        jbHdwanw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFbR-008BYi-Lo; Mon, 22 Mar 2021 08:08:02 +0000
Date:   Mon, 22 Mar 2021 08:07:57 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 02/27] mm/writeback: Add
 wait_on_page_writeback_killable
Message-ID: <20210322080757.GC1946905@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <20210320054104.1300774-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320054104.1300774-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 05:40:39AM +0000, Matthew Wilcox (Oracle) wrote:
> This is the killable version of wait_on_page_writeback.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
