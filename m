Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA8671F0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjAROJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjAROJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:09:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6E654D2;
        Wed, 18 Jan 2023 05:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R+y1aRAi1Q5p2FWSqw26xsXrVejTThXr1WM2j+n/J8o=; b=N2bv0EnonXAy0DCO5ujuktAarW
        0L2uuGshYz0OASni2bYSpQiXsDySyByaCnKiiHQSg6b4zb6P0PeGdWSBomJq4vxzMV2jz/kYLDJNc
        UuK6BMnvOgwjsQWMAWPC6ek7vZT6qQQucp5X2nEjXK5HkeDBARy95I2qc/mpeQ7pYujXsKDkO+Zec
        4b0yvNJRMGoBjoDcj5UUJmBtEo+NdP+mQ9IFZYofW1IYvOTt93vW8ZmgtzuZQN9SYzpJRgKhqKFC+
        mUgh9Rg1nwlw2LJ6GKG0srUH2EfhdfgrQbK4Of+ZTDeCbrAJUcqWcpNX2k7a+PEb0F/2H0FlxQS/F
        1SCK2PCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI8p5-0001y4-US; Wed, 18 Jan 2023 13:49:51 +0000
Date:   Wed, 18 Jan 2023 13:49:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 3/9] mm: use filemap_get_entry in filemap_get_incore_folio
Message-ID: <Y8f4/41eK0KQSRpI@casper.infradead.org>
References: <20230118094329.9553-1-hch@lst.de>
 <20230118094329.9553-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118094329.9553-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:43:23AM +0100, Christoph Hellwig wrote:
> filemap_get_incore_folio wants to look at the details of xa_is_value
> entries, but doesn't need any of the other logic in filemap_get_folio.
> Switch it to use the lower-level filemap_get_entry interface.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
