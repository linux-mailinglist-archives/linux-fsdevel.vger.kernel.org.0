Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC72B2C80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 10:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKNJxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 04:53:36 -0500
Received: from verein.lst.de ([213.95.11.211]:49870 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgKNJxg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:53:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 206D168B02; Sat, 14 Nov 2020 10:53:34 +0100 (CET)
Date:   Sat, 14 Nov 2020 10:53:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 02/16] mm/shmem: Use pagevec_lookup in
 shmem_unlock_mapping
Message-ID: <20201114095333.GC19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:27PM +0000, Matthew Wilcox (Oracle) wrote:
> The comment shows that the reason for using find_get_entries() is now
> stale; find_get_pages() will not return 0 if it hits a consecutive run
> of swap entries, and I don't believe it has since 2011.  pagevec_lookup()
> is a simpler function to use than find_get_pages(), so use it instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
