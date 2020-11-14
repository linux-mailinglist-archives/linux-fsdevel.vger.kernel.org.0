Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D272B2C92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 11:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKNKDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 05:03:21 -0500
Received: from verein.lst.de ([213.95.11.211]:49913 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgKNKDV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:03:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB14267373; Sat, 14 Nov 2020 11:03:18 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:03:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 06/16] mm/filemap: Add helper for finding pages
Message-ID: <20201114100318.GG19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-7-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:31PM +0000, Matthew Wilcox (Oracle) wrote:
> +	if (mark == XA_PRESENT)
> +		page = xas_find(xas, max);
> +	else
> +		page = xas_find_marked(xas, max, mark);

Is there any good reason xas_find_marked can't handle the XA_PRESENT
case as well?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
