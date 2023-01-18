Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83D671EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjAROJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAROIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:08:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CD4B4B1;
        Wed, 18 Jan 2023 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lxqHwE5NZsGY13fEvGCTQSPxat0iv3XloE5VpZBExhE=; b=Q7l+3/tG9aZgpyhuyHDOG41Gyt
        xfnggvWA8tPYfqME8v2Nwnqah65NzJEw1iZmr9XAvxVX+TbQ8ODPf8vyqo43H/KDVxzRtX6p13y66
        QWjampazxfnDSuY6lBq54pf3iE6+Kb6pXN3V5/3JHBpJhKpUACpWbPoJkWZnZzMl7kkt892DxqS4o
        f0GY3pMHvbd14BNCX9wXlsT7/aeudBuXrZWm1csuAccg5cyfwuegfL/8oivUso9bY8JiZT+kHRAar
        9Ajd97WhGJ3Pho6wR1Z2mgqd9rbPstL8fj9S6XU/z6Nge+RUopvzaJG10tp6wHDpcXQmzjE0tT5UM
        s410TO6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI8nA-0001sI-1w; Wed, 18 Jan 2023 13:47:52 +0000
Date:   Wed, 18 Jan 2023 13:47:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 1/9] mm: don't look at xarray value entries in
 split_huge_pages_in_file
Message-ID: <Y8f4iFGIaWz1bLWz@casper.infradead.org>
References: <20230118094329.9553-1-hch@lst.de>
 <20230118094329.9553-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118094329.9553-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:43:21AM +0100, Christoph Hellwig wrote:
> split_huge_pages_in_file never wants to do anything with the special
> value enties.  Switch to using filemap_get_folio to not even see them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
