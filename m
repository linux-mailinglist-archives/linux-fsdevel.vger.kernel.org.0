Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7740A2B2C8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 11:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKNKA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 05:00:57 -0500
Received: from verein.lst.de ([213.95.11.211]:49892 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgKNKA5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:00:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BE3C67373; Sat, 14 Nov 2020 11:00:54 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:00:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/16] mm: Add FGP_ENTRY
Message-ID: <20201114100053.GE19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-5-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:29PM +0000, Matthew Wilcox (Oracle) wrote:
> The functionality of find_lock_entry() and find_get_entry() can be
> provided by pagecache_get_pages(),

s/pagecache_get_pages/pagecache_get_page/

> which lets us delete find_lock_entry()
> and make find_get_entry() static.

I think this should mention that find_get_entry is now only used by
pagecache_get_page.  That answers the obvious questions of why we could
not switch all callers of find_get_entry to pagecache_get_page.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
