Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F326A2B2C7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 10:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKNJxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 04:53:10 -0500
Received: from verein.lst.de ([213.95.11.211]:49857 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgKNJxK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:53:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 830C468AFE; Sat, 14 Nov 2020 10:53:07 +0100 (CET)
Date:   Sat, 14 Nov 2020 10:53:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 01/16] mm: Make pagecache tagged lookups return only
 head pages
Message-ID: <20201114095307.GB19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:26PM +0000, Matthew Wilcox (Oracle) wrote:
> Pagecache tags are used for dirty page writeback.  Since dirtiness is
> tracked on a per-THP basis, we only want to return the head page rather
> than each subpage of a tagged page.  All the filesystems which use huge
> pages today are in-memory, so there are no tagged huge pages today.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
