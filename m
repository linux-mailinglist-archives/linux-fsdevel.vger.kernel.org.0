Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E932B2C82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKNJx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 04:53:56 -0500
Received: from verein.lst.de ([213.95.11.211]:49875 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgKNJx4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:53:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7BD3F68B05; Sat, 14 Nov 2020 10:53:54 +0100 (CET)
Date:   Sat, 14 Nov 2020 10:53:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/16] mm/swap: Optimise get_shadow_from_swap_cache
Message-ID: <20201114095354.GD19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-4-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:28PM +0000, Matthew Wilcox (Oracle) wrote:
> There's no need to get a reference to the page, just load the entry and
> see if it's a shadow entry.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
