Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357BE2B2CAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKNKXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 05:23:14 -0500
Received: from verein.lst.de ([213.95.11.211]:50038 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNKXN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:23:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14F2068AFE; Sat, 14 Nov 2020 11:23:11 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:23:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 16/16] mm/filemap: Return only head pages from
 find_get_entries
Message-ID: <20201114102310.GP19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-17-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:41PM +0000, Matthew Wilcox (Oracle) wrote:
> All callers now expect head (and base) pages, and can handle multiple
> head pages in a single batch, so make find_get_entries() behave that way.
> Also take the opportunity to make it use the pagevec infrastructure
> instead of open-coding how pvecs behave.  This has the side-effect of
> being able to append to a pagevec with existing contents, although we
> don't make use of that functionality anywhere yet.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
