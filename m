Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E54F392968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhE0IXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0IXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:23:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC7C061574;
        Thu, 27 May 2021 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yZ+1LVLUEgsr9wLPH37ZCAFiPck7BUBC5/HMtPosoo4=; b=J57hMdk5EMNOToZXD7NQgKDio2
        Hinv8IesTxNLoD0WZFImbvxrybhiFM88bvbQFe84ln7hLm737Ij5qT0NdbykjhRISS0D/IcZlF6NJ
        BmTD75R4DasrD7iBl8L2X9+3GlnIMqTBCKIPG3HKZNacTHIhZrbtKVaPr01qeGFwe+MlB/U9daFsQ
        PPQtWIxjymGqRzM5ob4jIv2GeIwmws+qKISdFGivdhGRO/vF/hYZQZdukYs8Llvp4CUqOhsQzhZTe
        31PYW7Yhct9sSro3XPs8eJls/Pts1Ox+rU0lMOQzuCKOclJJt2psFTfzNJRqpAN6PiRKRnpX70rmL
        iH1mF1Wg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmBGV-005KLC-Vk; Thu, 27 May 2021 08:21:21 +0000
Date:   Thu, 27 May 2021 09:21:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 31/33] mm/filemap: Add folio private_2 functions
Message-ID: <YK9We0uiY3bkfHhh@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-32-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:33PM +0100, Matthew Wilcox (Oracle) wrote:
> end_page_private_2() becomes folio_end_private_2(),
> wait_on_page_private_2() becomes folio_wait_private_2() and
> wait_on_page_private_2_killable() becomes folio_wait_private_2_killable().
> 
> Adjust the fscache equivalents to call page_folio() before calling these
> functions to avoid adding wrappers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
