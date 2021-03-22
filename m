Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAA343B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 09:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVIIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhCVIHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:07:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF3DC061574;
        Mon, 22 Mar 2021 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TbYveShLYeVqBDd6OuMK3KKplXpJFMY9UQBn/f/mXuk=; b=oUINOzWNzUdAROCRX5M78JAJO+
        HoCGe1ia4mvzSj9k8yi/ZlT/4E14wgYfKSCd7VnoLGoT3+IeEiDZvgBu7dSfnzQ/+dk8xDLcENX6t
        T62vKVi6lP7Dxtk5Y7hMV42i54rIMh6BieObBd3sq8YrAUWxADN7eE8bILypdhoQfZt10ko2R5kmP
        FKRNEfQbbbxfKutmUNBnmE8VRp3WnpG4d2p/U029bk06ERSvFupgAaZH7ekvMTRw0abD/XlT2e6WN
        VYmPuXFM5fy/UxIc03SwLmBfIoqM0/miKbVR1dK4DsvopqYGUZ4VPQRjREXIsd9EY31n3bI0MpaII
        aqQPm2Lg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFaM-008BRm-9O; Mon, 22 Mar 2021 08:06:55 +0000
Date:   Mon, 22 Mar 2021 08:06:50 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 01/27] fs/cachefiles: Remove wait_bit_key layout
 dependency
Message-ID: <20210322080650.GB1946905@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <20210320054104.1300774-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320054104.1300774-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 05:40:38AM +0000, Matthew Wilcox (Oracle) wrote:
> Cachefiles was relying on wait_page_key and wait_bit_key being the
> same layout, which is fragile.  Now that wait_page_key is exposed in
> the pagemap.h header, we can remove that fragility
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
