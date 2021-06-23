Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7753B174E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFWJ5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJ5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:57:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508BC061574;
        Wed, 23 Jun 2021 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=83itG8tKMAzG1kw+WXFQNT/V9kuwMEnwCst9B/Pbc28=; b=ZPzYEqelUxMrrLC8VAEESV9Dc7
        LTehLWblyY+p/I8weYPrZs+7KWuszfEX/DdVJ/zztYygTp5QvWN7vVDPbnouhR943Sol+a/WQtsoI
        zI+PqD2yx9RKXaqOnGFawD6F0fwaxIK4CsxsF/Mzb6I9mBCvCQHlg3ELnjc04WrXkoANUgeWUMx06
        +Q7pYqHf9SiUObNRK8p5pWgl7Mox7XQB504i+jS/6j+9TP8LcEQLAhdEnE4sLYf8HTXPwKh4YHcbo
        PZ5kU9PjvRHBStsbj8cbknE/UcJT9RhhsvfH5eYs8peUw18idxUAKt4DRvGQ8G7/naf7aQpp1azEA
        6aLCyO6w==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzaB-00FHnX-2w; Wed, 23 Jun 2021 09:54:27 +0000
Date:   Wed, 23 Jun 2021 11:54:06 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 38/46] mm: Add folio_evictable()
Message-ID: <YNMEviOojARovw7T@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-39-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-39-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> + * Reasons folio might not be evictable:
> + * 1. page's mapping marked unevictable
> + * 2. page is part of an mlocked VMA

s/page/folio/?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
