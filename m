Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2A3B2FC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFXNKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXNKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:10:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD2C061574;
        Thu, 24 Jun 2021 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qMR3ifTEdaYF345Y+tblX3vqZF74ggO7ZhF+xbE6Ujo=; b=WaTDeTDOGvmzf3KDbKqrwUL/W0
        OyIBYqTjDjQSY5POnb9ziMW+0EsvCWpRg2MSaJK7xtZy0bDFNB51b44/6VLBmI4lpp+gjjZtEe8+w
        pFnBwkPvhujxK6CTPJJNAFAAt9InatUbi7KVCz3qXWG6ywQCIF5G7JPoR2SzDHTSeL9gI5xccjXTj
        VNw/PhuzSJAy0i9Q2w8w37RmHAe7nmUIwulTaDBl16RM5+rlnMLf80oFFfxsrglCUI5BzJ19U51hF
        aOT4JA057UxCTvGpFGMWZC1ekJGDQ/YZDbX6viiJm9bGrbe+hBJKEySJOceeBUT2rbpstM53JZJ+w
        iW1IYvCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwP59-00GbCq-W1; Thu, 24 Jun 2021 13:07:59 +0000
Date:   Thu, 24 Jun 2021 14:07:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, code@tyhicks.com,
        ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: add a ->set_page_dirty cludge
Message-ID: <YNSDoyG7VqgJbxS0@casper.infradead.org>
References: <20210624125250.536369-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624125250.536369-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 02:52:50PM +0200, Christoph Hellwig wrote:
> "fix" ecryptfs to work the same as before the recent change to the
> behavior without a ->set_page_dirty method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This is atrocious, but we can't really do better.
